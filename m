Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041D56DACB1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 14:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjDGMqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 08:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjDGMqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 08:46:42 -0400
Received: from smtprelay04.ispgateway.de (smtprelay04.ispgateway.de [80.67.18.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E17540F6;
        Fri,  7 Apr 2023 05:46:41 -0700 (PDT)
Received: from [92.206.161.29] (helo=note-book.lan)
        by smtprelay04.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <git@apitzsch.eu>)
        id 1pklTE-0002cY-Ac; Fri, 07 Apr 2023 14:45:36 +0200
From:   =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Date:   Fri, 07 Apr 2023 14:44:24 +0200
Subject: [PATCH v2 1/2] dt-bindings: input: atmel,maxtouch: add
 linux,keycodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230407-atmel_keys-v2-1-92446a4343cb@apitzsch.eu>
References: <20230407-atmel_keys-v2-0-92446a4343cb@apitzsch.eu>
In-Reply-To: <20230407-atmel_keys-v2-0-92446a4343cb@apitzsch.eu>
To:     Nick Dyer <nick@shmanahar.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some configurations the touch controller can support the touch keys.
Document the linux,keycodes property that enables those keys and
specifies the keycodes that should be used to report the key events.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: André Apitzsch <git@apitzsch.eu>
---
 Documentation/devicetree/bindings/input/atmel,maxtouch.yaml | 7 +++++++
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

-- 
2.40.0

