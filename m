Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91FD163C867
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237003AbiK2T37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236993AbiK2T30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:29:26 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638012EF64
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:27:47 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221129192746epoutp03e292694ad7a3e9f1b656cdb4b2d22be5~sJNaevK1r1107811078epoutp03B
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 19:27:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221129192746epoutp03e292694ad7a3e9f1b656cdb4b2d22be5~sJNaevK1r1107811078epoutp03B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669750066;
        bh=r4Q+3DcpeLgg0ND65yZqk12Y88w9C9XYbMKCdRwmA7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hVZbmt+PhsiqGTsS991VzyNB1Zb3PglOKVSu/kw0eDWPlGnWZyokNiV0bi4CrjIu0
         8CBqAwxFIpsLhgXU1Bbrby05Dew4BUD6O02rAzVRUnBoo6zD6AnMCqea2gmUNMpNVa
         g390Ikey1roLAj3aLcwjsG8F9WOFGyp0avU1uegA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20221129192744epcas5p34525c201c3827a0e6535abf20d7fa9c5~sJNZOS_ud2189421894epcas5p3o;
        Tue, 29 Nov 2022 19:27:44 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4NMC6712nXz4x9Pt; Tue, 29 Nov
        2022 19:27:43 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.59.56352.E2D56836; Wed, 30 Nov 2022 04:27:43 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221129115546epcas5p3d5ef247af122c4041f50337ed2ec148c~sDCxQVTvu1588315883epcas5p3_;
        Tue, 29 Nov 2022 11:55:46 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221129115546epsmtrp26107b42a0d16ee11f38059c78e8d4c56~sDCxPmA8v1810718107epsmtrp2H;
        Tue, 29 Nov 2022 11:55:46 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-11-63865d2e5b3c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        6D.89.18644.243F5836; Tue, 29 Nov 2022 20:55:46 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221129115544epsmtip15a5fdff3791825de5f4fc541f02f5a3b~sDCvpAMVS0590005900epsmtip1J;
        Tue, 29 Nov 2022 11:55:44 +0000 (GMT)
From:   Sriranjani P <sriranjani.p@samsung.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, alim.akhtar@samsung.com,
        pankaj.dubey@samsung.com, ravi.patel@samsung.com,
        sathya@samsung.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sriranjani P <sriranjani.p@samsung.com>
Subject: [PATCH v4 2/2] arm64: dts: fsd: add sysreg device node
Date:   Tue, 29 Nov 2022 17:25:31 +0530
Message-Id: <20221129115531.102932-3-sriranjani.p@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221129115531.102932-1-sriranjani.p@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKKsWRmVeSWpSXmKPExsWy7bCmuq5+bFuywaozzBYP5m1js5h/5Byr
        Rd+Lh8wWmx5fY7W4vGsOm8WM8/uYLBZt/cJu8fDDHnaL1r1H2C2+HHnNaHH7zTpWB26PTas6
        2TzuXNvD5rF5Sb1H35ZVjB6fN8kFsEZl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpa
        WpgrKeQl5qbaKrn4BOi6ZeYAXaakUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAp
        0CtOzC0uzUvXy0stsTI0MDAyBSpMyM54t2w9c8Fe/oopj+4yNzDu5+li5OSQEDCRuNryia2L
        kYtDSGA3o0Tfo7fsEM4nRomNG1dDOZ8ZJdbtW8oE07L27BdmEFtIYBejxLEmG4iiViaJI9tX
        s4Ik2AR0JVqvfWYCSYgI7GCUeD3pAJjDLDCFUaL723qwKmEBe4mWxavZQGwWAVWJjfP/g63g
        FbCTeLbhHCvEOnmJ1RsOgK3jBKo/3fGJFWSQhMBLdokDu+ezQRS5SCxe+wvqPmGJV8e3sEPY
        UhKf3+2FqkmX2HxkM9TQHImOpmZmCNte4sCVOSxdjBxA12lKrN+lDxGWlZh6ah3YSGYBPone
        30+gxvNK7JgHY6tJLH7UCWXLSKx99AlqvIfEucY5rJBgmcQocWH7WcYJjHKzEFYsYGRcxSiZ
        WlCcm55abFpgnJdaDo+35PzcTYzg9KflvYPx0YMPeocYmTgYDzFKcDArifB+DGpNFuJNSays
        Si3Kjy8qzUktPsRoCgzAicxSosn5wAScVxJvaGJpYGJmZmZiaWxmqCTOu3iGVrKQQHpiSWp2
        ampBahFMHxMHp1QD01blSEnvlwv3fXhjfnFOiy9vyT+PxrSKtf80TNq3NJ0Mi2bbF3vrUYlF
        qm31+23Jrb4pcXFdr6acm2h+eGLT7aP8k/ynHWDbZK16fp/yT8F+wz2f9/i1dlbVXww5sGT1
        /yLHy3vT977d9f6XyJGsuY5WbB71C2I2HvIt5l/85c0Vxp7FPy9rL5R9ccODLXP53wfOk6/w
        sqn3LGfX2C/gdtM2c6M5f1r67st92fueXawXevnfQojPyG+bKIPEhZS7VQsSnxYxbp9stFDc
        NO5uks79PwXHF1aLFj/snHG9b+qUJH65D3+7tXUNHz/OuXS+e7q78a2HE3+zlx6rkTVo5zt4
        0lihT+Tr47XJyTc0GJRYijMSDbWYi4oTAWuzvdQIBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsWy7bCSnK7T59Zkg9e/OC0ezNvGZjH/yDlW
        i74XD5ktNj2+xmpxedccNosZ5/cxWSza+oXd4uGHPewWrXuPsFt8OfKa0eL2m3WsDtwem1Z1
        snncubaHzWPzknqPvi2rGD0+b5ILYI3isklJzcksSy3St0vgyni3bD1zwV7+iimP7jI3MO7n
        6WLk5JAQMJFYe/YLcxcjF4eQwA5GiQOvtrNCJGQkTj5YwgxhC0us/PecHaKomUni15JPLCAJ
        NgFdidZrn5lAEiICBxgldvcuYQRxmAVmMEr8XT+HEaRKWMBeomXxajYQm0VAVWLj/P9MIDav
        gJ3Esw3noNbJS6zecABsHSdQ/emOT2BxIaCaF1cuME9g5FvAyLCKUTK1oDg3PbfYsMAoL7Vc
        rzgxt7g0L10vOT93EyM4QLW0djDuWfVB7xAjEwfjIUYJDmYlEd6PQa3JQrwpiZVVqUX58UWl
        OanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTDVtsvMY/u2tlpG78n8FazJAmtZ
        csTrE8xq7v2IEkzo5jV4mf2KtVVwV/H9uxsFI3/LHpo9X8Js+5L7jwJqGr3nZTY2ue6qbLXR
        y5h4fe+nM6aLrn4+6rinQ+XZRH+lua4ng3J6PdVe1b+reG5xOf+AoGHOJ8Nz/6KXqHVz35CX
        ePpJqtH6Q+9t/9aPL3t5hfrU/qu/fLfk8COW1cXbMu45fdyzXmWNnsKpsrunsuv+mh1ru2pm
        5PTzwuW+c/YCFvJqX+4mzJw+peljRP2OD9ZtS8uj+N7P+PlUQ3qrbLeeqhl7k7J3+MoLUz2m
        M5i1s36XuSjwd2dAuOKMghbhsytWPL5gUXfCxNlhQYC5g7gSS3FGoqEWc1FxIgAv9pLxvwIA
        AA==
