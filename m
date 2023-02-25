Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A626A256C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 01:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjBYATX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 19:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBYATV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 19:19:21 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C5668689;
        Fri, 24 Feb 2023 16:19:20 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1DED46602FC5;
        Sat, 25 Feb 2023 00:19:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677284358;
        bh=Lih/5chedCssYGvXHYccrZexI9Z6zYFC+WoU9RjkJaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gaFWcnGrf+3jNv8EGARQqO0TMnQQKEvc2DwhJ0askyYyX6e2CU7nguS4u+w5xw7on
         Pd4PWsF4iZQc+ws6nmTwmq5JuJO7xfM+YMmrbTIUuiMcWRiEyGXknkE12CLNXSIiyS
         SyogsCESfgYeksWrq908sjidcSVusvZjCyh+jGDR6DH8uVpwOlC/YtC6aJQP3a1dlb
         JMTDET90Hbqk6Nfza2QBs+5Jvv3E6TrbhW/XRIPDuri32SOawObTRJcKIxnWpPA7Y8
         kBuK4tJsbUK3afeZvR3Et3krAONhfs4Q6jnQb9TGdEKCE1SAMuQ/0HuZeeuAURRn0q
         OQpj0z+yEP5yw==
Received: by mercury (Postfix, from userid 1000)
        id 045A11060924; Sat, 25 Feb 2023 01:19:15 +0100 (CET)
Date:   Sat, 25 Feb 2023 01:19:15 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     ChiaEn Wu <chiaen_wu@richtek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, peterwu.pub@gmail.com
Subject: Re: [PATCH v4] dt-bindings: power: supply: Revise Richtek RT9467
 compatible name
Message-ID: <20230225001915.3bcqqshyntvcbue7@mercury.elektranox.org>
References: <1676627755-14349-1-git-send-email-chiaen_wu@richtek.com>
 <ec046b79-ac83-1d5c-4a77-59a8f313e52f@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nwp35z7h4wqr3x2h"
Content-Disposition: inline
In-Reply-To: <ec046b79-ac83-1d5c-4a77-59a8f313e52f@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nwp35z7h4wqr3x2h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 17, 2023 at 11:11:47AM +0100, Krzysztof Kozlowski wrote:
> On 17/02/2023 10:55, ChiaEn Wu wrote:
> > Revise RT9467 compatible name from "richtek,rt9467-charger" to
> > "richtek,rt9467" because it has to match the "compatible name" in
> > the source code.
> >=20
> > Fixes: e1b4620fb503 ("dt-bindings: power: supply: Add Richtek RT9467 ba=
ttery charger")
> > Reported-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> > ---
>=20
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks, queued for v6.3.

-- Sebastian

--nwp35z7h4wqr3x2h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmP5VAAACgkQ2O7X88g7
+pqyNg/+IWC9HSMBeqkfNPuZF+QAasWBADtQcAvSK/acMwR7MBKADSMxKfdAmgdi
uTEGGDkc5TK5MwD85uwnIQgIjJHtILkOB26jDS0tOvl2ZYfD/0vaxnZtFDVg7xqe
N2yfalLmARQFfL3f4cdx9lSbsUc8AXirGIGXO0B/5Ffs9Xm1Hid0pAyX9hpySQE4
BxpHkdMhR7zYyqNMKwttTRxauG8M7EVNUxX6URxCNKxtQwDd03Z0XibRCH/kkMR6
wjP0N5wW3g0F1fjlhKFBPjuIIDQQ+Pdc/xg8LwzIKdC0FJ9SVTKOsrQrr87VppSx
3tf6r8tcgpwjHBpzJ2TqxEQ+usmVciDp0MeJkHgF1JB4F/AWjzZgmuJgjfm+xSSo
DZ/ShC+WvWNeW3Fus8cVIc+4BdgKa1Xqi6hroSL8OWFuI1Yl5CKKd2gzcBtRcD6v
WeQh6QhJyvDVxn+bIRkFX7TWpD1RwxIfMOVBW9zPYMzh8ZuWliD4lidBvPnaVNqq
K4r8WRH/Xe25lHWbeOBTZOKaUnl5bIftJHi899b7oATJ++Fb5TL4DlCeEOqfHGsg
tbnNe7SlvcXyWHUJp8DlkpYhOQuRHpi+zndQsAY6X+wJMWZMDoypTqIkLT7kOxCT
IIxKWQlPrtTgxs8AUQWjzHSRiqTamWdxsRZliqp6d6uNfU48SyU=
=pWVp
-----END PGP SIGNATURE-----

--nwp35z7h4wqr3x2h--
