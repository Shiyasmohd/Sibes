// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyAoMYmV47chgYBT3tg1Yig37PJdaHXA4pw",
  authDomain: "foodie-3f1f9.firebaseapp.com",
  projectId: "foodie-3f1f9",
  storageBucket: "foodie-3f1f9.appspot.com",
  messagingSenderId: "552347428018",
  appId: "1:552347428018:web:bf19aec77152cb468b95ab",
  measurementId: "G-N24VHMSNJ9"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);