Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E516F84C9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 16:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbjEEOYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 10:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjEEOYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 10:24:17 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D7916365;
        Fri,  5 May 2023 07:24:13 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-2fddb442d47so1688475f8f.2;
        Fri, 05 May 2023 07:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683296652; x=1685888652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PlDyLjFrRP+hfZ2TWXEpRe3b1GLGrGjhoymBjZ3qVLc=;
        b=p10HuDCV36ISVIMZatgDP0FktkLduGhvkpGCxgulHVNaJ9kUUr9hIaCQg1tY58GrWu
         trtEAppma+1beNjHAFHgTdXEzIsV45MP6lW7Og0NObFS/qVebz7Fu9EoBnE6PqZh298g
         k+qDO8IimllK3J2P15ut6B3J7FmPAPSXD+oSi+9LzmXkt7nbkqiKFCl38rnN5CjmVkDF
         u9jok73k7RKLhS5hpJtqZAtUr7cc4TniV/LG7L1/nw7Ny6/Je7JLjKPrxGDf24U5vU/A
         IMzVPoHMUv3/s3Aod35t+DthrUkswkql2SRKe6x8wnHOWynOuVqM8ksWWNwu65QOVuS4
         CBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683296652; x=1685888652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PlDyLjFrRP+hfZ2TWXEpRe3b1GLGrGjhoymBjZ3qVLc=;
        b=P7hBxEHFsS6rsu173EmQyXvCM8mZ4miAi9OS7gQYcZv61tJYBwgMEVjkzGRAgtgyJc
         YwJxugX2sLaJipqD6vgzf99X6TSOZFXjQ9hIVLzwYaonKuNmr1y1z/RyviEjs6BY72yE
         dp4/C4xHL2/dfhp1szngUxybw44drvDtzblPa/DLneoassunrGUCUJjEGgiT5OZKwuOv
         9kYSD0isJL7NpasERoec+K8fV9/Bg7uyAUhudwwSoxnv3yqJO0PHCQCXX5/vyxd2uFMf
         sdJGfo4H5zmwjyyrRhlXdDAH0avDX+QGdsj1vffZ8vb2h8hDZG4N9B9DXGmcx4hYscUu
         l2QA==
X-Gm-Message-State: AC+VfDz34ESOItJ5a4BQ4mJWnOdF+Bvc17pb64ms0HCqH5yJThAof7SE
        vRd32JITogHMqWQmQXWlrxs=
X-Google-Smtp-Source: ACHHUZ6F2f+oOlyXN55d8B0CDJM7mlvzRBv6v2gvWCvMTu1f9wQkEBlU8qrrck4PxF1uew6G807Pog==
X-Received: by 2002:adf:dd82:0:b0:306:287c:7106 with SMTP id x2-20020adfdd82000000b00306287c7106mr1557295wrl.54.1683296651675;
        Fri, 05 May 2023 07:24:11 -0700 (PDT)
Received: from localhost ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id k9-20020adfe8c9000000b0030642f5da27sm2562969wrn.37.2023.05.05.07.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 07:24:10 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     tsbogend@alpha.franken.de
Cc:     paul@crapouillou.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mips: dts: ingenic: Remove unnecessary AIC clocks
Date:   Fri,  5 May 2023 15:24:00 +0100
Message-Id: <20230505142400.1270848-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "ext" and "pll half" clocks don't belong in the DT. They are
not consumed directly by the AIC and are only used as the parent
clocks of the "i2s" clock. An operating system should be able to
figure out that information itself because it presumably knows the
layout of the clock tree.

Removing these from the DT should be safe from a compatibility
point of view because the jz4740-i2s driver in Linux does not, and
never did depend on them.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Link: https://lore.kernel.org/all/20221028103418.17578-1-aidanmacdonald.0x0@gmail.com/
---
This is a resend of patch 2/3 from a previous submission which is linked above.

v1->v2: updated commit message

 arch/mips/boot/dts/ingenic/jz4725b.dtsi | 7 ++-----
 arch/mips/boot/dts/ingenic/jz4740.dtsi  | 7 ++-----
 arch/mips/boot/dts/ingenic/jz4770.dtsi  | 5 ++---
 3 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/jz4725b.dtsi b/arch/mips/boot/dts/ingenic/jz4725b.dtsi
index e9e48022f631..acbbe8c4664c 100644
--- a/arch/mips/boot/dts/ingenic/jz4725b.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4725b.dtsi
@@ -198,11 +198,8 @@ aic: audio-controller@10020000 {
 
 		#sound-dai-cells = <0>;
 
-		clocks = <&cgu JZ4725B_CLK_AIC>,
-			 <&cgu JZ4725B_CLK_I2S>,
-			 <&cgu JZ4725B_CLK_EXT>,
-			 <&cgu JZ4725B_CLK_PLL_HALF>;
-		clock-names = "aic", "i2s", "ext", "pll half";
+		clocks = <&cgu JZ4725B_CLK_AIC>, <&cgu JZ4725B_CLK_I2S>;
+		clock-names = "aic", "i2s";
 
 		interrupt-parent = <&intc>;
 		interrupts = <10>;
diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi b/arch/mips/boot/dts/ingenic/jz4740.dtsi
index 7f76cba03a08..bdd6f4d82ec9 100644
--- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
@@ -192,11 +192,8 @@ aic: audio-controller@10020000 {
 		interrupt-parent = <&intc>;
 		interrupts = <18>;
 
-		clocks = <&cgu JZ4740_CLK_AIC>,
-			 <&cgu JZ4740_CLK_I2S>,
-			 <&cgu JZ4740_CLK_EXT>,
-			 <&cgu JZ4740_CLK_PLL_HALF>;
-		clock-names = "aic", "i2s", "ext", "pll half";
+		clocks = <&cgu JZ4740_CLK_AIC>, <&cgu JZ4740_CLK_I2S>;
+		clock-names = "aic", "i2s";
 
 		dmas = <&dmac 25 0xffffffff>, <&dmac 24 0xffffffff>;
 		dma-names = "rx", "tx";
diff --git a/arch/mips/boot/dts/ingenic/jz4770.dtsi b/arch/mips/boot/dts/ingenic/jz4770.dtsi
index bda0a3a86ed5..9c0099919db7 100644
--- a/arch/mips/boot/dts/ingenic/jz4770.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4770.dtsi
@@ -238,9 +238,8 @@ aic: audio-controller@10020000 {
 
 		#sound-dai-cells = <0>;
 
-		clocks = <&cgu JZ4770_CLK_AIC>, <&cgu JZ4770_CLK_I2S>,
-			 <&cgu JZ4770_CLK_EXT>, <&cgu JZ4770_CLK_PLL0>;
-		clock-names = "aic", "i2s", "ext", "pll half";
+		clocks = <&cgu JZ4770_CLK_AIC>, <&cgu JZ4770_CLK_I2S>;
+		clock-names = "aic", "i2s";
 
 		interrupt-parent = <&intc>;
 		interrupts = <34>;
-- 
2.39.2

