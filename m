Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF67A638F35
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 18:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiKYRgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 12:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiKYRgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 12:36:09 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4414252167;
        Fri, 25 Nov 2022 09:36:07 -0800 (PST)
Received: from mercury (dyndsl-091-096-063-064.ewe-ip-backbone.de [91.96.63.64])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 520056602B67;
        Fri, 25 Nov 2022 17:36:05 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669397765;
        bh=CiEBCUdBI5rPszjYHnPchLfc87kWvkLB4DpUGbO629Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IuOxVfTXV9xcq5bg+1EMP7mYrkCQJ6mMQ/SGr4VAvVRygw6hK69bKR9q11HXm4Afh
         mJuWfmYfFFTGuf8y7pvCjZD7mPFubZiwBSJcfkgEUVVFDAOAOkSSbp5yg3L0rqGH1R
         xktWMUC30AXEPPxGWtDzG7FYRYtMvYnfenAuU7uC+xZQKyX5immGQNsHYRLyb6kOl/
         l4ODPhcPpJxxAhK0tT/8SWOqsCWKxXXt5+Nbl32EenAjJklLXHkTJXu9ZHx0o0fcp8
         OlnCv1TVdP7tae3VAdqXrveR0xzRJnTav478pILqrWuCKx/kRwoa521ritnXPM+/7x
         Y7rYS1REA3gVw==
Received: by mercury (Postfix, from userid 1000)
        id A792D106137B; Fri, 25 Nov 2022 18:36:02 +0100 (CET)
Date:   Fri, 25 Nov 2022 18:36:02 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: omap: n900: drop enable-gpios from LED
 nodes
Message-ID: <20221125173602.cnipos5oo4ncxsac@mercury.elektranox.org>
References: <20221125144150.477290-1-krzysztof.kozlowski@linaro.org>
 <20221125144150.477290-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zeagndkk36b3hgd5"
Content-Disposition: inline
In-Reply-To: <20221125144150.477290-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zeagndkk36b3hgd5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 25, 2022 at 03:41:50PM +0100, Krzysztof Kozlowski wrote:
> LP5523 LED controller does not take enable-gpios property:
>=20
>   omap3-n900.dtb: lp5523@32: 'enable-gpios' does not match any of the reg=
exes: '^led@[0-8]$', '^multi-led@[0-8]$', 'pinctrl-[0-9]+'
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

The drivers uses it via devm_gpiod_get_optional() and the binding has this:

grep -A3 enable-gpio Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
  enable-gpio:
    maxItems: 1
    description: |
      GPIO attached to the chip's enable pin

-- Sebastian


>  arch/arm/boot/dts/omap3-n900.dts | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n=
900.dts
> index ba35cff5b01e..5e78dc990725 100644
> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -636,7 +636,6 @@ lp5523: lp5523@32 {
>  		compatible =3D "national,lp5523";
>  		reg =3D <0x32>;
>  		clock-mode =3D /bits/ 8 <0>; /* LP55XX_CLOCK_AUTO */
> -		enable-gpios =3D <&gpio2 9 GPIO_ACTIVE_HIGH>; /* 41 */
> =20
>  		led@0 {
>  			reg =3D <0>;
> --=20
> 2.34.1
>=20

--zeagndkk36b3hgd5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmOA/PUACgkQ2O7X88g7
+pouWBAAk12CPqacrxrLSiJRAmajF70zOnyrXA0FrgHc9i/UNqEderDfcnG8t1dB
h3lMwZs5YylQoIQj8UEVvbxlMG6cujCGA9dLYUvD4YL6+WNDcxnmjGLWeV3DuH+h
rmXJRZzR8cw1yk/rnreJSmcnjoZy2fTJR9C+I4UlOW4O38HoBwHXJj9788Z1HSrF
ztjWzOCbBfXAWzLuNA2sJDId0KgtayqRUDGDSoqziIKXCqPbUMELgO1XWVMDANti
/xSkb1iOjb1X5sFcJLkmfKhBJk22xjDtgKtA9LKJFgVnjtO4cLkursqCcLTMxYb3
7fwd0+HGtP/MY3rOpywwfQghk9H8g9e3zGvPg4ieVZkAjnpjxAiumP7S/6v4by1+
r2fHPQirwojmczErge+Cb47LzXzajL8lypS8Ip30ID5Kn0QKY4s3N0v6ybibS/fy
Y2BDp/kJShslv5qiZhCvlTNq/pMNaX/AvrMyOzwCqRnS3rmAiEVPgtZQ4k7mxhv0
5+M0to+lHbSMkjM7eSvM/QxTHVqSPYU3dFO3ZaTuHaw8/EgPEEKObUe81RgpEEJl
LmkecXtff1MySHFTVAwimHbJ7EARcWiqgCMBPum1WFr7nEVJRmNCLrEcdzUb6fRK
OMB+61XcL2gc8/HDIBiHVh6AFjBmCxbGnXgLQ7Pr82kZTMW6Xx4=
=moQ5
-----END PGP SIGNATURE-----

--zeagndkk36b3hgd5--
