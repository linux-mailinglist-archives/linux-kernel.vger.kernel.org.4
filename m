Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3797211B0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 20:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjFCSz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 14:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjFCSzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 14:55:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C2110C7;
        Sat,  3 Jun 2023 11:55:03 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2405:201:0:21ea:e49:10dd:40c0:e842])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D621066031BB;
        Sat,  3 Jun 2023 19:54:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685818502;
        bh=jSXs78i99G06gintRwSg5+8JsDLxQU7hBBHV8+/cw28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YrTmPgT0nSO/i2DjLbZUkzrVO16s+Toq3RBgc13mU2Tx5NsBYKV1v7q/1A6qYxnO5
         D42btqX0DnC7nwxrv4Nl4l9m0SjrERXdCVK1cg4JxH6CEtBA7reDG6wEnw1/uzqePn
         RqWvL7hkKxhphFSkAU3KhaBRGICbO7oiRuEZ0HGSoiGalEOf+mK2ZGHP7WC4ZVEIHT
         lIJqXqL1ZSAUMa9gat4ux7DUaqFByOxbnlgzgd29XTb0kieH96v98h9XTlufUeuB+f
         vFB6DopJjft/kHxRDQUZV8E/B+JMUOgi17gQR9iZ0P1v2r3ZM4oA009jXiGqhb/I2j
         rc1E+JisZRj9w==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     jic23@kernel.org, lars@metafoo.de, heiko@sntech.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sebastian.reichel@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        gustavo.padovan@collabora.com, kernel@collabora.com,
        serge.broslavsky@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH v3 7/8] arm64: dts: rockchip: Add DT node for ADC support in RK3588
Date:   Sun,  4 Jun 2023 00:23:39 +0530
Message-Id: <20230603185340.13838-8-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230603185340.13838-1-shreeya.patel@collabora.com>
References: <20230603185340.13838-1-shreeya.patel@collabora.com>
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

Changes in v3
  - No change

Changes in v2
  - No change

 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 5d010f34a7f7..9cfa7ba97461 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -1913,6 +1913,18 @@ dmac2: dma-controller@fed10000 {
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