X-CMS-MailID: 20221129115546epcas5p3d5ef247af122c4041f50337ed2ec148c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221129115546epcas5p3d5ef247af122c4041f50337ed2ec148c
References: <20221129115531.102932-1-sriranjani.p@samsung.com>
        <CGME20221129115546epcas5p3d5ef247af122c4041f50337ed2ec148c@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SYSREG controller device node, which is available in PERIC, FSYS0,
FSYS1 and CAM block of FSD SoC.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
---
 arch/arm64/boot/dts/tesla/fsd.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
index f35bc5a288c2..ff625fb71fbe 100644
--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
@@ -466,6 +466,11 @@
 			clock-names = "fin_pll";
 		};
 
+		sysreg_cam: system-controller@12630000 {
+			compatible = "tesla,fsd-cam-sysreg", "syscon";
+			reg = <0x0 0x12630000 0x0 0x500>;
+		};
+
 		clock_mfc: clock-controller@12810000 {
 			compatible = "tesla,fsd-clock-mfc";
 			reg = <0x0 0x12810000 0x0 0x3000>;
@@ -492,6 +497,11 @@
 				"dout_cmu_peric_shared1div4_dmaclk";
 		};
 
+		sysreg_peric: system-controller@14030000 {
+			compatible = "tesla,fsd-peric-sysreg", "syscon";
+			reg = <0x0 0x14030000 0x0 0x1000>;
+		};
+
 		clock_fsys0: clock-controller@15010000 {
 			compatible = "tesla,fsd-clock-fsys0";
 			reg = <0x0 0x15010000 0x0 0x3000>;
@@ -506,6 +516,11 @@
 				"dout_cmu_fsys0_shared0div4";
 		};
 
+		sysreg_fsys0: system-controller@15030000 {
+			compatible = "tesla,fsd-fsys0-sysreg", "syscon";
+			reg = <0x0 0x15030000 0x0 0x1000>;
+		};
+
 		clock_fsys1: clock-controller@16810000 {
 			compatible = "tesla,fsd-clock-fsys1";
 			reg = <0x0 0x16810000 0x0 0x3000>;
@@ -518,6 +533,11 @@
 				"dout_cmu_fsys1_shared0div4";
 		};
 
+		sysreg_fsys1: system-controller@16830000 {
+			compatible = "tesla,fsd-fsys1-sysreg", "syscon";
+			reg = <0x0 0x16830000 0x0 0x1000>;
+		};
+
 		mdma0: dma-controller@10100000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0x0 0x10100000 0x0 0x1000>;
-- 
2.17.1

