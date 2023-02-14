Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88196961D4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbjBNLEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjBNLE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:04:28 -0500
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F7425B90;
        Tue, 14 Feb 2023 03:04:07 -0800 (PST)
Received: from robin.home.jannau.net (p579ad32f.dip0.t-ipconnect.de [87.154.211.47])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 49F8126F797;
        Tue, 14 Feb 2023 12:04:04 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
Date:   Tue, 14 Feb 2023 12:03:21 +0100
Subject: [PATCH v2 08/16] dt-bindings: nvme: apple: Add
 apple,t8112-nvme-ans2 compatible string
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230202-asahi-t8112-dt-v2-8-22926a283d92@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1206; i=j@jannau.net;
 h=from:subject:message-id; bh=BnVG0wAdil1oj+bMWBydPENm7hlDIX32bb1ZtcztMcw=;
 b=owGbwMvMwCG2UNrmdq9+ahrjabUkhuTXWfMPsGiezXlzvHlysmjsqW0ZW2VtDa9HBryx5NxU/
 Z7vUuK8jlIWBjEOBlkxRZYk7ZcdDKtrFGNqH4TBzGFlAhnCwMUpABPpz2Vk6I7W++g9yS+1xUzz
 0ZJy5ccFQofLZvLt4RCV/qx233V5PCPD7Pt1FgdbNnD+j9h7fv45//vsuno7g05NY3Td/1Popul
 qbgA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"apple,t8112-nvme-ans2" as found on Apple M2 SoCs is compatible with the
existing driver. Add its SoC specific compatible string to allow special
handling if it'll be necessary.
t8112 uses only 2 power-domains as no 4 and 8 TB configurations are
offered.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
index 34dd1cc67124..fc6555724e18 100644
--- a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
+++ b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
@@ -14,6 +14,7 @@ properties:
     items:
       - enum:
           - apple,t8103-nvme-ans2
+          - apple,t8112-nvme-ans2
           - apple,t6000-nvme-ans2
       - const: apple,nvme-ans2
 
@@ -65,7 +66,9 @@ if:
   properties:
     compatible:
       contains:
-        const: apple,t8103-nvme-ans2
+        enum:
+          - apple,t8103-nvme-ans2
+          - apple,t8112-nvme-ans2
 then:
   properties:
     power-domains:

-- 
2.39.1

