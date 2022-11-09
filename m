Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0534C623B06
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 05:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbiKJEmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 23:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiKJEmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 23:42:50 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B72B25C61
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 20:42:46 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221110044240epoutp0198b7b8fe2e7f02125afc97aec9e915ae~mH4NFyKwi1280612806epoutp01B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 04:42:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221110044240epoutp0198b7b8fe2e7f02125afc97aec9e915ae~mH4NFyKwi1280612806epoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1668055360;
        bh=0iuTAljZ4MdMyzBRe+jAGF2xaM1v4OcplEZ7HOuz478=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=JUgEMZtkrB4z8zjZXFo0c/18BR6fpACzYpNZedPC8CO1gPsum+PaNIZkMugnrmzEA
         TgpeiYRiAtt6vsfy6A1wCxH9RhbkWkADhBwbtgz7IdIoE+QJbeL/0jGTEKaxv6+V0c
         8g+KAk4Rl5Uuqvhmmy3kiVfAP+rwLHkaiMnX9SQ4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20221110044239epcas5p25b14d6b9ccc336e503ae2781ef045eee~mH4MBEr8A0567805678epcas5p23;
        Thu, 10 Nov 2022 04:42:39 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4N78Mb3CLTz4x9Q9; Thu, 10 Nov
        2022 04:42:35 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F9.6C.01710.B318C636; Thu, 10 Nov 2022 13:42:35 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221109144433epcas5p3f2186f4dfc528612f75ff068a951758e~l8cbGAYIv2781627816epcas5p3V;
        Wed,  9 Nov 2022 14:44:33 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221109144433epsmtrp2b75dce1a4b0995efdf10e6003d867bb1~l8cbEsLdp1757517575epsmtrp2d;
        Wed,  9 Nov 2022 14:44:33 +0000 (GMT)
X-AuditID: b6c32a49-a41ff700000006ae-c5-636c813bc755
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        84.68.18644.0DCBB636; Wed,  9 Nov 2022 23:44:32 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221109144429epsmtip2387935d49e8a485fe7673123bad7cdc6~l8cX3GWr41983819838epsmtip2X;
        Wed,  9 Nov 2022 14:44:29 +0000 (GMT)
From:   "Aakarsh Jain" <aakarsh.jain@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Cc:     <m.szyprowski@samsung.com>, <andrzej.hajda@intel.com>,
        <mchehab@kernel.org>, <hverkuil-cisco@xs4all.nl>,
        <ezequiel@vanguardiasur.com.ar>, <jernej.skrabec@gmail.com>,
        <benjamin.gaignard@collabora.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <stanimir.varbanov@linaro.org>, <dillon.minfei@gmail.com>,
        <david.plowman@raspberrypi.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>, <andi@etezian.org>,
        <alim.akhtar@samsung.com>, <aswani.reddy@samsung.com>,
        <pankaj.dubey@samsung.com>, <smitha.t@samsung.com>
In-Reply-To: <5741e444-00b3-16f6-d012-f2b77cf8b0b2@linaro.org>
Subject: RE: [Patch v2 1/3] arm: exynos: Add new compatible string for
 Exynos3250 SoC.
