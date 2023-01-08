Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD386618CF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 20:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbjAHTr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 14:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbjAHTr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 14:47:27 -0500
X-Greylist: delayed 187 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 08 Jan 2023 11:47:26 PST
Received: from 1.mo575.mail-out.ovh.net (1.mo575.mail-out.ovh.net [46.105.41.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D00DBCA4
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 11:47:26 -0800 (PST)
Received: from director9.ghost.mail-out.ovh.net (unknown [10.108.20.16])
        by mo575.mail-out.ovh.net (Postfix) with ESMTP id 658B521440
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 19:32:18 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-rxrrl (unknown [10.110.208.237])
        by director9.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 531A61FED5;
        Sun,  8 Jan 2023 19:32:17 +0000 (UTC)
Received: from sk2.org ([37.59.142.102])
        by ghost-submission-6684bf9d7b-rxrrl with ESMTPSA
        id GQDvD0Eau2MQfAAAaOw9AQ
        (envelope-from <steve@sk2.org>); Sun, 08 Jan 2023 19:32:17 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-102R004bd0c23e1-a184-484d-af6b-234daf9726ce,
                    5128B599F7D401446F64D4771BE19AB2B9CD7A8B) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
Date:   Sun, 8 Jan 2023 20:32:15 +0100
From:   Stephen Kitt <steve@sk2.org>
To:     Sam Ravnborg via B4 Submission Endpoint 
        <devnull+sam.ravnborg.org@kernel.org>
Cc:     <sam@ravnborg.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
        Helge Deller <deller@gmx.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Antonino Daplas <adaplas@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>, Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-staging@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 13/15] backlight: omap1: Use backlight helpers
Message-ID: <20230108203215.30037a70@heffalump.sk2.org>
In-Reply-To: <20230107-sam-video-backlight-drop-fb_blank-v1-13-1bd9bafb351f@ravnborg.org>
References: <20230107-sam-video-backlight-drop-fb_blank-v1-0-1bd9bafb351f@ravnborg.org>
        <20230107-sam-video-backlight-drop-fb_blank-v1-13-1bd9bafb351f@ravnborg.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GypAq4FXG4m.CwTF5BhTXQF";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Ovh-Tracer-Id: 1892074796039898758
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrkeeggdduvdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfofggtgesghdtreerredtvdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepfeffgefhgfeuueeffeejieefieefgfefffethfdtudegvdejueelhffhfeegjeeinecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrddutddvnecuvehluhhsthgvrhfuihiivgepieenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeoshhtvghvvgesshhkvddrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehjeehpdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GypAq4FXG4m.CwTF5BhTXQF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 07 Jan 2023 19:26:27 +0100, Sam Ravnborg via B4 Submission Endpoint
<devnull+sam.ravnborg.org@kernel.org> wrote:

