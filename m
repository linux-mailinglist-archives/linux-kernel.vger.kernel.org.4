Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EB164586B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 12:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiLGLAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 06:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiLGK72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 05:59:28 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8C64E42A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 02:59:23 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221207105922epoutp016f28e1cc22f1699d061884360116e731~ufbzmv6dE2641126411epoutp01c
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 10:59:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221207105922epoutp016f28e1cc22f1699d061884360116e731~ufbzmv6dE2641126411epoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670410762;
        bh=Snt2Sfm19TbPHC6NdC56oxXeITXd+ZYEHuxh4O0JQaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BIpqPP3e/pIWlKxlW5oAfTbo49IY9k14zcuQqpujAUNKSJhOYl/bkVnWllblITAcq
         qkSttcRnyWKv+cwlJdTnqTqpmR9eQXMJX9y5sHJyCOSYu5o5Lzlswv+W9Pvjg5oLWm
         uW5QwI0oz8g79kUklg4ujNnIAnzwgHJWnBy480xA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221207105921epcas5p1d1560b1c4c8ae4b59bf7f157c0ae8f13~ufby8R-Qu1385413854epcas5p17;
        Wed,  7 Dec 2022 10:59:21 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4NRvRq3Psvz4x9Q1; Wed,  7 Dec
        2022 10:59:19 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4A.29.39477.70270936; Wed,  7 Dec 2022 19:59:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20221207105052epcas5p1473e38c140d38909c3c98d892bc8a4c4~ufUY-A9LX0558705587epcas5p1P;
        Wed,  7 Dec 2022 10:50:52 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221207105052epsmtrp12e8b8d59f47cd48ea27f7617fb3b0f1d~ufUY_VxRx2853128531epsmtrp1T;
        Wed,  7 Dec 2022 10:50:52 +0000 (GMT)
X-AuditID: b6c32a4a-259fb70000019a35-72-639072072c41
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E6.D0.14392.C0070936; Wed,  7 Dec 2022 19:50:52 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221207105050epsmtip13e2b239186347b50124be7e64ad2d259~ufUXetViX2632626326epsmtip1Y;
        Wed,  7 Dec 2022 10:50:50 +0000 (GMT)
From:   Sriranjani P <sriranjani.p@samsung.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, alim.akhtar@samsung.com,
        pankaj.dubey@samsung.com, ravi.patel@samsung.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Sriranjani P <sriranjani.p@samsung.com>
Subject: [PATCH v2 4/4] arm64: dts: exynos: add dedicated SYSREG compatibles
 to Exynosautov9
