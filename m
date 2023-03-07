Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD686ADE64
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 13:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjCGMKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 07:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjCGMKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 07:10:15 -0500
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECAD574F8;
        Tue,  7 Mar 2023 04:10:14 -0800 (PST)
Received: from robin.home.jannau.net (p54accbe8.dip0.t-ipconnect.de [84.172.203.232])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 8697226F88B;
        Tue,  7 Mar 2023 13:10:12 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
Date:   Tue, 07 Mar 2023 13:10:12 +0100
Subject: [PATCH v3 06/15] dt-bindings: iommu: apple,sart: Add
 apple,t8112-sart compatible string
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230202-asahi-t8112-dt-v3-6-d1a5f6383d95@jannau.net>
References: <20230202-asahi-t8112-dt-v3-0-d1a5f6383d95@jannau.net>
In-Reply-To: <20230202-asahi-t8112-dt-v3-0-d1a5f6383d95@jannau.net>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janne Grunau <j@jannau.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1092; i=j@jannau.net;
 h=from:subject:message-id; bh=SF0RulFge1KLXxYvCFPks4sDQS0ghvbAM8eYX/qWUvY=;
 b=owGbwMvMwCG2UNrmdq9+ahrjabUkhhR2zQUu7LeXcGj82rYoseHPxeUl81ZeqNUyCJrp0DJBb
 OIvp4llHaUsDGIcDLJiiixJ2i87GFbXKMbUPgiDmcPKBDKEgYtTACaSvpDhv/e3BVPOZ6oH/2sL
 ez3HX+I0M8+zN6JCi77NU34Vt5d3ozbDP4PGirOarQ9aZ06PPbTsWuPpJyZcM4o8P7pN0Kl7fei
 ULicA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"apple,t8112-sart" as found on the Apple M2 SoC appears to be SART3 as
well. To allow for later discovered incompatibilities use
'"apple,t8112-sart", "apple,t6000-sart"' as compatible string.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/iommu/apple,sart.yaml | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/apple,sart.yaml b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
index 1524fa3094ef..e87c1520fea6 100644
--- a/Documentation/devicetree/bindings/iommu/apple,sart.yaml
+++ b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
@@ -28,9 +28,13 @@ description:
 
 properties:
   compatible:
-    enum:
-      - apple,t6000-sart
-      - apple,t8103-sart
+    oneOf:
+      - items:
+          - const: apple,t8112-sart
+          - const: apple,t6000-sart
+      - enum:
+          - apple,t6000-sart
+          - apple,t8103-sart
 
   reg:
     maxItems: 1

-- 
2.39.2

