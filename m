Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5357A5F1F37
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 22:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiJAUP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 16:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJAUPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 16:15:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C68349AA;
        Sat,  1 Oct 2022 13:15:53 -0700 (PDT)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 57E3C6601F54;
        Sat,  1 Oct 2022 21:15:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664655351;
        bh=4VYYmA7fzG9OwRycPX/DaxU4t0NjzNha7dATmLtyZd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HW+8Ymemi2irys0+qXIFZmFLvLoD88W7eVL4SXoBNHjUQ29Qc6ouvdHtXxLOQp+nc
         mJgIJ6t4JmPu/vN1zNcnhN0/dNPnXTYs+ss6P18oGYFGnhXo06MUDl+BI1eBpKIMjO
         HWGe8FIRljbXUXXKMZNnEIrVpdFL2y7h6747EN13oHHpv+njg9Xu8loNq7rzIZR07T
         FXeVXm37odSXEieZkXTWdprIdF+VrxX95RlkFIqM8eNDt7N2C81mx/aXl5fN1vyoxU
         eew4jxC7Oeh1m0uvG3X1pHFftN0qHmGbbTdrC/NeqOJk1ZDqgF6Ptm3Hm/tZ2rK8jZ
         kO2AiSv7UsL9w==
Received: by mercury (Postfix, from userid 1000)
        id D8041106090C; Sat,  1 Oct 2022 22:15:48 +0200 (CEST)
Date:   Sat, 1 Oct 2022 22:15:48 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: max1721x: Fix spelling mistake "Gauage"
 -> "Gauge"
Message-ID: <20221001201548.xxezxgtsdtwpbe5i@mercury.elektranox.org>
References: <20220928211926.62818-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3rklnxsuc5paghr6"
Content-Disposition: inline
In-Reply-To: <20220928211926.62818-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3rklnxsuc5paghr6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 28, 2022 at 10:19:26PM +0100, Colin Ian King wrote:
> There is a spelling mistake in the module description. Fix it.
>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/power/supply/max1721x_battery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/max1721x_battery.c b/drivers/power/supp=
ly/max1721x_battery.c
> index 473e53cd2801..d8d52e09da7b 100644
> --- a/drivers/power/supply/max1721x_battery.c
> +++ b/drivers/power/supply/max1721x_battery.c
> @@ -444,5 +444,5 @@ module_w1_family(w1_max1721x_family);
> =20
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Alex A. Mihaylov <minimumlaw@rambler.ru>");
> -MODULE_DESCRIPTION("Maxim MAX17211/MAX17215 Fuel Gauage IC driver");
> +MODULE_DESCRIPTION("Maxim MAX17211/MAX17215 Fuel Gauge IC driver");
>  MODULE_ALIAS("w1-family-" __stringify(W1_MAX1721X_FAMILY_ID));

Thanks, queued.

-- Sebastian

--3rklnxsuc5paghr6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmM4n+4ACgkQ2O7X88g7
+ppEZg/8DviDAuBQ0jzaES+WYps3+xftStP5fhPDBit6KxSWKewybdbhHr0PtQoX
HR8JqEe79WgWDplR2lf3rJ1XMOueu3hJU2aH0xtQqLTFCaJvlatZbH+UeGgrWGss
FNeMpnhhxleOwUdh2m5XusCPwVY5RKEgmecPifHEj1D81uEPLZ0K/5jjsbtEyOe8
TWpetTLarQ8GzwFK+CbFC2qB8lezNSUQMsJbXv+rc7ZIyLzjTSW69gGF9BAjFOLC
1yGohFuRZhGe5YGk+cjnwlaSjop33bbQZAy9iq3az+4i4SWRTxkCty1ftcyUzvPC
Q7HE4u4ouanLp/gF1bD9nMl9s3LK97u7ICQF828GJhW57D5rtQx3bvGbiNveD1og
B2fNgb+CzaS6egx9mx1yY2dYXbloi452UajVOAC160c4elPJUsr1VSLIw3klv2nZ
L7jSsgppbJcKJzEKLsnECurjs9LxIELjGf5KrI2ZC5X3g9sGEoO47XGTubOT80lH
e/fO1aTtvGusUx1D8LhX78GtUF+hqE8cSTQxjrkpodi7C6oTMcGE9+pfdiAoTXIA
Tw1Y+fpg06q+Hq/cRuRnroRqRnJEE0JGhhDhPkXQFhlTr/NlvQh/QwOcu/qax21r
P2Nbo3hdbyj1sn7sMvazR9BxFxgJZgmTo03A8kXX6FJ0Kf7Tob8=
=pxoI
-----END PGP SIGNATURE-----

--3rklnxsuc5paghr6--
