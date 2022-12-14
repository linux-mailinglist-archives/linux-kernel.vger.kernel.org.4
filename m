Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFDC64C347
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 05:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237263AbiLNErp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 23:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237292AbiLNEri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 23:47:38 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE24E7D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 20:47:37 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221214044736epoutp010f454c964aeb4fa6c4c53fc27a0f8e0d~wj4Nc9UOD2974829748epoutp017
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 04:47:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221214044736epoutp010f454c964aeb4fa6c4c53fc27a0f8e0d~wj4Nc9UOD2974829748epoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670993256;
        bh=LESS+9FRzdAN/7Q6wUOIwfptX1lTGZf0KlXYzANBBns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QhJOcrLC/e7xhQMBlPe5oXkuyR5P7Y8ipZc2Jrg970Dsgt53Sq1nGu4zT73VnmvEx
         Z1YmZo4WKBWC+X+GKgeeqWuuQec064d/U5Q68BthJPBPBwdGyZMJcJvDBiZMYByGOa
         6x8YDjwlpXSndp4sh/lW4IpYe95QFI1ZR9dGxwvs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221214044735epcas5p1862d89ebd305f3a928ed3cae100459bf~wj4M_Wv1u2670026700epcas5p1s;
        Wed, 14 Dec 2022 04:47:35 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4NX2sd6cVhz4x9Q7; Wed, 14 Dec
        2022 04:47:33 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        67.72.01710.56559936; Wed, 14 Dec 2022 13:47:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221214044427epcas5p39131549dc4529ea41d9916d81d3d5fce~wj1d8522R1611116111epcas5p3k;
        Wed, 14 Dec 2022 04:44:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221214044427epsmtrp15c71daadcca8bf4e472b3694b0163257~wj1d8JQRV2887928879epsmtrp1H;
        Wed, 14 Dec 2022 04:44:27 +0000 (GMT)
X-AuditID: b6c32a49-c9ffa700000006ae-8f-639955653a10
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5A.2C.14392.BA459936; Wed, 14 Dec 2022 13:44:27 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20221214044425epsmtip208960f54d9a1073364917028110572bf~wj1bt_aXR2889728897epsmtip2e;
        Wed, 14 Dec 2022 04:44:24 +0000 (GMT)
From:   Sriranjani P <sriranjani.p@samsung.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, alim.akhtar@samsung.com,
        pankaj.dubey@samsung.com, ravi.patel@samsung.com,
        sathya@samsung.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sriranjani P <sriranjani.p@samsung.com>
Subject: [PATCH v3 2/4] arm64: dts: exynos: add dedicated SYSREG compatibles
 to Exynos850
