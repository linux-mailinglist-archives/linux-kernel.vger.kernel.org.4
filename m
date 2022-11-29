Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A825263C864
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236914AbiK2T3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236787AbiK2T3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:29:16 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD181015
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:27:38 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221129192735epoutp020cb6a54e27d934acced5e32b4ccb5541~sJNRBUixG2641226412epoutp02i
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 19:27:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221129192735epoutp020cb6a54e27d934acced5e32b4ccb5541~sJNRBUixG2641226412epoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669750055;
        bh=JTyrEQs5/9sBOf2rZXy5DrILwJjoFjs/U7QjKhXHvck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZnHH2ELKMKGAQT7yoZyy0K+/BkwdL5kUve4jWZIHcml0ptDxld1ghED9oOKgPxKGC
         SnmlUne1+6hVF3UN4wCeR4vOQcTDrWGRtZIU0e8qRK9YccXLccmwNTRqQ6yRy3zUet
         mGoLBWX5KO4BBIfC3/o+MJx+L5dHoMBUZz+k/tHw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221129192734epcas5p4a07bcbe43ca2845822ef61b4e99c2884~sJNPlerhd0098000980epcas5p4D;
        Tue, 29 Nov 2022 19:27:34 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4NMC5w5BsLz4x9Pt; Tue, 29 Nov
        2022 19:27:32 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0A.49.56352.42D56836; Wed, 30 Nov 2022 04:27:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221129115543epcas5p3638987bf61777f9cc1b54b980c98c25b~sDCuU606R0319803198epcas5p36;
        Tue, 29 Nov 2022 11:55:43 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221129115543epsmtrp16dff37e4af77601491904f633a61fab5~sDCuUNiON1078010780epsmtrp1S;
        Tue, 29 Nov 2022 11:55:43 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-03-63865d24201b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B9.F1.14392.E33F5836; Tue, 29 Nov 2022 20:55:43 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221129115541epsmtip10879c762fce6c6b686910b0ddd5be740~sDCsyTSjv0481204812epsmtip1W;
        Tue, 29 Nov 2022 11:55:41 +0000 (GMT)
From:   Sriranjani P <sriranjani.p@samsung.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, alim.akhtar@samsung.com,
        pankaj.dubey@samsung.com, ravi.patel@samsung.com,
        sathya@samsung.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sriranjani P <sriranjani.p@samsung.com>
Subject: [PATCH v4 1/2] dt-bindings: soc: samsung: exynos-sysreg: Add tesla
 FSD sysreg compatibles
