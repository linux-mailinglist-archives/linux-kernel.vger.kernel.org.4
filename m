Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4946968A9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 16:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbjBNP6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 10:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbjBNP6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 10:58:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0146A2BF25;
        Tue, 14 Feb 2023 07:57:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B303B81E24;
        Tue, 14 Feb 2023 15:57:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 347A4C433EF;
        Tue, 14 Feb 2023 15:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676390262;
        bh=fNduKqqPUYV6F1M5u00Pcrdw5zzaBtWuks1TRf+NJ/0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=NutoAAPmhiTsVna0yHCjaRN6lTKVuyIoiSoapq4gLoWLUZsUJ7eRASr5KYUVo9RYb
         +bkMVThto8j5RGh4Gs0kq0F4Tk5pxv7oJvI2g6Eb3x6JNaD14oUVIFKJ6qfuJqhhv9
         n1mk4Nmf56f8StzBBjx0CJQt1PKXafoVGAtOHMzNT5w44+DE1ENhmIN/qZ4Z+sNNcY
         DprT8QWe20jqMPg6JJouP9c0OwFhh+FWi6L1fORGn3wz2vQsZRWcRWZrQh6Y6a50cG
         Y3blRSlBMeWDnf1tIIqGGfBH13zgJr5RUG1ZhdmqAKSaE4cNHhECQsycoz+uyEHpNB
         LskAckXbv6uyQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 18A89C6379F;
        Tue, 14 Feb 2023 15:57:42 +0000 (UTC)
From:   Sasha Finkelstein via B4 Submission Endpoint 
        <devnull+fnkl.kernel.gmail.com@kernel.org>
Date:   Tue, 14 Feb 2023 16:57:23 +0100
Subject: [PATCH RESEND 2 v7 1/5] dt-bindings: pwm: Add Apple PWM controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230214-fpwm-v7-1-fb0a6bfbd037@gmail.com>
References: <20230214-fpwm-v7-0-fb0a6bfbd037@gmail.com>
In-Reply-To: <20230214-fpwm-v7-0-fb0a6bfbd037@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        - <asahi@lists.linux.dev>,
        Sasha Finkelstein <fnkl.kernel@gmail.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676390260; l=1759;
 i=fnkl.kernel@gmail.com; s=20230213; h=from:subject:message-id;
 bh=BeW75+AIFJcFrpFjOZabHWBRDLlSvckpqesK7uzTCx4=;
 b=s+tNMPIU6I5o9UPGsiZm/CArcN1IeGxgbgkzNTohM1pS17BErYBiDP/1d519ZLxoU1YsjgH+V
 d1dh0sEgglWDmRoqnMNxtFFYzJYbAEjaIcu68sEPKJtopT9HMm4O7l8
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=7LFSAJtxIWAs9LzCIyX0sSvCZy2wQTyEIu1zch6o804=
X-Endpoint-Received: by B4 Submission Endpoint for fnkl.kernel@gmail.com/20230213 with auth_id=28
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: <fnkl.kernel@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sasha Finkelstein <fnkl.kernel@gmail.com>

Apple SoCs such as the M1 contain a PWM controller used
among other things to control the keyboard backlight.

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Sven Peter <sven@svenpeter.dev>
---
 .../devicetree/bindings/pwm/apple,s5l-fpwm.yaml    | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml b/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
new file mode 100644
index 000000000000..142157bff0cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/apple,s5l-fpwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple FPWM controller
+
+maintainers:
+  - asahi@lists.linux.dev
+  - Sasha Finkelstein <fnkl.kernel@gmail.com>
+
+description: PWM controller used for keyboard backlight on ARM Macs
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - apple,t8103-fpwm
+          - apple,t6000-fpwm
+          - apple,t8112-fpwm
+      - const: apple,s5l-fpwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    pwm@235044000 {
+      compatible = "apple,t8103-fpwm", "apple,s5l-fpwm";
+      reg = <0x35044000 0x4000>;
+      power-domains = <&ps_fpwm1>;
+      clocks = <&clkref>;
+      #pwm-cells = <2>;
+    };

-- 
Git-137.1)

