Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED965E951F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 19:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbiIYRwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 13:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbiIYRwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 13:52:24 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE07520183
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 10:52:22 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id dv25so9809381ejb.12
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 10:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=dOPE1L7q5E7QdZRAYhm0K2Z1Q5vapQyABM0Y6Kwo/zE=;
        b=rpXllgi1ui0C+7mDAPG3UTMJMKX3GqJkXwVqkF+rT3uGpiGSLf62ihJPuG3CrAO29p
         cRw4A0eLtVJGfsdxFTl89+sNm9OMd/yJTYiqKk2U84orUKiBk2K4xlK7gzMbcEOTARY/
         56WOCSemX4jGl5BmH2khUUmFEpCsQmBUAM/ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dOPE1L7q5E7QdZRAYhm0K2Z1Q5vapQyABM0Y6Kwo/zE=;
        b=VitSQEDzSkfUI0Ev7y0JV03xpeCthL2ruteK9i6q/dmw/Z7nRA/NXmpRIFSExz0oE9
         eDWgITJq5hYZeBZUxMBH3EVI49fV4+RWv5fluIngOiuegyxUnncUoirWLOnr+fdt/lpy
         8nSpFMy0DqbFEJi1YBFECdrRaECF+WBZVBTJc8n6ghjLCLu5F83mrZpxAo8fCNUOiJit
         zIwUG3vMOGMawn/Sphg124X+4o24xdfqwXOkfvNFRicx4SZQraTWtjuuk8eEw8EduIe2
         mP8WOEr/E1d2CwDmAnLKNZYA7NWDIoS39MQn5bnm9PBunBfTBhTW1UlUTTrRf5IhG91X
         h16w==
X-Gm-Message-State: ACrzQf0uIU3+Y22or516vg0Iee0GzCHUqJewxQWt+/s8Uxa1t/Jgvndf
        pDQUoNXLUM+MGPx79Pu4g7JxIfiJ9zMyPw==
X-Google-Smtp-Source: AMsMyM7aJJDiFqfcUqHoW3X3EVzo65dZxU25xJIKTVawhR1ThjMIQqAHd5wMOFH5AhT+XV1BFlOEPw==
X-Received: by 2002:a17:907:6e17:b0:783:7839:ff3f with SMTP id sd23-20020a1709076e1700b007837839ff3fmr1778971ejc.300.1664128341028;
        Sun, 25 Sep 2022 10:52:21 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-232-92-192.retail.telecomitalia.it. [95.232.92.192])
        by smtp.gmail.com with ESMTPSA id f23-20020a056402161700b0045703d699b9sm3252594edv.78.2022.09.25.10.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 10:52:20 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [RFC PATCH v4 3/5] ARM: dts: stm32: add CAN support on stm32f429
Date:   Sun, 25 Sep 2022 19:52:07 +0200
Message-Id: <20220925175209.1528960-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220925175209.1528960-1-dario.binacchi@amarulasolutions.com>
References: <20220925175209.1528960-1-dario.binacchi@amarulasolutions.com>
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

Add support for bxcan (Basic eXtended CAN controller) to STM32F429. The
chip contains two CAN peripherals, CAN1 the master and CAN2 the slave,
that share some of the required logic like clock and filters. This means
that the slave CAN can't be used without the master CAN.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v4:
- Replace the node can@40006400 (compatible "st,stm32f4-bxcan-core")
  with the gcan@40006600 node ("sysnode" compatible). The gcan node
  contains clocks and memory addresses shared by the two can nodes
  of which it's no longer the parent.
- Add to can nodes the "st,gcan" property (global can memory) which
  references the gcan@40006600 node ("sysnode compatibble).

Changes in v3:
- Remove 'Dario Binacchi <dariobin@libero.it>' SOB.
- Add "clocks" to can@0 node.

 arch/arm/boot/dts/stm32f429.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index c31ceb821231..ce08872109b8 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -362,6 +362,35 @@ i2c3: i2c@40005c00 {
 			status = "disabled";
 		};
 
+		gcan: gcan@40006600 {
+			compatible = "st,stm32f4-gcan", "syscon";
+			reg = <0x40006600 0x200>;
+			clocks = <&rcc 0 STM32F4_APB1_CLOCK(CAN1)>;
+		};
+
+		can1: can@40006400 {
+			compatible = "st,stm32f4-bxcan";
+			reg = <0x40006400 0x200>;
+			interrupts = <19>, <20>, <21>, <22>;
+			interrupt-names = "tx", "rx0", "rx1", "sce";
+			resets = <&rcc STM32F4_APB1_RESET(CAN1)>;
+			clocks = <&rcc 0 STM32F4_APB1_CLOCK(CAN1)>;
+			st,can-master;
+			st,gcan = <&gcan>;
+			status = "disabled";
+		};
+
+		can2: can@40006800 {
+			compatible = "st,stm32f4-bxcan";
+			reg = <0x40006800 0x200>;
+			interrupts = <63>, <64>, <65>, <66>;
+			interrupt-names = "tx", "rx0", "rx1", "sce";
+			resets = <&rcc STM32F4_APB1_RESET(CAN2)>;
+			clocks = <&rcc 0 STM32F4_APB1_CLOCK(CAN2)>;
+			st,gcan = <&gcan>;
+			status = "disabled";
+		};
+
 		dac: dac@40007400 {
 			compatible = "st,stm32f4-dac-core";
 			reg = <0x40007400 0x400>;
-- 
2.32.0

