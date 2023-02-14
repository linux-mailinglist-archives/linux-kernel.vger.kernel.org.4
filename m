Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254D46961D8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjBNLEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbjBNLEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:04:31 -0500
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8DE25BBE;
        Tue, 14 Feb 2023 03:04:11 -0800 (PST)
Received: from robin.home.jannau.net (p579ad32f.dip0.t-ipconnect.de [87.154.211.47])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 8973B26F79D;
        Tue, 14 Feb 2023 12:04:05 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
Date:   Tue, 14 Feb 2023 12:03:24 +0100
Subject: [PATCH v2 11/16] dt-bindings: i2c: apple,i2c: Add apple,t8112-i2c
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230202-asahi-t8112-dt-v2-11-22926a283d92@jannau.net>
References: <20230202-asahi-t8112-dt-v2-0-22926a283d92@jannau.net>
In-Reply-To: <20230202-asahi-t8112-dt-v2-0-22926a283d92@jannau.net>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa@kernel.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=780; i=j@jannau.net;
 h=from:subject:message-id; bh=neCnsMi9MaM1q2S1DTmcf76eFl2d0zIyg5Xr1VD1n38=;
 b=owGbwMvMwCG2UNrmdq9+ahrjabUkhuTXWfNTnRbdkF6ba1Lev/vUo7kNFnbzX/11Kjvx0Xy69
 0f5ZXvkOkpZGMQ4GGTFFFmStF92MKyuUYypfRAGM4eVCWQIAxenAEyEKYGRoe/vouV7DG8rNMu2
 KShffOd9+uws9ouZEZb1/KbqZ6WPzWL4yXhz+gOWkwq1t7+9m62xraUqo3fj4Rq29GkOuxfkLZp
 9ggEA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This block on the Apple M2 is compatible with the existing driver so
just add the per-SoC compatible.

Acked-by: Wolfram Sang <wsa@kernel.org> # for I2C
Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/i2c/apple,i2c.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/apple,i2c.yaml b/Documentation/devicetree/bindings/i2c/apple,i2c.yaml
index 4ac61fec90e2..3f0e94189f2d 100644
--- a/Documentation/devicetree/bindings/i2c/apple,i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/apple,i2c.yaml
@@ -23,6 +23,7 @@ properties:
     items:
       - enum:
           - apple,t8103-i2c
+          - apple,t8112-i2c
           - apple,t6000-i2c
       - const: apple,i2c
 

-- 
2.39.1

