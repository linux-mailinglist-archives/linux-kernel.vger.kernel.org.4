Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91FE6F1B75
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 17:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346226AbjD1PZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 11:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346299AbjD1PZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 11:25:36 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6FE1FFF;
        Fri, 28 Apr 2023 08:25:07 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4edc7cc6f46so12439e87.1;
        Fri, 28 Apr 2023 08:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682695506; x=1685287506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJ4S0yrZieDrlsxPTVki5EisB1X127RCAgG78J6L5Ko=;
        b=q5uCQL8iLjMikgV7mvlOUCwbaeGfKyFG2oi79gRYyPqlz0lP8eTWSL19LynUgUFdPW
         ffq3VOvy5gnq55pVZLPOkOP90l7cvDmaEta0tKbRswvuo93+Fhfor+sz1l4V4IM1SyOp
         TAazwgvyOmkkfKgFKeD/PzLJve0wjPNzcKTp1xV3HwDyw7YclFMj4xaNuYFHlt7dZcJ7
         4sRx15CPL4XzN/PFtKYAWaeyiyjLlp89UzcRjwSF5M2ZIDeKjKi1FOfb0Brxua4BIv7y
         sLhMg798TlbwvnmHfPgjO1lYIcZyhaunJ4dJWlJ6NN2RXm5Bf+thF5BfU3Qm7HE4oMJR
         2Ywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682695506; x=1685287506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJ4S0yrZieDrlsxPTVki5EisB1X127RCAgG78J6L5Ko=;
        b=TpUg6WwEAHKclMZJVLbvmtooNlw3VYa/4OdAv/fQsX7W+VJgNjIFluPTQw65y3ZhuK
         CYzyJ+Gw91x0E5Y4TK0VXJtG8d1viOc3z6SDAR4ZXQcaSohg3+ZZtPnNtqNKEnVsMSZY
         IlH0WPbHKbnn0j0PuCv66jh4Y4cm/QqZcSrQ+Riq6HVemdOKTKu80TARQ8WsGTO8coF1
         e7jMCdZY+YUH7EHTDzyqOsgMncs36F9ZVE2n40AMwI7U939NJHFnPT35/n2BW5dIRhEm
         JCIePj0417/oaobOQ27MUisKxuu1BkwFPq3IP8eKZVLNBC2rkDWDGY0C1cUlCJNMno+X
         P+xw==
X-Gm-Message-State: AC+VfDx/9uom/Haa9ignrE4EItJt8G8V0ZVGl45yyo3PfnDhSUY3LeEo
        cMX6RG6Hzjq8y21gS8kgOpbDeMsV83LnaCOkCPsTAkV2eWw=
X-Google-Smtp-Source: ACHHUZ72yOJQH94iLHKA2BSMmPHMJi0OuaSxg1cVko59b+3Rk0Ai3rFEsgf0fpIZZaPC8j1IygLm5pEGZm9XngWwqZ8=
X-Received: by 2002:ac2:4c83:0:b0:4ec:89d4:b586 with SMTP id
 d3-20020ac24c83000000b004ec89d4b586mr1831050lfl.27.1682695505955; Fri, 28 Apr
 2023 08:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230420165454.9517-1-jorge.lopez2@hp.com> <20230420165454.9517-9-jorge.lopez2@hp.com>
 <ca74121b-bb78-4093-8625-13359c324c28@t-8ch.de>
In-Reply-To: <ca74121b-bb78-4093-8625-13359c324c28@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Fri, 28 Apr 2023 10:24:40 -0500
Message-ID: <CAOOmCE_MpCBFOHd6QtzD5ufcwEz_FhJvqevj68pVeY_JS+V=Rg@mail.gmail.com>
Subject: Re: [PATCH v11 08/14] HP BIOSCFG driver - bioscfg-h
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 23, 2023 at 7:01=E2=80=AFAM Thomas Wei=C3=9Fschuh <thomas@t-8ch=
.de> wrote:
>
> On 2023-04-20 11:54:48-0500, Jorge Lopez wrote:
> > ---
> >  drivers/platform/x86/hp/hp-bioscfg/bioscfg.h | 613 +++++++++++++++++++
> >  1 file changed, 613 insertions(+)
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h

