Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CD1705AF9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 01:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjEPXE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 19:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjEPXET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 19:04:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E195B7AB2;
        Tue, 16 May 2023 16:03:54 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2405:201:0:21ea:73f6:2283:f432:3936])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DC69E6605906;
        Wed, 17 May 2023 00:03:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684278232;
        bh=lDz/zDew1D+agp77cTWfGbMYmza4eMo3EHXMw7US+9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TwiO4uSHH2bl0609n6yUlQY6/QBubDltJLEdZGoy0Y9KYXrk95H3DtmAhq1XV5m9V
         rmZmcsvhlXHpjqjn7cr/zKNXkgUs31KNFxdok+0EmMqGjBDa1XMKxqCr8qjFt75z87
         IwN4lOtCWV2UHh+NBFM5jOqGYC3sTXAaQKbwF+GJ0wCO4fOf7ZnlBgN4ZooocPDIBO
         RIf09Gylnz7UbmCVxRYXkDijGZsBjnRjlqeehqnBHjQcJ2N0Nkgu1qyXkBDcFMZSOF
         Z8BmHBwcjOm2SSOz9Ql8ehIw+Nhpc1sqVVWCQ4UO2dC5zBEzR2sb1UmQlVGIT8/nsA
         32VoFv9tLdoAA==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     jic23@kernel.org, lars@metafoo.de, heiko@sntech.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sebastian.reichel@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, gustavo.padovan@collabora.com,
        serge.broslavsky@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH 6/7] arm64: dts: rockchip: Add DT node for ADC support in RK3588
Date:   Wed, 17 May 2023 04:30:50 +0530
Message-Id: <20230516230051.14846-7-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230516230051.14846-1-shreeya.patel@collabora.com>
References: <20230516230051.14846-1-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT node for ADC support in RK3588.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 657c019d27fa..6c4424bc4b1b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -1825,6 +1825,18 @@ dmac2: dma-controller@fed10000 {
 		#dma-cells = <1>;
 	};
 
+	saradc: saradc@fec10000 {
+		compatible = "rockchip,rk3588-saradc";
+		reg = <0x0 0xfec10000 0x0 0x10000>;
+		interrupts = <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH 0>;
+		#io-channel-cells = <1>;
+		clocks = <&cru CLK_SARADC>, <&cru PCLK_SARADC>;
+		clock-names = "saradc", "apb_pclk";
+		resets = <&cru SRST_P_SARADC>;
+		reset-names = "saradc-apb";
+		status = "disabled";
+	};
+
 	system_sram2: sram@ff001000 {
 		compatible = "mmio-sram";
 		reg = <0x0 0xff001000 0x0 0xef000>;
-- 
2.30.2

