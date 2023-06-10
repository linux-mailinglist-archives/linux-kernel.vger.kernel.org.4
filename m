Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A56F72ADA5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 19:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjFJRLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 13:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjFJRLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 13:11:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84C8359D;
        Sat, 10 Jun 2023 10:11:46 -0700 (PDT)
Received: from mercury (unknown [185.254.75.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4ABC76606EF5;
        Sat, 10 Jun 2023 18:11:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686417105;
        bh=GTCoI9gVT5Q9hQF9AbMQI6UBua8tpLElPPWw24KdOG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PGnFPCSfquUqM+8KZiBnsFAYM9sr/+eCoL0ROcsNmS8mH9h/lAU4jHZWmmt4pultw
         ZgT1P6a7SMYjaCa+Vfb9crZHLkwdVqKh7+uHn0QUgsft+owcEgvqCbln3PXXnc7iyH
         KaeJ17DtpKZHM5zo65zSmmmZSula50dyNyQ7cAFY9N8tlLEpeOiXAEZJQ04f6oJjDF
         X1TrzTgxQ6szCz1dByT2ANBCC6minjOKZdVBGJ4dA/gR7evMGHIz86wrZwS28nqTuk
         HP4Y239iqAHblPTUEYhIMj139HH9ICqfYxG507uJVtfvOUH+IA4SuEzbABA8SmFVZ0
         Gw9NFYglIL/5Q==
Received: by mercury (Postfix, from userid 1000)
        id AF4A81060921; Sat, 10 Jun 2023 19:11:42 +0200 (CEST)
Date:   Sat, 10 Jun 2023 19:11:42 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        heiko@sntech.de, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, gustavo.padovan@collabora.com,
        serge.broslavsky@collabora.com
Subject: Re: [PATCH v2] dt-bindings: iio: rockchip: Fix 'oneOf' condition
 failed warning
Message-ID: <20230610171142.dsezim4gcxr2b65u@mercury.elektranox.org>
References: <20230610143601.173307-1-shreeya.patel@collabora.com>
 <c5243179-9baf-59ce-b979-c596dcf6692b@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f23o6klw7upsg4lg"
Content-Disposition: inline
In-Reply-To: <c5243179-9baf-59ce-b979-c596dcf6692b@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f23o6klw7upsg4lg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jun 10, 2023 at 06:30:57PM +0200, Krzysztof Kozlowski wrote:
> On 10/06/2023 16:36, Shreeya Patel wrote:
> > rk3588-saradc isn't compatible with the rk3399-saradc variant,
> > hence, fix the following dtbs_check warning for 'oneOf' condition
> > failure.
>=20
> Are you sure it isn't compatible? According to your driver it is and
> this change is not enough.

The driver changes are still in the iio testing branch and not yet
in linux-next. RK3588 ADC is not compatible with previous
generations. It's trivial to see in Shreeya's driver patch:

https://lore.kernel.org/all/20230603185340.13838-3-shreeya.patel@collabora.=
com/

Greetings,

-- Sebastian

--f23o6klw7upsg4lg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSErsoACgkQ2O7X88g7
+pqdjA//fAN5NUk3NyyvjLVVAu3DIUPDIWnYahETYGCTp+c7Q5aVJ/ba/AifbEZ4
r8EWHcqU6T6WwnWXsgTyEQrp22wmLpwR90TR6fMo2Coz6cGGh+z/fqYsQ6ndk0iF
T2BcviSUpJ/Pcm7TPYMNrFVYp2r4Tik2cdJiTFpRkKMxGrv0A6XZ+/6Ulf59DaGT
rU/tFrDr97nM/2uLEjdsWM249QmW6tV9qB9VpkHj5HSmwIuZkOe3tbTXvvUMxBj6
qvq1VU8eKPbz30stpqJDsB/alqbQDmbMiv8A/mqEQKWqDEgWf1GjG1mTXraql+sB
2BojWwTJOFNxlQGHXSn9l6aL7f+G1s4do5kf5ObxTViyfG48kjrbWtZxg7n9ZZaw
fjJcMo+HRRIb+ywPjKpDGucgz9rb9o4W3OJn6Lh4koMUWZzQJR8CCFNgNHn8Z8Nr
DNo+JNyhqCNwJb+pzXCGDY5gW/gdRtN+6pyTRzpx76AQpWGEa5yDy1DoT2mwNKLG
bGw15HT6hG/oTS4sktYTreUU9bi1kcgHHQ0URTYrZeltyriUJDFMD90WGpJvogeM
HiDVtwRcgaS2LCSs51nAxJRcdn+XuXHzpDDz2W3/EN7JotqnZibjo3A7t0LcR2rm
k+89jth4jbuN1sKPjFIXV/adwv3Mf7N9H6KjX+nNuyO2B0/fo5c=
=jpmA
-----END PGP SIGNATURE-----

--f23o6klw7upsg4lg--