<snip>
> > +enum hp_wmi_spm_commandtype {
> > +     HPWMI_SECUREPLATFORM_GET_STATE  =3D 0x10,
> > +     HPWMI_SECUREPLATFORM_SET_KEK    =3D 0x11,
> > +     HPWMI_SECUREPLATFORM_SET_SK     =3D 0x12
> > +};
> > +
> > +enum hp_wmi_surestart_commandtype {
> > +     HPWMI_SURESTART_GET_LOG_COUNT   =3D 0x01,
> > +     HPWMI_SURESTART_GET_LOG         =3D 0x02
> > +};
> > +
> > +enum hp_wmi_command {
> > +     HPWMI_READ              =3D 0x01,
> > +     HPWMI_WRITE             =3D 0x02,
> > +     HPWMI_ODM               =3D 0x03,
> > +     HPWMI_SURESTART         =3D 0x20006,
> > +     HPWMI_GM                =3D 0x20008,
> > +     HPWMI_SECUREPLATFORM    =3D 0x20010
> > +};
> > +
> > +struct bios_return {
> > +     u32 sigpass;
> > +     u32 return_code;
> > +};
> > +
> > +enum hp_return_value {
> > +     HPWMI_RET_WRONG_SIGNATURE       =3D 0x02,
> > +     HPWMI_RET_UNKNOWN_COMMAND       =3D 0x03,
> > +     HPWMI_RET_UNKNOWN_CMDTYPE       =3D 0x04,
> > +     HPWMI_RET_INVALID_PARAMETERS    =3D 0x05
> > +};
>
> This seems to be same as wmi_error_values below.

Done!  Deleted enum hp_return_value
>
> > +
> > +enum wmi_error_values {
> > +     SUCCESS                         =3D 0x00,
> > +     CMD_FAILED                      =3D 0x01,
> > +     INVALID_SIGN                    =3D 0x02,
> > +     INVALID_CMD_VALUE               =3D 0x03,
> > +     INVALID_CMD_TYPE                =3D 0x04,
> > +     INVALID_DATA_SIZE               =3D 0x05,
> > +     INVALID_CMD_PARAM               =3D 0x06,
> > +     ENCRYP_CMD_REQUIRED             =3D 0x07,
> > +     NO_SECURE_SESSION               =3D 0x08,
> > +     SECURE_SESSION_FOUND            =3D 0x09,
> > +     SECURE_SESSION_FAILED           =3D 0x0A,
> > +     AUTH_FAILED                     =3D 0x0B,
> > +     INVALID_BIOS_AUTH               =3D 0x0E,
> > +     NONCE_DID_NOT_MATCH             =3D 0x18,
> > +     GENERIC_ERROR                   =3D 0x1C,
> > +     BIOS_ADMIN_POLICY_NOT_MET       =3D 0x28,
> > +     BIOS_ADMIN_NOT_SET              =3D 0x38,
> > +     P21_NO_PROVISIONED              =3D 0x1000,
> > +     P21_PROVISION_IN_PROGRESS       =3D 0x1001,
> > +     P21_IN_USE                      =3D 0x1002,
> > +     HEP_NOT_ACTIVE                  =3D 0x1004,
> > +     HEP_ALREADY_SET                 =3D 0x1006,
> > +     HEP_CHECK_STATE                 =3D 0x1007
> > +};
> > +
> > +enum spm_features {
> > +     HEP_ENABLED                     =3D 0x01,
> > +     PLATFORM_RECOVERY               =3D 0x02,
> > +     ENHANCED_BIOS_AUTH_MODE         =3D 0x04
>
> Trailing commas please everywhere.

Done!  Added all missing trailing commas across the file.
>
> > +};
> > +
> > +#define MAX_KEK_BLOB_SIZE            4160
> > +#define MAX_SK_BLOB_SIZE             516
>
> These are unused.

