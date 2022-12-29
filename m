Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C51658E1F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 15:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbiL2OyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 09:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbiL2Oxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 09:53:52 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F8594;
        Thu, 29 Dec 2022 06:53:51 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id bk16so4381270wrb.11;
        Thu, 29 Dec 2022 06:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GTM/UzbZlQLHzZ7f/Z9OSVfC+V1LjXS0BfKlhKw7U1k=;
        b=J/VuH1CkG+KFiqLc1lrXWU19CjO1wjb/OxUAf3YMBfbj3m9p7S8i0Tifn1Y/yMPxCs
         ua7zM7XH+D+3wvlF6QhGobYCR2G/35bUdRD0uSpllKXU7nM/Tjp0I3FJa/mDQ+pj7E/E
         hgxthjIbtfILOxLmEW7/OW5+wRizxqHQDH5DZGxDk5TZGbfqNdMJKD4SBLmzRYkFGrK/
         H8E5ZnQQoga7K8JTSXMaeMoPzBwFJ2L3eNIBPVV/xnt6gths65G/La+By7rE9/FtdrcW
         GPMiwAmpOzV7RGDl3CdyHb/uwTmbFGPIcIcXtn9HPRkUHO+8Am7lLHAP6XgZypNm5Ddv
         QcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GTM/UzbZlQLHzZ7f/Z9OSVfC+V1LjXS0BfKlhKw7U1k=;
        b=BYLiTylXm0bvDIFxclswmHA4XRU3dZdFtBf2X25BvX+heK0NQrYHR0VWkK0w6Ji89t
         trjwwpPWL8/B5/B9Ru5BBW40lv0B0RcfoKc4TkgNGEIca6eIrhdcCej2n9TqgAfV6a1F
         Na2+erHBfFKXZzf0omoO39YWkebshaBGwIS96yl7+CdT6BoE63cNcY7Z6i796reu9iVe
         gjlf/gZ1+yNDhqkkpufXJSenOXFTpFA6vumwqwH3IOGED1yIC4lXCi09IftU87nK7pso
         BX7PzDvi3VWaAjBXoAI3CMtVydjPvv7Gk2l1lg4UkTZpXQS9N+2U6oYJsoLpfcILc0k9
         7v4Q==
X-Gm-Message-State: AFqh2krm2pYwaI/weGNLWxRQxMifls7r0BP5Zb51vdygQt9P4eDCHeYq
        0hIHU+o4t7istsJuIqvy/Fj6vemIO7+4Rbhf
X-Google-Smtp-Source: AMrXdXvKu2IuIPWoA9PL/IdO+YQYezH8pV+6r2GNw5u88CuBFq3rI68QFAwBwgaAbRQ9WGd2Q1b+QA==
X-Received: by 2002:adf:ec43:0:b0:280:cc12:2827 with SMTP id w3-20020adfec43000000b00280cc122827mr8130110wrn.21.1672325630304;
        Thu, 29 Dec 2022 06:53:50 -0800 (PST)
Received: from tpt440p.steeds.sam ([69.63.64.50])
        by smtp.gmail.com with ESMTPSA id v7-20020adfe287000000b00241bd177f89sm18151089wri.14.2022.12.29.06.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 06:53:49 -0800 (PST)
From:   "Sicelo A. Mhlongo" <absicsz@gmail.com>
To:     linux-omap@vger.kernel.org
Cc:     "Sicelo A. Mhlongo" <absicsz@gmail.com>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tony@atomide.com,
        devicetree@vger.kernel.org, maemo-leste@lists.dyne.org
Subject: [PATCH v2 2/2] ARM: dts: n900: use iio driver for accelerometer
Date:   Thu, 29 Dec 2022 16:52:50 +0200
Message-Id: <20221229145251.3535402-3-absicsz@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221227223841.2990847-1-absicsz@gmail.com>
References: <20221227223841.2990847-1-absicsz@gmail.com>
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
compatible

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

