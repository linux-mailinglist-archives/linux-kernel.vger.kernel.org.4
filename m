Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97BF693803
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 16:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjBLPlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 10:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBLPla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 10:41:30 -0500
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0F3CA3D;
        Sun, 12 Feb 2023 07:41:29 -0800 (PST)
Received: from robin.home.jannau.net (p579ad32f.dip0.t-ipconnect.de [87.154.211.47])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 4A2A226F776;
        Sun, 12 Feb 2023 16:41:28 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/17] dt-bindings: power: apple,pmgr-pwrstate: Add t8112 compatible
Date:   Sun, 12 Feb 2023 16:41:11 +0100
Message-Id: <20230202-asahi-t8112-dt-v1-1-cb5442d1c229@jannau.net>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
References: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1525; i=j@jannau.net; h=from:subject:message-id; bh=n7yL/QDtU43Wl5Tm9zGg0PPtP+ZxPi+QYS5i4Gj7DUs=; b=owGbwMvMwCG2UNrmdq9+ahrjabUkhuSX7MdDAw2Lq9K5U0NvRC9siGdxzLiyf7OifrDVyfdSi nn/N6d2lLIwiHEwyIopsiRpv+xgWF2jGFP7IAxmDisTyBAGLk4BmMhjPkaGJTqrmTa6KV+8fDGN rX/V8za51TxuE6udk9fNt++K5lHkBaqoqTicLh+aHN15YIJ/fr/PTse6K1cfCZ6sDJG8O3fjE1Y A
X-Developer-Key: i=j@jannau.net; a=openpgp; fpr=8B336A6BE4E5695E89B8532B81E806F586338419
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hector Martin <marcan@marcan.st>

Add the apple,t8112-pmgr-pwrstate compatible for the Apple M2 SoC.

This goes after t8103. The sort order logic here is having SoC numeric
code families in release order, and SoCs within each family in release
order:

- t8xxx (Apple HxxP/G series, "phone"/"tablet" chips)
  - t8103 (Apple H13G/M1)
  - t8112 (Apple H14G/M2)
- t6xxx (Apple HxxJ series, "desktop" chips)
  - t6000 (Apple H13J(S)/M1 Pro)
  - t6001 (Apple H13J(C)/M1 Max)
  - t6002 (Apple H13J(D)/M1 Ultra)

Note that t600[0-2] share the t6000 compatible where the hardware is
100% compatible, which is usually the case in this highly related set
of SoCs.

Signed-off-by: Hector Martin <marcan@marcan.st>

---
This trivial dt-bindings update should be merged through the asahi-soc
tree to ensure validation of the Apple M2 (t8112) devicetrees in this
series.
---
 Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
index 94d369eb85de..59a6af735a21 100644
--- a/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
+++ b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
@@ -32,6 +32,7 @@ properties:
     items:
       - enum:
           - apple,t8103-pmgr-pwrstate
+          - apple,t8112-pmgr-pwrstate
           - apple,t6000-pmgr-pwrstate
       - const: apple,pmgr-pwrstate
 

-- 
2.39.1

