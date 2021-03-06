.. The contents of this file are included in multiple topics.
.. This file should not be changed in a way that hinders its ability to appear in multiple documentation sets.


The default action in a custom resource is, by default, the first action listed in the custom resource. For example, action ``aaaaa`` is the default resource:

.. code-block:: ruby

   property :name, RubyType, default: 'value'

   ...
   
   action :aaaaa do
    # the first action listed in the custom resource
   end
   
   action :bbbbb do
    # the second action listed in the custom resource
   end

The ``default_action`` method may also be used to specify the default action. For example:

.. code-block:: ruby

   property :name, RubyType, default: 'value'

   default_action: aaaaa

   action :aaaaa do
    # the first action listed in the custom resource
   end

   action :bbbbb do
    # the second action listed in the custom resource
   end

defines action ``aaaaa`` as the default action. If ``default_action: bbbbb`` is specified, then action ``bbbbb`` is the default action. Use this method for clarity in custom resources, if deliberately stating the default resource is desired, or to specify a default action that is not listed first in the custom resource.
