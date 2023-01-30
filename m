Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F36E6816FE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236162AbjA3Qys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbjA3Qyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:54:46 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BF53D92D
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 08:54:45 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id kt14so33655218ejc.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 08:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LXg0vcX33DnXDRl4Qdi6ZDWogrA8s0G2Rrxf8IO1PKs=;
        b=QbEicjF7YmF13ezulDFfNuz727VQByALrw9uuIPZvtZlKMsoG+jKaOarkL4iXLFKTG
         M0d6hNOY6JOUyW1OrmRyichUnqhw1kBkVBj0LApPmSnftNSC8johSQ78djllzPoCumbP
         KOd3H32nWwAcGVcTBDzQpq/8ZHGB8vg9dmTqpZYpQxcSQgiP1cAI2AjgfSPJiazPGZl1
         wxFm74achDIccqe7q6gGhas3ePdnaoHCZLqbcWoTFz16gQOpPV2Di3ZmnB9dc01SgKNY
         /ckAetNlwTU+YT3b2tGaxVSjfp7t2vt0DQJWAVym52nNEYWv3LPl04ChAPzvthnsLTsJ
         Jz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LXg0vcX33DnXDRl4Qdi6ZDWogrA8s0G2Rrxf8IO1PKs=;
        b=2hx57+JXG2hhiGoglLIxMUY4+o+ITVV4EC0VHiQGOgVFjwr0vh25XUoov+3fJaxzcS
         I/obzm+OaTwyWI+7IpFVYFRa+hBo92z7jDGX9n/EH+eKTORQOAU4I02KawY9NKRT2qQZ
         m/yWUzLNNNY7LfFH6uc56BPHsJFcBVI1nYGS1pL/vC+5p2CaXTsalQ58Cps/VWl8nQkP
         dOpNhSKUyd6b+Gq+0JMMfgp2lxP/nk1VmKkTVOJZi36PWlB4eJefBJxB8zu6ZqpkR4s4
         91QgeUFONOC0ms6XnuMKwR9/tC0VdtMr9norArLgGar/Um+CxwxQmB0JEia6hZwLZszm
         PvCg==
X-Gm-Message-State: AO0yUKWRlOH2R9FIs64vJfuwWAAJy6bLNLukja93N/vyWzQHMEPeE5gC
        NsYd79mVf0DaySsJBUqHiS+C3g==
X-Google-Smtp-Source: AK7set+Mbu9nF6QDeSGgFURDfRkwriUDkJi++ex+D+IPiTZoixzQMsBWsfU1u1xAf1BAwf+msRnsxQ==
X-Received: by 2002:a17:907:3c16:b0:889:daeb:5532 with SMTP id gh22-20020a1709073c1600b00889daeb5532mr2195829ejc.47.1675097684236;
        Mon, 30 Jan 2023 08:54:44 -0800 (PST)
Received: from localhost.localdomain (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id lj14-20020a170906f9ce00b0088744fc7084sm2590651ejb.38.2023.01.30.08.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 08:54:43 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] dt-bindings: pincfg-node: Introduce an overridable way to set bias on pins
Date:   Mon, 30 Jan 2023 17:54:34 +0100
Message-Id: <20230130165435.2347569-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We came to a point where we sometimes we support a few dozen boards
with a given SoC. Sometimes, we have to take into consideration
configurations which deviate rather significatly from the reference
or most common designs. In the context of pinctrl, this often comes
down to wildly different pin configurations. While pins, function and
drive-strength are easily overridable, the (mostly) boolean properties
associated with setting bias, aren't. This wouldn't be much of a
problem if they didn't differ between boards so often, preventing us
from having a "nice" baseline setup without inevitably having to go
with an ugly /delete-property/. Introduce bias-type, a bias-type-
specific property and clone the pinconf-generic type enum into
dt-bindings to allow for setting the bias in an easily overridable
manner such as:

// SoC DT
i2c0_pin: i2c0-pin-state {
	pins = "gpio10";
	function = "gpio";
	bias-type = <BIAS_PULL_UP>;
};

// Deviant board DT
&i2c0_pin {
	bias-type = <BIAS_HIGH_IMPEDANCE>;
};

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/pinctrl/pincfg-node.yaml         |  4 ++
 include/dt-bindings/pinctrl/pinconf-generic.h | 40 +++++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 include/dt-bindings/pinctrl/pinconf-generic.h

diff --git a/Documentation/devicetree/bindings/pinctrl/pincfg-node.yaml b/Documentation/devicetree/bindings/pinctrl/pincfg-node.yaml
index be81ed22a036..d4ea563d283e 100644
--- a/Documentation/devicetree/bindings/pinctrl/pincfg-node.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/pincfg-node.yaml
@@ -51,6 +51,10 @@ properties:
     description: use pin-default pull state. Takes as optional argument on
       hardware supporting it the pull strength in Ohm.
 
+  bias-type:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Use the specified bias type.
+
   drive-push-pull:
     oneOf:
       - type: boolean
diff --git a/include/dt-bindings/pinctrl/pinconf-generic.h b/include/dt-bindings/pinctrl/pinconf-generic.h
new file mode 100644
index 000000000000..7d9c7d8f9105
--- /dev/null
+++ b/include/dt-bindings/pinctrl/pinconf-generic.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2011 ST-Ericsson SA
+ * Written on behalf of Linaro for ST-Ericsson
+ *
+ * Author: Linus Walleij <linus.walleij@linaro.org>
+ */
+
+#ifndef _DT_BINDINGS_PINCTRL_PINCONF_GENERIC_H
+#define _DT_BINDINGS_PINCTRL_PINCONF_GENERIC_H
+
+#define BIAS_BUS_HOLD			0
+#define BIAS_DISABLE			1
+#define BIAS_HIGH_IMPEDANCE		2
+#define BIAS_PULL_DOWN			3
+#define BIAS_PULL_PIN_DEFAULT		4
+#define BIAS_PULL_UP			5
+#define DRIVE_OPEN_DRAIN		6
+#define DRIVE_OPEN_SOURCE		7
+#define DRIVE_PUSH_PULL			8
+#define DRIVE_STRENGTH			9
+#define DRIVE_STRENGTH_UA		10
+#define INPUT_DEBOUNCE			11
+#define INPUT_ENABLE			12
+#define INPUT_SCHMITT			13
+#define INPUT_SCHMITT_ENABLE		14
+#define MODE_LOW_POWER			15
+#define MODE_PWM			16
+#define OUTPUT				17
+#define OUTPUT_ENABLE			18
+#define OUTPUT_IMPEDANCE_OHMS		19
+#define PERSIST_STATE			20
+#define POWER_SOURCE			21
+#define SKEW_DELAY			22
+#define SLEEP_HARDWARE_STATE		23
+#define SLEW_RATE			24
+#define PIN_CONFIG_END			0x7F
+#define PIN_CONFIG_MAX			0xFF
+
+#endif
-- 
2.39.1

