document.addEventListener('DOMContentLoaded', () => {
    const projetNonDetail = document.querySelectorAll('.projetND');
    const projetDetaille = document.querySelectorAll('.projetDetaille');

    projetNonDetail.forEach(leProjet => {
        leProjet.addEventListener('click', () => {
            projetNonDetail.forEach(lesProjets => {
                lesProjets.classList.remove('voir');
            });
            /*À MODIFIER -> doit désélectioner résumé quand 2eme click*/
            
            // if (boite.classList.contains('voir')){
            //     boite.classList.remove('voir');
            // }
            // else{
            //     boite.classList.add('voir');
            // }

            leProjet.classList.add('voir');

            // Identifie tous les div avec projet-"celui cliqué"
            let nomProjet = null;
            leProjet.classList.forEach(classe => {
                if (classe.startsWith('projet-')) {
                    nomProjet = classe;
                }
            });

            // Gérer visibilité des projetDetaille
            projetDetaille.forEach(proj => {
                // Vérifier si le projet Detaillé est le même projet que celui cliqué
                if (nomProjet && proj.classList.contains(nomProjet) && proj.classList.contains('cache')) {
                    // Si oui le monter
                    proj.classList.remove('cache');
                } else {
                    // Sinon le cacher
                    proj.classList.add('cache');
                }
            });
        });
    });
});
