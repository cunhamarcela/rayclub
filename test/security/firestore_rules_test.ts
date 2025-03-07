import * as firebase from '@firebase/rules-unit-testing';
import * as fs from 'fs';

/**
 * Testes para as regras de segurança do Firestore
 * 
 * Para executar:
 * 1. Iniciar o emulador: firebase emulators:start
 * 2. Executar os testes: npm test
 */

const PROJECT_ID = 'rayclub-test';
const RULES_PATH = 'firestore.rules';

// Helpers para criar contextos de autenticação
function getAuthedFirestore(auth: any) {
  return firebase.initializeTestApp({ projectId: PROJECT_ID, auth }).firestore();
}

function getAdminFirestore() {
  return firebase.initializeAdminApp({ projectId: PROJECT_ID }).firestore();
}

describe('Firestore Security Rules', () => {
  beforeAll(async () => {
    // Carregar as regras
    const rules = fs.readFileSync(RULES_PATH, 'utf8');
    await firebase.loadFirestoreRules({ projectId: PROJECT_ID, rules });
  });

  afterAll(async () => {
    // Limpar apps de teste
    await Promise.all(firebase.apps().map(app => app.delete()));
  });

  beforeEach(async () => {
    // Limpar o banco de dados entre os testes
    await firebase.clearFirestoreData({ projectId: PROJECT_ID });
  });

  // Testes para regras de usuários
  describe('Users Collection', () => {
    it('should allow users to read their own data', async () => {
      const userId = 'user1';
      const db = getAuthedFirestore({ uid: userId });
      const adminDb = getAdminFirestore();
      
      // Criar dados de teste
      await adminDb.collection('users').doc(userId).set({ name: 'Test User', email: 'test@example.com' });
      
      // Verificar se o usuário pode ler seus próprios dados
      await firebase.assertSucceeds(db.collection('users').doc(userId).get());
    });

    it('should not allow users to read other users data', async () => {
      const userId = 'user1';
      const otherUserId = 'user2';
      const db = getAuthedFirestore({ uid: userId });
      const adminDb = getAdminFirestore();
      
      // Criar dados de teste
      await adminDb.collection('users').doc(otherUserId).set({ name: 'Other User', email: 'other@example.com' });
      
      // Verificar se o usuário não pode ler dados de outros usuários
      await firebase.assertFails(db.collection('users').doc(otherUserId).get());
    });
  });

  // Testes para regras de atividades
  describe('Activities Collection', () => {
    it('should allow users to create their own activities', async () => {
      const userId = 'user1';
      const db = getAuthedFirestore({ uid: userId });
      
      // Verificar se o usuário pode criar sua própria atividade
      await firebase.assertSucceeds(db.collection('activities').add({
        userId,
        type: 'exercise',
        points: 10,
        createdAt: new Date().toISOString()
      }));
    });

    it('should not allow users to create activities for other users', async () => {
      const userId = 'user1';
      const otherUserId = 'user2';
      const db = getAuthedFirestore({ uid: userId });
      
      // Verificar se o usuário não pode criar atividades para outros usuários
      await firebase.assertFails(db.collection('activities').add({
        userId: otherUserId,
        type: 'exercise',
        points: 10,
        createdAt: new Date().toISOString()
      }));
    });
  });

  // Testes para regras de conteúdo premium
  describe('Premium Content Collection', () => {
    it('should allow premium users to access premium content', async () => {
      const userId = 'premium-user';
      const contentId = 'premium-content-1';
      const db = getAuthedFirestore({ uid: userId });
      const adminDb = getAdminFirestore();
      
      // Criar usuário premium
      await adminDb.collection('users').doc(userId).set({ 
        name: 'Premium User', 
        email: 'premium@example.com',
        isPremium: true
      });
      
      // Criar conteúdo premium
      await adminDb.collection('premium_content').doc(contentId).set({
        title: 'Premium Workout',
        type: 'workout',
        isActive: true
      });
      
      // Verificar se o usuário premium pode acessar o conteúdo
      await firebase.assertSucceeds(db.collection('premium_content').doc(contentId).get());
    });

    it('should not allow non-premium users to access premium content details', async () => {
      const userId = 'regular-user';
      const contentId = 'premium-content-1';
      const db = getAuthedFirestore({ uid: userId });
      const adminDb = getAdminFirestore();
      
      // Criar usuário regular
      await adminDb.collection('users').doc(userId).set({ 
        name: 'Regular User', 
        email: 'regular@example.com',
        isPremium: false
      });
      
      // Criar conteúdo premium
      await adminDb.collection('premium_content').doc(contentId).set({
        title: 'Premium Workout',
        type: 'workout',
        isActive: true
      });
      
      // Verificar se o usuário não-premium não pode acessar detalhes do conteúdo
      await firebase.assertFails(db.collection('premium_content').doc(contentId).get());
    });
  });
}); 