Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044F269381D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 16:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjBLPlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 10:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjBLPlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 10:41:35 -0500
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7D71259A;
        Sun, 12 Feb 2023 07:41:33 -0800 (PST)
Received: from robin.home.jannau.net (p579ad32f.dip0.t-ipconnect.de [87.154.211.47])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 6217526F77D;
        Sun, 12 Feb 2023 16:41:32 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/17] dt-bindings: mailbox: apple,mailbox: Add t8112 compatibles
Date:   Sun, 12 Feb 2023 16:41:18 +0100
Message-Id: <20230202-asahi-t8112-dt-v1-8-cb5442d1c229@jannau.net>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
References: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1208; i=j@jannau.net; h=from:subject:message-id; bh=u2XW0UUQ4u8JUBUiVFVONT6wWAfsoR/YNQ8wVkAXQnA=; b=owGbwMvMwCG2UNrmdq9+ahrjabUkhuSX7CeYJkp9fxVkZjdtgsuFP8euzskIb15oevNIcGReq MfWhR5FHaUsDGIcDLJiiixJ2i87GFbXKMbUPgiDmcPKBDKEgYtTACZyP5bhD+9+x+pPbYKfpq2c Epc/VVzBoLDml0jrqwcpES/WP5Db/JmRof+N6hWOxA2JC/XnhJ78OVXxePiMJX8P8JlPCSyfUjX 5BAsA
X-Developer-Key: i=j@jannau.net; a=openpgp; fpr=8B336A6BE4E5695E89B8532B81E806F586338419
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mailbox hardware remains unchanged on M2 SoCs so just add its
per-SoC compatible.

Signed-off-by: Janne Grunau <j@jannau.net>

---
This trivial dt-bindings update should be merged through the asahi-soc
tree to ensure validation of the Apple M2 (t8112) devicetrees in this
series.
---
 Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
index 5c5c328b3134..4c0668e5f0bd 100644
--- a/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
@@ -29,6 +29,7 @@ properties:
         items:
           - enum:
               - apple,t8103-asc-mailbox
+              - apple,t8112-asc-mailbox
               - apple,t6000-asc-mailbox
           - const: apple,asc-mailbox-v4
 
@@ -39,6 +40,7 @@ properties:
         items:
           - enum:
               - apple,t8103-m3-mailbox
+              - apple,t8112-m3-mailbox
               - apple,t6000-m3-mailbox
           - const: apple,m3-mailbox-v2
 

-- 
2.39.1

