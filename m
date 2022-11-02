Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E564E617629
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 06:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiKCF3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 01:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiKCF3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 01:29:46 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0D817E19
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 22:29:45 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221103052943epoutp0440a5ee96d6c740b7d873feb8baaa698a~j-ASEKZ1x2023520235epoutp04Q
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 05:29:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221103052943epoutp0440a5ee96d6c740b7d873feb8baaa698a~j-ASEKZ1x2023520235epoutp04Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667453383;
        bh=5Yeiza4hwFUHRxgHQg44jdFShjSSRQePfF5w+VZxIp8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dmQVYW6K1sZejOA8ISG1usCf5VugaUwF7i7BGKSCRxWKSJCMv1SnoNkqAqatPCedw
         4C2yM9LOPeW6/wEm+ClFOsjKS/DUSgYY4O9yBslTN/aqZB6JQQCoxr4Hsl5KRWP0Zq
         jQzTXmhU+W3PsiRqnpbDiZhNjmVkDsjQjoubF49Q=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221103052942epcas5p129cf8302467d7f7e220cb4d9a8a5ee68~j-ARdOgbR2620726207epcas5p15;
        Thu,  3 Nov 2022 05:29:42 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4N2sl746tcz4x9Q7; Thu,  3 Nov
        2022 05:29:39 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1E.54.39477.1C153636; Thu,  3 Nov 2022 14:29:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20221102125813epcas5p40a38f17a267276ff8b2bc5861b5d450d~jxel4fnLc0163401634epcas5p4H;
        Wed,  2 Nov 2022 12:58:13 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221102125813epsmtrp1c3f15e1a5db7a711f83632ea98046a10~jxel3TP5U0619706197epsmtrp18;
        Wed,  2 Nov 2022 12:58:13 +0000 (GMT)
X-AuditID: b6c32a4a-259fb70000019a35-51-636351c172a1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E3.04.14392.56962636; Wed,  2 Nov 2022 21:58:13 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221102125810epsmtip1046d53c415e4db4ac2f17ef21a148d6a~jxeiw6bJU1919619196epsmtip1k;
        Wed,  2 Nov 2022 12:58:10 +0000 (GMT)
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
Subject: [PATCH 2/3] media: s5p-mfc:Add variant data for MFC v7 hardware for
 Exynos 3250 SOC
