Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323C1658F77
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 18:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbiL2ROb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 12:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiL2ROZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 12:14:25 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F062BE0F1;
        Thu, 29 Dec 2022 09:14:22 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id z8-20020a05600c220800b003d33b0bda11so11769731wml.0;
        Thu, 29 Dec 2022 09:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZsMmyNHeT0839gQFFQ7/+G/xkt5ciDXx9txXojKQC+k=;
        b=ZrwdOnFrURDvyqnMnW2NdGD7z2N+2qWdldqtxZ1DEbOI2yT3IonO9bHOVrvB2U/N1D
         U+Marxp/IoSVcpGw9sYOlzycPRs2k5vL3Ipe/M67PiAZls7x50uPKbJoxTYJ70hhh+T9
         LrM0CTw9zZKr5073Wz5/VPBWlXg9Cf65bXPApodyUAaYjff2kXaMhXhvGcAogC/Zqnv4
         fZwxiKocuzNmYd0rtY5AX7giSulnGMN2hH+0vuGtbK9Swjqw4RKX2L7s02n/PCjCvQkK
         Rm5JsEVNF9Sl4WdVC6Q6qcElDmJqRvQI4R5vmSN1I8XWmG4Hi1VB0BtIvuGAssEj0xc1
         g6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZsMmyNHeT0839gQFFQ7/+G/xkt5ciDXx9txXojKQC+k=;
        b=ddlPYdzXusImK3BiuPmm/bkYLMgEZuX7X0n+LQuC/fMiP53l3evyq9rMOEtAEvatlc
         +fvX2BZ2OJ9iT7Jk03GVI8YxrPtqz2vsjj3GFsbWfExwwXMWC2dd1wXiEthWiduyUClv
         CtxiMmsR2VMLDcKgU207qPNfOiiQ24zegU/z17+eLkcpdSS+T0y4BXhX6hrLEcGiWm82
         rF6loL2M59uDGwmNcBxDq6icSAs+dCt8CIS+o98f4S0piQn4yEkMVtxrqvzlXP5fa7e8
         oo10rhYRgVCq8mwEllIFjWayva1SukGOgUHo4j/6ejNI4QOcScLoZ5aFZd7d+5DPgM4s
         IZww==
X-Gm-Message-State: AFqh2krPWicyBK4jMY/h3FvY35pxpMHBe9hnMNLPcMUSgfE7uiHTFiC9
        Q7RlXBzkFArt0AhMXuRJ2m6SAeQ4M3FvR3Ms
X-Google-Smtp-Source: AMrXdXsIJk1bRf8PoSn99Vtgf3XyW9uj+8ODQzDGm0qgYHutbImbt9NoSYoBQ0xNcO0bLOLMjbSrPQ==
X-Received: by 2002:a05:600c:1c27:b0:3cf:a83c:184a with SMTP id j39-20020a05600c1c2700b003cfa83c184amr21077043wms.24.1672334061537;
        Thu, 29 Dec 2022 09:14:21 -0800 (PST)
Received: from tpt440p.steeds.sam ([2602:fbf6:10:8::2])
        by smtp.gmail.com with ESMTPSA id n41-20020a05600c3ba900b003d358beab9dsm28085366wms.47.2022.12.29.09.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 09:14:21 -0800 (PST)
From:   "Sicelo A. Mhlongo" <absicsz@gmail.com>
To:     linux-omap@vger.kernel.org
Cc:     "Sicelo A. Mhlongo" <absicsz@gmail.com>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tony@atomide.com,
        devicetree@vger.kernel.org, maemo-leste@lists.dyne.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/2] ARM: dts: n900: rename accelerometer node
Date:   Thu, 29 Dec 2022 19:13:47 +0200
Message-Id: <20221229171348.3543327-2-absicsz@gmail.com>
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

Use generic node naming for lis302dl accelerometer, and drop its
label that is not used anywhere else.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
---
 arch/arm/boot/dts/omap3-n900.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 6ba2e8f81973..20d7a7bb6b04 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -767,7 +767,7 @@ &i2c3 {
 
 	clock-frequency = <400000>;
 
-	lis302dl: lis3lv02d@1d {
+	accelerometer@1d {
 		compatible = "st,lis3lv02d";
 		reg = <0x1d>;
 
-- 
2.39.0

