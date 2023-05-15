Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D89D703FC6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 23:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245494AbjEOV0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 17:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245546AbjEOV03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 17:26:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B5D124AF;
        Mon, 15 May 2023 14:26:14 -0700 (PDT)
Received: from mercury (unknown [185.254.75.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 167ED660322C;
        Mon, 15 May 2023 22:26:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684185972;
        bh=xBml64hfGbUyOg9fPkEIiKZA7tz7tTNBBUqM9DwGxec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U81MtIo/0rXt7lYfN0f/XXxv59vfg3IPFyYLB6Moh94Sn3C7CAAJl+7/fphgeBUVy
         HkNEvG57xULpFV4kB2WP73LI6OPCfYhH7V8bUty3JldSuSp4Dl0xAU4jzKR6HELibj
         FV2cL30B0k5acQsD2vK4ZuqjEBB0VEeYCxwmWlVJ/WdjTxVzHa641Bc71v+soiwkA9
         28be9bA99pWOIx4+DJWpzqlgMp165tMdHL7xBqFU5WWWJ3V1pe5qJ0fPOGsy7keSLk
         MNgRWDfy7P6wA0O3QEH/S58Q7SxxKdFOIRwn0h0gxniJwxrpyfJgoNp8w2ouIibYsZ
         qmdserQEKeUAQ==
Received: by mercury (Postfix, from userid 1000)
        id 65F771060F7F; Mon, 15 May 2023 23:26:09 +0200 (CEST)
Date:   Mon, 15 May 2023 23:26:09 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, wens@csie.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/7] axp20x_usb_power: Add support for AXP192
Message-ID: <20230515212609.iorat5drawgl6re4@mercury.elektranox.org>
References: <20230510115046.963432-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a6mt77smbvbeae6h"
Content-Disposition: inline
In-Reply-To: <20230510115046.963432-1-aidanmacdonald.0x0@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a6mt77smbvbeae6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 10, 2023 at 12:50:39PM +0100, Aidan MacDonald wrote:
> This adds support for the AXP192's USB power supply. Most of this
> series (patches 1-5) consists of refactoring the driver to avoid
> explicit checks based on the variant ID. Doing that makes it very
> easy to add support for the AXP192 in patches 6-7, and as a nice
> side benefit, should make the driver more maintainable.
>=20
> Patches 1-5 are unchanged from their previous submission[1].
>=20
> [1] https://lore.kernel.org/all/20230218204946.106316-1-aidanmacdonald.0x=
0@gmail.com/
>=20
> Aidan MacDonald (7):
>   power: supply: axp20x_usb_power: Simplify USB current limit handling
>   power: supply: axp20x_usb_power: Use regmap fields for VBUS monitor
>     feature
>   power: supply: axp20x_usb_power: Use regmap fields for USB BC feature
>   power: supply: axp20x_usb_power: Use regmap field for VBUS disabling
>   power: supply: axp20x_usb_power: Remove variant IDs from VBUS polling
>     check
>   power: supply: axp20x_usb_power: Add support for AXP192
>   dt-bindings: power: supply: axp20x: Add AXP192 compatible
>=20
>  .../x-powers,axp20x-usb-power-supply.yaml     |   1 +
>  drivers/power/supply/axp20x_usb_power.c       | 307 +++++++++---------
>  2 files changed, 153 insertions(+), 155 deletions(-)

Thanks, queued to power-supply's for-next branch.

-- Sebastian

--a6mt77smbvbeae6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRio20ACgkQ2O7X88g7
+pqRIw//fAhw4acR6HfzG4hURUubFcQ+xKwpK4elZLBa53QheG8V57JAgL/+5iML
bwQHtYPtUs/7sLUogLq1sRmfGvlEQdmocmXNoqD3Xtjbyd2TCsxfjlVgs7TLkdWt
u37tta9Cg2dc5H4xOCN/JtJ9ph52cwflvSe20zxpK33a5iHFJvlkgNCmk3+rTDCl
IfUjKUSuz1+aliGSS3BdpC5WXFNw/NBmy0sAXppSgNhKKUdNIlp6fuR8xmZlBOAH
+WjttsYgwPRjql31utZY58eHl20lDYs0KyCXIYuJsRkvtIlhhzU4MXp4j+etCYqI
g3q86rNKKcd6r+lvuc2+n/K3b/WZLpItkIblKa1HK87YeQne7f/KcLNjFNmGn7PC
f/PLP2JyFuGZbZoGaykO5K1VHpPkvGwOMzB1El6DqGU66r0QI/vCx6SMKT/yElPl
x1GV6X7vdVIOcF/FOgGWKM2DZQs4XwsKWsFni8QT792PVirrQ6ZOXKrbXoM+GlYa
PgolTMxwVA3QjwVUDy3NdTJb8kjQG3Cg9uFpprQj4EmjK/SRH3Gm+apwHxWj914I
k1+J8SuM99SnMn+mttCk9sQU5/EJsix7yALYC7CHc7zxFxeJFb2auv9CPM2oTINq
ChxyeIu1wHtaoqL2Gb2UgyT5QQlLKFLeD1benqkaPLM+L3vEW94=
=HEMW
-----END PGP SIGNATURE-----

--a6mt77smbvbeae6h--
