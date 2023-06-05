Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B2872289E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbjFEOSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbjFEOSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:18:33 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04349C;
        Mon,  5 Jun 2023 07:18:30 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b1a46ad09fso57072501fa.2;
        Mon, 05 Jun 2023 07:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685974709; x=1688566709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euE2LLIwKx6OxWIB9svhYE3OVw9CdYqHRBxrFfXwQYA=;
        b=bwOS2R/pWoeBIpKbONBd2nKKRwvEcFoPMJmlTaDTqicrMUe7kOXC/HJcUt6gtTN1nL
         hOYI/6UqCioQ5sC4tl2f6rBjPc6vErCWJHz1iJxHtbWTJxyHJFB28/Bm58g4CNItPP8q
         ZjN6mKsMjkxdEXfoJq4IpvvbJINNBpwH9VdtnghUGAtn9rZOU2jN18w3CBOloGTGa8Uj
         9GHI2CLH6KJ/PTC2TCRpC3kO9KvkkV2iuVLCM9uEYt+r38W7XTpZyatoFaYfcJ6fCJ9l
         I4Ktvr63fvxB7nYsciuCc0zhayoJzq+LYmi8Ptr2bPfT4+kUI38/mt6oma2zRTPvJ21u
         eN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685974709; x=1688566709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=euE2LLIwKx6OxWIB9svhYE3OVw9CdYqHRBxrFfXwQYA=;
        b=RgLI8NOT6YbtFUBodAfjFAbHedPEIhCLX/SCv9/sHxBYeS80FWwu2lQ5ztwOMxhcKP
         5WdHxvIg4otl6xYj8pPM95DIdaQ4qVWyDxwmoiq9khZOd04g0pxV9Ue1XUqEzZA/0M+j
         eHH+UjFblOXqZDUNrlQJyRMtbLnvL6Mh4b3AWBcBG7+zI2F+sm2jzz182oOOKXvKrxCJ
         y0XAqPpZj07xeq+2cakbcaDOiJdOPl+QkRkiAz2B7InlJcAZ8kd0vMwM7/teYVYZWL/d
         uHDsnEquqMS6SRJRXHy0MDNn1FQpFSZu10CiUCFFCH2ttggFZEr626XxuF7KCravLJRn
         HoGg==
X-Gm-Message-State: AC+VfDwrClwtVBQTmN+ILXRldUHdgoqVdz9xuMxOFxz83SkBAHWE3pCO
        +jrevxs4jpgtaBSSsKZn+rsAUI4vPm7KJ9SUHA0=
X-Google-Smtp-Source: ACHHUZ7bttnRtxr9aXOWPQU8lXcC/E38B3z8oowg7XwbCXRBhsCgfQhMlClwG3Aw4hmpTMHPAxUDbz9jvuepDUFX2wg=
X-Received: by 2002:a2e:a28f:0:b0:2b1:b11f:1f2c with SMTP id
 k15-20020a2ea28f000000b002b1b11f1f2cmr3691920lja.25.1685974708550; Mon, 05
 Jun 2023 07:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230519201300.12964-1-jorge.lopez2@hp.com> <20230519201300.12964-6-jorge.lopez2@hp.com>
 <0cbd158e-0742-4e04-9996-bd376f9b555b@t-8ch.de> <CAOOmCE8=C_qH862G9sdLS59=QPh6U_78WY0SzJwzZfW+iSUiPA@mail.gmail.com>
 <dd9df9e7-9693-4ddc-8429-cc5e0567da17@t-8ch.de> <CAOOmCE_=LH9rcz4x=q-iq8sBhC4G7TtaU5M_R-ZLWwaJYNadSw@mail.gmail.com>
 <f53ddc7e-40d7-487d-9eff-1ee9fe2fcd9b@t-8ch.de>
In-Reply-To: <f53ddc7e-40d7-487d-9eff-1ee9fe2fcd9b@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Mon, 5 Jun 2023 09:17:51 -0500
Message-ID: <CAOOmCE9bLcbfGoRrQSj1Ot0bZmDGJuggrN0G-KFSe8Tpa_4=PA@mail.gmail.com>
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

