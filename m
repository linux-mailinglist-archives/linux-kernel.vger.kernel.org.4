Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3606456A5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiLGJhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 04:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiLGJg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:36:57 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63F841990
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 01:36:55 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221207093654epoutp0267b58a7779d021a405d82868a69f00e4~ueTzqOAoB2931729317epoutp02P
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 09:36:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221207093654epoutp0267b58a7779d021a405d82868a69f00e4~ueTzqOAoB2931729317epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670405814;
        bh=LESS+9FRzdAN/7Q6wUOIwfptX1lTGZf0KlXYzANBBns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VGyEk+NybxrdI68ISmzQcyVr3825Iqx8X53ACg5lrUeH+n5Yp1eY96FJeBN0GCoK0
         Jaw75Ec4N2YVOHFfyZCA8DJgM3thBiTYwXin+Q3ZKZ0PlQJvcOJFfa3ILaGEAnqJ5B
         gVTMiLZIiPgrlPQx4yg1qIzXpxYp0IERAxixvTvY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20221207093653epcas5p34dbd1e9ed9e9a34968bc43dbed41029e~ueTzV8Y_i1380113801epcas5p3N;
        Wed,  7 Dec 2022 09:36:53 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4NRsch3HSlz4x9Pw; Wed,  7 Dec
        2022 09:36:52 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BA.91.01710.4BE50936; Wed,  7 Dec 2022 18:36:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221207085849epcas5p36cc450174093b369c29433251a559e0b~udyjmWg_M0541805418epcas5p3u;
        Wed,  7 Dec 2022 08:58:49 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221207085849epsmtrp24a360cd283b34291afe01bad33d7b906~udyjll_uU3113231132epsmtrp2K;
        Wed,  7 Dec 2022 08:58:49 +0000 (GMT)
X-AuditID: b6c32a49-c9ffa700000006ae-26-63905eb46647
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E5.57.14392.9C550936; Wed,  7 Dec 2022 17:58:49 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221207085847epsmtip1a22e853d171352027290584e77e38afa~udyiI97nP2587525875epsmtip1K;
        Wed,  7 Dec 2022 08:58:47 +0000 (GMT)
From:   Sriranjani P <sriranjani.p@samsung.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, alim.akhtar@samsung.com,
        pankaj.dubey@samsung.com, ravi.patel@samsung.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Sriranjani P <sriranjani.p@samsung.com>
Subject: [PATCH 2/4] arm64: dts: exynos: add dedicated SYSREG compatibles to
 Exynos850
