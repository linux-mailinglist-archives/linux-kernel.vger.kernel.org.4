Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF0364569E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiLGJgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 04:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiLGJgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:36:51 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185F131DD8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 01:36:50 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221207093648epoutp036659f56d42de6d8d2c62bc62c1b3c244~ueTuUwOr40774007740epoutp03a
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 09:36:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221207093648epoutp036659f56d42de6d8d2c62bc62c1b3c244~ueTuUwOr40774007740epoutp03a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670405808;
        bh=CTA+WE23hQ9Bbu9shVvforMhAjMPGvQ6RIgEzLR2DYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L8AnrC+tV55KXIzYCOq4ntKCmON/ikT86laxmC//lcjToeZUOl538XR3myA8xN7q2
         k80CTiUg4AlzuB1GTiyK/lSt4E7EhR4R2qA1xY0jwsTZyAN3lz6ckHyHGJhsxDAdEO
         Lm5u/5q9xfZemf5FMl56b2GAxzqixy3+bB3fd8f4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20221207093648epcas5p22a6dbb7b75d57d8b41b495bf44217f73~ueTt79iVE2413524135epcas5p2c;
        Wed,  7 Dec 2022 09:36:48 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4NRscZ4j2Fz4x9Q1; Wed,  7 Dec
        2022 09:36:46 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        08.98.39477.EAE50936; Wed,  7 Dec 2022 18:36:46 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20221207085846epcas5p1d1e7fb6945752fc1d9d4aba4874b2484~udyg7EArk2642626426epcas5p1k;
        Wed,  7 Dec 2022 08:58:46 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221207085846epsmtrp211bb4b440a5bae8630fc6cf291f5c0e3~udyg6VaBy3113231132epsmtrp2H;
        Wed,  7 Dec 2022 08:58:46 +0000 (GMT)
X-AuditID: b6c32a4a-007ff70000019a35-23-63905eaea4d2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.92.18644.6C550936; Wed,  7 Dec 2022 17:58:46 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221207085844epsmtip167f6a6d0fddb4202e6caca7a45f4bf7d~udyfefP-E2358723587epsmtip1K;
        Wed,  7 Dec 2022 08:58:44 +0000 (GMT)
From:   Sriranjani P <sriranjani.p@samsung.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, alim.akhtar@samsung.com,
        pankaj.dubey@samsung.com, ravi.patel@samsung.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Sriranjani P <sriranjani.p@samsung.com>
Subject: [PATCH 1/4] dt-bindings: soc: samsung: exynos-sysreg: add dedicated
 SYSREG compatibles to Exynos850
