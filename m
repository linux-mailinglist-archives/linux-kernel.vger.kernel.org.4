Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DEA609074
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 01:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiJVXki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 19:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJVXkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 19:40:35 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2A4785A1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 16:40:33 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id by36so8439306ljb.4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 16:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C6At1H3szjViJnkV3q1VRKzRG4v2Bj/cByCEwQ1bgyM=;
        b=VQ7mbzj5hN8t52IfZwXU2t2B95RRp7vmkiDpjZTVDaEI1x0VBP/iysdDlLGUa6wPji
         U26MuG7nEDCxDQwr4XjJqN2lglZacSeRqq0UYk1GLdQiE8y1BqYHPFtR5DstYTRl6Zjh
         +thhymXHeveBJ8g4OBx7law2Q8osxes7zx8rA+3QoT4iY/4Ux44zYQgZTL7W443zyKjc
         LLxHO2qd4Zw84SYawq25Tc0tkXK+FwPfaqh36GjAT0tuNpnq9aK3APIr7L0fojratQIo
         iMpsILAzdk6v4zHxdclu/LFOTEJDXWydP7zQ7IsyTdt9g2m6OxUSFM8qh4pzevB2ThQV
         82iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C6At1H3szjViJnkV3q1VRKzRG4v2Bj/cByCEwQ1bgyM=;
        b=w346s00S02L+24t/bWj1FMjJJNfskDL8hMZSwdx4iP4wRYZdnBQFv6uWQ5EJgK1UZ+
         I4fBu0VLZVajpG3cD+ssjo+Fi/Qmm2jSV7ezpEoPBDiRsA8nLfD6nRIQDEReEPlrVyrX
         HaXhbayMGi3tkS+H8WuPPbMgInd1wqx6iT7UAQ2C1Y0x8iwRr+VMMG500YugxpeflC/o
         uDcnsBLhERv3BqIO7FA5vETdhllRszEX7UUpOKQTshUsL0xHqJLhmP6d9WsDawrN1zeB
         3UDwztmMPyFHS2Pi4/278wZuVrA9lzby3t1WwpIgarURxtTnR7ooK2mdtAoACElpx+3X
         Uc/g==
X-Gm-Message-State: ACrzQf2mDvMEVXjo9ZwVKQ9bdOCAtcAOsO6vyw0xJ/RHSQxOjmhww9JN
        o9PP9dVRTo1FEl+VPO8Mt3r3Nw==
X-Google-Smtp-Source: AMsMyM78SWXFcbPfgcCDhdUH4DnOOhgkkgPfPbbUHfJQo1Nu6MQXuSWEQUlwUTBljuFsGMu/BNn5dg==
X-Received: by 2002:a2e:97d7:0:b0:277:4c7:c938 with SMTP id m23-20020a2e97d7000000b0027704c7c938mr571272ljj.294.1666482031813;
        Sat, 22 Oct 2022 16:40:31 -0700 (PDT)
Received: from gilgamesh.lab.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id e10-20020a05651236ca00b004949f7cbb6esm3752602lfs.79.2022.10.22.16.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 16:40:31 -0700 (PDT)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, hch@lst.de, kabel@kernel.org,
        jaz@semihalf.com, Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH] ARM: dts: armada-38x: Mark devices as dma-coherent
Date:   Sun, 23 Oct 2022 01:40:24 +0200
Message-Id: <20221022234024.87475-1-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
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

Armada 38x platforms marks all devices as coherent via
mvebu_hwcc_notifier(), whereas the standard way to determine
this is by of_dma_is_coherent(). Reflect the hardware
capabilities by adding 'dma-coherent' properties to the device tree.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 arch/arm/boot/dts/armada-380.dtsi | 1 +
 arch/arm/boot/dts/armada-385.dtsi | 1 +
 arch/arm/boot/dts/armada-38x.dtsi | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/armada-380.dtsi b/arch/arm/boot/dts/armada-380.dtsi
index ce1dddb2269b..25d17550e2fc 100644
--- a/arch/arm/boot/dts/armada-380.dtsi
+++ b/arch/arm/boot/dts/armada-380.dtsi
@@ -38,6 +38,7 @@ pcie {
 			compatible = "marvell,armada-370-pcie";
 			status = "disabled";
 			device_type = "pci";
+			dma-coherent;
 
 			#address-cells = <3>;
 			#size-cells = <2>;
diff --git a/arch/arm/boot/dts/armada-385.dtsi b/arch/arm/boot/dts/armada-385.dtsi
index 83392b92dae2..6fb8c254cbdc 100644
--- a/arch/arm/boot/dts/armada-385.dtsi
+++ b/arch/arm/boot/dts/armada-385.dtsi
@@ -37,6 +37,7 @@ pciec: pcie {
 			compatible = "marvell,armada-370-pcie";
 			status = "disabled";
 			device_type = "pci";
+			dma-coherent;
 
 			#address-cells = <3>;
 			#size-cells = <2>;
diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 446861b6b17b..5801873dfcbe 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -102,6 +102,7 @@ internal-regs {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 MBUS_ID(0xf0, 0x01) 0 0x100000>;
+			dma-coherent;
 
 			sdramc: sdramc@1400 {
 				compatible = "marvell,armada-xp-sdram-controller";
-- 
2.29.0

