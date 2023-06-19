Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7610735C85
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 18:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjFSQz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 12:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjFSQzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 12:55:54 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7244FE79
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:55:46 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-763a2e39b88so63212485a.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1687193745; x=1689785745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlm5X0f1SJIUHEa+Ch7CRBAmlhS5LXsyaOP8GZ1/KKI=;
        b=SbYaNKhZPSx1sEjz/QOmKUpfVdd4KYPGpnFG5o2FjQoLIdAKa/JtEsZyqqQqKAnzk4
         ZmKpBIt7MoAo9tgpvbeV2PRVwqZHASQIuz747g1ZEkSlH503cifT+6L+NLoaYUbMGItT
         lh1ITnNB5CHjf2eheHdqIKGta6wxVFcWREhxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687193745; x=1689785745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tlm5X0f1SJIUHEa+Ch7CRBAmlhS5LXsyaOP8GZ1/KKI=;
        b=AclWNavpV05mSdWzDe1iBEBSFP6W9B6ct6QTA+N3qJyAm5Z+qr3rhp+ETCzDsoR1ti
         F8AUQfm1zQ2OQRJHL1aw2Ycxwj7lS11b4n8D+YIESclw9ZOnLuWQzgQFhtdwhAxuLgGj
         1Ms2EprQuaxpZcm/4AweVI9zYWy2G3H55Ecbf+48R0TnuA9G6X87hJ6CvVF0Sftij754
         v0ToBtfRiVpMJJqQMdIFinckFfbErzAV2MgG+v/TgFxdNkdjfyrSbjk79MTYCMO0iiou
         tHFlFHlCKFfQeNQ11F+NXzjq4PLM67CP/dU/J76TmYsnSQUyyIb/DfWmMhjxW8aemL+d
         p1Jg==
X-Gm-Message-State: AC+VfDwHOvYk6rEpe28JAi+6Wxue5+ctfOunBok2IPAclvyoRtV0baFx
        Kld4++2EwVIx9xZiZ3IMqod/VERZ2oaztAeoZY0=
X-Google-Smtp-Source: ACHHUZ5XtYO/z/qdMae1APmugjsBTfX/hOgFeCOsZeWBWZcBbnyjdbRxpFNWkSyPbqXvArT1y6dNMA==
X-Received: by 2002:a05:620a:20c9:b0:763:a671:b983 with SMTP id f9-20020a05620a20c900b00763a671b983mr1285107qka.11.1687193745422;
        Mon, 19 Jun 2023 09:55:45 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.pdxnet.pdxeng.ch (host-79-25-27-4.retail.telecomitalia.it. [79.25.27.4])
        by smtp.gmail.com with ESMTPSA id p23-20020a05620a15f700b0075d49ce31c3sm109103qkm.91.2023.06.19.09.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 09:55:45 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Philippe Cornu <philippe.cornu@foss.st.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v4 3/6] ARM: dts: stm32: support display on stm32f746-disco board
Date:   Mon, 19 Jun 2023 18:55:22 +0200
Message-Id: <20230619165525.1035243-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230619165525.1035243-1-dario.binacchi@amarulasolutions.com>
References: <20230619165525.1035243-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to Rocktech RK043FN48H display on stm32f746-disco board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 arch/arm/boot/dts/stm32f746-disco.dts | 51 +++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f746-disco.dts b/arch/arm/boot/dts/stm32f746-disco.dts
index c11616ed5fc6..cda423b6a874 100644
--- a/arch/arm/boot/dts/stm32f746-disco.dts
+++ b/arch/arm/boot/dts/stm32f746-disco.dts
@@ -60,10 +60,41 @@ memory@c0000000 {
 		reg = <0xC0000000 0x800000>;
 	};
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			no-map;
+			size = <0x80000>;
+			linux,dma-default;
+		};
+	};
+
 	aliases {
 		serial0 = &usart1;
 	};
 
+	backlight: backlight {
+		compatible = "gpio-backlight";
+		gpios = <&gpiok 3 GPIO_ACTIVE_HIGH>;
+		status = "okay";
+	};
+
+	panel_rgb: panel-rgb {
+		compatible = "rocktech,rk043fn48h";
+		backlight = <&backlight>;
+		enable-gpios = <&gpioi 12 GPIO_ACTIVE_HIGH>;
+		status = "okay";
+		port {
+			panel_in_rgb: endpoint {
+				remote-endpoint = <&ltdc_out_rgb>;
+			};
+		};
+	};
+
 	usbotg_hs_phy: usb-phy {
 		#phy-cells = <0>;
 		compatible = "usb-nop-xceiv";
@@ -99,6 +130,26 @@ &i2c1 {
 	status = "okay";
 };
 
+&dma1 {
+	status = "okay";
+};
+
+&dma2 {
+	status = "okay";
+};
+
+&ltdc {
+	pinctrl-0 = <&ltdc_pins_a>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	port {
+		ltdc_out_rgb: endpoint {
+			remote-endpoint = <&panel_in_rgb>;
+		};
+	};
+};
+
 &sdio1 {
 	status = "okay";
 	vmmc-supply = <&mmc_vcard>;
-- 
2.32.0