Date:   Wed, 14 Dec 2022 10:13:40 +0530
Message-Id: <20221214044342.49766-3-sriranjani.p@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221214044342.49766-1-sriranjani.p@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKKsWRmVeSWpSXmKPExsWy7bCmum5q6Mxkg3PH+SwezNvGZjH/yDlW
        i74XD5ktNj2+xmpxedccNosZ5/cxWSza+oXd4uGHPewWrXuPsFt8OfKa0eL2m3WsDtwem1Z1
        snncubaHzWPzknqPvi2rGD0+b5ILYI3KtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0
        tDBXUshLzE21VXLxCdB1y8wBukxJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BS
        oFecmFtcmpeul5daYmVoYGBkClSYkJ2xZ691wUWOimMdk9gbGCezdzFyckgImEgcOt7C1MXI
        xSEksJtRomvBf1YI5xOjxNFjR6Ccb4wSG7/sZYNp6f05gw0isZdR4tbaHVBOK5PEu+VTwKrY
        BHQlWq99BhssIrCDUeL1pANgDrPAFEaJ7m/rWUGqhAWiJToP7wLrYBFQldj65iaYzStgK3F2
        xT+oE+UlVm84wAxicwrYScxrmg02SELgJbvE5hX3mCGKXCRWtD5ihLCFJV4d3wLVLCXxsr8N
        yk6X2HxkMyuEnSPR0dQM1WsvceDKHJYuRg6g6zQl1u/ShwjLSkw9tY4JxGYW4JPo/f2ECSLO
        K7FjHoytJrH4USeULSOx9tEnqPEeEp9fdECDZSKjxMPVDcwTGOVmIaxYwMi4ilEytaA4Nz21
        2LTAMC+1HB5vyfm5mxjB6U/Lcwfj3Qcf9A4xMnEwHmKU4GBWEuFV1ZiWLMSbklhZlVqUH19U
        mpNafIjRFBiAE5mlRJPzgQk4ryTe0MTSwMTMzMzE0tjMUEmcd+mUjmQhgfTEktTs1NSC1CKY
        PiYOTqkGpph67VWbt3S5l7YcmPDiQS9PXuSO3J5C/p6aR7LcZs4T+YI/R7FtP2lu9aFz3g3t
        IqmHN770sclPe5XxJN0uOjhvizvb9eXrZhftt9kt1sbCoHu8IYOxzWrvj3lzxbNk5imc/8Kz
        cevqPRV2dvyJkuK6UfwPv1QuOK28gE8/7dnrHRHB/xZ8EjhdlrMtZP4xFWfRfqN6z9+NBh5F
        MpZtqYsWMmne15YX5uIVEj98SPO7wMmDM/YZPuoL9TjOYHLw6l65gxWv+ic02DPWztw98dud
        1Ce6Kw0bTfRemYUJfji7sZrx3d11mrnT58tWd/0OL28wibdbbHa0693D/352y95Y7Yu9yKR+
        R/lMQ6OLEktxRqKhFnNRcSIA7RgotQgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsWy7bCSvO7qkJnJBpMuy1k8mLeNzWL+kXOs
        Fn0vHjJbbHp8jdXi8q45bBYzzu9jsli09Qu7xcMPe9gtWvceYbf4cuQ1o8XtN+tYHbg9Nq3q
        ZPO4c20Pm8fmJfUefVtWMXp83iQXwBrFZZOSmpNZllqkb5fAlbFnr3XBRY6KYx2T2BsYJ7N3
        MXJySAiYSPT+nMHWxcjFISSwm1HiwKEeJoiEjMTJB0uYIWxhiZX/nrNDFDUzSRzfd4gFJMEm
        oCvReu0zE0hCROAAo8Tu3iWMIA6zwAxGib/r5zCCVAkLREr0HdoGto9FQFVi65ubbCA2r4Ct
        xNkV/6DukJdYveEA2DpOATuJeU2zwc4QAqrZ9Owu+wRGvgWMDKsYJVMLinPTc4sNCwzzUsv1
        ihNzi0vz0vWS83M3MYLDU0tzB+P2VR/0DjEycTAeYpTgYFYS4VXVmJYsxJuSWFmVWpQfX1Sa
        k1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA9MmlhMNrNcW/q7kq9Jf8srqQtC6
        S48j1CaLm6aa5Cy5tNuc4a9q71J7Dl7fGQdCZ7xeMfepzKRqFd/jRV+Y7vIsrP3FbOTQVSuW
        mRlxOu1ZRPXi47q9W7nnzCxw8PZS6ZdxuJ0wh60//XyNi3LA0r1mR1fP3L/A9HOB5Vz7Ioa4
        x14sk2L4l7kFur6KbP3Hw7rxNNfcG6mhwfYWHbdZeL61znRhv6iyPqcoRu3lRtOtZrvOm1Xe
        eCnaLXF3tfjim60Hvjeb11y8ciPq7ZQFt+7tsZSLVQi0brzuPHX2GTYB2W3J+lYvVNd/1LJ/
        vLiw50bS95cC/2UqWO+d4jq5M2TNm5nyU/uTQy+FNwWWByuxFGckGmoxFxUnAgAethu+vgIA
        AA==
X-CMS-MailID: 20221214044427epcas5p39131549dc4529ea41d9916d81d3d5fce
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221214044427epcas5p39131549dc4529ea41d9916d81d3d5fce
References: <20221214044342.49766-1-sriranjani.p@samsung.com>
        <CGME20221214044427epcas5p39131549dc4529ea41d9916d81d3d5fce@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

