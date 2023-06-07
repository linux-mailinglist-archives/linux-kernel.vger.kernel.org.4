Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791D6725C56
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 12:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240019AbjFGK54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 06:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240072AbjFGK5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:57:11 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F79269F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 03:56:34 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f738f579ceso29714625e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 03:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686135394; x=1688727394;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K8GFdKRMD7lVLHDPeBC4NKyqbNWVpJYg7Txx68MhvCQ=;
        b=xue/G0t7QYxpbqp7o3qZAVFXVo7ZJkAgPnTmpu0vzJHXLJZqVIDYeBNU3lOuQu4U3H
         ybI37NzziD/mrPfw+/UtsdlyTXBw0Bt0lkxdX418KV4uEK1PTvR+ClvRNDYh7JY/DjSV
         8CvdKQF6oPApoHl8s4++LD7WzIkhf0sFCJYtcu6j3DUHO2pDmgwcZYm0HK4Uo5Wq5XKq
         T5FedMpZ8lg1m+ihx4d+rVtdXNahwNZXPxGrnXuPfPXiunmdPT9/X2nzQnqhwX75eRaZ
         9nF+I2O54POZ6vZn7iyJzUVvsTRqsXLVUxpD/KBNy6GBjMAF9GxjqIdEaRH8CRZMqKWq
         vNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686135394; x=1688727394;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K8GFdKRMD7lVLHDPeBC4NKyqbNWVpJYg7Txx68MhvCQ=;
        b=WEeTol0l3BhA7pv9kXhvS2MrF1SZKqLt3sRu47aW0btmt3HoqrHAuAA+S4bguWD6ru
         njpyGwtlLhTjWrP3f7xhHcR2eRsz74DFL7BH1qdcTRAnkaztl797ak7ZzjBvMbyToeFg
         k/1GSv9NcjV6shVoKTE2OJj3oxwTevvHBlHvxoM4bNfTDmkrR7fZpQfsOOi7R44Gm1w5
         YnXY1ZRUt/9S0TE9yNdamS9gkr00ap4wo6B3Dm8KFC6joL0Dn/V6QfIkyqgCu2wwGoZ1
         BM4JAt5YoKgLQfesvb3UZBaIfDE+4DnJuOVmOQ5rH6YLPdwfx/r2jAU0bKzUmGsO8YhF
         btdQ==
X-Gm-Message-State: AC+VfDySf3ox8xsnKzqzhKARv7B+WhZ6E/RHeuGZ5TkufEH2wATkT4RS
        n0pZlTve86ctIls3V5ljy1xmmQ==
X-Google-Smtp-Source: ACHHUZ7pUAyIWBytw8If+FQsIJg8P0c6zI4hbXwlNoclwn2okeYBnLI/+38nM0dT9wjJFFIr27MBPg==
X-Received: by 2002:a7b:cc0c:0:b0:3f7:e6d7:f711 with SMTP id f12-20020a7bcc0c000000b003f7e6d7f711mr4269902wmh.7.1686135393865;
        Wed, 07 Jun 2023 03:56:33 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id i10-20020a05600c290a00b003f60faa4612sm1761879wmd.22.2023.06.07.03.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 03:56:33 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 07 Jun 2023 12:56:22 +0200
Subject: [PATCH 11/18] dt-bindings: clk: amlogic,a1-peripherals-clkc:
 expose all clock ids
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-11-9676afa6b22c@linaro.org>
References: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-0-9676afa6b22c@linaro.org>
In-Reply-To: <20230607-topic-amlogic-upstream-clkid-public-migration-v1-0-9676afa6b22c@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6446;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=oU7DoW88upfsFeorK9+1ZykeA2g9mY6VDy+3sPVMeYk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkgGJSmP/1ikqHAPkSKpFl+LOlZFrJ/pBegFA+tOsr
 DzZQaOaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIBiUgAKCRB33NvayMhJ0fzNEA
 Cd0ypTG4kyWaPKJAXrwLmP8t8Huk37AyuBsfIRooqU09EW75rBO1sKKwMSAulvyo3h50rNoUsatnEE
 iPxhZQhmoqWUuuyVfudHxVJPcljfOfkXnD97bjzykeBFlxsCLoUqSjO/zGhDE+5St+iSOb5AtSkQz5
 Z7YbpxkkiNeBo8TiTVK9p0trSUs7/+7hL/kw9n0omJfN++sIqX80AItyNz6N8j16yj2ErZ26k9AA/0
 07l4R6kEHRdDyfZYIWV/AFLDoED2jhyP38Xg4eozlEefw3RNqV+cxRpEOqkc5HArCTMHaR25LdbGo3
 uW4uYPOs1qMXYTYswHJZpumm0WWXqcXa9CVlYFqsCKKE9FdC1nAbsnRpVbOk/7dltZMyH1PG3vh93S
 qqrA2GIV4p4keQqaUr3oqD46c7IOI0O3Nu/98+WfVs9cxQk97C0RnQFpQn8yP0Q8tZyjMGuJcHz00z
 LXs5f1A5cCIGgubrror+hWWldpX6hxIgxBC7eYn5EIQa/dtS6NWi3Fis+grNrW4D7dkbjIZdENV2uV
 wKPnoV36b+7TuTunq7YSZ+/nNaYuIQmGO7/VudR4+JRMiH2CC5NBtCzdIuloaQ6wsBztfn7LAkzumG
 92+J5/6lsa+UPN2ZN0FCdjUPwMapcLlf2MjcMx2nsL/nlCaLOZsrKXWtc4rQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to a policy change in clock ID bindings handling, expose
