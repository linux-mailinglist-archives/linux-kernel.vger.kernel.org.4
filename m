Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EB368DDCE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbjBGQTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbjBGQTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:19:30 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCCF83EA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 08:19:29 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id A9E78320016F;
        Tue,  7 Feb 2023 11:19:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 07 Feb 2023 11:19:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1675786765; x=
        1675873165; bh=KrfmSrDkm//BSwsEycuDONuPAOVzLiga9Uqg5PG0Wpo=; b=d
        OtoLEwCndNUNNfu+mAZmuiJh5dhk7wK2Ax1nY9hBBMnjzFjZxrrEUmWD7j//RexS
        dhl0LnKhuMd9m8z5d+DkpveJ45g4IImZaz6rkocvVigCBuwmoAVPPDl78lw+7q3b
        VHYWS6HF6KhgIgBGSCi7xQ8R8Qfgl4XZWtL8AyXXFKjfxo6pkLAUXOedR/sJ3w5P
        oBz1WVyEl6vsyb79UOd94kMnrAZJMHvBVoD1/2Q03dM1CIzmz53J7PDIdgxtb36m
        kyaiDLR3LUWG3vSkKVMZXTOJCcybnqhErD76guRN1GhXi6+MBO2kQMOVWJFfN87j
        6yW4UWMq1nYWegBR6gVuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675786765; x=1675873165; bh=KrfmSrDkm//BSwsEycuDONuPAOVz
        Liga9Uqg5PG0Wpo=; b=DQlyYVXQamLdndjZR1/V7bBTpBiXNyW2+w+zIJHrYCv1
        rsRrgRvznCNE/vI4B7+4U0QMbVwv/3oPoLWB2pqfvahKfjQO5Q67NjvA6n+2nRVH
        TyX4nDgcuOCZjzVnnB/e6sJKF3Rnjbd998UM3NP+egulN+Oxil+Yd5W38zw6U/LQ
        pKRjiVp1gR0KeabFmDFQcv/xjN5uRPHv5PdFZrdITMn70CfDbOlotsoUpg5dtjkK
        fs4/Tv3KaUohoVjmzB8MgKp3eln8I5C/x6IYpRmR7QuEk6TakVS+lZl2YiL4aQLs
        iHKiivvJuxFPzj71obM11B/ESj9o7pXk6U/e5szU0A==
X-ME-Sender: <xms:DXriYyBDbgqpat3Jk2biqZ9Nb_SKRZWbw7EoereqxAuREpA9dd0Zng>
    <xme:DXriY8hwt2ojVITKISaVzYIWgQVBdXOMeIgWeJMaYH_wzTeYG7gxmHe5CR4Blzp9X
    wioFQBoIVNuChY>
X-ME-Received: <xmr:DXriY1kNL581gjeick9_HKeKE3vQU66urjZODwvZE8N--pG57Px8MtdeJY8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegkedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepudeileefueetvdelheeuteffjeeg
    jeegffekleevueelueekjeejudffteejkeetnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:DXriYwwR9s30cJkCtOSnUSn3VcHm2PJYlh2y2FrZPvZp76RpyAgc0Q>
    <xmx:DXriY3TOaSBztWGuKHSrZXhC4Yp5zkoxaUvVGp-I_ow1XIK0QFrwPQ>
    <xmx:DXriY7a7X0hRXZCx8JLKlFkHz28Sgx10X_Qgwk9SIb0Kc9bsOsfugw>
    <xmx:DXriYxei49rKiCKNiIwI0RqNqwCtMnm-pK7LsMYBgVnYfOhiFdfRCg>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Feb 2023 11:19:24 -0500 (EST)
Date:   Tue, 7 Feb 2023 11:19:19 -0500
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Joe Thornber <thornber@redhat.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-kernel@vger.kernel.org
Subject: Re: [dm-devel] [PATCH 1/2] Fail I/O to thin pool devices
Message-ID: <Y+J6CgDVnBlW3pO+@itl-email>
References: <20230207011849.1343-1-demi@invisiblethingslab.com>
 <CAJ0trDZsTcD43s3GQ7aKR_3eABWv0rREMrajw8xBQiu96X+B8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m1OVs7FAMuWaSnHQ"
Content-Disposition: inline
In-Reply-To: <CAJ0trDZsTcD43s3GQ7aKR_3eABWv0rREMrajw8xBQiu96X+B8w@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m1OVs7FAMuWaSnHQ
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 7 Feb 2023 11:19:19 -0500
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Joe Thornber <thornber@redhat.com>
Cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	dm-devel@redhat.com,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [dm-devel] [PATCH 1/2] Fail I/O to thin pool devices

On Tue, Feb 07, 2023 at 03:02:51PM +0000, Joe Thornber wrote:
> Nack.
>=20
> I don't see the security issue; how is this any different from running the
> thin tools on any incorrect device?  Or even the data device that the pool
> is mirroring.

I special-cased the pool device for two reasons:

1. I have run the thin tools on the pool device myself before realising
   that they needed to be run on the metadata device.  It took me a
   while to realize that I was using the wrong device.  I have not made
   that mistake with other devices, which is why I special-cased the
   pool device in this patch.

2. Doing I/O to the pool device is pointless.  The pool device is
   strictly slower than the data device and exposes the exact same
   contents, so accessing the pool device directly is never what one
   wants.

If there are backwards compatibility concerns, I could make this be
controlled by a Kconfig option, module parameter, or both.

> In general the thin tools don't modify the metadata they're
> running on.  If you know of a security issue with the thin tools please l=
et
> me know.

I am not aware of a concrete security problem, but in general I prefer
not to expose unnecessary attack surface.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--m1OVs7FAMuWaSnHQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmPiegoACgkQsoi1X/+c
IsHkYw/+LTzTC8ug1ruR4e+mUmoP2RCdrC8KFvx7cij6HJHKKUYi4KpCz/OKbYVH
QADgI2McT/0jHWIamXJ+J6gH7HjRS9MJv5HBSjmnG2AHJaFJh+gnv16OYwLhCVTE
wuGUrvLwSzwJj+Nlkn3q699tDob12x3p54tLDcM08EuKB+jqOzxYXQieOwvEADWM
qdLksdx5dG7eSJjo5GMqotJUBFxoBnkIIRmDqhTAyXOHsdMqceGGvkhfubrifz8v
oWn9Gat90HVS6i7qwkwOu02mNwCPGqD3oCz8lk/eUrSFjeAkOvyeXV6FjYXjY9f3
t55cByzDHmaRn6CzkIRdkkg7GeMBcxpPSzyodc8Fkr9eR28beEkGJ0dpFMFt2TTL
XqulnLVae4ZZ0OobiUGnwK0dgmQY03sKgGwp0/BoAGjIjgueLC/5BlcHUDTZmsTv
3aSihwfvvyY8POBrv46nsf8ONTBETu6u39YGk8Q7zagTxP2SBlns0IBbVIll+CZY
3egP7e/CTZVlCbeI/5zmakwB5R0hNqUMyW5SLX/rvoz+w9W2AbR1jxUmCOye8wNE
kJ3Cuv9u2UcN78pR4DZDnh9Np0nlWHxAq+jQSeovYzbTiUVe0+K0c40Zo0J2tCrl
E+UT4FGfeBAbY/AB2S19OgxRTNLMN0TO5HHUdlMV7+C9h+aubd4=
=OCkT
-----END PGP SIGNATURE-----

--m1OVs7FAMuWaSnHQ--
