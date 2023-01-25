Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC29367AE9D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 10:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbjAYJpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 04:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbjAYJpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:45:51 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B5F4FAD3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:45:25 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l8so13281599wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ztfbDoxGkDtDmGmBYfiBuBdnAIcB0uPVrA/v1nCpTCQ=;
        b=FsdNwkstyvELDGvtDJLlGrYXxXaw+Yd/rnWhJQdaClPX/6nI30z3KrEYdR1blg0yas
         HnJqJNdicB2Y8z/DDK7cVk2GiT1P7gjMOafnUgCU0NdWgPooizBy+2uA1TaqDKFCkYQ4
         irODL2cF7vLmfyvfA9kfkYlL5hsV7FQVZXfrMZZXT6qtD+IiBn/Rpi/dmW/ITImzx5FV
         7X34wUvBf1FSmcmnHVYSOCK+yAE4jsrYCXGyXWeyVCaWpPs3BMk/qPl05Y12+5WnXY0h
         khowzHbFZk9pHgh4AwlV3zTopNMsDH6el5kMsATONevRApwi4JSZVR7MKxQ4GRf1+AXf
         zN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ztfbDoxGkDtDmGmBYfiBuBdnAIcB0uPVrA/v1nCpTCQ=;
        b=NuWwdseKGNqqcuYdxA44j+UFzTmn80zvAzw9rz5l8o8V+e17hY0QE9eaLCM3E4lwNe
         NAqPjI+z8vONWkCNuQgWzqOYtI2csB+NsF9IEdDPZhRJ4G1RnP2RJUYs9RyZluC1sGpD
         Samhms0M+1v2MFKNb2qdf8QQsx0KMTnibYRIlBHU9ECou82r0SNq+dy8PUuoi7209aLt
         g/zzsju8bm1p3LCzq3hBUzvd6yDA9uVndZa24VLxve7PvEnyQsvMvh6PK4Z/kEgF4oyL
         u8vRWJe3k/RAhftNl1ZOwFcr3no3gQYqqT14TCZ3sGXPRlb0OWwBnpuxU8WZsyOT8RmR
         qKCA==
X-Gm-Message-State: AFqh2kph/3Al40/OTloaNU1B49KtpcQI6I/NeLxpwnzKEzTZCo8ezcl0
        jUKKE2CZ+KyRCvjiteSn4V63eQ==
X-Google-Smtp-Source: AMrXdXsh2igFfleXr30Bewy8M0jQBLxP7I9V02wCXUXTYQcHNQM6+J0AOl+0hWI7jdNJPkdu81Wrsg==
X-Received: by 2002:a05:600c:4e05:b0:3c6:e61e:ae71 with SMTP id b5-20020a05600c4e0500b003c6e61eae71mr32485060wmq.1.1674639922588;
        Wed, 25 Jan 2023 01:45:22 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id fl22-20020a05600c0b9600b003d1e3b1624dsm1419238wmb.2.2023.01.25.01.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 01:45:22 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     replicant@osuosl.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH 1/9] ARM: dts: exynos: correct HDMI phy compatible in Exynos4
Date:   Wed, 25 Jan 2023 10:45:05 +0100
Message-Id: <20230125094513.155063-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HDMI phy compatible was missing vendor prefix.

Fixes: ed80d4cab772 ("ARM: dts: add hdmi related nodes for exynos4 SoCs")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/exynos4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 55afe9972460..d1adaee2af58 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -605,7 +605,7 @@ i2c_8: i2c@138e0000 {
 			status = "disabled";
 
 			hdmi_i2c_phy: hdmiphy@38 {
-				compatible = "exynos4210-hdmiphy";
+				compatible = "samsung,exynos4210-hdmiphy";
 				reg = <0x38>;
 			};
 		};
-- 
2.34.1

