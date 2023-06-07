Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391AF7265F5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 18:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjFGQaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 12:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjFGQaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 12:30:00 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954662133;
        Wed,  7 Jun 2023 09:29:36 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id BF0E05C0086;
        Wed,  7 Jun 2023 12:29:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 07 Jun 2023 12:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1686155372; x=1686241772; bh=bUr9dN6x+m5YErGXG0FICdeoXK08ytJsDEF
        SjGRa3as=; b=OrZvbelqCa/0tqKTechh0z0HPyvmfhxGP2W3ddoa8fVZRmQXlXV
        Vjp2GR3zZyS+SRQzKlfBju3iLOduALS8eB4RYO3uj1duw3aY4aj4MkV+hfiUOgqJ
        lV+jJBsh2vC+l1y707PpwWJz8qwjZ4pN/GCdiV9+sA1C+DwLeoVfxMEgaFGdWcVg
        puim0Z1Gyp917MTEnDb/pT+Ya7Aaz02Z20v4BOAeMVnlI6RHswffQV24K2963ST3
        pztIBcEPqwoJcaYhe4XvriF0SsA4ef61AdsQc1C0xUmgT7iM/qsaU5gSZON5LLqb
        VdE1Y6+/iOpBLl5QJO37vrGBAhhNOdbwZPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686155372; x=1686241772; bh=bUr9dN6x+m5YE
        rGXG0FICdeoXK08ytJsDEFSjGRa3as=; b=E5lsJTODJhwSHO9/yyANsfAFyHQ1A
        lQ2GlpI14MxzAL1Pk+TDMJ2qKrmAJs19J310TkgO3nUKvZjwJ3JfRIgb6r+QWFO+
        oqLbAW4Q0Y55ACD3RWWrIi/V4a0+pD6cYH33ycyMqbV4Z9ThAWrMPKv03my1uNlN
        fW612SIN/aQMX71OPPZderfopsfUGOktZJ8VfMdZ4X4HTdXOiccKX8/Wafhx4HKi
        dPgHYNQ9qHhRTWtgHKen/U46L3rUYaOeY+sZVaDy6KvaDq28wKNRz+mZpEPFvo1U
        T1s/PIvvAbsM7uE/KBIHVAHj0XYDMYY6XgQv0Tio3nTI70IqZ7c69Z8bA==
X-ME-Sender: <xms:bLCAZNl_6XuCxcv57qau9EiuWUiEAbJKJpenjQUCCPEuL0ElShXxMg>
    <xme:bLCAZI2BSt0GCdSMxpIPFCSoP2ie3dKQFCkbkg-j7BGDT-rvBDGDrOWLfn53EbJvR
    ahIQT7AA9DqC7I>
X-ME-Received: <xmr:bLCAZDovetTVqC6eM23t9EwVI-hT-RhVwS6sq0tKwwTCDyj4OOUQb52YFt0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtgedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpedvjeetgeekhfetudfhgfetffeg
    fffguddvgffhffeifeeikeektdehgeetheffleenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:bLCAZNmjz1jVplgdZN0Br4ryc__tRROO7yqvqm2FN81p249uY8-GWA>
    <xmx:bLCAZL197dNAKDqbeCSAtyuVN52-dnQKs_4x6weQbaZRCbquaHl-3g>
    <xmx:bLCAZMvzOOy_fnWwo-8uvo2l19I066clSkIV1o6ccd3JePPwrgyBQA>
    <xmx:bLCAZFqNCkPgdqV1X6qvzqj-2S6Nu9MrUYymhcrWybQmirOIgAY5nw>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jun 2023 12:29:32 -0400 (EDT)
Date:   Wed, 7 Jun 2023 12:29:26 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 16/16] xen-blkback: Inform userspace that device has
 been opened
Message-ID: <ZICwaWidZxhaGp8v@itl-email>
References: <20230530203116.2008-1-demi@invisiblethingslab.com>
 <20230530203116.2008-17-demi@invisiblethingslab.com>
 <ZH75OTMA6N3zYrH2@Air-de-Roger>
 <ZH9tcGh0N2fEcwjH@itl-email>
 <ZIBDgKKDhDj+//Q0@Air-de-Roger>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T6W25fvao3OB3Dc6"
Content-Disposition: inline
In-Reply-To: <ZIBDgKKDhDj+//Q0@Air-de-Roger>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T6W25fvao3OB3Dc6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 7 Jun 2023 12:29:26 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
Cc: Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 16/16] xen-blkback: Inform userspace that device has
 been opened

