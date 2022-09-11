Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99835B5869
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiILK3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiILK2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:28:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB40386A2;
        Mon, 12 Sep 2022 03:28:41 -0700 (PDT)
Received: from mercury (unknown [185.122.133.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DF34E6601FE8;
        Mon, 12 Sep 2022 11:28:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662978518;
        bh=uNMLlgZMTYcC5mzrst0fDY2xiMV9lFyKj19odG4H/ko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e4YH8PA2z+L5Ko4pHG9kgmhpitFfNDSbDDISQ80oKXc99bYtm5NF2jCieDrRAPQvD
         oPk1JD/+oGt+Y17TMDGyUKlP+cyplznLl+X4QAsXzR1UAMyw+ZX3EuhJtLQ3kxXAr0
         NST/dL16r9meU7jEGAX/jeXivDKdDLI+iW/vZ9kpu0A5LMIMxlUVZ/j5ylCsh4gnuH
         shsHxDQoE2g7j4qE9PXLj0gz2i9+WmPZbWmV/zkvoqW5dWOOwsAK72AuyjFiZvtEnR
         2kPCunh+CpnxJlcDTov/Mox/MyshlvaY/ghHqIFZt/FT0W08iKj0jpYF7net1DzTnl
         k1X/zSz+2ce+w==
Received: by mercury (Postfix, from userid 1000)
        id 9885D1063356; Sun, 11 Sep 2022 14:18:43 +0200 (CEST)
Date:   Sun, 11 Sep 2022 14:18:43 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Anjelique Melendez <quic_amelende@quicinc.com>
Cc:     corbet@lwn.net, robh+dt@kernel.org, agross@kernel.org,
        andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        vkoul@kernel.org, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_collinsd@quicinc.com
Subject: Re: [RESEND PATCH v5 0/2] add support for PON GEN3 device
Message-ID: <20220911121843.k4appu2fszeeilkc@mercury.elektranox.org>
References: <20220909204207.15820-1-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="igpyojxumu3a3dio"
Content-Disposition: inline
In-Reply-To: <20220909204207.15820-1-quic_amelende@quicinc.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--igpyojxumu3a3dio
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 09, 2022 at 01:42:07PM -0700, Anjelique Melendez wrote:
>  Resent with fixed path for dt-bindings.
>=20
> Changes from v4:
>   - Updated commit message for patch 1/2
>=20
> Changes from v3:
>   - Addressed Krysztof's comments on patch 1/2
>     - Added missing minItems/maxItems
>     - Merged if statments with same constraints together
>     - Removed description from "reg-names"
>    =20
> Changes from v2:
>   - Added new "qcom,pmk8350-pon" compatible string as per Krysztof's
>     advice
>   - Updated dt logic to use comptaible strings to decide constraints
>     as per Krysztof's comment
>   - Added new patch (v3 2/2) to support new compatible string
>=20
> Changes from v1:
>   - Updated path which was missing Documentation/devicetree prefix
>   - Updated CC list
>=20
> New patch series to separate this patch from applied patches.
> Comments from original patch can be found
> https://lore.kernel.org/linux-arm-msm/27515993-18f3-8891-4835-9b6a8d7f86b=
0@quicinc.com/
>=20
> David Collins (1):
>   dt-bindings: power: reset: qcom-pon: Add new compatible
>     "qcom,pmk8350-pon"
>=20
> Anjelique Melendez (1):
>   power: reset: qcom-pon: add support for qcom,pmk8350-pon compatible str=
ing
>=20
>  Documentation/devicetree/bindings/power/reset/qcom,pon.yaml | 50 +++++++=
++++++++++++++++++++---
>  drivers/power/reset/qcom-pon.c | 1 +
>  2 file changed, 47 insertions(+), 4 deletions(-)

Thanks, I queued both patches.

-- Sebastian

--igpyojxumu3a3dio
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmMd0iIACgkQ2O7X88g7
+prrIw//duIMpV+No1Iwxa9UAzrbknmcZBWNwAm6tm23uRklakcfkj5dzCLtd8lG
kQf9RROKa08Yp8mhuOhOe2NAR9gp0stXj7rywJRKmLJhJjqaAsXYKqAO/rqdMS4b
lnDSbtQxJBHReLVT7oezDaKMtuqDBdpJ5FM4Q+SUt8/dJSTVog6Hyai1AwfZtItR
ndK0IpISd5Kj7wbqdhMK2yP8VFUsH5JdRKgMBCb0UQN9wKKLrgFJOiE9JzhfmKDn
M+xJ31QRj3/rxNS02p2BtFid0+VgSwAwcsvWsdWFhGkk0kFlo0mgqtnTI1pYX4PY
ymKQ/8tMjBqKs5GK7FxKFxvHGlqOEW+wAH8L21M4jZSP8vuXhbieYHneRIu3VQJs
D9LNyM/SVHb9BQ4ICAWZZevFmM6IqxNP7t3qghazu5GlB6GoGEdTtWot6Xcvf0WV
e5ubn+0bSQ4sorRA+Pw1RYBpB9ivqIYgg3ZCZq8e4SF4G79pzu1c6oqJQUwi1And
FiDKGyx2Pp8nej+MEGuBOIsL3bVIvc369IiKJ+tJUiIbRlTTRn0o8fmk6sq/dqNk
SSI2+paNsjzsO/N+Pc8uvmaxMQfSFYHbFSCWnDkbiQOIiHXWURULs+wFHQ+7yhFI
dX0ubIXKYNAQ9xn3xpS6h05Xrb5ZAiRH4qG4S2ZJd7KLlfxqXfI=
=4XS6
-----END PGP SIGNATURE-----

--igpyojxumu3a3dio--
