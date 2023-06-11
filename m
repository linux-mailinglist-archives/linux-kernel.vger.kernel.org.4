Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0C372B18E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 13:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbjFKLMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 07:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbjFKLMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 07:12:19 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08631173F;
        Sun, 11 Jun 2023 04:12:16 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35BBC5gd037621;
        Sun, 11 Jun 2023 06:12:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686481925;
        bh=h+XV1rSEDhSO+vYDCv2XRzmhNFqPo8BoUj2o+HHRRbk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Di1xn3nT9DIe4XFhU93YJG9EICCWJvAQZerVQwBICnbdpNSdG3mSBkjabk8T8zOia
         yb+fevds70lbtiFEcPHD5fTuCs42zgM7TdUvl3djyPEj8QG2/Yk91uC1QutIMODY71
         ldbttPUW8saJ/i4quWgp4mGIqKwox2zywf+1v+DM=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35BBC5Ek002455
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Jun 2023 06:12:05 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 11
 Jun 2023 06:12:05 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 11 Jun 2023 06:12:05 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35BBBh13010303;
        Sun, 11 Jun 2023 06:12:02 -0500
From:   Udit Kumar <u-kumar1@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <conor+dt@kernel.org>, <m-chawdhry@ti.com>, <n-francis@ti.com>
CC:     Udit Kumar <u-kumar1@ti.com>
Subject: [v4 5/6] arm64: dts: ti: k3-j7200-common-proc-board: Define aliases at board level
Date:   Sun, 11 Jun 2023 16:41:39 +0530
Message-ID: <20230611111140.3189111-6-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230611111140.3189111-1-u-kumar1@ti.com>
References: <20230611111140.3189111-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Define aliases at board level

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index 5569d48b900c..38b48115ed0d 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -15,6 +15,16 @@ / {
 	compatible = "ti,j7200-evm", "ti,j7200";
 	model = "Texas Instruments J7200 EVM";
 
+	aliases {
+		serial0 = &wkup_uart0;
+		serial1 = &mcu_uart0;
+		serial2 = &main_uart0;
+		serial3 = &main_uart1;
+		serial5 = &main_uart3;
+		mmc0 = &main_sdhci0;
+		mmc1 = &main_sdhci1;
+	};
+
 	chosen {
 		stdout-path = "serial2:115200n8";
 	};
-- 
2.34.1

