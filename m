Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5173D6F6F6D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 17:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjEDPwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 11:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjEDPwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 11:52:18 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418D555BD;
        Thu,  4 May 2023 08:52:17 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2ac836f4447so630051fa.2;
        Thu, 04 May 2023 08:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683215535; x=1685807535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLRcDLRAKnDzeIxGxA0njvlNmReV4kRXrEuPLmqEYZI=;
        b=H+6L9g1IK+A9XQ+DvbT+81La8CqSwH6EDwYVI1DZ9ZXWhpb2CSuDTMHuJOlBrt6FV8
         hIfXwo/DIVd9+N/Nlqb5xm6pW/nZXJTydbGubo1ejG3KU4r4NJE503wIiV2WQt1Xu1B1
         y4GV9AuZxJ3/4XSDxtA5AunaTutnV51CR01mmFXyUEPdMeKJOKubV3bqdgyqhZ8THN9f
         tHcGsVgENAXG691NY5raLtfn3s19ufCjUOIKRCBLAhFjxRbI4FiBmG3ib1Z02rkErKPC
         ACnL4tpNrSAf5G3MAqSaqN+l1qQI1j6ViHRlfjC3ur8dlpAQioaHl2Cd+oUtKRIWDjNu
         kaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683215535; x=1685807535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pLRcDLRAKnDzeIxGxA0njvlNmReV4kRXrEuPLmqEYZI=;
        b=Zf5IejV8yPKku/a5DTUVlAlp40UX7WFVofkFKQ9X5WzMPlzX+RsVZaGTiH6KqkLm7W
         XtEVXl8+T0oQv70M1I62WAxYzu6Xb/x/tQ45lmkDsP3i3vfnN7nv+qKbCBtASQCJl9Uw
         DVoPG5uM1sf8WuianWtYL7z8GYF2NSZWxPHGHBAvkHEs7C1nORLezhn84Pj5ijbTDZw4
         bEPD7kVCAtpD0oo2zExvf0GImnk2J/Qa1pPoVeL7AFNGM14brJl2EYeVeAXch77uHgwx
         4hL4BksUib9b1toSnypTXJmG2VMZx8y8+ht4ng2pKka2phH3FDBv9q90ttutUNln+cZ+
         PmvQ==
X-Gm-Message-State: AC+VfDx/9dWge9Kqkh5Loo/XXW4/2wDMW60bEkqRdLjgovI+iSl2tI7n
        8f7N3MS8d5Ob6pcy574YVu8F08+xVmp2+5KEHcdbAqOcH+w=
X-Google-Smtp-Source: ACHHUZ67OzVk754Ba+mAKQP4iIMO0pH1FrHC48B3tZd0EVMwEXEBzmo1s0rm2A+ZJkCsbdDqUtPk4I3wSKmhkMu1x64=
X-Received: by 2002:a2e:3518:0:b0:2ac:80cd:6c0d with SMTP id
 z24-20020a2e3518000000b002ac80cd6c0dmr606495ljz.19.1683215535386; Thu, 04 May
 2023 08:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230420165454.9517-1-jorge.lopez2@hp.com> <20230420165454.9517-10-jorge.lopez2@hp.com>
 <951adb9c-dd5c-4c40-a786-2025ebe1650f@t-8ch.de> <CAOOmCE-dVzSrjWDx=tcXP-f+4NuN-U_-sc_QaLRt1qjtjaVVGw@mail.gmail.com>
 <bb7ca13b-bef2-459a-aa11-bfbae1ee81bd@t-8ch.de>
In-Reply-To: <bb7ca13b-bef2-459a-aa11-bfbae1ee81bd@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Thu, 4 May 2023 10:51:48 -0500
Message-ID: <CAOOmCE8RQ5x2+eGSEZwBkoj1oQzY=VCrZf8vaWnY9+QT_P+tcg@mail.gmail.com>
Subject: Re: [PATCH v11 09/14] HP BIOSCFG driver - enum-attributes
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

On Wed, May 3, 2023 at 3:10=E2=80=AFPM Thomas Wei=C3=9Fschuh <thomas@t-8ch.=
de> wrote:
>
> On 2023-05-03 14:42:37-0500, Jorge Lopez wrote:
> > On Sun, Apr 23, 2023 at 7:55=E2=80=AFAM Thomas Wei=C3=9Fschuh <thomas@t=
-8ch.de> wrote:
> > >
> > > On 2023-04-20 11:54:49-0500, Jorge Lopez wrote:
> > > >  .../x86/hp/hp-bioscfg/enum-attributes.c       | 543 ++++++++++++++=
++++
> > > >  1 file changed, 543 insertions(+)
> > > >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/enum-attribu=
tes.c
> > > >
> > > > diff --git a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c b=
/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
>
> <snip>
>
> > > > +/*
> > > > + * validate_enumeration_input() -
> > > > + * Validate input of current_value against possible values
> > > > + *
> > > > + * @instance_id: The instance on which input is validated
> > > > + * @buf: Input value
> > > > + */
> > > > +static int validate_enumeration_input(int instance_id, const char =
*buf)
> > > > +{
> > > > +     int ret =3D 0;
> > > > +     int found =3D 0;
> > > > +     int i;
> > > > +     int possible_values;
> > > > +
> > > > +     /* Is it a read only attribute */
> > > > +     if (bioscfg_drv.enumeration_data[instance_id].common.is_reado=
nly)
> > > > +             return -EIO;
> > > > +
> > > > +     possible_values =3D bioscfg_drv.enumeration_data[instance_id]=
.possible_values_size;
> > > > +     for (i =3D 0; i < possible_values && !found; i++)
> > > > +             if (!strcasecmp(bioscfg_drv.enumeration_data[instance=
_id].possible_values[i], buf))
> > >
> > > Is this also intentionally case-insensitive?
> >
> > Yes
>
> Why? It is surprising.
>
> The behavior differs from sysfs_match_string() and friends.
> Thinking about it, this function should be able to use
> __sysfs_match_string().
>
> (Same for the ordered list type)
>

I will not be able to use  sysfs_match_string() for the conditions on
how the possible values are read and allocated by hp-bioscfg driver.

1. sysfs_match_string() expects the array to be defined as  const char
* const  array.  This definition is possible if the values are
statically assigned but not when the values are dynamically allocated.

const char * const possible_values[] =3D {
         [VALUE1] =3D "Enable",
         [VALUE2] =3D "Disable",
};
...
ret =3D sysfs_match_string(possible_values, buf);

2. sysfs_match_string() returns error EINVAL if the string case does
not match.   sysfs_match_string() string comparison is case sensitive.

3. BIOS rejects data if the data is not case sensitive nor matches
either one of the reported possible values.


> <snip>
