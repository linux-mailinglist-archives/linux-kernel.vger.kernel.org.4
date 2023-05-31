Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE5E7186ED
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 18:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbjEaQAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 12:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbjEaQAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 12:00:42 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF87132;
        Wed, 31 May 2023 09:00:37 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2af98eb6ef0so67045261fa.3;
        Wed, 31 May 2023 09:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685548835; x=1688140835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOkBKE/hQQ8rwktRtIxFFLCd/qEMCLP+bHFun6NkU10=;
        b=XDGcsRq14BfbugKJRTA7BHefDPOXqXhnK5YeF1WfI0yDAE/SdLD/2amGZCQA9fVj1Q
         WGwFFhlgInXpBRk+uDK+vNrNA7WRK5D7/ugWj5QoeszGsIkBbqvWsGkpJWvc7zzFyAbU
         akXnGuZlCvE+qNKTOvJaAGDWEQleneKtooBQh6vqsh7BNU6M+dG7hFcGL99aoqn8gsuR
         vzb20vhqyNDJ1kDcbdClhgroUdtvz+ZHTMIuspdOaG87LD/NMCFxDzasAS/wIQ7CLhO4
         F3pit9+GGQfDASyetXs4UolbLfosapfUyTyb15QoPgIUacnKHggztXarmYUIQmjcKaYf
         kokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685548835; x=1688140835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOkBKE/hQQ8rwktRtIxFFLCd/qEMCLP+bHFun6NkU10=;
        b=KQYGR3T4St1mU/nMRLvYNevHqztgG+V1Fey+4hy/bmcV7qSai4gpndF8PZ4sODB2FA
         JNV2ihmMbrVObrkh5l802FW+wQeFHUZL2W0vbC5itxn0kD2SITMAL0EnVHzWx3oY0Mug
         Rqx04o7HNed6m+60EEIdcriQjEvwIfUEXcjGWXGNwzQ4OrgmW5mdy6AvA5FmoL4e0l5m
         fpJsbJrTH91XV9/crlzFQXK8aeRVtMI3PxbioHh9bsoAZYn7BWs5JQ/8oHW3sxNYA2Wr
         CTYCKy/gnqxA/NDltFAyc1JVuZNlvUDh/jlGve1JFnW0jYAnMjBxdygRsXeQ202qencL
         ja9g==
X-Gm-Message-State: AC+VfDzURK7FVC2diRL7nN+lQhgkXCkA/uv1ikvFiHskFsRMFm1I9/P+
        IWyjF1tJImI6gmY0PN6s7e+9zfMcZg1KST8MARA=
X-Google-Smtp-Source: ACHHUZ448aJUSYj9k0YL5urAXKXOIynNHFph4hfWDcabwcYjISRGir1UxQ34r9m2YTXBhwpSIIe7/eUfgNgDIzG0kuE=
X-Received: by 2002:a2e:2c06:0:b0:2b0:3046:9c6 with SMTP id
 s6-20020a2e2c06000000b002b0304609c6mr3547711ljs.9.1685548835135; Wed, 31 May
 2023 09:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230519201300.12964-1-jorge.lopez2@hp.com> <20230519201300.12964-6-jorge.lopez2@hp.com>
 <0cbd158e-0742-4e04-9996-bd376f9b555b@t-8ch.de> <CAOOmCE8=C_qH862G9sdLS59=QPh6U_78WY0SzJwzZfW+iSUiPA@mail.gmail.com>
 <dd9df9e7-9693-4ddc-8429-cc5e0567da17@t-8ch.de>
In-Reply-To: <dd9df9e7-9693-4ddc-8429-cc5e0567da17@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Wed, 31 May 2023 10:59:58 -0500
Message-ID: <CAOOmCE_=LH9rcz4x=q-iq8sBhC4G7TtaU5M_R-ZLWwaJYNadSw@mail.gmail.com>
Subject: Re: [PATCH v15 05/13] hp-bioscfg: enum-attributes
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

