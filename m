Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AEF6B6E8F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 05:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjCMEzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 00:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjCMEzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 00:55:45 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9F835265;
        Sun, 12 Mar 2023 21:55:44 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id q6so4546427iot.2;
        Sun, 12 Mar 2023 21:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678683343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gpq6X/4WS7nrx/ihZzLk1eGxqJisJrm0b1Z3C7/sHiY=;
        b=VVJP0l+6wl3D4HQv8BZkNIroI5pwpa4btEYlyh1dWdwJrRgSzBwymmZ0eYHTIsT0uC
         1wXM9lAu6tdWZg95ImZJYtWcZXqIOpvrARhycSSc0qHfBVHo85z3Vags9SU+B84+UvjI
         VIVtZhqdUtgWUVsCvR9JxXMdrDN19b6LWqFqYNPhwSPQNguFeTZk8gSDdpzypnvsY4j2
         g5BH3sCifCfWtulQ1X3O/a/2Rnh1BluOpnXcIOy9EQllsGS/HEpp0xKM8V79MFTST5+v
         wMuc6hr47oyGpPqhYZ2z8XFAU/zYkarF71TgwhkXbR41G3ipAmERaqnaScWDFnvFNUDE
         HVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678683343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gpq6X/4WS7nrx/ihZzLk1eGxqJisJrm0b1Z3C7/sHiY=;
        b=oJFEKQgDB1CmWkkf2NFXa19+YS5+bzsWx4hylM/TPK3b5UN3vpGHc9EAAxVgDnziM/
         4dJwsPWklSmer+3hK7VDrbNvE11lkitoUq2NkGT4WP87L3QlLNnh4mtsS/BfsA4zNuVZ
         +/H8Zfc2A6krPNATFX9tw+0VfWMVqJ5EcX794mS0lg9YdvxmV4Rp1Mh2Cn6Apg2hvFzG
         0tnj3rVZDfp98W0blUBoOItvuBps5jznBUmIxlaFwoT2kH4xL67you4vq0QdNFLtYx/8
         YaXJxLB2ReNcNSh3MDrjWHwLB1PVVLEt6njEiOcM61735wyO3gLArjkuDcV6uBG+u+f7
         EULA==
X-Gm-Message-State: AO0yUKUANOwLQwRisidOxUky2Nlk+MrMlwmblLdjW01hWaTSZJp8mz5l
        J7iDRAQa74bPI+lDRmgRX6g=
X-Google-Smtp-Source: AK7set/vaKhV5BybX29gbzgA7KfHXdksLjbCadOAxjzAmtTlZgN6liZnpTLpc/44YL0k3TVPX3dPVg==
X-Received: by 2002:a6b:b7c3:0:b0:746:190a:138f with SMTP id h186-20020a6bb7c3000000b00746190a138fmr6388871iof.2.1678683343597;
        Sun, 12 Mar 2023 21:55:43 -0700 (PDT)
Received: from JOEL-DESKTOP.. ([2604:2d80:4d87:cd00:9f51:32d7:1177:67d])
        by smtp.gmail.com with ESMTPSA id p19-20020a0566380e9300b003eac69029e5sm2175085jas.79.2023.03.12.21.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 21:55:43 -0700 (PDT)
From:   Joel Selvaraj <joelselvaraj.oss@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <joelselvaraj.oss@gmail.com>
Subject: [PATCH] arch: arm64: qcom: sdm845-xiaomi-beryllium: add notification LED
Date:   Sun, 12 Mar 2023 23:55:39 -0500
Message-Id: <20230313045539.47538-1-joelselvaraj.oss@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Enable the Qualcomm Light Pulse Generator (LPG) driver based
notification LED.

Signed-off-by: Joel Selvaraj <joelselvaraj.oss@gmail.com>
---
 .../boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
index e0fda4d754fe..9d11502e5e0e 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
@@ -2,6 +2,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include <dt-bindings/sound/qcom,q6afe.h>
@@ -322,6 +323,16 @@ vol_up_pin_a: vol-up-active-state {
 	};
 };
 
+&pmi8998_lpg {
+	status = "okay";
+
+	led@5 {
+		reg = <5>;
+		color = <LED_COLOR_ID_WHITE>;
+		function = LED_FUNCTION_STATUS;
+	};
+};
+
 &pmi8998_wled {
 	status = "okay";
 	qcom,current-boost-limit = <970>;
-- 
2.39.2