Done!  deleted
>
> > +
> > +enum spm_states_values {
> > +     NOT_PROVISIONED                 =3D 0x00,
> > +     PROVISIONED                     =3D 0x01,
> > +     PROVISIONING_IN_PROGRESS        =3D 0x02
> > +};
> > +
> > +
> > +
> > +/*
> > + * struct bios_args buffer is dynamically allocated.  New WMI command =
types
> > + * were introduced that exceed 128-byte data size.  Changes to handle
> > + * the data size allocation scheme were kept in hp_wmi_perform_qurey f=
unction.
> > + */
> > +struct bios_args {
> > +     u32 signature;
> > +     u32 command;
> > +     u32 commandtype;
> > +     u32 datasize;
> > +     u8 data[];
> > +};
> > +
> > +struct secureplatform_provisioning_data {
> > +     u8 state;
> > +     u8 version[2];
> > +     u8 reserved1;
> > +     u32 features;
> > +     u32 nonce;
> > +     u8 reserved2[28];
> > +     u8 sk_mod[MAX_KEY_MOD];
> > +     u8 kek_mod[MAX_KEY_MOD];
> > +};
>
> bios_args and secureplatform_provisioning_data are only used from a
> single .c file. There is no need to define them in the shared header.
>

Done!  bios_args and secureplatform_provisioning_dataStructures move
to .c file where they are used.

> > +
> > +struct common_data {
> > +     u8 display_name[MAX_BUFF];
> > +     u8 path[MAX_BUFF];
> > +     u32 is_readonly;
> > +     u32 display_in_ui;
> > +     u32 requires_physical_presence;
> > +     u32 sequence;
> > +     u32 prerequisites_size;
> > +     u8 prerequisites[MAX_PREREQUISITES_SIZE][MAX_BUFF];
> > +     u32 security_level;
> > +     u8 display_name_language_code[MAX_BUFF];
> > +};
> > +
> > +
> > +struct string_data {
> > +     struct kobject *attr_name_kobj;
> > +     u8 current_value[MAX_BUFF];
> > +     u8 new_value[MAX_BUFF];
> > +     u32 min_length;
> > +     u32 max_length;
> > +     struct common_data common;
>
> It would be nicer to read if the common_data was at the start of the
> struct.

Agree.  Done!

<snip>

> > +/* global structure used by multiple WMI interfaces */
> > +extern struct bioscfg_priv bioscfg_drv;
> > +
> > +enum hp_wmi_data_type {
> > +     HPWMI_STRING_TYPE               =3D 0x00,
> > +     HPWMI_INTEGER_TYPE              =3D 0x01,
> > +     HPWMI_ENUMERATION_TYPE          =3D 0x02,
> > +     HPWMI_ORDERED_LIST_TYPE         =3D 0x03,
> > +     HPWMI_PASSWORD_TYPE             =3D 0x04,
> > +     HPWMI_SECURE_PLATFORM_TYPE      =3D 0x05,
> > +     HPWMI_SURE_START_TYPE           =3D 0x06
> > +};
>
> Unused.

Both hp_wmi_data_type and hp_wmi_data_elements are used
for instance  HP_WMI_STRING_TYPE

bioscfg.c:338: case HPWMI_STRING_TYPE:
bioscfg.c:626: case HPWMI_STRING_TYPE:
bioscfg.c:722: case HPWMI_STRING_TYPE:
bioscfg.c:798: case HPWMI_STRING_TYPE:
bioscfg.c:906: ret =3D hp_init_bios_attributes(HPWMI_STRING_TYPE,
HP_WMI_BIOS_STRING_GUID);
bioscfg.h:247: HPWMI_STRING_TYPE
>
> > +
> > +enum hp_wmi_data_elements {
> > +
> > +     /* Common elements */
> > +     NAME =3D 0,
> > +     VALUE =3D 1,
> > +     PATH =3D 2,
> > +     IS_READONLY =3D 3,
> > +     DISPLAY_IN_UI =3D 4,
> > +     REQUIRES_PHYSICAL_PRESENCE =3D 5,
> > +     SEQUENCE =3D 6,
> > +     PREREQUISITES_SIZE =3D 7,
> > +     PREREQUISITES =3D 8,
> > +     SECURITY_LEVEL =3D 9,
> > +
> > +     /* String elements */
> > +     STR_MIN_LENGTH =3D 10,
> > +     STR_MAX_LENGTH =3D 11,
> > +
> > +     /* Integer elements */
> > +     INT_LOWER_BOUND =3D 10,
> > +     INT_UPPER_BOUND =3D 11,
> > +     INT_SCALAR_INCREMENT =3D 12,
> > +
> > +     /* Enumeration elements */
> > +     ENUM_CURRENT_VALUE =3D 10,
> > +     ENUM_SIZE =3D 11,
> > +     ENUM_POSSIBLE_VALUES =3D 12,
> > +
> > +     /* Ordered list elements */
> > +     ORD_LIST_SIZE =3D 10,
> > +     ORD_LIST_ELEMENTS =3D 11,
> > +
> > +     /* Password elements */
> > +     PSWD_MIN_LENGTH =3D 10,
> > +     PSWD_MAX_LENGTH =3D 11,
> > +     PSWD_SIZE =3D 12,
> > +     PSWD_ENCODINGS =3D 13,
> > +     PSWD_IS_SET =3D 14
> > +};
> > +
> > +
> > +enum hp_wmi_elements_count {
> > +     STRING_ELEM_CNT         =3D 12,
> > +     INTEGER_ELEM_CNT        =3D 13,
> > +     ENUM_ELEM_CNT           =3D 13,
> > +     ORDERED_ELEM_CNT        =3D 12,
> > +     PASSWORD_ELEM_CNT       =3D 15
> > +};
>
> To make it clearer where these values come from you could put them into
> the enum hp_wmi_data_elements.
>
> ...
>         ORD_LIST_ELEMENTS =3D 11,
>         ORD_LIST_ELEM_CNT =3D 12,
> ...

Done!  changes provided across all files affected.

>
> But replacing the loop logic would remove the need for these enums
> completely.
>

_CNT values are necessary when elements are read from a buffer (
populate_string_elements_from_buffer).
_CNT values are not needed when elements are read from a package
(populate_string_package_data)

> > +
> > +#define GET_INSTANCE_ID(type)                                         =
       \
> > +     static int get_##type##_instance_id(struct kobject *kobj)       \
> > +     {                                                               \
> > +             int i;                                                  \
> > +                                                                     \
> > +             for (i =3D 0; i <=3D bioscfg_drv.type##_instances_count; =
i++) { \
> > +                     if (!(strcmp(kobj->name, bioscfg_drv.type##_data[=
i].attr_name_kobj->name))) \
>
> No need for braces after "!".

Done!
>
> > +                             return i;                               \
> > +             }                                                       \
> > +             return -EIO;                                            \
> > +     }
> > +
> > +#define ATTRIBUTE_S_PROPERTY_SHOW(name, type)                         =
       \
