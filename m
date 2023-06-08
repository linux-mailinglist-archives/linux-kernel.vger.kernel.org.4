Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9355A7283A8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236793AbjFHPXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjFHPXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:23:18 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943AB26AD;
        Thu,  8 Jun 2023 08:23:16 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 47EE85C01C4;
        Thu,  8 Jun 2023 11:23:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 08 Jun 2023 11:23:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1686237793; x=1686324193; bh=8NQR1QgWkz5FJshx76hkwpBKXiFIu2ZBcaz
        eZgfU2HU=; b=RNr33zvInGlHpMqFqPaWlax+/J8+13RX1z3cGoqD0m0mN6T9KFG
        uTT4/u3eB4me0Falzaq63/Eemzr1qJtHm5R4bTa8/r21DQf3Yy7mwtd6p44inMtv
        0JFHYicLUv9e4toFh/H+7UvqWYmznpmzIV8bwPZGVgN1aAjulb6mWWGTf5WDsgkG
        rZwYYXi71/jw29GnspjgKa4nND6h73b7Z45UJ+V1JeDMzWDWboGXkrnkjvcMfrRv
        zLPcHRFbZ3s/gvU0VvNCzIiLatTypTI+C2CnkczM93CuSEorSSoiJSOIjD8Lkb3V
        yhBs5btMqhSesOtB0QYdVIDZfxKD7tLgL6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686237793; x=1686324193; bh=8NQR1QgWkz5FJ
        shx76hkwpBKXiFIu2ZBcazeZgfU2HU=; b=yqh6JQeZP2OslVaaN0b9gaJwAlpTD
        X84n2uEtVHFyB3O6aAGEmbiRHVdgmgZ1eZfw1LHyV/naZqMA4EWAQblH1eYvCfIp
        1ILnCXQdTmPHGuBrkgAf4XOyMsdanOPcdhRJj3AgqmEBTNgHBZ6jW5o9mkBd78cP
        iQB6nWQxUxd58M93OJIJPp21F9ntgyYSSVlATbT34ifDAcfcHb4U4tRTbO3/ttRq
        8ZoiGHF714dhLWiQSBSv3sFvK2s2f3O1uT5BZhKq/1jH3cxvVSj1tmIje4cfQl4N
        niXqwKld7slr8EPB4FvoLVPY6HzzBH+naNWCw/er4ElkDhh+l/n4pilOw==
X-ME-Sender: <xms:YPKBZOe8-xo8s7Dfgt-AopesjR3IiAnC_W2hN5O7lh0Ia4keVlAS0w>
    <xme:YPKBZIMU0WdxOItx84HVTp_nkTI_YvTFLAg9KKjvI2NS8-HMhqr4wzcPgqTyqbAc3
    6qaALGQ_ppjUCY>
X-ME-Received: <xmr:YPKBZPjFl4bpETpiF7W5ZGmwjx3XfxDnoL9zJrMElrBIuJ_XWfd9AQk_U_E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtiedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepvdejteegkefhteduhffgteffgeff
    gfduvdfghfffieefieekkedtheegteehffelnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:YPKBZL-G_3_Ci0GJw6XrystQz7a7FePvF3QI7x0lBogsLIuVP4tAvw>
    <xmx:YPKBZKu9MyksjpE4khqAqJYtJqiMPbirkUanGOh9zy-mIl1kKRKmvQ>
    <xmx:YPKBZCEA-qutMj487Mpgc9AYYvjqXp9tZZJa7O1Uq_Ao_6jBUQPupw>
    <xmx:YfKBZOgpfrXR2AJL2GZsTVjPWsw6q3cdbRyGuIOAbUx1E3udWcBmpA>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jun 2023 11:23:12 -0400 (EDT)
Date:   Thu, 8 Jun 2023 11:23:07 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 16/16] xen-blkback: Inform userspace that device has
 been opened
Message-ID: <ZIHyXrAj5+DXAblD@itl-email>
References: <20230530203116.2008-1-demi@invisiblethingslab.com>
 <20230530203116.2008-17-demi@invisiblethingslab.com>
 <ZH75OTMA6N3zYrH2@Air-de-Roger>
 <ZH9tcGh0N2fEcwjH@itl-email>
 <ZIBDgKKDhDj+//Q0@Air-de-Roger>
 <ZICwaWidZxhaGp8v@itl-email>
 <ZIGbUDpqjwbR5zmz@Air-de-Roger>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PU98An8gDVvBtzYA"
Content-Disposition: inline
In-Reply-To: <ZIGbUDpqjwbR5zmz@Air-de-Roger>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PU98An8gDVvBtzYA
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Thu, 8 Jun 2023 11:23:07 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
Cc: Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 16/16] xen-blkback: Inform userspace that device has
 been opened

