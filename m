Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D1162E866
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbiKQW34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiKQW3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:29:54 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF724BF7F;
        Thu, 17 Nov 2022 14:29:52 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 21so4686895edv.3;
        Thu, 17 Nov 2022 14:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7K+2+hb50PgBvImpYfRCmrZDiumqAIoMLO+SRy2BjY=;
        b=OW8Sf6bOy/sCfRmUTV1Jn9JpRbQqH2u+fqVW7VD2h/eJW2dpOxkbe90k0zJTN4gAJ4
         gi/dGTx5ZPclge1JRDpCh73zPeMtOPChP0YMVcZo2Ah8KufSyuT72LhV3cmlbtCDbL65
         UHe7SKts67iQyKQALQ3XpcCSOuSNa+6hrNJAcOU7/Zkl3UwULhXMdztK7HD6AviiFEmO
         LWY8bT1+Ux0EvQs0/Mj+DgPyPeRwbjBQipMEBTtiC/8MkcJEC8krB0XmCJHX9/uyqiHy
         2boukPOWjy7bBGTjy/aSUP0ys4fx0RQjGgj2v5RjeLK+LIXRKo2OQjhdCdugzbamdD9t
         1euw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7K+2+hb50PgBvImpYfRCmrZDiumqAIoMLO+SRy2BjY=;
        b=I/dzjHugphbDffrt+O9JTVmxyeBF67qsFU96ukBZXgBypLHtEEocimGNu98jEYv0kc
         vy9XeG47Kt4o6XgB1SaAKUqbVC7lK07Qxd8oEkFtjwBMKH4pFIBRYp8aOvZH4CbBP7fL
         f8fV+QptkJaCiySwTc3Jia1QOmgXzKeaQHTBdZF2+63UOtOBdxkRt7OTyz6ljl5wrr/P
         HyQ1LEe49e5F1bxFejCowXMYE13h9B6JQ4tKuK2+67/7ZI3Bzz+Dy5ydPaJIkL6BZG4o
         R7z5OSF+HK90wUsRZYB7bCjmmLXZJvXU5zw3hfGXpnKNkKkBNXry7YTCGjktFPBlSceJ
         koeg==
X-Gm-Message-State: ANoB5pkXn8Lp5GoiaSFU3xmz0gd6biK2GQcHz/5H19xrOuJyq9wAX1ID
        34LkMDSRtYk57xEYl3OEjRo=
X-Google-Smtp-Source: AA0mqf5oLozVoWkc8kyT9DFV87DVXFHiYgdXSJjg30pW9ms02tIgyRzoBtVLyPgG54wncIMrJJEmHw==
X-Received: by 2002:a05:6402:2993:b0:462:845:ba98 with SMTP id eq19-20020a056402299300b004620845ba98mr3862361edb.12.1668724191287;
        Thu, 17 Nov 2022 14:29:51 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id v10-20020aa7dbca000000b0044dbecdcd29sm1034459edt.12.2022.11.17.14.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:29:50 -0800 (PST)
Date:   Thu, 17 Nov 2022 23:29:49 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jim Lin <jilin@nvidia.com>
Cc:     gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v7 1/3] xhci: Add hub_control to xhci_driver_overrides
Message-ID: <Y3a13Q+iSosDUOW3@orome>
References: <20221111101813.32482-1-jilin@nvidia.com>
 <20221111101813.32482-2-jilin@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jnB12ol0gjctK1Jc"
Content-Disposition: inline
In-Reply-To: <20221111101813.32482-2-jilin@nvidia.com>
User-Agent: Mutt/2.2.8 (2022-11-05)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jnB12ol0gjctK1Jc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 11, 2022 at 06:18:11PM +0800, Jim Lin wrote:
> Add a hub_control() callback to the xhci_driver_overrides structure to
> allow host drivers to override the default hub_control function. This
> is required for Tegra which requires device specific actions for power
> management to be executed during USB state transitions.
>=20
> Signed-off-by: Jim Lin <jilin@nvidia.com>
>=20
> ---
> v5: new change
> v6: adjust parameter alignment (xhci.h hub_control)
> v7: change commit message
>=20
>  drivers/usb/host/xhci.c | 2 ++
>  drivers/usb/host/xhci.h | 2 ++
>  2 files changed, 4 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--jnB12ol0gjctK1Jc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmN2tdoACgkQ3SOs138+
s6Heyw//S8yCagyOrYQmjUJ/unCk4QbLBERULyACz8zFu9dU5pv3FwGQ3wt5Gype
DoRh0fqnPOQO7raK4fbXp+ZtC8DrykmJFBhAsi+ePH3fihusMHjrbCr6CMjENH6d
xAkY0YKEdYywz12smypRGxrwoD10IkwV8AEWoxJbzbJSJetKJ01ot0V7BUpZbt8o
oCSzQmOmWXCX8InlZKaRm6zKrNU9Cy5mbgnv17tVv8XMrkuju00c8GrzVcdiFOkP
H1LK0z/B66NQJFUyeAxNPYXwlntpc6hubdLOcKbx/VozrU/eKu4mXnGIuRNJx+x6
eTO4MN8rcGCQ8ZGb9wEm8xkh0HedddjRh+xD9X9rugWdcEk22rlRO3bGS/FLS61r
hHfM3YFhzHt08Xtyj6GnEMmncno+ZVVtP0jpb9StkuvqRSuJK2/73fI+Y4F760cY
jTv0+PvgzNUgeBdK+c0UE7RCk6/jvhDXpPLC5K72qR5eKTWzF3+sH80tkgOKLuKc
0+LCAQlKuC1cJAyHucUE3pKmlNxMeorP/MJmEUtXs1WyvHWfu4eNq7ZDQFP1r7z1
AyEj8Wj3rkSzXQr1oNrglVuX8BPPnw0t0qeAtmwNVrdYLvshYC+1r46rQ91/HSPg
NxBG6K+GWQZU68TUXDpqopbcymlFXpxsmNvAC5ztf4vIq3BOwh4=
=RD/t
-----END PGP SIGNATURE-----

--jnB12ol0gjctK1Jc--
