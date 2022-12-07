Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EAC645862
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 11:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiLGK7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 05:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiLGK7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 05:59:13 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF074B75D
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 02:59:12 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221207105911epoutp03c4bb55c176f3631b7f0cf367130c83e5~ufbpyOVaj1197111971epoutp03Y
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 10:59:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221207105911epoutp03c4bb55c176f3631b7f0cf367130c83e5~ufbpyOVaj1197111971epoutp03Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670410751;
        bh=LESS+9FRzdAN/7Q6wUOIwfptX1lTGZf0KlXYzANBBns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P7lZSKqp7SWN57OtYX5W4y/ebd83olvOWn13k8QoBuZ63d4KWRaeVMoQd8vQ90SPe
         627XLBNkEW8jhb9dyyF43itntUCtpOPVcENrOiNY2BvBLItIXgYYU+UXmKHk0iLDSR
         0p9OrYxGdsnNvD53tB04nHIO/LnMLqRAuwd/dw10=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20221207105910epcas5p2f947bddb5e28b827c833c6d008663f9a~ufbpQwxyK2762627626epcas5p2a;
        Wed,  7 Dec 2022 10:59:10 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4NRvRd0Dznz4x9Q6; Wed,  7 Dec
        2022 10:59:09 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        83.29.39477.CF170936; Wed,  7 Dec 2022 19:59:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20221207105046epcas5p133c477b31f060d72e52c02566fa7683a~ufUTa0wSf3192631926epcas5p1Z;
        Wed,  7 Dec 2022 10:50:46 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221207105046epsmtrp13f32b9d0316d7c1feb748c0e50accbc1~ufUTaIjkZ2884028840epsmtrp1H;
        Wed,  7 Dec 2022 10:50:46 +0000 (GMT)
X-AuditID: b6c32a4a-259fb70000019a35-52-639071fc8afa
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CD.4C.18644.60070936; Wed,  7 Dec 2022 19:50:46 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221207105044epsmtip1939f8003e37a32cf995ebb7d0c3ddc92~ufUR_St6L2634226342epsmtip1Y;
        Wed,  7 Dec 2022 10:50:44 +0000 (GMT)
From:   Sriranjani P <sriranjani.p@samsung.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, alim.akhtar@samsung.com,
        pankaj.dubey@samsung.com, ravi.patel@samsung.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Sriranjani P <sriranjani.p@samsung.com>
Subject: [PATCH v2 2/4] arm64: dts: exynos: add dedicated SYSREG compatibles
 to Exynos850
