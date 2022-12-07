Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93ADB6456AC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiLGJhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 04:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiLGJhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:37:20 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1504042F5C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 01:37:09 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221207093707epoutp0116195e7d06cc352fd9cee68d2a144166~ueUACieD61995619956epoutp01d
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 09:37:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221207093707epoutp0116195e7d06cc352fd9cee68d2a144166~ueUACieD61995619956epoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670405827;
        bh=Snt2Sfm19TbPHC6NdC56oxXeITXd+ZYEHuxh4O0JQaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QJ4ytBD10XwkIGoRLKN0mENTUxpizzKcz8oJWF117Wf4gKjVyZOXBCoSZ0nmMNlIk
         Io6pZDD/4uY9uDkakmjtNwJfnM0tUQWDkQ4hVXVEkLTaaX7WoSvOE/0taAaWyu9CXS
         iz8QH4fjTa9nHx3ylhdo7J5at90NhG2Ato2RQQWg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221207093706epcas5p4e951749315f8a19d00ca98014a49e353~ueT-XyLAV0772407724epcas5p4m;
        Wed,  7 Dec 2022 09:37:06 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4NRscw5PfNz4x9Q1; Wed,  7 Dec
        2022 09:37:04 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.A1.01710.0CE50936; Wed,  7 Dec 2022 18:37:04 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20221207085855epcas5p17245364dc058b29f7edcabdfc5dfb456~udypkPXdz2875028750epcas5p1-;
        Wed,  7 Dec 2022 08:58:55 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221207085855epsmtrp1cbfc1a9d59a1249d77aa826edad11a39~udypjcrsW2582425824epsmtrp1X;
        Wed,  7 Dec 2022 08:58:55 +0000 (GMT)
X-AuditID: b6c32a49-c9ffa700000006ae-52-63905ec0a847
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        98.57.14392.FC550936; Wed,  7 Dec 2022 17:58:55 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221207085854epsmtip1725b59b360fd2fe8f19de08c8177bb7a~udyoESAIK2541625416epsmtip1R;
        Wed,  7 Dec 2022 08:58:54 +0000 (GMT)
From:   Sriranjani P <sriranjani.p@samsung.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, alim.akhtar@samsung.com,
        pankaj.dubey@samsung.com, ravi.patel@samsung.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Sriranjani P <sriranjani.p@samsung.com>
Subject: [PATCH 4/4] arm64: dts: exynos: add dedicated SYSREG compatibles to
 Exynosautov9
