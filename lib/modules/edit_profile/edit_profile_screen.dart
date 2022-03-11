import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/app_cubit/cubit.dart';
import 'package:social/layout/app_cubit/states.dart';
import 'package:social/shared/styles/icon_broken.dart';


class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController() ;

  @override
  Widget build(BuildContext context) {
    return 
      
    BlocConsumer<SocialCubit,SocialStates>(
                    listener: (context,state){

                    } ,
                    
                    builder: (context,state){

            var userModel = SocialCubit.get(context).userModel;
            var cubit = SocialCubit.get(context) ;

            nameController.text = userModel!.name! ;
           bioController.text = userModel.bio! ;
           phoneController.text = userModel.phone! ;
                     
                      return Scaffold(
                 appBar: AppBar(
                   titleSpacing: 0.0 ,
                  iconTheme:  IconThemeData(color: Colors.black) ,
                   title: Text('Edit Profile', style: TextStyle(color:  Colors.black ) , ) ,
                   backgroundColor: Colors.white ,
                   elevation: 0.0,
                   actions: [
                     Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: TextButton(
                  onPressed: () {
                   
                    cubit.updateUser(
                      name: nameController.text,
                        bio:  bioController.text ,
                        phone: phoneController.text ,

                    ) ;
                  },
                  child: Text('UpDate'),
                ),
              ),

               
            ],
                 ) ,
                 body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                    if ( state is SocialUserUpdateLoadingState ) 
                    Padding(
                      padding: const EdgeInsets.symmetric( vertical: 7.0  ),
                      child: LinearProgressIndicator(),
                    ) ,

                  Container(
                    height: 190,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                            
                          
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: cubit.changeCoverImage(cubit.coverImage) ,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(4.0),
                                    topLeft: Radius.circular(4.0),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  cubit.getCoverImage() ;
                                },
                                icon: CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Colors.blue.shade800,
                                  child: Icon(
                                    IconBroken.Camera,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 65,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: cubit.changeProfileImage(cubit.profileImage) ,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                SocialCubit.get(context).getProfileImage();
                              },
                              icon: CircleAvatar(
                                radius: 16,
                                backgroundColor: Colors.blue.shade800,
                                child: Icon(
                                  IconBroken.Camera,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 7,) ,


                    Row(
                    children: [
                    if ( cubit.profileImage != null )

                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: MaterialButton(
                                    onPressed: () {
                                     cubit.uploadProfileImage(
                                         name: nameController.text,
                                         bio: bioController.text ,
                                         phone: phoneController.text
                                     ) ;
                                    },
                                    child: Text('UPLOAD PROFILE IMAGE' ,
                                    style: TextStyle( fontSize: 12.0 , color: Colors.white   ) ,
                                    ),
                                    color: Colors.blue,
                                  ),
                                ),
                                if ( state is SocialUserUpdate2LoadingState   )
                                SizedBox(height: 5.0,) ,
                                if ( state is SocialUserUpdate2LoadingState   )
                                LinearProgressIndicator() ,
                              ],
                            ),
                          ),

                      SizedBox(width: 5,) ,
                      if ( cubit.coverImage != null )

                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity ,
                              child: MaterialButton(
                                onPressed: () {
                                cubit.uploadCoverImage(
                                    name: nameController.text,
                                    bio: bioController.text ,
                                    phone: phoneController.text
                                );
                                },
                                child: Text('UPLOAD COVER IMAGE' ,
                                  style: TextStyle( fontSize: 12.0 , color: Colors.white  ) ,
                                ),
                                color: Colors.blue,
                              ),
                            ),
                            if ( state is SocialUserUpdate2LoadingState   )
                            SizedBox(height: 5.0,) ,
                      if ( state is SocialUserUpdate2LoadingState   )
                            LinearProgressIndicator() ,
                          ],
                        ),
                      ),
                    ],
                  ),
                  if ( cubit.profileImage != null || cubit.coverImage != null )
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      label: Text('Name'),
                      hintText: 'write your name ...',
                      prefixIcon: Icon(IconBroken.User),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return 'the name must not be empty';

                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    controller: bioController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      label: Text('Bio'),
                      hintText: 'write your bio ...',
                      prefixIcon: Icon(IconBroken.Info_Circle),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return 'the bio must not be empty';

                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),

                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      label: Text('phone'),
                      hintText: 'write here',
                      prefixIcon: Icon(IconBroken.Call),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return 'the phone must not be empty';

                      return null;
                    },
                  ),

                ],
              ),
            ),
          ),
               );
                    } ,
      
    
     );
}
}