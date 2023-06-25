Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8071673D283
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 18:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjFYQnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 12:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFYQnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 12:43:51 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74DA194
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:43:50 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 13DD95C005C;
        Sun, 25 Jun 2023 12:43:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 25 Jun 2023 12:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1687711430; x=1687797830; bh=mnkHX8vpNODUQLBztiQX7CwcPS1+k+UToFx
        uSmIlkMM=; b=DWg4UfKCmReyVxuaHQMjG/fpzgRQULhPnrcuJ4h2U/L55/Q+iUV
        kKb8zl0oNlXOtp9HHy1Le8yVwW6IXMvwHWaWk6+nC/y+WU/4ww4WaCc6mAsxDx6n
        8adzSSi39kujPE6sVRMFxSDKetJ8biVtttc5nkBqYKN2A17zYsEaCko0P0lbksKL
        IWkbpvC7OACKKNqJiQ0fh+NdU+wcx0PJIhAMPINQfLfHUY2mo6sukYlgCOsL1xMW
        uPe1L2sFgTamxMN+ysEK3Y/CuMyh/a3DWajz7muFlrlMVLaYL/LMxv8qelDO9MoX
        wz+w/PR2w94V2WeX+rxvHBrrWQFBGXc4Smg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687711430; x=1687797830; bh=mnkHX8vpNODUQ
        LBztiQX7CwcPS1+k+UToFxuSmIlkMM=; b=jKMynBRarGdJRvrbXYAIfukfzC1gX
        Xwi8SZ70foXcFAsfXq87SFF7h1dhyvtGiQjPHUNhHJw80O0q+2f986gX7EJzQOx8
        s3RxrKXCQF9HoZaKrIXR5b2fCaX3TM+Q+wAULPPf3VRtRmioO+YlPWGVrNrh7lCH
        Lf7paFL6+/+XtQWi6G1SxZYVjgYVE2LRahhBVhU4jmObkoscMy+ZC4SUHqT+m13v
        Hq+7XVY7+f0eYKNFNOTi3VFs5yj9wfDLxmgMS5NqiSeBFe785oEfyWFJQa24lAdX
        Kl8UD1IZeZiuaRULzwoclJ/9AAxeqZa3FAeAoqZqFFulxtJAGFW7vMrAw==
X-ME-Sender: <xms:xW6YZHgCC08tZMUItrXSa5PAoAjre8Mnxlb90fRUN4caAxGAXmqSDg>
    <xme:xW6YZED5fSonD_cG26ecrF4oE36KZpBEaQDruNhp9WwWzOVD1QvWcaik2TCZLvvKX
    EAGuseesKx5WU0>
X-ME-Received: <xmr:xW6YZHH48oOgJWPFs8FakezD5XkYKqnL44KzAKfxAawsDqYDA05kITNYEXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeehtddguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeduieelfeeutedvleehueetffej
    geejgeffkeelveeuleeukeejjeduffetjeekteenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:xW6YZES6uMQQV5I2qBnnaCknZkBKo48-3qwBKsBAgnj2FjUFV98qGw>
    <xmx:xW6YZEwr9KSJO2gIrYNyerK2vC6kSAm9zXGOGf2_RuYLPpURuzmXAg>
    <xmx:xW6YZK5T0-25Oe5FpWVbJJGdMusVdas_dVwr7LXlWgSANH8xUHWw3A>
    <xmx:xm6YZP_VJB2MJuMFB8zyX7-MLBJbv-jR3z9MwBpVNORRvPgak_u0Eg>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 25 Jun 2023 12:43:49 -0400 (EDT)
Date:   Sun, 25 Jun 2023 12:43:44 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Milan Broz <gmazyland@gmail.com>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [dm-devel] [PATCH v2 3/4] dm ioctl: Allow userspace to suppress
 uevent generation
Message-ID: <ZJhuw3MaFjW5Bocw@itl-email>
References: <20230624230950.2272-1-demi@invisiblethingslab.com>
 <20230624230950.2272-4-demi@invisiblethingslab.com>
 <0b22e328-40e1-54d7-367c-96059a3fef7c@gmail.com>
 <ZJhlGCP0gTz7T3gG@itl-email>
 <81c94a1e-b316-c195-402c-01776f3200dc@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xgxcetYBA/qMp0pW"
Content-Disposition: inline
In-Reply-To: <81c94a1e-b316-c195-402c-01776f3200dc@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xgxcetYBA/qMp0pW
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Jun 2023 12:43:44 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Milan Broz <gmazyland@gmail.com>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [dm-devel] [PATCH v2 3/4] dm ioctl: Allow userspace to suppress
 uevent generation