Date:   Wed,  7 Dec 2022 14:28:32 +0530
Message-Id: <20221207085832.86909-5-sriranjani.p@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221207085832.86909-1-sriranjani.p@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPKsWRmVeSWpSXmKPExsWy7bCmlu6BuAnJBhf+Klo8mLeNzWL+kXOs
        Fn0vHjJbbHp8jdXi8q45bBYzzu9jsli09Qu7xcMPe9gtWvceYbe4/WYdqwOXx6ZVnWwed67t
        YfPYvKTeo2/LKkaPz5vkAlijsm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTy
        EnNTbZVcfAJ03TJzgI5SUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YW
        l+al6+WlllgZGhgYmQIVJmRn7Gr5w1gwgati6ZGyBsa1HF2MnBwSAiYS015dZu9i5OIQEtjN
        KHHy6XFWkISQwCdGif7bThCJb4wSqyZcZoLpuPljClTHXkaJD9P2skA4rUwS2x8tZQepYhPQ
        lWi99pkJJCEisIRRorV7FyOIwywwhVHi2K9ljCBVwgLREgeebQLrYBFQlVh1fDcLiM0rYCux
        8vpRdoh98hKrNxxgBrE5Bewkvu1oYQMZJCFwi13ixdsTLBBFLhI3/n1jhrCFJV4d3wLVLCXx
        sr8Nyk6X2HxkMyuEnSPR0dQMVW8vceDKHKA5HEDXaUqs36UPEZaVmHpqHdjPzAJ8Er2/n0D9
        zyuxYx6MrSax+FEnlC0jsfbRJ6jxHhJHbsxnhATLREaJ2S172Scwys1CWLGAkXEVo2RqQXFu
        emqxaYFhXmo5PNqS83M3MYJTnpbnDsa7Dz7oHWJk4mA8xCjBwawkwvtiY2+yEG9KYmVValF+
        fFFpTmrxIUZTYABOZJYSTc4HJt28knhDE0sDEzMzMxNLYzNDJXHepVM6koUE0hNLUrNTUwtS
        i2D6mDg4pRqYFimka3w80Ki67OOLk4rf5z+apXc2myFRt3nVxlUF71UcSj9WFTI5HZpVONN+
        500OV8HZiQfbVE6tt2pytckJr3+z1OdxiomXltEH7+Phi6O8DhXry7vc7NO8ceJO7nun3c1f
        2dZNmcRX3s1XED1786HolQZLZx8P+sPuIVD9/VzM+k1BR9sz6sPKeFYJSntrhc0qfbw0Ik/C
        avm/Q01vtq4+EPXNwsR3a5/zHcnDz3VUEyr9/n352L748JcD1e4n0ywzReuMmlYbJU9Pndqp
        tHfNieKtP5jNk3L/35TNSLK49/7bd9VJqp6TvnW1OT3nPrxsjdJD8dqvhxjULfnLdMQXKc6Y
        7tHGqxj+LDpTiaU4I9FQi7moOBEA7cJ9+AIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGLMWRmVeSWpSXmKPExsWy7bCSnO750AnJBvMea1g8mLeNzWL+kXOs
        Fn0vHjJbbHp8jdXi8q45bBYzzu9jsli09Qu7xcMPe9gtWvceYbe4/WYdqwOXx6ZVnWwed67t
        YfPYvKTeo2/LKkaPz5vkAlijuGxSUnMyy1KL9O0SuDJ2tfxhLJjAVbH0SFkD41qOLkZODgkB
        E4mbP6awdzFycQgJ7GaUOLtnNxtEQkbi5IMlzBC2sMTKf8+hipqZJFp+zGEBSbAJ6Eq0XvvM
        BJIQEVjFKHHm0VQwh1lgBqPE0qVnwEYJC0RKPG37yQRiswioSqw6vhusm1fAVmLl9aPsECvk
        JVZvOAC2jlPATuLbjhawXiGgmnsPl7NNYORbwMiwilEytaA4Nz232LDAMC+1XK84Mbe4NC9d
        Lzk/dxMjOCi1NHcwbl/1Qe8QIxMH4yFGCQ5mJRHeFxt7k4V4UxIrq1KL8uOLSnNSiw8xSnOw
        KInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpgOi4/6YHrr+iVp+0UvSel3yx+yHh+ofEa+wl7
        tcrZn9rU/p+8jc3mUm3y39mfv30t6nk6P/tyjdKU8x0yd5+VvegKsdbcNjl5j1umAFfYfN7t
        gkExZiu0g8zm9n95+NHaof118ZS2R4pfNroXcE3iuDhRuXCr32MRH99zJjZFR60dv7Nc4hLS
        zLrQ9cytauv3lrS/e54sm5choMdwpGyL77/y+N3JX3I49hy/bhtVUbE1pGC5leBxkf7ihS6m
        ei98vhxqeMnuou01ffa8uWU6P/a+vn2Hv+u7c/1E46tbmF894+nuvlq5Jpz9mdmEicqvotbY
        ic58xB12/Cn3+W0W5gyBlaIZS3/uiWV7VnhLQYmlOCPRUIu5qDgRAE/6xR+5AgAA
X-CMS-MailID: 20221207085855epcas5p17245364dc058b29f7edcabdfc5dfb456
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221207085855epcas5p17245364dc058b29f7edcabdfc5dfb456
References: <20221207085832.86909-1-sriranjani.p@samsung.com>
        <CGME20221207085855epcas5p17245364dc058b29f7edcabdfc5dfb456@epcas5p1.samsung.com>
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

