Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDCC5FC754
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 16:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiJLOZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 10:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiJLOYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 10:24:44 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B809D73E4;
        Wed, 12 Oct 2022 07:24:33 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CAd1I5013940;
        Wed, 12 Oct 2022 16:24:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=isiHWGkB7Zp0J3xZU0OT68bWWrLfWPTeUDUFSGCGSYU=;
 b=zrq/1NEgoGc0ZzWh9haQmgGiDLmDA1is/Kd+eGlrA35MXE58xP1K20femMpdj9h0DVb6
 uwkkaoVoaWEvjLntubkf6omtwjxZbe3Tx0vQI+oFloseVN0YGT+gJEWYROIEHBah1PFN
 J5cY2mNQNfHv3MlpZSqlFynhUbpnegdkr2AHe86n6PwPguPtd/CVb5YpkilY7JnZMsDd
 ueQaNuDyfmIxhQdr/ggBeau+91Wzm1eh0oA7vhHcNCNS3g63D3H9wpJrPZcaQa4qAQGY
 wZbppJbx9rKG7gPNfNXRdLq9H+qGMMiqmEGR5Wndm1TYoIF5MR/4jroiI/cMGGLIdqN/ QQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3k31gq3kjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 16:24:15 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8C05010002A;
        Wed, 12 Oct 2022 16:24:10 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8750522FA28;
        Wed, 12 Oct 2022 16:24:10 +0200 (CEST)
Received: from localhost (10.75.127.119) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Wed, 12 Oct
 2022 16:24:10 +0200
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v4 8/8] ARM: dts: stm32: add adc support on stm32mp135f-dk
Date:   Wed, 12 Oct 2022 16:22:05 +0200
Message-ID: <20221012142205.13041-9-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221012142205.13041-1-olivier.moysan@foss.st.com>
References: <20221012142205.13041-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.119]
X-ClientProxiedBy: GPXDAG2NODE6.st.com (10.75.127.70) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_07,2022-10-12_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure ADC support on stm32mp135f-dk. ADC can be used for
USB Type-C CC1 & CC2 pins wired to in6 & in12.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 arch/arm/boot/dts/stm32mp135f-dk.dts | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp135f-dk.dts b/arch/arm/boot/dts/stm32mp135f-dk.dts
index 348adeec7fdc..967df1944822 100644
--- a/arch/arm/boot/dts/stm32mp135f-dk.dts
+++ b/arch/arm/boot/dts/stm32mp135f-dk.dts
@@ -76,6 +76,31 @@ vdd_adc: vdd-adc {
 	};
 };
 
+&adc_1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&adc1_usb_cc_pins_a>;
+	vdda-supply = <&vdd_adc>;
+	vref-supply = <&vdd_adc>;
+	status = "okay";
+	adc1: adc@0 {
+		status = "okay";
+		/*
+		 * Type-C USB_PWR_CC1 & USB_PWR_CC2 on in6 & in12.
+		 * Use at least 5 * RC time, e.g. 5 * (Rp + Rd) * C:
+		 * 5 * (5.1 + 47kOhms) * 5pF => 1.3us.
+		 * Use arbitrary margin here (e.g. 5us).
+		 */
+		channel@6 {
+			reg = <6>;
+			st,min-sample-time-ns = <5000>;
+		};
+		channel@12 {
+			reg = <12>;
+			st,min-sample-time-ns = <5000>;
+		};
+	};
+};
+
 &i2c1 {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&i2c1_pins_a>;
-- 
2.25.1