On Sun, Jun 25, 2023 at 06:33:33PM +0200, Milan Broz wrote:
> On 6/25/23 18:02, Demi Marie Obenour wrote:
> > On Sun, Jun 25, 2023 at 03:25:38PM +0200, Milan Broz wrote:
> > > On 6/25/23 01:09, Demi Marie Obenour wrote:
> > > > Userspace can use this to avoid spamming udev with events that udev
> > > > should ignore.
> > >=20
> > > Well, does it also mean that udev will not create /dev/disk/by-* syml=
inks
> > > (as response to the change udev event followed by internal udev blkid=
 scan)?
> >=20
> > In the use-case I have for this feature (block devices for Qubes VMs)
> > the blkid scan is unwanted and there are udev rules to prevent this.
> >=20
> > > If it is a private device, that is ok. But for a visible device I thi=
nk
> > > that it breaks some assumptions in userspace (presence of symlinks me=
ntioned
> > > above etc).
> >=20
> > The devices I am considering are implementation details of a userspace
> > process.  Nobody else should be opening them.  Ideally, no other
> > userspace process would even know they exist, at least without mucking
> > around in /proc or using ptrace.
> >=20
> > > So, what is the exact use for this patch?
> >=20
> > Ephemeral devices that are created, opened, marked for deferred removal,
> > assigned to a Xen VM (needs another patch currently being worked on),
> > and then closed.  udev has no business scanning these devices, and
> > indeed for it to scan them at all would be a security vulnerability
> > since their contents are under guest control.  There are udev rules to
> > ignore these devices, but for udev to even process the event wastes CPU
> > time and delays processing of other events that actually matter.  The
> > only symlink that possibly ought to be created is /dev/disk/by-diskseq
> > and I can just do that myself.
> But this is not clear from the patch header. I guess you also need
> to disable udev inotify on close on write, which will trigger device scan=
 too.
>=20
> BTW we use exactly this scenario in cryptsetup for years with existing fl=
ags
> (DM_UDEV_DISABLE_SUBSYSTEM_RULES_FLAG | DM_UDEV_DISABLE_DISK_RULES_FLAG
> DM_UDEV_DISABLE_OTHER_RULES_FLAG) - just rules are ignored while uevent i=
s still
> sent.
> Anyway, not sure we need another way to disable it; I just asked do you n=
eed it.

How can one set these flags using the raw kernel ioctls?  The code I am
working on does not use libdevmapper at all and just uses the kernel API
directly.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--xgxcetYBA/qMp0pW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmSYbsQACgkQsoi1X/+c
IsG7Lg/+JO5Xx1J/OAEBlAdC5MHRtdJVoYorTf91RrYG3eFJcxMF8EjoKbwFUL+Q
NzQ6bpzZx7QUHKybUCJD9h2OYBz1y5gUllfw8nbffxncrlWLuIEuuFah9pJQSz1P
WQD0g8KFCpW0atLhAaEYJEdU6eABOL53une4H3NShRUZ0UR5Mj3hAWNUuq2GL+QA
VmA1Riz/w8l3ynOucuexpefC+s4UMn1kel4PYVRQkD81UFn5Qn/OtwNbabJwSA2P
XyvQHcEEsKbdsd7hYyxLB1JgPRtp83qLI7uclQofJlFpaxPN/1apjaw049IX1akY
OZOGaUWIG/xyXd9zh7mwHFf37bvjwLEzASEyKKA4btO/Lsql8zpUmxuOkN6/xYoo
5fRVYLle1lXg2l1Pe55Igu65Z/n+zeWq1oxi3WA1zIOFyVOzR6Jp6g4g4u7X7iBO
1HbPca1foLtfdEL47/55ZyikIi4Z1Mu7v5gZDZnwdtRB2oklj1VyWsjFZzPNRo7P
UJY93Ldmjgg26eDukMQNYQGcPXb4+7eo90C9KkaDoWP2ykyWiStmDBZviYrkSp0j
8c1VfdvnieL9maPHq5gH8SyzSK1Q9Z7J1zptSe6+7xrhd3cc3AlJbLvP1EBwU5fX
ZfF4M4f+2H72QR8ATh4akixRJ9FZs64YoRKKYWxVvTiOd5GCCa0=
=CIIC
-----END PGP SIGNATURE-----

--xgxcetYBA/qMp0pW--
