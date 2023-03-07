Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5936ADE69
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 13:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjCGMKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 07:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjCGMKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 07:10:15 -0500
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61A5574FD;
        Tue,  7 Mar 2023 04:10:14 -0800 (PST)
Received: from robin.home.jannau.net (p54accbe8.dip0.t-ipconnect.de [84.172.203.232])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 6FA3A26F88D;
        Tue,  7 Mar 2023 13:10:13 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
Date:   Tue, 07 Mar 2023 13:10:14 +0100
Subject: [PATCH v3 08/15] dt-bindings: nvme: apple: Add
 apple,t8112-nvme-ans2 compatible string
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230202-asahi-t8112-dt-v3-8-d1a5f6383d95@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1270; i=j@jannau.net;
 h=from:subject:message-id; bh=fHBkvAY6XhNS/kXyTd3/WQYda6VSGxdD5gGv92wX0ao=;
 b=owGbwMvMwCG2UNrmdq9+ahrjabUkhhR2zQWRO9lkI1PuGm+QrNx1Wmp5KtOn5VO2WtxPPfXnd
 9H9+9kvO0pZGMQ4GGTFFFmStF92MKyuUYypfRAGM4eVCWQIAxenAExE5TPDH/4bE1fsyZQ57+bN
 a7wg863npS3aPlNcp9w899KWPdnxwg5GhqnCFhu3G1mzu7xY+39yXnPSb/UTh9S913/9EDnJQft
 oAzMA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
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

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
2.39.2

