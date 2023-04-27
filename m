Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107966F0D6D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344334AbjD0UqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344313AbjD0Upx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:45:53 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC6946BE
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 13:45:51 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-953343581a4so1381654766b.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 13:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1682628350; x=1685220350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zgyM9/Qsb7y0LcnLSlDess36RbYnrfbiOfx4wd1SRU=;
        b=C0kEWeMPUx9aQmFafDeK++7KxvR/FRLnqASxZ467WKjEKHO4kRSWw8X66kfedTFAZV
         k4bgWFabp/4gWrqn5uyRPdUTMUct44VJOkbw1eGKd/h5Y2DwEUi20UwtyMTHTRKtOzQ/
         uDyeKQzPP2dYzVUk6300KOiLOBWtp47JlVaZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682628350; x=1685220350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8zgyM9/Qsb7y0LcnLSlDess36RbYnrfbiOfx4wd1SRU=;
        b=UQ9C2neRg8CTqcozmiW1NJwnHjGedaxpV3Q7CwEvmVOYJjn26uSJn1u48HmyFoN44w
         3reNU7I6JMBqPT5uMySTdusTYP9yzjVqnYOHCD0HDqS0WzmyejcL/YhPTNi0mPJ7+9xx
         XZtQ9ymyvtI/9ajYMLPcGo0VfB8dgPTjhlwwnIj/CEQs1VDZRqk6xX5lsZdlWRMzd2UT
         d38L/WaHh6LF8Ka2r1pXB/KdbHJLiBpk7lCyie/IxT2mZzGBIdMXO/1oLF9ddiY4bvRD
         L+OGqDoFPGYey2GRvS7RMaiIGGhlXLm9/MPChs/hBMEnWiKYEKVzTkeQYtNE69BgyrXv
         TCjQ==
X-Gm-Message-State: AC+VfDw9c+7rVMKHI4VxASJMfjwPA/bf54NNNYBsAky+5QrheXzVcVEh
        DS6qDEUiuRezJazt8Oqp12SHJ/vV7YV/c0i8nXE9wQ==
X-Google-Smtp-Source: ACHHUZ7xp3LajXmJwIzUw4bO+6Ie+hY8CRiA9yNimoCacSraqyoqOfQE8akxqqf8UroKvyN6TWHbXQ==
X-Received: by 2002:a17:907:3e1a:b0:94f:1a11:e07d with SMTP id hp26-20020a1709073e1a00b0094f1a11e07dmr3458979ejc.32.1682628349735;
        Thu, 27 Apr 2023 13:45:49 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-87-5-99-194.retail.telecomitalia.it. [87.5.99.194])
        by smtp.gmail.com with ESMTPSA id s12-20020a170906bc4c00b00947ed087a2csm10171360ejv.154.2023.04.27.13.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 13:45:49 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 3/5] ARM: dts: stm32: add pin map for CAN controller on stm32f7
Date:   Thu, 27 Apr 2023 22:45:38 +0200
Message-Id: <20230427204540.3126234-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230427204540.3126234-1-dario.binacchi@amarulasolutions.com>
References: <20230427204540.3126234-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pin configurations for using CAN controller on stm32f7.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 arch/arm/boot/dts/stm32f7-pinctrl.dtsi | 82 ++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f7-pinctrl.dtsi b/arch/arm/boot/dts/stm32f7-pinctrl.dtsi
index c8e6c52fb248..9f65403295ca 100644
--- a/arch/arm/boot/dts/stm32f7-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32f7-pinctrl.dtsi
@@ -283,6 +283,88 @@ pins2 {
 					slew-rate = <2>;
 				};
 			};
+
+			can1_pins_a: can1-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('A', 12, AF9)>; /* CAN1_TX */
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('A', 11, AF9)>; /* CAN1_RX */
+					bias-pull-up;
+				};
+			};
+
+			can1_pins_b: can1-1 {
+				pins1 {
+					pinmux = <STM32_PINMUX('B', 9, AF9)>; /* CAN1_TX */
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('B', 8, AF9)>; /* CAN1_RX */
+					bias-pull-up;
+				};
+			};
+
+			can1_pins_c: can1-2 {
+				pins1 {
+					pinmux = <STM32_PINMUX('D', 1, AF9)>; /* CAN1_TX */
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('D', 0, AF9)>; /* CAN1_RX */
+					bias-pull-up;
+
+				};
+			};
+
+			can1_pins_d: can1-3 {
+				pins1 {
+					pinmux = <STM32_PINMUX('H', 13, AF9)>; /* CAN1_TX */
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('H', 14, AF9)>; /* CAN1_RX */
+					bias-pull-up;
+
+				};
+			};
+
+			can2_pins_a: can2-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('B', 6, AF9)>; /* CAN2_TX */
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('B', 5, AF9)>; /* CAN2_RX */
+					bias-pull-up;
+				};
+			};
+
+			can2_pins_b: can2-1 {
+				pins1 {
+					pinmux = <STM32_PINMUX('B', 13, AF9)>; /* CAN2_TX */
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('B', 12, AF9)>; /* CAN2_RX */
+					bias-pull-up;
+				};
+			};
+
+			can3_pins_a: can3-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('A', 15, AF11)>; /* CAN3_TX */
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('A', 8, AF11)>; /* CAN3_RX */
+					bias-pull-up;
+				};
+			};
+
+			can3_pins_b: can3-1 {
+				pins1 {
+					pinmux = <STM32_PINMUX('B', 4, AF11)>;  /* CAN3_TX */
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('B', 3, AF11)>; /* CAN3_RX */
+					bias-pull-up;
+				};
+			};
 		};
 	};
 };
-- 
2.32.0

