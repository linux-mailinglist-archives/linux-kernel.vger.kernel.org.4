Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB6B62759E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 06:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbiKNFok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 00:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbiKNFog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 00:44:36 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523CE167E1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 21:44:34 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221114054431epoutp0265475b0851c71e05c1c49c034417adaa~nXTWki5Bt0438204382epoutp02q
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 05:44:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221114054431epoutp0265475b0851c71e05c1c49c034417adaa~nXTWki5Bt0438204382epoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1668404671;
        bh=lAxATCQAulvIqfJHs/O2bkzkAPOq2wlzgtGdQecwgzM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=WThHOmSjjOspdK8+aCvEyaZUvkL/OesWh/b9/4x62rKsZDpHOCR54FYBrCgFKjdgw
         K0xCkkMT0WgvjmpOFE6Q44B6thF1xWrUYFy6aDuCfTAn+BJtBPvWEA8jsVZ/yk22RS
         DK5+szeeSQIT1M0HrSuUVl8PRDAfd6Z/JYCpGVHs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221114054430epcas5p4f3ec88c44c29a94f8b04e8a920cc2ce6~nXTVnROHP2353323533epcas5p42;
        Mon, 14 Nov 2022 05:44:30 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4N9dY75bFqz4x9Ps; Mon, 14 Nov
        2022 05:44:27 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3B.00.39477.6B5D1736; Mon, 14 Nov 2022 14:44:22 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221114054040epcas5p2fe1bca3fbef7f4addb5906a03f397e4e~nXP_31OsK2399723997epcas5p2J;
        Mon, 14 Nov 2022 05:40:40 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221114054040epsmtrp1c6e5ff3f4119c7e18d7942c6dc6972a8~nXP_2SjRM1353813538epsmtrp1o;
        Mon, 14 Nov 2022 05:40:40 +0000 (GMT)
X-AuditID: b6c32a4a-007ff70000019a35-bf-6371d5b6a148
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7A.CA.14392.8D4D1736; Mon, 14 Nov 2022 14:40:40 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20221114054036epsmtip21034c2d63e5f20684a979dc6784b84f4~nXP7Zsn6V2101621016epsmtip2Z;
        Mon, 14 Nov 2022 05:40:36 +0000 (GMT)
From:   Aakarsh Jain <aakarsh.jain@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, krzysztof.kozlowski+dt@linaro.org,
        stanimir.varbanov@linaro.org, dillon.minfei@gmail.com,
        david.plowman@raspberrypi.com, mark.rutland@arm.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, andi@etezian.org,
        alim.akhtar@samsung.com, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com, smitha.t@samsung.com,
        aakarsh.jain@samsung.com
