Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E1A617CE0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 13:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiKCMoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 08:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiKCMoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:44:15 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C8310544
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 05:44:11 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221103124407euoutp0266d0ad2b9aa6f85b3b5f21fe2e934ae2~kE7j6cURV0671906719euoutp02H
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 12:44:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221103124407euoutp0266d0ad2b9aa6f85b3b5f21fe2e934ae2~kE7j6cURV0671906719euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667479447;
        bh=B8EIxwkHWzNB8cLxt3UbHYSl/fF2qLDPOKhcKQWxZSg=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=vc4Nq/xAH4WSpwAnmwBKvQbVpyJsCjQELDvgNd+uc/euI1TzPFmJAEs6JgMI3Hi/K
         ggetFC4vyCM1Q/lsD5e7XW52HO0DGT3PapX2HeANx8QB+IyOy0aDnSELSnRgJYAbJO
         Y5FcgsZzFtp7riiQObMkyEWHAs94+mXVEygEwbV4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20221103124406eucas1p1d076d20e0b1b94706c9baf30aa51cfad~kE7jZX9Rf2728927289eucas1p1Y;
        Thu,  3 Nov 2022 12:44:06 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 35.2C.07817.697B3636; Thu,  3
        Nov 2022 12:44:06 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20221103124406eucas1p23727d05069d1c388d2a59bc5d865d3f4~kE7i7sM9v1951319513eucas1p2s;
        Thu,  3 Nov 2022 12:44:06 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221103124406eusmtrp2538cb3ad859c157d8add95ce11e7a2c2~kE7i6lQ6m0302803028eusmtrp2f;
        Thu,  3 Nov 2022 12:44:06 +0000 (GMT)
X-AuditID: cbfec7f4-8abff70000011e89-7c-6363b796e314
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CA.7F.10862.697B3636; Thu,  3
        Nov 2022 12:44:06 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221103124404eusmtip1182775ac9b999fe766f39bcd3c2f271c~kE7hxl4ra0287302873eusmtip11;
        Thu,  3 Nov 2022 12:44:04 +0000 (GMT)