> From: Sam Ravnborg <sam@ravnborg.org>
>=20
> Rework backlight handling to avoid access to the deprecated
> backlight_properties.fb_blank member.
>=20
> The rework includes removal of get_brightness() operation,
> because there was no read back from HW so no use for it.
>=20
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> ---
>  drivers/video/backlight/omap1_bl.c | 67
> +++++--------------------------------- 1 file changed, 9 insertions(+), 58
> deletions(-)
>=20
> diff --git a/drivers/video/backlight/omap1_bl.c
> b/drivers/video/backlight/omap1_bl.c index 69a49384b3de..49f37da857e7 100=
644
> --- a/drivers/video/backlight/omap1_bl.c
> +++ b/drivers/video/backlight/omap1_bl.c
> @@ -20,9 +20,6 @@
>  #define OMAPBL_MAX_INTENSITY		0xff
> =20
>  struct omap_backlight {
> -	int powermode;
> -	int current_intensity;
> -
>  	struct device *dev;
>  	struct omap_backlight_config *pdata;
>  };
> @@ -37,82 +34,40 @@ static inline void omapbl_send_enable(int enable)
>  	omap_writeb(enable, OMAP_PWL_CLK_ENABLE);
>  }
> =20
> -static void omapbl_blank(struct omap_backlight *bl, int mode)
> -{
> -	if (bl->pdata->set_power)
> -		bl->pdata->set_power(bl->dev, mode);
> -
> -	switch (mode) {
> -	case FB_BLANK_NORMAL:
> -	case FB_BLANK_VSYNC_SUSPEND:
> -	case FB_BLANK_HSYNC_SUSPEND:
> -	case FB_BLANK_POWERDOWN:
> -		omapbl_send_intensity(0);
> -		omapbl_send_enable(0);
> -		break;
> -
> -	case FB_BLANK_UNBLANK:
> -		omapbl_send_intensity(bl->current_intensity);
> -		omapbl_send_enable(1);
> -		break;
> -	}
> -}
> -
>  #ifdef CONFIG_PM_SLEEP
>  static int omapbl_suspend(struct device *dev)
>  {
>  	struct backlight_device *bl_dev =3D dev_get_drvdata(dev);
> -	struct omap_backlight *bl =3D bl_get_data(bl_dev);
> =20
> -	omapbl_blank(bl, FB_BLANK_POWERDOWN);
> +	backlight_disable(bl_dev);
>  	return 0;
>  }
> =20
>  static int omapbl_resume(struct device *dev)
>  {
>  	struct backlight_device *bl_dev =3D dev_get_drvdata(dev);
> -	struct omap_backlight *bl =3D bl_get_data(bl_dev);
> =20
> -	omapbl_blank(bl, bl->powermode);
> +	backlight_enable(bl_dev);
>  	return 0;
>  }
>  #endif
> =20
> -static int omapbl_set_power(struct backlight_device *dev, int state)
> -{
> -	struct omap_backlight *bl =3D bl_get_data(dev);
> -
> -	omapbl_blank(bl, state);
> -	bl->powermode =3D state;
> -
> -	return 0;
> -}
> -
>  static int omapbl_update_status(struct backlight_device *dev)
>  {
> -	struct omap_backlight *bl =3D bl_get_data(dev);
> +	int brightness =3D backlight_get_brightness(dev);
> =20
> -	if (bl->current_intensity !=3D dev->props.brightness) {
> -		if (bl->powermode =3D=3D FB_BLANK_UNBLANK)
> -			omapbl_send_intensity(dev->props.brightness);
> -		bl->current_intensity =3D dev->props.brightness;
> +	if (brightness > 0) {
> +		omapbl_send_intensity(dev->props.brightness);
> +		omapbl_send_enable(1);
> +	} else {
> +		omapbl_send_intensity(0);
> +		omapbl_send_enable(0);
>  	}
> =20
> -	if (dev->props.fb_blank !=3D bl->powermode)
> -		omapbl_set_power(dev, dev->props.fb_blank);
> -
>  	return 0;
>  }
> =20
> -static int omapbl_get_intensity(struct backlight_device *dev)
> -{
> -	struct omap_backlight *bl =3D bl_get_data(dev);
> -
> -	return bl->current_intensity;
> -}
> -
>  static const struct backlight_ops omapbl_ops =3D {
> -	.get_brightness =3D omapbl_get_intensity,
>  	.update_status  =3D omapbl_update_status,
>  };
> =20
> @@ -139,9 +94,6 @@ static int omapbl_probe(struct platform_device *pdev)
>  	if (IS_ERR(dev))
>  		return PTR_ERR(dev);
> =20
> -	bl->powermode =3D FB_BLANK_POWERDOWN;
> -	bl->current_intensity =3D 0;
> -
>  	bl->pdata =3D pdata;
>  	bl->dev =3D &pdev->dev;
> =20
> @@ -149,7 +101,6 @@ static int omapbl_probe(struct platform_device *pdev)
> =20
>  	omap_cfg_reg(PWL);	/* Conflicts with UART3 */
> =20
> -	dev->props.fb_blank =3D FB_BLANK_UNBLANK;
>  	dev->props.brightness =3D pdata->default_intensity;
>  	omapbl_update_status(dev);
> =20
>=20
> --=20
> 2.34.1

Wow that gets rid of a lot of unnecessary code!

Reviewed-by: Stephen Kitt <steve@sk2.org>

--Sig_/GypAq4FXG4m.CwTF5BhTXQF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAmO7GkAACgkQgNMC9Yht
g5wbPw//Ss+kTsAfHvbPabK9dJV/X66aYDEyoOZ3yDLe6E2BoTflL+WrHBw8VFNa
AJvgfHwrJ1T4yIWpz0T/hzHKeO1gx0bj+VMDMJnCwGueAAZoz3rE9NXDPclWfqzb
LkSkCDgIu44dDRbvFE3Sd0azg0lN35evn+zyEqbpw+QKfsv5O3S+LX9iY2rkLXcv
CkEynsPcOzfQSUBMgCvrvkDK0L0Gi0OghVh5WEnYfB0RMs31qFaEd8i+maho3DKP
p78tgvWNxAw62OxEvlXK66XvibuCJpwsVmDCN6pLZXQCqmIUgUa3U6PS3kINzIVp
vd0Mlca7QxaPrqWINi8SQhO8O9bVhQWK5FgPP719ay6QGtyR85FhNsW5DZQHG7yd
kxrvExOJDvZ0GnrAvSNGPrPXqp/rlelpeHW4dyf67t8bQkpaUIsNYVha0XrhuZv9
tFwdW5RA0Ay/uqReXzMn+qXJqcakZ0YBsRunzpSjvXC2ejg8K056tncizpvAFY6o
B427h2bO5F1gZ83eXMFVNuhxk8ve2Bi4A62l2J0lJb1UZNuLy0I2YSTgvvOlHN/E
GCsrQFZZc6T0ETq1STqS1b8yGFbB47xQTluCqOD5Pk91cisLsUL7uFAyI/6HnbrA
gdlHJTW4bxnEHedzYUUIW40PlyoAW01YP3dvwrUSUgFvQqJQfAs=
=WGiV
-----END PGP SIGNATURE-----

--Sig_/GypAq4FXG4m.CwTF5BhTXQF--
