Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E739638EB0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 17:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiKYQ5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 11:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiKYQ5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 11:57:10 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C645216E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 08:56:53 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221125165651epoutp032c9fad6e53666a840ff05d1a8e8fd1b1~q4kga1sy72714127141epoutp03G
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 16:56:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221125165651epoutp032c9fad6e53666a840ff05d1a8e8fd1b1~q4kga1sy72714127141epoutp03G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669395411;
        bh=5zEwm62+Df41XmeGPV9WhvFqqIDc/P4iT5J13bGw/rg=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=H5EhzEOGWTp+ya+Hie/A05aYUztyvdDezGCEWE0zWxaGgrz2eIu/TfPwvtBhmm6EH
         W3npsNPACvvFEZJuYMjTfDlvDau2ynup3SdUTKtvrY14xSGED8GfdixYJbAGFTsvqf
         VCmczlcRBE8aBW7zhqz3zKvl1sXXvAFjBtu44DyU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20221125165650epcas5p28408f153e44320e73c07c918517acc95~q4kfw5v0j3024330243epcas5p2B;
        Fri, 25 Nov 2022 16:56:50 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4NJgxr5stdz4x9Pt; Fri, 25 Nov
        2022 16:56:48 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F0.3C.01710.0D3F0836; Sat, 26 Nov 2022 01:56:48 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221125165648epcas5p324203ea005c991ee26b830abeb4b98c3~q4kdo0z8y2149521495epcas5p37;
        Fri, 25 Nov 2022 16:56:48 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221125165648epsmtrp2e91fdab847f200cdda91e73e4dfa38a7~q4kdn74390986309863epsmtrp22;
        Fri, 25 Nov 2022 16:56:48 +0000 (GMT)
X-AuditID: b6c32a49-a41ff700000006ae-cb-6380f3d04e83
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        6D.88.18644.0D3F0836; Sat, 26 Nov 2022 01:56:48 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221125165646epsmtip21aed4aef02e1bbe5a6e82d093a468278~q4kcGYgHg3214732147epsmtip2J;
        Fri, 25 Nov 2022 16:56:46 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Lee Jones'" <lee@kernel.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>
Cc:     "'Sriranjani P'" <sriranjani.p@samsung.com>,
        "'Chanho Park'" <chanho61.park@samsung.com>,
        "'Sam Protsenko'" <semen.protsenko@linaro.org>
In-Reply-To: <20221125112201.240178-2-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 2/4] dt-bindings: soc: samsung: exynos-sysreg: split
 from syscon
