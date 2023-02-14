Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781C46961D6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbjBNLEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbjBNLEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:04:30 -0500
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10D52685B;
        Tue, 14 Feb 2023 03:04:08 -0800 (PST)
Received: from robin.home.jannau.net (p579ad32f.dip0.t-ipconnect.de [87.154.211.47])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 2F1EB26F79C;
        Tue, 14 Feb 2023 12:04:05 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
Date:   Tue, 14 Feb 2023 12:03:23 +0100
Subject: [PATCH v2 10/16] dt-bindings: pinctrl: apple,pinctrl: Add
 apple,t8112-pinctrl compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230202-asahi-t8112-dt-v2-10-22926a283d92@jannau.net>
References: <20230202-asahi-t8112-dt-v2-0-22926a283d92@jannau.net>
In-Reply-To: <20230202-asahi-t8112-dt-v2-0-22926a283d92@jannau.net>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=821; i=j@jannau.net;
 h=from:subject:message-id; bh=jh6XjzB5WpgNn26BkBIm/HimbXvQgmtI1mfw0jO8dVw=;
 b=owGbwMvMwCG2UNrmdq9+ahrjabUkhuTXWfOXZj3p6Kzwltb3LJn7ftrN+8+8Eu2XplQ4bRDUu
 5uk/vlRRykLgxgHg6yYIkuS9ssOhtU1ijG1D8Jg5rAygQxh4OIUgImwODH8j9ssuOuQ/o9LFfkO
 y5l3VAc69/n7qfI61HyZOZvhyumjAowMu8PajudU/T9+61Drkik/75wuc9i/XuhsoyffnEpJ1f7
 H7AA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new SoC uses the same pinctrl hardware, so just add a new per-SoC
compatible.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
index d3b11351ca45..684c03a6bd40 100644
--- a/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
@@ -19,6 +19,7 @@ properties:
     items:
       - enum:
           - apple,t8103-pinctrl
+          - apple,t8112-pinctrl
           - apple,t6000-pinctrl
       - const: apple,pinctrl
 

-- 
2.39.1

