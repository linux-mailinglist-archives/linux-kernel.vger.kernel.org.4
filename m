Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405DD7249B0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237291AbjFFRBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbjFFRBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:01:37 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10948E6B;
        Tue,  6 Jun 2023 10:01:35 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 19C075C012D;
        Tue,  6 Jun 2023 13:01:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 06 Jun 2023 13:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1686070893; x=1686157293; bh=l2EzN6E/qocsYv3o8wJqF7HDny4dm9MwaMQ
        5WBtXj4Q=; b=ZADMKl3MnlVwGXHqpt8eGbGaF8puWI4iVmYboN61PHb5av+UeP/
        Mwcs8RsetL/Ia1TD3XjbeOVyX1XtQDmaenLSZv1k7n7V1YkeHHiC8e1SJJDsF1uw
        z+iMJ25KJxfOkmKN30YtM/UuLgeI859JUNhHCWvTsG+ZrTje3ObKDlToP1VaiGLn
        JIKypbEJ+w1d+sAz60ZP170xoGwtqPgI6yIr4K1GTGftVa6dqC6OTRPaU5vqYjYQ
        a1AZG7vWO16iD8L9QQvURJuLbkqLyi60yG+ghLCzdYIQN3F5Tcn00OVxO8NogdOd
        SzYbivZrzph0bf4589ArZksnRFEFjVbf/Lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686070893; x=1686157293; bh=l2EzN6E/qocsY
        v3o8wJqF7HDny4dm9MwaMQ5WBtXj4Q=; b=eiiOaOKtqq5GhqSypOjJmRkmI4fKP
        Z09ALho2siegC6nBwRb6eOJeFL+U1zmRVQj3ABZ0jn41SZ5R4XVv4XruydlJ/2gx
        fHOpVgzqtkEd7kk+nLRbTsbSzLbZpbi/vWof52KNRn7+OvPI8OWOtwJI7dvjoPG/
        pzj/Dn4SWtBsnVvUA26m26Eya9slFNCIHumJBzOlkzuna3OlAnYQ5PAc4t7BcjWj
        lFzcnWHMWvQ5OOXhVvpgiS0iv7jTFCczZPIUuLm7yIANApgwu96x+HX+d3+zieqy
        Rl9v0VEvKT1RyayBe9p4m9RIMs6igKPUBNQUY6sMYlBD+UTEA9JcX/6Zg==
X-ME-Sender: <xms:a2Z_ZAWpQed-F1Rq8M57HU6BNvRoFM9TPwzr3RY-q3crE2xsPWlIzg>
    <xme:a2Z_ZEmRYeNXKD01xmCSSiOV3skS_x8dVqTu6_-qRv1DHPn7ZSDWy5KJVZN5TA-bD
    0-cMTfme4y2C8w>
X-ME-Received: <xmr:a2Z_ZEbKvq29I-9GutIe_25UN5PkfaWTdN0eXKPnRXHr4wHsQmzVGAUE3xk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtuddguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpedvjeetgeekhfetudfhgfetffeg
    fffguddvgffhffeifeeikeektdehgeetheffleenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:a2Z_ZPVvYtX4NM-79g7DVuGNFvi3TqziTCvFMV6f152Nokz7N0TrjQ>
    <xmx:a2Z_ZKmNnzPaKH5oPSBnNxVPgMC6SivDnaYg1nmGO0MdVNwRkoKwJw>
    <xmx:a2Z_ZEfD5_pUCg9jce7fGwlO3jU0942-qvYTAM01zBHl9VNe2WhpnA>
    <xmx:bWZ_ZIZZr1wY8mOjIoKzsVLl53G6HUnb2iXQ4YAYwPxGNbRxTpG4lw>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jun 2023 13:01:31 -0400 (EDT)
Date:   Tue, 6 Jun 2023 13:01:20 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 13/16] xen-blkback: Implement diskseq checks
Message-ID: <ZH9mZGbM32CDmKGF@itl-email>
References: <20230530203116.2008-1-demi@invisiblethingslab.com>
 <20230530203116.2008-14-demi@invisiblethingslab.com>
 <ZH7tizoYl8YVFN9B@Air-de-Roger>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gvaHE6UC2pWo4unn"
Content-Disposition: inline
In-Reply-To: <ZH7tizoYl8YVFN9B@Air-de-Roger>
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


--gvaHE6UC2pWo4unn
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 6 Jun 2023 13:01:20 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
Cc: Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 13/16] xen-blkback: Implement diskseq checks