Date:   Fri, 25 Nov 2022 22:26:45 +0530
Message-ID: <01a401d900ee$e8150b50$b83f21f0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQIt87tfTwup8v8WQwS48SHvnyDBrAMTnK5UAdyyr/6tfnKu4A==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmlu6Fzw3JBv+u6lhc3q9tMf/IOVaL
        vhcPmS32vt7KbrGjbSGLxabH11gtLu+aw2Yx4/w+JovWvUfYLZ73AVm336xjdeD22LSqk83j
        zrU9bB6bl9R79G1ZxejxeZNcAGtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5
        kkJeYm6qrZKLT4CuW2YO0GFKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKTAr3i
        xNzi0rx0vbzUEitDAwMjU6DChOyMY3OzC+7LVex4f5O5gXGaZBcjJ4eEgInEpsntjF2MXBxC
        ArsZJWYuucMM4XxilGidMIkVwvnMKLFizzpmmJYf7auYQGwhgV2MEv8fWUMUvWSUePP/AhtI
        gk1AV2LH4jY2kISIwCUmiXdvJ4CNYhboY5RY9XoRSxcjOwengKvE/1yQemGBMInWjd0sIDaL
        gKrEn3eXGUFsXgFLiS0z77NC2IISJ2c+AathFpCX2P52DtRBChI/ny5jhYiLS7w8eoQdxBYR
        cJLYue072G8SAjs4JHavng7V4CKx6P9dFghbWOLV8S3sELaUxOd3e4GO5gCyPSQW/ZGCCGdI
        vF2+nhHCtpc4cGUOC0gJs4CmxPpd+hBr+SR6fz9hgujklehoE4KoVpVofncVapG0xMTublYI
        20Pi3snH7BMYFWcheWwWksdmIXlmFsKyBYwsqxglUwuKc9NTi00LDPNSy+GxnZyfu4kRnGi1
        PHcw3n3wQe8QIxMH4yFGCQ5mJRHehOMNyUK8KYmVValF+fFFpTmpxYcYTYGhPZFZSjQ5H5jq
        80riDU0sDUzMzMxMLI3NDJXEeRfP0EoWEkhPLEnNTk0tSC2C6WPi4JRqYBIIdvB1XTlBt1Bx
        xqm31yd9Cwx/9m6T6qSFXBnFa6wMVi8QyOEtv3t97YHV//uiYmJPsHzTXrQ1bb7WuT31vdN7
        TuctiNG8VH5i/9r8Uusa3oc6h+wdTv2t7GTaMuW3z8mZ6/r0v6t6TEyb96UtuL7cz39S8JyP
        Fxl1oly9uT7dqb+y6FjaiRmn1LxmyCdHmnReTzjO1++z6O4ES0tVllc2J7PWTezNXPmiYQXD
        Z7fXfptrL/RMOrAia8Kq3y9OcFUa1F1m0ezcwHh6qvqOzefsNnxXnxsjLv7tyaaYP5vXJCec
        XJQZpNjmwlHst/znVXn1tni+S5ccN8hZ8a3/t+xewwq9Qt2PVZ3Tg1/XfL6nxFKckWioxVxU
        nAgAbHrlNj0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWy7bCSvO6Fzw3JBsvOsltc3q9tMf/IOVaL
        vhcPmS32vt7KbrGjbSGLxabH11gtLu+aw2Yx4/w+JovWvUfYLZ73AVm336xjdeD22LSqk83j
        zrU9bB6bl9R79G1ZxejxeZNcAGsUl01Kak5mWWqRvl0CV8axudkF9+Uqdry/ydzAOE2yi5GT
        Q0LAROJH+yqmLkYuDiGBHYwSl75tZ4FISEtc3ziBHcIWllj57zk7RNFzRokLZ8+AJdgEdCV2
        LG5jA0mICNxgkpi95hYLiMMsMIFRYtuCj4wQLecZJVa2nATKsHNwCrhK/M8FaRYWCJFY332N
        FcRmEVCV+PPuMiOIzStgKbFl5n1WCFtQ4uTMJ0CdHEAz9STaNoKVMAvIS2x/O4cZ4jgFiZ9P
        l7FCxMUlXh49AnabiICTxM5t3xknMArPQjJpFsKkWUgmzULSvYCRZRWjZGpBcW56brFhgVFe
        arlecWJucWleul5yfu4mRnC8aWntYNyz6oPeIUYmDsZDjBIczEoivAnHG5KFeFMSK6tSi/Lj
        i0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYGLPts4/29IcsuV7gMqhPOOS
        +aYlqluuSJ9iZD6mL/An9fkT5bubAw9cur326dnAaMdTh7Le/Dw9f8pxn387uP/uXLtpIuuF
        3OtFM9vk9xlbpPr6z/BUc7FuVq1ZxX/u1oe1zCc/5i6M7SldnDFvvwk7j8u/hcdizT32eD1v
        vZhW8jBM5dUL87tn2cwbP9Tdtm8pv/HgM6ufsdBfHec7PD/5Nl488N12eob/drWMhdZzzR50
        f8z6s67h4qa3eZ9Slpz56uV7JWYDu1z5tOLbtwXLqySvu1w8osu8+Ie6k3FsYGFA9/MJKrsq
        xRfcLwua7arr2BqUIHCg2GvCJrf7DJvVf6bn708stHp7ZpZTWq4SS3FGoqEWc1FxIgAKzM0F
        JgMAAA==
X-CMS-MailID: 20221125165648epcas5p324203ea005c991ee26b830abeb4b98c3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221125112238epcas5p1fb32a08855354b6264f5ee9451c25519
References: <20221125112201.240178-1-krzysztof.kozlowski@linaro.org>
        <CGME20221125112238epcas5p1fb32a08855354b6264f5ee9451c25519@epcas5p1.samsung.com>
        <20221125112201.240178-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