Date:   Wed,  7 Dec 2022 16:20:30 +0530
Message-Id: <20221207105032.103510-3-sriranjani.p@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221207105032.103510-1-sriranjani.p@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHKsWRmVeSWpSXmKPExsWy7bCmpu6fwgnJBhvarS0ezNvGZjH/yDlW
        i74XD5ktNj2+xmpxedccNosZ5/cxWSza+oXd4uGHPewWrXuPsFvcfrOO1YHLY9OqTjaPO9f2
        sHlsXlLv0bdlFaPH501yAaxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5
        ibmptkouPgG6bpk5QEcpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OL
        S/PS9fJSS6wMDQyMTIEKE7Iz9uy1LrjIUXGsYxJ7A+Nk9i5GTg4JAROJXzd62LoYuTiEBHYz
        Shzpvs0E4XxilDi3cS87hPOZUeL6m4XMMC1TdtyAatnFKLGy/x4jhNPKJHG55QPYYDYBXYnW
        a5/BZokILGGUaO3eBVbFLDCFUeLYr2WMIFXCAtESj+bMB5rFwcEioCqx/aoiSJhXwE5i7pel
        TBDr5CVWbzgAtppTwF7iwtJHzCBzJARusUus+vSaFaLIRWLy4edQ9wlLvDq+Beo9KYmX/W1Q
        drrE5iOboepzJDqamqHq7SUOXJnDAnIDs4CmxPpd+hBhWYmpp9aB3cAswCfR+/sJ1D28Ejvm
        wdhqEosfdULZMhJrH31iBRkjIeAhcWNpICRQJjFK/Jk3m3ECo9wshA0LGBlXMUqmFhTnpqcW
        mxYY5aWWw2MtOT93EyM44Wl57WB8+OCD3iFGJg7GQ4wSHMxKIrwvNvYmC/GmJFZWpRblxxeV
        5qQWH2I0BQbfRGYp0eR8YMrNK4k3NLE0MDEzMzOxNDYzVBLnXTqlI1lIID2xJDU7NbUgtQim
        j4mDU6qBacI+qbm7lYxs5iqt31C/xyNpxu/++4tsxWT3/FRIejdnusNj21N7LnoK3xeccPTB
        3Qs/bdIiIk0jt+evc7I8tUfvouuuua/np8V4rVe5UM78eq3D+7AOTouFrnPC96t+3LLmimRr
        44LQiDWKi6NYNdiPvrnZm3GHn++qYMnRCXZ1ExN0v+hpTkhsvzBx0cXrQXkXljvcK/lTLahr
        cLWssbLkes5pr2s/M+YxtatMZrJxmbHm/PydU24bH8sTN1r3JPDctPOMbh8LZncujOdfvp17
        81SVimKpVX/n7lZzyRB/uPAv76Fd4rJ5m6+tPbrm2XYOW3a/o/uLtzhrFizeeC3eaRajTs4F
        hY5dUSqVUSeUWIozEg21mIuKEwG/TPOsAQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCLMWRmVeSWpSXmKPExsWy7bCSnC5bwYRkg6eXRC0ezNvGZjH/yDlW
        i74XD5ktNj2+xmpxedccNosZ5/cxWSza+oXd4uGHPewWrXuPsFvcfrOO1YHLY9OqTjaPO9f2
        sHlsXlLv0bdlFaPH501yAaxRXDYpqTmZZalF+nYJXBl79loXXOSoONYxib2BcTJ7FyMnh4SA
        icSUHTfYuhi5OIQEdjBKfHj5BSohI3HywRJmCFtYYuW/52BxIYFmJomu3fogNpuArkTrtc9M
        IM0iAqsYJc48mgrmMAvMYJRYuvQMG0iVsECkxPn+I0DdHBwsAqoS268qgoR5Bewk5n5ZygSx
        QF5i9YYDYMs4BewlLix9xAyxzE5i14odbBMY+RYwMqxilEwtKM5Nzy02LDDKSy3XK07MLS7N
        S9dLzs/dxAgOSC2tHYx7Vn3QO8TIxMF4iFGCg1lJhPfFxt5kId6UxMqq1KL8+KLSnNTiQ4zS
        HCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZODilGphYkk9eeJUWfvKwx4dUNp4zTYILvjBElN42
        Vo8U3Bv5xOdg1s5q1xsiHSsW7LM6WPb/dbakjueb+Q3PK6MPl+h9YKhqXBtWw5eiw+STKDNh
        b8S8HRPXv/i4m2GHToTshntfgxO1tzHNPrj8yud3/KeNja5srNI/lDj9HbsSI9fDufyGlqkG
        8Uq34m1UXp8oPsf8yumH972LiQsycipFGj5MqJCwLfG6V9kbliXY8r/7Uf/fuL9r7+XGbBPs
        br7PxrGz5fmVrYGeF8x0hSc8WWxbtY+toLdXKis+bHGbyqzOS3Ld8dfPzdgfyF4vVtHnFVux
        yGLRpZjP2UtNlA1NN59gE/0iHeF1fWbJ94nzmZRYijMSDbWYi4oTAbgxHfa3AgAA
X-CMS-MailID: 20221207105046epcas5p133c477b31f060d72e52c02566fa7683a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221207105046epcas5p133c477b31f060d72e52c02566fa7683a
References: <20221207105032.103510-1-sriranjani.p@samsung.com>
        <CGME20221207105046epcas5p133c477b31f060d72e52c02566fa7683a@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

