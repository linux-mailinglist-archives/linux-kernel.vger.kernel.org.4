Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620046EC15B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 19:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjDWRZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 13:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjDWRZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 13:25:47 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8304F10D4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 10:25:45 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-2f833bda191so2104189f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 10:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1682270743; x=1684862743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FeM+sCDaiJjgHIKAN9KA5DToVUgObUF0WlB1aYKrng=;
        b=Cg0qM4kMSyG1istSRanl7VDS6Dy0TnJALGPLvbHhJLyTfvVepvGSxZjN9dLA7p5/RJ
         vdQx888knq7AwWjjmJHfeEkbf+ofHW3zEN45ssZuQcvuc0zqEMh536s84pjHvTq3M4M+
         qrY7eM6BO3IogIqIogbZq8/56fjkmnNmNh58E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682270743; x=1684862743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FeM+sCDaiJjgHIKAN9KA5DToVUgObUF0WlB1aYKrng=;
        b=VwKncxpa/eEQKo2cnhjH46o53wzezR6Pv850bXfPWwObRa1yFGR00mMciSHbr1u8Fq
         zevIpNBk8tEAXq5tgl2utNdZzsacWMyachklt7nQz4vw9oTV5K7xSIwJOTis8onZ1WKm
         eLqXonTu+YLWS3ilczBUWd0hT2NCI/yGXRs28ZLTrbgPyJZuDP9EqyRCm5FkjlZ/etPf
         Al1oOJwh53nzwvw62sebHMwbmARt2SpkQyZP+oSFwJ2Wj0pYX1PdrdBBWmIXsaOMT4G7
         eGQ099mxKhFaQPBqrZAJY/7FDtRYpyczgHWdeOViPiNUXlpWzJGQOsS+ZF5iu2NX93Eq
         8Kdw==
X-Gm-Message-State: AAQBX9cYHnGi1+Kxl9y2EvVDePyw3iUxahuVcomGmW5IDBya7FjCOhiq
        os+qSDR0XvYoJq1lBKl4ZBU8d4i+1ge6vhdax+DiUg==
X-Google-Smtp-Source: AKy350ZG9b++T7dK9uT8+qInWMRARXrouuqU40WgBNWL+FhWJRbAFNK8K7tKbrQmqgyES7dKmxf+Rw==
X-Received: by 2002:a5d:5272:0:b0:2f4:de63:a0b5 with SMTP id l18-20020a5d5272000000b002f4de63a0b5mr8057660wrc.69.1682270743681;
        Sun, 23 Apr 2023 10:25:43 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([37.159.119.249])
        by smtp.gmail.com with ESMTPSA id j32-20020a05600c1c2000b003f173987ec2sm13511653wms.22.2023.04.23.10.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 10:25:43 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 3/4] ARM: dts: stm32: add pin map for CAN controller on stm32f7
Date:   Sun, 23 Apr 2023 19:25:27 +0200
Message-Id: <20230423172528.1398158-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230423172528.1398158-1-dario.binacchi@amarulasolutions.com>
References: <20230423172528.1398158-1-dario.binacchi@amarulasolutions.com>
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

