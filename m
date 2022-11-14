Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B8A62910A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 05:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237670AbiKOEBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 23:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbiKOEBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 23:01:32 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5FC15FDE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 20:01:30 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221115040128epoutp01fb0c8c4fc2e562e383650803c0c587eb~npiqRA93w2094820948epoutp01g
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:01:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221115040128epoutp01fb0c8c4fc2e562e383650803c0c587eb~npiqRA93w2094820948epoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1668484888;
        bh=tLxH/oSbN4ttWhYedYhc0ui5x2yb6SohQZ11AMUJCvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bUMkZ1ubFkkMNhORoeaZCx5sgCFcVsQmpxz1d8xxy4/hFZ/0hjrrI5BAbnbTgMK3f
         Tp+Gi0cp7+aqiP67J9zE3opH7TpokZLdRG3aa5jKO/3cg2L6dLj+G49hdL4iUlMMEt
         BM/8BDgOFbx8lMmJ1C4SmCQfWALr6QAC3dIZSVGM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221115040127epcas5p419d029e877d5109e154d2f52102fb3da~npipUHNKA1030510305epcas5p4a;
        Tue, 15 Nov 2022 04:01:27 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4NBCCn6thMz4x9Q3; Tue, 15 Nov
        2022 04:01:25 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        71.A0.39477.51F03736; Tue, 15 Nov 2022 13:01:25 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221114114409epcas5p32057f807dd538f874f8fd4a940c9de00~ncNWRC9St2923329233epcas5p3u;
        Mon, 14 Nov 2022 11:44:09 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221114114409epsmtrp184711f2642d3142513c0017d9aab5cd2~ncNWP1IYX0315803158epsmtrp1M;
        Mon, 14 Nov 2022 11:44:09 +0000 (GMT)
X-AuditID: b6c32a4a-007ff70000019a35-cb-63730f155a0f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        66.71.18644.90A22736; Mon, 14 Nov 2022 20:44:09 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20221114114406epsmtip2c6b27252ae24b80d4ee2ec90a03e4e2b~ncNTHWzGc1105511055epsmtip2U;
        Mon, 14 Nov 2022 11:44:06 +0000 (GMT)
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
Subject: [Patch v5 2/3] media: s5p-mfc: Add variant data for MFC v7 hardware
 for Exynos 3250 SoC
Date:   Mon, 14 Nov 2022 17:20:23 +0530
Message-Id: <20221114115024.69591-3-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221114115024.69591-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTa1AbVRSeu7vZLGjoDhS4UkoxIx3AARIgcSlPlalbHzMgan2MxpAsz7wm
        Gyq0TMUOoCQtgtJRIg3Y0DJDkSLvAu0ADW1lpA4DAlKiLdg26aggKRahY01I0H/fOef7zjn3
        u/cSqO88HkTkq3SMViVV8HFvrPdyRHiU/w5WJpiziajb/fUc6qapF6fM63cR6hezA6NGu3q4
        VPf0VyjVcnWYQzVarnOovpFFjPrW5qxO1lsx6m5jO6Dsxp9xqtp2C6U6l2Y41NRAA04d7+jh
        UN9YrFzqzOwkQp3tfIhQp3vuc6mKixYuZR3qBVR5pQVJg3SbqQ3Q/dZmQM82r6L0BaOVS5uH
        7Ajd2VqF0wszQzjd1fwhXTG2gdHV3a2A1ltmcdrRGUKPrzm4Gby3C5PyGKmc0YYyKplanq/K
        Tea/lCV5XiISC4RRwgTqGX6oSqpkkvnpL2dE7c9XOC3ghx6SKoqcqQwpy/JjUpK06iIdE5qn
        ZnXJfEYjV2jiNdGsVMkWqXKjVYxun1AgiBU5ie8X5lUZD2gWfYorHCc4ZeD443rgRUAyHs7/
        No/qgTfhSw4COD1TjbuDVQAt+muewAFg2XI7ti3Rrw1wXdiXHADwuwtpblIFAlc2W50KgsDJ
        KDjRp3BxdpIfAbj0ic7FQclaDN6otqGugh+ZDRfq/gAuPkaGweY1xJXmkcnQ/NMI4p61B57r
        GN6ie5EpcGJkBXP1geQ6AY1fVHLcpHTYZtnwCPzgvavdXDcOgvZPKz1YBpdO21E3VsDzQ3We
        w6TC4ekGzLUDSkbA8wMx7vRueHK8faslSvrAE5u/etrzYL9pG++FDQvrnhWC4eVzZ4Ab09Aw
        Z/ZYWgtg/VojXgNCjP+PaAKgFTzBaFhlLsOKNLEq5oP/7kymVnaCrUce+WI/uHVzJXoUIAQY
        BZBA+Tt5pmC1zJcnl5YcZrRqibZIwbCjQOT0rxYN8pepnb9EpZMI4xME8WKxOD4hTizkB/LM
        X0bKfMlcqY4pZBgNo93WIYRXUBmijlsXlB7NkbABe4LnehBFVilhSLVdMnYr9PKTE5NQvazt
        W20KzDKIeYMTkouvBoxNHZMlDO0ShwJl2Pf1ZHjMKps5a8pJ20z0k8R5R210nZq4dPjpR3tP
        oR9fIR67/ZkpwKh9LuRsbclDLGJ+f1PNnyMl1qUsn8yGN60rWbH3rpS98HX03OJa0QPjomkq
        Gz1qO9Ty1l8FBvkOSXH5kcxGeeKN5QLS9GPba3dy7FWPyKdGTYa5gNgj2XV/G1J+73q2sGdw
        3+cd/4x5JT2IFBxsvZPXokxITaJLr7+e6B/7Az0KwmuOvRK26SjfNW0/eOC9Anz8yd22dwNF
        +vvX3nkjfaqYj7F5UmEkqmWl/wJmn/6ZbQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSvC6nVlGywfRZwhZPd8xktXgwbxub
        xeIfz5ks7i/+zGJxaPNWdostV2YzWyw/foDVYv6Rc6wW2w8+YrHY+AIoe3HmXRaL5/PXMVq8
        nHWPzaLvxUNmi02Pr7FaXN41h82iZ8NWVou1R+6yWyy9fpHJYtmmP0wWi7Z+Ybdo3XuE3eLu
        nm2MFi1tR5gcJDzWzFvD6LHj7hJGj+tLPjF77Jx1l91j8Z6XTB6bVnWyedy5tofNY/OSeo/W
        o79YPPq2rGL06Dpync3j8yY5j1NfP7MH8EZx2aSk5mSWpRbp2yVwZXTO8ix4xFfR+rmXtYGx
        h6eLkZNDQsBEouvrLnYQW0hgB6NEcxM3RFxG4n/bMXYIW1hi5b/nQDYXUE0zk8TkWR9Zuhg5
        ONgEdCXObs8BiYsItDJKXF/ZyQTiMAusZJG4vbGHCaRbWCBBYs/RGWANLAKqEku+goV5BWwl
        Ft88yASxQF5i9YYDzCA2p4CdxNmDH1ggDrKVeHfsLdsERr4FjAyrGCVTC4pz03OLDQuM8lLL
        9YoTc4tL89L1kvNzNzGCY01LawfjnlUf9A4xMnEwHmKU4GBWEuGdJ5OfLMSbklhZlVqUH19U
        mpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVANT4dJilaZJPP32+xx+K3yRcGar
        nxwnfombIeyaldu6D8ZaH9aUBcVtMnLernV21TwVj99nvJjknBcFpQpM+GF1eNFXYfbsggNa
        0R8euJUnJzZX+gecKC2490bg8mqJ38Z9LiW6fc4y6t36V8r0H/d4cVfap4utOjL1b8BWT+aA
        trW2f5r8b99WXTbn2c9TNRWTJi9i6q7vmKt7TPhuoeS2xP3zlsjVGQu3aOT6XsqNPrs6+8H6
        X3KS+U1Bj/0yat97e7/aE8azYObx/4y39u2IlX6vmXbOOK+svin1X6CPlK1uxKn5unbLF380
        6ZhUF/5W6oRSwtl1rpUMhjMt5WODKs5t9H3b2rtsxq9tb5RYijMSDbWYi4oTATvyGfckAwAA