Message-ID: <aadbb452-506d-89cc-28d9-497369c0018e@samsung.com>
Date:   Thu, 3 Nov 2022 13:44:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH 2/3] media: s5p-mfc:Add variant data for MFC v7 hardware
 for Exynos 3250 SOC
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Aakarsh Jain <aakarsh.jain@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     andrzej.hajda@intel.com, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, ezequiel@vanguardiasur.com.ar,
        jernej.skrabec@gmail.com, benjamin.gaignard@collabora.com,
        krzysztof.kozlowski+dt@linaro.org, stanimir.varbanov@linaro.org,
        dillon.minfei@gmail.com, david.plowman@raspberrypi.com,
        mark.rutland@arm.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        andi@etezian.org, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        smitha.t@samsung.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <c55d29d2-a70a-f2ae-b605-1c63051202bf@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf1CTZRzned93716mw5cJ8Sie6FTu4goELJ+rjrMifP3xB93lcdl1Nccb
        cDGkTYi8E5Fy4iKY1JhbxPgNTmQ2YIAB5iIHzAzNmCdMUukGepwNsGguaduLxX+fz+f7/Tyf
        z/PcQ+Gib8i1VFbOIVaeI8kWkwLCcvnvn5+v7JJKt2pLt6Dfu3U89Fu1hUT1Cy4MTdTPEcja
        3slHHTe+xlGz7XseMgxc5aGuS3cJ9O2Ub3pN5ySQy9AG0LT+NonKpu7gqO+Bz2G+N8pDv1yo
        IlHp+U4eanRcw1CT2Yuhus55PjreN8BHzl4LQJ8pB7AdkGmtbgVMt7MBMI6GWZzp0Tv5TH3v
        NMaYjSdJZny0l2TaG44yx3/0EExZhxEwqgEHycyZ1zPDj+b4qcL9glfS2eysfFYel/S+IFNb
        pOTlFvMLilu1RBG4yVOBYArS2+AJdzmhAgJKRLcAeLnyD8CReQD/NCiXyByADeZS8qnFenaY
        xw2aAbx+rgnjiBvAKyNdfP+WkE6C7YP/YH5M0JvhOZ0L5/RQOKSbJPw4nE6H331uCeDV9AHo
        uVMbKIXTEfDWpCFwaBg9CWBdbUugIU6P4fBMT2OgB0nHQ9WMKoCDfWmO1nt8zh0Fu2aqcL8B
        0joB1CgXMK54MjTd1QAOr4b3bR18Dq+Diz1cHKRPAFjzeGKJqAEsct1acrwMx696fHGUL+JZ
        aLoQx8mvwtqJYuCXIR0Cb86EciVCYIVFi3OyEJYoRdx2NNTb2v6LvTRyHVcDsX7Zw+iXPYB+
        2XX0/+fWAMIIItg8hSyDVSTksB/HKiQyRV5ORqz0oMwMfD/Y/sQ23w2a77tjrQCjgBVACheH
        CY/+9I5UJEyXfHKYlR98T56XzSqsIJIixBFC8nSMVERnSA6xH7JsLit/OsWo4LVFWJlNrUks
        0G1dQ/WP64MTCwxu86aP3kguaU7cbE+xD52aHau3Dz6q2uONzt1p+ivLcLsjoSfauLHem3tE
        n/7VC6sKtFF5IDRoxcPG9k9z3A+9Z+t+sOSXvXWk4820ocKofRd3qSPzy4NkHk21LOz1FdvS
        sofNV36N363ev33Dhie7z3gL8ZJRw/Dwuz3uHakp87si96xzGVMPnFrpCv8AW3DavzjpmBVM
        T6orM7fHJYcf6zvsqUgoLMlsA888MK1POtb0Zdde+vGgmbjRL1OnhZIxa06fJxQWzcq3RxYr
        +kOG+srHYqqiX0rZZ9tb6TVtefFiwc7XNmLEc3NTLZuKpatqFoPEhCJTEh+DyxWSfwHyTmoL
        MAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsVy+t/xu7rTticnG5xvYLV4umMmq8WDedvY
        LBb/eM5kcX/xZxaLQ5u3sltsuTKb2WL58QOsFvOPnGO12H7wEYvFxhdA2Ysz77JYPJ+/jtHi
        5ax7bBZ9Lx4yW+x9DdSx6fE1VovLu+awWfRs2MpqsfT6RSaLZZv+MFks2vqF3aJ17xF2i7t7
        tjFatLQdYXKQ8Fgzbw2jx467Sxg9ri/5xOyxc9Zddo/Fe14yeWxa1cnmcefaHjaPzUvqPVqP
        /mLx6NuyitGj68h1No/Pm+Q8Tn39zB7AG6VnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdo
        bB5rZWSqpG9nk5Kak1mWWqRvl6CXMb2hjbWgib2iac10lgbGG6xdjJwcEgImEodWnwKzhQSW
        Mkqs7uGAiMtInJzWAFUjLPHnWhdbFyMXUM17RomJnZsYQRK8AnYSm0/8ZQKxWQRUJNbOfM4M
        EReUODnzCUsXIweHqECKxLdzdSBhYYEkiV8PF4LNZBYQl7j1ZD4TyEwRgSeMEis7vjKCOMwC
        t5klzq+fzA6x7SejxOcTG8E2sAkYSnS9BTmDk4MTaPP1NY/ZIUaZSXRt7WKEsOUltr+dwzyB
        UWgWkkNmIdk4C0nLLCQtCxhZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgSmm23Hfm7Zwbjy
        1Ue9Q4xMHIyHGCU4mJVEeOvPRicL8aYkVlalFuXHF5XmpBYfYjQFhsZEZinR5HxgwssriTc0
        MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5NLUgtgulj4uCUamDiSeKLNn5o0axR7LvKlsGN
        c1WITs+jOabHVEUnhL/6f+rD5qxD7Hr/Y7wffJ/VHP/+zplio6tuMzLd9aNn6TncaLrM8b6y
        ft/ehtzLKqbCOzi6Um5k1F7vO9mY+SzueNEalnMGzZOdwoWrblzbeX73Xy7m5edqDm1QX/4/
        afXPS1wCFZWNnGW8lzZVfS7nkH7Ur+HyZS/PNLnFlw9Pyg0/utfE7nncnaiwyuvvis5Lz7CU
        5qreEm6wNapgW+ipnQrSWRpcTh8vTT0crjB39ofHHzn/bz9nGDDl55drvhM9Jt40710wU8jp
        0bVC8x8fYlv1p63cyat6jW3Hna3LzTclubeLTr41J/NY+ME5Oh6pSizFGYmGWsxFxYkAMVUw
        7cADAAA=
X-CMS-MailID: 20221103124406eucas1p23727d05069d1c388d2a59bc5d865d3f4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20221102125813epcas5p40a38f17a267276ff8b2bc5861b5d450d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221102125813epcas5p40a38f17a267276ff8b2bc5861b5d450d
References: <20221102130602.48969-1-aakarsh.jain@samsung.com>
        <CGME20221102125813epcas5p40a38f17a267276ff8b2bc5861b5d450d@epcas5p4.samsung.com>
        <20221102130602.48969-2-aakarsh.jain@samsung.com>
        <c55d29d2-a70a-f2ae-b605-1c63051202bf@linaro.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.11.2022 13:35, Krzysztof Kozlowski wrote:
> On 02/11/2022 09:06, Aakarsh Jain wrote:
>> commit "5441e9dafdfc6dc40fa" which adds mfc v7 support for
> Please run scripts/checkpatch.pl and fix reported warnings.
>
>> Exynos3250 and used the same compatible string as used by
>> Exynos5240 but both the IPs are a bit different in terms of
>> IP clock.
>> Lets add variant driver data based on the new compatible string
>> "samsung,exynos3250-mfc" for Exynos3250 SoC.
> Aren't you just missing the clock on Exynos3250?

Nope, the Exynos3250 variant indeed has only one clock and the driver 
code simply ignored the -ENOENT error while getting the clocks, see the 
code in drivers/media/platform/samsung/s5p-mfc/s5p_mfc_pm.c, so it 
worked fine even without it.

IMHO it is a good idea to clean this up.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

