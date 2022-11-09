Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2176222ED
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 05:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiKIEDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 23:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiKIEDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 23:03:09 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090301B1E3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 20:03:06 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221109040303epoutp04e9892150a4a378ad4a310f9152d8cba0~lzsVYVuN41521115211epoutp04e
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 04:03:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221109040303epoutp04e9892150a4a378ad4a310f9152d8cba0~lzsVYVuN41521115211epoutp04e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667966584;
        bh=75q32kFTDh2aoj/8HQFaNz0fPSzCYF1eqAVoDbM2G84=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=AVEG4PQnT+CXcbXFbokINqX6THjzwCE7Wtb3BdLHohOMqq+8WcPgnwesie8kTVW1y
         ftyQxm+eBU0qh8ResqaLiy1geHu96x8mFoQvf+UeewyRkEXn0VLilUvaJe7fRI/kgj
         YdgqK+jz5CeHuY/UWpxP5aM6+1sIBdsFfyrgDKd8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20221109040303epcas5p2f016ec83d9fd38c123b29249e20ef1bd~lzsUrlKfm1854418544epcas5p2t;
        Wed,  9 Nov 2022 04:03:03 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4N6WXN18bfz4x9Pp; Wed,  9 Nov
        2022 04:03:00 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6A.9E.56352.2762B636; Wed,  9 Nov 2022 13:02:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20221109040230epcas5p16dc551db7e4bdfc5be2cd98f92495ce4~lzr2NDEHC0091200912epcas5p10;
        Wed,  9 Nov 2022 04:02:30 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221109040230epsmtrp18b767ddd02fb2c2ccde9f85b34c29799~lzr2LG-Vw2044620446epsmtrp1u;
        Wed,  9 Nov 2022 04:02:30 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-ae-636b26729ccc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A1.E9.18644.6562B636; Wed,  9 Nov 2022 13:02:30 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221109040227epsmtip234d540bed7147343ec2d4e8107f589a3~lzrzAjXxq2646526465epsmtip2i;
        Wed,  9 Nov 2022 04:02:26 +0000 (GMT)
From:   "Aakarsh Jain" <aakarsh.jain@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Marek Szyprowski'" <m.szyprowski@samsung.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Cc:     <andrzej.hajda@intel.com>, <mchehab@kernel.org>,
        <hverkuil-cisco@xs4all.nl>, <ezequiel@vanguardiasur.com.ar>,
        <jernej.skrabec@gmail.com>, <benjamin.gaignard@collabora.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <stanimir.varbanov@linaro.org>, <dillon.minfei@gmail.com>,
        <david.plowman@raspberrypi.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>, <andi@etezian.org>,
        <alim.akhtar@samsung.com>, <aswani.reddy@samsung.com>,
        <pankaj.dubey@samsung.com>, <smitha.t@samsung.com>
In-Reply-To: <f4ca26c6-6c03-b7e7-3d5e-f6bc42c3a785@linaro.org>
Subject: RE: [PATCH 2/3] media: s5p-mfc:Add variant data for MFC v7 hardware
 for Exynos 3250 SOC
