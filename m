Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074C85FDA3C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiJMNSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 09:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiJMNSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:18:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7572F197FB2;
        Thu, 13 Oct 2022 06:18:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15E52617A6;
        Thu, 13 Oct 2022 13:18:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504BFC433C1;
        Thu, 13 Oct 2022 13:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665667079;
        bh=ykIpCQcdoqILe12bA6j/YQGVyLMp8Zu4lFFTHjx+wVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dj8nGPq3b8sewX2PINI4u13q4Z1NEXVHCRJprTUlr0W7frv5NYHbkhJHGHV9aCcuz
         KL+bBXC5cSaLJEMyQl2LQZF6IWzojOl39bNCJyMNgIFvm7FICR6/f0Y2dGQTe0+VKl
         cOsGc+XCVzLR9hwkRIL/MvLlsANf27s0m/e4NvABCoV9idrcQdenTCEI85M0aW3kqL
         02NltqAlNYtoXlmgX0IwwSm6t3TWe5PMfQiiX+JCtjgRNMH2TBOZb/fe/GAQfL1RHW
         Kveink+OoIO45T2xpxY8OL9h0fo0+00811nFs376dxHa8uXPjx7gQHuLolq5rUa7Jb
         WpN2Bh/4hC7ug==
Received: by mercury (Postfix, from userid 1000)
        id 650ED106523D; Thu, 13 Oct 2022 15:17:56 +0200 (CEST)
Date:   Thu, 13 Oct 2022 15:17:56 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH 1/4] ARM: dts: omap3-n900: fix LCD reset line polarity
Message-ID: <20221013131756.wzn6pea4thwmwipb@mercury.elektranox.org>
References: <Y0UDEtQlN5Y9h7BU@atomide.com>
 <20221011123726.elsr53ue7nxzhvww@mercury.elektranox.org>
 <Y0V4cLGbYe4j+ls6@google.com>
 <Y0V99Agad6Ma+yTC@atomide.com>
 <Y0V/82JsRVZh6PlL@google.com>
 <Y0WCCw8k+KTuvdWX@atomide.com>
 <41373c20-3b97-ac47-81c8-75bf1bbe3a38@ideasonboard.com>
 <Y0cVw63d3+pAVbd2@google.com>
 <b56197a1-f23d-5f8a-b32d-f8787586364e@ideasonboard.com>
 <Y0fxxsk+e2o0wYZV@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eltypheyjbzocwtf"
Content-Disposition: inline
In-Reply-To: <Y0fxxsk+e2o0wYZV@atomide.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eltypheyjbzocwtf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 13, 2022 at 02:08:54PM +0300, Tony Lindgren wrote:
> Hi,
>=20
> * Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> [221013 06:13]:
> > I would just go with the above for the time being. It should be an easy
> > change, and as these omapfb and drm panel drivers are kind of copies of=
 each
> > other, I think it makes sense to use the same code in both.
>=20
> Maybe if a fix is needed, sure let's fix things first, then drop
> the unused panel drivers.
>=20
> We already have drivers/gpu/drm/panel driver for both of these two
> omapfb panels:
>=20
> drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
> drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
>=20
> The compatible strings used translate to these dts files:
>=20
> arch/arm/boot/dts/motorola-mapphone-common.dtsi
> arch/arm/boot/dts/omap3-n900.dts
> arch/arm/boot/dts/omap3-n950.dts
> arch/arm/boot/dts/omap4-sdp.dts
>=20
> These devices work with omapdrm and there should not be any need to
> stick with the omapfb driver. We can just drop the omapfb panel
> drivers for panel-sony-acx565akm.c and panel-dsi-cm.c. Let's put
> the limited effort where there is activity instead :)

FWIW

Acked-by: Sebastian Reichel <sre@kernel.org>

for removal of those two omapfb panel drivers.

> The vrfb rotation work has been discussed on the lists, so seems
> like we will eventually have that for omapdrm. Meanwhile, software
> rotation is being used for postmarketos and leste with omapdrm
> AFAIK.
>=20
> > That said, I personally don't mind fixing the dts files and the drivers=
, and
> > even dropping the omapfb panel drivers. However, as I don't know if som=
eone
> > needs the omapfb drivers or has to use an old dtb, I don't want to step=
 on
> > that possible mine field. If someone else wants to go there (without my
> > involvement), fine for me =3D).
>=20
> I belive the only valid use case for omap2 omapfb is the n8x0 rfbi
> driver that has no omapdrm driver.

Is that upstream? omapfb (and omapdrm) both have this:

	/*
	 * HACK
	 * We don't have a working driver for rfbi, so skip it here always.
	 * Otherwise dss will never get probed successfully, as it will wait
	 * for rfbi to get probed.
	 */
	if (strstr(dev_name(dev), "rfbi"))
		return 0;

I've seen a few old drivers being removed by marking them as BROKEN
(and updating Kconfig help text to explain the situation). Then the
code is dropped 1-2 cycles later assuming nobody complained.

-- Sebastian

--eltypheyjbzocwtf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmNID/oACgkQ2O7X88g7
+prR2RAAhA6EHZoqVJe/DqbtLqAnVKcWDEnIsciyOK6uDDOBzLz1yBeigzrfGocv
QbKywte+CxYypvgGpxpWXh3WW88R94l3jTm/mbg5knI+Tj/Y7QtJZvZucKYLCK5J
FsIAs7FnVbMZeL8/mEzY4s3IXP6r7JyAzKoIJJbzWfiKYcIriEQO3ywRjbisoq43
45GNxoN2XrFSEtoohzmZBtm5iuOsLqWfB/1uZ4tzNkkJN/6w42i492dxa3yTJU1+
Rb/Fx/DSToRE6XOWF6dkQ7Hl6QT2Gx6SWayZg1ZXyazcbmb0wLZ7XZhMd1ucLhvn
QSbxqjv0tLfCH3abrIz9yCDts631jwCHnRt5lfCbsI6CQcdttKnwKKfFDCizBbsb
BHje9X5abYLNrL+t/At6GrHy/tKVE9IPcQEX6PmdvKCHjSV1x167yI7p/vsRZ+z1
haFlAYkqub0m5Ab8o0rLJNqoK/LtWdAw7gN7sH4EMy6tg3tmrx97/6ClRqZhEOWA
bkztA6jTIi7yzm0zwpzyNGIiI6N0GI6exYRJ/FtFEBWzyALKbJuhPKgPMmBuWX06
mIMK8PSSvCipqjnTeiOl9U43qh4lVCKa1r7WK9zJxEHJVVLlOJcfpdQGBO9IXo6U
U0bcvMuFAu0zMcjEjb89Veq6ulLDkk75aFQJLL1D95wauNw8nw8=
=zZqw
-----END PGP SIGNATURE-----

--eltypheyjbzocwtf--
