Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35EF60EBF9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 01:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbiJZXBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 19:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbiJZXAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 19:00:34 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50980317F3;
        Wed, 26 Oct 2022 16:00:08 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id a13so44192741edj.0;
        Wed, 26 Oct 2022 16:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ww8Jx6MwPKHu8PJmJYn80kwAUAuLzjtG0hvl+VPoT7M=;
        b=I3fm9YJEZN8vn/vYlXN9fSY8k4i77jAX52zOoYBBuPldBV1oZUwXuOvRRKrprh6aIs
         9XgPQSBYSf5MkYEjF4m3St8lRpQkqlYZ5W5rXDzeor135zCDa3EtyZ1eiPqaRIcZDgXy
         9KHMK3AStov4UfcuX3L4cYqw/Z/Pa1Ty6r5uzfdl5/t9SLr7Hji9DJBcxeoisTUdybZl
         hBhqiq7ODzjdmpTwfVcA32aXit4rdv+Ws2XO9kH8lFn2XanPs7ZXfPKlLxhOn22yYYvE
         M92dIhVxNN7oaWijPD8O3xtcn5HwZXm1y6SmUwjFUp6dRyYlyazwRqVg/gFQ5kl5UK91
         bkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ww8Jx6MwPKHu8PJmJYn80kwAUAuLzjtG0hvl+VPoT7M=;
        b=TLqQUn8UNW/PaQamoSqhKcG5fqHpHAFnMB4/SOlxVxBxOlzL/F3X6DdV/jhzAisHTE
         8guRcqmwA3KcGo19NwRTSJujWIL/IQAm2I//x1YZ8WYOcFypDa4Ymw6aDVDjK1Hc/3Bf
         KlndGD27R/3gsk8mPdFrOJmbLYBvEXCkxE4j8ESqWQXNSmdHr8rKf0/lfawwZ1HJSb9R
         SjOgTVVZSawR4TG+j13fvVDeXBvbKnBSwD3zVXl28w0YsR+QdBy1Ql46t3Z3DMV4B2B1
         pbUzpl3c3XgkM3Ic7P1oHxeh3SLxHJaMS43rTG99rKgDnq0VH91H2VWLf2LPuF0jtrnd
         gwLw==
X-Gm-Message-State: ACrzQf0pBpUkzsq4zPkCHCJt4xv1V2RVAr98SSGh6byKa1nXMC1RT7RK
        GmLgWUyuXeu8FjKBdBehruU=
X-Google-Smtp-Source: AMsMyM7LfwC6hr00YFuS7OlQuq6QKPSmS3Rztqf9jg+nzCnwAq4lXLwpFOcej6U/S60SWkn3lWsQEA==
X-Received: by 2002:a05:6402:3213:b0:461:dec8:336d with SMTP id g19-20020a056402321300b00461dec8336dmr15397238eda.221.1666825206604;
        Wed, 26 Oct 2022 16:00:06 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id qh24-20020a170906ecb800b00782fbb7f5f7sm3563185ejb.113.2022.10.26.16.00.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 16:00:06 -0700 (PDT)
Message-ID: <84f14b40-0804-9734-963a-31e200687a8d@gmail.com>
Date:   Thu, 27 Oct 2022 01:00:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 2/3] ARM: dts: rockchip: rename "haoyu,hym8563" rtc nodes
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <f7127f87-05fd-5e20-eb2d-a3fd04674229@gmail.com>
Content-Language: en-US
In-Reply-To: <f7127f87-05fd-5e20-eb2d-a3fd04674229@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "haoyu,hym8563" RTC node names should be generic,
so change them.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3036-evb.dts            | 2 +-
 arch/arm/boot/dts/rk3288-evb-act8846.dts    | 2 +-
 arch/arm/boot/dts/rk3288-firefly-reload.dts | 2 +-
 arch/arm/boot/dts/rk3288-firefly.dtsi       | 2 +-
 arch/arm/boot/dts/rk3288-miqi.dts           | 2 +-
 arch/arm/boot/dts/rk3288-rock2-square.dts   | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/rk3036-evb.dts b/arch/arm/boot/dts/rk3036-evb.dts
index 9fd4d9db9..89b0927ce 100644
--- a/arch/arm/boot/dts/rk3036-evb.dts
+++ b/arch/arm/boot/dts/rk3036-evb.dts
@@ -35,7 +35,7 @@
 &i2c1 {
 	status = "okay";

-	hym8563: hym8563@51 {
+	hym8563: rtc@51 {
 		compatible = "haoyu,hym8563";
 		reg = <0x51>;
 		#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/rk3288-evb-act8846.dts b/arch/arm/boot/dts/rk3288-evb-act8846.dts
index be695b8c1..8a635c243 100644
--- a/arch/arm/boot/dts/rk3288-evb-act8846.dts
+++ b/arch/arm/boot/dts/rk3288-evb-act8846.dts
@@ -54,7 +54,7 @@
 		vin-supply = <&vcc_sys>;
 	};

-	hym8563@51 {
+	rtc@51 {
 		compatible = "haoyu,hym8563";
 		reg = <0x51>;

diff --git a/arch/arm/boot/dts/rk3288-firefly-reload.dts b/arch/arm/boot/dts/rk3288-firefly-reload.dts
index a5a082634..2b462bbca 100644
--- a/arch/arm/boot/dts/rk3288-firefly-reload.dts
+++ b/arch/arm/boot/dts/rk3288-firefly-reload.dts
@@ -197,7 +197,7 @@
 };

 &i2c0 {
-	hym8563: hym8563@51 {
+	hym8563: rtc@51 {
 		compatible = "haoyu,hym8563";
 		reg = <0x51>;
 		#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
index 052afe554..9267857be 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
@@ -233,7 +233,7 @@
 		vin-supply = <&vcc_sys>;
 	};

-	hym8563: hym8563@51 {
+	hym8563: rtc@51 {
 		compatible = "haoyu,hym8563";
 		reg = <0x51>;
 		#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/rk3288-miqi.dts b/arch/arm/boot/dts/rk3288-miqi.dts
index 713f55e14..e3d5644f2 100644
--- a/arch/arm/boot/dts/rk3288-miqi.dts
+++ b/arch/arm/boot/dts/rk3288-miqi.dts
@@ -162,7 +162,7 @@
 		vin-supply = <&vcc_sys>;
 	};

-	hym8563: hym8563@51 {
+	hym8563: rtc@51 {
 		compatible = "haoyu,hym8563";
 		reg = <0x51>;
 		#clock-cells = <0>;
diff --git a/arch/arm/boot/dts/rk3288-rock2-square.dts b/arch/arm/boot/dts/rk3288-rock2-square.dts
index 80e0f07c8..07a3a5275 100644
--- a/arch/arm/boot/dts/rk3288-rock2-square.dts
+++ b/arch/arm/boot/dts/rk3288-rock2-square.dts
@@ -165,7 +165,7 @@
 };

 &i2c0 {
-	hym8563: hym8563@51 {
+	hym8563: rtc@51 {
 		compatible = "haoyu,hym8563";
 		reg = <0x51>;
 		#clock-cells = <0>;
--
2.20.1

