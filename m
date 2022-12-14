Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A1C64C345
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 05:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237301AbiLNErl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 23:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237287AbiLNErf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 23:47:35 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA63E248F9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 20:47:33 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221214044732epoutp0115e9cbf1aa069b92c9b6ac26756e69d2~wj4J1DTju2974229742epoutp017
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 04:47:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221214044732epoutp0115e9cbf1aa069b92c9b6ac26756e69d2~wj4J1DTju2974229742epoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670993252;
        bh=+4XnDAvecmnygChVlYokd4C4SPrUM72pLX3mbpuCyZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OpQ+q4SJx7MbFUfrEpI2Ptjl/xo5lvmmZldmnYdVAaaVWu7t+dIkpzyBM7n7CYaCV
         cUD2scTBS6B+pgME8+7sWmM/9ZD2xNEHHJJHFntVc/AS7RPNdNJG00FVoSAppyLY8E
         aVyiwK/7O0WpB7RvATOnwJTAohkD02MHGGCaig8U=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221214044731epcas5p155926d78324d11e38282705e5e5da6e3~wj4JV97pT2260822608epcas5p1x;
        Wed, 14 Dec 2022 04:47:31 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4NX2sX3CTDz4x9Q1; Wed, 14 Dec
        2022 04:47:28 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        53.7F.56352.F5559936; Wed, 14 Dec 2022 13:47:27 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221214044423epcas5p2920e87930665345169745002ec6993c3~wj1Z_XQ7L1922319223epcas5p2R;
        Wed, 14 Dec 2022 04:44:23 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221214044423epsmtrp13ade7fc1d30de17dcbfa37bb22a10473~wj1Z9lCoH2887928879epsmtrp1C;
        Wed, 14 Dec 2022 04:44:23 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-88-6399555fb072
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CC.E9.18644.7A459936; Wed, 14 Dec 2022 13:44:23 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20221214044420epsmtip2b1ab384577994b787295874e45dd87b8~wj1XaVte02889728897epsmtip2d;
        Wed, 14 Dec 2022 04:44:20 +0000 (GMT)
From:   Sriranjani P <sriranjani.p@samsung.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, alim.akhtar@samsung.com,
        pankaj.dubey@samsung.com, ravi.patel@samsung.com,
        sathya@samsung.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sriranjani P <sriranjani.p@samsung.com>
Subject: [PATCH v3 1/4] dt-bindings: soc: samsung: exynos-sysreg: add
 dedicated SYSREG compatibles to Exynos850