On Sat, Jun 3, 2023 at 1:35=E2=80=AFAM Thomas Wei=C3=9Fschuh <thomas@t-8ch.=
de> wrote:
>
> On 2023-05-31 10:59:58-0500, Jorge Lopez wrote:
> > On Tue, May 30, 2023 at 4:42=E2=80=AFPM Thomas Wei=C3=9Fschuh <thomas@t=
-8ch.de> wrote:
> > >
> > > On 2023-05-30 12:01:57-0500, Jorge Lopez wrote:
> > > > On Fri, May 26, 2023 at 10:35=E2=80=AFAM Thomas Wei=C3=9Fschuh <tho=
mas@t-8ch.de> wrote:
> > > > >
> > > > > On 2023-05-19 15:12:52-0500, Jorge Lopez wrote:
> > > > >
> > > > > <snip>
> > > > >
> > > > > >  .../x86/hp/hp-bioscfg/enum-attributes.c       | 465 ++++++++++=
++++++++
> > > > > >  1 file changed, 465 insertions(+)
> > > > > >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/enum-att=
ributes.c
> > > > > >
> > > > > > diff --git a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes=
.c b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
> > > > > > new file mode 100644
> > > > > > index 000000000000..80842835606d
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
> > > > > > @@ -0,0 +1,465 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > > +/*
> > > > > > + * Functions corresponding to enumeration type attributes unde=
r
> > > > > > + * BIOS Enumeration GUID for use with hp-bioscfg driver.
> > > > > > + *
> > > > > > + * Copyright (c) 2022 HP Development Company, L.P.
> > > > > > + */
> > > > > > +
> > > > > > +#include "bioscfg.h"
> > > > > > +
> > > > > > +GET_INSTANCE_ID(enumeration);
> > > > > > +
> > > > > > +static ssize_t current_value_show(struct kobject *kobj, struct=
 kobj_attribute *attr, char *buf)
