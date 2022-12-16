Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB6C64E6B2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 05:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiLPEbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 23:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiLPEax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 23:30:53 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB22ABE08;
        Thu, 15 Dec 2022 20:30:45 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.98.53]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MIdNt-1pBCto2rlF-00EbLU; Fri, 16 Dec 2022 05:30:17 +0100
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 3DB2A3C0C9;
        Fri, 16 Dec 2022 05:30:14 +0100 (CET)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id F178737A; Fri, 16 Dec 2022 05:30:10 +0100 (CET)
Date:   Fri, 16 Dec 2022 05:30:10 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     David Laight <David.Laight@aculab.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] kbuild: ensure Make >= 3.82 is used
Message-ID: <Y5v0UpL6WFafKYIS@bergen.fjasle.eu>
References: <20221211030352.2622425-1-masahiroy@kernel.org>
 <Y5djBr9rVhSq8+iK@dev-arch.thelio-3990X>
 <Y5f4ZgyK7QlqYu31@bergen.fjasle.eu>
 <6c4413040a624b728081e27213fb46a1@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="utwNP9iZHO2yxSWK"
Content-Disposition: inline
In-Reply-To: <6c4413040a624b728081e27213fb46a1@AcuMS.aculab.com>
Jabber-ID: nicolas@fjasle.eu
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:9oqv30GxUUMy72uhruRoe7PIaKukv+E3i+minznA0Pas5iBDTY7
 DDdgSC15yFIM0oSwmumEPQ3OkDCjo1xV6BkGOCWnOqZDkevHEgJP4EKdf53+io/CIx1MCvl
 OMCX7vx2viQnocKEefn5w9eKEJ5YuiP53HeSy8Pk6AC+oJrUvD9WdUnVxHYs6Ifm/OrfogP
 m52Ob12/T8Pc+QodB7k2A==
UI-OutboundReport: notjunk:1;M01:P0:jtCCvBiKSaU=;LBXgIUEtWrHh3G0E6mkDEJPXDUs
 rnCCkP13lZ+wLvWnQfrFg3lw7+zXpyfXQKgjMywkE3z+RpRE+JwIZrrwznvUOr5Ld5thtm7b2
 2TV7YlG5kO0RaT6Ms+SH2SUOLUAw6QmU/rZEGL9slBeZnDl7z/MmHrGIDZve+dGd+JYoag7YN
 jOEtrgq2j1YD4IdRDk9uXv7EzQbSsmdi6/bXzIlFx6tIzz87PRCYDqOd+tFroDDD71dD3xYIU
 Y698fxKFrZDMhENeHt8fzv0Saqv6kSkobtBn7nCl8NbPvsPbc/6T2yA9IgW7ej6BejNDEqOsI
 pN637bOhV+fdFvG3a6X66attSkoTO2++L76ej3lCHwpFbxLlMv+sD+57o6TL8w46m+Fq7+oTb
 c6jvWmNZhopqxjT7FLWqRVOkyEYdTM2X4f2VbloSPMzjnjIEb+b1gV3dQ8EBw3PS08E0QI4Zy
 QcS62jFlP8WCHVjRDe/C0h1HL0s/Z/x9hdnQLaIiTmAWSLkG66Y8sGalrndsGD1+idS3bSVrI
 13kY2YnjaDu31Z/Bg0klXOXMiMO/DvT0HTxXVv+EgdaPXeZf1HooHpbC1Ur/IYf4bxHsr0O3L
 /QWYPqT3/t8kr+t6Rq/chiX9rYMaIgsMGduJH4xrzrwplpHMFHJg8wyTMbZfcmCeObY+n25WL
 uGap2shNN7svB4PuHGIEwQ2QqMxpGSS7tI4NPX87Aw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--utwNP9iZHO2yxSWK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 14 Dec 2022 11:05:10 GMT, David Laight wrote:
> From: Nicolas Schier
> > Sent: 13 December 2022 03:59
> ...
> > > > diff --git a/Makefile b/Makefile
> > > > index 2dda1e9a717a..66dfc5751470 100644
> > > > --- a/Makefile
> > > > +++ b/Makefile
> > > > @@ -11,6 +11,11 @@ NAME =3D Hurr durr I'ma ninja sloth
> > > >  # Comments in this file are targeted only to the developer, do not
> > > >  # expect to learn how to build the kernel reading this file.
> > > >
> > > > +# Ensure Make >=3D 3.82
>=20
> Wouldn't it be better to say either:
> 	# Ensure gmake supports 'undefine' (added in 3.82)
> or:
> 	# Building with gmake versions prior to 3.82 fails due to
> 	# bug 'brief description'.
> 	# Check for 'undefine' support as a surrogate for the bug fix.
>=20
>     David

'undefine' is not the only feature that has been introduced in make=20
3.82 that we use,  e.g. 'private' keyword is used in rust/Makefile but=20
'private' is not checkable via .FEATURES.  Checking for 'undefine' in=20
=2EFEATURES is kind of a hack to detect make 3.82, but as written=20
earlier, it prevents doing other explicit version comparison like=20
$(filter-out 3.80 3.81 3.82 3.99.% $(filter 1.% 2.% 3.*)).

I think $(filter undefine,$(.FEATURES)),) is a sensible compromise.

Kind regards,
Nicolas

--utwNP9iZHO2yxSWK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmOb9E0ACgkQB1IKcBYm
Emk1wRAAquVjsbp9mSWFQtp6d3azhpmjHL3ZnbefyJvrkyq8y9YOd1FtRoZdZbwF
48SKn8jSea+Lc8i3Rrj7aiKnwN5w1T/E/vChKjf6fpssYMiu1vfLlRkEwGB/biN9
W8bSmh0LMQ0h+6MdSGlOUhzddrPLkgGW11PzndYijoA6syFuplYdMZZj8UA47l6u
HuCcqS4p2GA20s//yPvvn0BBkAVkq5msh74ywXI7gD1BAqVSuDG4wttoVpmXn3xc
s+MkSvIiIhRymuVHXTr5hFl/nWCyCwagwiToOH7RJS006oi/4m+nLRBwcbersok/
ud9V9hcLhgItGBIWMa9XXJ665gWpIhenQ1U42jZJR7Q6VLnZQRP41AFhEbP7uBsM
taSvkGqH22+hQhV8seKo0cenOlSVxA1+2lJJGpKHTkHPVtKLIbd8dwoYUD0o5lLb
XNKNPpoLsaQtixnXbnsBrcyvjiNItovFTGzjpNKwT/GGV7zCk1C5gAcs7YSl8MIO
mvQnzx+h8bSx7JEjOx8RNldA/9xL0X++4Xnz/zZvAV6WoLmoKodAvoKyePuaUoTA
/OKUsZFhxveQDcCApSj9BJ0E4luM/4wZkV+gcVshpnirTInHGgAaPGLtET+teues
DWR1xY5V0k7Q3wb2xlT08Z0wCDSsWg385CcI3ZW9dwkjODrek3k=
=gyaj
-----END PGP SIGNATURE-----

--utwNP9iZHO2yxSWK--
