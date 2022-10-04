Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458D85F4B01
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 23:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiJDVfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 17:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiJDVfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 17:35:15 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5447C5603C;
        Tue,  4 Oct 2022 14:35:13 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id q9so13729379pgq.8;
        Tue, 04 Oct 2022 14:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=PKhtda4QhKXPGvOXr8H8k3AOFs8XK+Y1T7+7axDZq3U=;
        b=Jxhflc+Wn1Zf4TwrQ+8y/yjGYHw73gY+8ve42WOU5pJ4g9YgCff9vH6Jtj9/z0b8tu
         BL0xeN0fZkDsttxOsKQuYT6xaV1ys8mRF17FccjzQIaPpdfqL2y/4eOOL+N/key/Mevj
         1hIw0Poh5cCObCViNNMZruH6XNGHRB9XlIgyscJ4JlB/Df+ga1gpgJdTf35YdWeN6HNJ
         m1iZ0nlNyAcYPwQYY1bhTplmSGJPK5eMkvbKRFlq03mttnQP1tmhkEn6QtfJTc40mfSw
         kRDFlNffFW/K64M67mojBY5PF3ZjclD5S//LXOIo9Rn6oRBF1GaUafKdmXvdy03jm/IK
         kzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=PKhtda4QhKXPGvOXr8H8k3AOFs8XK+Y1T7+7axDZq3U=;
        b=ys2qtaTBxldOXwCmnEJ+6Sx6YmPFJ8lH/GpaY3SpSMlrzzsaKlurR7owekA/q2JE/r
         +kvU/9OgNKc4egXiu4OzW26O9vax/kST2A7PNSz3SLl92VOF8ZGt4AtaCnbxzuSNcqNy
         sNMVdyf3CEDITrzQurDmM6DzJnoQB/xv64Ss4W0K68LqH8udiBjSj9SPYE/oKu+TFYLz
         T39caQkHLIWnxExIKlhYYFrayZS3QR8mVTEnYK+uCVtwIN2MffQLEiPynoCTwxS2MStB
         u4a3u+YU3t+9WVCK1UgNdnr5+809N05rVrKlweYusdaeopVAe0J+gPBF7I5IASs413vw
         yr5A==
X-Gm-Message-State: ACrzQf1axPyNXIo8aJPCOh9fWqw3XmCdtKfj4CvMR0XU+HGk0KkbeGcY
        WFuwbefev+9GaHp2RFLaxpY=
X-Google-Smtp-Source: AMsMyM4EdILJ5TeOlwwCpvXxEIGM0VKQEBWHF6nOVhLtPlr0+c5ZSt5o71ttQXZdvzlGdlYiLKoljA==
X-Received: by 2002:a05:6a00:15c9:b0:541:1767:4ce2 with SMTP id o9-20020a056a0015c900b0054117674ce2mr28601833pfu.30.1664919312528;
        Tue, 04 Oct 2022 14:35:12 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:978:a034:8ff4:b4b5])
        by smtp.gmail.com with ESMTPSA id y187-20020a6232c4000000b0055f209690c0sm7675219pfy.50.2022.10.04.14.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 14:35:11 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] ARM: dts: motorola-mapphone: fix LCD reset line polarity
Date:   Tue,  4 Oct 2022 14:35:03 -0700
Message-Id: <20221004213503.848262-4-dmitry.torokhov@gmail.com>
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
 arch/arm/boot/dts/motorola-mapphone-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/motorola-mapphone-common.dtsi b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
index c7a1f3ffc48c..beffa1cf08b2 100644
--- a/arch/arm/boot/dts/motorola-mapphone-common.dtsi
+++ b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
@@ -212,7 +212,7 @@ lcd0: panel@0 {
 		reg = <0>;
 		label = "lcd0";
 		vddi-supply = <&lcd_regulator>;
-		reset-gpios = <&gpio4 5 GPIO_ACTIVE_HIGH>;	/* gpio101 */
+		reset-gpios = <&gpio4 5 GPIO_ACTIVE_LOW>;	/* gpio101 */
 
 		backlight = <&backlight>;
 
-- 
2.38.0.rc1.362.ged0d419d3c-goog

