Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6035BFA2C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiIUJGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiIUJGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:06:07 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E594B0D8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:06:05 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id n12so8713785wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=hTq3Rd3TJ513y76FFI3WT0dfpVj4Khn+ApB44y0p0+k=;
        b=0c2Cy+Q4wxXUAvCsCYHW2Jf8B8+krbOBDUB7xauW7/MN/NXxhW3ygOeM5v2ZrgqEzl
         xLrIGnNBJS5IvoQhCVJ9RzIA5NcZe0v03Alpp2kuTuvNaZJldsybst/SunpEBzz/hRn+
         Bu7b4tbLUItAFCyx8C6B9l0T1coCvRcUmxDsplAJBfc2W0bGKoiYq40M/kSc/GepPFLz
         DxFZHirBp0PJu+KhrFyA+e060GPY+teQ5a1KsIAdrQeJoq7flqLo+aiguQjoAimB5BZE
         +DvSu0zXEk5TpN062T1rAElzC73z6yMbpGGh+TCV42ZMbSKdRoAJ9JUvzQtdkMRBhqzC
         +HBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hTq3Rd3TJ513y76FFI3WT0dfpVj4Khn+ApB44y0p0+k=;
        b=JzvN/Ji/6Yj7toyR7L+F2slr6TvYuM7/dKsO18WFPPA7QiYDR1I/b2Hglgo0+7hj87
         cvyP3Uw1sIvVk7aWjTJxls7yYhieHSSZgnlwkg4fp77cHUgzqRqS4o0ry0eSsj7so1mY
         dmYi1LGTyz4MGxwAFGgQssszy+l6V2ce5sMhSjC4MTyLEWGAvyyt2eRNsDjh3Jnmm61J
         0QF3M3KTv0Zk5KJ4T9y8OTHAtRN1HEBHIzUa0ThNHM95CJb5NENbi3T28pM5DXTs/8zF
         385O/k1gLvgtvpbE2tBpNcKNpGBpgXDv1epklwi71PVn/D/iOkbDX8Iac/n7ZXLHxwoe
         2tHg==
X-Gm-Message-State: ACrzQf0qQQoGtnSv2j+nb8kXqmJ2woa0gFIO/345EfXevUugwEz/4jQh
        eRYqcB3Hd39doeHhQdFEQ3HAqg==
X-Google-Smtp-Source: AMsMyM4Qpq8v43feSwHJfA27oBOpdjOQnzkAJwh28NMTj4f2VN4DosURKua9zHscoCuwe0yDrxwgnQ==
X-Received: by 2002:adf:fb88:0:b0:22a:f742:af59 with SMTP id a8-20020adffb88000000b0022af742af59mr10817471wrr.230.1663751163802;
        Wed, 21 Sep 2022 02:06:03 -0700 (PDT)
Received: from [127.0.1.1] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id p10-20020a5d638a000000b0022b0064841esm1975482wru.59.2022.09.21.02.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:06:03 -0700 (PDT)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
Date:   Wed, 21 Sep 2022 11:05:33 +0200
Subject: [PATCH v2 1/1] arm64: dts: mediatek: mt8183: disable thermal zones without
 trips.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220921-mt8183-disables-thermal-zones-up-v2-1-4a31a0b19e1e@baylibre.com>
References: <20220921-mt8183-disables-thermal-zones-up-v2-0-4a31a0b19e1e@baylibre.com>
In-Reply-To: <20220921-mt8183-disables-thermal-zones-up-v2-0-4a31a0b19e1e@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        daniel.lezcano@linaro.org
X-Mailer: b4 0.10.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1663751161; l=1541;
 i=aouledameur@baylibre.com; s=20220920; h=from:subject:message-id;
 bh=+48HSG61Tboa5W5HVeC955O8SAyXJVzdboBwb6baiTg=;
 b=G6EMcK1spRehaxNq/icrbsiBlZLOHtLbMIiv271RWH23rYmDwzq8SlL12BPpNVMsMeAZ6+Q7oXW6
 GcLOJNqqCSjfr9joJaP05Cf/8OfsAfmsOx1G9Oe0eTAhXhHPJj7j
X-Developer-Key: i=aouledameur@baylibre.com; a=ed25519;
 pk=HgYWawSL4qLGPx+RzJ+Cuu+V8Pi/KQnDDm1wjWPMOFE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thermal zones without trip point are not registered by thermal core.

tzts1 ~ tzts6 zones of mt8183 were intially introduced for test-purpose
only.

Disable the zones above and keep only cpu_thermal enabled.

Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 9d32871973a2..44a197e92c99 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1193,6 +1193,7 @@ tzts1: tzts1 {
 				sustainable-power = <5000>;
 				trips {};
 				cooling-maps {};
+				status = "disabled";
 			};
 
 			tzts2: tzts2 {
@@ -1202,6 +1203,7 @@ tzts2: tzts2 {
 				sustainable-power = <5000>;
 				trips {};
 				cooling-maps {};
+				status = "disabled";
 			};
 
 			tzts3: tzts3 {
@@ -1211,6 +1213,7 @@ tzts3: tzts3 {
 				sustainable-power = <5000>;
 				trips {};
 				cooling-maps {};
+				status = "disabled";
 			};
 
 			tzts4: tzts4 {
@@ -1220,6 +1223,7 @@ tzts4: tzts4 {
 				sustainable-power = <5000>;
 				trips {};
 				cooling-maps {};
+				status = "disabled";
 			};
 
 			tzts5: tzts5 {
@@ -1229,6 +1233,7 @@ tzts5: tzts5 {
 				sustainable-power = <5000>;
 				trips {};
 				cooling-maps {};
+				status = "disabled";
 			};
 
 			tztsABB: tztsABB {
@@ -1238,6 +1243,7 @@ tztsABB: tztsABB {
 				sustainable-power = <5000>;
 				trips {};
 				cooling-maps {};
+				status = "disabled";
 			};
 		};
 

-- 
b4 0.10.0