all the "private" clock IDs to the public clock dt-bindings
to move out of the previous maintenance scheme.

This refers to a discussion at [1] & [2] with Krzysztof about
the issue with the current maintenance.

It was decided to move every A1 peripherals ID to the public clock
dt-bindings headers to be merged in a single tree so we
can safely add new clocks without having merge issues.

[1] https://lore.kernel.org/all/c088e01c-0714-82be-8347-6140daf56640@linaro.org/
[2] https://lore.kernel.org/all/2fabe721-7434-43e7-bae5-088a42ba128d@app.fastmail.com/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/clk/meson/a1-peripherals.h                 | 63 ----------------------
 .../clock/amlogic,a1-peripherals-clkc.h            | 53 ++++++++++++++++++
 2 files changed, 53 insertions(+), 63 deletions(-)

diff --git a/drivers/clk/meson/a1-peripherals.h b/drivers/clk/meson/a1-peripherals.h
index 4d60456a95a9..842b52634ed0 100644
--- a/drivers/clk/meson/a1-peripherals.h
+++ b/drivers/clk/meson/a1-peripherals.h
@@ -46,67 +46,4 @@
 /* include the CLKIDs that have been made part of the DT binding */
 #include <dt-bindings/clock/amlogic,a1-peripherals-clkc.h>
 
-/*
- * CLKID index values for internal clocks
- *
- * These indices are entirely contrived and do not map onto the hardware.
- * It has now been decided to expose everything by default in the DT header:
- * include/dt-bindings/clock/a1-peripherals-clkc.h.
- * Only the clocks ids we don't want to expose, such as the internal muxes and
- * dividers of composite clocks, will remain defined here.
- */
-#define CLKID_XTAL_IN		0
-#define CLKID_DSPA_SEL		61
-#define CLKID_DSPB_SEL		62
-#define CLKID_SARADC_SEL	74
-#define CLKID_SYS_A_SEL		89
-#define CLKID_SYS_A_DIV		90
-#define CLKID_SYS_A		91
-#define CLKID_SYS_B_SEL		92
-#define CLKID_SYS_B_DIV		93
-#define CLKID_SYS_B		94
-#define CLKID_DSPA_A_DIV	96
-#define CLKID_DSPA_A		97
-#define CLKID_DSPA_B_DIV	99
-#define CLKID_DSPA_B		100
-#define CLKID_DSPB_A_DIV	102
-#define CLKID_DSPB_A		103
-#define CLKID_DSPB_B_DIV	105
-#define CLKID_DSPB_B		106
-#define CLKID_RTC_32K_IN	107
-#define CLKID_RTC_32K_DIV	108
-#define CLKID_RTC_32K_XTAL	109
-#define CLKID_RTC_32K_SEL	110
-#define CLKID_CECB_32K_IN	111
-#define CLKID_CECB_32K_DIV	112
-#define CLKID_CECA_32K_IN	115
-#define CLKID_CECA_32K_DIV	116
-#define CLKID_DIV2_PRE		119
-#define CLKID_24M_DIV2		120
-#define CLKID_GEN_DIV		122
-#define CLKID_SARADC_DIV	123
-#define CLKID_PWM_A_DIV		125
-#define CLKID_PWM_B_DIV		127
-#define CLKID_PWM_C_DIV		129
-#define CLKID_PWM_D_DIV		131
-#define CLKID_PWM_E_DIV		133
-#define CLKID_PWM_F_DIV		135
-#define CLKID_SPICC_SEL		136
-#define CLKID_SPICC_DIV		137
-#define CLKID_SPICC_SEL2	138
-#define CLKID_TS_DIV		139
-#define CLKID_SPIFC_SEL		140
-#define CLKID_SPIFC_DIV		141
-#define CLKID_SPIFC_SEL2	142
-#define CLKID_USB_BUS_SEL	143
-#define CLKID_USB_BUS_DIV	144
-#define CLKID_SD_EMMC_SEL	145
-#define CLKID_SD_EMMC_DIV	146
-#define CLKID_PSRAM_SEL		148
-#define CLKID_PSRAM_DIV		149
-#define CLKID_PSRAM_SEL2	150
-#define CLKID_DMC_SEL		151
-#define CLKID_DMC_DIV		152
-#define CLKID_DMC_SEL2		153
-
 #endif /* __A1_PERIPHERALS_H */
