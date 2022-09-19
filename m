Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7415BD32E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiISRFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiISREn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:04:43 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A4C3E76D;
        Mon, 19 Sep 2022 10:03:51 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o5so17262040wms.1;
        Mon, 19 Sep 2022 10:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=m5hdKCMrXjDt6ZA2ndwEUQquAl5ne5bCVuc8YArZ/7c=;
        b=m+MfKc90fGD4L/oI2AaaFE9RlOk6vl1s7sMOECgcWLiDQnumbnNtTgXlTyp+5UpKhA
         vtzOMMIKiMbsThE7sLxsl0IE3uGrvY8gwkt7fMNamS3uZRAjgaPu4Pazt8wx6Bmq9V4U
         glu5jvmGoUfMYmL2PNGp2izMTnUvNqG5KlXqk5pMzNeGYlWQ6wA/czfJH3/EmUc+COMU
         V1HZDYz9Q8ZbieHB6qiUaeWx0TPUEyYvtv3kHvnTMhMSW6FpPCSu2Ekaf5LSR69NKSBa
         DGa8JRh3icazAaID4FMH2hnzOwljeX2nYZM8+t6U4IWT5G5HGOyJfHVHyt+6Z+IknEPZ
         TpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=m5hdKCMrXjDt6ZA2ndwEUQquAl5ne5bCVuc8YArZ/7c=;
        b=7wT/xm+6aR9vXJyGv4MheS52EQv6J6GvYyMEw1slNPmcu0TC8J8E5SHzdLXqkkPuTe
         yomJABtCQpFev7nbQcdTCiV3of+NmFgvwODuESCblcxjKaOBfqGruerg/bJ2Esu3UkLX
         cT9HfzAkjjIKQJaBs/SZc1wyxxpBmKyUIyTbRk5FAuQstiFud03w7PQ1KFjNh3zT7XFt
         DcgYbnH0N1k4RMxOjXexFilXevOAdcPILWMR4mH30ETpUv+hZ+MSfOP8MmcgluS/YBnF
         WhTusAvN8+Hjcna8mdreivBVmxTP6ozp+REfudMcpGNpddyeWBtwPzhovaLCF10dbGOM
         iqSQ==
X-Gm-Message-State: ACrzQf2kpzRzAyUNSTzpjmIIqNslRObyjPcPq4Pf9dzy3QSsOn9SyqWK
        y7VYc9qSQxmsDrajglqKZXg=
X-Google-Smtp-Source: AMsMyM6Eyf/xv2UKj5yaHzqoan8SSawWq4SBia09Cw+BlUx4cWw5euSoYAXYtcVY+EnOtqmEG20M9Q==
X-Received: by 2002:a1c:440b:0:b0:3b3:330d:88d8 with SMTP id r11-20020a1c440b000000b003b3330d88d8mr13286916wma.31.1663607030190;
        Mon, 19 Sep 2022 10:03:50 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id ci10-20020a5d5d8a000000b0021e6c52c921sm17562487wrb.54.2022.09.19.10.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 10:03:49 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] arm64: dts: mediatek: mt6797: Make pin configuration nodes follow DT bindings
Date:   Mon, 19 Sep 2022 20:01:13 +0300
Message-Id: <20220919170115.94873-3-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220919170115.94873-1-y.oudjana@protonmail.com>
References: <20220919170115.94873-1-y.oudjana@protonmail.com>
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

Add -pins suffix to pin configuration nodes to follow DT bindings
and pass dtbs_check.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 arch/arm64/boot/dts/mediatek/mt6797.dtsi | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt6797.dtsi b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
index 15616231022a..0c2b477184ae 100644
--- a/arch/arm64/boot/dts/mediatek/mt6797.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
@@ -135,70 +135,70 @@ pio: pinctrl@10005000 {
 		gpio-controller;
 		#gpio-cells = <2>;
 
-		uart0_pins_a: uart0 {
+		uart0_pins_a: uart0-pins {
 			pins0 {
 				pinmux = <MT6797_GPIO234__FUNC_UTXD0>,
 					 <MT6797_GPIO235__FUNC_URXD0>;
 			};
 		};
 
-		uart1_pins_a: uart1 {
+		uart1_pins_a: uart1-pins {
 			pins1 {
 				pinmux = <MT6797_GPIO232__FUNC_URXD1>,
 					 <MT6797_GPIO233__FUNC_UTXD1>;
 			};
 		};
 
-		i2c0_pins_a: i2c0 {
+		i2c0_pins_a: i2c0-pins {
 			pins0 {
 				pinmux = <MT6797_GPIO37__FUNC_SCL0_0>,
 					 <MT6797_GPIO38__FUNC_SDA0_0>;
 			};
 		};
 
-		i2c1_pins_a: i2c1 {
+		i2c1_pins_a: i2c1-pins {
 			pins1 {
 				pinmux = <MT6797_GPIO55__FUNC_SCL1_0>,
 					 <MT6797_GPIO56__FUNC_SDA1_0>;
 			};
 		};
 
-		i2c2_pins_a: i2c2 {
+		i2c2_pins_a: i2c2-pins {
 			pins2 {
 				pinmux = <MT6797_GPIO96__FUNC_SCL2_0>,
 					 <MT6797_GPIO95__FUNC_SDA2_0>;
 			};
 		};
 
-		i2c3_pins_a: i2c3 {
+		i2c3_pins_a: i2c3-pins {
 			pins3 {
 				pinmux = <MT6797_GPIO75__FUNC_SDA3_0>,
 					 <MT6797_GPIO74__FUNC_SCL3_0>;
 			};
 		};
 
-		i2c4_pins_a: i2c4 {
+		i2c4_pins_a: i2c4-pins {
 			pins4 {
 				pinmux = <MT6797_GPIO238__FUNC_SDA4_0>,
 					 <MT6797_GPIO239__FUNC_SCL4_0>;
 			};
 		};
 
-		i2c5_pins_a: i2c5 {
+		i2c5_pins_a: i2c5-pins {
 			pins5 {
 				pinmux = <MT6797_GPIO240__FUNC_SDA5_0>,
 					 <MT6797_GPIO241__FUNC_SCL5_0>;
 			};
 		};
 
-		i2c6_pins_a: i2c6 {
+		i2c6_pins_a: i2c6-pins {
 			pins6 {
 				pinmux = <MT6797_GPIO152__FUNC_SDA6_0>,
 					 <MT6797_GPIO151__FUNC_SCL6_0>;
 			};
 		};
 
-		i2c7_pins_a: i2c7 {
+		i2c7_pins_a: i2c7-pins {
 			pins7 {
 				pinmux = <MT6797_GPIO154__FUNC_SDA7_0>,
 					 <MT6797_GPIO153__FUNC_SCL7_0>;
-- 
2.37.3