Date:   Wed, 9 Nov 2022 20:14:28 +0530
Message-ID: <001101d8f449$c78f8010$56ae8030$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH93wRx5mB7au8KVEFSf1YZqxrmqQIInJ4oAoPuhXGtyGyWoA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02TaVBbVRTH5+a95CVo6mOTa6SYvjoqIEuQ4MWytIVpH+oHZopMy9ShmfAk
        DCGJWWqro4ZibUWk6rRKwiaF4kArtSmEpcECZRE6hTIiWEpCSuiwaa3EOlD6wYRHlW+/c87/
        3LPcOXzM7zQh4uep9IxWJVNSPB/cei30xYgdhUp59PWqQOSssvJQ7cocB03XunHUc7mFQM1j
        5Rj6fqCLi6p7h7motXsGR5fmPdFRkx1Hc9VNAC2YHTxUOn8HQ51LngyLa5yLfumo4KGSH1u4
        6IdeO4HOTYxyUL3lEQedbfmbQMc7ewlkt1kB+uTTXs5OSF+ougDoNnsdoCfqljG63Wwn6Frb
        Aoe2NH7Go6fGbTz6ct3H9PG+hzhd2twI6OLeCR7ttoTQQw/cRLowKz9BwchyGK2YUcnVOXmq
        3ETqjX3ZKdnSuGhJhCQevUqJVbICJpFKfTM9Yk+e0rMCSnxYpjR4XOkynY6KSkrQqg16RqxQ
        6/SJFKPJUWpiNZE6WYHOoMqNVDH61yTR0TFSj/BQvuL8rQmgqQg6Ypy3YEYw5l8M+HxIxsKW
        svxi4MP3I68AaLvhwlljGcDV1eUNww1gU7kLFAPBesbY8AzhZT+yA8CqvrdZ0RyAN+8Vrot4
        ZBScHirhegMBZB+AzuY7mNfAyGocjh+7z/MWF5BJ0OhO9qI/uR+WrD3tRZx8Hj4a9vE+IyTj
        oWOyicuyLxw0zeJexshwWF+zhLH9iOHq3fp1TQC5Gx5rXyNYTRDsWy3Z0AwJ4NIsYjkVVjrb
        uCz7w8WBZoJlEXTf6+SxLIeuswsbuUp40XYaZzkZdo1V4N42MTIUXuyIYt1b4ZmhJg5bdgv8
        Ym2Ww/qFsK3qMb8AK6ZWNsoGw2vnz4EvAWXeNJl502TmTROY/6/2HcAbwTOMRleQy+ikGomK
        ee+/35arCyxg/TzC0tqA3Xk/sgdw+KAHQD5GBQifeClf7ifMkR19n9Gqs7UGJaPrAVLPtr/C
        RIFytee+VPpsSWx8dGxcXFxs/CtxEipIWFsWJvcjc2V6Jp9hNIz2cR6HLxAZOU0PZaceTNu2
        mYq0qG7fYGt3ZgB1OLv5z5+NQ1YfZ9mem5HhDaaQ/m9PfZD2+d6qwqSJW8/6xyhv12Qq/kgJ
        cQb3E+JE48iHJ98pnS66DWNCfwroDiN3DQZd5+3cflCQqljcMTtgC6+ZOeGKPvCP4SnXcw57
        +zS/sjb5dzeqmw9K23/yRnuGNMU0YNo64kgZPdBl+K2/bvuVSr7ApXWVdaRwJ79ejLprPEFz
        ieKxt8oydid8VP/r3BaNz2rXkP/Rv7JEUZIiSUarLWkqeIpKDRFZ91pf3zZydVHaRvtmSd59
        UqpoKBf5XsKXD5Zc7Zr8ZteRxAZyxXEmM7BjOGLFcehlC4XrFDJJGKbVyf4FDEmUYacEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsWy7bCSvO6FPdnJBlu2mVo8mLeNzWLxj+dM
        FvcXf2axOLR5K7vFliuzmS2WHz/AajH/yDlWi+0HH7FYbHwBlL048y6LxfP56xgtXs66x2bR
        9+Ihs8Xe10Admx5fY7W4vGsOm0XPhq2sFmuP3GW3WHr9IpPFsk1/mCwWbf3CbtG69wi7xd09
        2xgtWtqOMDlIeKyZt4bRY8fdJYwe15d8YvbYOesuu8fiPS+ZPDat6mTzuHNtD5vH5iX1Hq1H
        f7F49G1ZxejRdeQ6m8fnTXIep75+Zg/gjeKySUnNySxLLdK3S+DKWP/gGFvBFbGK6atlGhg7
        hLsYOTkkBEwkrpx7xN7FyMUhJLCDUeLigRWsEAkZif9tx9ghbGGJlf+eQxU9ZZRY93c+C0iC
        TUBf4v6pHlaQhIjASUaJ/jMtYA6zwGYWibWte1ggWg4ySpw/tZ6xi5GDg1PATqLhsz1It7BA
        mMSzn91gYRYBFYk/57hAwrwClhL3bq1jhbAFJU7OfAK2jFlAW+Lpzadw9rKFr5khrlOQ+Pl0
        GVi9iICTRNPO3+wQNeISR3/2ME9gFJ6FZNQsJKNmIRk1C0nLAkaWVYySqQXFuem5xYYFRnmp
        5XrFibnFpXnpesn5uZsYwWlES2sH455VH/QOMTJxMB5ilOBgVhLh5dbIThbiTUmsrEotyo8v
        Ks1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qBybrzj+yBnwmFmssCP156YMx8
        1rPKt9i+LCNbm7v70syGD9dXqu1YPnNrA+v5Lxy6xdcLPz72OdjeeUZg+pI8lYYPmQ8uu9V3
        M7XPLJ0vK1Yiwy+SwNW1d/vbRgae+TdVXbdOSUqL2z2N8/iFqrSYw3z+Ty7tCyqP95NOYz24
        fH3M3oboP+taXurGqUd99z7pZj3hrVNVwQpFxe2rAm/wPmgS/6jLL5b8deWJj1aKb1s+6KU4
        TJ+5v/h3QUB3LKNgyNtttY/P1WUXfmd4p7xng7lWv/s5L7GOTwvPzfuyvbPU+yX/3QaJ9pen
        K7jnlQTs3Md82NFJ55Z3REVFacKuybxLTFgObti/1DrtJf8OJZbijERDLeai4kQAhMsipZID
        AAA=
