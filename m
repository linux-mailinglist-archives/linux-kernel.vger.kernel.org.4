Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DCD70F4B2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjEXLD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 07:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbjEXLDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:03:24 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7417318D;
        Wed, 24 May 2023 04:03:18 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230524110315euoutp0164dd9b15490eea079dfd58f7d0450215~iD3KJbQo02918229182euoutp01a;
        Wed, 24 May 2023 11:03:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230524110315euoutp0164dd9b15490eea079dfd58f7d0450215~iD3KJbQo02918229182euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684926195;
        bh=1wcT/DkBhdgsOklpLQ5lKaDqe8ag/M99XfXWcx+uvfY=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=LJvr8mW2xp+BQS+70FzMaVSJ9cCoj+cFtgzcFqZcwZpObUONV+6GINvm9/A3H3/V5
         h+NJeUFQfzDfyXUrCrKubXdFpHaZxi5b9k59b0EYeMPOizQwi6kZhcxEA8Gn/zpp/E
         RcUOBinroP7vbLDpxoYamgzo20d9iYz6k2ugZf28=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230524110314eucas1p2d86f0d523121fe9267eb82fd5380ad44~iD3JvU1oX1469714697eucas1p2U;
        Wed, 24 May 2023 11:03:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 4B.9A.11320.2FEED646; Wed, 24
        May 2023 12:03:14 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230524110314eucas1p257ca6d02f8774bd0d027a380d036e11c~iD3JYmuMG2372923729eucas1p2M;
        Wed, 24 May 2023 11:03:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230524110314eusmtrp1aac54e4ca3211491560b71a9619a2cdc~iD3JX-L4P1914619146eusmtrp1l;
        Wed, 24 May 2023 11:03:14 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-e1-646deef26d3e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 24.A7.10549.2FEED646; Wed, 24
        May 2023 12:03:14 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230524110314eusmtip10af4039497324dc4d4feee9f091815b9~iD3JN-2l22523125231eusmtip1U;
        Wed, 24 May 2023 11:03:14 +0000 (GMT)
Received: from localhost (106.110.32.133) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 24 May 2023 12:03:13 +0100
Date:   Wed, 24 May 2023 13:03:12 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: bott test warning
Message-ID: <20230524110312.ymt5hgwkzwkybbog@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="rko4m7q4vw4gjshi"
Content-Disposition: inline
In-Reply-To: <20230524160724.0df28220@canb.auug.org.au>
X-Originating-IP: [106.110.32.133]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsWy7djP87qf3uWmGFxYqWNxedccNouDC9sY
        LW5MeMposXXvVXYHFo/GGzfYPDat6mTz+LxJLoA5issmJTUnsyy1SN8ugSvj/J6vbAUd3BWP
        LlxlbWC8xdnFyMkhIWAisXrqZTYQW0hgBaPEuwadLkYuIPsLo8SVY/MYIZzPjBI99yezwnQc
        /NTDCpFYziixds4ndoSq9zdYIGZtYZTovSrUxcjBwSKgKrHhgQRImE1AR+L8mzvMIGERAW2J
        A78FQFqZBeYwSry6+IQVJC4soCXRtM0EpJxXwFyi9+8RFghbUOLkzCdgNrNAhcTmoxvBxjAL
        SEss/8cBYnIClV95zAJxpZLE1ze9UBfXSpzacosJZJOEwAcOifOnd7FBJFwkPvefYoSwhSVe
        Hd/CDmHLSJye3MMC0TCZUWL/vw/sEM5qRolljV+ZIKqsJVquPIHqcJS4vXgHC8gVEgJ8Ejfe
        CkLcyScxadt0Zogwr0RHmxBEtZrE6ntvWCYwKs9C8tksJJ/NQvgMIqwjsWD3JzYMYW2JZQtf
        M0PYthLr1r1nWcDIvopRPLW0ODc9tdgoL7Vcrzgxt7g0L10vOT93EyMwJZ3+d/zLDsblrz7q
        HWJk4mA8xKgC1Pxow+oLjFIsefl5qUoivCfKs1OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ82rb
        nkwWEkhPLEnNTk0tSC2CyTJxcEo1MJkp+hqHpE66WWO+pJN75tv/W9Yn7O12602Y+/1hhnbx
        oY4FR1+kRf9qiQssOVokeqqMpT7c4oe6Yqz7pBcfPvx2enlc/Xbcqg3urStKvYKVanbc2N4t
        5jmP07RxwnXe1QJuC0yjnp2MPFou0778y/0fAlPSApyltY8JbL5ae2lHvHN5/N/Zvwzn58wL
        OqIcqV4f83JtiID9OcM7ogV6l3INzF7aZP17fvs3X2mMy5oFR9Uzg7fZfP8S3i3ZW8K0lYdV
        zkOndZl6QU2x6IRf25hc7Vd9iM2td3R/xBqw6c/3GO4rx9/4SE08MjEs/uwN43gBwXdN/bZ/
        ffbKX9H8cfbVpufFGbtY10zxuBBcocRSnJFoqMVcVJwIACyoc2zEAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsVy+t/xu7qf3uWmGPQ+EbK4vGsOm8XBhW2M
        FjcmPGW02Lr3KrsDi0fjjRtsHptWdbJ5fN4kF8AcpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFn
        ZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJex8oNBQRt3xa1D8xkbGG9wdjFyckgImEgc/NTD
        2sXIxSEksJRR4se5Z6wQCRmJjV+uQtnCEn+udbFBFH1klJhwayMjhLOFUeLwic3sXYwcHCwC
        qhIbHkiANLAJ6Eicf3OHGSQsIqAtceC3AEg5s8AcRolXF5+wgsSFBbQkmraZgJTzCphL9P49
        wgIx8imjxLt/d9ghEoISJ2c+YQGxmQXKJDb+XcEC0sssIC2x/B8HiMkJ1HvlMQvEmUoSX9/0
        Qp1cK/H57zPGCYzCs5AMmoVk0CyEQRBhLYkb/14yYQhrSyxb+JoZwraVWLfuPcsCRvZVjCKp
        pcW56bnFhnrFibnFpXnpesn5uZsYgZG57djPzTsY5736qHeIkYmD8RCjClDnow2rLzBKseTl
        56UqifCeKM9OEeJNSaysSi3Kjy8qzUktPsRoCgzCicxSosn5wJSRVxJvaGZgamhiZmlgamlm
        rCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXAZKQlfnrJihD3e1JnDPnfzLycdJ4rIm1no+0m
        w3vXGfMfnbrtGP+/2/O6Q0jcqhsxTFJZe3V4zwoJc/1+YbHvxQbu2TJpR9Ke2ZdV8l5Xf2Ew
        OfzSxqff33S/6z1+6Vt62uVHJ06t2F76WPNVSPKfX6e+TI5v+BcgsOG3Gl9W3jpbmehdy1Oy
        k5RT9k37F+PP9j17rqyGkU+MQlmIexHX+itOHU8ilVfaqzFLpBpnzPyWPKvkfWTW2mftzCqb
        pQ/YXA1OXlH/ybCa4Z6n9POo2VE8LMJ2ZVorO1lKTzvtrUl5Xjmr8W72zYUOS6aW9BxfPrNl
        er/Szpip9wuDjr3jkTjsoP6vVpDJYO3h/ZyzlFiKMxINtZiLihMBlR3oBmEDAAA=
