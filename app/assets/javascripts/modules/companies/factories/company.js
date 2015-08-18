'use strict';

angular.module('CompaniesApp')
  .factory('Company',
    ['$resource',
    function($resource) {

      var _basePath = '/api/companies/';

      return $resource(_basePath + ':id', { id: '@id' }, {
        update: {
          method: 'PUT',
          transformRequest: function(data){
            return Object.toFormData({company: data});
          }, 
          headers: {
            'Content-Type': undefined
          }
        },
        query: {
          method: 'GET',
          isArray: false
        },
        default: {
          method: 'GET',
          isArray: false,
          url: _basePath + 'default'
        },
        update_default: {
          method: 'PUT',
          isArray: false,
          url: _basePath + ':id' + '/update_default'
        },
        save: { 
          method: 'POST', 
          transformRequest: function(data){
            return Object.toFormData({company: data});
          }, 
          headers: {
            'Content-Type': undefined
          }
        }
      });

    }
  ]);
