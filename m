Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633BE68EFB0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 14:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjBHNV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 08:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjBHNV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 08:21:57 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615CE199E8;
        Wed,  8 Feb 2023 05:21:55 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230208132153euoutp01c3b4e2b5d573475f498098642d27990c~B3BOgfxjl2262122621euoutp01l;
        Wed,  8 Feb 2023 13:21:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230208132153euoutp01c3b4e2b5d573475f498098642d27990c~B3BOgfxjl2262122621euoutp01l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1675862513;
        bh=ow1P+4R9xcwHOMc6AOQpT3Y+AH7tNX4VNmWplSvRkb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B2u5WQCFpOFFZlAFFFdUBhc2fFSCh2YLazHXc1XHGDIhSHZPoIzA8zA+TY16/XpEq
         CAdrGytGFuLP5zcLZYoRBw6okyneiR3+7aCuKamntbxQ2wPGaM3Y7IXnERa0/FzF0s
         VElRELJcMQBfsVeNG/jbP/u5LQ/CtDfpy0EQtzQ0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230208132152eucas1p2f4532a1d44c44db19b6b92be93bde8bc~B3BOEeAVo1231112311eucas1p2c;
        Wed,  8 Feb 2023 13:21:52 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C7.D8.01471.0F1A3E36; Wed,  8
        Feb 2023 13:21:52 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230208132152eucas1p2247790aae3aa897db4a265f5bc7bf28c~B3BNuM2N21231112311eucas1p2b;
        Wed,  8 Feb 2023 13:21:52 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230208132152eusmtrp2416a335a1618468c8a2c166ee48125d7~B3BNtk8Ts1338213382eusmtrp2U;
        Wed,  8 Feb 2023 13:21:52 +0000 (GMT)
X-AuditID: cbfec7f2-2b1ff700000105bf-4f-63e3a1f090f1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 42.99.02722.0F1A3E36; Wed,  8
        Feb 2023 13:21:52 +0000 (GMT)
Received: from localhost (unknown [106.120.51.111]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230208132152eusmtip23454cda8d87d75c4b125a23cecd9366f~B3BNhp0BX2783327833eusmtip2-;
        Wed,  8 Feb 2023 13:21:52 +0000 (GMT)
From:   Lukasz Stelmach <l.stelmach@samsung.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] merge_config.sh: do not report some differencess
 between input and output
