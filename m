Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E6274FF40
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjGLGaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbjGLG3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:29:42 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366BC1BC0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 23:29:27 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b703c900e3so103016711fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 23:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1689143365; x=1691735365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jaFWUw9gKjfe3Ukcvgb1jp0d6hB2t/eCpjIsrYyKWTo=;
        b=fQehUMh02IXnUqs11ZSMB8+hM0rieOkvTmwEQVLV8VBy3v5+bd5MX5ualkxI3PNskM
         YmZxZCcv5uoER6qjccIz/NAoGEl+hVnbQpOq7L4mVnC8PUe7QVoEleBQoItSZpn6PlVL
         jhPthpmFJZOUGriG/kDZ6YRm5qlB2pkrK7IHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689143365; x=1691735365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jaFWUw9gKjfe3Ukcvgb1jp0d6hB2t/eCpjIsrYyKWTo=;
        b=hGQsnMPMm4CHbPIir8DBpp7PXY2o0T4r6phNZw5z1YQqLNQzs5gk0Ws6nAS4CG+tlc
         iLjInRVLapyAqAISg/owHH+FCDtOZnUDhTHe3dcPlUwSIGC1IPmtYizreAaeNlL9o0VQ
         jY2OsLJ3sR6zBaG5zeKd0dUKtcibLETYmwCBqwq/YbRW3nPIXuXLg6lqcvOIFQ8eexfo
         +wGNKSMS779suJ2E1gXk9kPBdmcGWF+DjwEhgRm7AnCHWw9QEnung9LFkINIxWIAkgAt
         NpcPYIvVJzfFoqnuFg00nJOV3RXRPyrve1XV756mGZtCopsxaBtJkVDR3rZ+baHfkFLX
         xqDA==
X-Gm-Message-State: ABy/qLZRR2xoi945MuBtdLj4+9/mS/4xorlrA7ttnuFr1giNQZW7b9z6
        0aab4cBndBWvNI+GbX8fY5/njPQPWeLqtsqZ4nExlg==
X-Google-Smtp-Source: APBJJlFddfjiNpXl3v97FZcNWYumrgBFlgTdW/il742NBF7QIBsu0Cys8eDGmBLoo0Jnlw0299DeFA==
X-Received: by 2002:a2e:8699:0:b0:2b6:9ebc:daf8 with SMTP id l25-20020a2e8699000000b002b69ebcdaf8mr15337445lji.31.1689143364867;
        Tue, 11 Jul 2023 23:29:24 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com (host-82-58-49-236.retail.telecomitalia.it. [82.58.49.236])
        by smtp.gmail.com with ESMTPSA id d21-20020a170906371500b009890e402a6bsm2065390ejc.221.2023.07.11.23.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 23:29:24 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v6 2/3] ARM: dts: stm32: add pin map for LTDC on stm32f7
Date:   Wed, 12 Jul 2023 08:29:17 +0200
Message-Id: <20230712062918.2248573-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230712062918.2248573-1-dario.binacchi@amarulasolutions.com>
References: <20230712062918.2248573-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

 arch/arm/boot/dts/st/stm32f7-pinctrl.dtsi | 35 +++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32f7-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32f7-pinctrl.dtsi
index 9f65403295ca..36dad40dd0c7 100644
--- a/arch/arm/boot/dts/st/stm32f7-pinctrl.dtsi
+++ b/arch/arm/boot/dts/st/stm32f7-pinctrl.dtsi
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

