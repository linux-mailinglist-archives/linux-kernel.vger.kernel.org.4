Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E57A724A49
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbjFFRb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237748AbjFFRb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:31:56 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDAF198C;
        Tue,  6 Jun 2023 10:31:32 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 83DA55C0156;
        Tue,  6 Jun 2023 13:31:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 06 Jun 2023 13:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1686072691; x=1686159091; bh=PPJ8ANsJ3ndC+NKLw9cb82lPRFQQEpH4AzH
        /soitpaM=; b=P0tfctNxN6mn1B0nwOJxxLWp6+OEhmftVv7YFCLXchwUTH69NZs
        3PlfS0mi/lQOWcR2p15ycdn1Ur+6nn7e+AnvmVCUwOMKSqPm4RAvewy7BB9j9twd
        a5shp6CDpc24V4TrJ8FbhAZBIRioylbWpKb/nnn92RtNLT0oOQS5Xh2KchPjCrYn
        /v6auTLUC71EeuEUuSRzQuvmABZGjpxqS4z53ZeQ3lccYcJGcgSymRPDjG5UhOjo
        5xxDKlBm1y0aqt1D35kewJ6mF8+NX5Ap1yFentB59t3uDBJsbjyCAgjjc8mlYHOB
        MjnwJP+zACLNfdjg9bBVylVqvtSiJTNXTpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686072691; x=1686159091; bh=PPJ8ANsJ3ndC+
        NKLw9cb82lPRFQQEpH4AzH/soitpaM=; b=LaRJgzIthnbwCDP8EB6dUMUJAMtxY
        6MkrH0yrgtLI/Z6Ddc1KGjD+nSawwgtocmaBUUanj4O6uaHdVkF/ljY8bzd6TLYB
        qZnsQc2gyD0h+y8qDUA2wWJg39viglyAD12kqbb1cMI5FShps4jMl9kmE7LN1nkS
        n4Q48swTpQZo+3JkHogiWI+anLaI1RBGkvC5rfjesvr2riRvwXAlC36AoauODiBU
        Y+i0qwZGZW/F/GTLdymrHEOIFENBExyYonwCD0Pg+AtUJhDKYtbEGx6CPghw70KD
        27rZKRcEJVr+Bx/3AXjbUwXGBhrACYVV5dExp+VXDSZEki/+SB3VBBQYA==
X-ME-Sender: <xms:c21_ZKd8WCaHfQUj7cA0lQ5aiyai52sGXNYStDIqtr2QG-TxPYEptQ>
    <xme:c21_ZEM5ldcBe2_40Za36iUh3w5DgMPgiOSoaEodOcxzGC0bRZQRKhv6_9lPXNdMz
    -J3y7dQCIORS3A>
X-ME-Received: <xmr:c21_ZLjrH7dc41-Duoq54zoW7k3Gytb6gRThIOHNHzxx6NEvCHEIDWhYdPU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtuddgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpedvjeetgeekhfetudfhgfetffeg
    fffguddvgffhffeifeeikeektdehgeetheffleenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:c21_ZH8Z4sjS5tPngpz6PzEwIyUw66nwljaREopGyymrxY9sl6tBPQ>
    <xmx:c21_ZGu5hIonaBKPQSBDMCA5627MKJDiwayRyLOrtziwJcrCTh6lOw>
    <xmx:c21_ZOGwo3J7FVrPqwGHV9sWREnzPF7pWeAI9ro6DEyqU0ziywqjzw>
    <xmx:c21_ZKhZijSEkroUDzXTteeVgMINareaN66m812-2uCPceMsvBTFGw>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jun 2023 13:31:30 -0400 (EDT)
Date:   Tue, 6 Jun 2023 13:31:25 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 16/16] xen-blkback: Inform userspace that device has
 been opened
Message-ID: <ZH9tcGh0N2fEcwjH@itl-email>
References: <20230530203116.2008-1-demi@invisiblethingslab.com>
 <20230530203116.2008-17-demi@invisiblethingslab.com>
 <ZH75OTMA6N3zYrH2@Air-de-Roger>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v5HGqs481WPJ8zTb"
