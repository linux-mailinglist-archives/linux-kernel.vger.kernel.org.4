Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3241D66E77D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 21:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjAQUK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 15:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjAQUI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 15:08:29 -0500
Received: from smtp.gentoo.org (dev.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272E99EDA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 11:01:55 -0800 (PST)
Content-Type: multipart/signed;
        boundary="Apple-Mail=_AD2B2963-45DD-4D19-8FA7-DDB227647BBD";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH] kheaders: prefer gtar over tar for better compatibility
From:   Sam James <sam@gentoo.org>
In-Reply-To: <628c5e32a437ad198866b03f2d6ff8a9c65754df.camel@gentoo.org>
Date:   Tue, 17 Jan 2023 19:01:39 +0000
Cc:     Dmitry Goldin <dgoldin+lkml@protonmail.ch>,
        linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dist-kernel@gentoo.org
Message-Id: <897BDBF1-6C6E-4C69-8BA7-FEEFEB8ADC11@gentoo.org>
References: <20221217084155.663235-1-mgorny@gentoo.org>
 <CAK7LNAQ8=YbOVvugBUQBo8eXRMH+YA49aS-1C=2hCGq0xoW7XA@mail.gmail.com>
 <628c5e32a437ad198866b03f2d6ff8a9c65754df.camel@gentoo.org>
To:     =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
        yamada.masahiro@socionext.com
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_AD2B2963-45DD-4D19-8FA7-DDB227647BBD
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 25 Dec 2022, at 16:33, Micha=C5=82 G=C3=B3rny <mgorny@gentoo.org> =
wrote:
>=20
> On Sun, 2022-12-25 at 01:45 +0900, Masahiro Yamada wrote:
>> Instead of inserting a workaround like this,
>> another way is to allow users to override a variable
>> from the command line.
>>=20
>>=20
>> See the top Makefile, for example,
>>=20
>>=20
>> AWK             =3D awk
>>=20
>>=20
>> Then, users can do "make AWK=3Dgawk"
>=20
> I'm sorry but are you requesting that I remove the check and use $TAR
> instead, or allow overriding with TAR, and fall back to gtar or tar
> respectively?  If the former, should the script unconditionally assume
> that TAR will be always set in the environment, or include fallback to
> tar for when the script is run directly?


Masahiro, what do you reckon? Thanks.

Best,
sam

--Apple-Mail=_AD2B2963-45DD-4D19-8FA7-DDB227647BBD
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iNUEARYKAH0WIQQlpruI3Zt2TGtVQcJzhAn1IN+RkAUCY8bwk18UgAAAAAAuAChp
c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0MjVB
NkJCODhERDlCNzY0QzZCNTU0MUMyNzM4NDA5RjUyMERGOTE5MAAKCRBzhAn1IN+R
kOAGAQCSppR28ni2U15wpr98qaBB4T9x9EYwCGkM7bh0WdzTrAEA8HU+ojCiaSyn
TrTQ59BVbVBI3BhHF+/4wFS9FLp1rgc=
=WMyv
-----END PGP SIGNATURE-----

--Apple-Mail=_AD2B2963-45DD-4D19-8FA7-DDB227647BBD--
