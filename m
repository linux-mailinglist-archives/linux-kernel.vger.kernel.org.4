Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D378B62DDE8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 15:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240279AbiKQOYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 09:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240024AbiKQOYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 09:24:00 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52ED41D30E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 06:23:59 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id w4so1163249qts.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 06:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XwTck/ecNhkid0iaJxj8dCkVWjNa9jLvmWZcqTf2HEY=;
        b=TofIAUcUgNXdKkRlLpXAHp8LPOT+KnI3SNxuveYWvBTs6tRG9zxznjhaG2E7m2VMv3
         82jxzeTw6haC8iWyHY4JKqEZAXouquoN8TTFCJIgKd0d6UUzGEptPxRLjrg6KXxGNR2w
         murjBhrirP64xXtZVcfHKlVhh5Td4BPvP61Ri4IPnEo3rrcEFnmr8dzp9Y3rXM5DsbjL
         cyvdDaLTYt/KwCvRorUY98pNdUqFz/pwBQTNa6TXZwKx4T2dPSblqWtCbJznGaCm4mQA
         +hsDXCfEm9hy9oEg+09mtgkWC6h/eMmJVN7jFodZBQRn0d3FbwVDKDvxy6pwBsOQUSOp
         IwUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwTck/ecNhkid0iaJxj8dCkVWjNa9jLvmWZcqTf2HEY=;
        b=EDAne1FDjGK0eTnVKFhTY/iQN6+hzPWlpYzHp/tEBLcQhaxGt3S7Qwo2butq97+g9Y
         kkJjI+tzXZ4TaCTcQDU/2FEN68a5gX7eyUnrwJvpUMTCxui54QLcKL8c7j51w+Fr73SJ
         zB8ino/v5wpB2DKbYZQkTeEKgtew8GpYGCY0PYPfAiRBBTioyq/iDX/UCPR6xFqskJD1
         ED03gX2WfoDKUcxu07M1Igmsnwqvvzs0359xikhMcou7v6oTCa78pQ12uUm2n7v5lKSn
         /Ex1ARh6uv7OJh2yTBGYEdNlh0uinnMIZovZK+QjYzDAzhrJGrSiVym4FEcR9OXHG/yI
         uL/Q==
X-Gm-Message-State: ANoB5pniS+uE4nRU5/7lV+ppF/vS4sW4useqUxNbroGJ6aP5091MZTzP
        DbufeS09/bo5ClKQmP1++xOfgg==
X-Google-Smtp-Source: AA0mqf7v3Ie4yFVjQ30XKSRMo7y2QRB7Hnlv7UR53ByhdzHhYt63cPhGswcMJ05MvFXZN2boPog0Bg==
X-Received: by 2002:ac8:5441:0:b0:3a5:50ba:b20c with SMTP id d1-20020ac85441000000b003a550bab20cmr2336722qtq.588.1668695038409;
        Thu, 17 Nov 2022 06:23:58 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id y19-20020a05620a44d300b006bbf85cad0fsm574376qkp.20.2022.11.17.06.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 06:23:57 -0800 (PST)
Date:   Thu, 17 Nov 2022 09:22:31 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        robert.marko@sartura.hr, linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org
Subject: Re: [PATCH v2 1/4] gpio: regmap: Always set gpio_chip get_direction
Message-ID: <Y3ZDp6skghvMyaKv@fedora>
References: <cover.1668129763.git.william.gray@linaro.org>
 <1805d1ddb5bbce8e86164e66421ddde481cce4f9.1668129763.git.william.gray@linaro.org>
 <Y3DlsTAQMi6kKObJ@smile.fi.intel.com>
 <Y3DvUaA7YYAsypGv@fedora>
 <cc33aaa342ad60749d2f7c2a6d690733@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="enTNzqmh6/WJTuPZ"
Content-Disposition: inline
In-Reply-To: <cc33aaa342ad60749d2f7c2a6d690733@walle.cc>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--enTNzqmh6/WJTuPZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 16, 2022 at 04:41:30PM +0100, Michael Walle wrote:
> Am 2022-11-13 14:21, schrieb William Breathitt Gray:
> > On Sun, Nov 13, 2022 at 02:40:17PM +0200, Andy Shevchenko wrote:
> > > On Thu, Nov 10, 2022 at 08:55:50PM -0500, William Breathitt Gray
> > > wrote:
> > > > If you only have reg_dat_base set, then it is input-only; if you on=
ly
> > > > have reg_set_base set, then it is output-only. Thus, we can always =
set
> > > > gpio_chip get_direction to gpio_regmap_get_direction and return
> > > > GPIO_LINE_DIRECTION_IN/GPIO_LINE_DIRECTION_OUT given the respective
> > > > register base addresses configuration.
> > >=20
> > > Seems legit to me. Have you checked if we have any gpio-regmap
> > > drivers that
> > > have something like this in their configuration already? In such
> > > cases we need
> > > to be sure they behave as expected.
> > >=20
> > > From the code perspective:
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >=20
> > I see gpio-sl28cpld has two device types SL28CPLD_GPO (output-only) and
> > SL28CPLD_GPI (input-only); gpio-tn48m similarly has two device types
> > TN48M_GPO (output-only) and TN48M_GPI (input-only). It doesn't look like
> > the change in this patch will cause problems for them, but I'll let
> > Michael Walle and Robert Marko comment if they see issues here.
>=20
> For the sl28cpld driver this shouldn't be a problem. So for that
> Acked-by: Michael Walle <michael@walle.cc>
>=20
> But back when I wrote gpio-regmap the bgpio served as a blue print.
> There is the same handling. If you look at gpiolib-sysfs.c there
> is a comment about the direction property:
>=20
>  * MAY BE OMITTED if kernel won't allow direction changes
>=20
> So from a gpiolib/sysfs POV I'm not sure about this change. Does
> get_direction =3D=3D NULL means setting the direction isn't possible?
> OTHO there is a fat "MAY" :)
>=20
> Which brings me to the question of "why this change?". The commit
> message doesn't mention it. Just out of curiosity.
>=20
> -michael

Currently, the 104-idi-48 module implements a get_direction() callback
that is executed in situations such as gpiod_get_direction() which
aren't necessarily related to sysfs. In this patch series, the
104-idi-48 module is migrated to the gpio_regmap API, but loses this
get_direction() support because it's an input-only configuration. The
purpose of this patch is to prevent that regression by supporting
get_direction() for input-only/output-only configurations.

William Breathitt Gray

--enTNzqmh6/WJTuPZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY3ZDpwAKCRC1SFbKvhIj
K+zwAP91upqRhQV1dEM30LJyPIHO0ZHSXcyFgPN/PzNpEzV9cAEAvGvb9qHtmdAk
xs3ibm0MRBsHFvbknnITdjEwBm27pg8=
=/k59
-----END PGP SIGNATURE-----

--enTNzqmh6/WJTuPZ--