On Tue, May 30, 2023 at 4:42=E2=80=AFPM Thomas Wei=C3=9Fschuh <thomas@t-8ch=
.de> wrote:
>
> On 2023-05-30 12:01:57-0500, Jorge Lopez wrote:
> > On Fri, May 26, 2023 at 10:35=E2=80=AFAM Thomas Wei=C3=9Fschuh <thomas@=
t-8ch.de> wrote:
> > >
> > > On 2023-05-19 15:12:52-0500, Jorge Lopez wrote:
> > >
> > > <snip>
> > >
> > > >  .../x86/hp/hp-bioscfg/enum-attributes.c       | 465 ++++++++++++++=
++++
> > > >  1 file changed, 465 insertions(+)
> > > >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/enum-attribu=
tes.c
> > > >
> > > > diff --git a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c b=
/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
> > > > new file mode 100644
> > > > index 000000000000..80842835606d
> > > > --- /dev/null
> > > > +++ b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
> > > > @@ -0,0 +1,465 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Functions corresponding to enumeration type attributes under
> > > > + * BIOS Enumeration GUID for use with hp-bioscfg driver.
> > > > + *
> > > > + * Copyright (c) 2022 HP Development Company, L.P.
> > > > + */
> > > > +
> > > > +#include "bioscfg.h"
> > > > +
> > > > +GET_INSTANCE_ID(enumeration);
> > > > +
> > > > +static ssize_t current_value_show(struct kobject *kobj, struct kob=
j_attribute *attr, char *buf)
> > > > +{
> > > > +     int instance_id =3D get_enumeration_instance_id(kobj);
> > > > +
> > > > +     if (instance_id < 0)
> > > > +             return -EIO;
> > > > +
> > > > +     return sysfs_emit(buf, "%s\n",
> > > > +                      bioscfg_drv.enumeration_data[instance_id].cu=
rrent_value);
> > > > +}
> > > > +
> > > > +/**
> > > > + * validate_enumeration_input() -
> > > > + * Validate input of current_value against possible values
> > > > + *
> > > > + * @instance_id: The instance on which input is validated
> > > > + * @buf: Input value
> > > > + */
> >
> > <snip>
> >
> > > > +static int hp_populate_enumeration_elements_from_package(union acp=
i_object *enum_obj,
> > > > +                                                      int enum_obj=
_count,
> > > > +                                                      int instance=
_id)
> > > > +{
> > > > +     char *str_value =3D NULL;
> > > > +     int value_len;
> > > > +     u32 size =3D 0;
> > > > +     u32 int_value;
> > > > +     int elem =3D 0;
> > > > +     int reqs;
> > > > +     int pos_values;
> > > > +     int ret;
> > > > +     int eloc;
> > > > +     struct enumeration_data *enum_data =3D &bioscfg_drv.enumerati=
on_data[instance_id];
> > > > +
> > > > +     for (elem =3D 1, eloc =3D 1; elem < enum_obj_count; elem++, e=
loc++) {
> > > > +             /* ONLY look at the first ENUM_ELEM_CNT elements */
> > > > +             if (eloc =3D=3D ENUM_ELEM_CNT)
> > > > +                     goto exit_enumeration_package;
> > > > +
> > > > +             switch (enum_obj[elem].type) {
> > > > +             case ACPI_TYPE_STRING:
> > > > +                     if (PREREQUISITES !=3D elem && ENUM_POSSIBLE_=
VALUES !=3D elem) {
> > > > +                             ret =3D hp_convert_hexstr_to_str(enum=
_obj[elem].string.pointer,
> > > > +                                                            enum_o=
bj[elem].string.length,
> > > > +                                                            &str_v=
alue, &value_len);
> > > > +                             if (ret)
> > > > +                                     return -EINVAL;
> > > > +                     }
> > > > +                     break;
> > > > +             case ACPI_TYPE_INTEGER:
> > > > +                     int_value =3D (u32)enum_obj[elem].integer.val=
ue;
> > > > +                     break;
> > > > +             default:
> > > > +                     pr_warn("Unsupported object type [%d]\n", enu=
m_obj[elem].type);
> > > > +                     continue;
> > > > +             }
> > > > +
> > > > +             /* Check that both expected and read object type matc=
h */
> > > > +             if (expected_enum_types[eloc] !=3D enum_obj[elem].typ=
e) {
> > > > +                     pr_err("Error expected type %d for elem %d, b=
ut got type %d instead\n",
> > > > +                            expected_enum_types[eloc], elem, enum_=
obj[elem].type);
> > > > +                     return -EIO;
> > > > +             }
> > > > +
> > > > +             /* Assign appropriate element value to corresponding =
field */
> > > > +             switch (eloc) {
> > > > +             case NAME:
> > > > +             case VALUE:
> > > > +                     break;
> > > > +             case PATH:
> > > > +                     strscpy(enum_data->common.path, str_value,
> > > > +                             sizeof(enum_data->common.path));
> > > > +                     break;
> > > > +             case IS_READONLY:
> > > > +                     enum_data->common.is_readonly =3D int_value;
> > > > +                     break;
> > > > +             case DISPLAY_IN_UI:
> > > > +                     enum_data->common.display_in_ui =3D int_value=
;
> > > > +                     break;
> > > > +             case REQUIRES_PHYSICAL_PRESENCE:
> > > > +                     enum_data->common.requires_physical_presence =
=3D int_value;
> > > > +                     break;
> > > > +             case SEQUENCE:
> > > > +                     enum_data->common.sequence =3D int_value;
> > > > +                     break;
> > > > +             case PREREQUISITES_SIZE:
> > > > +                     enum_data->common.prerequisites_size =3D int_=
value;
> > > > +                     if (int_value > MAX_PREREQUISITES_SIZE)
> > > > +                             pr_warn("Prerequisites size value exc=
eeded the maximum number of elements supported or data may be malformed\n")=
;
> > > > +
> > > > +                     /*
> > > > +                      * This HACK is needed to keep the expected
> > > > +                      * element list pointing to the right obj[ele=
m].type
> > > > +                      * when the size is zero. PREREQUISITES
> > > > +                      * object is omitted by BIOS when the size is
> > > > +                      * zero.
> > > > +                      */
> > > > +                     if (int_value =3D=3D 0)
> > > > +                             eloc++;
> > > > +                     break;
> > > > +
> > > > +             case PREREQUISITES:
> > > > +                     size =3D min_t(u32, enum_data->common.prerequ=
isites_size, MAX_PREREQUISITES_SIZE);
> > >
> > > We cannot blindly truncate this to a maximum value.
> > > The firmware reported an amount of elements it would return.
> > >
> > > If this value is to big than we can not just intpret the data as if i=
t
> > > was something the firmware did not return.
> > >
> > > An error needs to be reported to userspace.
> > > A default value is not enough as userspace can not interpret this
> > > properly.
> > >
> >
> > It is ok to truncate prerequisite size to MAX_PREREQUISITES_SIZE.
> > MAX_PREREQUISITES_SIZE is a value predefined by BIOS when the
> > prerequisite values size is invalid ( > MAX_PREREQUISITES_SIZE) and/or
> > the prerequisite data is corrupted.
> > Neither PREREQUISITES nor PREREQUISITES_SIZE are reported to the
> > userspace so there is no need to report a failure on data that is not
> > exposed.  One item that needs clarification is the fact that
> > regardless if  PREREQUISITES or PREREQUISITES_SIZE are invalid, that
> > does not mean other values are invalid.  It is for this reason, we
> > need to continue to read all remaining packages.
>
> It may be that prerequisites are not reported to userspace.
> But the following values are:
>
> security level, current value and possible values.
>
> And if prerequisites are garbage then those are now also garbage.

This statement is not correct.  Each attribute value is isolated from
each other hence it only affects a single value and does not impact
the following values such security level, current value and possible
values
Here is a sample where the prerequisite_size is invalid but the
prerequisites, security, string min value and string max value are
correct.

8003.571287] Attribute: HP_Disk0MapForUefiBootOrder    Prerequisite_size 31=
45848
[ 8003.571287] String Prerequisites size value exceeded the maximum
number of elements supported or data may be malformed

[ 8003.571288] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[0]
/Pci(0x1F,0x6)/MAC(3
[ 8003.571288] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[1]
24D33F453F,0x0)/IPv6(000
[ 8003.571289] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[2]
:0000:0000:0000:0000:000
[ 8003.571290] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[3]
:0000:0000,0x0,Static,00
[ 8003.571290] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[4]
0:0000:0000:0000:0000:00
[ 8003.571291] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[5]
0:0000:0000,0x40,0000:00
[ 8003.571291] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[6]
0:0000:0000:0000:0000:00
[ 8003.571292] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[7]
0:0000)\r\n\tPciRoot(0x0)/P
[ 8003.571292] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[8]
i(0x0,0x0)/IPv4(0.0.0.0,0x0,DHCP,0.0.0.0,0.0.0.0,
[ 8003.571293] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[9]
.0.0.0)\r\n\tPciRoot(0x0)/P
[ 8003.571293] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[10]
i(0x0,0x0)/IPv6(0000:0000:0000:0000:0000:0000:000
[ 8003.571294] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[11]
:0000,0x0,Static,0000:00
[ 8003.571295] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[12]
0:0000:0000:0000:0000:00
[ 8003.571295] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[13]
0:0000,0x0,0000:0000:000
[ 8003.571296] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[14]
:0000:0000:0000:0000:000
[ 8003.571296] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[15] )
[ 8003.571297] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[16]
[ 8003.571297] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[17]
[ 8003.571298] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[18]
[ 8003.571298] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[19]

[ 8003.571298] Attribute: HP_Disk0MapForUefiBootOrder Security 0
[ 8003.571299] Attribute: HP_Disk0MapForUefiBootOrder String Min Length  0
[ 8003.571299] Attribute: HP_Disk0MapForUefiBootOrder String Max Length  0


>
> hp_populate_enumeration_package_data() always returns "0".

Earlier in the code, failures reported for a particular attribute
value were ignored because each value is independent from each other.
It is up to the user space application to analyze the raw data read from BI=
OS.

>
> > In earlier reviews, it was agreed to report a warning  that reads
> >
> > /* Report a message and limit prerequisite size to maximum value */
> > pr_warn("Enum Prerequisites size value exceeded the maximum number of
> > elements supported or data may be malformed\n");
> >
> > See lines 370-374
> >
> > > (Affects all attributes)
> > >
> > > > +                     for (reqs =3D 0; reqs < size; reqs++) {
> > > > +                             if (elem >=3D enum_obj_count) {
> > > > +                                     pr_err("Error enum-objects pa=
ckage is too small\n");
> > > > +                                     return -EINVAL;
> > > > +                             }
> > > > +
> > > > +                             ret =3D hp_convert_hexstr_to_str(enum=
_obj[elem + reqs].string.pointer,
> > > > +                                                            enum_o=
bj[elem + reqs].string.length,
> > > > +                                                            &str_v=
alue, &value_len);
> > > > +
> > > > +                             if (ret)
> > > > +                                     return -EINVAL;
> > > > +
> > > > +                             strscpy(enum_data->common.prerequisit=
es[reqs],
> > > > +                                     str_value,
> > > > +                                     sizeof(enum_data->common.prer=
equisites[reqs]));
> > > > +
> > > > +                             kfree(str_value);
> > > > +                     }
> > > > +                     break;
> > > > +
> > > > +             case SECURITY_LEVEL:
> > > > +                     enum_data->common.security_level =3D int_valu=
e;
> > > > +                     break;
> > > > +
> > > > +             case ENUM_CURRENT_VALUE:
> > > > +                     strscpy(enum_data->current_value,
> > > > +                             str_value, sizeof(enum_data->current_=
value));
> > > > +                     break;
> > > > +             case ENUM_SIZE:
> > > > +                     enum_data->possible_values_size =3D int_value=
;
> > > > +                     if (int_value > MAX_VALUES_SIZE)
> > > > +                             pr_warn("Possible number values size =
value exceeded the maximum number of elements supported or data may be malf=
ormed\n");
> > > > +
> > > > +                     /*
> > > > +                      * This HACK is needed to keep the expected
> > > > +                      * element list pointing to the right obj[ele=
m].type
> > > > +                      * when the size is zero. POSSIBLE_VALUES
> > > > +                      * object is omitted by BIOS when the size is=
 zero.
> > > > +                      */
> > > > +                     if (int_value =3D=3D 0)
> > > > +                             eloc++;
> > > > +                     break;
> > > > +
> > > > +             case ENUM_POSSIBLE_VALUES:
> > > > +                     size =3D enum_data->possible_values_size;
> > > > +
> > > > +                     for (pos_values =3D 0; pos_values < size && p=
os_values < MAX_VALUES_SIZE;
> > > > +                          pos_values++) {
> > > > +                             if (elem >=3D enum_obj_count) {
> > > > +                                     pr_err("Error enum-objects pa=
ckage is too small\n");
> > > > +                                     return -EINVAL;
> > > > +                             }
> > > > +
> > > > +                             ret =3D hp_convert_hexstr_to_str(enum=
_obj[elem + pos_values].string.pointer,
> > > > +                                                            enum_o=
bj[elem + pos_values].string.length,
> > > > +                                                            &str_v=
alue, &value_len);
> > > > +
> > > > +                             if (ret)
> > > > +                                     return -EINVAL;
> > > > +
> > > > +                             /*
> > > > +                              * ignore strings when possible value=
s size
> > > > +                              * is greater than MAX_VALUES_SIZE
> > > > +                              */
> > > > +                             if (size < MAX_VALUES_SIZE)
> > > > +                                     strscpy(enum_data->possible_v=
alues[pos_values],
> > > > +                                             str_value,
> > > > +                                             sizeof(enum_data->pos=
sible_values[pos_values]));
> > > > +                     }
> > > > +                     break;
> > > > +             default:
> > > > +                     pr_warn("Invalid element: %d found in Enumera=
tion attribute or data may be malformed\n", elem);
> > > > +                     break;
> > > > +             }
> > > > +
> > > > +             kfree(str_value);
> > > > +     }
> > > > +
> > > > +exit_enumeration_package:
> > > > +     kfree(str_value);
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +/**
> > > > + * hp_populate_enumeration_package_data() -
> > > > + * Populate all properties of an instance under enumeration attrib=
ute
> > > > + *
> > > > + * @enum_obj: ACPI object with enumeration data
> > > > + * @instance_id: The instance to enumerate
> > > > + * @attr_name_kobj: The parent kernel object
> > > > + */
> > > > +int hp_populate_enumeration_package_data(union acpi_object *enum_o=
bj,
> > > > +                                      int instance_id,
> > > > +                                      struct kobject *attr_name_ko=
bj)
> > > > +{
> > > > +     struct enumeration_data *enum_data =3D &bioscfg_drv.enumerati=
on_data[instance_id];
> > > > +
> > > > +     enum_data->attr_name_kobj =3D attr_name_kobj;
> > > > +
> > > > +     hp_populate_enumeration_elements_from_package(enum_obj,
> > > > +                                                   enum_obj->packa=
ge.count,
> > > > +                                                   instance_id);
> > > > +     hp_update_attribute_permissions(enum_data->common.is_readonly=
,
> > > > +                                     &enumeration_current_val);
> > > > +     /*
> > > > +      * Several attributes have names such "MONDAY". Friendly
> > > > +      * user nane is generated to make the name more descriptive
> > > > +      */
> > > > +     hp_friendly_user_name_update(enum_data->common.path,
> > > > +                                  attr_name_kobj->name,
> > > > +                                  enum_data->common.display_name,
> > > > +                                  sizeof(enum_data->common.display=
_name));
> > > > +     return sysfs_create_group(attr_name_kobj, &enumeration_attr_g=
roup);
> > > > +}
> > > > +
> > > > +static int hp_populate_enumeration_elements_from_buffer(u8 *buffer=
_ptr, u32 *buffer_size,
> > > > +                                                     int instance_=
id)
> > > > +{
> > > > +     int reqs;
> > > > +     int values;
> > > > +     struct enumeration_data *enum_data =3D &bioscfg_drv.enumerati=
on_data[instance_id];
> > > > +
> > > > +     /*
> > > > +      * In earlier implementation, reported errors were ignored
> > > > +      * causing the data to remain uninitialized. It is for this
> > > > +      * reason functions may return an error and no validation
> > > > +      * takes place.
> > > > +      */
> > >
> > > Where is this error returned?
> >
> > functions such hp_get_string_from_buffer, hp_get_integer_from_buffer
>
> But the errors returned from those functions are just thrown away, no?

Earlier in the code, failures reported for a particular attribute
value were ignored because each value is independent from each other.
It is for this reason, we are throwing away any errors returned from
those functions.

> > >
> > > > +
> > > > +     // VALUE:
> > > > +     hp_get_string_from_buffer(&buffer_ptr, buffer_size, enum_data=
->current_value,
> > > > +                               sizeof(enum_data->current_value));
> > > > +
> > > > +     // PATH:
> > > > +     hp_get_string_from_buffer(&buffer_ptr, buffer_size, enum_data=
->common.path,
> > > > +                               sizeof(enum_data->common.path));
> > > > +
> > > > +     // IS_READONLY:
> > > > +     hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
> > > > +                                &enum_data->common.is_readonly);
> > > > +
> > > > +     //DISPLAY_IN_UI:
> > > > +     hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
> > > > +                                &enum_data->common.display_in_ui);
> > > > +
> > > > +     // REQUIRES_PHYSICAL_PRESENCE:
> > > > +     hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
> > > > +                                &enum_data->common.requires_physic=
al_presence);
> > > > +
> > > > +     // SEQUENCE:
> > > > +     hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
> > > > +                                &enum_data->common.sequence);
> > > > +
> > > > +     // PREREQUISITES_SIZE:
> > > > +     hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
> > > > +                                &enum_data->common.prerequisites_s=
ize);
> > > > +
> > > > +     if (enum_data->common.prerequisites_size > MAX_PREREQUISITES_=
SIZE) {
> > > > +             /* Report a message and limit prerequisite size to ma=
ximum value */
> > > > +             pr_warn("Enum Prerequisites size value exceeded the m=
aximum number of elements supported or data may be malformed\n");
> > > > +             enum_data->common.prerequisites_size =3D MAX_PREREQUI=
SITES_SIZE;
> > > > +     }
> > > > +
> > > > +     // PREREQUISITES:
> > > > +     for (reqs =3D 0; reqs < enum_data->common.prerequisites_size;=
 reqs++)
> > > > +             hp_get_string_from_buffer(&buffer_ptr, buffer_size,
> > > > +                                       enum_data->common.prerequis=
ites[reqs],
> > > > +                                       sizeof(enum_data->common.pr=
erequisites[reqs]));
> > > > +
> > > > +     // SECURITY_LEVEL:
> > > > +     hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
> > > > +                                &enum_data->common.security_level)=
;
> > >
> > > The reading of all the common elemtns can be extracted into a helper
> > > and reused from all the attributes.
> >
> > Is extracting all common elements into a helper routine absolutely
> > necessary now or can it be refactored after driver is accepted?
>
> It's not necessary.

Thank you
>
> > >
> > > > +
> > > > +     // ENUM_CURRENT_VALUE:
> > > > +     hp_get_string_from_buffer(&buffer_ptr, buffer_size,
> > > > +                               enum_data->current_value,
> > > > +                               sizeof(enum_data->current_value));
> > > > +     // ENUM_SIZE:
> > > > +     hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
> > > > +                                &enum_data->possible_values_size);
> > > > +
> > > > +     if (enum_data->possible_values_size > MAX_VALUES_SIZE) {
> > > > +             /* Report a message and limit possible values size to=
 maximum value */
> > > > +             pr_warn("Enum Possible size value exceeded the maximu=
m number of elements supported or data may be malformed\n");
> > > > +             enum_data->possible_values_size =3D MAX_VALUES_SIZE;
> > > > +     }
> > > > +
> > > > +     // ENUM_POSSIBLE_VALUES:
> > > > +
> > > > +     for (values =3D 0; values < enum_data->possible_values_size; =
values++)
> > > > +             hp_get_string_from_buffer(&buffer_ptr, buffer_size,
> > > > +                                       enum_data->possible_values[=
values],
> > > > +                                       sizeof(enum_data->possible_=
values[values]));
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +/**
> > > > + * hp_populate_enumeration_buffer_data() -
> > > > + * Populate all properties of an instance under enumeration attrib=
ute
> > > > + *
> > > > + * @buffer_ptr: Buffer pointer
> > > > + * @buffer_size: Buffer size
> > > > + * @instance_id: The instance to enumerate
> > > > + * @attr_name_kobj: The parent kernel object
> > > > + */
> > > > +int hp_populate_enumeration_buffer_data(u8 *buffer_ptr, u32 *buffe=
r_size,
> > > > +                                     int instance_id,
> > > > +                                     struct kobject *attr_name_kob=
j)
> > > > +{
> > > > +     struct enumeration_data *enum_data =3D &bioscfg_drv.enumerati=
on_data[instance_id];
> > > > +
> > > > +     enum_data->attr_name_kobj =3D attr_name_kobj;
> > > > +
> > > > +     /* Populate enumeration elements */
> > > > +     hp_populate_enumeration_elements_from_buffer(buffer_ptr, buff=
er_size, instance_id);
> > > > +
> > > > +     hp_update_attribute_permissions(enum_data->common.is_readonly=
,
> > > > +                                     &enumeration_current_val);
> > > > +     /*
> > > > +      * Several attributes have names such "MONDAY". A Friendlier
> > > > +      * user nane is generated to make the name more descriptive
> > > > +      */
> > > > +     hp_friendly_user_name_update(enum_data->common.path,
> > > > +                                  attr_name_kobj->name,
> > > > +                                  enum_data->common.display_name,
> > > > +                                  sizeof(enum_data->common.display=
_name));
> > > > +
> > > > +     return sysfs_create_group(attr_name_kobj, &enumeration_attr_g=
roup);
> > > > +}
> > > > +
> > > > +/**
> > > > + * hp_exit_enumeration_attributes() - Clear all attribute data
> > > > + *
> > > > + * Clears all data allocated for this group of attributes
> > > > + */
> > > > +void hp_exit_enumeration_attributes(void)
> > > > +{
> > > > +     int instance_id;
> > > > +
> > > > +     for (instance_id =3D 0; instance_id < bioscfg_drv.enumeration=
_instances_count;
> > > > +          instance_id++) {
> > > > +             struct enumeration_data *enum_data =3D &bioscfg_drv.e=
numeration_data[instance_id];
> > > > +             struct kobject *attr_name_kobj =3D enum_data->attr_na=
me_kobj;
> > > > +
> > > > +             if (attr_name_kobj)
> > > > +                     sysfs_remove_group(attr_name_kobj, &enumerati=
on_attr_group);
> > > > +     }
> > > > +     bioscfg_drv.enumeration_instances_count =3D 0;
> > > > +
> > > > +     kfree(bioscfg_drv.enumeration_data);
> > > > +     bioscfg_drv.enumeration_data =3D NULL;
> > > > +}
> > > > --
> > > > 2.34.1
> > > >
