import "./App.css";
import { Navbar, Footer } from "./components";
import {
  Home,

} from "./pages";
import { Routes, Route } from "react-router-dom";
import AppProvider from "./providers/AppProvider";

function App() {
  return (
    <div>
      <AppProvider>
        <Navbar />
        <Routes>
          <Route path="/" element={<Home />} />
        </Routes>
        <Footer />
      </AppProvider>
    </div>
  );
}

export default App;
