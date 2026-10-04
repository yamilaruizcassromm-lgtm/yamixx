// Arreglo para almacenar los productos añadidos
let cart = [];

// Función para abrir/cerrar la barra lateral del carrito
function toggleCart() {
    const sidebar = document.getElementById('cart-sidebar');
    sidebar.classList.toggle('active');
}

// Función para añadir productos al carrito
function addToCart(name, price) {
    const existingProduct = cart.find(item => item.name === name);

    if (existingProduct) {
        existingProduct.quantity += 1;
    } else {
        cart.push({ name, price, quantity: 1 });
    }

    updateCartUI();
}

// Función para actualizar la vista del carrito
function updateCartUI() {
    const cartItemsContainer = document.getElementById('cart-items');
    const cartCount = document.getElementById('cart-count');
    const cartTotal = document.getElementById('cart-total');

    // Limpiar vista previa
    cartItemsContainer.innerHTML = '';

    let total = 0;
    let totalCount = 0;

    if (cart.length === 0) {
        cartItemsContainer.innerHTML = '<p class="empty-msg">Tu carrito está vacío.</p>';
    } else {
        cart.forEach((item, index) => {
            total += item.price * item.quantity;
            totalCount += item.quantity;

            const cartItemHTML = `
                <div class="cart-item">
                    <div>
                        <strong>${item.name}</strong><br>
                        <small>$${item.price.toFixed(2)} x ${item.quantity}</small>
                    </div>
                    <div>
                        <span>$${(item.price * item.quantity).toFixed(2)}</span>
                        <button onclick="removeFromCart(${index})" style="background:none; border:none; color:red; cursor:pointer; margin-left:5px;">&times;</button>
                    </div>
                </div>
            `;
            cartItemsContainer.innerHTML += cartItemHTML;
        });
    }

    cartCount.innerText = totalCount;
    cartTotal.innerText = total.toFixed(2);
}

// Función para eliminar elementos del carrito
function removeFromCart(index) {
    cart.splice(index, 1);
    updateCartUI();
}

// Simulación de finalizar compra
function checkout() {
    if (cart.length === 0) {
        alert('El carrito está vacío');
        return;
    }
    alert('¡Gracias por tu pedido en Yamicomid! Tu comida va en camino.');
    cart = [];
    updateCartUI();
    toggleCart();
}