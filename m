Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38949693823
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 16:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjBLPmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 10:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjBLPln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 10:41:43 -0500
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8260212065;
        Sun, 12 Feb 2023 07:41:37 -0800 (PST)
Received: from robin.home.jannau.net (p579ad32f.dip0.t-ipconnect.de [87.154.211.47])
        by soltyk.jannau.net (Postfix) with ESMTPSA id E6F8126F78F;
        Sun, 12 Feb 2023 16:41:35 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: [PATCH 14/17] dt-bindings: sound: apple,mca: Add t8112-mca compatible
Date:   Sun, 12 Feb 2023 16:41:24 +0100
Message-Id: <20230202-asahi-t8112-dt-v1-14-cb5442d1c229@jannau.net>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
References: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=896; i=j@jannau.net; h=from:subject:message-id; bh=d6xopFInR0A/pTQ8VBQnZ0XquLmM0VM326XmH34u10g=; b=owGbwMvMwCG2UNrmdq9+ahrjabUkhuSX7Ccr21aeeiL1YfpZIaUNlz9XH+yfNfPDS7fTfEFX9 vA4Gl542FHKwiDGwSArpsiSpP2yg2F1jWJM7YMwmDmsTCBDGLg4BWAi2qUMv9keZW9Y+T+47c3d PWsZ3yiGsKi9Ug9IYv0jYTvllMST22oM/2umt3nz/ljVdJdVuf/Yz9dNexRbDvf9iw2xXJ+4YnJ aIjcA
X-Developer-Key: i=j@jannau.net; a=openpgp; fpr=8B336A6BE4E5695E89B8532B81E806F586338419
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The block found on Apple's M2 SoC is compatible with the existing driver
so add its per-SoC compatible.

Signed-off-by: Janne Grunau <j@jannau.net>

---
This trivial dt-bindings update should be merged through the asahi-soc
tree to ensure validation of the Apple M2 (t8112) devicetrees in this
series.
---
 Documentation/devicetree/bindings/sound/apple,mca.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/apple,mca.yaml b/Documentation/devicetree/bindings/sound/apple,mca.yaml
index 40e3a202f443..5c6ec08c7d24 100644
--- a/Documentation/devicetree/bindings/sound/apple,mca.yaml
+++ b/Documentation/devicetree/bindings/sound/apple,mca.yaml
@@ -23,6 +23,7 @@ properties:
       - enum:
           - apple,t6000-mca
           - apple,t8103-mca
+          - apple,t8112-mca
       - const: apple,mca
 
   reg:

-- 
2.39.1

