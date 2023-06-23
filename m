Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E75773B99C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjFWOOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjFWON5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:13:57 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB492956;
        Fri, 23 Jun 2023 07:13:41 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35ND3Ss3032052;
        Fri, 23 Jun 2023 16:13:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=n7CnWGQap5G34zSVoJPQnyZJhA8mpXd2NmvWCwOewAw=;
 b=XtZ1w1ERDw5a3hKxJ6p8KQ0X9vB4G+cNJoItjibOB/BCZwEPFxr6TQXOTUmpsQ+svapw
 AWhB7meZjZTrzpc9zozV0ViwUAd9rn1gdCJCs5olaXmGSMdob2w2mQ9j0+nS01pAyqLY
 cIxppKbSneGlJ8NQz8nO0UEMi3yfkYgsxf39Ui7tzuQDc2AoyZn6mH8WMi32WtCt75Bq
 4z8TwRxTDl8fXbIBNmssdHDllVOM4877qOXjfSqxVV6OgatmmfT57ZycsMrYNxnWK57n
 lOK3ozRZf8wTvkODFQ81jGpUyDawj2ijDRtC3b4kOzkMqPt4a8UsLJlt6g0d7PiU89jI eA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rd6mab0tg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 16:13:32 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0917310002A;
        Fri, 23 Jun 2023 16:13:32 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 012E322D170;
        Fri, 23 Jun 2023 16:13:32 +0200 (CEST)
Received: from localhost (10.252.5.198) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 23 Jun
 2023 16:13:31 +0200
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Olivier Moysan <olivier.moysan@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 7/7] ARM: dts: stm32: add dfsdm iio suppport
Date:   Fri, 23 Jun 2023 16:09:43 +0200
Message-ID: <20230623140944.2613002-8-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230623140944.2613002-1-olivier.moysan@foss.st.com>
References: <20230623140944.2613002-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.5.198]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_08,2023-06-22_02,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This DT is an example of backend iio device use for STM32 DFSDM.
DFSDM filter0 has a single input channel, while filter1 is configured
for scan mode with two input channels.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 arch/arm/boot/dts/stm32mp157c-ev1.dts | 62 +++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
index ba8e9d9a42fa..ebd67a219df2 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
@@ -73,6 +73,24 @@ panel_backlight: panel-backlight {
 		default-on;
 		status = "okay";
 	};
+
+	sd_adc0: simple-sd-adc0 {
+		compatible = "sd-modulator";
+		io-backend-cells = <0>;
+		vref-supply = <&v3v3>;
+	};
+
+	sd_adc1: simple-sd-adc1 {
+		compatible = "sd-modulator";
+		io-backend-cells = <0>;
+		vref-supply = <&v3v3>;
+	};
+
+	sd_adc2: simple-sd-adc2 {
+		compatible = "sd-modulator";
+		io-backend-cells = <0>;
+		vref-supply = <&v3v3>;
+	};
 };
 
 &cec {
@@ -99,6 +117,50 @@ dcmi_0: endpoint {
 	};
 };
 
+&dfsdm {
+	spi-max-frequency = <2048000>;
+
+	clocks = <&rcc DFSDM_K>, <&rcc ADFSDM_K>;
+	clock-names = "dfsdm", "audio";
+	status = "disabled";
+
+	dfsdm0: filter@0 {
+		compatible = "st,stm32-dfsdm-adc";
+		st,filter-order = <3>;
+		status = "okay";
+
+		channel@1 {
+			reg = <1>;
+			label = "in1";
+			st,adc-channel-types = "SPI_R";
+			st,adc-channel-clk-src = "CLKOUT";
+			io-backend = <&sd_adc0>;
+		};
+	};
+
+	dfsdm1: filter@1 {
+		compatible = "st,stm32-dfsdm-adc";
+		st,filter-order = <3>;
+		status = "okay";
+
+		channel@2 {
+			reg = <2>;
+			label = "in2";
+			st,adc-channel-types = "SPI_R";
+			st,adc-channel-clk-src = "CLKOUT";
+			io-backend = <&sd_adc1>;
+		};
+
+		channel@3 {
+			reg = <3>;
+			label = "in3";
+			st,adc-channel-types = "SPI_F";
+			st,adc-channel-clk-src = "CLKOUT";
+			io-backend = <&sd_adc2>;
+		};
+	};
+};
+
 &dsi {
 	phy-dsi-supply = <&reg18>;
 	status = "okay";
-- 
2.25.1

