Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95FB625714
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbiKKJnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbiKKJnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:43:09 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEF5729A0;
        Fri, 11 Nov 2022 01:43:08 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id z5-20020a17090a8b8500b00210a3a2364fso7543763pjn.0;
        Fri, 11 Nov 2022 01:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyDKQpZMzsEhp0LAIu0OPkD/FuQNGjCcyBUAqhhwqak=;
        b=XRP4geMZx6kjuwTuwCzNE3NGQvZSPEpgUGPUs/on8NHxBiXRo40j+eGI6CUVyRP1vh
         QZPNUwTxiNDvtyoAg5z8UV4Tiye9mGB7m87FISgzUQdPRGluBENb9zLf45DZE3LcOmdu
         mCC052P4k0Zu+R8hCZqYWXdOvMuJk1LNtYQaWw0Y0QuPXRsihOdIAyH6ZEuGipMuOHzR
         0DINweUKaO2BXGVbpj+H3C5I0C5ZURPxqV94G4YeixQ34BWrKbUubzXncGEsrdxnUXGw
         YujkS7lHGqU8R0QeRZ9N3RsYmsU2Fg7GMI7ChqIWsqmA19VC1JU2dcSRshVUe9D8R4nq
         P+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pyDKQpZMzsEhp0LAIu0OPkD/FuQNGjCcyBUAqhhwqak=;
        b=K7EV0slOU0Ge6wY1rhSCLizCJohN/oDbsxRcoItkdjFtqssmaSODtgOTIs49dSLUkB
         aoOjTa/JV1sSYdwyEPW7EoYZ8GlPcU5lLIONejbIjWEZp3PkUz3yzpR45ZHN1W3xlmKp
         DvMXbfe3ir8Q4psw/8S5FZo7HtuYaANjTl+FkydkqqYIpewsIpv7A2RPNAGXXzD/+1WM
         M5yqQ0JAI/vjPbHQc34IBNDSoRTjS5E8B4Jb8h3khunrSHMcFpZOhcJ4jPhbMuMV0Ux4
         4k4q+A/wd06iDb80LruspsQOqKyruY85ArOoLaXYAWSotH1RJVHLZcp50s7olXG4ZFCd
         G9GQ==
X-Gm-Message-State: ANoB5pkQrlKY4Wo/FnViiftO+d0PIP5TOfCTvmNZxBH13odMc/0q0MOO
        +Dyog7LXU1H8rwKahpGKJFM=
X-Google-Smtp-Source: AA0mqf5LZt+ozbN3nDo5HbA+lemE2vIe5kztiCD5WFbcQhMyUR9mVULYpLTjBSnRmgtRuSJOVTckPQ==
X-Received: by 2002:a17:902:e54d:b0:188:4ea8:a685 with SMTP id n13-20020a170902e54d00b001884ea8a685mr1521777plf.71.1668159788465;
        Fri, 11 Nov 2022 01:43:08 -0800 (PST)
Received: from localhost.localdomain ([103.51.72.74])
        by smtp.gmail.com with ESMTPSA id fa13-20020a17090af0cd00b002086ac07041sm1188450pjb.44.2022.11.11.01.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 01:43:07 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Chukun Pan <amadeus@jmu.edu.cn>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [linux-next-v1 2/3] arm64: dts: rockchip: Add support of external clock to ethernet node on Rock 3A sbc
Date:   Fri, 11 Nov 2022 09:42:34 +0000
Message-Id: <20221111094238.1640-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111094238.1640-1-linux.amoon@gmail.com>
References: <20221111094238.1640-1-linux.amoon@gmail.com>
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

Add support of external clock gmac1_clkin which is used as input clock
to ethernet node.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
index 72e410e3aca8..16fff1ada195 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
@@ -32,6 +32,13 @@ hdmi_con_in: endpoint {
 		};
 	};
 
+	gmac1_clkin: external-gmac1-clock {
+		compatible = "fixed-clock";
+		clock-frequency = <125000000>;
+		clock-output-names = "gmac1_clkin";
+		#clock-cells = <0>;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -249,9 +256,8 @@ &cpu3 {
 
 &gmac1 {
 	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
-	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>;
-	assigned-clock-rates = <0>, <125000000>;
-	clock_in_out = "output";
+	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>, <&gmac1_clkin>;
+	clock_in_out = "input";
 	phy-handle = <&rgmii_phy1>;
 	phy-mode = "rgmii";
 	pinctrl-names = "default";
@@ -259,6 +265,7 @@ &gmac1 {
 		     &gmac1m1_tx_bus2
 		     &gmac1m1_rx_bus2
 		     &gmac1m1_rgmii_clk
+		     &gmac1m1_clkinout
 		     &gmac1m1_rgmii_bus>;
 	status = "okay";
 };
-- 
2.38.1

