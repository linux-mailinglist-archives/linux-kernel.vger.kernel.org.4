Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD796233A4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 20:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbiKITk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 14:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbiKITkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 14:40:53 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C0F02A421;
        Wed,  9 Nov 2022 11:40:52 -0800 (PST)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 73766292;
        Wed,  9 Nov 2022 20:40:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202205; t=1668022849;
        bh=GaOmxz6JTuMIOYsKhCv0SBSOjIVtDuRY7JydJkeuUWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mcg5csJxaykijh8hhFUTKYC+e/Us2HmYcNvujeIpmH/F7Qvql1/gwUQXFykk/Usn5
         aHzuy/TMtbLDZCp3S1RO7SIV/QRnqEB9V67ZkuLZ3UlVUXIUdd8TtylIUHXejxgr0y
         c+qZKNr1wA2uYRYUp4GUE+m61wCM9sVVs7oxeZ+7INuKabeYp8Kvf+chI6I4ZBWyD7
         bDYW5pMrYBVU5hxlFzkZK2RVLdrFEXV/IadoXpQVoZAmZ5PiIj6ZDrcma/+g8bAwL1
         AFlsHIA4CunIUS9wnI+9mCTl4lUEVkDAT7jWtYN6gYDGaVpHqaqdD8aMhKBBmCTVg1
         u/9d90Ci9IPGpYArd3vtKfi0dAfaI1tlWfXRobr3745EoQfGbDQLGGVU/g1cqqYbkh
         AfDR6QxgiUDVFDF8z8bayiwB/G9VNf1dXrDwcld7Wlj8JoLSSCX1MdElmfhM7W5jbU
         Un/S8lLzW/RuSwItSZkVqvlSjaFwzR0vDBaFUkPYhqqphWsJ0JWkQ601kfCT/sswNB
         ZW7e9T6CUE6UJnFRBnlZZNNIjjzF0uI2Br7cNeIEQKqs5WAVaTK9a4mxlYYWMD7aaZ
         FHT6EnFo6fvVVYEgJ2chejEnm/nQETVLYQ+6xseptvFQ5CYpxNHf5OZyDqotTTaG81
         RfZL7MmbwntdB+7uvxum/MB0=
Date:   Wed, 9 Nov 2022 20:40:48 +0100
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH v2 14/15] scsi: ncr53c8xx: replace CCB_MAGIC with bool
 busy
Message-ID: <20221109194048.hcs65yzpsgvek73m@tarta.nabijaczleweli.xyz>
References: <cover.1667330271.git.nabijaczleweli@nabijaczleweli.xyz>
 <27cefe163e602f7d5b35ba2e966dccf9109798f9.1667330271.git.nabijaczleweli@nabijaczleweli.xyz>
 <44fa41b4d69219b89e805d572df486c4dda77f08.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a6dqxib67q7dhbvf"
Content-Disposition: inline
In-Reply-To: <44fa41b4d69219b89e805d572df486c4dda77f08.camel@linux.ibm.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a6dqxib67q7dhbvf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 04, 2022 at 03:57:20PM -0400, James Bottomley wrote:
> On Wed, 2022-11-02 at 00:06 +0100, Ahelenia Ziemia=C5=84ska wrote:
> [...]
> > @@ -4356,7 +4347,7 @@ static int ncr_queue_command (struct ncb *np,
> > struct scsi_cmnd *cmd)
> >  	*/
> > =20
> >  	/* activate this job.  */
> > -	cp->magic		=3D CCB_MAGIC;
> > +	cp->busy		=3D true;
> > =20
> >  	/*
> >  	**	insert next CCBs into start queue.
>=20
> Are you sure this is just an internal magic number?  The way these old
> scripts engines used to work is that the CCB array forms a mailbox and
> the card continually scans the mailbox to see if it has any work to do.
> These magic values are often a signal to the card that the CCB array
> contains a valid entry it hasn't seen and it should work on it, so the
> card might be expecting to see this full 32 bit value.

AFAICT this is an internal flag: in FreeBSD, whence this is copied, this
driver is introduced in 37bd2c9c33d9684c0bf650e02579ebb329724d6a[1],
and AFAICT it's used in exactly the same way as it is here; the manual[2]
doesn't mention it at all; neither do the scripts; and the layout is
vastly different between there and current Linux; so I'm happy to
conclude it's not used by the device, I think?

1: https://cgit.freebsd.org/src/commit/?id=3D37bd2c9c33d9684c0bf650e02579eb=
b329724d6a
2: http://bitsavers.trailing-edge.com/components/ncr_symbios/scsi/53C810/53=
C810_PCI-SCSI_IO_Processor_Data_Manual_May1993.pdf

--a6dqxib67q7dhbvf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmNsAj0ACgkQvP0LAY0m
WPG6Ig/6A5Ng7Ep5CkhuZqOi5kIQ3K1T8VujDWxbD5DyiTl9UtcQu5lk2WLDFnew
GxdVzmt7abEzibLMIn0cPKPKolcfxmXWnqmT9tJr/G7iabW5VEpXKyMY2nP50u8F
owYqsnSfqxoBElAx0FEH9w7pdrwCUd5Ty0wdhscieyBtUlKd9RuUdLL2KOY2z+Ki
SFBw9IjMB/Mh6QQfGQuuyu1BMETDCVxQRyBJ/R+WPUnywWBzHyeJM7NeFFXvXOFL
uIWsuaotXbNJXm+rZwrQOsBIXhczP5nHVlB+y+44ownDvyfQ0PUYNbn61/OH5Ha2
7yJDpSZsrkxVDLumOc0/X/tryY0X9QpUGhnZ/ToNgsChiskyZAd1MSNQX9dEHLzi
u2X89NbH04HnxVvWKsoG29cmAO0/2FHfHdVriqLqgC6g0c6o64pPAKlp+ywDJf0j
aymHn6yUlXbDlWI1DRTYKjzqCpdEZEQb5in1j8guaGAlzK/XUQJPSMHgk3k9xi4y
K9loM46Pvxfl+86VSTe44E5iQ9sN0sWWVhjNHqcdJ2Ace1WkJOUWVt1hjYx+lGA7
st5rq6oc5o6onHnqFDjZ+hJoqkNpmBMqk7PkjQ6woc3IFiRFE3+mZMWvSUCPNfFH
4kacNlNyV5Qab8R+LALDioIkW9ZrVBaJy9x6u3zuomK4DRquVC4=
=vTv4
-----END PGP SIGNATURE-----

--a6dqxib67q7dhbvf--
