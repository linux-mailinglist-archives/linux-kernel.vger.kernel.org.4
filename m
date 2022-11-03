Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A44617612
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 06:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiKCFSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 01:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiKCFSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 01:18:09 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4077515831
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 22:18:07 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221103051802epoutp04129a240e7ca2410dbb2810760f11b5be~j_2FCoN2a1087910879epoutp04E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 05:18:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221103051802epoutp04129a240e7ca2410dbb2810760f11b5be~j_2FCoN2a1087910879epoutp04E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667452682;
        bh=LhjMGNSBgKGUq/exYmlMgiWLvagJ4e0tY1ifKW+16Ao=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=DttK8QbRuEK6ddknaEavupkSp3OUk5SsActxghgJop3Wl2frTcNjNMJhvlvzL6/zi
         q++7SCqL+I/LbS1J55Kpmji+CaWZ8NlYgogck2IIUcmWLlkWNXDszp+Ar3CV681+ux
         PXMB8huaERrUhSH4y2fJhgu7ZRnZdPqx38LYwsh8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20221103051801epcas5p30db8f64a81a1b127e34bdae5846269c7~j_2EDDF1e1641116411epcas5p3C;
        Thu,  3 Nov 2022 05:18:01 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4N2sTf4C8pz4x9QG; Thu,  3 Nov
        2022 05:17:58 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F9.57.56352.30F43636; Thu,  3 Nov 2022 14:17:55 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221103051754epcas5p21e47e29dc4ea8555dccef940e09070c6~j_1_BEB3p2720027200epcas5p2V;
        Thu,  3 Nov 2022 05:17:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221103051754epsmtrp2eb9625a492eb687b9aa7d6b63c52c031~j_1_AN_B81412114121epsmtrp2T;
        Thu,  3 Nov 2022 05:17:54 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-07-63634f036838
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        ED.DE.14392.20F43636; Thu,  3 Nov 2022 14:17:54 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221103051752epsmtip23e3972e9b2b5c34cf8236ae2be3762ea~j_18YMRey2049720497epsmtip2x;
        Thu,  3 Nov 2022 05:17:52 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Pierre Gondois'" <pierre.gondois@arm.com>,
        <linux-kernel@vger.kernel.org>
Cc:     <Rob.Herring@arm.com>, "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>
In-Reply-To: <20221031091945.531874-1-pierre.gondois@arm.com>
Subject: RE: [PATCH 06/20] arm64: dts: Update cache properties for exynos
Date:   Thu, 3 Nov 2022 10:47:51 +0530
Message-ID: <000001d8ef43$a09b4fd0$e1d1ef70$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI+lpph67DgCBIFu2s2ICNyHohXJQIa2F3OrUwxbwA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmhi6zf3KyQfsKJYv5R86xWvS9eMhs
        senxNVaLy7vmsFnMOL+PyeLBqkyLmy/3MVq07j3C7sDhsWbeGkaPTas62TzuXNvD5rF5Sb3H
        501yAaxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5
        QJcoKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OLS/PS9fJSS6wMDQyM
        TIEKE7IznsxezFzwQLBi23rrBsavfF2MnBwSAiYS2yd2snUxcnEICexmlPh4/DkzhPOJUWL7
        m/nsEM43RolXf+eww7QsfnEfqmovo8Sn321QVS8ZJZ5NPgJWxSagK7FjcRvQYA4OEYFAiQUb
        EkFqmAXeMkpsvdnIBFLDKWAr8fjwHVYQW1jAU2LX3zMsIDaLgIrE282vmEF6eQUsJVYsqAMJ
        8woISpyc+QSshFlAXmL72znMEAcpSPx8uowVYpWVxKNDrhAl4hIvjx4BO01CYC6HxNdXu6Dq
        XSTmn33OBGELS7w6vgXqMSmJz+/2gp0sIeAhseiPFEQ4Q+Lt8vWMELa9xIErc1hASpgFNCXW
        79KHWMUn0fv7CRNEJ69ER5sQRLWqRPO7qywQtrTExO5uVgjbQ2Lf5C7WCYyKs5D8NQvJX7OQ
        PDALYdkCRpZVjJKpBcW56anFpgXGeanl8MhOzs/dxAhOpFreOxgfPfigd4iRiYPxEKMEB7OS
        CG/92ehkId6UxMqq1KL8+KLSnNTiQ4ymwLCeyCwlmpwPTOV5JfGGJpYGJmZmZiaWxmaGSuK8
        i2doJQsJpCeWpGanphakFsH0MXFwSjUwhcukrzv4O2J6ffeGkuUZFxSaXqeIzsi4al2dnvzx
        3Yf/LMtPaNWvPMx0ymnaxa6DKxQt+ANP7wi6JGZz3P3NhdppmxRf37a5Y+d7TkW4eC1bQc2y
        mcVdd8r+Wl2c7j5/nUlq2cNnbQF1c/dvtrkaaV6+hzkoetryGg+5gtuzC+cVbyy/5M0oM/XP
        85ogu25bm90f2YJ1op7o1wevvafp7bgi8smpUP/oBIHbwQeSODNKfA5GmO2Rnpy70UTCZ1XS
        smkXNEMDFP7d23FiW5nvbE22DPYpLAkhX3N4q7tObvHo/q/8X5il/uaFyD9ztByu3Nq8NP9u
        Us3Dxc+9T6/fkfrX71bOVYnC3U5zL59yV2Ipzkg01GIuKk4EAJNrtwotBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkkeLIzCtJLcpLzFFi42LZdlhJXpfJPznZ4PNVeYv5R86xWvS9eMhs
        senxNVaLy7vmsFnMOL+PyeLBqkyLmy/3MVq07j3C7sDhsWbeGkaPTas62TzuXNvD5rF5Sb3H
        501yAaxRXDYpqTmZZalF+nYJXBlPZi9mLnggWLFtvXUD41e+LkZODgkBE4nFL+4zdzFycQgJ
        7GaUWP/sJztEQlri+sYJULawxMp/z9khip4zSux5vogNJMEmoCuxY3EbkM3BISIQKLFgQyJI
        mFngI6PEqcnOEPV9jBIr955iBklwCthKPD58hxXEFhbwlNj19wwLiM0ioCLxdvMrZpA5vAKW
        EisW1IGEeQUEJU7OfMICEmYW0JNo28gIMV5eYvvbOcwQpylI/Hy6jBXiAiuJR4dcIUrEJV4e
        PcI+gVF4FpJBsxAGzUIyaBaSjgWMLKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYJj
        SUtzB+P2VR/0DjEycTAeYpTgYFYS4a0/G50sxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4
        IYH0xJLU7NTUgtQimCwTB6dUA1N+dbGhyLwpavqPrvr8X3KF4ZSIvm7vsZ3Mio5ngj7JcF3+
        aHLSUfCAZfocvbOrI09UTzdQOxOe5pq5tv32na9K6hbHTXcJHA7vnZFWJaia8GVfuF3xu/c3
        prMsPSVlFcTgK17OuWu3YMCNAI7Z+3wm3d/Bfu3RnfmRXwKeb249qbf15+7MpEn8l55pBT7c
        E5ks/miRvPbHE5vafz88cGxXZnnKJs2FX7S2mCxs5jixL4ZfNuPur2OR618+MLZ0VTzGzDLz
        0ecPU74v3lr5Ks3kqLmn/se45ermf9OXu925efSLR+XzZJ+ddx+3V6R461s5rtjyqdao3erZ
        0f9nqphuv1hzadIX77KSy4JR4fpGSizFGYmGWsxFxYkAiEoAuRQDAAA=
