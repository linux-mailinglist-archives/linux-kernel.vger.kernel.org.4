Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80905726453
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240106AbjFGPZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241254AbjFGPYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:24:48 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B71E2707;
        Wed,  7 Jun 2023 08:24:13 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 54D205C0083;
        Wed,  7 Jun 2023 11:23:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 07 Jun 2023 11:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1686151389; x=1686237789; bh=Wv7B88fCXHMfzlDN3UtqKmkgxzrFTCsQxuL
        FkzoPHro=; b=XHoJXnU2+Jkn+R2bLfxIbPT3bxyCMF5fQ0zS8CtDaGSqTker57P
        +kWa087zeC5Ak/d9FH1sIyKJfOUWIEPH0W+iLtAAwje6RiZiNIzNHKAKLuZBcQzy
        iSA8qh+dv3ecCR3pxKTD1QhHl76XcJUmsRH4JD2b3zdtTGSPFs+0BvS3My/btqlf
        1QxY6VQJrkPBM/yDs5df/q66phXvfOxWuP60SCz0KAu0jOjFksl7ptO5Yad9+w91
        3I4JMbOv0gOb/nITmlYw+i1RAmyT0ry3MSHecRMprLdXrSoOLf/0D/BFsVWFOM7k
        45UTq+Lo+WOzCC+V7SKVWcYnC3Ie3qSwFkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686151389; x=1686237789; bh=Wv7B88fCXHMfz
        lDN3UtqKmkgxzrFTCsQxuLFkzoPHro=; b=WfumrNaC/mT4OajhXHOPWdcfHkkRO
        SZxV2GMvr7fjCKdu30Xlbk8xXeRJbI2KfUgBJ2UetKMClF6NadOWhoMVJbj1lEqp
        cRJeUFo4/rxQ+zmQI/G68XmA8Tq6x8++apsN10xmDfBDdUxsJvR/3Vm9yWfMxQxK
        4BSwzZdM7ZpVYXu7YH8mF9TuYgXHVSZ63yHwIJTGJmDzZXj1EEbqdpEt8N2cVELa
        OC12kqNMT+udqBO0F9ZrEtpESzyCByu0HE1ih+9yzF/WBJ0vFiRfa+mw8bAHB91a
        I0ZIjGVNV9DekVhFswsKhRMNNj+EygWawq/0HoK06rTHZlxXEA5iBzxdg==
X-ME-Sender: <xms:3aCAZKIePnmYH3J5jOSqMNxXvAl_imf-4iBP7eI7sGwDDo1N4Fd42Q>
    <xme:3aCAZCKzRnAX1EsopXNKY1hl1_lndEpGoS6tHm1M4cruxgXfpc0s2CLvPFGVBreZp
    HEEznlA5akIP7c>
X-ME-Received: <xmr:3aCAZKspw-lkDixv91bZzVjZ1rJrXPT5JfphLqFuvqcyQfgzQvv59PW1iQs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtgedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepvdejteegkefhteduhffgteffgeff
    gfduvdfghfffieefieekkedtheegteehffelnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:3aCAZPbLD9jwZE94B875RYnbBA-THOuPZ6lpzR_jbGp8OkRaFT3dRA>
    <xmx:3aCAZBagBMf94CsyL7OqQza8ILYscmGdY9fEXTkwXQP7GACLD-oZbA>
    <xmx:3aCAZLCJ-g2hls9eWfKLhTzmcZKfZdH0igmijUnbFehtRrhRfVHzlg>
    <xmx:3aCAZAwgnAlah1z8Ldh3loCdK-6XmzNQqI3Pc2Fvn1p3p4I8NW0f5w>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jun 2023 11:23:08 -0400 (EDT)
Date:   Wed, 7 Jun 2023 11:23:00 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block, loop: Increment diskseq when releasing a loop
 device
Message-ID: <ZICg2sxHQRRPW3Nc@itl-email>
References: <20230601222656.2062-1-demi@invisiblethingslab.com>
 <ZIA004HDuhoTQzY/@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ciKbitYsLUhZP3Im"
Content-Disposition: inline
In-Reply-To: <ZIA004HDuhoTQzY/@infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ciKbitYsLUhZP3Im
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 7 Jun 2023 11:23:00 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block, loop: Increment diskseq when releasing a loop
 device

On Wed, Jun 07, 2023 at 12:42:11AM -0700, Christoph Hellwig wrote:
> > +++ b/block/genhd.c
> > @@ -1502,3 +1502,4 @@ void inc_diskseq(struct gendisk *disk)
> >  {
> >  	disk->diskseq =3D atomic64_inc_return(&diskseq);
> >  }
> > +EXPORT_SYMBOL(inc_diskseq);
>=20
> I really do not like exporting this as a lowlevel function.  If we
> increment the sequence it should be part of a higher level operation.

Fair!

> > --- a/drivers/block/loop.c
> > +++ b/drivers/block/loop.c
> > @@ -1205,6 +1205,12 @@ static void __loop_clr_fd(struct loop_device *lo=
, bool release)
> >  	if (!part_shift)
> >  		set_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
> >  	mutex_lock(&lo->lo_mutex);
> > +
> > +	/*
> > +	 * Increment the disk sequence number, so that userspace knows this
> > +	 * device now points to something else.
> > +	 */
> > +	inc_diskseq(lo->lo_disk);
>=20
> And I'm not sure why we even need this.  __loop_clr_fd
> already calls disk_force_media_change, which calls inc_diskseq.
> Why do we need an extra increment?

How does disk_force_media_change() call inc_diskseq()?  I don=E2=80=99t see=
 any
calls in the source code.  I=E2=80=99m going to use systemtap to see if the=
re is
an indirect call chain.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--ciKbitYsLUhZP3Im
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmSAoNoACgkQsoi1X/+c
IsHQlBAAkPrxFId08lsXJQUerNo6JNd7c3rnGL/J7C1RclnoXZvb2wTxTOU7SyAK
Pm0DjJ+MkEbJPCtk4mhaA75ezfDNiA66cPmmaN3xBDb9VmuqwMSUgKhEDqpvMGyD
r41wCIrMIv3daXrqMbdThLX8MN9nyLNFPG2VkLK71z7Yar/3jEhTVH7JkcrCZ79C
STBv9mj8oG86ycCIUrKeWpI3zFZaniO0yUqlqXEuCt9x5LZ1WQ/EG6G9kiQyJIb1
rdKyWeJg0al9eRWJT9xQxnBmPlGAj5l/C9NUk70WYWaer5r7xmhmVZhyazIAwf/I
pz3huGDWEr7XEt7Nf6+3Xoyq4+koI9RnJtO3Hn5wYzQC/Xn6+JA1qcD1krJoLA2F
fockSGh2BA7UtVXx+krv3tnC9xmayLJCxuFBYjzcoWFmzsJoXpgaQ2wR77qXtwnB
SUbw55OBbOR2TCXmJajNIDhKc9WvqV46uFd15/Sq8S+xhyU5pkeZM/uK7QBxUT6j
Wrb0iPLE6R5KOhDiE+TqfFfaUxMS9zi1sS4eu+KyZ7bQ42CN70SGH/1UDmwAk3x6
rWtTna5azpbJbQO7y4TtOS1/7ieCXwFBbGESqJCOACdBWHNKCmoA4Krc1p16l3+k
Qapw/TfC17dcL5X9rynQ238Hvvgwmu6tRFIQFonQVRaaKY9LeFk=
=OUMI
-----END PGP SIGNATURE-----

--ciKbitYsLUhZP3Im--
