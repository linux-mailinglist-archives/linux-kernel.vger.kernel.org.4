Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88626961D2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbjBNLEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjBNLE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:04:28 -0500
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4662D265B2;
        Tue, 14 Feb 2023 03:04:07 -0800 (PST)
Received: from robin.home.jannau.net (p579ad32f.dip0.t-ipconnect.de [87.154.211.47])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 6550126F793;
        Tue, 14 Feb 2023 12:04:03 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
Date:   Tue, 14 Feb 2023 12:03:19 +0100
Subject: [PATCH v2 06/16] dt-bindings: iommu: apple,sart: Add
 apple,t8112-sart compatible string
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230202-asahi-t8112-dt-v2-6-22926a283d92@jannau.net>
References: <20230202-asahi-t8112-dt-v2-0-22926a283d92@jannau.net>
In-Reply-To: <20230202-asahi-t8112-dt-v2-0-22926a283d92@jannau.net>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1028; i=j@jannau.net;
 h=from:subject:message-id; bh=Am2hpYfuFFOIDC8gMQnR51jsehRvPYk6LpgtY9k4U4A=;
 b=owGbwMvMwCG2UNrmdq9+ahrjabUkhuTXWfMndfXlHLii9fVT+tlH5RNVEwWYVFlENn46+TBu6
 2tWk6apHaUsDGIcDLJiiixJ2i87GFbXKMbUPgiDmcPKBDKEgYtTACYSxsvIcJN93ln3at8Ze52u
 PU3WMtiyJ+ZBceK5bt6VrPYsx4NtWBl+s8QUP+WO7d1X9nWqtUncVNfuIBX+Js3pasJyWV+ruNf
 wAwA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"apple,t8112-sart" as found on the Apple M2 SoC appears to be SART3 as
well. To allow for later discovered incompatibilities use
'"apple,t8112-sart", "apple,t6000-sart"' as compatible string.

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
2.39.1

