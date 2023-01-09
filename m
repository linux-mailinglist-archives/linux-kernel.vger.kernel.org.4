Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76598661F14
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 08:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbjAIHTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 02:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjAIHTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 02:19:13 -0500
X-Greylist: delayed 42291 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 08 Jan 2023 23:19:11 PST
Received: from 12.mo584.mail-out.ovh.net (12.mo584.mail-out.ovh.net [178.33.104.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7041275B
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 23:19:11 -0800 (PST)
Received: from director4.ghost.mail-out.ovh.net (unknown [10.109.156.6])
        by mo584.mail-out.ovh.net (Postfix) with ESMTP id E53D5236C2
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 07:11:45 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-d49t7 (unknown [10.110.171.144])
        by director4.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 510651FE5B;
        Mon,  9 Jan 2023 07:11:45 +0000 (UTC)
Received: from sk2.org ([37.59.142.97])
        by ghost-submission-6684bf9d7b-d49t7 with ESMTPSA
        id fAHTEDG+u2OKGQ8AOFPK8w
        (envelope-from <steve@sk2.org>); Mon, 09 Jan 2023 07:11:45 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-97G0024828470a-7050-4627-9617-550785b01b9b,
                    796317D5D98EA53ED2B7ABF3FE0FDD27B7A2AA3D) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
Date:   Mon, 9 Jan 2023 08:11:44 +0100
From:   Stephen Kitt <steve@sk2.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] auxdisplay: ht16k33: Use backlight helper
Message-ID: <20230109081144.5a6ceeb0@heffalump.sk2.org>
In-Reply-To: <Y7sk51V5d3P+Uk8x@ravnborg.org>
References: <20230106143002.1434266-1-steve@sk2.org>
        <CAMuHMdWvOx+K+eQfpC-t2jfkVTQOa+SBorwi=LKmUdW7VPwjig@mail.gmail.com>
        <CANiq72nnyxq_JhCETL+v1zQuU=HHjsS66Lt=0bzQ6Xy6CPKN2Q@mail.gmail.com>
        <CAMuHMdUNze0mL=2VOLPj5kE3Lsa3B3bzN_WipC_v=CddNNSJfQ@mail.gmail.com>
        <CANiq72=8T4=NhxLqeV0vgynRB0+gy9VnddZNTKXP75UfVPnc+Q@mail.gmail.com>
        <Y7sk51V5d3P+Uk8x@ravnborg.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XCTMHGblIB+aBzhx79756hE";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Ovh-Tracer-Id: 13704735144836236934
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrkeehgddutdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfofggtgesghdtreerredtjeenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepgedtieevheduudejjeelheetvdejudehvdejudfggfetteekffevvdehjeekkeefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddrleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeoshhtvghvvgesshhkvddrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkeegpdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XCTMHGblIB+aBzhx79756hE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 8 Jan 2023 21:17:43 +0100, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Sun, Jan 08, 2023 at 08:11:52PM +0100, Miguel Ojeda wrote:
> > On Sun, Jan 8, 2023 at 7:32 PM Geert Uytterhoeven <geert@linux-m68k.org>
> > wrote: =20
> > >
> > > Oh, I sent it here because of
> > > https://lore.kernel.org/all/Y7qM+ZlG5gQiOW4K@ravnborg.org ? =20
> >=20
> > Yeah, sorry. I mentioned it just in case, since Sam asked for Robin's
> > Ack in that thread, but I should have probably just Cc'd him here
> > (done!)... =20
>=20
> Stephen notified me that the patch is already applied - so no need for
> anything now. Sorry for the noise!

That was the via-pmu-backlight patch; AFAIK the ht16k33 patch hasn=E2=80=99=
t been
applied anywhere yet.

Regards,

Stephen

--Sig_/XCTMHGblIB+aBzhx79756hE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAmO7vjAACgkQgNMC9Yht
g5wh1g//al9zX/rDLXUuo6/L9PlosL+Djb5EEKvqCU0YTRY8XNBj42zhYG2YgItg
iAuTIeIHALt9UjpQaXcz1z/thO4FHChRhJcWmwLCIxnnICI1QXP76fknpnsdfmKJ
JYicFaZEEZJgNGfQ5pdrHWU16a6xwcJnCOhgiJ3hZQEDAG2EmhnzeutukVKAfCcm
0AKR5CfTeLTWCMoE5Moz4jaF2PSrGjCZLnusNRgO13DEfAlpCIvoiIiYs+HEIjVc
MrLtuGdfBOY+DkKjqooII1hyC66GUS9L1Z7yQwu4y8nxrXtAHVGXvyW7N1KC++AU
hmgly7u/zxG7zDKTu+xFlhTaUbJKh9/hyECEk76t83JR14fwZVFWK6HmWmfmlD3C
RzmFh/28ZCWm7Me7cRG2ooiejS4hVYX00lKaRTJgBFOhUdbozGJ0/5od4obpHVly
N8FLbNfWoLavXIOI4PgXl1ncX0pc+cme3nMkgSSNUyo5M7GwFi/SlLqq6U3CY0OJ
3pY7rX4arUZOtPRwkE8RwYnRb3AOAEc9jrMB3wePu2jT7G/2RkfQizX7qk4+IGlZ
zKhJ/km/5mMGDVQMUyP0JZlmoX7pzlTrRW/pXzbMxK0Jvw5b0Ko2XOJTsuDLzjqo
qisDpPcc4zRXyvcH6a5+ubAWrZHE8+SLWnBC9EZi3Dlc1rTLwCw=
=B4BV
-----END PGP SIGNATURE-----

--Sig_/XCTMHGblIB+aBzhx79756hE--
