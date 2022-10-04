Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1A75F4B00
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 23:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJDVfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 17:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJDVfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 17:35:14 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C2B520AB;
        Tue,  4 Oct 2022 14:35:11 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id b2so8880648plc.7;
        Tue, 04 Oct 2022 14:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=SEuMG1PV2vuBeTlNXduiO37BC+xa1Q5/Izz8GxQ/6zY=;
        b=GEYHFZ6A9n+QqooBY8Dpa2ko+JgUcRB4y48ms9TsecRpWql5z+J4SDWz6itkG/IRMq
         y6kfeWpcY3uDjgbd4+iSaXUcqALQBKAbllPQX2V6vtjBQU8hAJszM5Uam8mJfD1JKOLj
         m0aG5Q3TFgMieVUCYEwbiVpyc4WAIvfFU53dmygpJHaQequ4XFbYPlhONUlBh66Om5HB
         lBuZCBEajD3bw9CHNWbdEsPV6z/otICUnNmB2Nhj+WFEFF404zDi9oq3VUpby8x9biiu
         /nkCyXdVRv3MvmfEpeI6CTLGYAd8Nm44wDUtmk+zmsOXbein9dEJhCxpV8X4Uu1UIq+n
         kCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=SEuMG1PV2vuBeTlNXduiO37BC+xa1Q5/Izz8GxQ/6zY=;
        b=QZjK0OZt9xNA/LtRqGRydHaMZribyELY9mAAZJAh5MiW1xv1lmoF6b3Kcj2L/F6idQ
         d3lrvztCwSrtceM4Jk2ShaNyjCceBob/FN4Wx39iaCKcHB97cTQugK/ha2tKjbILworw
         3Py+3msxJQ8mgzbAzytZghhM/Xg7FwETRwPygBtXiWqQQxvADK1gBeR7VkuUgpNdN4Qr
         jHxMnkEsBozPG/6OJb0np8ULjf2RTWvIOTjG5OaytOQGo89+avIt8GuXfmi9bwwRjIwX
         DnJrV6L9Ox22RLpkgNChA+P3JSQG9KoPh2YglJXtx6d7Yp10S/WpCy4+YbXf5qxFA+Wh
         wWoA==
X-Gm-Message-State: ACrzQf1hIIITJ0WKPs4PIkzu5ATjgcb5zscVhyaDyx0NZaGjoDAy3HlE
        AD4O/S82Ym15ILzUPffdS8U=
X-Google-Smtp-Source: AMsMyM4dGFz0In6c5+NmHVzG0Hi2cgXiNr0O3tCLUHm4/juYyyCteobJwKJkdtOBsuRgZwMl4819zg==
X-Received: by 2002:a17:90a:4413:b0:20a:10e2:cb3 with SMTP id s19-20020a17090a441300b0020a10e20cb3mr1644705pjg.37.1664919310938;
        Tue, 04 Oct 2022 14:35:10 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:978:a034:8ff4:b4b5])
        by smtp.gmail.com with ESMTPSA id y187-20020a6232c4000000b0055f209690c0sm7675219pfy.50.2022.10.04.14.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 14:35:10 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] ARM: dts: omap3-n950: fix LCD reset line polarity
Date:   Tue,  4 Oct 2022 14:35:02 -0700
Message-Id: <20221004213503.848262-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221004213503.848262-1-dmitry.torokhov@gmail.com>
References: <20221004213503.848262-1-dmitry.torokhov@gmail.com>
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

The LCD driver (panel-dsi-cm), when performing reset, starts with line
set high, then drives it low, holds it there for a moment, and releases
it back to high.  This means that the reset line should be described
as "active low" in DTS. This will be important when the driver is
converted to gpiod API which respects the polarity declared in DTS.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/boot/dts/omap3-n950.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-n950.dts b/arch/arm/boot/dts/omap3-n950.dts
index b2f480022ff6..fa133612bcc2 100644
--- a/arch/arm/boot/dts/omap3-n950.dts
+++ b/arch/arm/boot/dts/omap3-n950.dts
@@ -235,7 +235,7 @@ lcd0: panel@0 {
 		vpnl-supply = <&vmmc2>;
 		vddi-supply = <&vio>;
 
-		reset-gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;	/* 87 */
+		reset-gpios = <&gpio3 23 GPIO_ACTIVE_LOW>;	/* 87 */
 		te-gpios = <&gpio2 30 GPIO_ACTIVE_HIGH>;	/* 62 */
 
 		width-mm = <49>; /* 48.960 mm */
-- 
2.38.0.rc1.362.ged0d419d3c-goog

