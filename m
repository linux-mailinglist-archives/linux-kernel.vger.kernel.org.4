Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05136F92BC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 17:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbjEFP36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 11:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbjEFP3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 11:29:50 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F81F1A4AC
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 08:29:49 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f1394cb0d1so3287208e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 08:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683386987; x=1685978987;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4qtQZvewa01bd3WNJlBR7VuLAaPubF3IprbkAp3R6jI=;
        b=rhuQY7bo7jkXWsQzOXHpflGgCgLdqnVRcCihN51Y9WQwdrcHNtLEMKbqkNuARXYgi/
         NcTP6lA8O/JTb+wbiiXPdeyw2r4vOVb4c/2oZz7oOvpvX7xszULlw2HX1O9sFU2A36n8
         IQHdV/NcGoUKxnChKWA/OiaSOnxeMS5SuH8leoPO18dpv0pto3li4LFhpNP2QTu/OURc
         jY93voIUXGtjUAp0WAR75xrNW4pkQFozS4OM0KWwTcGj2hLrvevxDLnuSWz7Dw5KMSHl
         J3NhFjjRCU1rsuN6LcF7erX3lQIXqAl3uNGXuJzMIRbrJFcm5OjTPPsb/4/6phXQ9fNA
         EhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683386987; x=1685978987;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qtQZvewa01bd3WNJlBR7VuLAaPubF3IprbkAp3R6jI=;
        b=cGxscifXw0hLA+kkF7maYuJZprwY5e4GgZ9JpapYOIsi8pevNI1ttS61z0W0DJBZ3s
         Yf6sscBKayGM8da8cThdAbtojlWGJmtyff17z78quaJyUTdDrQb9FO2ppZZ3qLU0+Lps
         IDQkUwRlPgFuraq1DF0nMMukAYamAY4ZSy+bl+Xhs06QTvPJq19DjTg+FBIhRQ2U9W8e
         tDysDJkQUxMlOInlcbWk1yPyaO+9QQFB/hwI0G5Q9V3NgwcoezsTYRPl6VFRFVVgFxjO
         hSkyRFKnxG9R8akUC+4O8APeoxjDAGPsJJD+A4zAbXOToljf6dGPkb2XLHyLouq+rlBI
         wllQ==
X-Gm-Message-State: AC+VfDyjAef5xQZ+NN7exQGbH4NtlrbwcxyU4XeCe5AJbpzDFDCU+IhZ
        hZX34ROGB9z1ao5BaBoG0YY2HA==
X-Google-Smtp-Source: ACHHUZ4aE6ybHgPo+un8T6iOuQhf3zQ+v7vONYr//+SCABjwwSjCNAQ2+Qt3Fv5hsQU1ukHnWuA0/A==
X-Received: by 2002:ac2:4470:0:b0:4ed:c3a1:752a with SMTP id y16-20020ac24470000000b004edc3a1752amr1189012lfl.45.1683386987504;
        Sat, 06 May 2023 08:29:47 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id v5-20020a197405000000b004eff32d6a21sm680814lfe.121.2023.05.06.08.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 08:29:47 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 06 May 2023 17:29:45 +0200
Subject: [PATCH 2/2] ARM: dts: bcm5301x: Add SEAMA compatibles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230506-seama-partitions-v1-2-5806af1e4ac7@linaro.org>
References: <20230506-seama-partitions-v1-0-5806af1e4ac7@linaro.org>
In-Reply-To: <20230506-seama-partitions-v1-0-5806af1e4ac7@linaro.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds SEAMA compatibles to the firmware partition of these
two D-Link devices.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts | 1 +
 arch/arm/boot/dts/bcm47094-dlink-dir-890l.dts | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
index 555fbe41dd8f..cf3000b07eea 100644
--- a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
+++ b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
@@ -33,6 +33,7 @@ partitions {
 				#size-cells = <1>;
 
 				partition@0 {
+					compatible = "seama";
 					label = "firmware";
 					reg = <0x00000000 0x08000000>;
 				};
diff --git a/arch/arm/boot/dts/bcm47094-dlink-dir-890l.dts b/arch/arm/boot/dts/bcm47094-dlink-dir-890l.dts
index d945a20b06e0..3551f855ff20 100644
--- a/arch/arm/boot/dts/bcm47094-dlink-dir-890l.dts
+++ b/arch/arm/boot/dts/bcm47094-dlink-dir-890l.dts
@@ -149,6 +149,7 @@ partitions {
 		 * partitions: this device uses SEAMA.
 		 */
 		firmware@0 {
+			compatible = "seama";
 			label = "firmware";
 			reg = <0x00000000 0x08000000>;
 		};

-- 
2.34.1

