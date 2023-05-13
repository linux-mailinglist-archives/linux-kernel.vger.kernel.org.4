Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E6A701614
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 12:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbjEMKOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 06:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237502AbjEMKOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 06:14:04 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98CA4EC9;
        Sat, 13 May 2023 03:14:00 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34DADl8D041495;
        Sat, 13 May 2023 05:13:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683972827;
        bh=0pxgKDR9xXJVaGLLBSKo+uFW3+UqrWs3UKUezHnn7nM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=PTrxko8in0fdYKs+tJzQ3T5by//rq6IfmnwdmaEi01s+ZUmlhG6YFv6lpZTaqkWnQ
         VLlZe/u988nylYSjmEVX3+SEADFa/L464ic3BFubRgbqCeyZlYLiD8irhXI8k9x6l/
         BUAwh8+VTJSbMEL2rMJgZuRKt0l/z9UM17/PXA9U=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34DADlsH008043
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 13 May 2023 05:13:47 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 13
 May 2023 05:13:47 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 13 May 2023 05:13:47 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34DADjBx019442;
        Sat, 13 May 2023 05:13:46 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <vigneshr@ti.com>, <nm@ti.com>, <kristo@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <afd@ti.com>
CC:     <vaishnav.a@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <u-kumar1@ti.com>
Subject: [PATCH v3 1/2] arm64: dts: ti: k3-j7200-mcu-wakeup: Switch mcu_syscon to ti,j721e-system-controller
Date:   Sat, 13 May 2023 15:43:42 +0530
Message-ID: <20230513101343.785-2-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230513101343.785-1-vaishnav.a@ti.com>
References: <20230513101343.785-1-vaishnav.a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nishanth Menon <nm@ti.com>

Use ti,j721e-system-controller to be explicit about the syscon node we
are using.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---

No changes since V1.

 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index 674e695ef844..b58a31371bf3 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -35,7 +35,7 @@
 	};
 
 	mcu_conf: syscon@40f00000 {
-		compatible = "syscon", "simple-mfd";
+		compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
 		reg = <0x00 0x40f00000 0x00 0x20000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.17.1

