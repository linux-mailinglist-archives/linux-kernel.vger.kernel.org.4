Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADA96456A8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 10:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiLGJhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 04:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiLGJhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:37:07 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0433E41990
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 01:37:02 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221207093701epoutp04f3975b4a00dd37c1d582b7828aac0f29~ueT59qJvf0756807568epoutp04c
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 09:37:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221207093701epoutp04f3975b4a00dd37c1d582b7828aac0f29~ueT59qJvf0756807568epoutp04c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670405821;
        bh=8CoUo2GDekukmV9hqwQXTpIwsJjED3+WdDv5hlzQWZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d82SXM5XmEfbtZ2bkc20ddJYWjC/wevOxjiDPKjbmYW8RVTd6xEsPixE73+zaMc8+
         DOwa95gRoo9FRf6LD5lt46q2aMWU6xvqSGXL3eC5SxajHTvm3jVon3amdcW6H1CNhI
         JRfXepd/esD7o1vPNh8kbWif+DwOubMjqHJ7T/Z8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221207093700epcas5p1f3767598e0aeb2d30b3efae1e4d9491e~ueT5pgzhl1731417314epcas5p1K;
        Wed,  7 Dec 2022 09:37:00 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4NRscq1cPHz4x9Pq; Wed,  7 Dec
        2022 09:36:59 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EF.3A.56352.BBE50936; Wed,  7 Dec 2022 18:36:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221207085852epcas5p3de090e5b0abec213c1b5511e1da3eeff~udymTbsa20542405424epcas5p3z;
        Wed,  7 Dec 2022 08:58:52 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221207085852epsmtrp2746d3234807963bd555678f1f832f9a5~udymSr1323113231132epsmtrp2R;
        Wed,  7 Dec 2022 08:58:52 +0000 (GMT)
X-AuditID: b6c32a4b-383ff7000001dc20-02-63905ebb94d2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        87.57.14392.CC550936; Wed,  7 Dec 2022 17:58:52 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221207085850epsmtip19577055692d25ddbc3d6e236c9d5d8f2~udyk2QggV2541625416epsmtip1Q;
        Wed,  7 Dec 2022 08:58:50 +0000 (GMT)
From:   Sriranjani P <sriranjani.p@samsung.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, alim.akhtar@samsung.com,
        pankaj.dubey@samsung.com, ravi.patel@samsung.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Sriranjani P <sriranjani.p@samsung.com>
Subject: [PATCH 3/4] dt-bindings: soc: samsung: exynos-sysreg: add dedicated
 SYSREG compatibles to Exynosautov9
