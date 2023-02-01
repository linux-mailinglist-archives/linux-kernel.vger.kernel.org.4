Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B33686B66
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 17:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjBAQTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 11:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjBAQTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 11:19:10 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD4666EEF;
        Wed,  1 Feb 2023 08:19:09 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id DB2875C01EC;
        Wed,  1 Feb 2023 11:19:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 01 Feb 2023 11:19:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1675268345; x=
        1675354745; bh=hGkZ2VpFg3uEzHOUEbaF+QJhRmurf7E0YdJuys1SWPA=; b=T
        Xgb+B8iIDbmLTaLqjnSQaeoxd6Vz+4rvJKnCfiXuN9ge/yOBYIyYAQmrARzqFk3v
        2i5dkbbwVtrvJ4N9U8mCSzI0/lV10p0HR3L8f4wDBOOS7asJ0yfnz7DUHQYHzGbB
        psZiOOua5uDlFeaYQFL41+wkfOIfIJ7PYM9rCJEj3jzgJoBtiAO7i4RM8QbOaJrR
        0xmxQpPfhvFZkzDDAANh4xnykZfuE6CTiKMzaX2+GA1SnrioM/6W/EYxJE/I96ci
        4DNjbdnMYLZw8x1Ltod8PF0wHjOs8HrC4hcNLY2KYC2J/YdyDARqiKxbODOlostw
        P0BtaVxUzahCTum4RaR9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675268345; x=1675354745; bh=hGkZ2VpFg3uEzHOUEbaF+QJhRmur
        f7E0YdJuys1SWPA=; b=QyOY53v5EXxOsKBKuoy6Yr/bJWJV/6PvdMaBY0ceMUyZ
        TJ6JquKyHiyC2Bpr92u5HvdmX6mATLyY8QisKKKigWq2ejcF78AxwVA5rQmBNJ8b
        sV3z9me4Z6xDOx1U/zVnt+xUl5EeLv9jCGCCANfVgax+yybResU7DQAtvWpz9J/l
        O2naZLCvnK8n3+qvbia4fukO5IiC0gL3iqoWh3H2zM/aO/1RxNJWf2aaCUn4d5RA
        yaKdIhd84HezTZsP6r0hsOu5+PJrT+X8HrqnZsCl3eNDjIwnRMMXo6WvKH1G7uKl
        hrkLwl5LLNwvrj7Kg8zG5yN7fbd5ZL7l6A1ABYa8XA==
X-ME-Sender: <xms:-ZDaYzgqUR9xp2oDCZI01ZFYKBmM2ibmCOO4ghOBBH_oDOACnPM0CA>
    <xme:-ZDaYwBmEwUCHXqFFkz2Y5pw3OVDL4RcdUHitjnhVHJhhuAWyAOGvdHOt7-2FZoSf
    6Q38mk1cjVoWrM>
X-ME-Received: <xmr:-ZDaYzHGRpYd5j2eGse-RwGSswCYVXwnQ032PSBEn6bdmrvdCktQTYz8V5Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefiedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepvdejteegkefhteduhffgteffgeff
    gfduvdfghfffieefieekkedtheegteehffelnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:-ZDaYwTVQQosofRRjTdfs0UTm08CWvG3snzDzDUTgDjQupHJZcyBwg>
    <xmx:-ZDaYwwPXZcnoi7UA_f-N_PboXyC3LurLurAT8mxMul3H02Wt1GCXg>
    <xmx:-ZDaY27MGtZUp8qdDQDdQUgdfusJ0BVbCNZVOcJDQyGUh9_vjKgX0w>
    <xmx:-ZDaY79x3qz0adSGL85DMrgq75i3beUKGEbxc1rBFG0Tgb9ZLq_JHg>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Feb 2023 11:19:04 -0500 (EST)
Date:   Wed, 1 Feb 2023 11:18:54 -0500
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/7] block: Support creating a struct file from a
 block device
Message-ID: <Y9qQ9i6rNvJWPbV+@itl-email>
References: <20230126033358.1880-1-demi@invisiblethingslab.com>
 <20230126033358.1880-2-demi@invisiblethingslab.com>
 <Y9d692WEX/ZvBhXI@infradead.org>
 <Y9gZAJGgdjFtsm9I@itl-email>
 <Y9jW73uAtE3HdCou@infradead.org>
 <Y9lBlKD3U/jMug9j@itl-email>
 <Y9oYs+KycfdFYlu2@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pHrCnqjgacOmsNWC"