Date:   Wed,  7 Dec 2022 14:28:29 +0530
Message-Id: <20221207085832.86909-2-sriranjani.p@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221207085832.86909-1-sriranjani.p@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7bCmlu66uAnJBtN/KFs8mLeNzWL+kXOs
        Fn0vHjJbbHp8jdXi8q45bBYzzu9jsli09Qu7xcMPe9gtWvceYbe4/WYdqwOXx6ZVnWwed67t
        YfPYvKTeo2/LKkaPz5vkAlijsm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTy
        EnNTbZVcfAJ03TJzgI5SUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YW
        l+al6+WlllgZGhgYmQIVJmRn/J18lLlgE1/FmtPPWBoYp3B1MXJySAiYSGxZtpYVxBYS2M0o
        8eNCYRcjF5D9iVFi6Zn1TBDOZ0aJR82/2bsYOcA6pn5IgojvYpSY8mkGO4TTyiTx49t7sFFs
        AroSrdc+g3WLCCxhlGjt3sUI4jALTGGUOPZrGSNIlbBAnsSpf1vAbBYBVYmpa/6ygNi8ArYS
        GzZ+ZoU4UF5i9YYDzCA2p4CdxLcdLWwQ8UfsEtumaUCc5CKxfKEQRFhY4tXxLewQtpTE53d7
        ocrTJTYf2Qw1Mkeio6mZGcK2lzhwZQ4LyBhmAU2J9bv0IcKyElNPrWMCsZkF+CR6fz9hgojz
        SuyYB2OrSSx+1Ally0isffQJaryHxMon3cyQQJnIKPFsxTuWCYxysxBWLGBkXMUomVpQnJue
        WmxaYJSXWg6PtOT83E2M4HSn5bWD8eGDD3qHGJk4GA8xSnAwK4nwvtjYmyzEm5JYWZValB9f
        VJqTWnyI0RQYfBOZpUST84EJN68k3tDE0sDEzMzMxNLYzFBJnHfplI5kIYH0xJLU7NTUgtQi
        mD4mDk6pBqa1py/t3V6+s+dgUX5vQRpfe0f4zWOnPwha5zmrbpWoXlFl0Sdo5hI6dVLexyn/
        HJhN5rIr9E27dy1qGbcCe4eoy91Jm848NC6NWnHFddmWv7W56qzOkyW2Z9/1np67ICXYOWnF
        x65lnWeU9VQzpkm38y706zr55NW/ilgp3UWH3LQYSzaZnk7OYQu/d/367xObF/k5rTxWtGhT
        UYTd1uW6WUeUJjM55S9SV/depiRQdPCLSizDkn180kyLElOY1wguE3EyPfHA/fq0B0HqxayK
        vy691j/kzXyg/zNjLv+va9V6LSKrkhjeMebNMY6V1i98UPO3Z31x3uHCtgcH7j8sPmO8NaXc
        dFJOayhvoRJLcUaioRZzUXEiAEBTRG0ABAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGLMWRmVeSWpSXmKPExsWy7bCSnO6x0AnJBhsni1k8mLeNzWL+kXOs
        Fn0vHjJbbHp8jdXi8q45bBYzzu9jsli09Qu7xcMPe9gtWvceYbe4/WYdqwOXx6ZVnWwed67t
        YfPYvKTeo2/LKkaPz5vkAlijuGxSUnMyy1KL9O0SuDL+Tj7KXLCJr2LN6WcsDYxTuLoYOTgk
        BEwkpn5I6mLk4hAS2MEoMWtzC1MXIydQXEbi5IMlzBC2sMTKf8/ZIYqamSQuH+sFK2IT0JVo
        vfaZCSQhIrCKUeLMo6lgDrPADEaJpUvPsIFUCQvkSHz+exCsg0VAVWLqmr8sIDavgK3Eho2f
        WSFWyEus3nAAbB2ngJ3Etx0tYL1CQDX3Hi5nm8DIt4CRYRWjZGpBcW56brFhgVFearlecWJu
        cWleul5yfu4mRnBQamntYNyz6oPeIUYmDsZDjBIczEoivC829iYL8aYkVlalFuXHF5XmpBYf
        YpTmYFES573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwJT8n/3OZpuf8662eHK6v2p39Gfw0mLu
        UwxiXqb6IuLjW8eJf3pXSvDyrDjspt8S6tS4dsuDA+lL1/489Cip2HLSvK7pNVu/i21Jv934
        ztlJMyJP68xjp/1qbrsjpAJYTl18aCu9XLbM87rzGoZ9+k6X57+60FO1bFvls1uz7q7UkP7w
        We5c5vvtlj45i2z3PJ64waTdj3n3hEU/ggpuroyYXuJ1OdW6+iTD1q6n3+SzZ9Rsi189v82a
        ZYX3n8MszSn/NQ/9X+erLrrm82uGjXVtv0/dqXa66LLF1kbXdvnKzZ7aHivjr7PO3th0c1Gc
        j7f5baWgt10s+qz8Vn/6E+dcSxZWOtn96M3J26fkblorsRRnJBpqMRcVJwIA8EAEFbkCAAA=
X-CMS-MailID: 20221207085846epcas5p1d1e7fb6945752fc1d9d4aba4874b2484
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221207085846epcas5p1d1e7fb6945752fc1d9d4aba4874b2484
References: <20221207085832.86909-1-sriranjani.p@samsung.com>
        <CGME20221207085846epcas5p1d1e7fb6945752fc1d9d4aba4874b2484@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exynos850 has two different SYSREGs, hence add dedicated compatibles for
them and deprecate usage of generic Exynos850 compatible alone.

Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
---
 .../soc/samsung/samsung,exynos-sysreg.yaml        | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
index 4954790eda6c..f57bc7c194a1 100644
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
@@ -36,6 +35,16 @@ properties:
           - const: samsung,exynos5433-sysreg
           - const: syscon
         deprecated: true
+      - items:
+          - enum:
+              - samsung,exynos850-cmgp-sysreg
+              - samsung,exynos850-peri-sysreg
+          - const: samsung,exynos850-sysreg
+          - const: syscon
+      - items:
+          - const: samsung,exynos850-sysreg
+          - const: syscon
+        deprecated: true
 
   reg:
     maxItems: 1
@@ -53,7 +62,9 @@ allOf:
         compatible:
           contains:
             enum:
-              - samsung,exynos850-sysreg
+              - samsung,exynos850-cmgp-sysreg
+              - samsung,exynos850-peri-sysreg
+            const: samsung,exynos850-sysreg
     then:
       required:
         - clocks
-- 
2.17.1