On Tue, Jun 06, 2023 at 10:25:47AM +0200, Roger Pau Monn=C3=A9 wrote:
> On Tue, May 30, 2023 at 04:31:13PM -0400, Demi Marie Obenour wrote:
> > This allows specifying a disk sequence number in XenStore.  If it does
> > not match the disk sequence number of the underlying device, the device
> > will not be exported and a warning will be logged.  Userspace can use
> > this to eliminate race conditions due to major/minor number reuse.
> > Old kernels do not support the new syntax, but a later patch will allow
> > userspace to discover that the new syntax is supported.
> >=20
> > Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> > ---
> >  drivers/block/xen-blkback/xenbus.c | 112 +++++++++++++++++++++++------
> >  1 file changed, 89 insertions(+), 23 deletions(-)
> >=20
> > diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blk=
back/xenbus.c
> > index 4807af1d58059394d7a992335dabaf2bc3901721..9c3eb148fbd802c74e626c3=
d7bcd69dcb09bd921 100644
> > --- a/drivers/block/xen-blkback/xenbus.c
> > +++ b/drivers/block/xen-blkback/xenbus.c
> > @@ -24,6 +24,7 @@ struct backend_info {
> >  	struct xenbus_watch	backend_watch;
> >  	unsigned		major;
> >  	unsigned		minor;
> > +	unsigned long long	diskseq;
>=20
> Since diskseq is declared as u64 in gendisk, better use the same type
> here too?

simple_strtoull() returns an unsigned long long, and C permits unsigned
long long to be larger than 64 bits.

> >  	char			*mode;
> >  };
> > =20
> > @@ -479,7 +480,7 @@ static void xen_vbd_free(struct xen_vbd *vbd)
> > =20
> >  static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
> >  			  unsigned major, unsigned minor, int readonly,
> > -			  int cdrom)
> > +			  bool cdrom, u64 diskseq)
> >  {
> >  	struct xen_vbd *vbd;
> >  	struct block_device *bdev;
> > @@ -507,6 +508,26 @@ static int xen_vbd_create(struct xen_blkif *blkif,=
 blkif_vdev_t handle,
> >  		xen_vbd_free(vbd);
> >  		return -ENOENT;
> >  	}
> > +
> > +	if (diskseq) {
> > +		struct gendisk *disk =3D bdev->bd_disk;
>=20
> const.
>=20
> > +
> > +		if (unlikely(disk =3D=3D NULL)) {
> > +			pr_err("%s: device %08x has no gendisk\n",
> > +			       __func__, vbd->pdevice);
> > +			xen_vbd_free(vbd);
> > +			return -EFAULT;
>=20
> ENODEV or ENOENT might be more accurate IMO.

I will drop it, as this turns out to be unreachable code.

> > +		}
> > +
> > +		if (unlikely(disk->diskseq !=3D diskseq)) {
> > +			pr_warn("%s: device %08x has incorrect sequence "
> > +				"number 0x%llx (expected 0x%llx)\n",
>=20
> I prefer %#llx, and likely pr_err like above.  Also I think it's now
> preferred to not split printed lines, so that `grep "has incorrect
> sequence number" ...` can find the instance.

Ah, so _that_ is why I got a warning from checkpatch!

> > +				__func__, vbd->pdevice, disk->diskseq, diskseq);
> > +			xen_vbd_free(vbd);
> > +			return -ENODEV;
> > +		}
> > +	}
> > +
> >  	vbd->size =3D vbd_sz(vbd);
> > =20
> >  	if (cdrom || disk_to_cdi(vbd->bdev->bd_disk))
> > @@ -707,6 +728,9 @@ static void backend_changed(struct xenbus_watch *wa=
tch,
> >  	int cdrom =3D 0;
> >  	unsigned long handle;
> >  	char *device_type;
> > +	char *diskseq_str =3D NULL;
>=20
> const, and I think there's no need to init to NULL.
>=20
> > +	int diskseq_len;
>=20
> unsigned int
>=20
> > +	unsigned long long diskseq;
>=20
> u64
>=20
> > =20
> >  	pr_debug("%s %p %d\n", __func__, dev, dev->otherend_id);
> > =20
> > @@ -725,10 +749,46 @@ static void backend_changed(struct xenbus_watch *=
watch,
> >  		return;
> >  	}
> > =20
> > -	if (be->major | be->minor) {
> > -		if (be->major !=3D major || be->minor !=3D minor)
> > -			pr_warn("changing physical device (from %x:%x to %x:%x) not support=
ed.\n",
> > -				be->major, be->minor, major, minor);
> > +	diskseq_str =3D xenbus_read(XBT_NIL, dev->nodename, "diskseq", &disks=
eq_len);
> > +	if (IS_ERR(diskseq_str)) {
> > +		int err =3D PTR_ERR(diskseq_str);
> > +		diskseq_str =3D NULL;
> > +
> > +		/*
> > +		 * If this does not exist, it means legacy userspace that does not
> > +		 * support diskseq.
> > +		 */
> > +		if (unlikely(!XENBUS_EXIST_ERR(err))) {
> > +			xenbus_dev_fatal(dev, err, "reading diskseq");
> > +			return;
> > +		}
> > +		diskseq =3D 0;
> > +	} else if (diskseq_len <=3D 0) {
> > +		xenbus_dev_fatal(dev, -EFAULT, "diskseq must not be empty");
> > +		goto fail;
> > +	} else if (diskseq_len > 16) {
> > +		xenbus_dev_fatal(dev, -ERANGE, "diskseq too long: got %d but limit i=
s 16",
> > +				 diskseq_len);
> > +		goto fail;
> > +	} else if (diskseq_str[0] =3D=3D '0') {
> > +		xenbus_dev_fatal(dev, -ERANGE, "diskseq must not start with '0'");
> > +		goto fail;
> > +	} else {
> > +		char *diskseq_end;
> > +		diskseq =3D simple_strtoull(diskseq_str, &diskseq_end, 16);
> > +		if (diskseq_end !=3D diskseq_str + diskseq_len) {
> > +			xenbus_dev_fatal(dev, -EINVAL, "invalid diskseq");
> > +			goto fail;
> > +		}
> > +		kfree(diskseq_str);
> > +		diskseq_str =3D NULL;
> > +	}
>=20
> Won't it be simpler to use xenbus_scanf() with %llx formatter?

xenbus_scanf() doesn=E2=80=99t check for overflow and accepts lots of junk =
it
really should not.  Should this be fixed in xenbus_scanf()?

> Also, we might want to fetch "physical-device" and "diskseq" inside
> the same xenstore transaction.

Should the rest of the xenstore reads be included in the same
transaction?

> Also, you tie this logic to the "physical-device" watch, which
> strictly implies that the "diskseq" node must be written to xenstore
> before the "physical-device" node.  This seems fragile, but I don't
> see much better optiono since the "diskseq" is optional.

What about including the diskseq in the "physical-device" node?  Perhaps
use diskseq@major:minor syntax?

> The node and its behaviour should be documented in blkif.h.

Indeed so.

> > +	if (be->major | be->minor | be->diskseq) {
> > +		if (be->major !=3D major || be->minor !=3D minor || be->diskseq !=3D=
 diskseq)
> > +			pr_warn("changing physical device (from %x:%x:%llx to %x:%x:%llx)"
> > +				" not supported.\n",
> > +				be->major, be->minor, be->diskseq, major, minor, diskseq);
> >  		return;
>=20
> You are leaking diskseq_str here, and in all the error cases between
> here and up to the call to xen_vbd_create().

I will fix this by moving the diskseq reading code into its own
function.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--gvaHE6UC2pWo4unn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmR/ZmUACgkQsoi1X/+c
IsFcXw/+O0uik5rd4boydxFX99UjfrkGiog1pfbmuhUxgisJFIPtkNnbz2S66pb5
h2wD5k3BZC+Sl/Mbt4LKpKbRM9qJWhhGZZjNG7n0GTBw08k9WJP2QhlJVLkqwtWt
Fg+JyZACmla53o0nlhrvMZGAtNN0f/4S3z2ary6h6AqNRl5nIAso9E7qEMkaZ/aW
EMGGdy5gWhAUUfFeo7pG7LlgPUPZHLZ0EdpqOuVW37B3w3DbeRuX1abRgQwpBZcC
1bx6MY1y59+K5tri4ONQHSDriBH8z0hcHLUTYNaGCBCWiC+19zY+njahy9gAEit+
YjoiTevhLSn+UtxPB6Fi/233LEQySlGyS90McFx+3fMnkc32sOoxxI3drAxWUDCB
iKY4VMgvdUrCi6zN+IWITMDCRsQzidLs5rUPPj14Lf6w7R7wKaxTvMZBlcbbQBBU
PKUo2homKpex3/Qxw7/c5DyZ0M/oPEuJyp/lmHmEDXDMqInF9PI+A8ukSaFOzE96
jCBO8ay7vpXZG5jEx9FRF/T8JGmYnL6F/cu5P+o8t2vxNg0fe9w5Jg0o3zjEkraC
Qxu9cpr4/44ySNx7cB7fUXMkw4+Ubbe0UrFcyX9NvKtaB8F5H+tptCHyGJ0hQa36
6Z9EKHUoChcUGKMLAJ1GUI383RpDqbzdOS5FS97X/HlIc7B9S4Q=
=ln1g
-----END PGP SIGNATURE-----

--gvaHE6UC2pWo4unn--