Date:   Wed,  7 Dec 2022 16:20:32 +0530
Message-Id: <20221207105032.103510-5-sriranjani.p@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221207105032.103510-1-sriranjani.p@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAKsWRmVeSWpSXmKPExsWy7bCmpi570YRkg2PPxCwezNvGZjH/yDlW
        i74XD5ktNj2+xmpxedccNosZ5/cxWSza+oXd4uGHPewWrXuPsFvcfrOO1YHLY9OqTjaPO9f2
        sHlsXlLv0bdlFaPH501yAaxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5
        ibmptkouPgG6bpk5QEcpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OL
        S/PS9fJSS6wMDQyMTIEKE7IzdrX8YSyYwFWx9EhZA+Naji5GTg4JAROJCY/OsHQxcnEICexm
        lOjZ/ZoZwvnEKLHox1Z2COcbo8Ted23sMC1b1l+CatnLKHGnZzIrhNPKJHF0zjawKjYBXYnW
        a5+ZQBIiAksYJVq7dzGCOMwCUxgljv1axghSJSwQJ3Fv63ywDhYBVYnNM6+zgNi8AnYSZ2+t
        h9onL7F6wwFmEJtTwF7iwtJHYBdKCNxjl3j3+DIzRJGLxOqP36AahCVeHd8CZUtJvOyHOTxd
        YvORzawQdo5ER1MzVK+9xIErc4AWcwBdpymxfpc+RFhWYuqpdUwgNrMAn0Tv7ydMEHFeiR3z
        YGw1icWPOqFsGYm1jz5BjfeQeLvzJhMkWCYxSvyefIF1AqPcLIQVCxgZVzFKphYU56anFpsW
        GOWllsPjLTk/dxMjOOlpee1gfPjgg94hRiYOxkOMEhzMSiK8Lzb2JgvxpiRWVqUW5ccXleak
        Fh9iNAUG4ERmKdHkfGDazSuJNzSxNDAxMzMzsTQ2M1QS5106pSNZSCA9sSQ1OzW1ILUIpo+J
        g1OqgWmas0ywYpIfC2MYR4CN1Mfcc4d6r9l5xSxh5D//495Ob+VeDasrrekPombJrPB+XvSB
        QUAr81Kq9Enp5T6iZ6e05L27Xm7Bm/3s+srHS67zPnysNGPbw73L8gtqytK1kk1jH/9YuOeN
        6XyncxcmFvQyLwx7s093G/eXjufnYhmLTAN55Ze9t7t3ooDNOZ4vcdZPQ5l7kVJPgjQbsryN
        rD1LFnxpVTJn0uPQvdBx9qfqje/5LXGLHRl58m6/WBw+r924h/PH9j/d+zeK/1h97273XsdV
        di95lPPVVJwOflfdzXFt6/3CtAcrw6a65zU84dfgkJYTUp77ImjPpgS9vLjaY3kdT4KUwn+F
        zzLnVGIpzkg01GIuKk4EAEcE57sDBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGLMWRmVeSWpSXmKPExsWy7bCSnC5PwYRkg/l3hC0ezNvGZjH/yDlW
        i74XD5ktNj2+xmpxedccNosZ5/cxWSza+oXd4uGHPewWrXuPsFvcfrOO1YHLY9OqTjaPO9f2
        sHlsXlLv0bdlFaPH501yAaxRXDYpqTmZZalF+nYJXBm7Wv4wFkzgqlh6pKyBcS1HFyMnh4SA
        icSW9ZdYuhi5OIQEdjNK3F5ymwkiISNx8sESZghbWGLlv+fsEEXNTBITD7azgyTYBHQlWq99
        ZgJJiAisYpQ482gqmMMsMINRYunSM2wgVcICMRLHlk0FG8UioCqxeeZ1FhCbV8BO4uyt9ewQ
        K+QlVm84AFbDKWAvcWHpIzBbCKhm14odbBMY+RYwMqxilEwtKM5Nzy02LDDMSy3XK07MLS7N
        S9dLzs/dxAgOSi3NHYzbV33QO8TIxMF4iFGCg1lJhPfFxt5kId6UxMqq1KL8+KLSnNTiQ4zS
        HCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZODilGpjs+BZMVjOfe0bu6pJJNfWLZjK8vbr3f7EL
        H6PD0ovLxF8KGHjO8Wasbbg579ti2y0blyqon2aO2ul/4nSRIEOvxGOd9CmsGTP+yZXnPTxY
        ZzdVcMemDUvjroZoxnowRRz9qv2KeU/v001vV26sfrDkIguPtOHpnObryt49pexyE3muPlpV
        +uDoZK2jEir/fI5sLJPfezbx/eq+D++/XE57eGzj49SX73YFrcr331jC4HbUKP79sQ23Gk5Z
        1nTLum+b58J0Y/9kCfmYs/u2hGpraHz0P1H7eFq2wz6zxuQfxyq26LsvV1Wd6Ld/9bP7ykv+
        eezSOXZC8tX+vM3lbIIaeX1nRO49kj/4JlLox6SXpkosxRmJhlrMRcWJAF1t/sm5AgAA
X-CMS-MailID: 20221207105052epcas5p1473e38c140d38909c3c98d892bc8a4c4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221207105052epcas5p1473e38c140d38909c3c98d892bc8a4c4
References: <20221207105032.103510-1-sriranjani.p@samsung.com>
        <CGME20221207105052epcas5p1473e38c140d38909c3c98d892bc8a4c4@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exynosautov9 has several different SYSREGs, so use dedicated compatibles
for them.

Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynosautov9.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
index 5dc361734cfe..d3c5cdeff47f 100644
--- a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
@@ -370,17 +370,20 @@
 		};
 
 		syscon_fsys2: syscon@17c20000 {
-			compatible = "samsung,exynosautov9-sysreg", "syscon";
+			compatible = "samsung,exynosautov9-fsys2-sysreg",
+				     "samsung,exynosautov9-sysreg", "syscon";
 			reg = <0x17c20000 0x1000>;
 		};
 
 		syscon_peric0: syscon@10220000 {
-			compatible = "samsung,exynosautov9-sysreg", "syscon";
+			compatible = "samsung,exynosautov9-peric0-sysreg",
+				     "samsung,exynosautov9-sysreg", "syscon";
 			reg = <0x10220000 0x2000>;
 		};
 
 		syscon_peric1: syscon@10820000 {
-			compatible = "samsung,exynosautov9-sysreg", "syscon";
+			compatible = "samsung,exynosautov9-peric1-sysreg",
+				     "samsung,exynosautov9-sysreg", "syscon";
 			reg = <0x10820000 0x2000>;
 		};
 
-- 
2.17.1

