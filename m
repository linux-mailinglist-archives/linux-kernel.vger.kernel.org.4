Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1607E651C1A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 09:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbiLTICZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 03:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbiLTIB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 03:01:59 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A2813F95;
        Tue, 20 Dec 2022 00:01:58 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id t2so11514185ply.2;
        Tue, 20 Dec 2022 00:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cn9sFYqIGbUunzJ/h1lkLLrsgoXDUwwaBnwYE/8qbO4=;
        b=boQBueAK+MllFRt+huvohf4L7VYUzk0TicrIJE5Yg+ZbwQQUNgVyjvgKrmojKPTadC
         1mi7J+6CiEfWZhy+yFMfhkXHM1RoRXiWwLIzwzxRggB0a9o4jxmflAHR9KYHVsCKDPyL
         8l6QEAgafhCll0i//bQJDQIg7b8EvNWtPtTkRSfM3SIHLQL9QnnLFSaIjCyIXXf3XfB0
         3T65dSGI/b1UBTfGCaHp8co4AawmnAhT+6RQpERM8x7HHvIehx2qRNuyWLckt1BCcLm4
         EwHHqWneU2SN3aWO9w5bxliWnT5Z5lFI3VvjMFknqgW8UcB16XkAYvJumtvurb9gEBVI
         RUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cn9sFYqIGbUunzJ/h1lkLLrsgoXDUwwaBnwYE/8qbO4=;
        b=TbMx3qrlFv8jrmeN7KyKihTyeZkNtuAGfXc5RHcuul3846vyl8y3dOkxkOyyOoq5FJ
         KoyDaf8bxdMO0+27AnGcq3hHlGDcqQRstp+PNemUbkFKCBXs+RSvZ9S7OroGR9TkUoyT
         hMIYkmmjZDZCq07USbnKlOtZ8v5i3wMTAfFkI45UrW59vhndYo4539W7c1TQwJNO5erv
         /NRLugQLOohtfT+XxWd7YcmQgEQP7M9tO/2UOJiKuIvTjxH7eXlg8F/UK4tuTZkU55ST
         WExt/OHXLEAkstXgHJgAhsxVS7uQH0lH0IbRRMjkD/6CtD6icNI/CzqCNHg93fHAIy+k
         15MA==
X-Gm-Message-State: AFqh2koLxNqbz3wdIUrd8GrT8uhTGTFzbcJBiNQFH26e11d/yyIi7t/D
        QAwiAAyyuNDVe27rnjhAf0c=
X-Google-Smtp-Source: AMrXdXvGVaCuW8BstMZUCIUBRCXv7DaUOthBPlGx2Hh+ViA88FYbhCNh1vaxhPxPFf6xT4We9sP2oQ==
X-Received: by 2002:a05:6a20:3d25:b0:af:953a:12b2 with SMTP id y37-20020a056a203d2500b000af953a12b2mr29479761pzi.43.1671523318093;
        Tue, 20 Dec 2022 00:01:58 -0800 (PST)
Received: from localhost.localdomain ([180.217.146.214])
        by smtp.gmail.com with ESMTPSA id u15-20020a65670f000000b00476d1385265sm7559179pgf.25.2022.12.20.00.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 00:01:57 -0800 (PST)
From:   Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To:     JJLIU0@nuvoton.com, KWLIU@nuvoton.com, jim.t90615@gmail.com,
        linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH v3 2/3] arm: dts: nuvoton: npcm7xx: Add sgpio feature
Date:   Tue, 20 Dec 2022 16:01:38 +0800
Message-Id: <20221220080139.1803-3-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221220080139.1803-1-JJLIU0@nuvoton.com>
References: <20221220080139.1803-1-JJLIU0@nuvoton.com>
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

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
Changes for v3:
   - modify node name
   - modify in/out property name
Changes for v2:
   - modify dts node
---
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
index c7b5ef15b716..f780474a16ce 100644
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
+				bus-frequency = <16000000>;
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
+				bus-frequency = <16000000>;
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

