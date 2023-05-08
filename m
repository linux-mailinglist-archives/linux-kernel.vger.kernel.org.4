Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2466FB3EE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 17:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbjEHPhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 11:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbjEHPhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 11:37:02 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40DB618B;
        Mon,  8 May 2023 08:36:59 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2ac8d9399d5so33849791fa.1;
        Mon, 08 May 2023 08:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683560218; x=1686152218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqBgEUQQl6A/5SX259SjViiMdJ7YooayVKuDuqp6eSY=;
        b=DAMNW8MtGN06GMg8oxY/YaVFpESYesC2q0a9Lsv4Z2jFFuLESYedtaJzn+VU1MVc2+
         eDYHiDyUZMqUxYyphj4Bxs6DPXwFUfgvoAyzqyjH3fMtoSRurpR27DOqL9O6DvEcVTTU
         K039RP//80+sOzemWztskxeisoWWJ+E1xxg6rDIBEbdE3hjSyVp34Po6a5W0hWNQMs8H
         sMQqIETPq9ubh/DhKzZkoUCL+7Ax8FliQEH+KKrvYWNJ5m33YE1gb4CeamyCg32hU419
         V27DAsiFrfmo3zFgRVjYVGMILOLX8Tm1Ae1Wng9TTN+om2rM8gG2YcAVvxtVjDhZJgft
         G4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683560218; x=1686152218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqBgEUQQl6A/5SX259SjViiMdJ7YooayVKuDuqp6eSY=;
        b=gTDnrKdVMjSPXLGCTwM5+PkNXhuwg617lbAZfDEhVrM+0Z9tNprVlhxJnaLEym3K6g
         ofmjwOpEEzGgmMdgTkbUK0APd7eJ2amdY+/57nZIrVrGeaAL5tCsUrTmScjbn9ANzgzN
         Rxn0ajErEwNG0BZ13V7f1GY18ey6xhRXAqw518Kzs6NnBf1MEoTRAVeIuek3+Xn03WuG
         gNlNsmS5mPAkktP+fmt6Io70Xr72G4Hfmkxq7WXcDOmaWm4dITKzMWJWsIrg/DH1/ULB
         W5jPOpXyOrdJO69ewkbgZHGmIeESPhnOEjtB8FlDIAaylVKPTRjoIdrMKWqDtuEDlb83
         a2hg==
X-Gm-Message-State: AC+VfDz7xr3OdyjAi9w8EZQt2AHdki3cfaUovTuA7lT1p8ZJQ+jRtevg
        +Fgt2mxxhQ1CrVg+nEsPWcP0AF40OMD+owD+Yi/GChPv
X-Google-Smtp-Source: ACHHUZ6KF/wIpC/Ww3p6ZxdSZP9iWGMkTPPdEgi/YAD6fTf5QbQ9qMsFEDnnV5g+9iEL+a+fpDHzEqdD7xVB68CDhc8=
X-Received: by 2002:ac2:5999:0:b0:4db:1e4a:74a1 with SMTP id
 w25-20020ac25999000000b004db1e4a74a1mr2420424lfn.0.1683560217977; Mon, 08 May
 2023 08:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230505220043.39036-1-jorge.lopez2@hp.com> <20230505220043.39036-9-jorge.lopez2@hp.com>
 <83b3f3ac-74e8-4681-828e-a82d64d6f104@t-8ch.de>
In-Reply-To: <83b3f3ac-74e8-4681-828e-a82d64d6f104@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Mon, 8 May 2023 10:36:29 -0500
Message-ID: <CAOOmCE9XtOrdBJLQFGXyPDycevyv92Aww-CzZuRC9d8M6KSBUA@mail.gmail.com>
Subject: Re: [PATCH v12 08/13] HP BIOSCFG driver - bioscfg-h
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

