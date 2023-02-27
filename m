Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BF16A4CA7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 22:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjB0VAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 16:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjB0VAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 16:00:45 -0500
Received: from smtprelay04.ispgateway.de (smtprelay04.ispgateway.de [80.67.31.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8007A25E12;
        Mon, 27 Feb 2023 13:00:33 -0800 (PST)
Received: from [92.206.161.29] (helo=note-book.lan)
        by smtprelay04.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <git@apitzsch.eu>)
        id 1pWkSJ-0006TA-21; Mon, 27 Feb 2023 21:50:43 +0100
From:   =?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>
To:     Nick Dyer <nick@shmanahar.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>
Subject: [PATCH 1/2] dt-bindings: input: atmel,maxtouch: add linux,keycodes
Date:   Mon, 27 Feb 2023 21:50:34 +0100
Message-Id: <20230227205035.18551-1-git@apitzsch.eu>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some configurations the touch controller can support the touch keys.
Document the linux,keycodes property that enables those keys and
specifies the keycodes that should be used to report the key events.

Signed-off-by: André Apitzsch <git@apitzsch.eu>
---
 .../devicetree/bindings/input/atmel,maxtouch.yaml          | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/atmel,maxtouch.yaml b/Documentation/devicetree/bindings/input/atmel,maxtouch.yaml
index 3ec579d63570..c40799355ed7 100644
--- a/Documentation/devicetree/bindings/input/atmel,maxtouch.yaml
+++ b/Documentation/devicetree/bindings/input/atmel,maxtouch.yaml
@@ -14,6 +14,9 @@ description: |
   Atmel maXTouch touchscreen or touchpads such as the mXT244
   and similar devices.
 
+allOf:
+  - $ref: input.yaml#
+
 properties:
   compatible:
     const: atmel,maxtouch
@@ -60,6 +63,10 @@ properties:
       or experiment to determine which bit corresponds to which input. Use
       KEY_RESERVED for unused padding values.
 
+  linux,keycodes:
+    minItems: 1
+    maxItems: 8
+
   atmel,wakeup-method:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: |

base-commit: 982818426a0ffaf93b0621826ed39a84be3d7d62
-- 
2.39.2

