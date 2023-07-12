Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD9974FD30
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 04:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjGLClg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 22:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbjGLCle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 22:41:34 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835AF1736;
        Tue, 11 Jul 2023 19:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689129688; x=1720665688;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tznlbG5AbiqSiozof5lGgLyoGSA7MZxGGsabeR0FxYA=;
  b=OsgHNwXDNO6EHQbJRYRZ2abR3+LEZO2p6TrCdtI3eba7i1XlpXn7T6TW
   +gpTfm5vlDeULKB2wL/yDQVBvcRV/HyevEsNuCIe4a0BBoNLpXRaWKvOU
   eHzfisStVYJqm7Lt9w+9B6Sb4NT6Y+wQ+wdaNzeFUiop7PsjqmTsHHJlz
   20G0tc0c6GPUmc/Jd15sBXdTFTve4HLyNtLi8VeVjlPdU6lJZ8QrX8eE/
   tgKcImAa6emOFTeizmBuVzj/kEcqkR+vCGu2dXhgccqaM6s333hpJ6A0c
   9Q/iU9255p45spFPEluLzYjmbawMBsCfJLcoaLnITNM9UoFbkznqO4X24
   A==;
X-IronPort-AV: E=Sophos;i="6.01,198,1684825200"; 
   d="scan'208";a="224240971"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2023 19:41:27 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 11 Jul 2023 19:40:52 -0700
Received: from che-lt-i67131.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 11 Jul 2023 19:40:43 -0700
From:   Manikandan Muralidharan <manikandan.m@microchip.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <sam@ravnborg.org>,
        <bbrezillon@kernel.org>, <airlied@gmail.com>, <daniel@ffwll.ch>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
CC:     <Hari.PrasathGE@microchip.com>,
        <Balamanikandan.Gunasundar@microchip.com>,
        <Durai.ManickamKR@microchip.com>, <Nayabbasha.Sayed@microchip.com>,
        <Dharma.B@microchip.com>, <Varshini.Rajendran@microchip.com>,
        <Balakrishnan.S@microchip.com>,
        Manikandan Muralidharan <manikandan.m@microchip.com>
Subject: [PATCH v2 1/9] dt-bindings: mfd: Add bindings for SAM9X75 LCD controller
Date:   Wed, 12 Jul 2023 08:10:09 +0530
Message-ID: <20230712024017.218921-2-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230712024017.218921-1-manikandan.m@microchip.com>
References: <20230712024017.218921-1-manikandan.m@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new compatible string for the XLCD controller on sam9x75 variant
of the SAM9X7 SoC family.
The XLCD controller in sam9x75 variant supports interfacing with
LVDS and MIPI-DSI and parallel port RGB.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt b/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
index 5f8880cc757e..7de696eefaed 100644
--- a/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
+++ b/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
@@ -8,6 +8,7 @@ Required properties:
    "atmel,sama5d3-hlcdc"
    "atmel,sama5d4-hlcdc"
    "microchip,sam9x60-hlcdc"
+   "microchip,sam9x75-xlcdc"
  - reg: base address and size of the HLCDC device registers.
  - clock-names: the name of the 3 clocks requested by the HLCDC device.
    Should contain "periph_clk", "sys_clk" and "slow_clk".
-- 
2.25.1

