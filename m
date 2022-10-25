Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4606060D078
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbiJYPYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbiJYPYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:24:30 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6D32BB1A;
        Tue, 25 Oct 2022 08:23:05 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4ECFF240003;
        Tue, 25 Oct 2022 15:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666711384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qDzusZ9A8zw1jVXS4iAKbgJV8r3mCHdkLf1MyFvx4gk=;
        b=WyQWk65ertDntaKhrGj2iEo9HpiA+d4viIf1ns4+LTjL95FFJj5RygO21qTem71T734nMU
        XuFdPvOe3SmnjD1hJ+Z/cEwn0j4R4PsZlGPJ8Fldbt43ScGRbt0KWzH2gPCBXrdb7pMqCt
        tmpzhW6N+nEO+LS8MnOFxA5edif7JHq89c1iXH4YiwaCcDLCNgJsNYWgM782c1EHXKwSN/
        vu/Q6w3dgJv/6gDN43FtD61zcadhTxBb8NZ0ZAqiQo5xICYa89ushQMdyJzT3U3yg16Dtb
        cP1yW44UuAwQD2fUa761qEcPQnDGHLAXciStnBRnV+Rv6AG2+zVCFLqtdyyYug==
Date:   Tue, 25 Oct 2022 17:22:59 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, mripard@kernel.org,
        mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] media: cedrus: Add helper for checking capabilities
Message-ID: <Y1f/U8NxyJo/pMAH@aptenodytes>
References: <20221024201515.34129-1-jernej.skrabec@gmail.com>
 <20221024201515.34129-5-jernej.skrabec@gmail.com>
 <Y1eChJS/0aEchtpH@kadam>
 <13124586.uLZWGnKmhe@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="W34rlajBUncxrU/f"
Content-Disposition: inline
In-Reply-To: <13124586.uLZWGnKmhe@jernej-laptop>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W34rlajBUncxrU/f
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jernej,

On Tue 25 Oct 22, 17:17, Jernej =C5=A0krabec wrote:
> Dne torek, 25. oktober 2022 ob 08:30:28 CEST je Dan Carpenter napisal(a):
> > On Mon, Oct 24, 2022 at 10:15:08PM +0200, Jernej Skrabec wrote:
> > > There is several different Cedrus cores with varying capabilities, so
> > > some operations like listing formats depends on checks if feature is
> > > supported or not.
> > >=20
> > > Currently check for capabilities is only in format enumeration helper,
> > > but it will be used also elsewhere later. Let's convert this check to
> > > helper and while at it, also simplify it. There is no need to check if
> > > capability mask is zero, condition will still work properly.
> >=20
> > Sure.  That's true.  Out of curiousity, can cedrus_formats[i].capabilit=
ies
> > be zero?  Because it feels like that's what should be checked.
>=20
> Yes, it can be. It's the case for V4L2_PIX_FMT_NV12_32L32. All variants=
=20
> supports it, so there is no special capability needed in order to be list=
ed.=20
> What would you check in such case? Condition still works for this case.

I think the problem is that (bits & 0) =3D=3D 0 is always true.
So if the input caps are 0, we need to make sure to return false.

Cheers,

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--W34rlajBUncxrU/f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmNX/1MACgkQ3cLmz3+f
v9Hflwf/W2MqmRYak1O1TUFjnU5lVd99pw1YkGwToYlc9u+6GUXrUy0MBg0vXhOB
o0P+HJNDhO1cRPqpTWcL3B3dJ13j0RhTHOGQNFVtkedHoWsRKM3OGCYHlGgMwGQm
FBYMx7GgV6HkB3uox/fY60RAqYG42RWkm6h+lVwdb/771kNvEBDYX1U/rrQaLSCY
uh/6uKNqO6EtUaLYI/ox+7C35G2DZepkHz+9miOY7KDdgXBloFKA+9t8OdjYx899
KROzq5yjNk04Jbe3xFX9B2saxt8Y6OlxcElLKyZFBJ1NhjaGss14BToEH9etGQ/8
6gSrdpjlnmrKeVQvEFKhIhKxx56bpw==
=0zvP
-----END PGP SIGNATURE-----

--W34rlajBUncxrU/f--
