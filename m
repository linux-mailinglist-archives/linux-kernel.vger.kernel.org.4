Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A045F4AFA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 23:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiJDVfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 17:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiJDVfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 17:35:10 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DA4520AB;
        Tue,  4 Oct 2022 14:35:08 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id b15so5906836pje.1;
        Tue, 04 Oct 2022 14:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=VxhM66mMMUQbnYR8BIES2RN9lh3AWlJeJAa9Fgty5So=;
        b=b7hC7vRRtEXFCYyZxaj+EWPRsUKYnWuZw1FX9KcRCTkqra5waRPl9Fuay2F/ST4gKv
         9mPF4JXkqPUt5hVTvqoO5WBb2giRQA9m7FnGPisbRUA4MLLANY6y2hy7ojM0YScGNe7c
         n70gRO+i+la2JZXG1iZLHLLWmIS11kTMZnYrPo+wjhveK3EbYEwDkIH25gTeMsTcbh6g
         H68D4y6359V0uTFPPDRWtrikkYx69Ad/JPfRmQ5LU5MYopdRj1muucD6AChnea85oQ3W
         DFjEDGXOrVknN4vI3CKBP+7iJV+LMyq2/M33uyfOeQYIqBbNLOQ5hmPtCd+2xhHvf75K
         zqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=VxhM66mMMUQbnYR8BIES2RN9lh3AWlJeJAa9Fgty5So=;
        b=oNNHWm3E7UoZJSSrWxwcKUF1Kdn2APq79MEmW432LbQWyMnQAVj1Wd+jN0qy+ja+L7
         Vhypxqvl897UydGgfmQMcTbq3+OzUGpwdtAsyrmIiSsE6crwvhrHq0inMwbmc7EQEzrX
         T55FQ6u5Ul0LyzHTRiP/VPeopB7oTHojtm3+eBcicoTyZlCqBKPMeamr7vdKM7Fvpu5V
         gtnX0LQ39iDt0a9ney8CmYujnMtim7g/RxlE+ALo2be92AuzWGrwIqW2JcCUnLm3K+O5
         SVxRp525JmZS8g9bjyzwHNLCKrUI2CBUUvkfPP9U9gicstLaGbGQ8O9cdUD3QEQxEXTs
         h4tg==
X-Gm-Message-State: ACrzQf2+Kvejz9wI4nQECXdn6DcTt3EpGgzM18PKR3xd8tsWO1hGL/gq
        htdM3Tjl4+Rq5K/YExFRjP1f0q5aWW4=
X-Google-Smtp-Source: AMsMyM4Xo0MrP6m95yQTu2zoNqaIxVAFAUc1CXY3o4Q9AcskF1uInnflpvVWA0f39QpbEFM2jal3JA==
X-Received: by 2002:a17:90a:aa96:b0:205:bb67:a85f with SMTP id l22-20020a17090aaa9600b00205bb67a85fmr1652256pjq.202.1664919307565;
        Tue, 04 Oct 2022 14:35:07 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:978:a034:8ff4:b4b5])
        by smtp.gmail.com with ESMTPSA id y187-20020a6232c4000000b0055f209690c0sm7675219pfy.50.2022.10.04.14.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 14:35:06 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] ARM: dts: omap3-n900: fix LCD reset line polarity
Date:   Tue,  4 Oct 2022 14:35:00 -0700
Message-Id: <20221004213503.848262-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
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

The LCD driver (panel-sony-acx565akm), when probing, starts with line
driven low, and then toggles it to high and keeps it there. Also, the
line is driven low when powering off the device, and ls released when
powering it back on. This means that the reset line should be described
as "active low" in DTS. This will be important when the driver is
converted to gpiod API which respects the polarity declared in DTS.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/boot/dts/omap3-n900.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index dd7971556449..c2e5bde19452 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -1038,7 +1038,7 @@ lcd: acx565akm@2 {
 		pinctrl-0 = <&acx565akm_pins>;
 
 		label = "lcd";
-		reset-gpios = <&gpio3 26 GPIO_ACTIVE_HIGH>; /* 90 */
+		reset-gpios = <&gpio3 26 GPIO_ACTIVE_LOW>; /* 90 */
 
 		port {
 			lcd_in: endpoint {
-- 
2.38.0.rc1.362.ged0d419d3c-goog

