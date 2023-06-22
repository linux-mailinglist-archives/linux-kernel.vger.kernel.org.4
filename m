Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEAB73A971
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 22:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjFVU1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 16:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjFVU1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 16:27:49 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF261FF5;
        Thu, 22 Jun 2023 13:27:48 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 3FEE53200907;
        Thu, 22 Jun 2023 16:27:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 22 Jun 2023 16:27:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1687465665; x=1687552065; bh=ilJlmW5t/nNPJnmJ9TZkHLhft7UuDMdmosF
        my2qk/S8=; b=EBJHw7L/eT0J4kZs8eq/RthZPLrXyDpbFYbvrT4ELAQ20aQTYbN
        fSTsVTOwvCXp5i/KCrZSsG5dmGT21hGXrN6I+qcp23GFOioAkC7JmYXKD/rSMbbh
        ZPngWtXETA7q5tn1vk4IZxxZa4w2hO+EOYgjL9xqb1WB/gK/gFo2BKTZuNWXEBtA
        1D8Qow9UjF2AIzWNV4jVDfCoKJKbkt8mRdM24nxe9tnitkibT/dTEdhDSWiuuO0z
        imGn8pS0p+mAIfGH7mWKf4wpgylhqNwkavwsLGeTglu7OmiMwGQxAlF1mhwadBxD
        Dcqt3rDMM1k5qIr+fcAu1TqxtoNZ159GFjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687465665; x=1687552065; bh=ilJlmW5t/nNPJ
        nmJ9TZkHLhft7UuDMdmosFmy2qk/S8=; b=UhNHZ5sPRRswW9vfl+/iSssWVKGLG
        hY8lnOd+QcqY4UXlJW0VoqunDgXCIpyeGIbK+QLkPRP9dCSS86+WAdtdU9R+zRBP
        6x71TfJAK2G5fT4qaAaqSzsuBQnlTa2A7KFsQFsY6Z2ncpFRKjBFidsnyG5z9BLc
        cCCseu17H5OgyPRW4omgbg9VI6ZbuyYw6QsZPDCQiTG1ZmCDWDRgWstZCKLM61U7
        iD7Sv/ZnsCiJ4pfQJXftBfCuWD2+8JogVQni/CiVN0N/Y95ryxqU1dAPjCum7tT9
        xyR0D5N0tVZEwI+KjsAaNuTOSFLm/gfCV7iIV8/ksb124asDuDCjlqc1Q==
X-ME-Sender: <xms:wa6UZEBWPUC4gRnfPLhesSBAALBGJJQ-nMbwENMcotb_n07fHo_ASQ>
    <xme:wa6UZGhVkcDF15PMF8HWRzo7R88XMFNP3wmjbQWDBVwnv93mILaqou11ZqqOdjcQM
    XHocqlGuXfXvmM>
X-ME-Received: <xmr:wa6UZHkl3XPU0J6zssPiHXctf7TNeYKAZdKPbFDDj9huRouHeQu_Xd9cOSs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeeguddgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpedvjeetgeekhfetudfhgfetffeg
    fffguddvgffhffeifeeikeektdehgeetheffleenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:wa6UZKwWQ8OXEO61atZ6yScKd2o3GssCiKCRndZxW6qlS2LvHTimDA>
    <xmx:wa6UZJTzwrQ7UtnPND0ecjnRMAJVHBvYZu4eZr_lU4YxcVTzDUHUrw>
    <xmx:wa6UZFZKL4MQuK1gBljJJHpZ2zh1zVIYPnVBHfiWrmMMQy8MiTRDwQ>
    <xmx:wa6UZLdkWlYfiM0yzNViaGbzhthhAv5GOf7W13M7WwwQZjeb5kDKcw>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jun 2023 16:27:45 -0400 (EDT)
Date:   Thu, 22 Jun 2023 16:27:40 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [dm-devel] [PATCH v2 1/6] device-mapper: Check that target specs
 are sufficiently aligned
Message-ID: <ZJSuv0cdqGR1BEbS@itl-email>
References: <20230601212456.1533-1-demi@invisiblethingslab.com>
 <20230603145244.1538-1-demi@invisiblethingslab.com>
 <20230603145244.1538-2-demi@invisiblethingslab.com>
 <7d56d190-b97c-f515-ebd0-c3790f11954@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="atMqDGrroiLEtsgA"
