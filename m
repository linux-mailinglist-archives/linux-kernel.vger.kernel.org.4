Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D0D6618B8
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 20:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbjAHTmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 14:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbjAHTma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 14:42:30 -0500
X-Greylist: delayed 319 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 08 Jan 2023 11:42:03 PST
Received: from 7.mo583.mail-out.ovh.net (7.mo583.mail-out.ovh.net [178.32.124.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686A6E015
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 11:42:03 -0800 (PST)
Received: from director7.ghost.mail-out.ovh.net (unknown [10.109.156.215])
        by mo583.mail-out.ovh.net (Postfix) with ESMTP id 6D1DB23DFD
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 19:36:42 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-wl7j5 (unknown [10.109.138.190])
        by director7.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 18A311FED9;
        Sun,  8 Jan 2023 19:36:39 +0000 (UTC)
Received: from sk2.org ([37.59.142.106])
        by ghost-submission-6684bf9d7b-wl7j5 with ESMTPSA
        id Tf9QAUcbu2N19wAAid5/uw
        (envelope-from <steve@sk2.org>); Sun, 08 Jan 2023 19:36:39 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-106R0064db9debf-ab59-4406-8e3b-2900436b4735,
                    5128B599F7D401446F64D4771BE19AB2B9CD7A8B) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
Date:   Sun, 8 Jan 2023 20:36:37 +0100
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
Subject: Re: [PATCH 11/15] powerpc: via-pmu-backlight: Introduce
 backlight_get_brightness()
Message-ID: <20230108203637.0eb346fb@heffalump.sk2.org>
In-Reply-To: <20230107-sam-video-backlight-drop-fb_blank-v1-11-1bd9bafb351f@ravnborg.org>
References: <20230107-sam-video-backlight-drop-fb_blank-v1-0-1bd9bafb351f@ravnborg.org>
        <20230107-sam-video-backlight-drop-fb_blank-v1-11-1bd9bafb351f@ravnborg.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uukmOXDDn4g_OXGHTWj0dxU";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Ovh-Tracer-Id: 1966384190180525702
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrkeeggddufedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfofggtgesghdtreerredtvdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepfeffgefhgfeuueeffeejieefieefgfefffethfdtudegvdejueelhffhfeegjeeinecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrddutdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeoshhtvghvvgesshhkvddrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkeefpdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uukmOXDDn4g_OXGHTWj0dxU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 07 Jan 2023 19:26:25 +0100, Sam Ravnborg via B4 Submission Endpoint
<devnull+sam.ravnborg.org@kernel.org> wrote:

> From: Sam Ravnborg <sam@ravnborg.org>
>=20
> Introduce backlight_get_brightness() to simplify logic
> and avoid direct access to backlight properties.
>=20
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  drivers/macintosh/via-pmu-backlight.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>=20
> diff --git a/drivers/macintosh/via-pmu-backlight.c
> b/drivers/macintosh/via-pmu-backlight.c index 2194016122d2..c2d87e7fa85b
> 100644 --- a/drivers/macintosh/via-pmu-backlight.c
> +++ b/drivers/macintosh/via-pmu-backlight.c
> @@ -71,12 +71,7 @@ static int pmu_backlight_get_level_brightness(int leve=
l)
>  static int __pmu_backlight_update_status(struct backlight_device *bd)
>  {
>  	struct adb_request req;
> -	int level =3D bd->props.brightness;
> -
> -
> -	if (bd->props.power !=3D FB_BLANK_UNBLANK ||
> -	    bd->props.fb_blank !=3D FB_BLANK_UNBLANK)
> -		level =3D 0;
> +	int level =3D backlight_get_brightness(bd);
> =20
>  	if (level > 0) {
>  		int pmulevel =3D pmu_backlight_get_level_brightness(level);
>=20
> --=20
> 2.34.1

This one is already in 6.2-rc1, it went in via powerpc/next.

Regards,

Stephen

--Sig_/uukmOXDDn4g_OXGHTWj0dxU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAmO7G0UACgkQgNMC9Yht
g5xMrQ/+PwvgQ0CHCn8HmbOrtCc6qRRFkBMOMZAVkGha3M3hYGioht4oHn4GrnMy
TjIR7v3/JOkUdOLbjB/64to5DRhpRA1ViZ5+rzli6mJQi4D/vcf83SUedofbYnjy
L/qOMiT/c73cpoldhKsOkvgATQSLfTQfddDthcS09XVmldfqgxqcEtSrnJ6cJ3QT
eguOeI9WR/MqVNXT8y+NYlQttBWVAk0xoZQJgQcFBt5pS41b8Eql9n7A7+Zn5cxs
fZLnmt9N2ul1oWFIc75dwcd803z/huqueMI/lnZ/ClSPuO2Cyvy75j9MOeWdOqBt
iFQFUSATbNJS+WqXZQ2Tgxdz2f84jqDheSB3znCijKJuRZT9Z8JyncQKElbaqayB
bTUIOcxFQUjQzSj01lRLrvV8R+xoZwSjJzL+DDev9FKbqXrS6lPVh2ZjGveJWvXy
5ERsDt/BScQ0LqR2e7UjXh3md0NGHBts8eQM+sLGSeHp6R8CyxP6et3GdGJrQdBF
BfDGcN/PbNufCzTxuVMEEYXkNDqxTtvz/V+rNJJS9KkeEYp8rp4kQIbC00TXDIDQ
ZekvV+TKZ4JkqEX+z44qRw+kI0mza8D9FUCx8mxh20WU1JVRtr1IGc8zyl8Y1wu1
0vLNwdTdxVfj8Z7NnIvcI8RxxcwZVT/XoIXauX9N3/iintzk5G8=
=ImCK
-----END PGP SIGNATURE-----

--Sig_/uukmOXDDn4g_OXGHTWj0dxU--
