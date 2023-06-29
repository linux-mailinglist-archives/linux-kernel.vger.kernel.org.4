Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D203F74226D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 10:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbjF2Img (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 04:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjF2IlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 04:41:13 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC793C3E
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 01:37:43 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f86fbe5e4fso602408e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 01:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1688027861; x=1690619861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VnEheSovvunB6I3AktXE1UaU+sD3f90l2AKOrWC4PB8=;
        b=oCEJRBlG0q5Ikznr8GnTiR7wyzuqUQJcL9dD0uLR9k1UXS1TZdpar3ejEUbVR+bDH6
         43CxGZR5xJ2xDm5CrSisUeIA08iUGV81j12q/2VL+/d53Y16nX3ROAHyE5J+zxR8UyWR
         7h7G2JGf4Is/EMG4PN/cthIR2+XFnzBCM5FZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688027861; x=1690619861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VnEheSovvunB6I3AktXE1UaU+sD3f90l2AKOrWC4PB8=;
        b=Kb/YbkmXXeIwx63Vy/Di963LyeM2Bct3SxOUookexEdc+FKYi4fAT2tsNpcPp/tx8I
         Eumiq6/PDsEcbv1oc8lPRXzxkpTgX6Bbf6W4Bncp1aErj4Zvr56xaZIdbkWC6nxOJuUp
         HgumGT4DR+7A7qIjpFqP2cwjc+JdW+F/Fax43luWIB+deG+MArw7e8fTkVj8wOQE2+hJ
         bnuMaQZZEsN0WAZqxiBm2dNSG/kFCbR//9YGRJVMxTToUZH++sNXLjyResdHGOh9L+Uh
         Pokeya93nApxZMRDpWb5eEnkbxZwPLbVeE/NE7gTt5oTXL4dSnE/cC3eenNqDXRFjaXf
         PuSg==
X-Gm-Message-State: AC+VfDywUQkrqUlDMU6AYiAPxn/WldM6UeHnRgxfmSNWVoXcrl7WMrN7
        RjQh1e+p3zkiT9y0GxHwZmnkg1HlDw79ttGfhm+yFg==
X-Google-Smtp-Source: ACHHUZ7ByXysxvPaeuaHZIwK2Y1GqQD+cRUR2oy+pDeGtRreuognjKejfzOBHomUFPstE+PBAaMMKg==
X-Received: by 2002:a05:6512:33c4:b0:4fb:89e2:fc27 with SMTP id d4-20020a05651233c400b004fb89e2fc27mr5492157lfg.54.1688027860684;
        Thu, 29 Jun 2023 01:37:40 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.praguecc.cz (90-182-211-1.rcp.o2.cz. [90.182.211.1])
        by smtp.gmail.com with ESMTPSA id cw13-20020a056000090d00b003112f836d4esm15266322wrb.85.2023.06.29.01.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 01:37:40 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v5 2/3] ARM: dts: stm32: add pin map for LTDC on stm32f7
Date:   Thu, 29 Jun 2023 10:37:25 +0200
Message-Id: <20230629083726.84910-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230629083726.84910-1-dario.binacchi@amarulasolutions.com>
References: <20230629083726.84910-1-dario.binacchi@amarulasolutions.com>
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

Add pin configurations for using LTDC (LCD-tft Display Controller) on
stm32f746-disco board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v3)

Changes in v3:
- rename ltdc-pins-a-0 to ltdc-0.

 arch/arm/boot/dts/stm32f7-pinctrl.dtsi | 35 ++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f7-pinctrl.dtsi b/arch/arm/boot/dts/stm32f7-pinctrl.dtsi
index 9f65403295ca..36dad40dd0c7 100644
--- a/arch/arm/boot/dts/stm32f7-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32f7-pinctrl.dtsi
@@ -365,6 +365,41 @@ pins2 {
 					bias-pull-up;
 				};
 			};
+
+
+			ltdc_pins_a: ltdc-0 {
+				pins {
+					pinmux = <STM32_PINMUX('E', 4, AF14)>, /* LCD_B0 */
+						 <STM32_PINMUX('G',12, AF9)>,  /* LCD_B4 */
+						 <STM32_PINMUX('I', 9, AF14)>, /* LCD_VSYNC */
+						 <STM32_PINMUX('I',10, AF14)>, /* LCD_HSYNC */
+						 <STM32_PINMUX('I',14, AF14)>, /* LCD_CLK */
+						 <STM32_PINMUX('I',15, AF14)>, /* LCD_R0 */
+						 <STM32_PINMUX('J', 0, AF14)>, /* LCD_R1 */
+						 <STM32_PINMUX('J', 1, AF14)>, /* LCD_R2 */
+						 <STM32_PINMUX('J', 2, AF14)>, /* LCD_R3 */
+						 <STM32_PINMUX('J', 3, AF14)>, /* LCD_R4 */
+						 <STM32_PINMUX('J', 4, AF14)>, /* LCD_R5 */
+						 <STM32_PINMUX('J', 5, AF14)>, /* LCD_R6 */
+						 <STM32_PINMUX('J', 6, AF14)>, /* LCD_R7 */
+						 <STM32_PINMUX('J', 7, AF14)>, /* LCD_G0 */
+						 <STM32_PINMUX('J', 8, AF14)>, /* LCD_G1 */
+						 <STM32_PINMUX('J', 9, AF14)>, /* LCD_G2 */
+						 <STM32_PINMUX('J',10, AF14)>, /* LCD_G3 */
+						 <STM32_PINMUX('J',11, AF14)>, /* LCD_G4 */
+						 <STM32_PINMUX('J',13, AF14)>, /* LCD_B1 */
+						 <STM32_PINMUX('J',14, AF14)>, /* LCD_B2 */
+						 <STM32_PINMUX('J',15, AF14)>, /* LCD_B3 */
+						 <STM32_PINMUX('K', 0, AF14)>, /* LCD_G5 */
+						 <STM32_PINMUX('K', 1, AF14)>, /* LCD_G6 */
+						 <STM32_PINMUX('K', 2, AF14)>, /* LCD_G7 */
+						 <STM32_PINMUX('K', 4, AF14)>, /* LCD_B5 */
+						 <STM32_PINMUX('K', 5, AF14)>, /* LCD_B6 */
+						 <STM32_PINMUX('K', 6, AF14)>, /* LCD_B7 */
+						 <STM32_PINMUX('K', 7, AF14)>; /* LCD_DE */
+					slew-rate = <2>;
+				};
+			};
 		};
 	};
 };
-- 
2.32.0

