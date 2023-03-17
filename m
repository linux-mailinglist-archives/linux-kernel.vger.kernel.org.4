Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9506BDD4F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 01:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjCQAFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 20:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjCQAFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 20:05:13 -0400
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976E06BDD2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 17:05:11 -0700 (PDT)
References: <20221217084155.663235-1-mgorny@gentoo.org>
 <CAK7LNAQ8=YbOVvugBUQBo8eXRMH+YA49aS-1C=2hCGq0xoW7XA@mail.gmail.com>
 <628c5e32a437ad198866b03f2d6ff8a9c65754df.camel@gentoo.org>
 <897BDBF1-6C6E-4C69-8BA7-FEEFEB8ADC11@gentoo.org>
 <1416803D-E4E9-426B-8419-60251B8245B7@gentoo.org>
User-agent: mu4e 1.8.14; emacs 29.0.60
From:   Sam James <sam@gentoo.org>
To:     =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
        yamada.masahiro@socionext.com
Cc:     Dmitry Goldin <dgoldin+lkml@protonmail.ch>,
        linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dist-kernel@gentoo.org
Subject: Re: [PATCH] kheaders: prefer gtar over tar for better compatibility
Date:   Fri, 17 Mar 2023 00:04:36 +0000
In-reply-to: <1416803D-E4E9-426B-8419-60251B8245B7@gentoo.org>
Message-ID: <87wn3g2qfk.fsf@gentoo.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Sam James <sam@gentoo.org> writes:

> [[PGP Signed Part:Undecided]]
>
>
>> On 17 Jan 2023, at 19:01, Sam James <sam@gentoo.org> wrote:
>>=20
>>=20
>>=20
>>> On 25 Dec 2022, at 16:33, Micha=C5=82 G=C3=B3rny <mgorny@gentoo.org> wr=
ote:
>>>=20
>>> On Sun, 2022-12-25 at 01:45 +0900, Masahiro Yamada wrote:
>>>> Instead of inserting a workaround like this,
>>>> another way is to allow users to override a variable
>>>> from the command line.
>>>>=20
>>>>=20
>>>> See the top Makefile, for example,
>>>>=20
>>>>=20
>>>> AWK             =3D awk
>>>>=20
>>>>=20
>>>> Then, users can do "make AWK=3Dgawk"
>>>=20
>>> I'm sorry but are you requesting that I remove the check and use $TAR
>>> instead, or allow overriding with TAR, and fall back to gtar or tar
>>> respectively?  If the former, should the script unconditionally assume
>>> that TAR will be always set in the environment, or include fallback to
>>> tar for when the script is run directly?
>>=20
>>=20
>> Masahiro, what do you reckon? Thanks.
>>=20
>
> Ping.

ping^2. We'd really love to get this in to fix a bug for our users in
Gentoo.

>
>> Best,
>> sam
>
>
> [[End of PGP Signed Part]]


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iOUEARYKAI0WIQQlpruI3Zt2TGtVQcJzhAn1IN+RkAUCZBOusV8UgAAAAAAuAChp
c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0MjVB
NkJCODhERDlCNzY0QzZCNTU0MUMyNzM4NDA5RjUyMERGOTE5MA8cc2FtQGdlbnRv
by5vcmcACgkQc4QJ9SDfkZBxFAD+JBeFAe0c+gzCpovBYIpWGW0bYgbqSTYNsmSG
bq+Jd7QBAJfSEJpOeh6rTQO6x3vtroZy1UwzzO9GlUPT4SYIgjQP
=goNs
-----END PGP SIGNATURE-----
--=-=-=--
