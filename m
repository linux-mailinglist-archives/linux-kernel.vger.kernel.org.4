Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFBC662EFD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237473AbjAIS1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237459AbjAIS0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:26:34 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BA017E21
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 10:24:08 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id hw16so10457806ejc.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 10:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfErmyZAWFClEhl0ayKENaiIcOOkglWFws7K0nbLI8s=;
        b=keYgJ2y3nl5URethgnUoaSGHv3Qr1qCaZizWzyh3ecUHLBUFAOR+b0RCOE0XQ/QD0X
         dhlXZZ4fBWTRdK5q3Ef7VW5Cs9igbU9BkjasBP0WiF2ebvrFYvw9xBJe/tyRlKNdendY
         mN1/SXhIEecvDAHuF1wycidjyRVeJ3uPadn2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfErmyZAWFClEhl0ayKENaiIcOOkglWFws7K0nbLI8s=;
        b=yWYQZOinLZZN81jzT31UTxOHYO+dmiQepm8WaWKeVVfKUns/lnkbzGGifnML3Zeupl
         VDtYhjUgKz65chgCax0W8EQnvmDhSkZ7Vt8SrPUU9UmKCWffOwyJj4LZjKzizRrB+Ntb
         izReI1Zsl54f2Btn5F6x/7ZSx1ScbnS3rDEzc/hBJ/hTTdqF0uYeD7iYe0YkVvbyO5gg
         3I7NSS5v9TvwPowZuCJMABP+f+lSIhZCREPDVn9GyTO/9T47VxWCcKxDQcsPaYlmpKn2
         i7IWaNPzMGdDEpdnaLp4CKzk787DSDsD+xkx6zyQa3Os9t9psFkjweims5XwW0mB7P+v
         iHag==
X-Gm-Message-State: AFqh2krzC9gOBvhfH+UpASrV3eQCa1mThsIyyqqdAAqDLmm37Ow6lzxV
        mVESjefCe1+IibXMzFEm0Q1ceEXAfow+CTf0bOU=
X-Google-Smtp-Source: AMrXdXtO6fIJ3sOc41BMC9psPV+e6x5DXYY7cI4VJRUluWdF9f+T6K4XqawFGBAk0fbrbk81UWuMbw==
X-Received: by 2002:a17:907:2113:b0:84d:4b39:1448 with SMTP id qn19-20020a170907211300b0084d4b391448mr3081519ejb.67.1673288647150;
        Mon, 09 Jan 2023 10:24:07 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.pdxnet.pdxeng.ch (host-80-180-23-57.retail.telecomitalia.it. [80.180.23.57])
        by smtp.gmail.com with ESMTPSA id kz22-20020a17090777d600b007c1633cea13sm4093653ejc.12.2023.01.09.10.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 10:24:06 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        michael@amarulasolutions.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v6 4/5] ARM: dts: stm32: add pin map for CAN controller on stm32f4
Date:   Mon,  9 Jan 2023 19:23:54 +0100
Message-Id: <20230109182356.141849-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230109182356.141849-1-dario.binacchi@amarulasolutions.com>
References: <20230109182356.141849-1-dario.binacchi@amarulasolutions.com>
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

Add pin configurations for using CAN controller on stm32f469-disco
board. They are located on the Arduino compatible connector CN5 (CAN1)
and on the extension connector CN12 (CAN2).

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v3)

Changes in v3:
- Remove 'Dario Binacchi <dariobin@libero.it>' SOB.
- Remove a blank line.

Changes in v2:
- Remove a blank line.

 arch/arm/boot/dts/stm32f4-pinctrl.dtsi | 30 ++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
index 500bcc302d42..8a4d51f97248 100644
--- a/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32f4-pinctrl.dtsi
@@ -448,6 +448,36 @@ pins2 {
 					slew-rate = <2>;
 				};
 			};
+
+			can1_pins_a: can1-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('B', 9, AF9)>; /* CAN1_TX */
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('B', 8, AF9)>; /* CAN1_RX */
+					bias-pull-up;
+				};
+			};
+
+			can2_pins_a: can2-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('B', 13, AF9)>; /* CAN2_TX */
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
 		};
 	};
 };
-- 
2.32.0