> > +     static ssize_t name##_show(struct kobject *kobj, struct kobj_attr=
ibute *attr, \
> > +                                char *buf)                           \
> > +     {                                                               \
> > +             int i =3D get_##type##_instance_id(kobj);                =
 \
> > +             if (i >=3D 0)                                            =
 \
> > +                     return sysfs_emit(buf, "%s\n", bioscfg_drv.type##=
_data[i].name); \
> > +             return -EIO;                                            \
> > +     }
> > +
> > +#define ATTRIBUTE_N_PROPERTY_SHOW(name, type)                         =
       \
> > +     static ssize_t name##_show(struct kobject *kobj, struct kobj_attr=
ibute *attr, \
> > +                                char *buf)                           \
> > +     {                                                               \
> > +             int i =3D get_##type##_instance_id(kobj);                =
 \
> > +             if (i >=3D 0)                                            =
 \
> > +                     return sysfs_emit(buf, "%d\n", bioscfg_drv.type##=
_data[i].name); \
> > +             return -EIO;                                            \
> > +     }
> > +
> > +
> > +#define ATTRIBUTE_PROPERTY_STORE(curr_val, type)                     \
> > +     static ssize_t curr_val##_store(struct kobject *kobj,           \
> > +                                     struct kobj_attribute *attr,    \
> > +                                     const char *buf, size_t count)  \
> > +     {                                                               \
> > +             char *p =3D NULL;                                        =
 \
> > +             char *attr_value =3D NULL;                               =
 \
> > +             int i;                                                  \
> > +             int ret =3D -EIO;                                        =
 \
> > +                                                                     \
> > +             attr_value =3D kstrdup(buf, GFP_KERNEL);                 =
 \
> > +             if (!attr_value)                                        \
> > +                     return -ENOMEM;                                 \
> > +                                                                     \
> > +             p =3D memchr(attr_value, '\n', count);                   =
 \
> > +             if (p !=3D NULL)                                         =
 \
> > +                     *p =3D '\0';                                     =
 \
>
> This can also truncate the string if there is data after the newline.

This is a expected behavior as described by Hans in a later email

<snip>
> > +
> > +#define ATTRIBUTE_V_COMMON_PROPERTY_SHOW(name, type)                 \
> > +     static ssize_t name##_show(struct kobject *kobj,                \
> > +                                struct kobj_attribute *attr, char *buf=
) \
> > +     {                                                               \
> > +             int i;                                                  \
> > +             int len =3D 0;                                           =
 \
> > +             int instance_id =3D get_##type##_instance_id(kobj);      =
 \
> > +                                                                     \
> > +             if (instance_id < 0)                                    \
> > +                     return 0;                                       \
> > +                                                                     \
> > +             for (i =3D 0; i < bioscfg_drv.type##_data[instance_id].co=
mmon.name##_size; i++) { \
> > +                     if (i)                                          \
> > +                             len +=3D sysfs_emit_at(buf, len, "%s", ";=
"); \
>
> No need for the "%s" here.

Done!

<snip>

> > + * Prototypes
> > + */
> > +union acpi_object *get_wmiobj_pointer(int instance_id, const char *gui=
d_string);
> > +int get_instance_count(const char *guid_string);
> > +void update_attribute_permissions(u32 isReadOnly, struct kobj_attribut=
e *current_val);
> > +void friendly_user_name_update(char *path, const char *attr_name,
> > +                            char *attr_display, int attr_size);
> > +int bioscfg_wmi_error_and_message(int error_code);
> > +
> > +/* String attributes */
> > +int populate_string_buffer_data(u8 *buffer_ptr, u32 *buffer_size,
> > +                             int instance_id,
> > +                             struct kobject *attr_name_kobj);
> > +
> > +int populate_string_elements_from_buffer(u8 *buffer_ptr, u32 *buffer_s=
ize,
> > +                                      int instance_id);
> > +
> > +//enum hp_wmi_data_type type);
> > +int alloc_string_data(void);
> > +void exit_string_attributes(void);
> > +int populate_string_package_data(union acpi_object *str_obj,
> > +                              int instance_id,
> > +                              struct kobject *attr_name_kobj);
> > +int populate_string_elements_from_package(union acpi_object *str_obj,
> > +                                       int str_obj_count,
> > +                                       int instance_id);
> > +
> > +/* Integer attributes */
> > +int populate_integer_buffer_data(u8 *buffer_ptr, u32 *buffer_size,
> > +                              int instance_id,
> > +                              struct kobject *attr_name_kobj);
> > +int populate_integer_elements_from_buffer(u8 *buffer_ptr, u32 *buffer_=
size,
> > +                                       int instance_id);
> > +int alloc_integer_data(void);
> > +void exit_integer_attributes(void);
> > +int populate_integer_package_data(union acpi_object *integer_obj,
> > +                               int instance_id,
> > +                               struct kobject *attr_name_kobj);
> > +int populate_integer_elements_from_package(union acpi_object *integer_=
obj,
> > +                                        int integer_obj_count,
> > +                                        int instance_id);
> > +
> > +/* Enumeration attributes */
> > +int populate_enumeration_buffer_data(u8 *buffer_ptr, u32 *buffer_size,
> > +                                  int instance_id,
> > +                                  struct kobject *attr_name_kobj);
> > +int populate_enumeration_elements_from_buffer(u8 *buffer_ptr, u32 *buf=
fer_size,
> > +                                           int instance_id);
> > +int alloc_enumeration_data(void);
> > +void exit_enumeration_attributes(void);
> > +int populate_enumeration_package_data(union acpi_object *enum_obj,
> > +                                   int instance_id,
> > +                                   struct kobject *attr_name_kobj);
> > +int populate_enumeration_elements_from_package(union acpi_object *enum=
_obj,
> > +                                            int enum_obj_count,
> > +                                            int instance_id);
> > +
> > +/* Ordered list */
> > +int populate_ordered_list_buffer_data(u8 *buffer_ptr,
> > +                                   u32 *buffer_size,
> > +                                   int instance_id,
> > +                                   struct kobject *attr_name_kobj);
> > +int populate_ordered_list_elements_from_buffer(u8 *buffer_ptr,
> > +                                            u32 *buffer_size,
> > +                                            int instance_id);
> > +int alloc_ordered_list_data(void);
> > +void exit_ordered_list_attributes(void);
> > +int populate_ordered_list_package_data(union acpi_object *order_obj,
> > +                                    int instance_id,
> > +                                    struct kobject *attr_name_kobj);
> > +int populate_ordered_list_elements_from_package(union acpi_object *ord=
er_obj,
> > +                                             int order_obj_count,
> > +                                             int instance_id);
>
> There are a lot of these per-type setup and teardown functions.
> They are cluttering the API and need a lot of code when called.
>
> Instead there could be a struct with function pointers:
>
> struct type_ops {
>   populate_data;
>   from_buffer;
>   alloc;
>   exit;
>   ...
> }
>
> const struct string_ops {
>   .alloc =3D alloc_string_data;
>   ...
> };
>
> const struct type_ops[] =3D {
>   &string_ops,
>   ...
> };
>
> And then the global setup code can just loop over these structs.

package or buffer data are exposed by BIOS but never both.  Agree, the
new interface is an improvement and we will refactor the driver after
initial release upstream.
>
> > +
> > +/* Password authentication attributes */
> > +int populate_password_buffer_data(u8 *buffer_ptr, u32 *buffer_size,
> > +                               int instance_id,
> > +                               struct kobject *attr_name_kobj);
> > +int populate_password_elements_from_buffer(u8 *buffer_ptr, u32 *buffer=
_size,
> > +                                        int instance_id);
> > +int populate_password_package_data(union acpi_object *password_obj,
> > +                                int instance_id,
> > +                                struct kobject *attr_name_kobj);
> > +int populate_password_elements_from_package(union acpi_object *passwor=
d_obj,
> > +                                         int password_obj_count,
> > +                                         int instance_id);
> > +int alloc_password_data(void);
> > +int alloc_secure_platform_data(void);
> > +void exit_password_attributes(void);
> > +void exit_secure_platform_attributes(void);
> > +int populate_secure_platform_data(struct kobject *attr_name_kobj);
> > +int password_is_set(const char *auth);
> > +int check_spm_is_enabled(void);
> > +int hp_wmi_set_bios_setting(u16 *input_buffer, u32 input_size);
> > +int hp_wmi_perform_query(int query, enum hp_wmi_command command,
> > +                      void *buffer, int insize, int outsize);
> > +int validate_password_input(int instance_id, const char *buf);
> > +
> > +/* Sure Start attributes */
> > +void exit_sure_start_attributes(void);
> > +int populate_sure_start_data(struct kobject *attr_name_kobj);
> > +
> > +int set_bios_defaults(u8 defType);
> > +int get_password_instance_for_type(const char *name);
> > +int clear_all_credentials(void);
> > +int clear_passwords(const int instance);
> > +void exit_bios_attr_set_interface(void);
> > +int init_bios_attr_set_interface(void);
> > +size_t bioscfg_calculate_string_buffer(const char *str);
> > +size_t calculate_security_buffer(const char *authentication);
> > +void populate_security_buffer(u16 *buffer, const char *authentication)=
;
> > +int set_new_password(const char *password_type, const char *new_passwo=
rd);
> > +int init_bios_attr_pass_interface(void);
> > +void exit_bios_attr_pass_interface(void);
> > +void *ascii_to_utf16_unicode(u16 *p, const u8 *str);
> > +int get_integer_from_buffer(int **buffer, u32 *buffer_size, int *integ=
er);
> > +int get_string_from_buffer(u8 **buffer, u32 *buffer_size, char *dst, u=
32 dst_size);
> > +int convert_hexstr_to_str(const char *input, u32 input_len, char **str=
, int *len);
> > +int encode_outsize_for_pvsz(int outsize);
> > +int hp_set_attribute(const char *a_name, const char *a_value);
> > +
> > +/* SPM Attributes */
> > +ssize_t update_spm_state(void);
> > +ssize_t statusbin(struct kobject *kobj, struct kobj_attribute *attr, c=
har *buf);
> > +ssize_t statusbin_show(struct kobject *kobj, struct kobj_attribute *at=
tr, char *buf);
> > +ssize_t status_show(struct kobject *kobj, struct kobj_attribute *attr,=
 char *buf);
>
> None of these SPM functions are used outside of their compilation
> units. They should be static and removed from the header.
>
> Please also validate all the other non-static symbols, enums and
> #defines.

Done!
>
> > +
> > +#endif
> > --
> > 2.34.1
> >