On Sat, May 6, 2023 at 2:15=E2=80=AFAM Thomas Wei=C3=9Fschuh <thomas@t-8ch.=
de> wrote:
>
> On 2023-05-05 17:00:38-0500, Jorge Lopez wrote:
> <snip>
>
> > ---
> > Based on the latest platform-drivers-x86.git/for-next
> > ---
> >  drivers/platform/x86/hp/hp-bioscfg/bioscfg.h | 523 +++++++++++++++++++
> >  1 file changed, 523 insertions(+)
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
> >
> > diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h b/drivers/pla=
tform/x86/hp/hp-bioscfg/bioscfg.h
> > new file mode 100644
> > index 000000000000..f27667d7ba9f
> > --- /dev/null
> > +++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
> > @@ -0,0 +1,523 @@
> > +/* SPDX-License-Identifier: GPL-2.0
> > + *
> > + * Definitions for kernel modules using hp_bioscfg driver
> > + *
> > + *  Copyright (c) 2022 HP Development Company, L.P.
> > + */
> > +
> > +#ifndef _HP_BIOSCFG_H_
> > +#define _HP_BIOSCFG_H_
> > +
> > +#include <linux/wmi.h>
> > +#include <linux/types.h>
> > +#include <linux/device.h>
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/capability.h>
> > +#include <linux/nls.h>
> > +
> > +#define DRIVER_NAME          "hp-bioscfg"
> > +
> > +#define MAX_BUFF             512
> > +#define MAX_KEY_MOD          256
>
> Seems to need _SIZE suffix.

Done!.   I will update references in all files

>
> > +#define MAX_PASSWD_SIZE              64
> > +#define MAX_MESSAGE_SIZE     256
>
> Never used.

Done!  MAX_MESSAGE_SIZE will be delete

>
> > +#define MAX_PREREQUISITES_SIZE       20
> > +#define MAX_REQ_ELEM_SIZE    128
> > +#define MAX_VALUES_SIZE              16
> > +#define MAX_ENCODINGS_SIZE   16
> > +#define MAX_ELEMENTS_SIZE    16
> > +
> > +#define SPM_STR_DESC         "Secure Platform Management"
> > +#define SPM_STR                      "SPM"
> > +#define SURE_START_DESC              "Sure Start"
> > +#define SURE_START_STR               "Sure_Start"
> > +#define SETUP_PASSWD         "Setup Password"
> > +#define POWER_ON_PASSWD              "Power-On Password"
> > +
> > +#define LANG_CODE_STR                "en_US.UTF-8"
> > +#define SCHEDULE_POWER_ON    "Scheduled Power-On"
> > +
> > +#define COMMA_SEP            ","
> > +#define SEMICOLON_SEP                ";"
> > +
> > +/* Sure Admin Functions */
> > +
> > +#define UTF_PREFIX           "<utf-16/>"
> > +#define BEAM_PREFIX          "<BEAM/>"
> > +
> > +/* mechanism - Authentication attribute */
> > +
> > +#define MAX_MECHANISM_TYPES  3
>
> Never used.

Done!

>
> > +
> > +enum mechanism_values {
> > +     PASSWORD                =3D 0x00,
> > +     NOT_PROVISION           =3D 0x00,
>
> Never used.

Done!
>
> > +     SIGNING_KEY             =3D 0x01,
> > +     ENDORSEMENT_KEY         =3D 0x02,
> > +};
> > +

<snip>

> > +
> > +enum spm_features {
> > +     HEP_ENABLED                     =3D 0x01,
> > +     PLATFORM_RECOVERY               =3D 0x02,
> > +     ENHANCED_BIOS_AUTH_MODE         =3D 0x04,
> > +};
> > +
> > +enum spm_states_values {
> > +     NOT_PROVISIONED                 =3D 0x00,
> > +     PROVISIONED                     =3D 0x01,
> > +     PROVISIONING_IN_PROGRESS        =3D 0x02,
> > +};
>
> Are these enums used?