Content-Disposition: inline
In-Reply-To: <ZH75OTMA6N3zYrH2@Air-de-Roger>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v5HGqs481WPJ8zTb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 6 Jun 2023 13:31:25 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
Cc: Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 16/16] xen-blkback: Inform userspace that device has
 been opened

On Tue, Jun 06, 2023 at 11:15:37AM +0200, Roger Pau Monn=C3=A9 wrote:
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
> There was some work in the past to allow reloading blkback as a
> module, it's clear that using delete-on-close won't work if attempting
> to reload blkback.

Should blkback stop itself from being unloaded if delete-on-close is in
use?

> Isn't there some existing way to check whether a device is opened?
> (stat syscall maybe?).

Knowing that the device has been opened isn=E2=80=99t enough.  The block sc=
ript
needs to be able to wait for blkback (and not something else) to open
the device.  Otherwise it will be confused if the device is opened by
e.g. udev.

> I would like to avoid adding more xenstore blkback state if such
> information can be fetched from other methods.

I don=E2=80=99t think it can be, unless the information is passed via a
completely different method.  Maybe netlink(7) or ioctl(2)?  Arguably
this information should not be stored in Xenstore at all, as it exposes
backend implementation details to the frontend.

> > diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blk=
back/xenbus.c
> > index 9c3eb148fbd802c74e626c3d7bcd69dcb09bd921..519a78aa9073d1faa1dce5c=
1b36e95ae58da534b 100644
> > --- a/drivers/block/xen-blkback/xenbus.c
> > +++ b/drivers/block/xen-blkback/xenbus.c
> > @@ -699,6 +713,14 @@ static int xen_blkbk_probe(struct xenbus_device *d=
ev,
> >  	if (err)
> >  		pr_warn("%s write out 'max-ring-page-order' failed\n", __func__);
> > =20
> > +	/*
> > +	 * This informs userspace that the "opened" node will be set to "1" w=
hen
> > +	 * the device has been opened successfully.
> > +	 */
> > +	err =3D xenbus_write(XBT_NIL, dev->nodename, "opened", "0");
> > +	if (err)
> > +		goto fail;
> > +
>=20
> You would need to set "opened" before registering the xenstore backend
> watch AFAICT, or else it could be racy.

Will fix in the next version.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--v5HGqs481WPJ8zTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmR/bXEACgkQsoi1X/+c
IsH4LQ/8CBCRE3oNXmGpRfn2V6qP3hByq92y8oEWMR2YzQ3ndD6PeKp1WW3R4CX8
oaK+UonWY/8k4miLPUvGPgvk/igvHGGwbJ5LQMUrDr7MxSKK2M5DXrOX9s10P9vS
gYb2lJZpgnP490tjeoM+9tDUTUH/zsqzGuAdRAJoFcIFpePCibf5+7xhNpLroHX7
RYXXjyJshqHQJCfoofao9qqWvDgSHbwRW+g86iDOPBbzorN2sVHHBgYpgMUgGrhf
fjf/Ola7ZJFeyPOv3EwdZDOjPb3yVPeuWmPbm08BjIwMKe5VVKu4UpWpYIaPaTgc
AxAVNOZpMx2Zi4MtckhVDjfxenFwr/2fKOgT4zbp46480wLY1i3gYYRM/mesxUID
aYXCKf/J0W3QGwnpb1vMszwUpYD5Zc/pnUQobwVIvnZUxMQl8IRwsFAFlkdvzbVD
sHg0JDxSo4csiDi2cluz4N1Y8QO4slB+mQbSfsZPhXYOo644Mz/nR0RTb58EluJt
rK/Ja/xzbHd9Xuwo1n8nmpH/Todpoze/hKhyoUw6y+uU2JCJwZxelO0hQ2s7BZ57
ngFcZ+RgrefNYK/zjenp5qdeWG3oxRsrLhwhoyUw+mUO1BzHBJAUQHLhnVwi9M1i
aRq4CIKxSNY7YYBPNHXJdLqjcHl7N2uxS0XZxEM9SBqNFjBAjl4=
=m67i
-----END PGP SIGNATURE-----

--v5HGqs481WPJ8zTb--
