Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAC2663328
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237969AbjAIVhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238072AbjAIVft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:35:49 -0500
Received: from 14.mo550.mail-out.ovh.net (14.mo550.mail-out.ovh.net [178.32.97.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D359A3D1C6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 13:34:43 -0800 (PST)
Received: from director2.ghost.mail-out.ovh.net (unknown [10.109.138.143])
        by mo550.mail-out.ovh.net (Postfix) with ESMTP id 37B332476E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 20:19:08 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-frlns (unknown [10.109.138.190])
        by director2.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 7D9691FEFE;
        Mon,  9 Jan 2023 20:19:04 +0000 (UTC)
Received: from sk2.org ([37.59.142.110])
        by ghost-submission-6684bf9d7b-frlns with ESMTPSA
        id 3/0OF7h2vGMDvxAAlD46gA
        (envelope-from <steve@sk2.org>); Mon, 09 Jan 2023 20:19:04 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-110S004842627ec-d049-43fb-8f4c-5212fa5a1396,
                    796317D5D98EA53ED2B7ABF3FE0FDD27B7A2AA3D) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
Date:   Mon, 9 Jan 2023 21:18:57 +0100
From:   Stephen Kitt <steve@sk2.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Sam Ravnborg via B4 Submission Endpoint 
        <devnull+sam.ravnborg.org@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
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
        linuxppc-dev@lists.ozlabs.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH 01/15] video: fbdev: atmel_lcdfb: Rework backlight
 handling
Message-ID: <20230109211857.79856bcf@heffalump.sk2.org>
In-Reply-To: <811a392a-d634-5557-dd58-57f1580e28f2@gmx.de>
References: <20230107-sam-video-backlight-drop-fb_blank-v1-0-1bd9bafb351f@ravnborg.org>
        <20230107-sam-video-backlight-drop-fb_blank-v1-1-1bd9bafb351f@ravnborg.org>
        <553AE999-CAF1-4E59-9F3F-68591ED192DE@sk2.org>
        <Y7nb2q6SDota/rTU@ravnborg.org>
        <811a392a-d634-5557-dd58-57f1580e28f2@gmx.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/JDvLw33J.MlCnUHZ=3B.xEG";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Ovh-Tracer-Id: 8555713393067591302
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrkeeigddufeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfofggtgesghdtreerredtjeenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepfeeljeehvdeuheejudetvdfggfdutdekledvuddthedtkeehhfejffefudegveelnecuffhomhgrihhnpehlkhhmlhdrohhrghdpkhgvrhhnvghlrdhorhhgnecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrdduuddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeoshhtvghvvgesshhkvddrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehhedtpdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JDvLw33J.MlCnUHZ=3B.xEG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 8 Jan 2023 18:26:12 +0100, Helge Deller <deller@gmx.de> wrote:

> On 1/7/23 21:53, Sam Ravnborg wrote:
> > Hi Stephen.
> >
> > On Sat, Jan 07, 2023 at 09:36:47PM +0100, Stephen Kitt wrote: =20
> >> On 7 January 2023 19:26:15 CET, Sam Ravnborg via B4 Submission Endpoint
> >> <devnull+sam.ravnborg.org@kernel.org> wrote: =20
> >>> From: Sam Ravnborg <sam@ravnborg.org>
> >>>
> >>> The atmel_lcdfb had code to save/restore power state.
> >>> This is not needed so drop it.
> >>>
> >>> Introduce backlight_is_brightness() to make logic simpler.
> >>>
> >>> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> >>> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> >>> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> >>> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> >>> Cc: linux-fbdev@vger.kernel.org
> >>> Cc: linux-arm-kernel@lists.infradead.org
> >>> ---
> >>> drivers/video/fbdev/atmel_lcdfb.c | 24 +++---------------------
> >>> 1 file changed, 3 insertions(+), 21 deletions(-) =20
> > ... =20
> >>
> >> Hi Sam,
> >>
> >> I=E2=80=99d submitted quite a few more of these previously (and you=E2=
=80=99d reviewed
> >> them), see e.g. the thread starting at
> >> https://lkml.org/lkml/2022/6/7/4365, and yesterday,
> >> https://lkml.org/lkml/2023/1/6/520, https://lkml.org/lkml/2023/1/6/656,
> >> https://lkml.org/lkml/2023/1/6/970, https://lkml.org/lkml/2023/1/6/643,
> >> and https://lkml.org/lkml/2023/1/6/680. There are a few more, I can fi=
nd
> >> them if it=E2=80=99s any use. =20
> >
> > The patches from yesterday was what triggered me to resurrect an old
> > branch of mine where I had done something similar. I had lost all
> > memory of reviewing similar patches from you.
> >
> >
> > Helge - could you pick the reviewed patches from:
> > https://lore.kernel.org/all/20220607192335.1137249-1-steve@sk2.org/
> > [This is the same mail as Stephen refer to above - looked up via lore].=
 =20
>=20
> I just pulled those 7 patches into fbdev/for-next.
> If you need more, please let me know,

Please pull
https://lore.kernel.org/lkml/20230109200239.1850611-1-steve@sk2.org/ too, it
completes the fbdev set. (It=E2=80=99s a re-send of
https://lore.kernel.org/lkml/20220609180440.3138625-1-steve@sk2.org/).

Thanks,

Stephen

--Sig_/JDvLw33J.MlCnUHZ=3B.xEG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAmO8drEACgkQgNMC9Yht
g5xaOhAAjf3wpZqPQkXA+OJq7x3rFQCxDxu+EC9QfKpc+GTyKDeYUp1CiCaMACTm
CmEva3GpgKshfkWam50r0elXs+IKPn9/Bwu7aoFot55EumgQp5Tbep2Bmzq92XPu
oFvKrneavKK3Zc0y8tMyqnY44egaf1p5ngnCL9KWvgtSxSdqUUc7h1rp8Uevxc16
Svpv5x8AaWNjvHqexEWU7DPoGzWwhCJosdFfzE0E/b5oamL3bCpniVgqvrhZ3XNh
xDDLZsUQPWx6h51ndY44PfUUaF93mHtXo678mlOXIBK4Eb+GCQUTu6FUgWsbIYL9
3zS7n+hYOgrAcvjXD+Kj2EwGAkfAkySAOs98SZYc/P9qzdEPZ7SIA2FbLbXyqf6x
oO7qJlb7PLYCro4L6uSzBYJHK9or4nFh/K0sjWlJMCu3BSHtuDBxpU1+ajilEZYw
GCN2Or9X+vFwQm0GtdpnbwRXutktuUmyEiaTZ0SRswPuK/8o/gc4BjaNdVm7xGld
Yite9fSnhZsSwrT+TsCmoZw4m3W43c5zNs35lcw2LlhZEFnMNhYPAOd6I5zJPKno
SgxxN7R6BxWIiXk7uEt+3CR745R6yGebDDD2G5cR1LtilzKWaj49g4ChgwAjsN5t
uicuFMKEruILdqw6DfjJ5cDi+/1Db3pnP0mdjoiHWmrgigU6wD0=
=3DFt
-----END PGP SIGNATURE-----

--Sig_/JDvLw33J.MlCnUHZ=3B.xEG--
