Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6F365751A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 11:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbiL1KGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 05:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbiL1KF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 05:05:28 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F8310063;
        Wed, 28 Dec 2022 02:05:27 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so15654391pjd.0;
        Wed, 28 Dec 2022 02:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RV2gKx+ImpgFBjPm9dyBpImlDYC4T4c39ICqJ71RD4Y=;
        b=m7XOWPjkKjPzvRjq/Gd84qiQH3j0ogxyHrKL6mktIATiS7MLRQjNo9Jze14v8qw70Z
         M1jYBiz92tL7+wITxqo3KT31+w5qZ/WlpUR0fjRogyrDBDSuFGMPkP76mDgSPFqI7V2T
         GpPI3jyY3gs7eM8eXYtGZakp1DUgFtNg9rhbyzlEsoDxAdpeQFLZ8LPKSacUJumUHYWl
         F2axCUDA4ItmZkbPQZP5ZeQC8VcBQN67rVkSOD6izwbe27/mIiSRkf99JxnTixTJgSIL
         OZRW+gf3oHGo7Z3d7F3g9ztCY3F3iHt3VDMQ7L/+1N7H+NnUGDwxdSFBZ/REy7xDB6Ys
         EJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RV2gKx+ImpgFBjPm9dyBpImlDYC4T4c39ICqJ71RD4Y=;
        b=ce/v31Oh8MWxn9Gt8eLoUELLub3Oacj1/spQ7DBg38XtEGydCQ/eWI8GLTVTA8+cmw
         2jf+O3cXsgOELlCDN10ks/0ypmuHCCez5XahTKdsuk/4q7hFcBabqMWz6hTKtZsi/yNE
         YKxe4A4/QnFtATqAtgsMbkkWDJ4wKUlahqI8lEXEb1HmdWxJyjk3Q+YdFmDvtbgirTRC
         aiDTiJuTJixHU+XI2AsyHAgmYs28CjA1YLaLRDZbtOqcUxxT1DQI3pksCnGpqV0kH3hk
         IAhosoongOtXg/5CeUKRatjgtv1mH7QjHubuTfRyEyne7+GtRCB/Np7AewKn6FeZvwit
         jbvA==
X-Gm-Message-State: AFqh2kqQYA36+oLW0AQGihoD1UXv9ppf1fNdW3ovWah3fbqIPlL9kKiC
        77Rbx2ZOry1fSuWUEBScQkw=
X-Google-Smtp-Source: AMrXdXsfi0gBxw2JIb1Q3UK0+j1Lw9FOCcImOnvQgu4ReAtjZbecY6rIn56RYxzdOUvzSa5aabpqPA==
X-Received: by 2002:a05:6a20:8f2a:b0:9d:efbe:52ae with SMTP id b42-20020a056a208f2a00b0009defbe52aemr38715217pzk.30.1672221926637;
        Wed, 28 Dec 2022 02:05:26 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.26])
        by smtp.gmail.com with ESMTPSA id t6-20020a1709027fc600b0019277df45a6sm5794915plb.53.2022.12.28.02.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 02:05:26 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 04/11] arm64: dts: amlogic: Used onboard usb hub reset on odroid n2
Date:   Wed, 28 Dec 2022 10:03:13 +0000
Message-Id: <20221228100321.15949-5-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221228100321.15949-1-linux.amoon@gmail.com>
References: <20221228100321.15949-1-linux.amoon@gmail.com>
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

On Odroid n2 previously use gpio-hog to reset the usb hub,
switch to used on-board usb hub reset to enable the usb hub
and enable power to hub.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 .../dts/amlogic/meson-g12b-odroid-n2.dtsi     | 26 ++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
index 667d2b774924..e5ae885c4008 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
@@ -347,6 +347,20 @@ codec {
 			};
 		};
 	};
+
+	usb {
+		dr_mode = "host";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		hub: hub@1 {
+			/* Genesys Logic GL3523-QFN76 usb hub*/
+			compatible = "genesys,usb5e3,620";
+			reg = <1>;
+			vdd-supply = <&hub_5v>;
+			reset-gpios = <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
+		};
+	};
 };
 
 &acodec {
@@ -535,18 +549,6 @@ &gpio {
 		"PIN_3",  /* GPIOX_17 */
 		"PIN_5",  /* GPIOX_18 */
 		"PIN_36"; /* GPIOX_19 */
-	/*
-	 * WARNING: The USB Hub on the Odroid-N2 needs a reset signal
-	 * to be turned high in order to be detected by the USB Controller
-	 * This signal should be handled by a USB specific power sequence
-	 * in order to reset the Hub when USB bus is powered down.
-	 */
-	hog-0 {
-		gpio-hog;
-		gpios = <GPIOH_4 GPIO_ACTIVE_HIGH>;
-		output-high;
-		line-name = "usb-hub-reset";
-	};
 };
 
 &hdmi_tx {
-- 
2.38.1