>Sent: Friday, November 25, 2022 4:52 PM
>To: Lee Jones <lee@kernel.org>; Rob Herring <robh+dt@kernel.org>;
>Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Alim Akhtar
><alim.akhtar@samsung.com>; devicetree@vger.kernel.org; linux-
>kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>samsung-soc@vger.kernel.org
>Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>; Sriranjani P
><sriranjani.p@samsung.com>; Chanho Park <chanho61.park@samsung.com>;
>Sam Protsenko <semen.protsenko@linaro.org>
>Subject: [PATCH 2/4] dt-bindings: soc: samsung: exynos-sysreg: split from
>syscon
>
>Split Samsung Exynos SoC SYSREG bindings to own file to narrow the bindings
>and do not allow other parts of syscon.yaml.  This allows further
customization
>of Samsung SoC bindings.
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
>---
>
>Cc: Sriranjani P <sriranjani.p@samsung.com>
>Cc: Chanho Park <chanho61.park@samsung.com>
>Cc: Sam Protsenko <semen.protsenko@linaro.org>
>---
> .../devicetree/bindings/mfd/syscon.yaml       |  6 ---
> .../soc/samsung/samsung,exynos-sysreg.yaml    | 39
>+++++++++++++++++++
> 2 files changed, 39 insertions(+), 6 deletions(-)  create mode 100644
>Documentation/devicetree/bindings/soc/samsung/samsung,exynos-
>sysreg.yaml
>
>diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml
>b/Documentation/devicetree/bindings/mfd/syscon.yaml
>index 1b01bd010431..b73ba1ea08f7 100644
>--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
>+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
>@@ -64,12 +64,6 @@ properties:
>               - rockchip,rk3568-qos
>               - rockchip,rk3588-qos
>               - rockchip,rv1126-qos
>-              - samsung,exynos3-sysreg
>-              - samsung,exynos4-sysreg
>-              - samsung,exynos5-sysreg
>-              - samsung,exynos5433-sysreg
>-              - samsung,exynos850-sysreg
>-              - samsung,exynosautov9-sysreg
>
>           - const: syscon
>
>diff --git
>a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-
>sysreg.yaml
>b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-
>sysreg.yaml
>new file mode 100644
>index 000000000000..68064a5e339c
>--- /dev/null
>+++ b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-
>sysre
>+++ g.yaml
>@@ -0,0 +1,39 @@
>+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause %YAML 1.2
>+---
>+$id:
>+https://protect2.fireeye.com/v1/url?k=66a4ea1d-393fd378-66a56152-
>000bab
>+ff32e3-46dd8d7834263379&q=1&e=0e7cbbb5-e02f-4452-b6ad-
>5f17f37da091&u=ht
>+tp%3A%2F%2Fdevicetree.org%2Fschemas%2Fsoc%2Fsamsung%2Fsamsung
>%2Cexynos-
>+sysreg.yaml%23
>+$schema:
>+https://protect2.fireeye.com/v1/url?k=0bf71500-546c2c65-0bf69e4f-000bab
>+ff32e3-2ad7163b19d3c132&q=1&e=0e7cbbb5-e02f-4452-b6ad-
>5f17f37da091&u=ht
>+tp%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23
>+
>+title: Samsung Exynos SoC series System Registers (SYSREG)
>+
>+maintainers:
>+  - Krzysztof Kozlowski <krzk@kernel.org>
>+
>+properties:
>+  compatible:
>+    oneOf:
>+      - items:
>+          - enum:
>+              - samsung,exynos3-sysreg
>+              - samsung,exynos4-sysreg
>+              - samsung,exynos5-sysreg
>+              - samsung,exynos5433-sysreg
>+              - samsung,exynos850-sysreg
>+              - samsung,exynosautov9-sysreg
>+          - const: syscon
>+
>+  reg:
>+    maxItems: 1
>+
>+required:
>+  - compatible
>+  - reg
>+
>+additionalProperties: false
>+
>+examples:
>+  - |
>+    system-controller@10010000 {
>+        compatible = "samsung,exynos4-sysreg", "syscon";
>+        reg = <0x10010000 0x400>;
>+    };
>--
>2.34.1