Content-Disposition: inline
In-Reply-To: <Y9oYs+KycfdFYlu2@infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pHrCnqjgacOmsNWC
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 1 Feb 2023 11:18:54 -0500
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/7] block: Support creating a struct file from a
 block device

On Tue, Jan 31, 2023 at 11:45:55PM -0800, Christoph Hellwig wrote:
> On Tue, Jan 31, 2023 at 11:27:59AM -0500, Demi Marie Obenour wrote:
> > While it is easy to provide userspace with an FD to any struct file, it
> > is *not* easy to obtain a struct file for a given struct block_device.
> > I could have had device-mapper implement everything itself, but that
> > would have duplicated a large amount of code already in the block layer.
> > Instead, I decided to refactor the block layer to provide a function
> > that does exactly what was needed.  The result was this patch.  In the
> > future, I would like to add an ioctl for /dev/loop-control that creates
> > a loop device and returns a file descriptor to the loop device.  I could
> > also see iSCSI supporting this, with the socket file descriptor being
> > passed in from userspace.
>=20
> And it is somewhat intentional that you can't.  Block device inodes
> have interesting life times and are never directly exposed to userspace
> at all.  They are internal, and only f_mapping of a file system inode
> delegates to them or I/O.  Your patch now magically exposes them to
> userspace.

The intention is that the file descriptor is equvalent to what one would
get by first creating the device and then opening it.  If it is not,
that is a bug in one of my patches.

> And it then bypasses all pathname and inode permission
> based access checks and auditing.  So we can't just do it.

Accessing /dev/mapper/control is already enough to panic the kernel, so
presumably only fully trusted userspace can make the ioctl to begin
with.  Furthermore, this only allows a userspace process to get a file
descriptor to the device-mapper device it itself created.

> > blkdev_do_open() does not solve any problem for me at this time.
> > Instead, it represents the code shared by blkdev_get_by_dev() and
> > blkdev_get_file().  I decided to export it because it could be of
> > independent use to others.  In particular, it could potentially
> > simplify disk_scan_partitions() in block/genhd.c, pkt_new_dev() in
> > pktcdvd, backing_dev_store() in zram, and f2fs_scan_devices() in f2fs.
>=20
> All thse need to actually open the underlying device as they do I/O.
> Doing I/O without opening the device is a no-go.

blkdev_do_open() *does* open the device.  If it doesn=E2=80=99t, that=E2=80=
=99s a bug.
In v2 I will add the same access control checks that blkdev_get_by_dev()
does.  Is this sufficient?
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--pHrCnqjgacOmsNWC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmPakPYACgkQsoi1X/+c
IsGKyw/9Hs+s8xlrXGrh/7V99Ied9nhGpUllLF37lmssb7at6VDvhQQSI+KqMDWD
NgFet7GmBJlNc7Hd8dJm7aLUxd/i7YqOJMD3vQabso0lTxcOtTZPilfwoqlmmeTn
04C90lumgPgvCiRWkscLU0sNGb0zPxnbOw+jDSAjFfgWJ3ppU+D6gM7nYx09T7fG
q4b6MQhVNRsJ80oo+70/kePnea9+pLJTmH+kSJ7aOEfggp7Zn2F2kZFT7Q+J/ES0
gEUmcuVM6gqRXgfOPxyMDrxorU3kniuhBWeNB8ZtTie8u7ZY+5gEVhvY/gMLurYO
B+DP1noCXsjC4c76dLX5igAznMbRZoSnttAHXqkZ+eV1mN8Vc/B9C5BtL1BDqSne
YoFfPp8XCIZZVKyBQIxmbGHBSb/uQYaCZ3EtYekhftgTp4akrsVyu7aj6U/ivOSz
0HY0nrip3HgaTqSpr138JIX4QsDyE+CFpvqXDOlTNOaVq/jIPMw2EEOOFYjC1nOB
hy/qfiXHwj9ZGEKpMzIzht2ZWhRlPUa7uEui35UpWeSc/Oo6mEa2sqq3sXcTPr6W
npUtkt+qHBs4udmVWahxR7GLmSq403GCRjS6VABu7WKTSV4AVZ/bLDfF73vGRbm6
Iczu88uhIha88Q27yEnEkbszzwRWwPjYS2NqMRo0YUkiIv8ykXA=
=TOo+
-----END PGP SIGNATURE-----

--pHrCnqjgacOmsNWC--
