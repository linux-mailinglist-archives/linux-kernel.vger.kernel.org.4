Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE616E54D0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 00:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjDQWzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 18:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjDQWzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 18:55:04 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F6C2D63;
        Mon, 17 Apr 2023 15:55:03 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33HMsrbq114783;
        Mon, 17 Apr 2023 17:54:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681772093;
        bh=bmOuu49NuBWNEl3nk/4898U+cVcCbbiXk7vZ5YosqY8=;
        h=From:To:CC:Subject:Date;
        b=RNTCiy4+x4Tq4rq6zs0jXlZnktfvHt3Z56xyxjHLKSR2PuBce9jqx8zmKnOae2pK7
         LaqXgxQhT9khTUkjFRADqWxVuGnO7V3AD/bNci78wYvgJLa6vzefI2xaj9XYNCcXn7
         e4tpDDUeaaTG8yjN6iXPNV0A7zmpuNw+4MhGwfdw=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33HMsriS081718
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Apr 2023 17:54:53 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 17
 Apr 2023 17:54:52 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 17 Apr 2023 17:54:52 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33HMsqkZ008110;
        Mon, 17 Apr 2023 17:54:52 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH] arm64: dts: ti: k3: j721s2/j784s4: Switch to https links
Date:   Mon, 17 Apr 2023 17:54:50 -0500
Message-ID: <20230417225450.1182047-1-nm@ti.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like a couple of http:// links crept in. Use https instead.

While at it, drop unicode encoded character.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

Note: I have'nt droped in a fixes tag as this is cosmetic and did'nt
make sense to go through the stable tree steps.

 arch/arm64/boot/dts/ti/k3-j721s2.dtsi | 2 +-
 arch/arm64/boot/dts/ti/k3-j784s4.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2.dtsi
index 376924726f1f..d11c213420be 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2.dtsi
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for J721S2 SoC Family
  *
- * TRM (SPRUJ28 – NOVEMBER 2021) : http://www.ti.com/lit/pdf/spruj28
+ * TRM (SPRUJ28 NOVEMBER 2021): https://www.ti.com/lit/pdf/spruj28
  *
  * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
  *
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
index 2e03d84da7d2..c598d28cc7dd 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for J784S4 SoC Family
  *
- * TRM (SPRUJ43 JULY 2022) : http://www.ti.com/lit/zip/spruj52
+ * TRM (SPRUJ43 JULY 2022): https://www.ti.com/lit/zip/spruj52
  *
  * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
  *
-- 
2.40.0

