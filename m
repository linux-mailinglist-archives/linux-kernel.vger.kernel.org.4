Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470BA5BB2FE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 21:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiIPTpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 15:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiIPTpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 15:45:53 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFDFAE224;
        Fri, 16 Sep 2022 12:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663357551; x=1694893551;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lMng9lxVFZajrqtvs0LNq4NoNTqYcVaV72Uah0GvGrA=;
  b=DweHb8SVeUUCMAzjzTmmP7r/a0hLJAm36Yy5Xq/vGUXVhusGh/2A4fZ0
   zr1pVwqlX+54dhsguwuf8iVL/Es9gDuvqxF0r6LSa9pZvjXBGvfzPnNwc
   BI/ZKDEn8Uql3oX7056jW+ONXV0U51qc9HKsPRibCOjuvsWsbPhQqinCB
   ZM9Xy1kYtXvWEjLXjwzg14XEcBKC2D+sRbqzwN9aWHBEye2MJ5CviZqj6
   ir+YXlBHueZDQ6XHY6C/wRKu0PsXZiAT0GHIeSj5vISRt62yaannmTnIF
   vWtiUtuyf4YlX1fF/CrW/oMUXjo351Fa4JCALLc2Ei/FkEbTL2guIouK9
   A==;
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="177568901"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Sep 2022 12:45:50 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 16 Sep 2022 12:45:46 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Fri, 16 Sep 2022 12:45:44 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <claudiu.beznea@microchip.com>, <nicolas.ferre@microchip.com>,
        <UNGLinuxDriver@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH] ARM: dts: lan966x: Add otp support
Date:   Fri, 16 Sep 2022 21:49:46 +0200
Message-ID: <20220916194946.2869510-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add OTP (one time programmable) support.
The both lan966x SocS (lan9662 and lan9668) have the same OTP IP.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 arch/arm/boot/dts/lan966x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/lan966x.dtsi b/arch/arm/boot/dts/lan966x.dtsi
index 23665a0429906..784caba369485 100644
--- a/arch/arm/boot/dts/lan966x.dtsi
+++ b/arch/arm/boot/dts/lan966x.dtsi
@@ -163,6 +163,11 @@ port7: port@7 {
 			};
 		};
 
+		otp: otp@e0021000 {
+			compatible = "microchip,lan9668-otpc", "microchip,lan9662-otpc";
+			reg = <0xe0021000 0x300>;
+		};
+
 		flx0: flexcom@e0040000 {
 			compatible = "atmel,sama5d2-flexcom";
 			reg = <0xe0040000 0x100>;
-- 
2.33.0

