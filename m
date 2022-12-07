Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0165964585B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 11:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiLGK7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 05:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiLGK6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 05:58:51 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24C72497E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 02:58:46 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221207105844epoutp044ee8c795fe66d89cebfb25a2e933e031~ufbQt0DTY1326113261epoutp04W
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 10:58:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221207105844epoutp044ee8c795fe66d89cebfb25a2e933e031~ufbQt0DTY1326113261epoutp04W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670410724;
        bh=yhlSsXDIPk3UQpWGJmA5ZRR7ty2+JKHG8HOE6eTzSLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r4uaDFoTRrrJseqMO+We6DQLKYu+mdUUWX1jXXBS6qyfdSsbysrCSbAlmEa/vLcrh
         gVohnPJv+sxsWtqRAMgHXS8gVnQ9AZSpfuPkwYLtZhjRkH/HDgdYCcnTPp/HZhcQSU
         mr5seswOwvhhBPftmJ0B8f2Jc6PHVJnGg2srw01I=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221207105844epcas5p4e354596f2c2db9b903042e1bb8a82c52~ufbQcqUf40192501925epcas5p4J;
        Wed,  7 Dec 2022 10:58:44 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4NRvR62pWRz4x9Pv; Wed,  7 Dec
        2022 10:58:42 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E1.7B.56352.2E170936; Wed,  7 Dec 2022 19:58:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221207105043epcas5p306086213835a5287f39de9016dcd43d2~ufUQzywVW0089900899epcas5p39;
        Wed,  7 Dec 2022 10:50:43 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221207105043epsmtrp28cfda3319b3203b2dac871c2d106ed33~ufUQzGrwv0073900739epsmtrp2r;
        Wed,  7 Dec 2022 10:50:43 +0000 (GMT)
X-AuditID: b6c32a4b-383ff7000001dc20-0a-639071e2a974
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1D.4C.18644.30070936; Wed,  7 Dec 2022 19:50:43 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221207105042epsmtip1cfd98a3a0aafaede9c5808628e29b42a~ufUPXApu82633226332epsmtip1b;
        Wed,  7 Dec 2022 10:50:42 +0000 (GMT)
From:   Sriranjani P <sriranjani.p@samsung.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, alim.akhtar@samsung.com,
        pankaj.dubey@samsung.com, ravi.patel@samsung.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Sriranjani P <sriranjani.p@samsung.com>
Subject: [PATCH v2 1/4] dt-bindings: soc: samsung: exynos-sysreg: add
 dedicated SYSREG compatibles to Exynos850
