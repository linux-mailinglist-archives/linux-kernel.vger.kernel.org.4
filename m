Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0D67477E8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 19:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjGDRem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 13:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjGDRek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 13:34:40 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D111BD2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 10:34:14 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9924ac01f98so713469666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 10:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1688492053; x=1691084053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E82hjoqhMKWrCTgt/fXbmQjWVshoS0GVNipXIUdN9/k=;
        b=MknyirkMO5L5olTeZIB+6FibKKcCcnwpxx/lCEzrasyo2VaFLkGQnFAE3XfyPXBBrd
         5JxMLWQ7UgqdselInS83IA00I+bXOSMIaqZdnLoXYlsLnBsPk9jsj1FkP2NEBYAB8Itd
         3avYV1f8udp3EgWdoV4qLZSWIHNNmDKUnRAkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688492053; x=1691084053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E82hjoqhMKWrCTgt/fXbmQjWVshoS0GVNipXIUdN9/k=;
        b=R13x3ACZuvIEdog3e05gMIJ6OSpzJ/A5HbvA6mPaUAJ+wHgivVTznuxYlO5OBYDx/G
         WQB5AQIlZdoUpmPSjjayCGG64DwruzZgRcbyVti91l/BlkQJQxduAx+QhWb273K8ASR2
         lXckyXMhiJvttVBxFCjK//+c+iD1Gs+C78zIjzwamlIdfUyron5EyGhgrtucIIaBdKXq
         onHfWpOwuo8AmKCgIMWD1HNPzeTdQNw5qTY0TyUgfT6WXGIhOnoqVDYWHsYOSzvKMfSx
         FJ+vn/i/IVeefNawKurpaUTwdo00T92OUtv8g7aKlJ3E2OZF+xbwjLumSeTONvwFiXD8
         Vbww==
X-Gm-Message-State: ABy/qLaEQw9taeqcIxWA8b1/AkzU1Yg93m0gyBE+ZuskXGT/vrmzbWCY
        Bc6oMC1Mi6DSF0eeT8L365chG6OKaUK1EsBeEcI=
X-Google-Smtp-Source: APBJJlEUTY/dtc0SSVLyoiRR0j7AGo68Z6RwBaNZuNo7uqPpDBL2Z2MiKGW2gWb95F8odAa5qV455Q==
X-Received: by 2002:a17:906:a88b:b0:988:4a48:6ff3 with SMTP id ha11-20020a170906a88b00b009884a486ff3mr10024044ejb.30.1688492052935;
        Tue, 04 Jul 2023 10:34:12 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-58-49-236.retail.telecomitalia.it. [82.58.49.236])
        by smtp.gmail.com with ESMTPSA id v24-20020a1709064e9800b00992ca779f42sm6724645eju.97.2023.07.04.10.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 10:34:12 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 2/2] ARM: dts: stm32: add touchscreen on stm32f746-disco board
Date:   Tue,  4 Jul 2023 19:34:07 +0200
Message-Id: <20230704173407.590544-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230704173407.590544-1-dario.binacchi@amarulasolutions.com>
References: <20230704173407.590544-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds support for touchscreen on the stm32f746-disco board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 arch/arm/boot/dts/st/stm32f746-disco.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32f746-disco.dts b/arch/arm/boot/dts/st/stm32f746-disco.dts
index c11616ed5fc6..4830ccd48cb3 100644
--- a/arch/arm/boot/dts/st/stm32f746-disco.dts
+++ b/arch/arm/boot/dts/st/stm32f746-disco.dts
@@ -45,6 +45,7 @@
 #include "stm32f746-pinctrl.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "STMicroelectronics STM32F746-DISCO board";
@@ -99,6 +100,22 @@ &i2c1 {
 	status = "okay";
 };
 
+&i2c3 {
+	pinctrl-0 = <&i2c3_pins_a>;
+	pinctrl-names = "default";
+	clock-frequency = <400000>;
+	status = "okay";
+
+	touchscreen@38 {
+		compatible = "edt,edt-ft5306";
+		reg = <0x38>;
+		interrupt-parent = <&gpioi>;
+		interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
+		touchscreen-size-x = <480>;
+		touchscreen-size-y = <272>;
+	};
+};
+
 &sdio1 {
 	status = "okay";
 	vmmc-supply = <&mmc_vcard>;
-- 
2.32.0