Date:   Wed, 9 Nov 2022 09:32:25 +0530
Message-ID: <000001d8f3f0$165e5090$431af1b0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIVsoyS1LfNYjvTRsU3iIkRJvur6ALOAibeAe9RDWYBPCmjzAG0npdKAqjgM0StacB8gA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUxbVRjGc3pvewtJ3V3B7dBNrTe4OJSPSmkvDtiMG96ICkqUuaisa68t
        UNqmLQoatxFlCQQZSzBulTG+p1BgK5/rKBmlOEAhMBrQuW4IQ9otQwYy+XBgaYvy3+99z/uc
        5zzn5LARrgHjsdNUelqrkigJlj/a1rP3+VDtngxpxFKPmJwoa2ORVUszDPJO1QJKWptbMbLF
        /h1CXrx+jUlesA0xyfbuSZS87HSvjpxzoOTMhUZAugy3WWSR83eEtNx3K0xTY0xy1FzKIgsv
        tTLJBpsDI2vGRxhkrekfBlnZ+hdG5llsGOnobAPkV6dsjAOQMpYZAdXhqAbUePU8Ql0xODCq
        qtPFoEx1+Szq1lgni2quPkHl9a6gVFFLHaAKbOMsasH0NDWwuIAlcY5kxChoiYzW8mmVVC1L
        U8ljiYTk1FdTo0QRglBBNCkm+CpJJh1LHHwjKTQ+Tem+AoL/iUSZ5W4lSXQ6IjwuRqvO0tN8
        hVqnjyVojUypEWrCdJJMXZZKHqai9S8LIiJeinIPHs1QTBlXUM0kN7u8+zF6EuThBcCPDXEh
        rOz9AykA/mwufhXAv69MMb3FPIDteROYt1gA8IZ1hbkpGcz9wbdgBnB2PA94ixkAhxsrsI0p
        Fh4O7wwUevYKxJcAXCsp9UgQPBeFN+1dyMaUHx4Hp+bXWBscgB+D5Q2jHg8UD4arp+s9fQ4e
        DVfXzgMvb4f95+6iG4zgL8DaivuI90x8uDxd69EG4u/BstkGzDuzE/YuF3riQXzID37fX+gL
        cRA6bM0MLwfAe9dbMC/zoOv0KR9L4VSly2eghE2dJaiX98Nr9lI3s90Ge2GTOdzbfgp+M9DI
        8Po+Ab9evevbngM7yjZ5Dyy9teQ7wm7YU18DigFh2BLNsCWaYUsEw/9u5QCtA0G0Rpcpp3VR
        mkgV/el/by5VZ5qA55OEJHSAyYm5MCtgsIEVQDZCBHKMjelSLkcmyfmM1qpTtVlKWmcFUe77
        PoPwnpSq3b9MpU8VCKMjhCKRSBgdKRIQOzlVZ0OkXFwu0dMZNK2htZs6BtuPd5LhF3hI3xY7
        3xrz0aOzr5wwHeEqjD3bhemqHfbpX/cZi96vFeU3dLf7v4bQzj/Nz3URmodzQe8Ml37p/Nl+
        gLct4V7u65/7czCFUZ7PKY6cTV9xlrPtqvWaxl/qHvAt+zBu3XJUOLmY0ldxPH7M+u6PCV+o
        pnli7rNhXW8ydpjtzgrLB+0ticSxjMP9FR9qRnVXU2YD1i27Dg+fKXd0pAXNPNC3yMd7Hs1F
        xpsuhuzOGQxI5rz1rfjjwN9cmTmi5J+eaRiZ69PKi41NAfVxNwezE4P3Tw+JF9DF4LePmrc1
        9Vl2yc93qbPRQ9tLZA8fS6SXim/rb6wnXk7hvyhLYAwdd4kJVKeQCEIQrU7yLwc3oBOtBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsWy7bCSvG6YWnaywaI+YYsH87axWSz+8ZzJ
        4v7izywWhzZvZbfYcmU2s8Xy4wdYLeYfOcdqsf3gIxaLjS+Ashdn3mWxeD5/HaPFy1n32Cz6
        Xjxkttj7Gqhj0+NrrBaXd81hs+jZsJXVYu2Ru+wWS69fZLJYtukPk8WirV/YLVr3HmG3uLtn
        G6NFS9sRJgcJjzXz1jB67Li7hNHj+pJPzB47Z91l91i85yWTx6ZVnWwed67tYfPYvKTeo/Xo
        LxaPvi2rGD26jlxn8/i8Sc7j1NfP7AG8UVw2Kak5mWWpRfp2CVwZK86FFywXqrh43rSB8Qh/
        FyMnh4SAicTZxpXsXYxcHEICOxgl+va1MEMkZCT+tx1jh7CFJVb+ew5mCwk8ZZSY9ZkTxGYT
        0Je4f6qHFaRZROAPo8S6TVfZQBxmgaksEmf+LIQae4NJYvvDVywgLZwCdhKPP/0DquLgEBZI
        kNjeFwESZhFQkfjdv5oNxOYVsJT4/W8uI4QtKHFy5hOwVmYBbYmnN5/C2csWvoa6VEHi59Nl
        rCC2iECYxLx3a9khasQljv7sYZ7AKDwLyahZSEbNQjJqFpKWBYwsqxglUwuKc9Nziw0LjPJS
        y/WKE3OLS/PS9ZLzczcxgpOIltYOxj2rPugdYmTiYDzEKMHBrCTCu2ZdVrIQb0piZVVqUX58
        UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTE7PPsrWG8t8Xry52+zq4csV
        KtXdW29J9QStkgg4Y1+1b8m8zsMLPnrbBD+PfPNUwu2Bu9a/R0r8L6ZM36Z0k+3KXSHG6flZ
        ckve33wcues1/2WZ06fr9oroq970KWbdumXXK8MZXLGRHyKmFYsLiqes3yvz+Ekge5h3wvaM
        4DiNqU9XZLXE/2MSUbe+Z541fQ9v+kqtTSdrFESKq/Qz2YymBv9funiC4bL7d3rXrHPYfGWN
        /k31vytaLY+evNp5/Jjvtc7vH49cTTomEyJypXNtZ8Mf6/dCfxMzYoUfxxk96JGNjDZf8LpQ
        TWmCUHy+Tun8JTu3dyzfe9uj7MuD5D5zqe4pW392hf5TKLL/uF+JpTgj0VCLuag4EQBoGeFf
        kQMAAA==