X-CMS-MailID: 20221103051754epcas5p21e47e29dc4ea8555dccef940e09070c6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221031091951epcas5p44474924d5427c37186fa2ad6305e0ccf
References: <CGME20221031091951epcas5p44474924d5427c37186fa2ad6305e0ccf@epcas5p4.samsung.com>
        <20221031091945.531874-1-pierre.gondois@arm.com>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre 

>-----Original Message-----
>From: Pierre Gondois [mailto:pierre.gondois@arm.com]
>Sent: Monday, October 31, 2022 2:50 PM
>To: linux-kernel@vger.kernel.org
>Cc: pierre.gondois@arm.com; Rob.Herring@arm.com; Rob Herring
><robh+dt@kernel.org>; Krzysztof Kozlowski
><krzysztof.kozlowski+dt@linaro.org>; Alim Akhtar
><alim.akhtar@samsung.com>; devicetree@vger.kernel.org; linux-arm-
>kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org
>Subject: [PATCH 06/20] arm64: dts: Update cache properties for exynos
>
>The DeviceTree Specification v0.3 specifies that the cache node
'compatible'
>and 'cache-level' properties are 'required'. Cf.
>s3.8 Multi-level and Shared Cache Nodes
>
Not sure if this need to be documented in schema/yaml file as well or
already part of schema?

>The recently added init_of_cache_level() function checks these properties.
>Add them if missing.
>
>Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>---
Changes looks good though.

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

> arch/arm64/boot/dts/exynos/exynos5433.dtsi | 2 ++
> arch/arm64/boot/dts/exynos/exynos7.dtsi    | 1 +
> 2 files changed, 3 insertions(+)
>
>diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>index bd6a354b9cb5..e9eda46801f8 100644
>--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>@@ -229,6 +229,7 @@ cluster_a57_l2: l2-cache0 {
> 			cache-size = <0x200000>;
> 			cache-line-size = <64>;
> 			cache-sets = <2048>;
>+			cache-level = <2>;
> 		};
>
> 		cluster_a53_l2: l2-cache1 {
>@@ -236,6 +237,7 @@ cluster_a53_l2: l2-cache1 {
> 			cache-size = <0x40000>;
> 			cache-line-size = <64>;
> 			cache-sets = <256>;
>+			cache-level = <2>;
> 		};
> 	};
>
>diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi
>b/arch/arm64/boot/dts/exynos/exynos7.dtsi
>index 1cd771c90b47..aca1c32a6411 100644
>--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
>+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
>@@ -110,6 +110,7 @@ atlas_l2: l2-cache0 {
> 			cache-size = <0x200000>;
> 			cache-line-size = <64>;
> 			cache-sets = <2048>;
>+			cache-level = <2>;
> 		};
> 	};
>
>--
>2.25.1


