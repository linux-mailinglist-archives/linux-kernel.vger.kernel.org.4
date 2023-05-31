Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0FB718742
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 18:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjEaQWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 12:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjEaQWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 12:22:45 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B815132;
        Wed, 31 May 2023 09:22:42 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2af2c35fb85so63884201fa.3;
        Wed, 31 May 2023 09:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685550160; x=1688142160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O44tdFoCQTVZoNLcx4Jw4lcBxJgV7e1izc2pQGeyMtU=;
        b=hccPON+QR72ivDvazjP93XS1+i5Ru4KN8gNqIBSjluVihSYaEp5QhJJIJ/GPUrf/Ur
         o3XPAPuHX9U8qUn3B0K5SEna1kNSfMTmAuVTnc/SL9Bh8n+xl9U/6QJi7hV/NLQ7Ku66
         FE+EcNhrAwPNPasw6c+Q7RhH9A25kLGAtQvpOv0QIpXoxGY/9dUGEgiqFNEb6RBxKr1Y
         TzVetaJfQMlNnA/cz1eVVDilGuVS+4IEDbnWnLmYRfNw6kh5LVGGxn98LvaTcU4RFFLg
         qeRkeUlnRzQGPwq0qI/vIZ4Zp2Vu2a3PEjiiibjyctLYIT/Wv48/WiSqKvhoHoU4cpuu
         hIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685550160; x=1688142160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O44tdFoCQTVZoNLcx4Jw4lcBxJgV7e1izc2pQGeyMtU=;
        b=jEvXIMHkjB79I4BHZRvgtF+DoCRL7n83k9P85Q7jrEysERkVOhsAj3PwoCi7y0xvyj
         HjcnHvDqBxgkzCIo9sc790yBGGBHZraBUvt2Aex9YisVKJW25PSQ+T8TZwAv2nPasK4g
         7NtnYHyChC7GUQ+OPvMDO/I+D5ey4rYFoUpaPH7NAsVrzbq9mNLADmYIe0Qv31V/H2XF
         UVvxB9l8znJqL7JhsWQkj7mPtjb+6E5ZX+dYyUOdH0L+fjUkbSsJt8ghTsWFoUMnpvh2
         43Yw65UZ0zmqJygNhf2n/uG0jNg9Db8e3h80IVDi8TEjp6USgcKCxfVqERa7KvnPVZiP
         XwnA==
X-Gm-Message-State: AC+VfDzT2TCZ4fLkfKTcl/XWzX3XGinQqjrzaR+zDVbASEJtImZT1t2r
        fYkfoOODXnTnXcd051mXdfEcvQIYwQ/Iq9fWxOJkgI/7qZA=
X-Google-Smtp-Source: ACHHUZ65gHJuYKkAkZR3FktPreo0ps4YUOaxWXtqWmXF3hTtgMbi30hbfdX0TFUnX0Tm5aNwheyvS3vRqrCtjg9DSl8=
X-Received: by 2002:a2e:868e:0:b0:2ac:70fa:fb7b with SMTP id
 l14-20020a2e868e000000b002ac70fafb7bmr3305255lji.18.1685550160150; Wed, 31
 May 2023 09:22:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230519201300.12964-1-jorge.lopez2@hp.com> <20230519201300.12964-3-jorge.lopez2@hp.com>
 <efd7d98f-c441-4098-9ace-93529989d51d@t-8ch.de>
In-Reply-To: <efd7d98f-c441-4098-9ace-93529989d51d@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Wed, 31 May 2023 11:22:04 -0500
Message-ID: <CAOOmCE-EmwivPN_LJWqWMNe5WufTdmOHMuzjbJ1nNZ3n+bmpFQ@mail.gmail.com>
Subject: Re: [PATCH v15 02/13] hp-bioscfg: bioscfg-h
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com
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

On Fri, May 26, 2023 at 10:14=E2=80=AFAM Thomas Wei=C3=9Fschuh <thomas@t-8c=
h.de> wrote:
>
> Hi Jorge,
>
> sorry for the long delay.

No worries.  I got Covid while you were away so I am slowly coming back.

> Here we go again :-)
>
> On 2023-05-19 15:12:49-0500, Jorge Lopez wrote:
>
> <snip>
>
> > ---
> >  drivers/platform/x86/hp/hp-bioscfg/bioscfg.h | 486 +++++++++++++++++++
> >  1 file changed, 486 insertions(+)
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
> >
> > diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h b/drivers/pla=
tform/x86/hp/hp-bioscfg/bioscfg.h
> > new file mode 100644
> > index 000000000000..3a3b24f766d2
> > --- /dev/null
> > +++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
> > @@ -0,0 +1,486 @@
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
>
> Is this needed?

+#include <linux/capability.h> is not needed.  It will be removed.