Done!

>
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
> > +struct string_data {
> > +     struct common_data common;
> > +     struct kobject *attr_name_kobj;
> > +     u8 current_value[MAX_BUFF];
> > +     u8 new_value[MAX_BUFF];
> > +     u32 min_length;
> > +     u32 max_length;
> > +};
> > +
> > +struct integer_data {
> > +     struct common_data common;
> > +     struct kobject *attr_name_kobj;
> > +     u32 current_value;
> > +     u32 new_value;
> > +     u32 lower_bound;
> > +     u32 upper_bound;
> > +     u32 scalar_increment;
> > +};
> > +
> > +struct enumeration_data {
> > +     struct common_data common;
> > +     struct kobject *attr_name_kobj;
> > +     u8 current_value[MAX_BUFF];
> > +     u8 new_value[MAX_BUFF];
> > +     u32 possible_values_size;
> > +     u8 possible_values[MAX_VALUES_SIZE][MAX_BUFF];
> > +};
> > +
> > +struct ordered_list_data {
> > +     struct common_data common;
> > +     struct kobject *attr_name_kobj;
> > +     u8 current_value[MAX_BUFF];
> > +     u8 new_value[MAX_BUFF];
> > +     u32 elements_size;
> > +     u8 elements[MAX_ELEMENTS_SIZE][MAX_BUFF];
> > +};
> > +
> > +struct password_data {
> > +     struct common_data common;
> > +     struct kobject *attr_name_kobj;
> > +     u8 current_password[MAX_PASSWD_SIZE];
> > +     u8 new_password[MAX_PASSWD_SIZE];
> > +     u32 min_password_length;
> > +     u32 max_password_length;
> > +     u32 encodings_size;
> > +     u8 encodings[MAX_ENCODINGS_SIZE][MAX_BUFF];
> > +     u32 is_enabled;
>
> If it is only being used as a boolean, bool is nicer.

Done!

>
> > +
> > +     // 'bios-admin' 'power-on'
> > +     u32 role;
>
> Are the comments about the possible values or the context in which this
> field will be used?
> This should be clear.

'role' is described in the documentation

role:
       The type of authentication used.
       This attribute is mandatory.

Known types:
       bios-admin:
                        Representing BIOS administrator password
       power-on:
                        Representing a password required to use
                        the system

I will add similar comments to the code.

> > +
> > +     //'password'
> > +     u32 mechanism;
> > +};
> > +
> > +struct secure_platform_data {
> > +     struct kobject *attr_name_kobj;
> > +     u8 attribute_name[MAX_BUFF];
> > +     u8 *endorsement_key;
> > +     u8 *signing_key;
> > +     u8 *auth_token;
> > +     u32 is_enabled;
>
> Also bool.

Done!
>
> > +     u32 mechanism;
> > +};
> > +
> > +struct bioscfg_priv {
> > +     struct wmi_device *bios_attr_wdev;
> > +     struct kset *authentication_dir_kset;
> > +     struct kset *main_dir_kset;
> > +     struct device *class_dev;
> > +     struct string_data *string_data;
> > +     u32 string_instances_count;
> > +     struct integer_data *integer_data;
> > +     u32 integer_instances_count;
> > +     struct enumeration_data *enumeration_data;
> > +     u32 enumeration_instances_count;
> > +     struct ordered_list_data *ordered_list_data;
> > +     u32 ordered_list_instances_count;
> > +     struct password_data *password_data;
> > +     u32 password_instances_count;
> > +
> > +     struct kobject *sure_start_attr_kobj;
> > +     struct secure_platform_data spm_data;
> > +
> > +     bool pending_reboot;
> > +     struct mutex mutex;
> > +};
> > +
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
> > +     HPWMI_SURE_START_TYPE           =3D 0x06,
> > +};
>
> There is no need to explicitly specify enum values when they don't
> matter.
> This makes it clear if an enum represents values for an external ABI or
> if it is just for internal use.
>