On Wed, Jun 07, 2023 at 10:44:48AM +0200, Roger Pau Monn=C3=A9 wrote:
> On Tue, Jun 06, 2023 at 01:31:25PM -0400, Demi Marie Obenour wrote:
> > On Tue, Jun 06, 2023 at 11:15:37AM +0200, Roger Pau Monn=C3=A9 wrote:
> > > On Tue, May 30, 2023 at 04:31:16PM -0400, Demi Marie Obenour wrote:
> > > > Set "opened" to "0" before the hotplug script is called.  Once the
> > > > device node has been opened, set "opened" to "1".
> > > >=20
> > > > "opened" is used exclusively by userspace.  It serves two purposes:
> > > >=20
> > > > 1. It tells userspace that the diskseq Xenstore entry is supported.
> > > >=20
> > > > 2. It tells userspace that it can wait for "opened" to be set to 1.
> > > >    Once "opened" is 1, blkback has a reference to the device, so
> > > >    userspace doesn't need to keep one.
> > > >=20
> > > > Together, these changes allow userspace to use block devices with
> > > > delete-on-close behavior, such as loop devices with the autoclear f=
lag
> > > > set or device-mapper devices with the deferred-remove flag set.
> > >=20
> > > There was some work in the past to allow reloading blkback as a
> > > module, it's clear that using delete-on-close won't work if attempting
> > > to reload blkback.
> >=20
> > Should blkback stop itself from being unloaded if delete-on-close is in
> > use?
>=20
> Hm, maybe.  I guess that's the best we can do right now.

I=E2=80=99ll implement this.

> > > Isn't there some existing way to check whether a device is opened?
> > > (stat syscall maybe?).
> >=20
> > Knowing that the device has been opened isn=E2=80=99t enough.  The bloc=
k script
> > needs to be able to wait for blkback (and not something else) to open
> > the device.  Otherwise it will be confused if the device is opened by
> > e.g. udev.
>=20
> Urg, no, the block script cannot wait indefinitely for blkback to open
> the device, as it has an execution timeout.  blkback is free to only
> open the device upon guest frontend connection, and that (when using
> libxl) requires the hotplug scripts execution to be finished so the
> guest can be started.

I=E2=80=99m a bit confused here.  My understanding is that blkdev_get_by_de=
v()
already opens the device, and that happens in the xenstore watch
handler.  I have tested this with delete-on-close device-mapper devices,
and it does work.

> > > I would like to avoid adding more xenstore blkback state if such
> > > information can be fetched from other methods.
> >=20
> > I don=E2=80=99t think it can be, unless the information is passed via a
> > completely different method.  Maybe netlink(7) or ioctl(2)?  Arguably
> > this information should not be stored in Xenstore at all, as it exposes
> > backend implementation details to the frontend.
>=20
> Could you maybe use sysfs for this information?

Probably?  This would involve adding a new file in sysfs.

> We have all sorts of crap in xenstore, but it would be best if we can
> see of placing stuff like this in another interface.

Fair.

> Thanks, Roger.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--T6W25fvao3OB3Dc6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmSAsGoACgkQsoi1X/+c
IsEv9xAAh+0oREoh82YjIN1bf0M1x4FiXf8Db1W1nyF5Mx6GR8TSALA4UdBF2ZhR
wBwIpZKAJBxV5wW48ABeWatkop35EaE8V3Ort7gf5IeOoX4f13W3KiPPEO49b6Ar
hEdL93rM4XH4bNxeXAYh7OUi2of/zjJl+n4IOVV8Bl0c5WL65J+H4yQ+6VQdcsgr
K1DBOJgLy1ljc7MJWQHW44MFVvx4DE84BjTO1fuAZzrQ7OG3EvGh6f0WcodtzZk9
gfaSAv1c98EZcihrdaHl0NDxgybr8BZug+L1xq9so8+z5Kywi98TMOqd20pGwJkX
sALzQMVV/0gdWv1pXVxH/c8RO3RO0+eZoCS/N0/a3Ae/EldhlO8DKZ8UXq+vJ1V7
L4eGvdfBU1oqTKTXq5jekUTPF66oaW9TEFYTkW64n/hWRdFiRG8PEoglMC5YZB9G
yrCgqCdHPDHtG3TEPE0p1HqF9DFGffIE/OGhzEXvx0UXdVdB+J8oZa+G9W2yaKMZ
kuyC54J0FhOMkRFodoGgkpWnxpiC6mJMHnlEdpeSxWI41elg3jvH9MkHVOL9sTrr
bSQnmjwNBlxMlsbjo9Li6vzinnLNvwQR2LGT0t9vk7GFBI9wa0LWMReyO3mzz5c8
E5/g1pRZo3Jw/n/FWdQfdWiQQ3T4KSmHuV4ddrApHwIhrnl6WAg=
=I2t4
-----END PGP SIGNATURE-----

--T6W25fvao3OB3Dc6--