X-CMS-MailID: 20221114114409epcas5p32057f807dd538f874f8fd4a940c9de00
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221114114409epcas5p32057f807dd538f874f8fd4a940c9de00
References: <20221114115024.69591-1-aakarsh.jain@samsung.com>
        <CGME20221114114409epcas5p32057f807dd538f874f8fd4a940c9de00@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5441e9dafdfc6dc40 ("[media] s5p-mfc: Core support for MFC v7")
which adds mfc v7 support for Exynos3250 and use the same compatible
string as used by Exynos5240 but both the IPs are a bit different in
terms of IP clock.
Add variant driver data based on the new compatible string 
"samsung,exynos3250-mfc" for Exynos3250 SoC.

Suggested-by: Alim Akhtar <alim.akhtar@samsung.com>
Fixes: 5441e9dafdfc ("[media] s5p-mfc: Core support for MFC v7")
Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
 .../media/platform/samsung/s5p-mfc/s5p_mfc.c    | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
index fca5c6405eec..007c7dbee037 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c
@@ -1576,8 +1576,18 @@ static struct s5p_mfc_variant mfc_drvdata_v7 = {
 	.port_num	= MFC_NUM_PORTS_V7,
 	.buf_size	= &buf_size_v7,
 	.fw_name[0]     = "s5p-mfc-v7.fw",
-	.clk_names	= {"mfc", "sclk_mfc"},
-	.num_clocks	= 2,
+	.clk_names	= {"mfc"},
+	.num_clocks	= 1,
+};
+
+static struct s5p_mfc_variant mfc_drvdata_v7_3250 = {
+	.version        = MFC_VERSION_V7,
+	.version_bit    = MFC_V7_BIT,
+	.port_num       = MFC_NUM_PORTS_V7,
+	.buf_size       = &buf_size_v7,
+	.fw_name[0]     = "s5p-mfc-v7.fw",
+	.clk_names      = {"mfc", "sclk_mfc"},
+	.num_clocks     = 2,
 };
 
 static struct s5p_mfc_buf_size_v6 mfc_buf_size_v8 = {
@@ -1647,6 +1657,9 @@ static const struct of_device_id exynos_mfc_match[] = {
 	}, {
 		.compatible = "samsung,mfc-v7",
 		.data = &mfc_drvdata_v7,
+	}, {
+		.compatible = "samsung,exynos3250-mfc",
+		.data = &mfc_drvdata_v7_3250,
 	}, {
 		.compatible = "samsung,mfc-v8",
 		.data = &mfc_drvdata_v8,
-- 
2.17.1

