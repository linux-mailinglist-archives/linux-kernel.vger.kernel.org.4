Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC76B66704A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236560AbjALKzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbjALKyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:54:38 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C538B5D888;
        Thu, 12 Jan 2023 02:45:53 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30C7gqbY019146;
        Thu, 12 Jan 2023 11:45:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=J6sCbJAvaWM5HGxKl15fUTUZyL6LThGNw8XtSWWX/qY=;
 b=UoiF4PmJp75VdY69hHUQdV9Apgnv0BIoSjpHOkzG69+3UqtGdzUK9ep1Mk93NL0JWUbk
 I/g4c6pWw7wJxpM+8nGRicj5pYZ6df6DUSxqpF4+r4tYk9BKNzgHyXj0FVz8/SQQn7ae
 rY4kQZEW9KeALHyuLU9joMOMFleWotGpMuRoQYAzBcqeyuHEK6BuF4vGZuxhgsyZ85rs
 ScOXbG1aX9pUrlsvaWnNCp27Ea0K+qgIGMsulWJ6uT9BtZnjEQhmsWCTCUIbLAVVxF1q
 81h/rSKDrf0vEEiYh6wXcr0NMStIo84+BJjR9xH8rhOwV0otSf1MMy8xdBaX3sNFyUQs cA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3n1k5s1y2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 11:45:08 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 95DD610002A;
        Thu, 12 Jan 2023 11:45:07 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8FE2C214B11;
        Thu, 12 Jan 2023 11:45:07 +0100 (CET)
Received: from localhost (10.201.20.178) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Thu, 12 Jan
 2023 11:45:07 +0100
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Olivier Moysan <olivier.moysan@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 03/10] ARM: dts: stm32: add vrefint support to adc2 on stm32mp15
Date:   Thu, 12 Jan 2023 11:44:38 +0100
Message-ID: <20230112104446.1140551-4-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230112104446.1140551-1-olivier.moysan@foss.st.com>
References: <20230112104446.1140551-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.178]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_06,2023-01-12_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set STM32 ADC2 as a consumer of BSEC on STM32MP15, to retrieve
vrefint calibration data savec in OTP.

During the calibration process vrefp is set to 3.3V and the data
acquired is saved to the OTP. This data is used by the ADC driver
to calculated the actual value of vrefp according to the formula:
vrefp = 3.3 x vrefint_cal / vrefint_data

The vrefint channel provides the actual value of vrefp,
which can be used to correct ADC acquisition data.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 arch/arm/boot/dts/stm32mp151.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index eec5e9992bff..472fc3b94f33 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -1113,6 +1113,8 @@ adc2: adc@100 {
 				interrupts = <1>;
 				dmas = <&dmamux1 10 0x400 0x01>;
 				dma-names = "rx";
+				nvmem-cells = <&vrefint>;
+				nvmem-cell-names = "vrefint";
 				status = "disabled";
 				channel@13 {
 					reg = <13>;
-- 
2.25.1

