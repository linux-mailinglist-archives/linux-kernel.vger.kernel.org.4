Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24CE70F7E7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbjEXNlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235382AbjEXNl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:41:26 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB95194;
        Wed, 24 May 2023 06:41:03 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OCgVKL015625;
        Wed, 24 May 2023 15:40:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=iQXTMxUt9SX5FwNNn9VT0H47jLLTrjkB+qHe01i2GLc=;
 b=2X3ynNzgvp0WjjtCjo3LjAFnqc9iuEwXz85SZ3hsSY4YQeWvQHwGpR7GZ6b025gu1D2O
 MKFIRfALUYVPxHXO2g39Q9QBuDYXxyJTfiSJP7zabIAqERW+i5T6WwesgIS7SR6fAmI3
 1GaEMKSt0Dt11sitGurd/rwbmzBBF9u7WLy+O19eSKvEHHmiMKn0FUmimYkXOnKnYz+e
 ehP/jlHcOcCec3ftoT+WZl6RoflIXNgPRvb0B0aWkgKPFicmD5fhujGbd6rS9vkR5Mtz
 GLMILgZClQPe2/hgttI33a7xH0TtXOeKbdH4id3l/4efkFUD8GnKPNpJ8SVV9OvnAgrU Jg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qrthk9384-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 15:40:53 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3384610002A;
        Wed, 24 May 2023 15:40:53 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2A14B229A88;
        Wed, 24 May 2023 15:40:53 +0200 (CEST)
Received: from localhost (10.252.20.36) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 24 May
 2023 15:40:52 +0200
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
Subject: [PATCH 5/8] ARM: dts: stm32: adopt generic iio bindings for adc channels on stm32mp157c-ed1
Date:   Wed, 24 May 2023 15:39:14 +0200
Message-ID: <20230524133918.1439516-6-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230524133918.1439516-1-olivier.moysan@foss.st.com>
References: <20230524133918.1439516-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.20.36]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_09,2023-05-24_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use STM32 ADC generic bindings instead of legacy bindings on
STM32MP157c-ed1 board.

The STM32 ADC specific binding to declare channels has been deprecated,
hence adopt the generic IIO channels bindings, instead.
The STM32MP151 device tree now exposes internal channels using the
generic binding. This makes the change mandatory here to avoid a mixed
use of legacy and generic binding, which is not supported by the driver.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 arch/arm/boot/dts/stm32mp157c-ed1.dts | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts b/arch/arm/boot/dts/stm32mp157c-ed1.dts
index 8beb901be506..66ed5f9921ba 100644
--- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
@@ -103,10 +103,20 @@ &adc {
 	vref-supply = <&vdda>;
 	status = "disabled";
 	adc1: adc@0 {
-		st,adc-channels = <0 1 6>;
-		/* 16.5 ck_cycles sampling time */
-		st,min-sample-time-nsecs = <400>;
 		status = "okay";
+		channel@0 {
+			reg = <0>;
+			/* 16.5 ck_cycles sampling time */
+			st,min-sample-time-ns = <400>;
+		};
+		channel@1 {
+			reg = <1>;
+			st,min-sample-time-ns = <400>;
+		};
+		channel@6 {
+			reg = <6>;
+			st,min-sample-time-ns = <400>;
+		};
 	};
 };
 
-- 
2.25.1

