Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394FD6222D4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 04:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiKIDuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 22:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiKIDt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 22:49:58 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7882A17E29
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 19:49:55 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221109034954epoutp04dda701d12f98162042d2f3ba34d1e133~lzg1pL-Wt0365103651epoutp04q
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:49:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221109034954epoutp04dda701d12f98162042d2f3ba34d1e133~lzg1pL-Wt0365103651epoutp04q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667965794;
        bh=I1h3AraRZ5r0FizcGhsBmyj3WZa0LneUyzoFvuYazag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ex7UDMMT6uly73i8pIuChtYf6HxWTRii3kPFDIZQFgZ3MG/E8+P78pjWfKhx4AeBC
         Ew+3tTDY41+sQnLtVrpCEQsCS139yGAUzMIzgjMxmlYBpaXftzrnV/zBTShQrrsvp7
         94DjQQ0Qup9ecB9pJPd2ZgktvBH5Zawh7dana5T8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20221109034953epcas5p3f82c337ac4afe4c1eb92919c638decd6~lzg053tiD1932419324epcas5p3u;
        Wed,  9 Nov 2022 03:49:53 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4N6WFB1Lxyz4x9Pw; Wed,  9 Nov
        2022 03:49:50 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0E.0A.01710.E532B636; Wed,  9 Nov 2022 12:49:50 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20221109034811epcas5p4ecd94497380c5342258fc1dac7f99956~lzfWI9Dyq0747807478epcas5p4E;
        Wed,  9 Nov 2022 03:48:11 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221109034811epsmtrp1a83013c5ec1ba7226a54000222d28bb1~lzfWH1WOx1103811038epsmtrp1E;
        Wed,  9 Nov 2022 03:48:11 +0000 (GMT)
X-AuditID: b6c32a49-a41ff700000006ae-ee-636b235e1d6a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        36.38.18644.BF22B636; Wed,  9 Nov 2022 12:48:11 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221109034807epsmtip1f47eb8fc4e60a7836e27314250b1a491~lzfSVi4Ae0103101031epsmtip18;
        Wed,  9 Nov 2022 03:48:07 +0000 (GMT)
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
Subject: [Patch v2 3/3] arm: dts: exynos: Rename compatible string property
 from version to SoC specific
