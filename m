Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A1D683290
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjAaQ2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjAaQ23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:28:29 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F56568BD;
        Tue, 31 Jan 2023 08:28:09 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 252A03200564;
        Tue, 31 Jan 2023 11:28:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 31 Jan 2023 11:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1675182486; x=
        1675268886; bh=uGt41Hz2lmyqDw+R9CRmPEtUWmFKr0dODMcdmapvMlE=; b=L
        q7/drbKV3lgyQWFsCfz3cOvJf03TQhMFS6l3a0pch6BoWPSfvXU0j5K4yhZMqMr0
        LYm8eMCmH3tiKIpsK7Mx0bvrr+q6S59nM3oVLCUlAvNBSsKlKT0wEfzAREYVl2D5
        BC4nC0zg+bWu2y7B3HkQn2wOpbgcgtxddoWdvX+rJNTsmugnKL4eB3YkzUFlvuZS
        z4ItMoCWh9ie9QkdcQYd2a1DAVHt+YyW/z9r73pvKuudp3/8muvv1RCU4+iUgwYN
        C80b1qKbPZ3y+ZpwUYOv1G7rLgz5U0nXGfJcHKeujf/7r/YZRxweBb7FZ8uSENiV
        hTo1cYbqwltc09eBi5cCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675182486; x=1675268886; bh=uGt41Hz2lmyqDw+R9CRmPEtUWmFK
        r0dODMcdmapvMlE=; b=TQd3TbfHT1g+3Tw9QjyM776VfoSQnKFeVVHHrH5wTSvd
        8LWL33Q07LeizTcMumXUjugvcTcp6dO6Yp53lAKyFS9omvd7ZcMa6z3Zk62WDdTb
        RAIaoH9G+a08mtfBHlVfHiIfsMRLtssLALZpdlxrDnTKZ1d8r2SKP/Nrd91lg7SV
        zSNksRy+KVNbyZt6R35PMcKdBqj/O3sG6vfxjkd0rB6m9RhYW8Exq+nC6NNtxhVs
        Fwn39mcF94FUKh8B/YxJRbotYY7sBDG10mqnkqJVqCYIwpi5sba3y2SGGyJ9z+GP
        jI6GBaBdjqzeNpG0e10K8NVv1puP9NIk1aXY+Z8NFg==
X-ME-Sender: <xms:lkHZY0qhcEaK-S15qvfItEZ5GNTYDS0Uo3dfimGx4AQmdrjfdyxKNg>
    <xme:lkHZY6pEC1ND3grVIYw8NG22hBzd_WCn59luQ6BoYJJ2_6G49GD1pyp52qLbqMkW-
    LHy-HHnC3WAbCU>
X-ME-Received: <xmr:lkHZY5NQlSvlj4XXwSAgWhO2epLPeZPuSXlwvNXIc5Tj9r7oz5wstdUbED4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefgedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepvdejteegkefhteduhffgteffgeff
    gfduvdfghfffieefieekkedtheegteehffelnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:lkHZY77MXrswpijHI0Qs1-_YSxFO-PnRhzqXx78f0dKvf-JK0xpSkw>
    <xmx:lkHZYz6lu7IIastxRDXEfwgukhXji5FfZqW5savggoP-UQHTnx_zPg>
    <xmx:lkHZY7iraUp4Z7CaIz4gHOeAMP2rlNWs0lPL735eqJucuuyN9ti1Ew>
    <xmx:lkHZYzHckrYh5LJibdr9NzMahur-Bqp7A_t2zo7i61-gq8JyUQN0_w>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Jan 2023 11:28:05 -0500 (EST)
Date:   Tue, 31 Jan 2023 11:27:59 -0500
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/7] block: Support creating a struct file from a
 block device
Message-ID: <Y9lBlKD3U/jMug9j@itl-email>
References: <20230126033358.1880-1-demi@invisiblethingslab.com>
 <20230126033358.1880-2-demi@invisiblethingslab.com>
 <Y9d692WEX/ZvBhXI@infradead.org>
 <Y9gZAJGgdjFtsm9I@itl-email>
 <Y9jW73uAtE3HdCou@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xiaE+CeULPiwBElu"
Content-Disposition: inline
In-Reply-To: <Y9jW73uAtE3HdCou@infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xiaE+CeULPiwBElu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 31 Jan 2023 11:27:59 -0500
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/7] block: Support creating a struct file from a
 block device

