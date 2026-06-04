/* ============================================
   IPTV Panel - App JS (Responsive Enhanced)
   ============================================ */

// ---- Modal ----
function toggleModal(id) {
    const el = document.getElementById(id);
    if (!el) return;
    const isOpening = !el.classList.contains('open');
    el.classList.toggle('open');
    // Prevent body scroll when modal open
    document.body.style.overflow = isOpening ? 'hidden' : '';
}

// Close modal on overlay click
document.addEventListener('click', function(e) {
    if (e.target.classList.contains('modal-overlay')) {
        e.target.classList.remove('open');
        document.body.style.overflow = '';
    }
});

// Close modal on ESC
document.addEventListener('keydown', function(e) {
    if (e.key === 'Escape') {
        document.querySelectorAll('.modal-overlay.open').forEach(m => {
            m.classList.remove('open');
            document.body.style.overflow = '';
        });
    }
});

// ---- Sidebar Toggle ----
(function() {
    const toggle = document.querySelector('.sidebar-toggle');
    const overlay = document.querySelector('.sidebar-overlay');

    function closeSidebar() {
        document.body.classList.remove('sidebar-open');
    }

    if (toggle) {
        toggle.addEventListener('click', function(e) {
            e.stopPropagation();
            document.body.classList.toggle('sidebar-open');
        });
    }
    if (overlay) {
        overlay.addEventListener('click', closeSidebar);
    }

    // Close sidebar when nav item clicked on mobile
    document.querySelectorAll('.nav-item').forEach(function(item) {
        item.addEventListener('click', function() {
            if (window.innerWidth <= 768) closeSidebar();
        });
    });
})();

// ---- Copy to Clipboard ----
function copyText(text) {
    if (navigator.clipboard && navigator.clipboard.writeText) {
        navigator.clipboard.writeText(text).then(function() {
            showToast('Disalin ke clipboard!');
        }).catch(function() {
            fallbackCopy(text);
        });
    } else {
        fallbackCopy(text);
    }
}

function fallbackCopy(text) {
    const ta = document.createElement('textarea');
    ta.value = text;
    ta.style.cssText = 'position:fixed;top:-9999px;left:-9999px;opacity:0';
    document.body.appendChild(ta);
    ta.select();
    try {
        document.execCommand('copy');
        showToast('Disalin ke clipboard!');
    } catch (e) {
        showToast('Gagal menyalin', 'error');
    }
    document.body.removeChild(ta);
}

// ---- Toast Notification ----
function showToast(msg, type) {
    type = type || 'success';
    // Remove existing toasts
    document.querySelectorAll('.iptv-toast').forEach(function(t) { t.remove(); });

    const el = document.createElement('div');
    el.className = 'iptv-toast';
    el.textContent = msg;
    const bg = type === 'success' ? '#22c55e' : '#ef4444';
    el.style.cssText = [
        'position:fixed',
        'bottom:24px',
        'right:24px',
        'left:auto',
        'max-width:calc(100vw - 48px)',
        'background:' + bg,
        'color:#fff',
        'padding:10px 18px',
        'border-radius:8px',
        'font-size:.86rem',
        'font-weight:600',
        'z-index:9999',
        'box-shadow:0 4px 16px rgba(0,0,0,.4)',
        'animation:toastIn .25s ease',
        'pointer-events:none'
    ].join(';');

    // Inject keyframe if needed
    if (!document.getElementById('iptv-toast-style')) {
        const s = document.createElement('style');
        s.id = 'iptv-toast-style';
        s.textContent = '@keyframes toastIn{from{opacity:0;transform:translateY(12px)}to{opacity:1;transform:translateY(0)}}';
        document.head.appendChild(s);
    }

    document.body.appendChild(el);
    setTimeout(function() {
        el.style.transition = 'opacity .4s';
        el.style.opacity = '0';
        setTimeout(function() { el.remove(); }, 400);
    }, 2200);
}

// ---- Auto-dismiss alerts ----
setTimeout(function() {
    document.querySelectorAll('.alert').forEach(function(el) {
        el.style.transition = 'opacity .5s, max-height .5s, padding .5s, margin .5s';
        el.style.opacity = '0';
        el.style.maxHeight = '0';
        el.style.overflow = 'hidden';
        el.style.padding = '0';
        el.style.marginBottom = '0';
        setTimeout(function() { el.remove(); }, 500);
    });
}, 4500);

// ---- Wrap all card-body.p0 tables in .table-wrapper ----
document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('.card-body.p0').forEach(function(cb) {
        const tables = cb.querySelectorAll(':scope > table.table');
        tables.forEach(function(t) {
            if (!t.parentNode.classList.contains('table-wrapper')) {
                const wrapper = document.createElement('div');
                wrapper.className = 'table-wrapper';
                t.parentNode.insertBefore(wrapper, t);
                wrapper.appendChild(t);
            }
        });
    });
});