X-CMS-MailID: 20221109040230epcas5p16dc551db7e4bdfc5be2cd98f92495ce4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221102125813epcas5p40a38f17a267276ff8b2bc5861b5d450d
References: <20221102130602.48969-1-aakarsh.jain@samsung.com>
        <CGME20221102125813epcas5p40a38f17a267276ff8b2bc5861b5d450d@epcas5p4.samsung.com>
        <20221102130602.48969-2-aakarsh.jain@samsung.com>
        <c55d29d2-a70a-f2ae-b605-1c63051202bf@linaro.org>
        <aadbb452-506d-89cc-28d9-497369c0018e@samsung.com>
        <f4ca26c6-6c03-b7e7-3d5e-f6bc42c3a785@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski =5Bmailto:krzysztof.kozlowski=40linaro.org=5D
> Sent: 03 November 2022 18:16
> To: Marek Szyprowski <m.szyprowski=40samsung.com>; Aakarsh Jain
> <aakarsh.jain=40samsung.com>; linux-arm-kernel=40lists.infradead.org; lin=
ux-
> media=40vger.kernel.org; linux-kernel=40vger.kernel.org;
> devicetree=40vger.kernel.org
> Cc: andrzej.hajda=40intel.com; mchehab=40kernel.org; hverkuil-cisco=40xs4=
all.nl;
> ezequiel=40vanguardiasur.com.ar; jernej.skrabec=40gmail.com;
> benjamin.gaignard=40collabora.com; krzysztof.kozlowski+dt=40linaro.org;
> stanimir.varbanov=40linaro.org; dillon.minfei=40gmail.com;
> david.plowman=40raspberrypi.com; mark.rutland=40arm.com;
> robh+dt=40kernel.org; krzk+dt=40kernel.org; andi=40etezian.org;
> alim.akhtar=40samsung.com; aswani.reddy=40samsung.com;
> pankaj.dubey=40samsung.com; smitha.t=40samsung.com
> Subject: Re: =5BPATCH 2/3=5D media: s5p-mfc:Add variant data for MFC v7
> hardware for Exynos 3250 SOC
>=20
> On 03/11/2022 08:44, Marek Szyprowski wrote:
> > On 03.11.2022 13:35, Krzysztof Kozlowski wrote:
> >> On 02/11/2022 09:06, Aakarsh Jain wrote:
> >>> commit =225441e9dafdfc6dc40fa=22 which adds mfc v7 support for
> >> Please run scripts/checkpatch.pl and fix reported warnings.
> >>
As I didn't see any checkpatch warnings from the above commit message.
Anyway I fixed all checkpatch warnings from drivers/media/platform/samsung/=
s5p-mfc/s5p_mfc.c and posted 3 patches for the same.
https://patchwork.kernel.org/project/linux-media/patch/20221109035348.69026=
-1-aakarsh.jain=40samsung.com/

> >>> Exynos3250 and used the same compatible string as used by
> >>> Exynos5240 but both the IPs are a bit different in terms of IP
> >>> clock.
> >>> Lets add variant driver data based on the new compatible string
> >>> =22samsung,exynos3250-mfc=22 for Exynos3250 SoC.
> >> Aren't you just missing the clock on Exynos3250?
> >
> > Nope, the Exynos3250 variant indeed has only one clock and the driver
> > code simply ignored the -ENOENT error while getting the clocks, see
> > the code in drivers/media/platform/samsung/s5p-mfc/s5p_mfc_pm.c, so it
> > worked fine even without it.
> >
> > IMHO it is a good idea to clean this up.
>=20
> OK, then please make the new compatible followed by old.
>=20
> Best regards,
> Krzysztof


Thanks for the review.