Date:   Wed,  7 Dec 2022 16:20:29 +0530
Message-Id: <20221207105032.103510-2-sriranjani.p@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221207105032.103510-1-sriranjani.p@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAKsWRmVeSWpSXmKPExsWy7bCmlu6jwgnJBg/7RSwezNvGZjH/yDlW
        i74XD5ktNj2+xmpxedccNosZ5/cxWSza+oXd4uGHPewWrXuPsFvcfrOO1YHLY9OqTjaPO9f2
        sHlsXlLv0bdlFaPH501yAaxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5
        ibmptkouPgG6bpk5QEcpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OL
        S/PS9fJSS6wMDQyMTIEKE7Iznj4+w1Lwma/i/cE5zA2MW7m6GDk5JARMJBa3/GfqYuTiEBLY
        zSixeMdGdgjnE6PE7lPLoZzPjBILW+6wwrQsOHSZDSKxi1Hi269PUFWtTBIXOz6BVbEJ6Eq0
        XvsMNlhEYAmjRGv3LkYQh1lgCqPEsV/LGEGqhAUKJabPesUMYrMIqErc2bwRzOYVsJNoOHGT
        BWKfvMTqDQfA4pwC9hIXlj5iBhkkIXCPXWJt33egIg4gx0Xi+6V6iHphiVfHt7BD2FISn9/t
        ZYOw0yU2H9kM9UOOREdTMzOEbS9x4MocsDHMApoS63fpQ4RlJaaeWscEYjML8En0/n7CBBHn
        ldgxD8ZWk1j8qBPKlpFY++gT1HgPie9nj0JDZRKjxMVbj5kmMMrNQlixgJFxFaNkakFxbnpq
        sWmBcV5qOTzekvNzNzGCk56W9w7GRw8+6B1iZOJgPMQowcGsJML7YmNvshBvSmJlVWpRfnxR
        aU5q8SFGU2D4TWSWEk3OB6bdvJJ4QxNLAxMzMzMTS2MzQyVx3qVTOpKFBNITS1KzU1MLUotg
        +pg4OKUamMRdlv9rc0jUquISKD4QWB37QktL3664IrjV79ZGhrmtpxg727WizndxOG2wd1it
        HaEmwmFltnSP5KzSGzJ/f0SynqljPPV4ztqypX224SsuHdU5sSR6uufm9UtdjVpeRd4wbHdO
        6e/ynud8X/j9Dou8DVuPXt7U1B6VpxS1z6FCjHH6kqeTmYVVIoQLXZ8qTDf+/XfJimWOgkeD
        76ucDbn6ojqixbTWaElm6PovWkElaqErmZp2x1lv5ZzuUf+wJVDqs7HCeoXKSpkn6R8NGsIY
        JidnlTLPj9t0OyDnn2qm7M/V05b2LG9fnDHR6mx5l6bsu6/akp/uWiobqT0oj2CZm3TvquMO
        qUlVU7qVWIozEg21mIuKEwHhu7ybAwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOLMWRmVeSWpSXmKPExsWy7bCSnC5zwYRkg20/FC0ezNvGZjH/yDlW
        i74XD5ktNj2+xmpxedccNosZ5/cxWSza+oXd4uGHPewWrXuPsFvcfrOO1YHLY9OqTjaPO9f2
        sHlsXlLv0bdlFaPH501yAaxRXDYpqTmZZalF+nYJXBlPH59hKfjMV/H+4BzmBsatXF2MnBwS
        AiYSCw5dZuti5OIQEtjBKHGhdw0zREJG4uSDJVC2sMTKf8/ZIYqamSTuLWoCS7AJ6Eq0XvvM
        BJIQEVjFKHHm0VQwh1lgBqPE0qVn2ECqhAXyJTYduswOYrMIqErc2bwRrJtXwE6i4cRNFogV
        8hKrNxwAi3MK2EtcWPoIzBYCqtm1YgfbBEa+BYwMqxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS
        9ZLzczcxgsNSS2sH455VH/QOMTJxMB5ilOBgVhLhfbGxN1mINyWxsiq1KD++qDQntfgQozQH
        i5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGJlvd2HW37bcc+q/jpDfl16XpigsFWRim3bGW
        mSKfmTbVaX+z5oOb7JNdDlzb/Sbishr7mn+tCzacnnSPp6CI+5qcjkIu/5X0TYUFhQFPZkfN
        X3qjuuzSiQP+FTz32dYfq0w4faZK0nl7r1t0huPf9pJZe2Y4uDl4/P1sonuS//VcjhtbDfYb
        zNjW0V00iyO+Wf5a28ezgQLp3m/qLq1UOnnqvphjR61x2eL5BSL7KpiYlh0I222m37/g7Lod
        N93CeD/m3M68/n6BhVxflvfFd3ND1fYUzp+2kdNM20G4583S7OzHn6ebnFicOjE+7d/2bK7g
        vNuGok/CJ9ZtYXj0/lOz5N9/nvtvrGjisHq656cSS3FGoqEWc1FxIgARgX1gugIAAA==
X-CMS-MailID: 20221207105043epcas5p306086213835a5287f39de9016dcd43d2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221207105043epcas5p306086213835a5287f39de9016dcd43d2
References: <20221207105032.103510-1-sriranjani.p@samsung.com>
        <CGME20221207105043epcas5p306086213835a5287f39de9016dcd43d2@epcas5p3.samsung.com>
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
index 4954790eda6c..a37452965100 100644
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
+              - const: samsung,exynos5433-sysreg
+              - const: samsung,exynos850-sysreg
+              - const: syscon
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

