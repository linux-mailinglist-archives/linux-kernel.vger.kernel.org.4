Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779DF686E7C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 19:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjBAS5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 13:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbjBAS5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 13:57:11 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037787CCB5;
        Wed,  1 Feb 2023 10:57:09 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id f7so11480177edw.5;
        Wed, 01 Feb 2023 10:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQ2TcNqdLFOAVmLP5M0cy768AQ+LH1yHfkoCaBZyfHc=;
        b=RdzQM9UxdzXFHlTygjnB05HaKkfeckDFaoC0sQILZA8OjUcHc46SFz7RLBKN/jXBE6
         sBSjrAxxSLEPVES5uw9VQVE7SsY8rcvVATXQ/kOT+o6zRsoNLYMG9G9SEAd8qICEofgP
         138j1q+gS5EwFUGWHaMPifgTEMUvZVPZZ+1qrZyStRMn8odP7pPH1oVDIxpNEtJkUA+1
         SowWyQkWJ9cyG9mr+K6BQ0EvAjLWTbg4cYrNbCgHOfOhtocVQmQ+hmweRqQgbm1p3vdc
         6Ioru6D1UEh4F7Vwk9mc/+pE/P2P44cnRJs3gVIGl0W9j+7jHF0M1g99hL+mdYFPUFW3
         NJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQ2TcNqdLFOAVmLP5M0cy768AQ+LH1yHfkoCaBZyfHc=;
        b=RaXZexS5rfNWSeg5ua3pjjB1vBOQSY5uZPOu+H2LKmJKYwHk9Hwuh29kl3gomx5S25
         P6gW+6JvJ84q7Viu/DVPPbqVKhAXV6+HeprJiMtE8ayzphBPUxhP5sIypPHhWnawWjJe
         yhroMpMC278g9mdV/p8V2Wk8ni6dJcn4rz9n8LGF2TzYJFPkjIlRU48NtbmTj4ENyLza
         j/d5YXFzQEDDc2knTKyjgitFV4SX9OQhYRKqkUqQQrbwZe2Q34kvZoFeM7yJQhKcWhPK
         xq4boyDtP1Tej/WN/bZZduI/Cc5JIjhv9qFoRqyvosaP9SNnrc0FPL+KtJdaTI2B86JI
         Qlsw==
X-Gm-Message-State: AO0yUKVN+qq7onEkpz1rW+TN2UgUQ39krER2PovAAzVMtF8wCm7px9XO
        nRwkpVREoVqD8MzI5Gc2hkQ=
X-Google-Smtp-Source: AK7set9skUgnmhi1dYpijfocB0rlZ+p6Q6V2+UCwzZI/enK59SfnsKbNtQF2gvImI2edWtLPb7F3Cg==
X-Received: by 2002:a05:6402:35c7:b0:499:cc32:6a52 with SMTP id z7-20020a05640235c700b00499cc326a52mr8873964edc.16.1675277828527;
        Wed, 01 Feb 2023 10:57:08 -0800 (PST)
Received: from arinc9-PC.lan ([37.120.152.236])
        by smtp.gmail.com with ESMTPSA id dy25-20020a05640231f900b0049e210884dasm10100883edb.15.2023.02.01.10.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 10:57:08 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Frank Wunderlich <frank-w@public-files.de>,
        erkin.bozoglu@xeront.com, Sean Wang <sean.wang@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>
Subject: [PATCH v2 3/5] arm: dts: mt7623: change mt7530 switch address
Date:   Wed,  1 Feb 2023 21:56:54 +0300
Message-Id: <20230201185656.17164-4-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230201185656.17164-1-arinc.unal@arinc9.com>
References: <20230201185656.17164-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Arınç ÜNAL <arinc.unal@arinc9.com>

In the case of muxing phy0 of the MT7530 switch, the switch and the phy
will have the same address on the mdio bus, 0. This causes the ethernet
driver to fail since devices on the mdio bus cannot share an address.

Any address can be used for the switch, therefore, change the switch
address to 0x1f.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 arch/arm/boot/dts/mt7623a.dtsi                | 4 ++--
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 4 ++--
 arch/arm/boot/dts/mt7623n-rfb-emmc.dts        | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/mt7623a.dtsi b/arch/arm/boot/dts/mt7623a.dtsi
index fbb5731a3a53..dd522e508eb3 100644
--- a/arch/arm/boot/dts/mt7623a.dtsi
+++ b/arch/arm/boot/dts/mt7623a.dtsi
@@ -36,9 +36,9 @@ mdio: mdio-bus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		switch0: switch@0 {
+		switch0: switch@1f {
 			compatible = "mediatek,mt7530";
-			reg = <0>;
+			reg = <0x1f>;
 			mediatek,mcm;
 			resets = <&ethsys MT2701_ETHSYS_MCM_RST>;
 			reset-names = "mcm";
diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
index 1e03a3de654f..dc9b4f99eb8b 100644
--- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
+++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
@@ -189,9 +189,9 @@ mdio-bus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		switch@0 {
+		switch@1f {
 			compatible = "mediatek,mt7530";
-			reg = <0>;
+			reg = <0x1f>;
 			reset-gpios = <&pio 33 0>;
 			core-supply = <&mt6323_vpa_reg>;
 			io-supply = <&mt6323_vemc3v3_reg>;
diff --git a/arch/arm/boot/dts/mt7623n-rfb-emmc.dts b/arch/arm/boot/dts/mt7623n-rfb-emmc.dts
index 5e328c2a6a6e..6b0c3d1006ab 100644
--- a/arch/arm/boot/dts/mt7623n-rfb-emmc.dts
+++ b/arch/arm/boot/dts/mt7623n-rfb-emmc.dts
@@ -185,9 +185,9 @@ phy5: ethernet-phy@5 {
 			phy-mode = "rgmii-rxid";
 		};
 
-		switch@0 {
+		switch@1f {
 			compatible = "mediatek,mt7530";
-			reg = <0>;
+			reg = <0x1f>;
 			reset-gpios = <&pio 33 0>;
 			core-supply = <&mt6323_vpa_reg>;
 			io-supply = <&mt6323_vemc3v3_reg>;
-- 
2.37.2