Date:   Wed,  7 Dec 2022 14:28:31 +0530
Message-Id: <20221207085832.86909-4-sriranjani.p@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221207085832.86909-1-sriranjani.p@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsWy7bCmlu7uuAnJBs86OC0ezNvGZjH/yDlW
        i74XD5ktNj2+xmpxedccNosZ5/cxWSza+oXd4uGHPewWrXuPsFvcfrOO1YHLY9OqTjaPO9f2
        sHlsXlLv0bdlFaPH501yAaxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5
        ibmptkouPgG6bpk5QEcpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OL
        S/PS9fJSS6wMDQyMTIEKE7IzZr81L9jKU9H87B5TA+N0zi5GDg4JAROJXwsNuxi5OIQEdjNK
        tM/rZIVwPjFKtJ77yw7hfGOU6Fj1lqmLkROs4+ihqUwQib2MEj/n72OGcFqZJJZtnM0IUsUm
        oCvReu0zWJWIwBKgWd27GEEcZoEpjBLHfi0DqxIWKJR4d2MOE8glLAKqErd/m4KEeQVsJTZ9
        nMACsU5eYvWGA8wgNqeAncS3HS1sEPF77BITHrlC2C4S+ydsZoewhSVeHd8CZUtJfH63F6o+
        XWLzkc2sEHaOREdTMzOEbS9x4MocFpATmAU0Jdbv0ocIy0pMPbUO7GNmAT6J3t9PoL7nldgx
        D8ZWk1j8qBPKlpFY++gTKyRMPSQuPnaFhMlERoln70+yTGCUm4WwYQEj4ypGydSC4tz01GLT
        AuO81HJ4nCXn525iBCc7Le8djI8efNA7xMjEwXiIUYKDWUmE98XG3mQh3pTEyqrUovz4otKc
        1OJDjKbA0JvILCWanA9Mt3kl8YYmlgYmZmZmJpbGZoZK4rxLp3QkCwmkJ5akZqemFqQWwfQx
        cXBKNTCF9hWua3n/+eRzuRm/z+TO3+optvPXYs/M2duTp92KS+50mO5TYNty9Ev8CVmenP5Q
        P3PmScEPi1tZC/rcH/TkVKaZPXcVzZsk2tm4WDq5bebm0L03tU4mHTLJnD97uf3ckzfaebtX
        sEzX4T9Wf5Sn75nq5Je/D9Wzbcy7OlH7cYPN5IAbUvr8Vatr+jWDI7Z9yCq0/hbz6+Ru+8MN
        +2oiLD+s2fF0a2J7r83+5NoPtT837r79eF/B3+5Vq/R3P7M+KfJA7t2Xe6sePtvg6ZnEHrW5
        cPmKVrOmDt4O/Zm9jlM2mM96YJC3oLeO3epAwcSwlxslshz232x//XOVpeHKeWV29y8ttO+4
        Hh1xZuNTJZbijERDLeai4kQAkjTxY/8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKLMWRmVeSWpSXmKPExsWy7bCSnO6Z0AnJBr9WsFs8mLeNzWL+kXOs
        Fn0vHjJbbHp8jdXi8q45bBYzzu9jsli09Qu7xcMPe9gtWvceYbe4/WYdqwOXx6ZVnWwed67t
        YfPYvKTeo2/LKkaPz5vkAlijuGxSUnMyy1KL9O0SuDJmvzUv2MpT0fzsHlMD43TOLkZODgkB
        E4mjh6YydTFycQgJ7GaUmHP9IjtEQkbi5IMlzBC2sMTKf8/ZIYqamSSaWu6ygiTYBHQlWq99
        BusWEVjFKHHmEcQoZoEZjBJLl55hA6kSFsiXOD61AaiDg4NFQFXi9m9TkDCvgK3Epo8TWCA2
        yEus3nAAbBungJ3Etx0tYK1CQDX3Hi5nm8DIt4CRYRWjZGpBcW56brFhgWFearlecWJucWle
        ul5yfu4mRnBIamnuYNy+6oPeIUYmDsZDjBIczEoivC829iYL8aYkVlalFuXHF5XmpBYfYpTm
        YFES573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwKQY5jSta9cO5hDf72kPTE7u2CdpyOJ36E78
        DeFH6x1PqPxi8zc8PiVzy+493pOqQ0Tf3Pga6Nn/8H571MSW3r59B2Zct/rq72P5r1PK+MDe
        L1sjXpXnP6lvLJE0TbJ3PyrR575t9/+HLLtMvvh8uas/S7iudP3OX/viHtve3XdtnVQvy73W
        s47vQ8OZUq46TFkdkOVV0Xw3ZhvjLZG/5fNNLn2qeSmlxLxjdX+aSallsmLrC/V+t9csf1/O
        jLrL4fxboa5K0tGOb19mxfGENav37Y/de1PzSf2WBz574qZNLLQIMr+697xt08mP2V92zm+Z
        VCo00Vtpj8TeC6a7JU7Z37TeeFPf2Tau1NnbnFOJpTgj0VCLuag4EQDvYWpLuAIAAA==
X-CMS-MailID: 20221207085852epcas5p3de090e5b0abec213c1b5511e1da3eeff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221207085852epcas5p3de090e5b0abec213c1b5511e1da3eeff
References: <20221207085832.86909-1-sriranjani.p@samsung.com>
        <CGME20221207085852epcas5p3de090e5b0abec213c1b5511e1da3eeff@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exynosautov9 has several different SYSREGs, so use dedicated compatibles
for them and deprecate usage of generic Exynosautov9 compatible alone.

Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
---
 .../bindings/soc/samsung/samsung,exynos-sysreg.yaml  | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
index f57bc7c194a1..b6105d261b47 100644
--- a/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/samsung,exynos-sysreg.yaml
@@ -17,7 +17,6 @@ properties:
               - samsung,exynos3-sysreg
               - samsung,exynos4-sysreg
               - samsung,exynos5-sysreg
-              - samsung,exynosautov9-sysreg
               - tesla,fsd-cam-sysreg
               - tesla,fsd-fsys0-sysreg
               - tesla,fsd-fsys1-sysreg
@@ -45,6 +44,17 @@ properties:
           - const: samsung,exynos850-sysreg
           - const: syscon
         deprecated: true
+      - items:
+          - enum:
+              - samsung,exynosautov9-fsys2-sysreg
+              - samsung,exynosautov9-peric0-sysreg
+              - samsung,exynosautov9-peric1-sysreg
+          - const: samsung,exynosautov9-sysreg
+          - const: syscon
+      - items:
+          - const: samsung,exynosautov9-sysreg
+          - const: syscon
+        deprecated: true
 
   reg:
     maxItems: 1
-- 
2.17.1

