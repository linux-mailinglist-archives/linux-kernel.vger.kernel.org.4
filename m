Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D323620C30
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 10:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbiKHJ3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 04:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbiKHJ3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 04:29:20 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B8C13F0F;
        Tue,  8 Nov 2022 01:29:18 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id r18so12887367pgr.12;
        Tue, 08 Nov 2022 01:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qcp59m/6g8ZeyzO1wSKvpKlbq0R7mKURt6i4dFcO8bA=;
        b=PucDMhDhbm1l7tehLVP1ERY4yKN4MhaOUebhgpIEblxD8QNLtG55cK57MA0hxo7SeC
         1CVXNcBFjpjv9Uqw9kHtZI7M5mbvvcWECuMy24EZt7yGwVGdjlCTk1kj1nnxEttGELoL
         Yhi/KcAaiNCGDcWP7+osPHQHWQRnnIdAvFztkU8fTEYECMave6ywX/TUITyUfghAF4m1
         eb5fifQGi5eRhwQiizRR/D4SS0QWZMz6ES+LfBEBc91C8WhLTA9VIOnOIXYYHFKscmtI
         oHjIF2VnEIhlUPJd2RAVh24ay+ahIvIOD8L9Q3Ng0B8SsrNnd/VDGLL8bdyWiIENFuYy
         UH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qcp59m/6g8ZeyzO1wSKvpKlbq0R7mKURt6i4dFcO8bA=;
        b=ydgTqOHRIueW5PTmFw1WkXLEEx/Ho5KIAxmIwwk7uOj+J/29f2kk+t1q7pDkgqL84L
         0D+dyabiAMzchdh3ANsK7W7O4wHB8CfqN+hPfoD8KTNUjh0i6u13RhAG/fUX3DLDcwIG
         FVnw49ScRJTdbin/BKgm+caeI9ZsFFyViX+8s8bzNKsFHDMI/xEAWRc1m5gh/xa2npdg
         X2N78FSMIKg5eUs5eQjwogjycRyjxf/HtVKHdsuy3Yv2En13m2oh2vMsPddarKu2EqFS
         6X9YQYDGhuBwXLcwRgahg65rm6SHJ6hMemNqzHdY1FlR8184WakwNO060J8dJwDXkHOL
         uChw==
X-Gm-Message-State: ACrzQf2k4Bu68LZbvJ5hQ4sAuihoAhvfnk9c8MNpmbPwfb3xQWRBxbZ0
        f+g9AnhXb6gZsy641x7SPmw=
X-Google-Smtp-Source: AMsMyM49ZA+PNOeZNBTe9yyT3If6k61VbM6eeTHMYoVYhZcd/nOTQfeySZebJnjUmxdgGFe+j0EOuQ==
X-Received: by 2002:a05:6a00:15c3:b0:56c:e8d0:aaf1 with SMTP id o3-20020a056a0015c300b0056ce8d0aaf1mr55281575pfu.75.1667899758029;
        Tue, 08 Nov 2022 01:29:18 -0800 (PST)
Received: from localhost.localdomain ([180.217.157.203])
        by smtp.gmail.com with ESMTPSA id x17-20020a170902ec9100b00186727e5f5csm6467147plg.248.2022.11.08.01.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 01:29:17 -0800 (PST)
From:   Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To:     JJLIU0@nuvoton.com, jim.t90615@gmail.com, KWLIU@nuvoton.com,
        linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org
Subject: [PATCH v2 2/3] arm: dts: nuvoton: npcm7xx: add sgpio node
Date:   Tue,  8 Nov 2022 17:28:39 +0800
Message-Id: <20221108092840.14945-3-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221108092840.14945-1-JJLIU0@nuvoton.com>
References: <20221108092840.14945-1-JJLIU0@nuvoton.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SGPIO controller to the NPCM750 devicetree

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
Changes for v2:
   - modify dts node 
---
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
index c7b5ef15b716..9cac60734b57 100644
--- a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
+++ b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
@@ -330,6 +330,36 @@
 				status = "disabled";
 			};
 
+			sgpio1: sgpio@101000 {
+				compatible = "nuvoton,npcm750-sgpio";
+				reg = <0x101000 0x200>;
+				clocks = <&clk NPCM7XX_CLK_APB3>;
+				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+				bus-frequency = <16000000>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&iox1_pins>;
+				nin_gpios = <64>;
+				nout_gpios = <64>;
+				status = "disabled";
+			};
+
+			sgpio2: sgpio@102000 {
+				compatible = "nuvoton,npcm750-sgpio";
+				reg = <0x102000 0x200>;
+				clocks = <&clk NPCM7XX_CLK_APB3>;
+				interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+				bus-frequency = <16000000>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&iox2_pins>;
+				nin_gpios = <64>;
+				nout_gpios = <64>;
+				status = "disabled";
+			};
+
 			pwm_fan: pwm-fan-controller@103000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
2.17.1

