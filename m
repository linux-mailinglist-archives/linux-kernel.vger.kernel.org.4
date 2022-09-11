Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35CC5B4B8A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 06:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiIKEGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 00:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiIKEGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 00:06:36 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A983B2189;
        Sat, 10 Sep 2022 21:06:35 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id ml1so4404769qvb.1;
        Sat, 10 Sep 2022 21:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=mnufVPIaWa860PrqWW20aPuK+AZA/lbKd9aS/sEntN4=;
        b=PLb2wHbQ25Ejf1mcoH7bdgd1mbh0yf6VzcsfAcE6SOaaO+slxLzn3eLfi4Q3fCIFEX
         970nwzJb3JKgxW8l8+h2Rb5ICJ68UbBORBhv4kTGdECunisI6QtYXlK8U0M6jyvwI821
         jEJe79gej8kfPvxFoCRUY4nbN0svYZMKtN66rMdTROqnW0JJHcr8jBp5CEGpP/Hq+Tbw
         jDh3DeBzIlHiEr7owrYWdCLQqJsrAuMXNwoKPVNjRmIcpB8gFYnjwOcgRKbR7/WG6IPY
         gPip3jQiCZcZvStT0Q2DAm3T3IfORF/2mOwjLFv80YYKE1lcWafks2oscqi+fNgZYYpV
         Xh7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=mnufVPIaWa860PrqWW20aPuK+AZA/lbKd9aS/sEntN4=;
        b=2FNWiBHvVlixh3+ZcbFdb9gcZu7JEQ58Vs16Qj+nuJX4co/fdalPqScfzKClaiFtbZ
         nep5a5l6z2n5T3Bdl5mFdKNpQVnyl4hTw1wMYOaeHREnMO/r7FmnDdvQzL66Chu0WMqC
         ndfd9jA5aFPSGN8yBmxT0x/BTI0oO0OiOxlAUgqb9AyYpKXo9HbPK8TYdeM5/lSVlKmW
         gCD3wm9tcl5wvfp47oiz9ejFnByiX7oV9XdYSFZXxW+sgBnJyLZCgFOe/Ou186QoE3La
         JCot1KyAVXQvD24i7+cjnKZfAP2lL3FlWVofz6QGX3/20fj9jsvJzeyPr+W9pbFApXPM
         u7mA==
X-Gm-Message-State: ACgBeo3XSThWw670rNI25Vwlv837qJcnaeP52PC9y1PVs4XwXOQLbrbm
        IPWeS45TPTCcZYVn6Ar6F1g=
X-Google-Smtp-Source: AA6agR46meu1WJI6gR+abO8aQh7nqYJ2PVDkjHurgdsbC26t61U8oE/7WCF5eASLd1gkGN9CSF35CQ==
X-Received: by 2002:a05:6214:2468:b0:4ac:8786:f20e with SMTP id im8-20020a056214246800b004ac8786f20emr9060109qvb.50.1662869194791;
        Sat, 10 Sep 2022 21:06:34 -0700 (PDT)
Received: from localhost.localdomain (tunnel525895-pt.tunnel.tserv15.lax1.ipv6.he.net. [2001:470:c:1200::2])
        by smtp.googlemail.com with ESMTPSA id i2-20020a05620a248200b006bba46e5eeasm4569299qkn.37.2022.09.10.21.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 21:06:34 -0700 (PDT)
From:   Tianling Shen <cnsztl@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Tianling Shen <cnsztl@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] arm64: dts: rockchip: add EEPROM node for NanoPi R4S
Date:   Sun, 11 Sep 2022 12:06:28 +0800
Message-Id: <20220911040628.13774-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NanoPi R4S has a EEPROM attached to the 2nd I2C bus (U92), which
stores the MAC address.

FriendlyElec ship two versions of the R4S [1]: The standard as well
as the enterprise edition with only the enterprise edition including
the EEPROM chip that stores the unique MAC address.

1. https://wiki.friendlyelec.com/wiki/index.php/NanoPi_R4S#Differences_Between_R4S_Standard_Version_.26_R4S_Enterprise_Version

Changes in v4:
- Removed `mac-address` cell as it breaks the standard edition

Changes in v3:
- Added address-cells and size-cells

Changes in v2:
- Added the size of EEPROM
- Added `mac-address` cell to pass the MAC address to kernel
- Removed `read-only` property in EEPROM node

Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
index fe5b52610010..42c99573ab27 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
@@ -68,6 +68,17 @@ &emmc_phy {
 	status = "disabled";
 };
 
+&i2c2 {
+	eeprom@51 {
+		compatible = "microchip,24c02", "atmel,24c02";
+		reg = <0x51>;
+		pagesize = <16>;
+		size = <256>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+};
+
 &i2c4 {
 	status = "disabled";
 };
-- 
2.25.1