Date:   Tue, 29 Nov 2022 17:25:30 +0530
Message-Id: <20221129115531.102932-2-sriranjani.p@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221129115531.102932-1-sriranjani.p@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMKsWRmVeSWpSXmKPExsWy7bCmuq5KbFuywZ9V6hYP5m1js5h/5Byr
        Rd+Lh8wWmx5fY7W4vGsOm8WM8/uYLBZt/cJu8fDDHnaL1r1H2C2+HHnNaHH7zTpWB26PTas6
        2TzuXNvD5rF5Sb1H35ZVjB6fN8kFsEZl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpa
        WpgrKeQl5qbaKrn4BOi6ZeYAXaakUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAp
        0CtOzC0uzUvXy0stsTI0MDAyBSpMyM74MLGu4BV7xaM7j9gaGBvYuhg5OSQETCQav/9l6WLk
        4hAS2M0o0f/+NhuE84lR4sGzVVCZb4wSS7+fZ4Jpud4wmx0isZdRonfjYUaQhJBAK5PE4Tk6
        IDabgK5E67XPTCBFIgI7GCVeTzoA5jALTGGU6P62nhWkSlggReLbpoksIDaLgKrElyVrgJZz
        cPAK2ElcOp0FsU1eYvWGA8wgNqeAvcTpjk+sIHMkBB6xS7zovwZ1kovEjNPnGCFsYYlXx7ew
        Q9hSEi/726DsdInNRzazQtg5Eh1NzcwQtr3EgStzWED2MgtoSqzfpQ8RlpWYemod2HhmAT6J
        3t9PoFbxSuyYB2OrSSx+1Ally0isffQJaryHRPfCTiZICE1ilNgw8Sn7BEa5WQgrFjAyrmKU
        TC0ozk1PLTYtMM5LLYfHWnJ+7iZGcOrT8t7B+OjBB71DjEwcjIcYJTiYlUR4Pwa1JgvxpiRW
        VqUW5ccXleakFh9iNAWG30RmKdHkfGDyzSuJNzSxNDAxMzMzsTQ2M1QS5108QytZSCA9sSQ1
        OzW1ILUIpo+Jg1OqgamGhS90T6RV0byoVbvyPG9w+x+65c0cMbUvLmPKzqfMAhJmSxtWZrj2
        FUwX3X761KZC17i04NOyll6zOwP2lKYHl9+MmCmzYFYdj+d9yZmrdvWG3XpgVONSq/a+zs00
        qtj9ntLCmawyZaY350/0XpnsFr/iwqUDbnLa6mtUVec4rfd+eO/3kTVszo8YzXuF7+s3hk6b
        HPtkQ9iTbge9nmU7lIT4AxYveXAlQ/tBt/A0F+ntOktPlt+Zv05577z/65bzPNx58ofL3L9z
        lbknKFScVtjgZa2UzpCwKObglKqnAQ73mQ69Y3tsFMLxwOJK/uL9jF7PymIkvCbwv525Qy/q
        uExeSGrVf8W5/7Y/FFFiKc5INNRiLipOBAAvawJeBgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsWy7bCSnK7959Zkg44uZosH87axWcw/co7V
        ou/FQ2aLTY+vsVpc3jWHzWLG+X1MFou2fmG3ePhhD7tF694j7BZfjrxmtLj9Zh2rA7fHplWd
        bB53ru1h89i8pN6jb8sqRo/Pm+QCWKO4bFJSczLLUov07RK4Mj5MrCt4xV7x6M4jtgbGBrYu
        Rk4OCQETiesNs9m7GLk4hAR2M0r8+/sRKiEjcfLBEmYIW1hi5b/nUEXNTBJnP7axgCTYBHQl
        Wq99ZgJJiAgcYJTY3buEEcRhFpjBKPF3/RxGkCphgSSJ/VevMIHYLAKqEl+WrAFawcHBK2An
        cel0FsQGeYnVGw6AbeMUsJc43fGJFcQWAip5ceUC8wRGvgWMDKsYJVMLinPTc4sNCwzzUsv1
        ihNzi0vz0vWS83M3MYKDU0tzB+P2VR/0DjEycTAeYpTgYFYS4f0Y1JosxJuSWFmVWpQfX1Sa
        k1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA9PJDVeMI2t4vz9jXO0qlMZ260SF
        yPv6h26+rspTNUSvX2Iz4/y7QkfmcJHTmrjpj1xv5GXOz+EvVTi0MuRBAt8xfovwSUlcbqJr
        V7b5tj9be2vHnalq/Btbjz0Sbqr7vSXU0oNlHePpk/Em5qUfxOo02FmZSjvviK1QTdzg8uCp
        77TXVv5bFVwPN0R/Cf3GZXs16wlzsPpk3vNVe9J0PVIv3ZY+qvq6pmzd40f3DV9NDKn9Pu0x
        55VJvOeCOzxYLbffk7J2/SdXFPr3+QyH0GzxCUEabUxV3g99QucwMUmFJx5/s9hYoU2F9Xf4
        9JnOqe41XOs5TmW9VTpWYsvMI+F5ZwkXa4AEU91NldVMSizFGYmGWsxFxYkAX3mH7L0CAAA=
X-CMS-MailID: 20221129115543epcas5p3638987bf61777f9cc1b54b980c98c25b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221129115543epcas5p3638987bf61777f9cc1b54b980c98c25b
References: <20221129115531.102932-1-sriranjani.p@samsung.com>
        <CGME20221129115543epcas5p3638987bf61777f9cc1b54b980c98c25b@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for Tesla SYSREG controllers found on FSD SoC.

Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
---
 .../bindings/soc/samsung/samsung,exynos-sysreg.yaml           | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
index e7c80dd73081..4954790eda6c 100644
--- a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
@@ -19,6 +19,10 @@ properties:
               - samsung,exynos5-sysreg
               - samsung,exynos850-sysreg
               - samsung,exynosautov9-sysreg
+              - tesla,fsd-cam-sysreg
+              - tesla,fsd-fsys0-sysreg
+              - tesla,fsd-fsys1-sysreg
+              - tesla,fsd-peric-sysreg
           - const: syscon
       - items:
           - enum:
-- 
2.17.1