X-CMS-MailID: 20221109144433epcas5p3f2186f4dfc528612f75ff068a951758e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221109034803epcas5p26644fa402ff1837754b61c1a307b2bb8
References: <CGME20221109034803epcas5p26644fa402ff1837754b61c1a307b2bb8@epcas5p2.samsung.com>
        <20221109035507.69086-1-aakarsh.jain@samsung.com>
        <5741e444-00b3-16f6-d012-f2b77cf8b0b2@linaro.org>
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
> Sent: 09 November 2022 14:31
> To: Aakarsh Jain <aakarsh.jain=40samsung.com>; linux-arm-
> kernel=40lists.infradead.org; linux-media=40vger.kernel.org; linux-
> kernel=40vger.kernel.org; devicetree=40vger.kernel.org
> Cc: m.szyprowski=40samsung.com; andrzej.hajda=40intel.com;
> mchehab=40kernel.org; hverkuil-cisco=40xs4all.nl;
> ezequiel=40vanguardiasur.com.ar; jernej.skrabec=40gmail.com;
> benjamin.gaignard=40collabora.com; krzysztof.kozlowski+dt=40linaro.org;
> stanimir.varbanov=40linaro.org; dillon.minfei=40gmail.com;
> david.plowman=40raspberrypi.com; mark.rutland=40arm.com;
> robh+dt=40kernel.org; krzk+dt=40kernel.org; andi=40etezian.org;
> alim.akhtar=40samsung.com; aswani.reddy=40samsung.com;
> pankaj.dubey=40samsung.com; smitha.t=40samsung.com
> Subject: Re: =5BPatch v2 1/3=5D arm: exynos: Add new compatible string fo=
r
> Exynos3250 SoC.
>=20
> On 09/11/2022 04:55, Aakarsh Jain wrote:
> > Since,MFC v7 support was added for Exynos5420 and Exynos
> > 3250 SoC with same compatible string =22samsung,mfc-v7=22.As both SoCs
> > having different hardware properties and having same compatible string
> > for both SoCs doesn't seems to be correct.
> > New compatible is added for Exynos3250 SOC which will differentiate
> > the node properties for both SoCs which support MFC v7.
> >
> > Reviewed-by: Tommaso Merciai
> <tommaso.merciai=40amarulasolutions.com>
> > Suggested-by: Alim Akhtar <alim.akhtar=40samsung.com>
> > Signed-off-by: Aakarsh Jain <aakarsh.jain=40samsung.com>
> > ---
> >  Documentation/devicetree/bindings/media/s5p-mfc.txt =7C 9 +++++----
>=20
> Use subject prefixes matching the subsystem (git log --oneline -- ...).
>=20
As with recent commits on Documentation/devicetree/bindings/media/s5p-mfc.t=
xt with git log --oneline --  ,  subject prefix doesn't seems to be consist=
ent.

b1394dc151cb media: s5p-mfc: Adding initial support for MFC v10.10
60641e22599a =5Bmedia=5D s5p-mfc: Use preallocated block allocator always f=
or MFC v6+
003611334d55 =5Bmedia=5D s5p-mfc: Add support for MFC v8 available in Exyno=
s 5433 SoCs
0da658704136 ARM: dts: convert to generic power domain bindings for exynos =
DT
77634289286a ARM: dts: Update clocks entry in MFC binding documentation
2eae613b95a7 ARM: EXYNOS: Add MFC device tree support

Closest is ARM: dts.
so what is your suggestion on this?

Anyway we are in a process of converting this txt file to yaml .=20


> This is a friendly reminder during the review process.
>=20
> It seems my previous comments were not fully addressed. Maybe my
> feedback got lost between the quotes, maybe you just forgot to apply it.
> Please go back to the previous discussion and either implement all reques=
ted
> changes or keep discussing them.
>=20
> Thank you.
>=20
> Best regards,
> Krzysztof

Thanks for the review.

