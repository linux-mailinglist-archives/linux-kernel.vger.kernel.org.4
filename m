Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B0C600F5B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 14:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJQMn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 08:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiJQMn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 08:43:56 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DC64C609;
        Mon, 17 Oct 2022 05:43:55 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id q9so24742312ejd.0;
        Mon, 17 Oct 2022 05:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfWnhMTbmCubIiawz2PYbNchWCR8WEma7fr9AGcRi8M=;
        b=GvsxfAIqs5Cnjr379cP3fbtTrY3DBl39wfIX7Ta6x3T/9fMtEErYIe/C4TrXl6mgR6
         K+u7/YvozTD9E+Dnud83ZW14X6D/+e4auUedsV5DdpVySn+iQ8sKgrNU1vGaqsyxggRo
         tsaEjhX6pa93TJJK2zglk5DSk6/tr3vYElC+swKdrkP8885NrO2SzCY0MM/H4hlIH6wM
         5AFU/tdglzyUp7OgwuyIIUjvlMwmlyk+ykEUnV5x6eOgYSoheF2aQsKdSZOgOy7MuKq9
         ku1lJvA0jZa9Ph3216ua2oXvd2BzOtpkBJyXsfgvfrRECnEWUH6Fd8T0R1xWETpXFqfs
         SORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sfWnhMTbmCubIiawz2PYbNchWCR8WEma7fr9AGcRi8M=;
        b=i/LVwiD3igSVJ+zBtIfKFMvZYc7J+MetXhy4p5+CEG+DmfHmbgfIsYSKKPO/I5qL+n
         NbCT9tkefqkSnUflas2DY+BWdurI2SvE4MQfHeCJlVOSYLqfmZPGN70LV0mw5GBKzmNT
         Vf07bsumh9crQABSwSBmLqN8jM02EyR0TbkgR/0pHSeUnesu+4ndnYT0RlHI5N3r5cDK
         j3C8bp/WKc4xVWu6vYKiZuzeleZg8+kIpffpUlqWOTno7AKq14rnYruPVQKD+yj03OFw
         jGWZfRXgnpW1/SfGR5v/4lc84fEVE6S2jhHMxp4K2GkI4ss7w4XHECVDIYtRVVu31v9B
         rH3w==
X-Gm-Message-State: ACrzQf1qqw6lddRAi9ACQU6UwDGLQ1xY9guNKoazLR3sSXF8rFjFiD6y
        FeGwI2FWJlef4YM+EcXcKvc=
X-Google-Smtp-Source: AMsMyM5BauYTy7hmXTLnRFyd7yFVthBUWeAzHXpAbb6S7WKe2hlEYXfNdiv/g4+rcid4iiM33Bpfhg==
X-Received: by 2002:a17:907:1c1a:b0:78d:426c:2828 with SMTP id nc26-20020a1709071c1a00b0078d426c2828mr8813780ejc.331.1666010634128;
        Mon, 17 Oct 2022 05:43:54 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id hp11-20020a1709073e0b00b0078175601630sm5961279ejc.79.2022.10.17.05.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 05:43:52 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:43:51 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jim Lin <jilin@nvidia.com>
Cc:     gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] xhci: tegra: USB2 pad power controls
Message-ID: <Y01OBzmcwKxbw1yx@orome>
References: <20221017122531.9923-1-jilin@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MMNKjU9lt98sVp2G"
Content-Disposition: inline
In-Reply-To: <20221017122531.9923-1-jilin@nvidia.com>
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


--MMNKjU9lt98sVp2G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 17, 2022 at 08:25:31PM +0800, Jim Lin wrote:
> Program USB2 pad PD controls during port connect/disconnect, port
> suspend/resume, and test mode, to reduce power consumption on
> disconnect or suspend.
>=20
> Signed-off-by: Jim Lin <jilin@nvidia.com>
> ---
> v2: Fix issue that wrong tegra->phys[] may be accessed on tegra124
> v3: No change on copyright
> v4: Remove hcd_to_tegra_xusb() function which is used only once.
>=20
>  drivers/usb/host/xhci-tegra.c | 134 +++++++++++++++++++++++++++++++++-
>  1 file changed, 133 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
[...]
> @@ -2444,6 +2574,8 @@ static const struct xhci_driver_overrides tegra_xhc=
i_overrides __initconst =3D {
>  static int __init tegra_xusb_init(void)
>  {
>  	xhci_init_driver(&tegra_xhci_hc_driver, &tegra_xhci_overrides);
> +	original_xhci_hub_control =3D tegra_xhci_hc_driver.hub_control;
> +	tegra_xhci_hc_driver.hub_control =3D tegra_xhci_hub_control;

This whole business seems a bit exotic to me. Perhaps a better solution
would be to EXPORT_SYMBOL_GPL(xhci_hub_control) and then call that
directly where needed instead of this indirection? At the same time, it
might be a good idea to add a new hub_control to xhci_driver_overrides
so that this can be automatically set within xhci_init_driver() rather
than having to be done explicitly.

Thierry

--MMNKjU9lt98sVp2G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmNNTgQACgkQ3SOs138+
s6EUAg//UzJ55QcDpK2hvjCeMUl6eBClOdEcBZ3uamfDa9kkHuljFuZpaN92rxrU
S9enDWojwjmJWvli3tHdK52CO3C//oPjCtEw/ATyWOuOag9GJ7+fdQBGUM4vKJVw
UGzsEBEgzUcq5vIbbBfrbV7Y6AgMSXuUSn9jYSamzj4Sx6XerQBiPYsLy8ZoKNsN
17TC7PUbA59XSzky62v3beaHO+FhGTVA8veiFUq+BXsB3ENEpZzNffm1TPJBE3Uw
TjEQhJ5I6E+9UEjBPuwKnWIxVEViDVrn1Hc2VJvJepp6XZVzQGjoj+fh6Cto3LD3
ZTqwkF7xsiTPS53dTqXsJdaGBZm6TNFB7Bpw+ypPPmdXgfa+oeCUWWfnt9RUUdod
HMgSFscMHvREpacDx73PiSYQLlTr5tkctRBBWU/Z7ajajtkBEcNLtgxpv9tpV/LG
1R3h7urHhyYBdJ4p30fwn9eSlml7gK4vzYiPnIIL/jMStt/IsDSPjf1eYMevOSjv
mFjxBpmt90tqcesZAfkyG4pPJd9mlZoxbhg3T9YLsRPKzm9Z5NJPyxxWtdKIGTT/
qess4/Brn8QF9b47swSTR0hOFurt1jt1B5KJDkDcpOEXi+oLaNSyDMgN+8aSXAQo
F1UmJ+y2kLJhGxPUx7EIRsoZrasVeA+pD9FRQKrqv1HgRQZuRW4=
=UWv/
-----END PGP SIGNATURE-----

--MMNKjU9lt98sVp2G--