I added them for my clarification, in the event enums added at a later
time do not have a sequential value.
This is not the case here so I will remove the value.
Done!


<snip>
> > +#define ATTRIBUTE_S_COMMON_PROPERTY_SHOW(name, type)         \
> > +     static ssize_t name##_show(struct kobject *kobj, struct kobj_attr=
ibute *attr, \
> > +                                char *buf)                           \
> > +     {                                                               \
> > +             int i =3D get_##type##_instance_id(kobj);                =
 \
> > +             if (i >=3D 0)                                            =
 \
> > +                     return sysfs_emit(buf, "%s\n", bioscfg_drv.type##=
_data[i].common.name); \
> > +             return -EIO;                                            \
> > +     }
> > +
> > +/*
> > + * Prototypes
> > + */
> > +union acpi_object *get_wmiobj_pointer(int instance_id, const char *gui=
d_string);
>
> Weren't all non-static functions supposed to gain a common prefix?

I misunderstood an earlier comment and made only all functions with
current prefixes to have a common one.
I will add a prefix to all common functions.



>
> > +int get_instance_count(const char *guid_string);
> > +void update_attribute_permissions(u32 isreadonly, struct kobj_attribut=
e *current_val);
>
> "bool readonly" should be enough.

Done!


>
> > +void friendly_user_name_update(char *path, const char *attr_name,
> > +                            char *attr_display, int attr_size);
> > +int hp_wmi_error_and_message(int error_code);
> > +
> > +/* String attributes */
> > +int populate_string_buffer_data(u8 *buffer_ptr, u32 *buffer_size,
> > +                             int instance_id,
> > +                             struct kobject *attr_name_kobj);
> > +
> > +int populate_string_elements_from_buffer(u8 *buffer_ptr, u32 *buffer_s=
ize,
> > +                                      int instance_id);
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
> > +int check_spm_is_enabled(void);
> > +int hp_wmi_set_bios_setting(u16 *input_buffer, u32 input_size);
> > +int hp_wmi_perform_query(int query, enum hp_wmi_command command,
> > +                      void *buffer, u32 insize, u32 outsize);
> > +int validate_password_input(int instance_id, const char *buf);
> > +
> > +/* Sure Start attributes */
> > +void exit_sure_start_attributes(void);
> > +int populate_sure_start_data(struct kobject *attr_name_kobj);
> > +
> > +int set_bios_defaults(u8 deftype);
>
> This seems not to actually exist.
>
> > +int get_password_instance_for_type(const char *name);
> > +int clear_all_credentials(void);
> > +int clear_passwords(const int instance);
> > +void exit_hp_attr_set_interface(void);
> > +int init_hp_attr_set_interface(void);
> > +size_t hp_calculate_string_buffer(const char *str);
> > +size_t calculate_security_buffer(const char *authentication);
> > +int populate_security_buffer(u16 *buffer, const char *authentication);
> > +int set_new_password(const char *password_type, const char *new_passwo=
rd);
> > +int init_hp_attr_pass_interface(void);
> > +void exit_hp_attr_pass_interface(void);
> > +void *hp_ascii_to_utf16_unicode(u16 *p, const u8 *str);
> > +int get_integer_from_buffer(u8 **buffer, u32 *buffer_size, u32 *intege=
r);
> > +int get_string_from_buffer(u8 **buffer, u32 *buffer_size, char *dst, u=
32 dst_size);
> > +int convert_hexstr_to_str(const char *input, u32 input_len, char **str=
, int *len);
> > +int encode_outsize_for_pvsz(int outsize);
> > +int hp_set_attribute(const char *a_name, const char *a_value);
> > +int enforce_single_line_input(char *buf, size_t count);
> > +void set_reboot_and_signal_event(void);
> > +
> > +#endif
> > --
> > 2.34.1
> >
