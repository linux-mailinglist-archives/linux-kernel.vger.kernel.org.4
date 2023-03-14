Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB546B8E98
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 10:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjCNJYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 05:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjCNJX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 05:23:56 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166021A94E;
        Tue, 14 Mar 2023 02:23:50 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso14496193pjs.3;
        Tue, 14 Mar 2023 02:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678785829;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JeKGVI/WC03eOlEsJdjFv73hArgX9QnpUzvIn6G04v4=;
        b=qiPeyJnsv+K8pS31WF4x9qNz9Dlqtc6TdPYkmbUuD3aNglFVrK8MPt8LAXha7/CXSr
         dVQZEuZz+Eq3qSw5sRYjfSreGWxd4QOcA8HoZ00VPmOXcRlLKtKd0n937xOikElDbGDa
         6YS/qXgkRbsM16tz0qs3CgNUw0fe8QfRxqmiysRUG1ubBSmdfWcaX5SjaqMJsup3rYIN
         NdtoGVvbAJyDZcal5UNeiKTnecz4mvd+flBOXY0AbK5Zm9lsvUMUyF58dBNNkU6ge30h
         9oz/aU7QzSCTBaRiAkJg7ruqUiTGs4R90I9gmTWmtx1m5WVu1pOKzSpQi+8oUydX4pTu
         qBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678785829;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JeKGVI/WC03eOlEsJdjFv73hArgX9QnpUzvIn6G04v4=;
        b=484A9AU3yn+cY4/hN9dv/DbosvQqKAzaZBabic1v5h8Eqy3e4uRD3XtULyNYCCJ77q
         a2L/WFj52Zs2kBgCW2tuguH4q93GrykqnX9kjEt3+6sL4gqrckZjN0vIyCXkQ4fDioK9
         5VgnaeWJGrU44y/u0isRrnyKqjcQwbqx772gfXKh5zMmxnAa+zQbTqrWK/bn+KOd0ZMV
         v4aocj6YE4uwfJUrdmHqwOwU8Ces0+k8ClchrqHRuUdFAdW/+uFlrI5Mod6PYDRDiIAx
         SHdBA6k18+YgFHjwA4GxHapkk/FfBuLeP+CNXQrgTeGKFcagYzOS2Uq9cYvGxb8Pd4DX
         L+LQ==
X-Gm-Message-State: AO0yUKX61+50iNmz3nNvmXiqHNDXA5WvZS6FivZMb0TSyn9SBv48Bzx1
        3j2QFW3cb9BW3uzvs0BGeWc=
X-Google-Smtp-Source: AK7set+FoHFfxEBpFdnc+802scctAQgZN9haiL/SY42/nK47FPrdGr6/MGf4tMTpfuKyczxPhR3Q8Q==
X-Received: by 2002:a05:6a20:d49b:b0:bc:b9d2:f0f8 with SMTP id im27-20020a056a20d49b00b000bcb9d2f0f8mr34449267pzb.24.1678785829524;
        Tue, 14 Mar 2023 02:23:49 -0700 (PDT)
Received: from localhost.localdomain ([1.200.129.193])
        by smtp.gmail.com with ESMTPSA id f21-20020aa782d5000000b00592626fe48csm1120898pfn.122.2023.03.14.02.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 02:23:49 -0700 (PDT)
From:   Jim Liu <jim.t90615@gmail.com>
To:     JJLIU0@nuvoton.com, KWLIU@nuvoton.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, jim.t90615@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH v5 2/3] arm: dts: nuvoton: npcm: Add sgpio feature
Date:   Tue, 14 Mar 2023 17:23:10 +0800
Message-Id: <20230314092311.8924-3-jim.t90615@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230314092311.8924-1-jim.t90615@gmail.com>
References: <20230314092311.8924-1-jim.t90615@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SGPIO controller to the NPCM7xx devicetree

Signed-off-by: Jim Liu <jim.t90615@gmail.com>
---
Changes for v5:
   - remove npcm8xx node
Changes for v4:
   - add npcm8xx gpio node
Changes for v3:
   - modify node name
   - modify in/out property name
Changes for v2:
   - modify dts node
---
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
index c7b5ef15b716..7f53774a01ec 100644
--- a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
+++ b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
@@ -330,6 +330,36 @@
 				status = "disabled";
 			};
 
+			gpio8: gpio@101000 {
+				compatible = "nuvoton,npcm750-sgpio";
+				reg = <0x101000 0x200>;
+				clocks = <&clk NPCM7XX_CLK_APB3>;
+				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+				bus-frequency = <8000000>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&iox1_pins>;
+				nuvoton,input-ngpios = <64>;
+				nuvoton,output-ngpios = <64>;
+				status = "disabled";
+			};
+
+			gpio9: gpio@102000 {
+				compatible = "nuvoton,npcm750-sgpio";
+				reg = <0x102000 0x200>;
+				clocks = <&clk NPCM7XX_CLK_APB3>;
+				interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+				bus-frequency = <8000000>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&iox2_pins>;
+				nuvoton,input-ngpios = <64>;
+				nuvoton,output-ngpios = <64>;
+				status = "disabled";
+			};
+
 			pwm_fan: pwm-fan-controller@103000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
2.17.1