> > > > > > +{
> > > > > > +     int instance_id =3D get_enumeration_instance_id(kobj);
> > > > > > +
> > > > > > +     if (instance_id < 0)
> > > > > > +             return -EIO;
> > > > > > +
> > > > > > +     return sysfs_emit(buf, "%s\n",
> > > > > > +                      bioscfg_drv.enumeration_data[instance_id=
].current_value);
> > > > > > +}
> > > > > > +
> > > > > > +/**
> > > > > > + * validate_enumeration_input() -
> > > > > > + * Validate input of current_value against possible values
> > > > > > + *
> > > > > > + * @instance_id: The instance on which input is validated
> > > > > > + * @buf: Input value
> > > > > > + */
> > > >
> > > > <snip>
> > > >
> > > > > > +static int hp_populate_enumeration_elements_from_package(union=
 acpi_object *enum_obj,
> > > > > > +                                                      int enum=
_obj_count,
> > > > > > +                                                      int inst=
ance_id)
> > > > > > +{
> > > > > > +     char *str_value =3D NULL;
> > > > > > +     int value_len;
> > > > > > +     u32 size =3D 0;
> > > > > > +     u32 int_value;
> > > > > > +     int elem =3D 0;
> > > > > > +     int reqs;
> > > > > > +     int pos_values;
> > > > > > +     int ret;
> > > > > > +     int eloc;
> > > > > > +     struct enumeration_data *enum_data =3D &bioscfg_drv.enume=
ration_data[instance_id];
> > > > > > +
> > > > > > +     for (elem =3D 1, eloc =3D 1; elem < enum_obj_count; elem+=
+, eloc++) {
> > > > > > +             /* ONLY look at the first ENUM_ELEM_CNT elements =
*/
> > > > > > +             if (eloc =3D=3D ENUM_ELEM_CNT)
> > > > > > +                     goto exit_enumeration_package;
> > > > > > +
> > > > > > +             switch (enum_obj[elem].type) {
> > > > > > +             case ACPI_TYPE_STRING:
> > > > > > +                     if (PREREQUISITES !=3D elem && ENUM_POSSI=
BLE_VALUES !=3D elem) {
> > > > > > +                             ret =3D hp_convert_hexstr_to_str(=
enum_obj[elem].string.pointer,
> > > > > > +                                                            en=
um_obj[elem].string.length,
> > > > > > +                                                            &s=
tr_value, &value_len);
> > > > > > +                             if (ret)
> > > > > > +                                     return -EINVAL;
> > > > > > +                     }
> > > > > > +                     break;
> > > > > > +             case ACPI_TYPE_INTEGER:
> > > > > > +                     int_value =3D (u32)enum_obj[elem].integer=
.value;
> > > > > > +                     break;
> > > > > > +             default:
> > > > > > +                     pr_warn("Unsupported object type [%d]\n",=
 enum_obj[elem].type);
> > > > > > +                     continue;
> > > > > > +             }
> > > > > > +
> > > > > > +             /* Check that both expected and read object type =
match */
> > > > > > +             if (expected_enum_types[eloc] !=3D enum_obj[elem]=
.type) {
> > > > > > +                     pr_err("Error expected type %d for elem %=
d, but got type %d instead\n",
> > > > > > +                            expected_enum_types[eloc], elem, e=
num_obj[elem].type);
> > > > > > +                     return -EIO;
> > > > > > +             }
> > > > > > +
> > > > > > +             /* Assign appropriate element value to correspond=
ing field */
> > > > > > +             switch (eloc) {
> > > > > > +             case NAME:
> > > > > > +             case VALUE:
> > > > > > +                     break;
> > > > > > +             case PATH:
> > > > > > +                     strscpy(enum_data->common.path, str_value=
,
> > > > > > +                             sizeof(enum_data->common.path));
> > > > > > +                     break;
> > > > > > +             case IS_READONLY:
> > > > > > +                     enum_data->common.is_readonly =3D int_val=
ue;
> > > > > > +                     break;
> > > > > > +             case DISPLAY_IN_UI:
> > > > > > +                     enum_data->common.display_in_ui =3D int_v=
alue;
> > > > > > +                     break;
> > > > > > +             case REQUIRES_PHYSICAL_PRESENCE:
> > > > > > +                     enum_data->common.requires_physical_prese=
nce =3D int_value;
> > > > > > +                     break;
> > > > > > +             case SEQUENCE:
> > > > > > +                     enum_data->common.sequence =3D int_value;
> > > > > > +                     break;
> > > > > > +             case PREREQUISITES_SIZE:
> > > > > > +                     enum_data->common.prerequisites_size =3D =
int_value;
> > > > > > +                     if (int_value > MAX_PREREQUISITES_SIZE)
> > > > > > +                             pr_warn("Prerequisites size value=
 exceeded the maximum number of elements supported or data may be malformed=
\n");
> > > > > > +
> > > > > > +                     /*
> > > > > > +                      * This HACK is needed to keep the expect=
ed
> > > > > > +                      * element list pointing to the right obj=
[elem].type
> > > > > > +                      * when the size is zero. PREREQUISITES
> > > > > > +                      * object is omitted by BIOS when the siz=
e is
> > > > > > +                      * zero.
> > > > > > +                      */
> > > > > > +                     if (int_value =3D=3D 0)
> > > > > > +                             eloc++;
> > > > > > +                     break;
> > > > > > +
> > > > > > +             case PREREQUISITES:
> > > > > > +                     size =3D min_t(u32, enum_data->common.pre=
requisites_size, MAX_PREREQUISITES_SIZE);
> > > > >
> > > > > We cannot blindly truncate this to a maximum value.
> > > > > The firmware reported an amount of elements it would return.
> > > > >
> > > > > If this value is to big than we can not just intpret the data as =
if it
> > > > > was something the firmware did not return.
> > > > >
> > > > > An error needs to be reported to userspace.
> > > > > A default value is not enough as userspace can not interpret this
> > > > > properly.
> > > > >
> > > >
> > > > It is ok to truncate prerequisite size to MAX_PREREQUISITES_SIZE.
> > > > MAX_PREREQUISITES_SIZE is a value predefined by BIOS when the
> > > > prerequisite values size is invalid ( > MAX_PREREQUISITES_SIZE) and=
/or
> > > > the prerequisite data is corrupted.
> > > > Neither PREREQUISITES nor PREREQUISITES_SIZE are reported to the
> > > > userspace so there is no need to report a failure on data that is n=
ot
> > > > exposed.  One item that needs clarification is the fact that
> > > > regardless if  PREREQUISITES or PREREQUISITES_SIZE are invalid, tha=
t
> > > > does not mean other values are invalid.  It is for this reason, we
> > > > need to continue to read all remaining packages.
> > >
> > > It may be that prerequisites are not reported to userspace.
> > > But the following values are:
> > >
> > > security level, current value and possible values.
> > >
> > > And if prerequisites are garbage then those are now also garbage.
> >
> > This statement is not correct.  Each attribute value is isolated from
> > each other hence it only affects a single value and does not impact
> > the following values such security level, current value and possible
> > values
>
> Indeed, I stand corrected.
> I guess the loop-based logic is still confusing me.
>
> > Here is a sample where the prerequisite_size is invalid but the
> > prerequisites, security, string min value and string max value are
> > correct.
> >
> > 8003.571287] Attribute: HP_Disk0MapForUefiBootOrder    Prerequisite_siz=
e 3145848
> > [ 8003.571287] String Prerequisites size value exceeded the maximum
> > number of elements supported or data may be malformed
> >
> > [ 8003.571288] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[0]
> > /Pci(0x1F,0x6)/MAC(3
> > [ 8003.571288] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[1]
> > 24D33F453F,0x0)/IPv6(000
> > [ 8003.571289] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[2]
> > :0000:0000:0000:0000:000
> > [ 8003.571290] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[3]
> > :0000:0000,0x0,Static,00
> > [ 8003.571290] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[4]
> > 0:0000:0000:0000:0000:00
> > [ 8003.571291] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[5]
> > 0:0000:0000,0x40,0000:00
> > [ 8003.571291] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[6]
> > 0:0000:0000:0000:0000:00
> > [ 8003.571292] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[7]
> > 0:0000)\r\n\tPciRoot(0x0)/P
> > [ 8003.571292] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[8]
> > i(0x0,0x0)/IPv4(0.0.0.0,0x0,DHCP,0.0.0.0,0.0.0.0,
> > [ 8003.571293] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[9]
> > .0.0.0)\r\n\tPciRoot(0x0)/P
> > [ 8003.571293] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[10]
> > i(0x0,0x0)/IPv6(0000:0000:0000:0000:0000:0000:000
> > [ 8003.571294] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[11]
> > :0000,0x0,Static,0000:00
> > [ 8003.571295] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[12]
> > 0:0000:0000:0000:0000:00
> > [ 8003.571295] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[13]
> > 0:0000,0x0,0000:0000:000
> > [ 8003.571296] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[14]
> > :0000:0000:0000:0000:000
> > [ 8003.571296] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[15] =
)
> > [ 8003.571297] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[16]
> > [ 8003.571297] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[17]
> > [ 8003.571298] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[18]
> > [ 8003.571298] Attribute: HP_Disk0MapForUefiBootOrder Prerequisite[19]
> >
> > [ 8003.571298] Attribute: HP_Disk0MapForUefiBootOrder Security 0
> > [ 8003.571299] Attribute: HP_Disk0MapForUefiBootOrder String Min Length=
  0
> > [ 8003.571299] Attribute: HP_Disk0MapForUefiBootOrder String Max Length=
  0
> >
> >
> > >
> > > hp_populate_enumeration_package_data() always returns "0".
> >
> > Earlier in the code, failures reported for a particular attribute
> > value were ignored because each value is independent from each other.
> > It is up to the user space application to analyze the raw data read fro=
m BIOS.
>
> Please remember that this API will not only be used by HPs own userspace
> component.
>
> Where are the rules for userspace documented to analyze the raw data and =
recognize
> an error?
> Looking at the kernel log is not enough, it is not an API.

Completely agree.  At this time, Linux Security components are under
development and not published yet.
The only linux component is the driver (hp bioscfg) at this time.
Other published security components are under Windows.

Both Linux and Windows drivers return the data from BIOS as is and
either one can determine if the data is valid or not.
I have an idea how the data available to the user can be saved and
reported as an error when read by the userspace component from sysfs.
This solution will not change the way data is read or return value is
reported by hp_populate_enumeration_package_data().
Let me think about it and will get back to you.

>
> > >
> > > > In earlier reviews, it was agreed to report a warning  that reads
> > > >
> > > > /* Report a message and limit prerequisite size to maximum value */
> > > > pr_warn("Enum Prerequisites size value exceeded the maximum number =
of
> > > > elements supported or data may be malformed\n");
> > > >
> > > > See lines 370-374
> > > >
> > > > > (Affects all attributes)
> > > > >
> > > > > > +                     for (reqs =3D 0; reqs < size; reqs++) {
> > > > > > +                             if (elem >=3D enum_obj_count) {
> > > > > > +                                     pr_err("Error enum-object=
s package is too small\n");
> > > > > > +                                     return -EINVAL;
> > > > > > +                             }
> > > > > > +
> > > > > > +                             ret =3D hp_convert_hexstr_to_str(=
enum_obj[elem + reqs].string.pointer,
> > > > > > +                                                            en=
um_obj[elem + reqs].string.length,
> > > > > > +                                                            &s=
tr_value, &value_len);
> > > > > > +
> > > > > > +                             if (ret)
> > > > > > +                                     return -EINVAL;
> > > > > > +
> > > > > > +                             strscpy(enum_data->common.prerequ=
isites[reqs],
> > > > > > +                                     str_value,
> > > > > > +                                     sizeof(enum_data->common.=
prerequisites[reqs]));
> > > > > > +
> > > > > > +                             kfree(str_value);
> > > > > > +                     }
> > > > > > +                     break;
> > > > > > +
> > > > > > +             case SECURITY_LEVEL:
> > > > > > +                     enum_data->common.security_level =3D int_=
value;
> > > > > > +                     break;
> > > > > > +
> > > > > > +             case ENUM_CURRENT_VALUE:
> > > > > > +                     strscpy(enum_data->current_value,
> > > > > > +                             str_value, sizeof(enum_data->curr=
ent_value));
> > > > > > +                     break;
> > > > > > +             case ENUM_SIZE:
> > > > > > +                     enum_data->possible_values_size =3D int_v=
alue;
> > > > > > +                     if (int_value > MAX_VALUES_SIZE)
> > > > > > +                             pr_warn("Possible number values s=
ize value exceeded the maximum number of elements supported or data may be =
malformed\n");
> > > > > > +
> > > > > > +                     /*
> > > > > > +                      * This HACK is needed to keep the expect=
ed
> > > > > > +                      * element list pointing to the right obj=
[elem].type
> > > > > > +                      * when the size is zero. POSSIBLE_VALUES
> > > > > > +                      * object is omitted by BIOS when the siz=
e is zero.
> > > > > > +                      */
> > > > > > +                     if (int_value =3D=3D 0)
> > > > > > +                             eloc++;
> > > > > > +                     break;
> > > > > > +
> > > > > > +             case ENUM_POSSIBLE_VALUES:
> > > > > > +                     size =3D enum_data->possible_values_size;
> > > > > > +
> > > > > > +                     for (pos_values =3D 0; pos_values < size =
&& pos_values < MAX_VALUES_SIZE;
> > > > > > +                          pos_values++) {
> > > > > > +                             if (elem >=3D enum_obj_count) {
> > > > > > +                                     pr_err("Error enum-object=
s package is too small\n");
> > > > > > +                                     return -EINVAL;
> > > > > > +                             }
> > > > > > +
> > > > > > +                             ret =3D hp_convert_hexstr_to_str(=
enum_obj[elem + pos_values].string.pointer,
> > > > > > +                                                            en=
um_obj[elem + pos_values].string.length,
> > > > > > +                                                            &s=
tr_value, &value_len);
> > > > > > +
> > > > > > +                             if (ret)
> > > > > > +                                     return -EINVAL;
> > > > > > +
> > > > > > +                             /*
> > > > > > +                              * ignore strings when possible v=
alues size
> > > > > > +                              * is greater than MAX_VALUES_SIZ=
E
> > > > > > +                              */
> > > > > > +                             if (size < MAX_VALUES_SIZE)
> > > > > > +                                     strscpy(enum_data->possib=
le_values[pos_values],
> > > > > > +                                             str_value,
> > > > > > +                                             sizeof(enum_data-=
>possible_values[pos_values]));
> > > > > > +                     }
> > > > > > +                     break;
> > > > > > +             default:
> > > > > > +                     pr_warn("Invalid element: %d found in Enu=
meration attribute or data may be malformed\n", elem);
> > > > > > +                     break;
> > > > > > +             }
> > > > > > +
> > > > > > +             kfree(str_value);
> > > > > > +     }
> > > > > > +
> > > > > > +exit_enumeration_package:
> > > > > > +     kfree(str_value);
> > > > > > +     return 0;
> > > > > > +}
> > > > > > +
> > > > > > +/**
> > > > > > + * hp_populate_enumeration_package_data() -
> > > > > > + * Populate all properties of an instance under enumeration at=
tribute
> > > > > > + *
> > > > > > + * @enum_obj: ACPI object with enumeration data
> > > > > > + * @instance_id: The instance to enumerate
> > > > > > + * @attr_name_kobj: The parent kernel object
> > > > > > + */
> > > > > > +int hp_populate_enumeration_package_data(union acpi_object *en=
um_obj,
> > > > > > +                                      int instance_id,
> > > > > > +                                      struct kobject *attr_nam=
e_kobj)
> > > > > > +{
> > > > > > +     struct enumeration_data *enum_data =3D &bioscfg_drv.enume=
ration_data[instance_id];
> > > > > > +
> > > > > > +     enum_data->attr_name_kobj =3D attr_name_kobj;
> > > > > > +
> > > > > > +     hp_populate_enumeration_elements_from_package(enum_obj,
> > > > > > +                                                   enum_obj->p=
ackage.count,
> > > > > > +                                                   instance_id=
);
> > > > > > +     hp_update_attribute_permissions(enum_data->common.is_read=
only,
> > > > > > +                                     &enumeration_current_val)=
;
> > > > > > +     /*
> > > > > > +      * Several attributes have names such "MONDAY". Friendly
> > > > > > +      * user nane is generated to make the name more descripti=
ve
> > > > > > +      */
> > > > > > +     hp_friendly_user_name_update(enum_data->common.path,
> > > > > > +                                  attr_name_kobj->name,
> > > > > > +                                  enum_data->common.display_na=
me,
> > > > > > +                                  sizeof(enum_data->common.dis=
play_name));
> > > > > > +     return sysfs_create_group(attr_name_kobj, &enumeration_at=
tr_group);
> > > > > > +}
> > > > > > +
> > > > > > +static int hp_populate_enumeration_elements_from_buffer(u8 *bu=
ffer_ptr, u32 *buffer_size,
> > > > > > +                                                     int insta=
nce_id)
> > > > > > +{
> > > > > > +     int reqs;
> > > > > > +     int values;
> > > > > > +     struct enumeration_data *enum_data =3D &bioscfg_drv.enume=
ration_data[instance_id];
> > > > > > +
> > > > > > +     /*
> > > > > > +      * In earlier implementation, reported errors were ignore=
d
> > > > > > +      * causing the data to remain uninitialized. It is for th=
is
> > > > > > +      * reason functions may return an error and no validation
> > > > > > +      * takes place.
> > > > > > +      */
> > > > >
> > > > > Where is this error returned?
> > > >
> > > > functions such hp_get_string_from_buffer, hp_get_integer_from_buffe=
r
> > >
> > > But the errors returned from those functions are just thrown away, no=
?
> >
> > Earlier in the code, failures reported for a particular attribute
> > value were ignored because each value is independent from each other.
> > It is for this reason, we are throwing away any errors returned from
> > those functions.
> >
> > > > >
> > > > > > +
> > > > > > +     // VALUE:
> > > > > > +     hp_get_string_from_buffer(&buffer_ptr, buffer_size, enum_=
data->current_value,
> > > > > > +                               sizeof(enum_data->current_value=
));
> > > > > > +
> > > > > > +     // PATH:
> > > > > > +     hp_get_string_from_buffer(&buffer_ptr, buffer_size, enum_=
data->common.path,
> > > > > > +                               sizeof(enum_data->common.path))=
;
> > > > > > +
> > > > > > +     // IS_READONLY:
> > > > > > +     hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
> > > > > > +                                &enum_data->common.is_readonly=
);
> > > > > > +
> > > > > > +     //DISPLAY_IN_UI:
> > > > > > +     hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
> > > > > > +                                &enum_data->common.display_in_=
ui);
> > > > > > +
> > > > > > +     // REQUIRES_PHYSICAL_PRESENCE:
> > > > > > +     hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
> > > > > > +                                &enum_data->common.requires_ph=
ysical_presence);
> > > > > > +
> > > > > > +     // SEQUENCE:
> > > > > > +     hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
> > > > > > +                                &enum_data->common.sequence);
> > > > > > +
> > > > > > +     // PREREQUISITES_SIZE:
> > > > > > +     hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
> > > > > > +                                &enum_data->common.prerequisit=
es_size);
> > > > > > +
> > > > > > +     if (enum_data->common.prerequisites_size > MAX_PREREQUISI=
TES_SIZE) {
> > > > > > +             /* Report a message and limit prerequisite size t=
o maximum value */
> > > > > > +             pr_warn("Enum Prerequisites size value exceeded t=
he maximum number of elements supported or data may be malformed\n");
> > > > > > +             enum_data->common.prerequisites_size =3D MAX_PRER=
EQUISITES_SIZE;
> > > > > > +     }
> > > > > > +
> > > > > > +     // PREREQUISITES:
> > > > > > +     for (reqs =3D 0; reqs < enum_data->common.prerequisites_s=
ize; reqs++)
> > > > > > +             hp_get_string_from_buffer(&buffer_ptr, buffer_siz=
e,
> > > > > > +                                       enum_data->common.prere=
quisites[reqs],
> > > > > > +                                       sizeof(enum_data->commo=
n.prerequisites[reqs]));
> > > > > > +
> > > > > > +     // SECURITY_LEVEL:
> > > > > > +     hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
> > > > > > +                                &enum_data->common.security_le=
vel);
> > > > >
> > > > > The reading of all the common elemtns can be extracted into a hel=
per
> > > > > and reused from all the attributes.
> > > >
> > > > Is extracting all common elements into a helper routine absolutely
> > > > necessary now or can it be refactored after driver is accepted?
> > >
> > > It's not necessary.
> >
> > Thank you
> > >
> > > > >
> > > > > > +
> > > > > > +     // ENUM_CURRENT_VALUE:
> > > > > > +     hp_get_string_from_buffer(&buffer_ptr, buffer_size,
> > > > > > +                               enum_data->current_value,
> > > > > > +                               sizeof(enum_data->current_value=
));
> > > > > > +     // ENUM_SIZE:
> > > > > > +     hp_get_integer_from_buffer(&buffer_ptr, buffer_size,
> > > > > > +                                &enum_data->possible_values_si=
ze);
> > > > > > +
> > > > > > +     if (enum_data->possible_values_size > MAX_VALUES_SIZE) {
> > > > > > +             /* Report a message and limit possible values siz=
e to maximum value */
> > > > > > +             pr_warn("Enum Possible size value exceeded the ma=
ximum number of elements supported or data may be malformed\n");
> > > > > > +             enum_data->possible_values_size =3D MAX_VALUES_SI=
ZE;
> > > > > > +     }
> > > > > > +
> > > > > > +     // ENUM_POSSIBLE_VALUES:
> > > > > > +
> > > > > > +     for (values =3D 0; values < enum_data->possible_values_si=
ze; values++)
> > > > > > +             hp_get_string_from_buffer(&buffer_ptr, buffer_siz=
e,
> > > > > > +                                       enum_data->possible_val=
ues[values],
> > > > > > +                                       sizeof(enum_data->possi=
ble_values[values]));
> > > > > > +
> > > > > > +     return 0;
> > > > > > +}
> > > > > > +
> > > > > > +/**
> > > > > > + * hp_populate_enumeration_buffer_data() -
> > > > > > + * Populate all properties of an instance under enumeration at=
tribute
> > > > > > + *
> > > > > > + * @buffer_ptr: Buffer pointer
> > > > > > + * @buffer_size: Buffer size
> > > > > > + * @instance_id: The instance to enumerate
> > > > > > + * @attr_name_kobj: The parent kernel object
> > > > > > + */
> > > > > > +int hp_populate_enumeration_buffer_data(u8 *buffer_ptr, u32 *b=
uffer_size,
> > > > > > +                                     int instance_id,
> > > > > > +                                     struct kobject *attr_name=
_kobj)
> > > > > > +{
> > > > > > +     struct enumeration_data *enum_data =3D &bioscfg_drv.enume=
ration_data[instance_id];
> > > > > > +
> > > > > > +     enum_data->attr_name_kobj =3D attr_name_kobj;
> > > > > > +
> > > > > > +     /* Populate enumeration elements */
> > > > > > +     hp_populate_enumeration_elements_from_buffer(buffer_ptr, =
buffer_size, instance_id);
> > > > > > +
> > > > > > +     hp_update_attribute_permissions(enum_data->common.is_read=
only,
> > > > > > +                                     &enumeration_current_val)=
;
> > > > > > +     /*
> > > > > > +      * Several attributes have names such "MONDAY". A Friendl=
ier
> > > > > > +      * user nane is generated to make the name more descripti=
ve
> > > > > > +      */
> > > > > > +     hp_friendly_user_name_update(enum_data->common.path,
> > > > > > +                                  attr_name_kobj->name,
> > > > > > +                                  enum_data->common.display_na=
me,
> > > > > > +                                  sizeof(enum_data->common.dis=
play_name));
> > > > > > +
> > > > > > +     return sysfs_create_group(attr_name_kobj, &enumeration_at=
tr_group);
> > > > > > +}
> > > > > > +
> > > > > > +/**
> > > > > > + * hp_exit_enumeration_attributes() - Clear all attribute data
> > > > > > + *
> > > > > > + * Clears all data allocated for this group of attributes
> > > > > > + */
> > > > > > +void hp_exit_enumeration_attributes(void)
> > > > > > +{
> > > > > > +     int instance_id;
> > > > > > +
> > > > > > +     for (instance_id =3D 0; instance_id < bioscfg_drv.enumera=
tion_instances_count;
> > > > > > +          instance_id++) {
> > > > > > +             struct enumeration_data *enum_data =3D &bioscfg_d=
rv.enumeration_data[instance_id];
> > > > > > +             struct kobject *attr_name_kobj =3D enum_data->att=
r_name_kobj;
> > > > > > +
> > > > > > +             if (attr_name_kobj)
> > > > > > +                     sysfs_remove_group(attr_name_kobj, &enume=
ration_attr_group);
> > > > > > +     }
> > > > > > +     bioscfg_drv.enumeration_instances_count =3D 0;
> > > > > > +
> > > > > > +     kfree(bioscfg_drv.enumeration_data);
> > > > > > +     bioscfg_drv.enumeration_data =3D NULL;
> > > > > > +}
> > > > > > --
> > > > > > 2.34.1
> > > > > >