>
> > +#include <linux/nls.h>
> > +
> > +#define DRIVER_NAME          "hp-bioscfg"
> > +
> > +#define MAX_BUFF_SIZE                512
> > +#define MAX_KEY_MOD_SIZE     256
> > +#define MAX_PASSWD_SIZE              64
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
> > +enum mechanism_values {
> > +     PASSWORD                =3D 0x00,
> > +     SIGNING_KEY             =3D 0x01,
> > +     ENDORSEMENT_KEY         =3D 0x02,
> > +};
> > +
> > +#define BIOS_ADMIN           "bios-admin"
> > +#define POWER_ON             "power-on"
> > +#define BIOS_SPM             "enhanced-bios-auth"
> > +
> > +#define PASSWD_MECHANISM_TYPES "password"
> > +
> > +#define HP_WMI_BIOS_GUID             "5FB7F034-2C63-45e9-BE91-3D44E2C7=
07E4"
> > +
> > +#define HP_WMI_BIOS_STRING_GUID              "988D08E3-68F4-4c35-AF3E-=
6A1B8106F83C"
> > +#define HP_WMI_BIOS_INTEGER_GUID     "8232DE3D-663D-4327-A8F4-E293ADB9=
BF05"
> > +#define HP_WMI_BIOS_ENUMERATION_GUID "2D114B49-2DFB-4130-B8FE-4A3C09E7=
5133"
> > +#define HP_WMI_BIOS_ORDERED_LIST_GUID        "14EA9746-CE1F-4098-A0E0-=
7045CB4DA745"
> > +#define HP_WMI_BIOS_PASSWORD_GUID    "322F2028-0F84-4901-988E-01517604=
9E2D"
> > +#define HP_WMI_SET_BIOS_SETTING_GUID "1F4C91EB-DC5C-460b-951D-C7CB9B4B=
8D5E"
> > +
> > +enum hp_wmi_spm_commandtype {
> > +     HPWMI_SECUREPLATFORM_GET_STATE  =3D 0x10,
> > +     HPWMI_SECUREPLATFORM_SET_KEK    =3D 0x11,
> > +     HPWMI_SECUREPLATFORM_SET_SK     =3D 0x12,
> > +};
> > +
> > +enum hp_wmi_surestart_commandtype {
> > +     HPWMI_SURESTART_GET_LOG_COUNT   =3D 0x01,
> > +     HPWMI_SURESTART_GET_LOG         =3D 0x02,
> > +};
> > +
> > +enum hp_wmi_command {
> > +     HPWMI_READ              =3D 0x01,
> > +     HPWMI_WRITE             =3D 0x02,
> > +     HPWMI_ODM               =3D 0x03,
> > +     HPWMI_SURESTART         =3D 0x20006,
> > +     HPWMI_GM                =3D 0x20008,
> > +     HPWMI_SECUREPLATFORM    =3D 0x20010,
> > +};
> > +
> > +struct bios_return {
> > +     u32 sigpass;
> > +     u32 return_code;
> > +};
> > +

<snip>

> > +
> > +struct secure_platform_data {
> > +     struct kobject *attr_name_kobj;
> > +     u8 attribute_name[MAX_BUFF_SIZE];
> > +     u8 *endorsement_key;
> > +     u8 *signing_key;
> > +     u8 *auth_token;
> > +     bool is_enabled;
> > +     u32 mechanism;
> > +};
> > +
> > +struct bioscfg_priv {
> > +     struct wmi_device *bios_attr_wdev;
>
> This wmi_device is never really used.

bios_attr_wdev will be removed from this file and biosattr-interface.c

>
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
> > +     u8 display_name_language_code[MAX_BUFF_SIZE];
> > +     bool pending_reboot;
> > +     struct mutex mutex;
> > +};
> > +
> > +/* global structure used by multiple WMI interfaces */
> > +extern struct bioscfg_priv bioscfg_drv;
> > +
> > +enum hp_wmi_data_type {
> > +     HPWMI_STRING_TYPE,
> > +     HPWMI_INTEGER_TYPE,
> > +     HPWMI_ENUMERATION_TYPE,
> > +     HPWMI_ORDERED_LIST_TYPE,
> > +     HPWMI_PASSWORD_TYPE,
> > +     HPWMI_SECURE_PLATFORM_TYPE,
> > +     HPWMI_SURE_START_TYPE,
> > +};
> > +

<snip>

> > +/* Bioscfg */
> > +
> > +void hp_exit_attr_set_interface(void);
> > +int hp_init_attr_set_interface(void);
> > +size_t hp_calculate_string_buffer(const char *str);
> > +size_t hp_calculate_security_buffer(const char *authentication);
> > +void *hp_ascii_to_utf16_unicode(u16 *p, const u8 *str);
> > +int hp_get_integer_from_buffer(u8 **buffer, u32 *buffer_size, u32 *int=
eger);
> > +int hp_get_string_from_buffer(u8 **buffer, u32 *buffer_size, char *dst=
, u32 dst_size);
> > +int hp_convert_hexstr_to_str(const char *input, u32 input_len, char **=
str, int *len);
> > +int hp_encode_outsize_for_pvsz(int outsize);
> > +int hp_enforce_single_line_input(char *buf, size_t count);
> > +void hp_set_reboot_and_signal_event(void);
> > +ssize_t display_name_language_code_show(struct kobject *kobj,
> > +                                     struct kobj_attribute *attr,
> > +                                     char *buf);
> > +union acpi_object *hp_get_wmiobj_pointer(int instance_id, const char *=
guid_string);
> > +int hp_get_instance_count(const char *guid_string);
> > +void hp_update_attribute_permissions(bool isreadonly, struct kobj_attr=
ibute *current_val);
> > +void hp_friendly_user_name_update(char *path, const char *attr_name,
> > +                               char *attr_display, int attr_size);
> > +int hp_wmi_error_and_message(int error_code);
> > +
> > +#endif
> > --
> > 2.34.1
> >