diff --git a/include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h b/include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h
index ff2730f398a6..06f198ee7623 100644
--- a/include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h
+++ b/include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h
@@ -10,6 +10,7 @@
 #ifndef __A1_PERIPHERALS_CLKC_H
 #define __A1_PERIPHERALS_CLKC_H
 
+#define CLKID_XTAL_IN		0
 #define CLKID_FIXPLL_IN		1
 #define CLKID_USB_PHY_IN	2
 #define CLKID_USB_CTRL_IN	3
@@ -70,6 +71,8 @@
 #define CLKID_CPU_CTRL		58
 #define CLKID_ROM		59
 #define CLKID_PROC_I2C		60
+#define CLKID_DSPA_SEL		61
+#define CLKID_DSPB_SEL		62
 #define CLKID_DSPA_EN		63
 #define CLKID_DSPA_EN_NIC	64
 #define CLKID_DSPB_EN		65
@@ -81,6 +84,7 @@
 #define CLKID_12M		71
 #define CLKID_FCLK_DIV2_DIVN	72
 #define CLKID_GEN		73
+#define CLKID_SARADC_SEL	74
 #define CLKID_SARADC		75
 #define CLKID_PWM_A		76
 #define CLKID_PWM_B		77
@@ -95,21 +99,70 @@
 #define CLKID_SD_EMMC		86
 #define CLKID_PSRAM		87
 #define CLKID_DMC		88
+#define CLKID_SYS_A_SEL		89
+#define CLKID_SYS_A_DIV		90
+#define CLKID_SYS_A		91
+#define CLKID_SYS_B_SEL		92
+#define CLKID_SYS_B_DIV		93
+#define CLKID_SYS_B		94
 #define CLKID_DSPA_A_SEL	95
+#define CLKID_DSPA_A_DIV	96
+#define CLKID_DSPA_A		97
 #define CLKID_DSPA_B_SEL	98
+#define CLKID_DSPA_B_DIV	99
+#define CLKID_DSPA_B		100
 #define CLKID_DSPB_A_SEL	101
+#define CLKID_DSPB_A_DIV	102
+#define CLKID_DSPB_A		103
 #define CLKID_DSPB_B_SEL	104
+#define CLKID_DSPB_B_DIV	105
+#define CLKID_DSPB_B		106
+#define CLKID_RTC_32K_IN	107
+#define CLKID_RTC_32K_DIV	108
+#define CLKID_RTC_32K_XTAL	109
+#define CLKID_RTC_32K_SEL	110
+#define CLKID_CECB_32K_IN	111
+#define CLKID_CECB_32K_DIV	112
 #define CLKID_CECB_32K_SEL_PRE	113
 #define CLKID_CECB_32K_SEL	114
+#define CLKID_CECA_32K_IN	115
+#define CLKID_CECA_32K_DIV	116
 #define CLKID_CECA_32K_SEL_PRE	117
 #define CLKID_CECA_32K_SEL	118
+#define CLKID_DIV2_PRE		119
+#define CLKID_24M_DIV2		120
 #define CLKID_GEN_SEL		121
+#define CLKID_GEN_DIV		122
+#define CLKID_SARADC_DIV	123
 #define CLKID_PWM_A_SEL		124
+#define CLKID_PWM_A_DIV		125
 #define CLKID_PWM_B_SEL		126
+#define CLKID_PWM_B_DIV		127
 #define CLKID_PWM_C_SEL		128
+#define CLKID_PWM_C_DIV		129
 #define CLKID_PWM_D_SEL		130
+#define CLKID_PWM_D_DIV		131
 #define CLKID_PWM_E_SEL		132
+#define CLKID_PWM_E_DIV		133
 #define CLKID_PWM_F_SEL		134
+#define CLKID_PWM_F_DIV		135
+#define CLKID_SPICC_SEL		136
+#define CLKID_SPICC_DIV		137
+#define CLKID_SPICC_SEL2	138
+#define CLKID_TS_DIV		139
+#define CLKID_SPIFC_SEL		140
+#define CLKID_SPIFC_DIV		141
+#define CLKID_SPIFC_SEL2	142
+#define CLKID_USB_BUS_SEL	143
+#define CLKID_USB_BUS_DIV	144
+#define CLKID_SD_EMMC_SEL	145
+#define CLKID_SD_EMMC_DIV	146
 #define CLKID_SD_EMMC_SEL2	147
+#define CLKID_PSRAM_SEL		148
+#define CLKID_PSRAM_DIV		149
+#define CLKID_PSRAM_SEL2	150
+#define CLKID_DMC_SEL		151
+#define CLKID_DMC_DIV		152
+#define CLKID_DMC_SEL2		153
 
 #endif /* __A1_PERIPHERALS_CLKC_H */

-- 
2.34.1

