Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC0670969D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 13:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjESLeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 07:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjESLer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 07:34:47 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FD71B0;
        Fri, 19 May 2023 04:34:46 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34JBYe3c013686;
        Fri, 19 May 2023 06:34:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684496080;
        bh=0zvvZEHkm43gIFcoIqh9+DsFglNnTVurBewGEC2HdI4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GhFzmuX64mFcqBmAyEyXCcg1JIhKXyS7vWHKxr7Z02CW2Gpza8WAuSOHuermPqNq8
         OkM3YnmhqWGCt8ou1sBkD3BeHsWxjpS+hrjys87GcHuFn07doLNc9G9Zg7AzIMTimZ
         67BeoWzg6NSrdC3kZtFXFXPx55vx3Kd0FSXy+q6c=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34JBYeXv025024
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 May 2023 06:34:40 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 19
 May 2023 06:34:40 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 19 May 2023 06:34:40 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34JBYd4U032941;
        Fri, 19 May 2023 06:34:39 -0500
From:   Nitin Yadav <n-yadav@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] arm64: dts: ti: k3-am62-main: add sa3_secproxy in cbass_main
Date:   Fri, 19 May 2023 17:04:34 +0530
Message-ID: <20230519113434.1024206-3-n-yadav@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519113434.1024206-1-n-yadav@ti.com>
References: <20230519113434.1024206-1-n-yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add sa3_secproxy node in k3-am62-main.dtsi to keep device tree
nodes in sync with u-boot nodes.

Signed-off-by: Nitin Yadav <n-yadav@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index b3e4857bbbe4..7c2af5b0e022 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -42,6 +42,15 @@ gic_its: msi-controller@1820000 {
 		};
 	};
 
+	sa3_secproxy: secproxy@44880000 {
+		compatible = "ti,am654-secure-proxy";
+		#mbox-cells = <1>;
+		reg-names = "rt", "scfg", "target_data";
+		reg = <0x00 0x44880000 0x00 0x20000>,
+		      <0x0 0x44860000 0x0 0x20000>,
+		      <0x0 0x43600000 0x0 0x10000>;
+	};
+
 	main_conf: syscon@100000 {
 		compatible = "syscon", "simple-mfd";
 		reg = <0x00 0x00100000 0x00 0x20000>;
-- 
2.25.1