Date:   Wed,  7 Dec 2022 14:28:30 +0530
Message-Id: <20221207085832.86909-3-sriranjani.p@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221207085832.86909-1-sriranjani.p@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPKsWRmVeSWpSXmKPExsWy7bCmuu6WuAnJBhemS1o8mLeNzWL+kXOs
        Fn0vHjJbbHp8jdXi8q45bBYzzu9jsli09Qu7xcMPe9gtWvceYbe4/WYdqwOXx6ZVnWwed67t
        YfPYvKTeo2/LKkaPz5vkAlijsm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTy
        EnNTbZVcfAJ03TJzgI5SUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YW
        l+al6+WlllgZGhgYmQIVJmRn7NlrXXCRo+JYxyT2BsbJ7F2MnBwSAiYSzy5dBbK5OIQEdjNK
        nOxcygbhfGKU6Pt3A8r5xijxctJSZpiWn2cPs0Ak9jJKdEzbwAzhtDJJTNkxlQ2kik1AV6L1
        2mcmkISIwBJGidbuXYwgDrPAFEaJY7+WMYJUCQtESFz+8IAVxGYRUJWYfm0JUAcHB6+ArUTD
        OSuIdfISqzccAFvNKWAn8W1HC9hNEgL32CUWd25khChykfi17zgbhC0s8er4Fqj3pCQ+v9sL
        FU+X2HxkMyuEnSPR0dQM9Y+9xIErc1hA9jILaEqs36UPEZaVmHpqHROIzSzAJ9H7+wkTRJxX
        Ysc8GFtNYvGjTihbRmLto09Q4z0kbi1oZYWEykRGieZTrSwTGOVmIaxYwMi4ilEytaA4Nz21
        2LTAMC+1HB5tyfm5mxjBKU/Lcwfj3Qcf9A4xMnEwHmKU4GBWEuF9sbE3WYg3JbGyKrUoP76o
        NCe1+BCjKTD8JjJLiSbnA5NuXkm8oYmlgYmZmZmJpbGZoZI479IpHclCAumJJanZqakFqUUw
        fUwcnFINTGuL5l3UeZFawL7IdNPrT8ejWm7/u/tR0zfqq/mjb+nV77elnt6Yv2PBBNmg5n2Z
        G/aXh/P/+3Cq9rXQ4vg+DrdIYRk3/RdXb/lYcV2T0ix+8ez4gkVS3V9EWhnEb6Vu/jnV8c/C
        wnJ1bju/+Tpz3PZdskicHB14VDm7ZMX+ss27b7w98o735Eq2askF8wpjvhcd657Pl6bxZJ4W
        08kstc+/eiX7zQUeJpRF+OoGPtgTs+cNUxjXJJGOZd0u08P4DdZ1TV9hUiSfl7yBtTwgT73i
        27nkow1zbFUfBR1pKZd7+oBFz423v7BR9cORB+v0RCokz7S+UF63/tH55q1LL121zpVf9mCN
        QozWTbd9HEosxRmJhlrMRcWJABTziHwCBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCLMWRmVeSWpSXmKPExsWy7bCSnO7J0AnJBtubeC0ezNvGZjH/yDlW
        i74XD5ktNj2+xmpxedccNosZ5/cxWSza+oXd4uGHPewWrXuPsFvcfrOO1YHLY9OqTjaPO9f2
        sHlsXlLv0bdlFaPH501yAaxRXDYpqTmZZalF+nYJXBl79loXXOSoONYxib2BcTJ7FyMnh4SA
        icTPs4dZuhi5OIQEdjNKnJh9mBUiISNx8sESZghbWGLlv+fsEEXNTBI3e+eBFbEJ6Eq0XvvM
        BJIQEVjFKHHm0VQwh1lgBqPE0qVn2LoYOTiEBcIkXjR7gTSwCKhKTL+2hAkkzCtgK9Fwzgpi
        gbzE6g0HwJZxCthJfNvRwgZiCwGV3Hu4nG0CI98CRoZVjJKpBcW56bnFhgWGeanlesWJucWl
        eel6yfm5mxjBAamluYNx+6oPeocYmTgYDzFKcDArifC+2NibLMSbklhZlVqUH19UmpNafIhR
        moNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAOT2o4VW+KfV25smTS7MVh3o4viXGmuhWfa
        QiKX1Mc0HS1fUqciNnNLWK9AXqcdt4pa+BO7qC859wsbj3sYScQ4/HZafWbK91OBq6Iebgh+
        GmAQ7iPv9/iEh0++GVvs5ls777G6Bkre2N7/rdw/OMc75g9Lel184syQy6EM985vTPpeZi5u
        ttQ23vFe6tXHXBz79Rats3OQ0P/3uXqHgEL8/ynn7xfNOHIy3vPInqmGPJOZ1T38J5cnPNRp
        7LljcuVbv+rSoLDdpw7K6Kzc3y4z1Wu30vMZ+xceYKj8U/lxluGBmI6FOk5Bn9d0adpsz8kK
        nPLS6YjXndpfld8yf9/8+sVA5/bBvEefw11kPdOVWIozEg21mIuKEwFEjcHCtwIAAA==
X-CMS-MailID: 20221207085849epcas5p36cc450174093b369c29433251a559e0b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221207085849epcas5p36cc450174093b369c29433251a559e0b
References: <20221207085832.86909-1-sriranjani.p@samsung.com>
        <CGME20221207085849epcas5p36cc450174093b369c29433251a559e0b@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exynos850 has two different SYSREGs, so use dedicated compatibles for them.

Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos850.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos850.dtsi b/arch/arm64/boot/dts/exynos/exynos850.dtsi
index c61441f3a89a..a38fe5129937 100644
--- a/arch/arm64/boot/dts/exynos/exynos850.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos850.dtsi
@@ -549,13 +549,15 @@
 		};
 
 		sysreg_peri: syscon@10020000 {
-			compatible = "samsung,exynos850-sysreg", "syscon";
+			compatible = "samsung,exynos850-peri-sysreg",
+				     "samsung,exynos850-sysreg", "syscon";
 			reg = <0x10020000 0x10000>;
 			clocks = <&cmu_peri CLK_GOUT_SYSREG_PERI_PCLK>;
 		};
 
 		sysreg_cmgp: syscon@11c20000 {
-			compatible = "samsung,exynos850-sysreg", "syscon";
+			compatible = "samsung,exynos850-cmgp-sysreg",
+				     "samsung,exynos850-sysreg", "syscon";
 			reg = <0x11c20000 0x10000>;
 			clocks = <&cmu_cmgp CLK_GOUT_SYSREG_CMGP_PCLK>;
 		};
-- 
2.17.1