Date:   Wed,  9 Nov 2022 09:25:07 +0530
Message-Id: <20221109035507.69086-3-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221109035507.69086-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0xTVxzHd+5tb4ukyw2IHiticxsUWPraAC8GGHFM78ZMIPyxScSuKzct
        UNrax3RuydgCxJHJIEwj70nLnLwtDwuDpZTXZCiKBNxGlZfII3tIQRtntrVc2P77/B7f8zvn
        e87hogH3MT43U2uiDVqFhsB2sDr7w8NEp4TZSmlDHod8ZC9jkzPVnRhp8TxGyIcWN4t0tnVw
        yPaJCpS8OuxgkzUDt9nkjb45Fnl9yVu9W+ZikY9rmgG5XP4AI4uWZlHSNj/JJu91V2Lkl60d
        bLJpwMUh66buIuS3thcIWduxziHzewc4pKunE5B5BQNIAqQaqxsBZXdZATVlXUOprnIXh7L0
        LCOUrf4LjJqe7MGoNuunVP7gcxZV1F4PqMKBKYxy20KokQ03J5mXlh2rphUZtEFAa5W6jEyt
        Ko5ISpW/IY+KlspEshjyECHQKnLoOCLxnWTR0UyN1wJC8KFCY/amkhVGIyGJjzXozCZaoNYZ
        TXEErc/Q6CP1YqMix2jWqsRa2nRYJpW+GuVtfD9bbR9N1T/jnnWtDYJcMMgpBH5ciEfCybFp
        xMcB+PcAPmrVFoIdXl4D0DP7BGECN4ANC0PYtsLtPI8xhW4A56/WsZkgH4HNfUPegMvFcBG8
        dUPjE+zEP/M2nTf5elC8hAV/LVpCfYVAPAvOVLk2V2XhobC0qnJTy8Pj4HJXCDNsP2xodWy2
        ++HxcHjDubWJf7jwpsvMcCKstbYBhgPhynD71tH4cPmrgi1WwvnaZZRhDWzp+ZrF8OvQMVHJ
        8o1F8XDY0i1h0vvgxZHmTVdQ/GV44a8FhMnzoL16mw/AymkPm+Fg2N9QB3zLQJyCc04z40gJ
        gKvrI1gxCCn/f8I3ANSDPbTemKOijVF6mZY+89+NKXU5NrD5xCPesgPXzJ9iJ0C4wAkgFyV2
        8hqbs5QBvAzFR+dog05uMGtooxNEed0rQflBSp33j2hNcllkjDQyOjo6Mua1aBmxm2e5HKEM
        wFUKE51N03rasK1DuH78XCQlN87ztmclZd20q8neK16cHlexq0tPzKXeayr2P+loCp8Xdv4x
        e2jt6XVP0Hjw7GGH8HbCQWLIJa2u+fnOJ/7CwHn5xGLa6dgTkv70j6UcluTSwTePN3GrAuP3
        thU5isem9/x2Qbc6M2tKf0+3Ema9bPph7QPpK+N1Dc+6rHyL+vPVU/zfb730UB76t/81YXB6
        0Nl30w6cOzr+y097IxaCChaPZZg3vhNX3GzcL7Kp/FN2/SjlXRlNfBFbWiwpe65qb7nGE1uO
        X8FleYWisZxLFSPsUckZRWWSWnByKE9Ycd+a4r4jyEo6tloaKtrXe+RBgvL0buLpxT55wpH9
        w41PRsRhBMuoVsgiUINR8S9KLd84awQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWy7bCSnO5vpexkgwV7RC2e7pjJavFg3jY2
        i8U/njNZ3F/8mcXi0Oat7BZbrsxmtlh+/ACrxfwj51gtth98xGKx8QVQ9uLMuywWz+evY7R4
        Oesem0Xfi4fMFpseX2O1uLxrDptFz4atrBZrj9xlt1h6/SKTxbJNf5gsFm39wm7RuvcIu8Xd
        PdsYLVrajjA5SHismbeG0WPH3SWMHteXfGL22DnrLrvH4j0vmTw2repk87hzbQ+bx+Yl9R6t
        R3+xePRtWcXo0XXkOpvH501yHqe+fmYP4I3isklJzcksSy3St0vgythxJrjgO0fF3U9HGRsY
        j7J3MXJySAiYSHw+1MHWxcjFISSwg1FieedTRoiEjMT/tmNQRcISK/89Z4coamaS2HX4HZDD
        wcEmoCtxdnsOSFxEoJVR4vrKTiYQh1lgJYvE7Y09TCDdwgIZEmevbAGzWQRUJSbPncMK0swr
        YCvxcqccxAJ5idUbDjCD2JwCdhLHvx5iA7GFgEpamvawT2DkW8DIsIpRMrWgODc9t9iwwCgv
        tVyvODG3uDQvXS85P3cTIzjatLR2MO5Z9UHvECMTB+MhRgkOZiUR3jXrspKFeFMSK6tSi/Lj
        i0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYGqUMWt+pLX+4gb/u+qHvh95
        tqA0kpvd/Jtb9MPydfsmF39TWdqrJirzpv/Ssh3Pp71ca/Ly/mID3Q/5PsuUDfK/aByyNJvm
        aPapZUFhyy27FXe0P05rLniZdqb5adbKUB37rKeRwlqa0W4KDyx3+u3mnDVD8c/Zv36d/Ymr
        LXtffXi0zmJ2ph1fcHDAae/imebPW0uPdKY8s5F59SqquC/bnDlI8ZOYoUjQTQP92VGHOPY9
        f77ecpLPXHs5X96gv9pt07Pic3p4/4qGnbgjZu9XeCzylnGYb2d3Vd5dSamMIJ4p/ME3mTYm
        bbb35BS50Sk5RfR88odrpbWrr/Hsct2XvVFm5yo1SUGjior9SizFGYmGWsxFxYkAM4qSICUD
        AAA=
X-CMS-MailID: 20221109034811epcas5p4ecd94497380c5342258fc1dac7f99956
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221109034811epcas5p4ecd94497380c5342258fc1dac7f99956
References: <20221109035507.69086-1-aakarsh.jain@samsung.com>
        <CGME20221109034811epcas5p4ecd94497380c5342258fc1dac7f99956@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit "752d3a23d1f68de87e3c" which adds MFC codec device node
for exynos3250 SoC. Since exynos3250.dtsi and exynos5420.dtsi are
using same compatible string as "samsung,mfc-v7" but their
node properties are different.As both SoCs have MFC v7 hardware
module but with different clock hierarchy and complexity.
So renaming compatible string from version specific to SoC based.

Reviewed-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Suggested-by: Alim Akhtar <alim.akhtar@samsung.com>
Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 326b9e0ed8d3..98105c64f7d9 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -485,7 +485,7 @@
 		};
 
 		mfc: codec@13400000 {
-			compatible = "samsung,mfc-v7";
+			compatible = "samsung,exynos3250-mfc";
 			reg = <0x13400000 0x10000>;
 			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "mfc", "sclk_mfc";
-- 
2.17.1