On Thu, Jun 08, 2023 at 11:11:44AM +0200, Roger Pau Monn=C3=A9 wrote:
> On Wed, Jun 07, 2023 at 12:29:26PM -0400, Demi Marie Obenour wrote:
> > On Wed, Jun 07, 2023 at 10:44:48AM +0200, Roger Pau Monn=C3=A9 wrote:
> > > On Tue, Jun 06, 2023 at 01:31:25PM -0400, Demi Marie Obenour wrote:
> > > > On Tue, Jun 06, 2023 at 11:15:37AM +0200, Roger Pau Monn=C3=A9 wrot=
e:
> > > > > On Tue, May 30, 2023 at 04:31:16PM -0400, Demi Marie Obenour wrot=
e:
> > > > > > Set "opened" to "0" before the hotplug script is called.  Once =
the
> > > > > > device node has been opened, set "opened" to "1".
> > > > > >=20
> > > > > > "opened" is used exclusively by userspace.  It serves two purpo=
ses:
> > > > > >=20
> > > > > > 1. It tells userspace that the diskseq Xenstore entry is suppor=
ted.
> > > > > >=20
> > > > > > 2. It tells userspace that it can wait for "opened" to be set t=
o 1.
> > > > > >    Once "opened" is 1, blkback has a reference to the device, so
> > > > > >    userspace doesn't need to keep one.
> > > > > >=20
> > > > > > Together, these changes allow userspace to use block devices wi=
th
> > > > > > delete-on-close behavior, such as loop devices with the autocle=
ar flag
> > > > > > set or device-mapper devices with the deferred-remove flag set.
> > > > >=20
> > > > > There was some work in the past to allow reloading blkback as a
> > > > > module, it's clear that using delete-on-close won't work if attem=
pting
> > > > > to reload blkback.
> > > >=20
> > > > Should blkback stop itself from being unloaded if delete-on-close i=
s in
> > > > use?
> > >=20
> > > Hm, maybe.  I guess that's the best we can do right now.
> >=20
> > I=E2=80=99ll implement this.
>=20
> Let's make this a separate patch.

Good idea.

> > > > > Isn't there some existing way to check whether a device is opened?
> > > > > (stat syscall maybe?).
> > > >=20
> > > > Knowing that the device has been opened isn=E2=80=99t enough.  The =
block script
> > > > needs to be able to wait for blkback (and not something else) to op=
en
> > > > the device.  Otherwise it will be confused if the device is opened =
by
> > > > e.g. udev.
> > >=20
> > > Urg, no, the block script cannot wait indefinitely for blkback to open
> > > the device, as it has an execution timeout.  blkback is free to only
> > > open the device upon guest frontend connection, and that (when using
> > > libxl) requires the hotplug scripts execution to be finished so the
> > > guest can be started.
> >=20
> > I=E2=80=99m a bit confused here.  My understanding is that blkdev_get_b=
y_dev()
> > already opens the device, and that happens in the xenstore watch
> > handler.  I have tested this with delete-on-close device-mapper devices,
> > and it does work.
>=20
> Right, but on a very contended system there's no guarantee of when
> blkback will pick up the update to "physical-device" and open the
> device, so far the block script only writes the physical-device node
> and exits.  With the proposed change the block script will also wait
> for blkback to react to the physcal-device write, hence making VM
> creation slower.

Only block scripts that choose to wait for device open suffer
this performance penalty.  My current plan is to only do so for
delete-on-close devices which are managed by the block script
itself.  Other devices will not suffer a performance hit.

In the long term, I would like to solve this problem entirely by using
an ioctl to configure blkback.  The ioctl would take a file descriptor
argument, avoiding the need for a round-trip through xenstore.  This
also solves a security annoyance with the current design, which is that
the device is opened by a kernel thread and so the security context of
whoever requested the device to be opened is lost.

> > > > > I would like to avoid adding more xenstore blkback state if such
> > > > > information can be fetched from other methods.
> > > >=20
> > > > I don=E2=80=99t think it can be, unless the information is passed v=
ia a
> > > > completely different method.  Maybe netlink(7) or ioctl(2)?  Arguab=
ly
> > > > this information should not be stored in Xenstore at all, as it exp=
oses
> > > > backend implementation details to the frontend.
> > >=20
> > > Could you maybe use sysfs for this information?
> >=20
> > Probably?  This would involve adding a new file in sysfs.
> >=20
> > > We have all sorts of crap in xenstore, but it would be best if we can
> > > see of placing stuff like this in another interface.
> >=20
> > Fair.
>=20
> Let's see if that's a suitable approach, and we can avoid having to
> add an extra node to xenstore.

I thought about this some more and realized that in Qubes OS, we might
want to include the diskseq in the information dom0 gets about each
exported block device.  This would allow dom0 to write the xenstore node
itself, but it would require some way for dom0 to be informed about
blkback having this feature.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--PU98An8gDVvBtzYA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmSB8l4ACgkQsoi1X/+c
IsFSYA//XhC38a6SDufwf6y+xaRXnVDYSdUsP21JYKyDgiz9s6lEag0nuPNrUkLt
+pQdAxPoPq99fFKrhleiVEbr1GtEBonRU6qMCe/cUJ/BqTkUyJ75EOeRtxFjr7DI
QC9dbaly+Q+WkiLwmtHiaWgk56TaGp+GqYrG2Zj6w0fmIwOmZ59IRaDeIqwJYA6p
T4vagAEMK+f3poK6sWfEhZE2IJ5tGqyZwxvpVPY3ldnm5wS9n5WmNZF0rM7lKGzF
J8S8ITQut9DtW9NicTQfFz1jjIMDs3KFReSPchQ41+IRUx6nM3sjr6RnE2kBCER8
io/OtNbe6TVv5LxDe2bDLpEzPesjl3RNrx+mgC/LpIaO8JhvZEYpF49XmgQbXRhe
HMob73O0quNIUMQLqQ18zunfqE4wIq8Yfv4E146jRaItTN+AZT4oAFZZJb8f43BS
c95GNTtjdguBVeLKb3Vi9dH9bgqtO9CbDop9PeP1T05q2VHxMTEGhf2XkZoOCCxI
oMIV9IEbkBcVQT/nVZa56Suqgp6XKy/llGIrvk45bhraLT8ljpoHUeZnjQaJxJEO
YWr7ImrznVH+57dQbSlkQrWKZcp8f0dzzfoDGGWXP6UTTA9JiiVMkqjmk6YZEyQL
VGban/xP4mC8GD10OtAsc/b3n0w87wxVYjYT9hdDtgIBUzjcGP4=
=1nZV
-----END PGP SIGNATURE-----

--PU98An8gDVvBtzYA--
