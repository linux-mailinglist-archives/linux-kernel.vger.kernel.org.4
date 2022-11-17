Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD5062E4EE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 20:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240249AbiKQTFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 14:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240151AbiKQTFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 14:05:39 -0500
Received: from mail-40140.protonmail.ch (mail-40140.protonmail.ch [185.70.40.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D157EC8C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 11:05:37 -0800 (PST)
Date:   Thu, 17 Nov 2022 19:05:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1668711935; x=1668971135;
        bh=U5nqDWG9FhX2ieLESGVMcwyTvDa3UugkxKXP+0flQCE=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=sNA43D1GTk1KrLPZq18i+96MvMtzKp2n5/VzATph8CM1jOuorPqhrkSzLY0n+YMQj
         JDaYjwz5/zQ55flZ/vH9O5TEANFt/iRrKdDvheILyjbwICn1D+vbiroKSl9MJR8amh
         66wogiRu+Ae+vAEx3lnXVT2WOY3d/g5ZdFr5R7VjBzS8EnjkZbS2Sm9Yw5AyTTTp31
         h3eyeel+odwm84hvWvhpmhk/6/Qi1Gu7vT6/Xk6478HhMvRo83uASi6pVZh9voWbwt
         cf1S5vrIZVsSXJPSNu75ojZAbsFZxU7clgfQviw81E1EMdIXwLkGG6rTKdOIOPagyj
         AqewgeY596Ywg==
To:     linux-input@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alistair Francis <alistair@alistair23.me>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: input: cyttsp5: document vddio-supply
Message-ID: <20221117190507.87535-2-linmengbo0689@protonmail.com>
In-Reply-To: <20221117190507.87535-1-linmengbo0689@protonmail.com>
References: <20221117190507.87535-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Samsung touchscreen controllers are often used with external pull-up
for the interrupt line and the I2C lines, so we might need to enable
a regulator to bring the lines into usable state. Otherwise, this might
cause spurious interrupts and reading from I2C will fail.

Document support for a "vddio-supply" that is enabled by the cyttsp5
driver so that the regulator gets enabled when needed.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 .../devicetree/bindings/input/touchscreen/cypress,tt21000.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/cypress,tt=
21000.yaml b/Documentation/devicetree/bindings/input/touchscreen/cypress,tt=
21000.yaml
index 1959ec394768..869a9bdd962f 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.y=
aml
+++ b/Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.y=
aml
@@ -34,6 +34,9 @@ properties:
   vdd-supply:
     description: Regulator for voltage.
=20
+  vddio-supply:
+    description: Optional Regulator for I/O voltage.
+
   reset-gpios:
     maxItems: 1
=20
--=20
2.30.2


