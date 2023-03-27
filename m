Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2DA6CA2BD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 13:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbjC0Lqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 07:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjC0Lqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:46:37 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357A62713;
        Mon, 27 Mar 2023 04:46:35 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C55E21C0AB3; Mon, 27 Mar 2023 13:46:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1679917593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zFykRxzmTbL7DBBLByyFMIZThBCBkMRsBj1bnaQnEfI=;
        b=TX+T+yKp5DacOLhkpQ4BA8cBSLOVIO3ikm4LDE7/oCmhs0Hj1zKoLT9qTDwqeX9E7yZNag
        bqvc4VBmhBC7TUZksefeTGwAk1IMTeneJXk5NqdWroUMzHRUcV0HnQdgW37H3wyuv46t64
        cVzIRKYzod+VUMAxlt2cqgVHp/O/TAU=
Date:   Mon, 27 Mar 2023 13:46:33 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     ChiaEn Wu <chiaen_wu@richtek.com>
Cc:     corbet@lwn.net, lee@kernel.org, matthias.bgg@gmail.com,
        andriy.shevchenko@linux.intel.com, jacek.anaszewski@gmail.com,
        angelogioacchino.delregno@collabora.com, linux-doc@vger.kernel.org,
        peterwu.pub@gmail.com, cy_huang@richtek.com,
        linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        szunichen@gmail.com, Alice Chen <alice_chen@richtek.com>
Subject: Re: [PATCH v18 1/3] leds: rgb: mt6370: Add MediaTek MT6370 current
 sink type LED Indicator support
Message-ID: <ZCGCGb9E4KYlFNXR@duo.ucw.cz>
References: <cover.1678430444.git.chiaen_wu@richtek.com>
 <1df93a583c3f508a7158b83b95857e9bce235e1b.1678430444.git.chiaen_wu@richtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="D4r0h3j33WbMHnmz"
Content-Disposition: inline
In-Reply-To: <1df93a583c3f508a7158b83b95857e9bce235e1b.1678430444.git.chiaen_wu@richtek.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--D4r0h3j33WbMHnmz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The MediaTek MT6370 is a highly-integrated smart power management IC,
> which includes a single cell Li-Ion/Li-Polymer switching battery
> charger, a USB Type-C & Power Delivery (PD) controller, dual
> Flash LED current sources, a RGB LED driver, a backlight WLED driver,
> a display bias driver and a general LDO for portable devices.
>=20
> Add support for the MediaTek MT6370 Current Sink Type LED Indicator
> driver. It can control four channels current-sink RGB LEDs with 3 modes:
> constant current, PWM, and breath mode.
>=20
> Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Co-developed-by: Alice Chen <alice_chen@richtek.com>
> Signed-off-by: Alice Chen <alice_chen@richtek.com>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>


> +++ b/drivers/leds/rgb/Makefile
> @@ -2,3 +2,4 @@
> =20
>  obj-$(CONFIG_LEDS_PWM_MULTICOLOR)	+=3D leds-pwm-multicolor.o
>  obj-$(CONFIG_LEDS_QCOM_LPG)		+=3D leds-qcom-lpg.o
> +obj-$(CONFIG_LEDS_MT6370_RGB)		+=3D leds-mt6370-rgb.o

I'd preffer leds-mt6370 name. We already have "rgb" in directory
name...

Otherwise looks good. Thanks for doing this.

BR,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--D4r0h3j33WbMHnmz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZCGCGQAKCRAw5/Bqldv6
8i3ZAJ9qQLfE458c3OH+zEji2EkMi7QlSgCeK9mwxBDeevOjUAyXRclkUMQNHsc=
=XX/d
-----END PGP SIGNATURE-----

--D4r0h3j33WbMHnmz--
