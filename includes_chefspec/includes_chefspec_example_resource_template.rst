.. The contents of this file are included in multiple topics.
.. This file should not be changed in a way that hinders its ability to appear in multiple documentation sets.


**Recipe**

.. code-block:: ruby

   template '/tmp/default_action'
   
   template '/tmp/explicit_action' do
     action :create
   end
   
   template '/tmp/with_attributes' do
     user 'user'
     group 'group'
     backup false
   end
   
   template 'specifying the identity attribute' do
     path '/tmp/identity_attribute'
   end

**Unit Test**

.. code-block:: ruby

   require 'chefspec'

   describe 'template::create' do
     let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }
   
     it 'creates a template with the default action' do
       expect(chef_run).to create_template('/tmp/default_action')
       expect(chef_run).to_not create_template('/tmp/not_default_action')
     end
   
     it 'creates a template with an explicit action' do
       expect(chef_run).to create_template('/tmp/explicit_action')
     end
   
     it 'creates a template with attributes' do
       expect(chef_run).to create_template('/tmp/with_attributes').with(
         user: 'user',
         group: 'group',
         backup: false,
       )
   
       expect(chef_run).to_not create_template('/tmp/with_attributes').with(
         user: 'bacon',
         group: 'fat',
         backup: true,
       )
     end
   
     it 'creates a template when specifying the identity attribute' do
       expect(chef_run).to create_template('/tmp/identity_attribute')
     end
   end
