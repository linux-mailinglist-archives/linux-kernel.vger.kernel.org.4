Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFBB7283B2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237070AbjFHPYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236309AbjFHPY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:24:26 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11E72D7E;
        Thu,  8 Jun 2023 08:24:10 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 0F3BC5C01E9;
        Thu,  8 Jun 2023 11:24:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 08 Jun 2023 11:24:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1686237850; x=1686324250; bh=IUwV7Mu/3eeunQeH2XK30qt0uf9HHgiQtGt
        /LtpN1XE=; b=qkWSqIIhlL3j6f0o2QA3qjwAhifNX1DVceBxIUx80pu40CAbu00
        rG8BdFX5TCACouopEHlb/IMkNI6qtZMhwvR1Gpd2ltEgWLJhh+qDJTfx9LUwP2U+
        o0Fnd4VynfaIdgELqjIQRNOIHQhlhIOySyb7sxw+A8h9WXGlJLNX5TuEaelLmWl9
        IHXDFCtEKOBWm53s1hjhnawK1T6f4p0vAdJAR1bHw0WcxN/w0tYVo7/wNliOfqVw
        QFshIhJe7kV1vhILMaT6wk7/PswRPwurSQM0aCBHgAisq8tgX3p1f37FDNrrNYlb
        KFbLXDHXtO5kNgHG2pvFIdm2g/n67mDPTdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686237850; x=1686324250; bh=IUwV7Mu/3eeun
        QeH2XK30qt0uf9HHgiQtGt/LtpN1XE=; b=Wp7Efil1kW9JdynZmx2MHe+A9VB/H
        TzHbaEQQCyWkxQ1ekigse3L5qwdYtyNNlAl5Gc0Q38lykiETgRSoo/IADKhUr1P1
        PLZwmj2CWn1DNebeSS2a+J8JfTI6EhHn95VkHFtWe7bWG4VOeDVfbgwIJM8LFt9w
        3lsWcrcB6a58Whlq4ynJ8YLYzmJ9dOXcFmWOUmDJVnfR8scNHQ0LZ5FrErrW+bJt
        aHAcspBnYmYdLtxeQqvmSBpYyBmaV2jT6bT4bzaq+7AM5k4anQ1dCc8eMbqEanct
        4j3nErhC4feMyerw6a4iCzJH247hXmm4itdQUHnSBPlX9s8ffOuagZSTw==
X-ME-Sender: <xms:mfKBZOxI1o0PYMqIpPuxIUxANT07tGV5lD0i5iGnsIjqHBkIC7HOfQ>
    <xme:mfKBZKQwRxPpdELe6J4ZFN-vjgmvg3Rp91LnJGWA0SpSoX8Dj2Cp0uaUvOPPE7xwz
    1kfOR56rI4jzkI>
X-ME-Received: <xmr:mfKBZAVmkzE4rEcFIEIMuhqkaXhVUZbLXu4fn6VNwXoAos7KHXa2UBvGFZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtiedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepvdejteegkefhteduhffgteffgeff
    gfduvdfghfffieefieekkedtheegteehffelnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:mfKBZEha6jDGZjXc0JmuBhTWJJEpwJXdEcExcinxHBVYjkNgUiJ1Jw>
    <xmx:mfKBZADliEfQ41_FA0gBOwXt0thVTYm3OWhulErEFW9hhaffRUIWNw>
    <xmx:mfKBZFId7g--5ZFhk3WSRKZI_EhndyUtmSTEl5e3Te3TsuDsLVwvnA>
    <xmx:mvKBZC3BV-Ydv-Jp1hyhHhc-_ehW1LoJyYt6Zuki_sIl6b1uJ0ai-Q>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jun 2023 11:24:09 -0400 (EDT)
Date:   Thu, 8 Jun 2023 11:24:06 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 16/16] xen-blkback: Inform userspace that device has
 been opened
Message-ID: <ZIHyl3skhh/Yy5fe@itl-email>
References: <20230530203116.2008-1-demi@invisiblethingslab.com>
 <20230530203116.2008-17-demi@invisiblethingslab.com>
 <ZIGot1mn+lChK4q8@Air-de-Roger>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DG4zdBvb0kvaNjmD"
Content-Disposition: inline
In-Reply-To: <ZIGot1mn+lChK4q8@Air-de-Roger>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DG4zdBvb0kvaNjmD
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Thu, 8 Jun 2023 11:24:06 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
Cc: Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 16/16] xen-blkback: Inform userspace that device has
 been opened

On Thu, Jun 08, 2023 at 12:08:55PM +0200, Roger Pau Monn=C3=A9 wrote:
> On Tue, May 30, 2023 at 04:31:16PM -0400, Demi Marie Obenour wrote:
> > Set "opened" to "0" before the hotplug script is called.  Once the
> > device node has been opened, set "opened" to "1".
> >=20
> > "opened" is used exclusively by userspace.  It serves two purposes:
> >=20
> > 1. It tells userspace that the diskseq Xenstore entry is supported.
> >=20
> > 2. It tells userspace that it can wait for "opened" to be set to 1.
> >    Once "opened" is 1, blkback has a reference to the device, so
> >    userspace doesn't need to keep one.
> >=20
> > Together, these changes allow userspace to use block devices with
> > delete-on-close behavior, such as loop devices with the autoclear flag
> > set or device-mapper devices with the deferred-remove flag set.
>=20
> Now that I think a bit more about this, how are you planning to handle
> reboot with such devices?  It's fine for loop (because those get
> instantiated by the block script), but likely not with other block
> devices, as on reboot the toolstack will find the block device is
> gone.
>=20
> I guess the delete-on-close is only intended to be used for loop
> devices? (or in general block devices that are instantiated by the
> block script itself)

You understand correctly.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--DG4zdBvb0kvaNjmD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmSB8pcACgkQsoi1X/+c
IsFDgg/+LvYLn6bwcjUeONWEIyGKyw603h+1aYfMvgtLZNeFOldTtAfcVOMlZy8y
SSlLFAqfePxh7n7mCyi03wisScbGDY+iDNI+6Y0pmCKmrKXzZEKkRdXld9mejI/c
Sp5g2yz9lEV0lwqrX4vBMFux41AdCe9CwTxQ072RQabojUem8EdmvV82l88YJrBU
ZPe6mgZEknzAIDrbth/FIA7eowKITBrEwdDmdsHw1HzGzJcHbfpzdxKgcdg0r/b0
cqf2DdIi1DHUsCzjTILR6akwxuprAvEArGy00iB+wS+eXfZBZIBlLrwsAFYSwZSD
tRAZ0BgjeL5b0MxTP5KP1rRB6p4hBPxVyuBduDEaaBdsNJJcAHGDgiuvkTVKqMZM
HzaSWI9HCuJ/xIRTtAd620ogZDwlzjkVsc3vHo++hDEF3WvwEaKjfNjvVr1wg4HC
NQ+Tc4JllfsJgwAp6D7zsEAL/KwlcoQqZYf1o/Z9ukjCU+iRL9NXhPtMPX4Kjdqn
HPdBnnjAU8dyMebH0N4ltPt6CZw9cQ1V43QtJy89OpEt0PqF7BkIRkdXZ3yw8pAN
jCjWYIKy54g5Qzm3G/zQ7J3oc83/o0KWdZIfpZCWdZmO3mHD3i2fb/opIngDxsbR
M9HcUCFwbGOuwQ97S4t2XB2dXP106oxDkCRphDEwDFq9BpWmxQQ=
=wJOc
-----END PGP SIGNATURE-----

--DG4zdBvb0kvaNjmD--