Date:   Wed, 08 Feb 2023 14:21:37 +0100
In-Reply-To: <20230208130732.63172-1-l.stelmach@samsung.com>
        (=?utf-8?Q?=22=C5=81ukasz?= Stelmach"'s message of "Wed, 8 Feb 2023 14:07:31
        +0100")
Message-ID: <dleftjy1p8e1i6.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsWy7djP87ofFj5ONlj0QtXiz64dTBaXd81h
        s1h75C67xcMHN1gdWDw2repk8+jbsorR4/MmuQDmKC6blNSczLLUIn27BK6MGdsXMhZ08Fe0
        LPjK0sD4mqeLkZNDQsBE4ubnx8wgtpDACkaJDU88uxi5gOwvjBK9l7vZIJzPjBL3Xr9ggul4
        tPk4C0RiOaPElpa7TBDOC0aJtq4lQC0cHGwCehJr10aANIgIaEncWdrBChJmFsiTePI0FiQs
        LJAs0b/3JjuIzSKgKvFs+iJ2kDGcAlMZJRbuOw92Eq+AucTzxm+sILaogKXEn2cf2SHighIn
        Zz5hAbGZBXIlZp5/wwjSLCFwgUNiyq9+dohLXSRu3rgEdbWwxKvjW6DiMhL/d85ngmhoZ5Ro
        urKQFcKZwCjxuaMJqsNa4s65X2wQtqPE18md7CAvSAjwSdx4KwixmU9i0rbpzBBhXomONiGI
        ahWJdf17WCBsKYneVysYIWwPiasPZ0GDtJ9RYu/X3SwTGBVmIXloFpKHZoEDTFNi/S59iLC2
        xLKFr5khbFuJdevesyxgZF3FKJ5aWpybnlpsmJdarlecmFtcmpeul5yfu4kRmGxO/zv+aQfj
        3Fcf9Q4xMnEwHmJUAWp+tGH1BUYplrz8vFQlEd7vEx8nC/GmJFZWpRblxxeV5qQWH2KU5mBR
        EufVtj2ZLCSQnliSmp2aWpBaBJNl4uCUamCqqD+esqvZl/W4kXK3nm/9Rtlbh775qossD7r2
        4uncLScn7Hzj7Vn30nrGsp2uybPEK5yyEqJM33Wrxsbd2jarW2XOieDd1++ctzuQZJByXrBl
        Xl34mzX+qYlNEn9N7Z6VO05fXRa/dOGLpXbrbn92SDfsXMH3ifn2W0WGf1ufuX5sz/hmUKrG
        lfxh3hG3R9fvMv3qLZwoVHB28wr12/N0vl7/6y+wxLGd869XTLj+rq+smsuP7Rf73xn/oDe7
        5a/jrpA5yX2Tn6fpbBOeOOviydaEV6YiqQUvgpr2zo3bemVHdXVVwusHWutdO+Trn+x4VX1v
        wTvTUP6zm/lmsnrxet9eJ9N8YFva33dRha8XKrEUZyQaajEXFScCAIrO/ESxAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsVy+t/xe7ofFj5ONph9WcDiz64dTBaXd81h
        s1h75C67xcMHN1gdWDw2repk8+jbsorR4/MmuQDmKD2bovzSklSFjPziElulaEMLIz1DSws9
        IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MGdsXMhZ08Fe0LPjK0sD4mqeLkZNDQsBE4tHm
        4yxdjFwcQgJLGSW27ZzJ2MXIAZSQklg5Nx2iRljiz7UuNhBbSOAZo8TW92wgJWwCehJr10aA
        hEUEtCTuLO1gBbGZBfIl/k37wQ5iCwskS/TvvckO0WotsefSNkYQm0VAVeLZ9EVgcU6BqYwS
        B7elgdi8AuYSzxu/gc0RFbCU+PPsIztEXFDi5MwnLBDzsyW+rn7OPIFRYBaS1CwkqVlA1zEL
        aEqs36UPEdaWWLbwNTOEbSuxbt17lgWMrKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECY2Tb
        sZ+bdzDOe/VR7xAjEwfjIUYVoM5HG1ZfYJRiycvPS1US4f0+8XGyEG9KYmVValF+fFFpTmrx
        IUZToNcmMkuJJucDozevJN7QzMDU0MTM0sDU0sxYSZzXs6AjUUggPbEkNTs1tSC1CKaPiYNT
        qoHpmA93QMXxbSFXV2zVjXueHxx8dAdryLGIFIcXl+QqrHak5c6W3br9gmBJbHUMe1jycjYe
        PxmdmWIKWe08/xYuTbjt//tj2U5TtlXWl61Fnh95vPS859IvBdlPS+zzOY5yBe1f5C5e0fmZ
        9WjHhc5vE7SYXkvu2H3Km3H2m7uPzkV0zhPfMcfL4v+57BJZGYNaj4q53r++One5u0vtfMG8
        JO/6zJMvU6fZxWoVJccuMjspssd8VYSm1MRb89gP8hgVRDx2e7Gxn3t75iZ5vdvpH1dHNSz/
        ZOiRUKfGkr2n/NGKxbE3JxV9rIqWT/c+97WwwE9TfM9k7V+bWvO/LN+yWuHOYUXB+DnFAow1
        egJKLMUZiYZazEXFiQC7nweSJgMAAA==
X-CMS-MailID: 20230208132152eucas1p2247790aae3aa897db4a265f5bc7bf28c
X-Msg-Generator: CA
X-RootMTR: 20230208132152eucas1p2247790aae3aa897db4a265f5bc7bf28c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230208132152eucas1p2247790aae3aa897db4a265f5bc7bf28c
References: <20230208130732.63172-1-l.stelmach@samsung.com>
        <CGME20230208132152eucas1p2247790aae3aa897db4a265f5bc7bf28c@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2023-02-08 =C5=9Bro 14:07>, when =C5=81ukasz Stelmach wrote:
> If an input config file contains CONFIG_FOO=3Dn the output one
> will contain a line '# CONFIG_FOO is not set'. merge_config.sh
> should not report it as difference because the end result of
> CONFIG_FOO being disabled is achieved.
>
> Inexistence of CONFIG_FOO (because of unment dependencies) in case
> CONFIG_FOO=3Dn is requested, should also be ignored.
>
> Change-Id: I129f3a0b4205a76d8c42020f8adb72b1889d75fb

Do you want me to resend without this one?

> Signed-off-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>
> ---
> Changes in v2:
> - suppress reports reports if an option was "not set" in input files
>   but is missing from the filnal .config due to unmet dependecies.
> - apply the same logic to suppress some reports during the merging
>   phase
>
> BTW. Do you think adding "| sort -u" after "grep -w" to avoid reports
> about repeated entries may make sense or do you want such reports to
> be printed.
>
>  scripts/kconfig/merge_config.sh | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)

[...]


=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAmPjoeEACgkQsK4enJil
gBCNCgf+MSFgL/8/4Gm0KU5JL3ai8lVoyXgxwdROcYJ3Hv8TOAHc9HkNDmKDDvoe
wuLAAWdnU9ULn6GbBd8wtJqbq4SFJ8KRIq/LaAi49DetFAe5RXPoxOEGzn0km/5M
pn+QMAjvCo9kLXrufAtp2hSnMIeMG7DXoO1+hIrckm5dJzA/L59MGPKH56LxZxPf
CeJzS6PFbrGpEZzTAAFJfwXOq2da9+uLQl4qvjr67muwH/bVGkwa5WZW7f1aMEb0
hLhdDMwwDPnztnbkewTrA+tr1iYZlyOwTaeWrY79G52fsztyodBKPO8UhO5Hr31A
mHV4JYS813yTWlErzVJQxaE0gVU3BA==
=Oqs9
-----END PGP SIGNATURE-----
--=-=-=--
