import 'package:get/get.dart';
import 'package:locoo/logic/interfaces/IModel.dart';
import 'package:locoo/logic/resources/Resource.dart';
import 'package:locoo/logic/resources/ResourceContext.dart';

class RepositoryObject<T extends IModel> extends GetxService {
  RepositoryObject(this.resourceContext);

  ResourceContext resourceContext;
  Resource<T>? _resource;
  
  Resource<T> get resource {
    _resource ??= resourceContext.getResource<T>();
    return _resource!;
  }

  Resource<R> loadResource<R extends IModel>() {
    return resourceContext.getResource<R>();
  }
}