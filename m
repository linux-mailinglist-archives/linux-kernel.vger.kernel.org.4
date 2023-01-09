Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7A26630EB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237301AbjAIUDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237715AbjAIUDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:03:45 -0500
X-Greylist: delayed 45671 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 Jan 2023 12:03:44 PST
Received: from 7.mo584.mail-out.ovh.net (7.mo584.mail-out.ovh.net [178.33.253.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926B615807
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:03:44 -0800 (PST)
Received: from director10.ghost.mail-out.ovh.net (unknown [10.108.20.16])
        by mo584.mail-out.ovh.net (Postfix) with ESMTP id 8A61D24A2E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 20:03:42 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-pr92n (unknown [10.109.156.168])
        by director10.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 007F61FEA6;
        Mon,  9 Jan 2023 20:03:39 +0000 (UTC)
Received: from sk2.org ([37.59.142.98])
        by ghost-submission-6684bf9d7b-pr92n with ESMTPSA
        id 2FQONhtzvGPhugEAufjBpQ
        (envelope-from <steve@sk2.org>); Mon, 09 Jan 2023 20:03:39 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-98R002fae975b0-c3d6-495c-8602-a37db480a49a,
                    796317D5D98EA53ED2B7ABF3FE0FDD27B7A2AA3D) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
Date:   Mon, 9 Jan 2023 21:03:38 +0100
From:   Stephen Kitt <steve@sk2.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-staging@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Helge Deller <deller@gmx.de>, Lee Jones <lee@kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sam Ravnborg via B4 Submission Endpoint 
        <devnull+sam.ravnborg.org@kernel.org>,
        Antonino Daplas <adaplas@gmail.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Robin van der Gracht <robin@protonic.nl>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH 01/15] video: fbdev: atmel_lcdfb: Rework backlight
 handling
Message-ID: <20230109210338.42c993bd@heffalump.sk2.org>
In-Reply-To: <20230109205026.4c672dc8@heffalump.sk2.org>
References: <20230107-sam-video-backlight-drop-fb_blank-v1-0-1bd9bafb351f@ravnborg.org>
        <20230107-sam-video-backlight-drop-fb_blank-v1-1-1bd9bafb351f@ravnborg.org>
        <553AE999-CAF1-4E59-9F3F-68591ED192DE@sk2.org>
        <Y7nb2q6SDota/rTU@ravnborg.org>
        <366FC0B8-21E2-4642-A5A5-CF4B6AB046B0@sk2.org>
        <Y7smdFs2xgJwwVQO@ravnborg.org>
        <20230109205026.4c672dc8@heffalump.sk2.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fAednxbP+nwMmsBkrG4.geO";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Ovh-Tracer-Id: 8295067564944492166
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrkeeigdduvdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfofggtgesghdtreerredtjeenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepgedtieevheduudejjeelheetvdejudehvdejudfggfetteekffevvdehjeekkeefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddrleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeoshhtvghvvgesshhkvddrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkeegpdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fAednxbP+nwMmsBkrG4.geO
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 9 Jan 2023 20:53:44 +0100, Stephen Kitt <steve@sk2.org> wrote:
> On Sun, 8 Jan 2023 21:24:20 +0100, Sam Ravnborg <sam@ravnborg.org> wrote:
> > > Here are my pending patches from last June on lore:
> > >    =20
> >=20
> > All patches are handled I think except this: =20
> > > * https://lore.kernel.org/lkml/20220608205623.2106113-1-steve@sk2.org/
> > >  =20
> >=20
> > Can I ask you to drop the assignment that is not needed, and resend with
> > the collected acks/r-b.
> >=20
> > With this, then all fbdev patches are handled. =20
>=20
> Ah yes, it was revised as
> https://lore.kernel.org/lkml/20220609180440.3138625-1-steve@sk2.org/ which
> only got one ack (from you,
> https://lore.kernel.org/lkml/YqJCKQmQEuVsbspK@ravnborg.org/). Should I
> resend that or is that usable as-is? Or would it be better if I sent all =
the
> fbdev patches again (collecting all the acks and reviews)?

Since the others are already in fbdev/for-next, I=E2=80=99ve just resent v2=
 of this
patch with your ack.

Regards,

Stephen

--Sig_/fAednxbP+nwMmsBkrG4.geO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAmO8cxoACgkQgNMC9Yht
g5wz4BAAij/m9s80FJhymF6GFXJ6JFByUsTaGBWbmyRNRWMW+VPEh24jzlOXCT6m
eTqP1bR1+D+4DEYqRUyD0X7cf+k6KclOs4h83NnXQmVUWJ4KxMffVGWaRaWg3BGD
LgSgo62wCa/tODFoCLVZ9gmDsLfLvrU3ig0SefMgqZTKUNI63JJuVIY3v9upc9Xp
6mrj8xsiB9V5/GMgTlpcaoqTA8wb/OrJb2IvCEhcjFO7gti3LSSQ27VdA2WfGSpD
x+Uok2MBGoSbughl1Q0qD3oQxEkg3jvF94/gXfY40uedF1hBw+A2/mqQJ8XSumxI
H8rUTNeyeYailjBeegv0vhQYXjY3M8NiCbra54kWTRkFaIlORW1empICudxDuMvI
zB/DkEDAp86lpVuzovuUipwazxxbQCWxYDtEtebXKRE8xsai7Q1r6OYUSO0WN5k6
W3wbivddvTD2RjDbs0habIvERgM+A3lfGR4xor2hKL+XUkuw1zMavgRw1f/7Gk2N
J5KECYty3zKbugnM5uBtsnNUobmc1OnmyH7i2tgizTnKccF7Dd7N9WUWlatuEqFQ
+QIOt4j6Ii2FOuc/r122n8qNYePw/jyQZMpTBkUwAO6JH+Rv6NAnTOTCtBsT9lRq
i3mEWOkkOot6W1vgAcoxmZjuFGyI8YLV1rlwGd1ceOkZvHsP8X0=
=GTwo
-----END PGP SIGNATURE-----

--Sig_/fAednxbP+nwMmsBkrG4.geO--