Subject: [Patch v4 0/3] Add new compatible for Exynos3250
Date:   Mon, 14 Nov 2022 11:16:52 +0530
Message-Id: <20221114054655.68090-1-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTfUxTVxjGPff2C7KaKx/xQFCwkU2IQOtaOBBwRlGu25KxYPbHNuxquSuE
        0nb9wG2uAsYyYQq4uanA6GL5ElSwQAUtBLGsGQEZ0YGZLdgVU7pkQ4ExYLit5cL23+887/Pk
        ffOeczh40AgrnJOn0FJqhUTOYwUyLPdiYuIsP30k5RurUtHT7stM9KTOwkKmJQ+GpkzzDDTQ
        0cVGnQ9rcNRk72cio+0+E926+wsD3ZzxVccuOxnIY7wBkLd6koUqZlw4MrvHmejB7VoWOtve
        xUTXbU42apgYw1CjeRVDV7oW2MjQa2Mjp9UC0OlSG7YPktfqrgGy21kPyIn6OZzsqXaySZPV
        i5HmljIW6Ri3ssiO+iLSMLjCICs6WwBZbptgkfPm7eTQH/PsTO67+am5lCSHUkdRCqkyJ08h
        S+O9kSU+IBYl8gVxgmSUxItSSAqoNF76m5lxh/LkvhXwogolcp1PypRoNLyEvalqpU5LReUq
        Ndo0HqXKkauEqniNpECjU8jiFZQ2RcDn7xH5jB/k59753o6pRrkf93V1g2IwGVgOAjiQEMLi
        8R+Yfg4i7gBYNsuneQ5Aa28KzYsAtj3K2PAvui+xy0GgT+8FcP7PViZ9MGBwrrcHKwccDouI
        gyO35P5ACFECoPuM1u/BifMM+LhiBvcXgolkWDtbgfmZQUTDzhrjms4l0uDU7Cqb7hYJW9v7
        cX8YEtMcWDPqxulCOnw08g+T5mD4q71zPRAOvZWl6yyF7ivedb8ctlkvMGh+DfY/rGX4B8WJ
        GNh2O4GWt8Gvh26szYMTm+G5v6YxWufC7roNfhnWOpbW20bAe60NgGYSfnnazaC3lQ2fGQx4
        FdhW/X+H7wBoAWGUSlMgozQi1R4Fdfy/a5IqC8xg7V3Hvt4NXE+exQ8AjAMGAOTgvBBuXYRS
        GsTNkXzyKaVWitU6OaUZACLfzs7j4aFSpe9jKLRigTCZL0xMTBQmv5oo4G3lmi7FSoMImURL
        5VOUilJv5DBOQHgxJog4GLGQs6l49GpI1lcrniOFU0ni7Tv0+4pGQ10tGfkZCezI9Av7G8Mc
        dwWmH4NPMQ/Zd6Ys6xdSd7Wjp9IqU3OzK7ry95PLIcP9lkNdHw7LTrg8WtFq9CuFHqNb6Y0N
        eN9s2fLWkaQtBoXt4PPP3+sp222RCZsf7zSbm0Je2nH/hdgu2tTQN/JOo+OEtcmTyz5WXMmJ
        21/xWWxmYZKTE9H+Qlayq6/xQCQre+upjp8P/51lH2LfFB1tOfzb0S+WHPhF/ZkOx+SDGuOw
        R+cquaq3iZybi7wrIsNxfEE/H37xJBwbDJ02DuvPfft26bFvri+HVZ7lLezeK158nt00AXWD
        PIYmVyKIxdUayb8NWHn7YAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsWy7bCSvO6NK4XJBluX8Vg83TGT1eLBvG1s
        Fot/PGeyuL/4M4vFoc1b2S22XJnNbLH8+AFWi/lHzrFabD/4iMVi4wug7MWZd1ksns9fx2jx
        ctY9Nou+Fw+ZLTY9vsZqcXnXHDaLng1bWS3WHrnLbrH0+kUmi2Wb/jBZLNr6hd2ide8Rdou7
        e7YxWrS0HWFykPBYM28No8eOu0sYPa4v+cTssXPWXXaPxXteMnlsWtXJ5nHn2h42j81L6j1a
        j/5i8ejbsorRo+vIdTaPz5vkPE59/cwewBvFZZOSmpNZllqkb5fAlbH72HGmgvO8Ffu27mBs
        YLzH1cXIySEhYCLx7fEM9i5GLg4hgd2MEtuWXGOESMhI/G87xg5hC0us/PccqqiZSaJ9aj+Q
        w8HBJqArcXZ7DkhcRKCVUeL6yk4mEIdZYCWLxO2NPUwg3cIClhJz3veB2SwCqhJbZs9nBrF5
        BWwl7r//A7VBXmL1hgPMExh5FjAyrGKUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECI4g
        Lc0djNtXfdA7xMjEwXiIUYKDWUmEd55MfrIQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OF
        BNITS1KzU1MLUotgskwcnFINTEfWrrtbxe8wK0HS+9Rn9/DSf1pXks5wp3U4uKQkb+RfyPNM
        /cq71291OW+y1HZ36NRMfW9zS8VOSV2jQEn7ZItQybmsJRr/BVsnrwp78MXt6YfzjF/Ofphu
        LbQzZOb0Zt1E/vqlSnIXtXR3aP1dHdI2Z3GT3XXrbwbeW6o6r2xsT6wx1goxDi14ZsAQ8z+6
        5lWE+x8FeaGMg/fUnl11d2GarizanePAZ5lhL9fCeM3lHuvKrcoL9meuafq419+NW/Oh0O13
        fzgZ5qqV/px0Ys6iqo64fdrqqnMYz6yqffsofZ+gvMOdVd8/fGLK+NDI8j1kIdfUWeGSL4NZ
        juVNzSrWK+hd8+HJuZ4iL2sxJZbijERDLeai4kQA2dDXag8DAAA=
X-CMS-MailID: 20221114054040epcas5p2fe1bca3fbef7f4addb5906a03f397e4e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221114054040epcas5p2fe1bca3fbef7f4addb5906a03f397e4e
References: <CGME20221114054040epcas5p2fe1bca3fbef7f4addb5906a03f397e4e@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since MFC v7 support was added for Exynos5420 and Exynos3250
SoC with same compatible string "samsung,mfc-v7". As both SoCs
having different hardware properties and having same compatible
string for both SoCs doesn't seems to be correct.
Add a new compatible to differentiate the two SoC's MFC IP,
at the same time to keep git bisect happy, add a fallback to mfc-v7
for Exynos3250.

Changes since v3:
 - Addressed review comments from Krzysztof Kozlowski.
   - Added new compatible string for Exynos3250 followed by mfc-v7 fallback.

Changes since v2:
 - Addressed review comments from Krzysztof Kozlowski.
   - Changed subject prefixes matching the subsystem.

Changes since v1:
 - Addressed review comments from Marek Szyprowski.
   - Changed subject prefix from arm64 to arm.

 - Addressed review comments from Krzysztof Kozlowski.
   - Changed subject prefixes matching the subsystem.
   - Added new compatible string for Exynos3250 followed by mfc-v7 fallback.
   - Removed checkpatch warnings from s5p_mfc.c.Sent separate patch
     series for the same.
   
 - Addressed review comments from Tommaso Merciai.
   - Change in commit message body from used to use in Patch-2.

Aakarsh Jain (3):
  media: dt-bindings: s5p-mfc: Add new compatible string for Exynos3250
    SoC
  media: s5p-mfc: Add variant data for MFC v7 hardware for Exynos 3250
    SoC
  ARM: dts: exynos: Add new SoC specific compatible string for
    Exynos3250 SoC

 .../devicetree/bindings/media/s5p-mfc.txt       | 10 ++++++----
 arch/arm/boot/dts/exynos3250.dtsi               |  2 +-
 .../media/platform/samsung/s5p-mfc/s5p_mfc.c    | 17 +++++++++++++++--
 3 files changed, 22 insertions(+), 7 deletions(-)

-- 
2.17.1