On Tue, Jan 31, 2023 at 12:53:03AM -0800, Christoph Hellwig wrote:
> On Mon, Jan 30, 2023 at 02:22:39PM -0500, Demi Marie Obenour wrote:
> > What do you recommend instead?  This solves a real problem for
> > device-mapper users and I am not aware of a better solution.
>=20
> You could start with explaining the problem and what other methods
> you tried that failed.  In the end it's not my job to fix your problem.

I=E2=80=99m working on a =E2=80=9Cblock not-script=E2=80=9D (Xen block devi=
ce hotplug script
written in C) for Qubes OS.  The current hotplug script is a shell
script that takes a global lock, which serializes all invocations and
significantly slows down VM creation and destruction.  My C program
avoids this problem.

One of the goals of the not-script is to never leak resources, even if
it dies with SIGKILL or is never called with the =E2=80=9Cremove=E2=80=9D a=
rgument to
destroy the devices it created.  Therefore, whenever possible, it relies
on automatic destruction of devices that are no longer used.  I have
managed to make this work for loop devices, provided that the Xen
blkback driver is patched to accept a diskseq in the physical-device
Xenstore node.  I have *not* managed to make this work for device-mapper
devices, however.  One of the problems is that there is no way to
atomically create a device-mapper device and obtain a file descriptor to
it such that the device will be destroyed when no longer used.  To solve
this problem, I added a new flag (DM_FILE_DESCRIPTOR_FLAG) that asks the
device-mapper driver to provide userspace a file descriptor for the
device that was just created.  The uAPI will likely change in future
versions of the patch, but the general idea will not.

While it is easy to provide userspace with an FD to any struct file, it
is *not* easy to obtain a struct file for a given struct block_device.
I could have had device-mapper implement everything itself, but that
would have duplicated a large amount of code already in the block layer.
Instead, I decided to refactor the block layer to provide a function
that does exactly what was needed.  The result was this patch.  In the
future, I would like to add an ioctl for /dev/loop-control that creates
a loop device and returns a file descriptor to the loop device.  I could
also see iSCSI supporting this, with the socket file descriptor being
passed in from userspace.

blkdev_do_open() does not solve any problem for me at this time.
Instead, it represents the code shared by blkdev_get_by_dev() and
blkdev_get_file().  I decided to export it because it could be of
independent use to others.  In particular, it could potentially
simplify disk_scan_partitions() in block/genhd.c, pkt_new_dev() in
pktcdvd, backing_dev_store() in zram, and f2fs_scan_devices() in f2fs.

I hope this is enough information.  If it is not, feel free to ask for
more.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--xiaE+CeULPiwBElu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmPZQZQACgkQsoi1X/+c
IsGBEw/8Cdl16B9BaBXFp256DXyCZMehNStQ1CM3Fho/OkTAAfFMQIz3Yn17xNQG
88JihQ6BxaiQyNojeOLxTfK6omkPfN410l8tKDlWUHtlsPiOD73FqdUH8JSpeR3q
f4HD1jXsvqNqi1Adgf1sxGs49YE+t5sEntp0Dv03na9PCO1xW4dNGCG/WG1OsjrF
EQSmw8FnedvVjG0ZAthVwoNkIW97yJsLOHEOu94Ot6zprG+b9yh1d3haWBo4oOic
2pWkIWGtPAb+m4vcSW9tmYF6tfQvkpFwAXiiVIoRmzucq2qoi+0eboWCBvNllrsE
WFMskiS2MQaiLzs6id1FZKbnjACld6txGRvF3TtjW7gZiQoC87SC0l8vlz/wH4VY
jZ/lCstFWznAz5sjqDiNvBFufJ9hbcLHVNjpfCdpUIXaSGhRgqv4vHAbFwa6aMMC
TS/xEMJQeN6N4yAuvD1x5u4ghY5BmaLFc6c8jsJ82IgW/hWLvBVcvbIxOsKtVyzF
ftbYXQ5uFBg6oRc3eqM3SgZbdwDkJA5Qfb0FS1RV54BJjQG0HX/LEVwOBHhOmnxT
xr5hBwxdgUcIO4a0s+4aunb5PmBAbe0Xk58h+3aYz9qmNFrJtm+LPmbNt6BmW0U1
XPVNEeXwo7XEKN7+/C8YByEn43ndlD0A+R8L2iKk94+w7QAoSio=
=ldQE
-----END PGP SIGNATURE-----

--xiaE+CeULPiwBElu--