Date:   Wed, 14 Dec 2022 10:13:39 +0530
Message-Id: <20221214044342.49766-2-sriranjani.p@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221214044342.49766-1-sriranjani.p@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMKsWRmVeSWpSXmKPExsWy7bCmhm586Mxkg9aJMhYP5m1js5h/5Byr
        Rd+Lh8wWmx5fY7W4vGsOm8WM8/uYLBZt/cJu8fDDHnaL1r1H2C2+HHnNaHH7zTpWB26PTas6
        2TzuXNvD5rF5Sb1H35ZVjB6fN8kFsEZl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpa
        WpgrKeQl5qbaKrn4BOi6ZeYAXaakUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAp
        0CtOzC0uzUvXy0stsTI0MDAyBSpMyM44/fwcc8FDvooFh24zNTCu5Opi5OSQEDCRWLR4B3MX
        IxeHkMBuRon2b5+hnE+MEhcuHWGCcD4zSry+vJoNpqXvZB8rRGIXo8SfbR8YIZxWJomVX+4x
        g1SxCehKtF77DNYuIrADqH3SATCHWWAKo0T3t/VA/RwcwgKFEid35oA0sAioSnz4OJUNJMwr
        YCux7Jg2xDZ5idUbDoDN5BSwk5jXNBtsjITAW3aJqWuvsEMUuUhc7ZrFDGELS7w6vgUqLiXx
        sr8Nyk6X2HxkMyuEnSPR0dQMVW8vceDKHBaQvcwCmhLrd+lDhGUlpp5axwRiMwvwSfT+fsIE
        EeeV2DEPxlaTWPyoE8qWkVj76BPUeA+Jh2fugsWFBCYySpxosZrAKDcLYcMCRsZVjJKpBcW5
        6anFpgXGeanl8FhLzs/dxAhOfVreOxgfPfigd4iRiYPxEKMEB7OSCK+qxrRkId6UxMqq1KL8
        +KLSnNTiQ4ymwOCbyCwlmpwPTL55JfGGJpYGJmZmZiaWxmaGSuK8S6d0JAsJpCeWpGanphak
        FsH0MXFwSjUw7ed51x2y7nl3b2W5RsJUhS2vomYtu+u/YCrvTul/hQkpPSdlHz78MS/frnXV
        gttyOfkxOxuZrbO+Pau7eteMJevKC5lKjmXJ7q3fy1gSN7NurXlSVrKinSeAwZCT95qZ4i95
        xalLP8mbLGItvhi0fu/1hobjOU+vXi7ifjQrOKZAjPPQu5LK6t0X43x++xYcFnw5+dih7fKr
        V0sdYHF54eMYbt8vnnOSZ8LxPZXXhXrXv3z5gqtKhGepOfun+wGOzSy/I1Mr5BY8zj5wdZum
        0wL5uHJNCWHfu7MeOv+e78Y/y97qrm1iAaPFqRNyM44yp8WffMm6+NoOs7CjTefXbo9aWbl9
        wZ5dbf9rvooLKbEUZyQaajEXFScCAK09McQGBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsWy7bCSvO7ykJnJBmeeiFg8mLeNzWL+kXOs
        Fn0vHjJbbHp8jdXi8q45bBYzzu9jsli09Qu7xcMPe9gtWvceYbf4cuQ1o8XtN+tYHbg9Nq3q
        ZPO4c20Pm8fmJfUefVtWMXp83iQXwBrFZZOSmpNZllqkb5fAlXH6+Tnmgod8FQsO3WZqYFzJ
        1cXIySEhYCLRd7KPFcQWEtjBKLG1zQsiLiNx8sESZghbWGLlv+fsXYxcQDXNTBLz1/9lAUmw
        CehKtF77zASSEBE4wCixu3cJI4jDLDCDUeLv+jmMIFXCAvkSEw5eBbNZBFQlPnycytbFyMHB
        K2ArseyYNsQGeYnVGw6AbeMUsJOY1zSbCeIiW4lNz+6yT2DkW8DIsIpRMrWgODc9t9iwwCgv
        tVyvODG3uDQvXS85P3cTIzg4tbR2MO5Z9UHvECMTB+MhRgkOZiURXlWNaclCvCmJlVWpRfnx
        RaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1MEUyiwhrmd/feSv8JKeSQL5y
        zFHjw5eXm06qly5r8rawunbpZIiH09zCyNVn77bO/GjHuau/znPbmeRfB7uvPC+d+MLmq6NL
        3FQZPdE7+W+P2TfyFpSEiufHLnTcudrl/5zXM0t49n7KWn1sqlDFg0n3Nk3p3FZY5DPPcdKD
        FVFedr+s/gZ8uLvouN/LF+v/vDg6UWip/Db3PZqZcw7PrWxNOXRi/ulZdTP3bpz1lp8ldrrw
        VbPg0Lj30z9pfetfqD1fqPBH6vHeF2ar9x57YFjjcODJUS6bc2pXzcze/ZN+YDzvlT7fSilN
        ef///nv6Txu12y+xksy6JC6S8XYbd46j/1a28JOGj2dfOameMKNWiaU4I9FQi7moOBEAGxja
        X70CAAA=
X-CMS-MailID: 20221214044423epcas5p2920e87930665345169745002ec6993c3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221214044423epcas5p2920e87930665345169745002ec6993c3
References: <20221214044342.49766-1-sriranjani.p@samsung.com>
        <CGME20221214044423epcas5p2920e87930665345169745002ec6993c3@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exynos850 has two different SYSREGs, hence add dedicated compatibles for
them and deprecate usage of generic Exynos850 compatible alone.

Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
---
 .../soc/samsung/samsung,exynos-sysreg.yaml        | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
index 4954790eda6c..427df05224e5 100644
--- a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
@@ -17,7 +17,6 @@ properties:
               - samsung,exynos3-sysreg
               - samsung,exynos4-sysreg
               - samsung,exynos5-sysreg
-              - samsung,exynos850-sysreg
               - samsung,exynosautov9-sysreg
               - tesla,fsd-cam-sysreg
               - tesla,fsd-fsys0-sysreg
@@ -33,9 +32,17 @@ properties:
           - const: samsung,exynos5433-sysreg
           - const: syscon
       - items:
-          - const: samsung,exynos5433-sysreg
+          - enum:
+              - samsung,exynos5433-sysreg
+              - samsung,exynos850-sysreg
+          - const: syscon
+            deprecated: true
+      - items:
+          - enum:
+              - samsung,exynos850-cmgp-sysreg
+              - samsung,exynos850-peri-sysreg
+          - const: samsung,exynos850-sysreg
           - const: syscon
-        deprecated: true
 
   reg:
     maxItems: 1
@@ -53,6 +60,8 @@ allOf:
         compatible:
           contains:
             enum:
+              - samsung,exynos850-cmgp-sysreg
+              - samsung,exynos850-peri-sysreg
               - samsung,exynos850-sysreg
     then:
       required:
-- 
2.17.1

