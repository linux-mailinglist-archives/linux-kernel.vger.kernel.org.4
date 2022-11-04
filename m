Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA31D618F2C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 04:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiKDDix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 23:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiKDDim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 23:38:42 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BC625E6;
        Thu,  3 Nov 2022 20:38:41 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d20so2707796plr.10;
        Thu, 03 Nov 2022 20:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucUqZbR/kDPQRdKfiuudXWiRnCiCHKT9s9GBhXX4jwM=;
        b=LWfmil8f1DsRQUwuclZkyuz4wuprWIudvwX9Ra4Zjqow2C++2RUtTINPeLhyMkVEuU
         LbLz5nvJ9rPBiJj6/giSdmLlvG6zS6PHAzvGpNlqlcnwCnP6cgxz7WXYamSdAcgWM+00
         AddZ//26TtH18MNsyz9PmGTdfoxTzjcYmgwTWMWCXsFqOodqisMihsyfem2oM5CJsTxH
         4t34uzx1PAfEiTC8T+3qqH+m1WfvtelTSREbsE5tNhOaH4Koaj3+Y2bgjW6ucgRg3x0X
         z+91nvngPFpDi/w6dr+0rOZm/D75ruyum9h0PA5VHOy02+0QR9S1RmUu3wemQMQH3PJq
         HepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ucUqZbR/kDPQRdKfiuudXWiRnCiCHKT9s9GBhXX4jwM=;
        b=BxQV6QcK/yUAW7KkDFlKLhzVSJ3+L7ZhWSuINQ7k2OqTvN8XJunwHK19YgpGRcDSBc
         CV02pZpdncqTXBwpa6W2el7S1atTTuTURJPR5PZesBP664EQmXjh/rEo0K7n4o2JtnRK
         zy9E9j7fohNicPoxa8wVG7Kqvxiw2VAGCVmYyZM7TQmne0nn8Ru4J16NiL/vAPc27yXM
         tlCZFiFJYHpnzbFKG7Ev/DAqh3HpUk5S9ao2HMDXYL2R7pfQji5CzYq6sIPsVfELTM6V
         itwCo/cHhXErmU3fy5tctXMh7NQPP9c9i+mdvF9v0M0p/7i+GHeBqtnNkvxw9DEJy07L
         M3dA==
X-Gm-Message-State: ACrzQf1c7gpVyNVkVcJfaH/dA9XHobZLijgFMSetxarnpBtQ71+XO6NM
        A3OfvKLmOA1EJpNeH8j3nDxJo0rsshCFJA==
X-Google-Smtp-Source: AMsMyM5dE4H5YykBsYSZibO8HhRSLSFVb1FzvML1jk6mWgGTv5vudgXpdOtIzrLVLHZSPS8Y56Wb/w==
X-Received: by 2002:a17:90a:2a8b:b0:213:9ae5:b9ab with SMTP id j11-20020a17090a2a8b00b002139ae5b9abmr35062656pjd.110.1667533121225;
        Thu, 03 Nov 2022 20:38:41 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id f17-20020aa79d91000000b0056bb06ce1cfsm1545759pfq.97.2022.11.03.20.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 20:38:40 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com, Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v6 1/5] arm: dts: Add node for NPCM Video Capture/Encode Engine
Date:   Fri,  4 Nov 2022 11:38:06 +0800
Message-Id: <20221104033810.1324686-2-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221104033810.1324686-1-milkfafa@gmail.com>
References: <20221104033810.1324686-1-milkfafa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node for Video Capture/Differentiation Engine (VCD) and Encoding
Compression Engine (ECE) present on Nuvoton NPCM SoCs. Tested with Nuvoton
NPCM750 evaluation board.

Signed-off-by: Marvin Lin <milkfafa@gmail.com>
---
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
index c7b5ef15b716..293a550955bb 100644
--- a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
+++ b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
@@ -179,6 +179,19 @@ fiux: spi@fb001000 {
 			status = "disabled";
 		};
 
+		video: video@f0810000 {
+			compatible = "nuvoton,npcm750-video";
+			reg = <0xf0810000 0x10000>, <0xf0820000 0x2000>;
+			reg-names = "vcd", "ece";
+			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_VCD>,
+				 <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_ECE>;
+			reset-names = "vcd", "ece";
+			nuvoton,syscon-gcr = <&gcr>;
+			nuvoton,syscon-gfxi = <&gfxi>;
+			status = "disabled";
+		};
+
 		apb {
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -554,6 +567,12 @@ i2c15: i2c@8f000 {
 				pinctrl-0 = <&smb15_pins>;
 				status = "disabled";
 			};
+
+			gfxi: gfxi@e000 {
+				compatible = "nuvoton,npcm750-gfxi", "syscon",
+					     "simple-mfd";
+				reg = <0xe000 0x100>;
+			};
 		};
 	};
 
-- 
2.34.1

