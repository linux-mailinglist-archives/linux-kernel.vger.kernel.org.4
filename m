Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE4561E4EB
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 18:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiKFRfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 12:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiKFRfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 12:35:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA80F5FC4;
        Sun,  6 Nov 2022 09:35:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9261BB80C67;
        Sun,  6 Nov 2022 17:35:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC15CC433C1;
        Sun,  6 Nov 2022 17:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667756101;
        bh=K/R2PfBnRtCsPdAZPZWkG3dkqQSGM5S1L3bcvRE0TA0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AhOfN9x9Wk+g+kttu/Dm7IT/2nEpu5zYxweZ4l3TRPX1MqUem3+dz3I1Pzr4oZKS/
         1TY97crkR9Jwu2Tok0Qsz83J4sDdojqBZNTV7D9rVdIaCGbUL9WZtcr/jSUQUAf2VE
         ZLvriL+sB177lukgpffjDnvG7fKKc9wJmw+23da1iBKPv+EYh2dOqT1Ocii2+L562j
         zFaXk6ZqIpgZlHQPIKwlqGKHWHvmwSLWZVzkSBvvM/v/diOOpkHm/pVNYqdDa3O5Kd
         KWhqKa3zzJuEdqOjYUevPuOQU+2TgBrTXpYqueqzEiHvxMi0JOkRAVuWuD2pAu47Rk
         RyIjJoU+nJtDw==
Date:   Sun, 6 Nov 2022 17:34:51 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     Alejandro =?UTF-8?B?Q29uY2VwY2nDs24gUm9kcsOtZ3Vleg==?= 
        <asconcepcion@acoro.eu>, "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: light: apds9960: fix wrong register for gesture
 gain
Message-ID: <20221106173451.2e6e7ff0@jic23-huawei>
In-Reply-To: <CAJCx=gk0j-PT56yea_dEAT3=uBAfMebgvHf8D4yT9f7_4YAQhQ@mail.gmail.com>
References: <EaT-NKC-H4DNX5z4Lg9B6IWPD5TrTrYBr5DYB784wfDKQkTmzPXkoYqyUOrOgJH-xvTsEkFLcVkeAPZRUODEFI5dGziaWXwjpfBNLeNGfNc=@acoro.eu>
        <CAJCx=gk0j-PT56yea_dEAT3=uBAfMebgvHf8D4yT9f7_4YAQhQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Nov 2022 13:42:24 +0800
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> On Sun, Nov 6, 2022 at 9:56 AM Alejandro Concepci=C3=B3n Rodr=C3=ADguez
> <asconcepcion@acoro.eu> wrote:
> >
> > Gesture Gain Control is in REG_GCONF_2 (0xa3), not in REG_CONFIG_2 (0x9=
0).
> >
> > Fixes: aff268cd532e ("iio: light: add APDS9960 ALS + promixity driver")
> >
There shouldn't be any blank lines in the tags block.  I fixed this whilst =
applying. =20
>=20
> Good find. Odd that nobody ran into that issue before :/
>=20
> NOTE: Sorry for the double emails to some.. seems gmail dropped my
> Plain Text default setting and set it to HTML *sigh*
>=20
> Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>
>=20

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> > Signed-off-by: Alejandro Concepcion-Rodriguez <asconcepcion@acoro.eu>
> > ---
> >  drivers/iio/light/apds9960.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
> > index b62c139baf41..38d4c7644bef 100644
> > --- a/drivers/iio/light/apds9960.c
> > +++ b/drivers/iio/light/apds9960.c
> > @@ -54,9 +54,6 @@
> >  #define APDS9960_REG_CONTROL_PGAIN_MASK_SHIFT  2
> >
> >  #define APDS9960_REG_CONFIG_2  0x90
> > -#define APDS9960_REG_CONFIG_2_GGAIN_MASK       0x60
> > -#define APDS9960_REG_CONFIG_2_GGAIN_MASK_SHIFT 5
> > -
> >  #define APDS9960_REG_ID                0x92
> >
> >  #define APDS9960_REG_STATUS    0x93
> > @@ -77,6 +74,9 @@
> >  #define APDS9960_REG_GCONF_1_GFIFO_THRES_MASK_SHIFT    6
> >
> >  #define APDS9960_REG_GCONF_2   0xa3
> > +#define APDS9960_REG_GCONF_2_GGAIN_MASK                        0x60
> > +#define APDS9960_REG_GCONF_2_GGAIN_MASK_SHIFT          5
> > +
> >  #define APDS9960_REG_GOFFSET_U 0xa4
> >  #define APDS9960_REG_GOFFSET_D 0xa5
> >  #define APDS9960_REG_GPULSE    0xa6
> > @@ -396,9 +396,9 @@ static int apds9960_set_pxs_gain(struct apds9960_da=
ta *data, int val)
> >                         }
> >
> >                         ret =3D regmap_update_bits(data->regmap,
> > -                               APDS9960_REG_CONFIG_2,
> > -                               APDS9960_REG_CONFIG_2_GGAIN_MASK,
> > -                               idx << APDS9960_REG_CONFIG_2_GGAIN_MASK=
_SHIFT);
> > +                               APDS9960_REG_GCONF_2,
> > +                               APDS9960_REG_GCONF_2_GGAIN_MASK,
> > +                               idx << APDS9960_REG_GCONF_2_GGAIN_MASK_=
SHIFT);
> >                         if (!ret)
> >                                 data->pxs_gain =3D idx;
> >                         mutex_unlock(&data->lock);
> > --
> > 2.34.1 =20