X-CMS-MailID: 20230524110314eucas1p257ca6d02f8774bd0d027a380d036e11c
X-Msg-Generator: CA
X-RootMTR: 20230523035747eucas1p2f10754f5eb6759d6665a35562c523841
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230523035747eucas1p2f10754f5eb6759d6665a35562c523841
References: <CGME20230523035747eucas1p2f10754f5eb6759d6665a35562c523841@eucas1p2.samsung.com>
        <20230523135739.73068c68@canb.auug.org.au>
        <20230523112001.owwx7sa7qofwuzfd@localhost>
        <20230524160724.0df28220@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--rko4m7q4vw4gjshi
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2023 at 04:07:24PM +1000, Stephen Rothwell wrote:
> Hi Joel,
>=20
> On Tue, 23 May 2023 13:20:01 +0200 Joel Granados <j.granados@samsung.com>=
 wrote:
> >
> > Does the attached patch solve the issue?
>=20
> Yes, it does.
Awesome!. This is already in mcgrof's tree so it is on its way upstream.

thx again.

Best

>=20
> Tested-by: Stephen Rothwell <sfr@canb.auug.org.au> # ppc boot only
> --=20
> Cheers,
> Stephen Rothwell



--=20

Joel Granados

--rko4m7q4vw4gjshi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmRt7vAACgkQupfNUreW
QU9GnAv/R8B95OoG62ZPWGunutbYTEp5nxiyt18E543ouhdHlBLpW2FP62oAwV+1
uE4gVWIY64a0cru5AiOk123NDuxz9fiG+adlv8tu6LiPE6+ZViUyu2OmaRRdh4KR
EYno1JnMVbq5qomRxHRjwX5yeatLz8aSOGAecuiopHXoz6Sj5Vkk44gC/Dr7rzjN
g3MHN7H7oCRmbacMkiM22Yqg7lJcL6Dgc4qsXJkSLsuW1AT8J4tE8quaTW1L9Zib
5wtCvkE60CPyD2OTX+PgKF+VvmUg2p7gmo7Bml82tVWHbRnRB5zLkA7kV37POkcJ
zPFcQ832fxh9DoCb8+BqWmJY4gLIaLxFPBv496bnPX1kehqoRXMX1EKx22HwZS4t
YeQb0yRL5fpan009M+xW+4B4SqDC7LsRS2nhgPWrnCx3eJkJJdew/q2KBdM+Nfkb
EDH41VR4qM6Byf/M/c0+Zdd0LmIyZNLSAxxA4ZXbTnSaEnPfJ1tha3sWXJNUUJVk
iBC+kk/T
=qOmm
-----END PGP SIGNATURE-----

--rko4m7q4vw4gjshi--