Date:   Wed,  2 Nov 2022 18:36:01 +0530
Message-Id: <20221102130602.48969-2-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221102130602.48969-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0xTVxzHd+69vb1oCjcg7AwYsEacEIGWQXdg8nJu3gyzsAfJ5ozYtTdA
        WtqmLQi6TI3ihE2UqHM8UlmhzPF+0yo4HiUmbCAOAvIo8pjyiItOcHSbc2u5sP33Pb/f53u+
        J79zDoW7T5LeVLpKz2pVUqWQ3EK09QYFhXS/J5OJfntIofvmIh6aMbSRqNy+gKF75SsE6mlu
        5aOWkRIcfXeri4euWgd5qL17jkCNi47unSIbgRau1gG0VDxNooLFWRw1zY/y0PD1UhJ91dDK
        Q7VWGx+Zxu5gqLLpGYaMrat8lNtp5SNbRxtAp89YsXjI1BhqAGO2VQBmrOIJzliKbXymvGMJ
        Y5qq8khmarSDZJorjjO5fX8STEFLFWDyrWMks9Lkx/Q/XeEnCQ4odqexUjmrDWBVMrU8XZUa
        I0z8IOXNlEiJSBwijkKvCwNU0gw2Rrh3f1LI2+lKxwiEAVlSZaajlCTV6YRhsbu16kw9G5Cm
        1uljhKxGrtREaEJ10gxdpio1VMXqo8UiUXikAzysSHt+dwLT3HTNNuadwk6AR1vzgQsF6Qg4
        9Pcglg+2UO70DQCvNZTzucUTAPvqhglu8TuAc33z+KZlwV4LuEYngE+NJzeoXAzOna8n8wFF
        kXQIHGhXOg3b6JMAzp/VOxmcLiTgZMHi+k4e9CF4t3YFOHmCDoRDJh+nFNAxsH4ynsvyh9UN
        Xeu0Cx0L18bz13MhbaegpXuc4KC9cLbs5sbhPODyrRY+p73h0vkzG1oG541LG4wS1ndc2vDG
        wa6RUsKZi9NBsP56GFd+GV7ur8OcGqdd4bm/fsG4ugCaDZt6ByydsvM47Qt7q02A0wysHDLh
        3EgKAbxXaMIvAL/i/yPKAKgCL7EaXUYqq4vUhKvYI/9dmkyd0QTWX3nwO2YwO/M4tAdgFOgB
        kMKF2wTHBz6RuQvk0pyjrFados1UsroeEOkYXyHu7SlTO76JSp8ijogSRUgkkoio1yRi4YuC
        8m+CZe50qlTPKlhWw2o3fRjl4n0Co3/9J2N6+JBRuK/QElXz6Gt255rbs8ay+5KBfcaL7AJ6
        izpVHJYT5LvH+9VL705XC0arXA1eVfXHWpMPdoxXGj5dzhoNjPvQMMBPbj4SoyB3+WT23/B8
        EJYw9fP2Ub+Zg6a6FyYeT+V1nity8a8wzGKxnhYPr+eNPx247a9Pg3Hjgepv3SSrhxN8Jgft
        V8zfu6+5Hntl+mxNX3TSD3WNIuuA+YLtdp/6aGLcTiYw6/P32xJKwi0T9l2eBVsVkclopmf/
        g+XK+Oz23pK4kdMfX3T7Q/5Rmeiz1Tf8fHfkpF+u0LWSXyZu97hGpe+x/GiUpw5/gSmu6LXR
        obKx7Ie1s8grSi0kdGlScTCu1Un/BQmPGqFuBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRfVCLcRzA/Z7n2bOnsXludeenXFi6I+nF2/3OVbi4+/3HH/zh7WatR42t
        1p7k5bK6Y2gKnTlRV10ttAqtV4pb2xK5kFxDLSla5cSVKEeYzn+f733u8/3+8WVIaS7lz6iS
        UjldkkIto0VUvUMWuIpTxSkjeooWog+NVwWov7CeRqVTHgK9LZ2gkL2mTohqX+aT6EabTYCK
        nE8FqKFlgELVw39t51U3hTxFtwAaudZHo/PD70hkHewWoK57BTTKvlMnQFVOtxCVuToJdN36
        k0AldV+FyHDfKUTu5nqATp12EpsgriysBLjRbQbYZR4n8d1rbiEubR4hsNWSRePe7mYa15gz
        sKH1B4XP11oANjpdNJ6wBuL2yQnhdvFuUVQ8p1alcbrwmP2ixJlXbwjtA8nRkqyTRCb4PNcI
        fBjIroWeqSpgBCJGyjYBaDYa6FmxCP4+/VA4y76wfMbzj6XsSQKWDWUYAcPQ7CrY0aD2tn6s
        AUBXeRbhHUi2nII91dmEN/Bl98K2c+0Cb0CxwfB5WYAXxWw0vN2zaXb9Ylhxx0Z62YeNgd9f
        G8HsqWhYne0iLwJJMZhjAQs5La9J0PCR2sgk7kgYr9Dwh5MSwpTJGiv497WQFY2gwfIlzA4I
        BtgBZEiZnzijY49SKo5XHDvO6ZLlusNqjreDAIaSLRA/Nz6WS9kERSp3iOO0nO6/JRgf/0yi
        ZMGbIM36jSfiA4+rLHJTuiqvq2so5d7L6TyKZC5UiPreP3sH4cD8hzN9uWmM1vnIt6knonB5
        OFh9abckf7CS3bA8xxD7C5/NmP94i23QLgoGrrSKecqCy1EppqOdO+3SybHYCNP4R4/tmN5x
        aseamryoIv/+EPOL0KpdrrHkZHkKb6ccU8ES57Km9Oip8G692m2yPilb94Q516ZtibVcmf46
        1p/K5YTog1oSLUvfZ45+mx4a7R/d/K2g7+YB+RLTXdRLOUQ+OfFYFRpkG+A/Va7V49zJfHUr
        00Z8D5X4tcf07is+2HEgolWuj0t7tnLbmY6t06/zq4br8FYZxScqIkNIHa/4A2H/E14kAwAA
X-CMS-MailID: 20221102125813epcas5p40a38f17a267276ff8b2bc5861b5d450d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221102125813epcas5p40a38f17a267276ff8b2bc5861b5d450d
References: <20221102130602.48969-1-aakarsh.jain@samsung.com>
        <CGME20221102125813epcas5p40a38f17a267276ff8b2bc5861b5d450d@epcas5p4.samsung.com>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit "5441e9dafdfc6dc40fa" which adds mfc v7 support for
Exynos3250 and used the same compatible string as used by
Exynos5240 but both the IPs are a bit different in terms of
IP clock.
Lets add variant driver data based on the new compatible string
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