Content-Disposition: inline
In-Reply-To: <7d56d190-b97c-f515-ebd0-c3790f11954@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--atMqDGrroiLEtsgA
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Jun 2023 16:27:40 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	dm-devel@redhat.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [dm-devel] [PATCH v2 1/6] device-mapper: Check that target specs
 are sufficiently aligned

On Thu, Jun 22, 2023 at 07:29:52PM +0200, Mikulas Patocka wrote:
>=20
>=20
> On Sat, 3 Jun 2023, Demi Marie Obenour wrote:
>=20
> > Otherwise subsequent code will dereference a misaligned
> > `struct dm_target_spec *`, which is undefined behavior.
> >=20
> > Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/md/dm-ioctl.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >=20
> > diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
> > index cc77cf3d410921432eb0c62cdede7d55b9aa674a..34fa74c6a70db8aa67aaba3=
f6a2fc4f38ef736bc 100644
> > --- a/drivers/md/dm-ioctl.c
> > +++ b/drivers/md/dm-ioctl.c
> > @@ -1394,6 +1394,13 @@ static inline fmode_t get_mode(struct dm_ioctl *=
param)
> >  static int next_target(struct dm_target_spec *last, uint32_t next, voi=
d *end,
> >  		       struct dm_target_spec **spec, char **target_params)
> >  {
> > +	static_assert(_Alignof(struct dm_target_spec) <=3D 8,
> > +		      "struct dm_target_spec has excessive alignment requirements");
> > +	if (next % 8) {
> > +		DMERR("Next target spec (offset %u) is not 8-byte aligned", next);
> > +		return -EINVAL;
> > +	}
> > +
> >  	*spec =3D (struct dm_target_spec *) ((unsigned char *) last + next);
> >  	*target_params =3D (char *) (*spec + 1);
> > =20
> > --=20
> > Sincerely,
> > Demi Marie Obenour (she/her/hers)
> > Invisible Things Lab
>=20
> Hi
>=20
> Some architectures (such as 32-bit x86) specify that the alignment of=20
> 64-bit integers is only 4-byte. This could in theory break old userspace=
=20
> code that only uses 4-byte alignment. I would change "next % 8" to "next =
%=20
> __alignof__(struct dm_target_spec)".

That=E2=80=99s fine, provided that the rest of the code is okay with 4-byte
alignment.

> I think that there is no need to backport this patch series to the stable=
=20
> kernels because the bugs that it fixes may only be exploited by the user=
=20
> with CAP_SYS_ADMIN privilege. So, there is no security or reliability=20
> problem being fixed.

I agree that there is no reliability problem, but with kernel lockdown
root =E2=86=92 kernel is a security boundary, so fixes for memory unsafety
problems should still be backported IMO.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--atMqDGrroiLEtsgA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmSUrr8ACgkQsoi1X/+c
IsEIoA/8DWkGd0KGw2WnHuJEvQDRBwlh1Ul4+Bx9L6TCUVH56McjuQR+fUiH/QKg
PGQJSofqHwfFcaadQpHjJSp5FNcElA2gfFARBtOnFkRZAnytpZkEdvbgcPeNC0iD
1C3ss025m7IBVFxyWXbZqL6fyAIsYPSFjYUmlRVJ7lUySzUNIbTuuXoRWtzRdv9D
CmJlKfSI1LDuPVcV96bTJtTXItG+6whsKyQSoZOUV7Wg4JVpO+OqPaBahZFX20Ju
ArgxFM4N1u4VZQjUqf63YwT5ijjNIFOgsh/h37H7H4LtGYcRyu7oSFby8klfQa2T
aOexZyalxphANKoZm4AYpbx1Zp4G0g2Y1r06anldmNsD2PZsbFBsgv7lX2dJapVY
01JaexjpJuvtLQ4NrJgiVOd4Is2C26P3cQnb1R7mdwiwmyf6tWlkkqayVSI8JJJV
EdHnPvYJyx5hKZH8eSeodb8ylcRZoWGROdCu3m3hOBU6+asBfqwXLx80RiFqSLAy
998TUZZ2rfJYLZsvYmNNBdfBQC65xp4iO+sB4Me0By9e3r5tJO27tKm63LR1oO63
wlmPQYEnMFUr1gX2u7opD3XJPow9d9MBk2mjwN0IKqjqyni7kieNTU7MpnVEIaa9
agQLGBCuQ/lQm3zC/OTbpIF1F4ledIhfeGoV0jhOGXiQYfCB/i0=
=Ls9+
-----END PGP SIGNATURE-----

--atMqDGrroiLEtsgA--
