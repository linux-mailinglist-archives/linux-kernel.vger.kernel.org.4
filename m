Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA8065B138
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 12:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjABLcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 06:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235970AbjABLbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 06:31:36 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD91127
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 03:31:34 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230102113129epoutp04d9dc1d12874e3a6dfc0dcfb533161c63~2epR7vEKw1599715997epoutp04X
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 11:31:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230102113129epoutp04d9dc1d12874e3a6dfc0dcfb533161c63~2epR7vEKw1599715997epoutp04X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672659089;
        bh=V+MhvXZuyhnigGyJcR8OFBr7qhFj/TxXmOZFo/UxiQg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=rFeiLCvYanazoi3J330jeySMDVno3Lsm9ykk0dsa93/LkkIgM3dgxHU1IOl65cEyS
         QRiwNPV2g79/HzHmEQh5y44raWpficfgBXVvyO+mH/4/QqgXKuKmONTp7UAw0Rw0w/
         DoCkY8sLy+rXD4dQ51U5X12H+/oenGlwwSSSMwqE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230102113129epcas5p478247d8d48f57e6a71aa6a63d0c28d1f~2epRlZ4lQ0771707717epcas5p4y;
        Mon,  2 Jan 2023 11:31:29 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Nltwv5drdz4x9Pt; Mon,  2 Jan
        2023 11:31:27 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0D.E7.03362.F80C2B36; Mon,  2 Jan 2023 20:31:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230102093302epcas5p2d48e893eb8af30e4d78b1377e022ff3a~2dB2yiIx53146631466epcas5p2R;
        Mon,  2 Jan 2023 09:33:02 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230102093302epsmtrp2a9297a057b3a9368aac89b68b7f79a2a~2dB2x2IhQ1751117511epsmtrp2D;
        Mon,  2 Jan 2023 09:33:02 +0000 (GMT)
X-AuditID: b6c32a4b-287ff70000010d22-1e-63b2c08f38d3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        57.91.02211.EC4A2B36; Mon,  2 Jan 2023 18:33:02 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230102093301epsmtip26701ca8a5f5b384b5ec2c85d6f43ee29~2dB1iDwB00200002000epsmtip28;
        Mon,  2 Jan 2023 09:33:01 +0000 (GMT)
From:   Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alim.akhtar@samsung.com, s.prashar@samsung.com,
        pankaj.dubey@samsung.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Subject: [PATCH v2] arm64: dts: fsd: fix PUD values as per FSD HW UM
