Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6299E6C0384
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 18:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjCSRmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 13:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCSRmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 13:42:09 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BD51C594;
        Sun, 19 Mar 2023 10:42:08 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id t129so4503514iof.12;
        Sun, 19 Mar 2023 10:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679247727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dcI4BBLYtEvhPbu+xjdZvkfgUtEKrU3F0hXnGswV/Ug=;
        b=rRXEqAYEezh5J0LaA5GuJCDOm0q2BLyqsi/c5VGUO3vtMITDdDkMrMyi1PL9faIEpW
         llTE3UCik8RdZCcSSU4C7t36juiixG96gFVwMQFDKUMxKLitX1fVSbxiZbAwfAsV7+89
         D7OtgHNbInyWtVdt/SS4ETD0SeoqW0WrunQxLcxcdnRf6vMk8ggllRRj7T+E5ehWsU5v
         ZrnFWm1EEM0WHocn4CpEmtQRjF5zp+pS0A+ySLNvcEClIRLbBCJz10GxBivjpfL//S+s
         1T1+y7yhCNVVNy/MdBZiykOFaQfdGNorXQR2eOF2+8UEsim1pIp5z5mq0GDnCzNbx4r6
         HBfg==
X-Gm-Message-State: AO0yUKVLVmGpuSgvLJgOFEGyJgoggkcR7vMwCxQcGnEHpnH2KGtGjWYY
        fVoMRhaMv04Yc7BjDLKgyg==
X-Google-Smtp-Source: AK7set//n98nJ9+FQb0BtZHd7Da1WEWuL+VuV6QwEqnbAqyime0B6gw0uRYnbo/zcfdtajUZCIApqw==
X-Received: by 2002:a5e:da4b:0:b0:74c:b180:c5db with SMTP id o11-20020a5eda4b000000b0074cb180c5dbmr4082518iop.20.1679247726909;
        Sun, 19 Mar 2023 10:42:06 -0700 (PDT)
Received: from robh_at_kernel.org ([2605:ef80:80c2:711:b843:6628:3fd6:ded4])
        by smtp.gmail.com with ESMTPSA id l9-20020a5d8f89000000b00740710c0a65sm2288038iol.47.2023.03.19.10.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 10:42:06 -0700 (PDT)
Received: (nullmailer pid 44793 invoked by uid 1000);
        Sun, 19 Mar 2023 17:41:55 -0000
From:   Rob Herring <robh@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/arm: dts: rockchip: Fix DSI node names
Date:   Sun, 19 Mar 2023 12:41:05 -0500
Message-Id: <20230319174105.43978-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DSI bus/controller nodes should be named 'dsi' rather than 'mipi'.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/boot/dts/rk3288.dtsi            | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 2ca76b69add7..d401b850583c 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -1114,7 +1114,7 @@ vopl_mmu: iommu@ff940300 {
 		status = "disabled";
 	};
 
-	mipi_dsi: mipi@ff960000 {
+	mipi_dsi: dsi@ff960000 {
 		compatible = "rockchip,rk3288-mipi-dsi", "snps,dw-mipi-dsi";
 		reg = <0x0 0xff960000 0x0 0x4000>;
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 1881b4b71f91..e44e1c40c0ba 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1954,7 +1954,7 @@ hdmi_in_vopl: endpoint@1 {
 		};
 	};
 
-	mipi_dsi: mipi@ff960000 {
+	mipi_dsi: dsi@ff960000 {
 		compatible = "rockchip,rk3399-mipi-dsi", "snps,dw-mipi-dsi";
 		reg = <0x0 0xff960000 0x0 0x8000>;
 		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH 0>;
@@ -1990,7 +1990,7 @@ mipi_in_vopl: endpoint@1 {
 		};
 	};
 
-	mipi_dsi1: mipi@ff968000 {
+	mipi_dsi1: dsi@ff968000 {
 		compatible = "rockchip,rk3399-mipi-dsi", "snps,dw-mipi-dsi";
 		reg = <0x0 0xff968000 0x0 0x8000>;
 		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH 0>;
-- 
2.39.2

