const close = () => {
    const toDelete = document.querySelector('.flash'),
          wrapper = document.getElementById('wrapper');

    wrapper.removeChild(toDelete);
};