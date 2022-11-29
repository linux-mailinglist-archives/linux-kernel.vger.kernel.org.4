Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E552F63C869
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236991AbiK2Ta2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236988AbiK2T35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:29:57 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9C02658
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:28:37 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221129192836epoutp045bc45ce417b9e3274f900e320729048e~sJOJGZToY1027710277epoutp046
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 19:28:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221129192836epoutp045bc45ce417b9e3274f900e320729048e~sJOJGZToY1027710277epoutp046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669750116;
        bh=lkuhxHcEi+ueE4Lb3G8T6Nv+IZedCyGE3cNW3S37p0k=;
        h=From:To:Cc:Subject:Date:References:From;
        b=j6tlDL3KI4X8T4UeVI4mYNN5DUG6sSHFwAyi0vN9/gCTPPST2M0VZX2WuQLne0XEU
         R3Lxf+YfI9eHgTkZ+OWdOOZXxE+Bjaoq8RLIZIImQ1qLGGrBhzH2pWZyMgLuQ9zCv3
         dZXrk0FA+n4JLP+3JFRyT5eSgzK6uQPxMzYFSxnA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221129192834epcas5p1866007a3f2c11dde88ca20551faa1ee9~sJOH5PslW0265602656epcas5p14;
        Tue, 29 Nov 2022 19:28:34 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4NMC751QhKz4x9Pp; Tue, 29 Nov
        2022 19:28:33 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7B.59.56352.16D56836; Wed, 30 Nov 2022 04:28:33 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221129095529epcas5p31acfecd374b59cddd2e67d2efcdd86b4~sBZwO1y-u1210212102epcas5p3L;
        Tue, 29 Nov 2022 09:55:29 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221129095529epsmtrp2cb363ca8609e0e9c6e10bc204cab6a45~sBZwOIkKp1176311763epsmtrp2d;
        Tue, 29 Nov 2022 09:55:29 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-61-63865d612478
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1B.EA.14392.117D5836; Tue, 29 Nov 2022 18:55:29 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20221129095528epsmtip2e7c3c796682e5db203bf371f2c61faf4~sBZvBE1OC2783827838epsmtip2h;
        Tue, 29 Nov 2022 09:55:28 +0000 (GMT)
From:   Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alim.akhtar@samsung.com, s.prashar@samsung.com,
        pankaj.dubey@samsung.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Subject: [PATCH] arm64: dts: fsd: fix PUD values as per FSD HW UM
Date:   Tue, 29 Nov 2022 15:25:16 +0530
Message-Id: <20221129095516.89132-1-p.rajanbabu@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEKsWRmVeSWpSXmKPExsWy7bCmlm5ibFuywderbBYP5m1js5h/5Byr
        Rd+Lh8wWl3fNYbM4ujHYYtHWL+wWrXuPsFvM2zGX0YHDY9OqTjaPO9f2sHn0bVnF6PF5k1wA
        S1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QFUoK
        ZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScApMCveLE3OLSvHS9vNQSK0MDAyNToMKE
        7Ix73z+xFvwRqvj35B57A+MN/i5GTg4JAROJl8dns3UxcnEICexmlHh0biEjhPOJUWJ3404m
        COcbo8TGb8uYYVounz3FCpHYyyjRd+0mM4TTyiQx9d0mFpAqNgFTiVVzGllBbBGBVkaJuXcD
        QWxmgXyJs69usoHYwgKOElsPbmQCsVkEVCU+LfoDZvMK2EicnXuZHWKbvMTqDQfAFkgIrGKX
        mDbrFdQZLhLXFi1kgrCFJV4d3wLVICXx+d1eNgg7X2Lax2You0Ki7eMGqHp7iQNX5gAdygF0
        kKbE+l36EGFZiamn1jFB3Mkn0fv7CVQ5r8SOeTC2qsT65ZsYIWxpiX3X90LZHhLvH51lBxkp
        JBArcfa97QRG2VkICxYwMq5ilEwtKM5NTy02LTDOSy2HR1Ryfu4mRnDi0vLewfjowQe9Q4xM
        HIyHGCU4mJVEeD8GtSYL8aYkVlalFuXHF5XmpBYfYjQFBtlEZinR5Hxg6swriTc0sTQwMTMz
        M7E0NjNUEuddPEMrWUggPbEkNTs1tSC1CKaPiYNTqoFpotei6V7K79SvFffKLd2b1HnyuInb
        LQ8mxfJwpapLjpUv9ujXdfKfYeWfbdZum/L8R9cCIaOOqsUXA7NsytOetW3fEh2/N21rYp7P
        84nGTaoLN/LsiVA6wvDA51d7F3eafviLT3YXX7amONWc7lWek/u0omfa2cB7R35az2Xvf2Ri
        Jh+edjDe2vrF3ZTH7ukyy+7M3Pvg54efywrKO+xO7uNrq+bR61PeF9Y39yjPx+lntyyZJfNn
        zflWw26/Za/Z0lZoXLlSIJDatW+3q9PxWK5M6Vr/FTsznoTenxU/f92coq8zYtLnq1hOzJ3g
        /v+gN/c/s/hpNzVtLnoXXUk8N19c+dK3BIGpjYqOD0qVWIozEg21mIuKEwFykk5h5QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPJMWRmVeSWpSXmKPExsWy7bCSvK7g9dZkg327lS0ezNvGZjH/yDlW
        i74XD5ktLu+aw2ZxdGOwxaKtX9gtWvceYbeYt2MuowOHx6ZVnWwed67tYfPo27KK0ePzJrkA
        ligum5TUnMyy1CJ9uwSujHvfP7EW/BGq+PfkHnsD4w3+LkZODgkBE4nLZ0+xdjFycQgJ7GaU
        WDi5mxkiIS0xvX8PG4QtLLHy33N2iKJmJolXKx6CJdgETCVWzWkE6xYR6GaUuNb4mgUkwSxQ
        KPFv4R2wImEBR4mtBzcygdgsAqoSnxb9AbN5BWwkzs69zA6xQV5i9YYDzBMYeRYwMqxilEwt
        KM5Nzy02LDDMSy3XK07MLS7NS9dLzs/dxAgOIy3NHYzbV33QO8TIxMF4iFGCg1lJhPdjUGuy
        EG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxSDUwpB29bqR0M
        UJx3LYj7DXdezMvizVJzShaeMvz0bZndw/+3D3+xUs9pcdQ3fMz1qukGp8nJdexZtYL3ZT1N
        Dy18pPTQLMG0O39V5/aDIsYb5U9vPSuW9uDLOrM3czPkwwVS13fZLApOV9hvk62kaxRXY/q6
        N/Zha71y+GcDu8SMSgaBU4LGUwN/28Xmpb6oMP9c+VRu3kJvBfZHnbIi0Qrv+ToydMWSarMq
        WeTdtadzTBKceaNivlieSHnvfJNVFxVkfnAtXd2v4lirOcv0xmmHpRsvRrg8PLLncWi+2/l8
        w7va97OkV5+f/VJwu591uLDW7KVuV7WPtgRFswcu0P//a7d3p5XuosblJy3jlFiKMxINtZiL
        ihMBuS44x5ICAAA=
X-CMS-MailID: 20221129095529epcas5p31acfecd374b59cddd2e67d2efcdd86b4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221129095529epcas5p31acfecd374b59cddd2e67d2efcdd86b4
References: <CGME20221129095529epcas5p31acfecd374b59cddd2e67d2efcdd86b4@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index e3852c946352..2b367bde45b8 100644
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
 };
-- 
2.17.1