Date:   Mon,  2 Jan 2023 15:02:47 +0530
Message-Id: <20230102093247.59649-1-p.rajanbabu@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEKsWRmVeSWpSXmKPExsWy7bCmpm7/gU3JBldbdS0ezNvGZjH/yDlW
        i74XD5ktLu+aw2ZxdGOwxaKtX9gtWvceYbeYt2MuowOHx6ZVnWwed67tYfPo27KK0ePzJrkA
        lqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygK5QU
        yhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BSYFesWJucWleel6eaklVoYGBkamQIUJ
        2RkXdp1gL/glVHF/7XO2BsZr/F2MnBwSAiYSU3/eZOpi5OIQEtjNKPHp+Q0o5xOjxKq97WwQ
        zjdGiYs3mllgWn51H2eGSOxllLj0cSdUSyuTxI8bD9hAqtgETCVWzWlkBbFFBFoZJebeDQSx
        mQXyJc6+uglWIyzgIvHi1zZmEJtFQFVixbvpYPW8AjYSn1tPQm2Tl1i94QAzhL2OXaLxIxeE
        7SJx7tRsdghbWOLV8S1QtpTE53d72SDsfIlpH5uh7AqJto8bmCBse4kDV+YAzecAukdTYv0u
        fYiwrMTUU+uYIM7kk+j9/QSqnFdixzwYW1Vi/fJNjBC2tMS+63uhbA+J63sWg50sJBArseXC
        dqYJjLKzEDYsYGRcxSiZWlCcm55abFpgnJdaDo+o5PzcTYzgxKXlvYPx0YMPeocYmTgYDzFK
        cDArifBe/rwuWYg3JbGyKrUoP76oNCe1+BCjKTDIJjJLiSbnA1NnXkm8oYmlgYmZmZmJpbGZ
        oZI4b+rW+clCAumJJanZqakFqUUwfUwcnFINTIErZ9q5NRtK5QglROzzFq5PnLcvpenNm5nv
        xIPNfH45NCUuYmFYtLfYJJnz28xlHcd8bCzsAtgZg5ucn/+4bq/ev+oe6zlGwZpv4Saqc7SY
        DP9/j164q3Iu/6aAJ65TnfdGqDJ4+VhMm1FQLlCU4K2dv/jhif8qce+Ti/e0Tvyln6Ma/t5e
        YbfVvoocl9cXa9if8XWdfF9t17PT/DR3GMvxc219qlv/PX1+MfxS+uovFrOey/yaNunq7XWz
        ZzFrTNtk+scy/cPaqQdSFu76vWxf5OIGwcAQ8+33jHa5Ln/787/7csWihnfv7A+77F5aL8J3
        yOhMStEB878vskO7BFYfk+r/Gd9pECxqGnS+XImlOCPRUIu5qDgRADvx5S3lAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPJMWRmVeSWpSXmKPExsWy7bCSvO65JZuSDV6fFbd4MG8bm8X8I+dY
        LfpePGS2uLxrDpvF0Y3BFou2fmG3aN17hN1i3o65jA4cHptWdbJ53Lm2h82jb8sqRo/Pm+QC
        WKK4bFJSczLLUov07RK4Mi7sOsFe8Euo4v7a52wNjNf4uxg5OSQETCR+dR9n7mLk4hAS2M0o
        sannFQtEQlpiev8eNghbWGLlv+fsEEXNTBIHzp1lB0mwCZhKrJrTyAqSEBHoZpS41vgarJtZ
        oFDi38I7YN3CAi4SL35tYwaxWQRUJVa8m84KYvMK2Eh8bj0JtU1eYvWGA8wTGHkWMDKsYpRM
        LSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIDiMtzR2M21d90DvEyMTBeIhRgoNZSYT38ud1
        yUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwVd7/8SNU
        QeXSq1lF5Ut9Ldu+mllPj8qeWfRu4ynL74pFMhmb8rpDnqxJl17ZvUS79PFT6cqfuzfxfH3T
        p3rq4jyGC31FMw3/tJ/Jknmn4p2092TruWTRw9kLyv9dKuozSusr78ox+nvW6GPP7qSvcc6a
        vO7br53uWWx09GHJ6umbruzZIjYv5YfRHPb9k1Ib/obd+v49sNbARW9N37kF07fWf9+Tw3tT
        JuaLjrV996s6jtViX4+tUzdhSpF0leo/+ifUwy3gWILZk/aHHo8SuHTbK2Xqtp3TW+8zZ3kZ
        26+KuOfNjB9fhNm+SXnyxd/Mtm6t4z1b679Xv/C9c/ivEn65T2Xj9D/7EtnTn06qVGIpzkg0
        1GIuKk4EAEMgHqqSAgAA
X-CMS-MailID: 20230102093302epcas5p2d48e893eb8af30e4d78b1377e022ff3a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230102093302epcas5p2d48e893eb8af30e4d78b1377e022ff3a
References: <CGME20230102093302epcas5p2d48e893eb8af30e4d78b1377e022ff3a@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PUD values used for UFS, SPI and UART are not reflecting
the default values recommended by FSD HW UM. Therefore,
changing the same to comply with HW UM recommendation.

Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
---
 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
index 73cb388d6ac1..c99868b273b4 100644
--- a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
@@ -54,14 +54,14 @@
 	ufs_rst_n: ufs-rst-n-pins {
 		samsung,pins = "gpf5-0";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
-		samsung,pin-pud = <FSD_PIN_PULL_NONE>;
+		samsung,pin-pud = <FSD_PIN_PULL_DOWN>;
 		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	ufs_refclk_out: ufs-refclk-out-pins {
 		samsung,pins = "gpf5-1";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
-		samsung,pin-pud = <FSD_PIN_PULL_NONE>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
 		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 };
@@ -308,35 +308,35 @@
 	uart0_data: uart0-data-pins {
 		samsung,pins = "gpb7-0", "gpb7-1";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
-		samsung,pin-pud = <FSD_PIN_PULL_NONE>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
 		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	uart1_data: uart1-data-pins {
 		samsung,pins = "gpb7-4", "gpb7-5";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
-		samsung,pin-pud = <FSD_PIN_PULL_NONE>;
+		samsung,pin-pud = <FSD_PIN_PULL_UP>;
 		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	spi0_bus: spi0-bus-pins {
 		samsung,pins = "gpb4-0", "gpb4-2", "gpb4-3";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
-		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-pud = <FSD_PIN_PULL_DOWN>;
 		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	spi1_bus: spi1-bus-pins {
 		samsung,pins = "gpb4-4", "gpb4-6", "gpb4-7";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
-		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-pud = <FSD_PIN_PULL_DOWN>;
 		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	spi2_bus: spi2-bus-pins {
 		samsung,pins = "gpb5-0", "gpb5-2", "gpb5-3";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
-		samsung,pin-pud = <FSD_PIN_PULL_UP>;
+		samsung,pin-pud = <FSD_PIN_PULL_DOWN>;
 		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
-- 
2.17.1

