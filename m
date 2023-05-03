Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD7A6F6070
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 23:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjECVIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 17:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjECVIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 17:08:34 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833A97DB0;
        Wed,  3 May 2023 14:08:33 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4eff50911bfso6727646e87.2;
        Wed, 03 May 2023 14:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683148112; x=1685740112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEb3kPuS3fJNVGD00ZNK/EnPxaOujueiJ87hFJ+k1JM=;
        b=MHqvka/h+NlBABApiwQ11HEu7plNCUftelH0gYdJ8ykGNJwVj9c1uJ0GSReafYwmTX
         SmG3DRPJwU1yrz4SI0/yTU6SyfZvr0XKFie1IL2X7oVL6oWPWZBfw+qtxLUscFPggIJW
         StASkuLxLrJKy/y/ItTFaIFKNaIAK9quKoIs/Nr3AxZLRcnRxwEjZyzCwAmrUkSdK3ZQ
         0RYXTck6zA/VT0jzGoCAeheA1A23MstYNO2A0kglR1yZaw98d2HWtYs1j0DRQA6pHmG0
         M2cKEbz93tLMvNdFAY/OvGxMnzdWEq2Q4crNkee6e9GZcV3R1d3VVz96IUH4hNYlnoGW
         xYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683148112; x=1685740112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fEb3kPuS3fJNVGD00ZNK/EnPxaOujueiJ87hFJ+k1JM=;
        b=Fabk1/QyY4WOK5/rSna8Fb7XypzNnA7BFbz1ar/Kf/+Zw86x5lTV7qDrKKnMIZhZ58
         P2k9x4A1J+wIg6zNOEsKiUDTGBs5tPl26hCIYje2G86XzKHu+un1ByFcgKS874V2t/ZE
         0n9NPL6bxbajsV9ll4Fz+kd/t2CII83yRFi0EZGb5In44hKgQ3sIy7ixl4YZRec9IkrA
         wB2AUqZr140QHkxflv+5+g5mLSu5dGxMIh44m8vVXNwX1u/FUtj0u0Z8Mb4ZaRBn+bV1
         Vb06CGHD+loA1vSBX8imNsPGAuBjK9o5ESryoYl3jvSsE5rXiRvia64L4+E7VOxDiyGv
         a0UQ==
X-Gm-Message-State: AC+VfDy+nv2Cch/4SiPQcoHtJvqHlXl6+EYBBR4Kn13+7S1AbPMQqkCr
        17YCTLWV6CfTXijor17lWs9WN64wDTv4iXV0lhc=
X-Google-Smtp-Source: ACHHUZ4G8ko8KSjb2QpoIDv1sFAUHGQ+36fR0OsCBklVM8JehgtQsJEiZl3kPsx9UJ6pQADSwEl/a0SBXjZgmZy4HWQ=
X-Received: by 2002:ac2:4215:0:b0:4ef:f4ef:a1cc with SMTP id
 y21-20020ac24215000000b004eff4efa1ccmr1236718lfh.14.1683148111688; Wed, 03
 May 2023 14:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230420165454.9517-1-jorge.lopez2@hp.com> <20230420165454.9517-10-jorge.lopez2@hp.com>
 <951adb9c-dd5c-4c40-a786-2025ebe1650f@t-8ch.de> <CAOOmCE-dVzSrjWDx=tcXP-f+4NuN-U_-sc_QaLRt1qjtjaVVGw@mail.gmail.com>
 <bb7ca13b-bef2-459a-aa11-bfbae1ee81bd@t-8ch.de>
In-Reply-To: <bb7ca13b-bef2-459a-aa11-bfbae1ee81bd@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Wed, 3 May 2023 16:08:04 -0500
Message-ID: <CAOOmCE9VXRFXQN0dt4tgxtHhObhOML7vzaXWqNTR=RydaiyEYA@mail.gmail.com>
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
sysfs_match_string will compare the current value against all possible
values in the array.
I will use the recommended sysfs call.  I will need to do some testing
since the documentation is not explicitly of what comparison it does.

> (Same for the ordered list type)

Will do.
>
> <snip>
