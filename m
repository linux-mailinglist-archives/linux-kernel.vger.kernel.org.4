Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC89069381C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 16:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjBLPlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 10:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjBLPld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 10:41:33 -0500
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8ED12583;
        Sun, 12 Feb 2023 07:41:33 -0800 (PST)
Received: from robin.home.jannau.net (p579ad32f.dip0.t-ipconnect.de [87.154.211.47])
        by soltyk.jannau.net (Postfix) with ESMTPSA id C545D26F77C;
        Sun, 12 Feb 2023 16:41:31 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Subject: [PATCH 07/17] dt-bindings: iommu: apple,sart: Add apple,t8112-sart compatible string
Date:   Sun, 12 Feb 2023 16:41:17 +0100
Message-Id: <20230202-asahi-t8112-dt-v1-7-cb5442d1c229@jannau.net>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
References: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1211; i=j@jannau.net; h=from:subject:message-id; bh=behPg4aqpLIrrMH961E72k3iDwv6hRfXJBOGGtz768o=; b=owGbwMvMwCG2UNrmdq9+ahrjabUkhuSX7Cf4X0YsM642XdA5x2bKI/nFe7c2fZ7wvFHZM+dA6 rqnR1UedZSyMIhxMMiKKbIkab/sYFhdoxhT+yAMZg4rE8gQBi5OAZiIxQ9GhhXTr/5Z1xPnzVzg /idBNK/VQVvsQsSMj/LP/Qy+yEj+P8HwT1V2ydoI7lIev97pGzj0SxWeTt/75mXexMeXP1fxuHx T4wYA
X-Developer-Key: i=j@jannau.net; a=openpgp; fpr=8B336A6BE4E5695E89B8532B81E806F586338419
Content-Transfer-Encoding: 8bit
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
This trivial dt-bindings update should be merged through the asahi-soc
tree to ensure validation of the Apple M2 (t8112) devicetrees in this
series.
---
 Documentation/devicetree/bindings/iommu/apple,sart.yaml | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/apple,sart.yaml b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
index 1524fa3094ef..07d2d68a87df 100644
--- a/Documentation/devicetree/bindings/iommu/apple,sart.yaml
+++ b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
@@ -28,9 +28,14 @@ description:
 
 properties:
   compatible:
-    enum:
-      - apple,t6000-sart
-      - apple,t8103-sart
+    oneOf:
+      - items:
+          - const: apple,t8112-sart
+          - const: apple,t6000-sart
+      - items:
+          enum:
+            - apple,t6000-sart
+            - apple,t8103-sart
 
   reg:
     maxItems: 1

-- 
2.39.1

