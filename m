Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8319D5EDF5B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbiI1O6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbiI1O6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:58:02 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB825D133;
        Wed, 28 Sep 2022 07:58:01 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y8so17632993edc.10;
        Wed, 28 Sep 2022 07:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=f/HZZdebxu0hO5KZ/Snq1NCBmoxmHmJa1M3saKHy9Es=;
        b=jtj1UtFJVUp5mNI4ABQVK5ICzxz4G0U0TL/nqgIor186nRlOWwfgakV7iFEO1BLHCl
         6CcOkodKGf80Vd7Xr7122HjJzIlhikhPJOPnlmpKxfer/GDMVkhEMLdUa0grHS4r6dOE
         fTil81BnYfo3VVlpZ3Qk4SE4aIGergw+OpSDO93NKRgMnWDNlKz/AvLwf83c/hMfQUvE
         BjUqVc3mKkyf5z86ZJ1RcjXX1DR5pJ5iyCRpE5FzYRvxDJXj9H4ZRZpyc0dfOatNbQ8n
         /bZ92U+MKCrzcPpaXVZp/ASazA/iPvsBRunEhQRrVjOw0hYV/1QqZlCFWi50GPsMwIyW
         HApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=f/HZZdebxu0hO5KZ/Snq1NCBmoxmHmJa1M3saKHy9Es=;
        b=tHYfyQfNoPSO87e0Dljv5xyDW/KUmsaSrFTIjgQN1H7dEGLtjLIXwcxgnm5CzwZIXr
         lMgFp1qf8QKXu5R/3l29ikb0tTFSpQ3NKKzPq1cpxXG7iGr1HeC82aDrpZ7//iv/lT2G
         6Nz3x60lE0xA2b3VsujaonbSLAVoDshw5756xMGW1NW1cOq674iq1bOGSi2aPFtwVcQL
         t0FrNTxFJXV9lEFzG7NjUmcoVUzeyFzWR39SJ9MWHcRZEeiJouA9E67WIX8h2eR4/U5R
         c3F7FkkWNihB/T2czo+SwGpvXVKh0M1ksLQvAfr19Tlh8eIrGSQXhAg6MiMXMSR7UTp/
         lJnQ==
X-Gm-Message-State: ACrzQf123O2PMzbXu4PxVcRsf2Gmnvt7dHIlQYxHr/768rbhpazCd/kZ
        x8u6ROtVtgWVpjG6WuPHnKI=
X-Google-Smtp-Source: AMsMyM7P9BftqFLmbn8pq97+RcsL9sHd7ATUVph0laOCiYhyFNRrNXjEz5TRTkt2bnbH2NN6eqXjAQ==
X-Received: by 2002:aa7:c956:0:b0:43b:206d:c283 with SMTP id h22-20020aa7c956000000b0043b206dc283mr33701362edt.381.1664377079907;
        Wed, 28 Sep 2022 07:57:59 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id n2-20020a17090695c200b0073cf6ec3276sm2440311ejy.207.2022.09.28.07.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 07:57:59 -0700 (PDT)
Date:   Wed, 28 Sep 2022 16:57:57 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] pwm: core: Replace custom implementation of
 device_match_fwnode()
Message-ID: <YzRg9cLVlfZfKhws@orome>
References: <20220927172258.62418-1-andriy.shevchenko@linux.intel.com>
 <YzRZp4e48XK6jAZD@orome>
 <YzRfAE58ZMI/MC0K@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xknfgDc4sPDfyFdY"
Content-Disposition: inline
In-Reply-To: <YzRfAE58ZMI/MC0K@smile.fi.intel.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xknfgDc4sPDfyFdY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 28, 2022 at 05:49:36PM +0300, Andy Shevchenko wrote:
> On Wed, Sep 28, 2022 at 04:26:47PM +0200, Thierry Reding wrote:
> > On Tue, Sep 27, 2022 at 08:22:58PM +0300, Andy Shevchenko wrote:
> > > Replace custom implementation of the device_match_fwnode().
>=20
> > I really don't see the point in having an exported symbol for this. It's
> > a simple comparison and the result is even longer than the original.
>=20
> Longer doesn't always mean worse.
>=20
> > The
> > *only* reason why this helper exists seems to be because it is getting
> > used in *_find_device() callbacks.
>=20
> Yes and no. Initially for the purpose to be a callback it can be reused.
> The point is that it hides the dev_fwnode() machinery behind and taking
> into account ongoing discussion about constification of the dev_fwnode()
> we might need to touch this or similar places to avoid problems with
> compiler.

Maybe next time use that argument in the commit message. That's much
more convincing than a useless "replace custom implementation" because
that just makes it look like you're doing this to pass the time or
something.

Applied, with a slightly updated commit message, thanks.

Thierry

--xknfgDc4sPDfyFdY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmM0YPUACgkQ3SOs138+
s6EWZg//doDoJ9LYc3N9ewjYfNNQ+0y9uPO8ycCSvymdc4l5O24ERDkAz2fiTrDn
CKRGCtHYIojNdcKQN5dDNkwQqyqxpRN89vtN1uzDdLlHLCpBQYQIZd704o9B1EC8
lY9m/nuszQZH26gUCaZxPoWGMnwNfsFOAAC+JSUvX8OD5TyXUzChRAjjzw6ti0L+
tstTFcDyvdCxP7qVlzIijToLHaT6b7Kx0pt7XcQ3/ErIQTr/G7K1y2K7bbIGettc
3iGRQGeup+TfHjsGZonvRP+CR7Eq3nU/eEmfVNeZk3QomVv9meCY2IJ09UrKMxY+
kJRbMRkzujHPmRfRRLH00DHGMOis0FhAHa1wdkJksvq//bylWIyQk1/8lgPrCJhJ
ONeJSBhWkHXSjFU3uus23WaRqyE3iLnppOEJBAoeWpffaZ9MzHevoy/hq0HoyDPF
bHB8GfTNl3190HHXr6V0Vg5FxWt27Jovi1G+q+udL0j0tfk9gbvlzazm6txEcaCO
Ar7M8gBlh7Ug0tpgSCo+nWVuGyDsFDs/xnuQPJQ5jgYTk/qHOjXJmfuphc0SpNWm
SZycV/t8/fZDxgzqInkIIQqJGIFEvqLmgRp+xGiOgoB1uKjX1z2O9HxvlIjzDZ01
Ke/7FXOZimRAnxHrpt1B0t87bILDa3MGYMLuIbqEXcdFm7dCAyI=
=t1Qp
-----END PGP SIGNATURE-----

--xknfgDc4sPDfyFdY--
