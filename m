Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17CD658F7A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 18:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbiL2RO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 12:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbiL2ROb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 12:14:31 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4036913F76;
        Thu, 29 Dec 2022 09:14:30 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l26so11996968wme.5;
        Thu, 29 Dec 2022 09:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIQW09CqX9CkrW+ObP5qHJbu4xvI7F5KPrqUJVnMAfg=;
        b=kTbYGYfbcKJYoEQJGQ6Zi9Sw0kJu6rCQDiGDUq603Sd01FjS3LIuBUdNiisDXN2Xan
         q7ykbJaGj6TM6QKvK5W8ct4E3qkx3N/IQ8ipcVZiEYM0YVL/kl+lQKDTtwhmkQLt3Tdw
         VZhA39d/JZk8jDwZErEKNQZzOIQ9fpLFoBji2dZXdbQH2st9kUaySewRXU6bJU3Aln6x
         2Zp5SpjESwPjpU7gXODpBJS/v4sUwQA/C0kdiFXBmmsnSeHdLsib7AL94qBH4DWGVstk
         8m6gaMrt2RlUTPmPdpWIvowwuyM1Ya9MQpqM1m90DObqnZYm8fM2ixWcav5l4DoDYj5Y
         3OAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cIQW09CqX9CkrW+ObP5qHJbu4xvI7F5KPrqUJVnMAfg=;
        b=X6VTZgrQW4s8H2SakIe53QH34V8cflF/XXmXTa2xml9aBt6uIRH7IVpdeTXgNSVEgH
         +HtDbepc8iKsY/HaKm6hOPUJHoXGmZiX9Gxpb2sjTEOm/SKd1fAo+ufR5bQpuhwTaube
         5Fwu4kCjaRXpDzwTrrGuntz+CZk+7n41fFtTxJDHC3L2MtukGwEEWkft3q7C5f5KfCNc
         6txendGHQFcwwJh1lsTBr+XnYAYCM6FZQXFP/w+I2oTSrStlkHFrnUom8yoxGu2+3U7Z
         Pd8WyXd31qNbXmpOPvXPw5/03gppFOjTIezXzs86Q46IKPkP/pkIYcj8VqGyylOoEINo
         /q7Q==
X-Gm-Message-State: AFqh2kreUgrsPC5R5UQtCd/0E0Jd67w5fUu2618057wEhDX+LG6k1fw3
        36XgAXya62RCTR8bhCRKAXWv9u7IRWuCLweZ
X-Google-Smtp-Source: AMrXdXvxdNzeaVO27hvAA4NHURvr+qmfEunBqFUzPtq8x3m0yT80gZNe5XjjIV3IPvgA5nLY5uxPdw==
X-Received: by 2002:a05:600c:ace:b0:3d1:fe0a:f134 with SMTP id c14-20020a05600c0ace00b003d1fe0af134mr20524123wmr.19.1672334068801;
        Thu, 29 Dec 2022 09:14:28 -0800 (PST)
Received: from tpt440p.steeds.sam ([2602:fbf6:10:8::2])
        by smtp.gmail.com with ESMTPSA id n41-20020a05600c3ba900b003d358beab9dsm28085366wms.47.2022.12.29.09.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 09:14:28 -0800 (PST)
From:   "Sicelo A. Mhlongo" <absicsz@gmail.com>
To:     linux-omap@vger.kernel.org
Cc:     "Sicelo A. Mhlongo" <absicsz@gmail.com>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tony@atomide.com,
        devicetree@vger.kernel.org, maemo-leste@lists.dyne.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/2] ARM: dts: n900: use iio driver for accelerometer
Date:   Thu, 29 Dec 2022 19:13:48 +0200
Message-Id: <20221229171348.3543327-3-absicsz@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221229171348.3543327-1-absicsz@gmail.com>
References: <20221229171348.3543327-1-absicsz@gmail.com>
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

The accelerometer in the N900 is supported by the iio-framework since commit
8a7449d68670a8f9 ("iio: accel: add support for LIS302DL variant). This commit
switches to it and updates node properties to match the bindings of the new
compatible.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
---
 arch/arm/boot/dts/omap3-n900.dts | 52 +++++---------------------------
 1 file changed, 8 insertions(+), 44 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 20d7a7bb6b04..adee3da93421 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -768,55 +768,19 @@ &i2c3 {
 	clock-frequency = <400000>;
 
 	accelerometer@1d {
-		compatible = "st,lis3lv02d";
+		compatible = "st,lis302dl";
 		reg = <0x1d>;
 
-		Vdd-supply = <&vaux1>;
-		Vdd_IO-supply = <&vio>;
+		vdd-supply = <&vaux1>;
+		vddio-supply = <&vio>;
 
 		interrupt-parent = <&gpio6>;
-		interrupts = <21 20>; /* 181 and 180 */
-
-		/* click flags */
-		st,click-single-x;
-		st,click-single-y;
-		st,click-single-z;
-
-		/* Limits are 0.5g * value */
-		st,click-threshold-x = <8>;
-		st,click-threshold-y = <8>;
-		st,click-threshold-z = <10>;
-
-		/* Click must be longer than time limit */
-		st,click-time-limit = <9>;
-
-		/* Kind of debounce filter */
-		st,click-latency = <50>;
-
-		/* Interrupt line 2 for click detection */
-		st,irq2-click;
-
-		st,wakeup-x-hi;
-		st,wakeup-y-hi;
-		st,wakeup-threshold = <(800/18)>; /* millig-value / 18 to get HW values */
-
-		st,wakeup2-z-hi;
-		st,wakeup2-threshold = <(900/18)>; /* millig-value / 18 to get HW values */
-
-		st,hipass1-disable;
-		st,hipass2-disable;
-
-		st,axis-x = <1>;    /* LIS3_DEV_X */
-		st,axis-y = <(-2)>; /* LIS3_INV_DEV_Y */
-		st,axis-z = <(-3)>; /* LIS3_INV_DEV_Z */
-
-		st,min-limit-x = <(-32)>;
-		st,min-limit-y = <3>;
-		st,min-limit-z = <3>;
+		interrupts = <21 IRQ_TYPE_EDGE_RISING>,
+			     <20 IRQ_TYPE_EDGE_RISING>; /* 181 and 180 */
 
-		st,max-limit-x = <(-3)>;
-		st,max-limit-y = <32>;
-		st,max-limit-z = <32>;
+		mount-matrix =	 "-1",  "0",  "0",
+				  "0",  "1",  "0",
+				  "0",  "0",  "1";
 	};
 
 	cam1: camera@3e {
-- 
2.39.0

