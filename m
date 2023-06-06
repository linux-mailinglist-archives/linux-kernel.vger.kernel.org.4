Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B45724883
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 18:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238443AbjFFQHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 12:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238130AbjFFQHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:07:00 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4F0119;
        Tue,  6 Jun 2023 09:06:58 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 356G6jY2120995;
        Tue, 6 Jun 2023 11:06:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686067605;
        bh=27c0o83wkHsIFucZ/bjfD2dLUqS+ecpJji3L0YWawls=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wQ2NNiRJTvtI1IATNxCRUL8gDKXheQh9+d/fFFqQG0ctJC5sGJQqGVgOyC/Tc91Xo
         tnmybLN5bQuvR03vCmc/ghg54NoRsppiLWsWdEUBZQHR6yp6U9HjtatktNT4Gi7BTM
         52DiJvV+xv6MHhKWaklRGTD2ZCD/Y9rj8nWNsTec=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 356G6iwM062103
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Jun 2023 11:06:44 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Jun 2023 11:06:44 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Jun 2023 11:06:44 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 356G6iNe034908;
        Tue, 6 Jun 2023 11:06:44 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jan Kiszka <jan.kiszka@siemens.com>, Andrew Davis <afd@ti.com>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 4/4] arm64: dts: ti: k3-am65-iot2050-common: Rename rtc8564 nodename
Date:   Tue, 6 Jun 2023 11:06:43 -0500
Message-ID: <20230606160643.3618390-5-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230606160643.3618390-1-nm@ti.com>
References: <20230606160643.3618390-1-nm@ti.com>
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

Just use "rtc" as the nodename to better match with the bindings.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
No change since V1
V1: https://lore.kernel.org/r/20230424144949.244135-8-nm@ti.com
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index 96ac2b476b11..679857ca95ea 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -483,7 +483,7 @@ &main_i2c0 {
 	pinctrl-0 = <&main_i2c0_pins_default>;
 	clock-frequency = <400000>;
 
-	rtc: rtc8564@51 {
+	rtc: rtc@51 {
 		compatible = "nxp,pcf8563";
 		reg = <0x51>;
 	};
-- 
2.40.0

