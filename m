Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9836170040E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 11:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240162AbjELJlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 05:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240459AbjELJlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 05:41:12 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F1D11B6F;
        Fri, 12 May 2023 02:40:40 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34C8Qr6R025593;
        Fri, 12 May 2023 11:39:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=yMVXfzGr6CyJqoITq1F7C9+yE8pmzBojhHVwsRcheFY=;
 b=jRt5jU7ZZXv2e6CcTl1PRSLk3JF9ySZOGvYsubxeOt5Us8jy8Sqyeyzo6kBwQwzX1IwP
 II2L/36TR+WJMn9SamRP3AM1dmho2VXC8Iwe6zKDRwgTemxR10PezzKsrhT/D2tzjdMQ
 wyNAx+sA1tTbqsFqR8WBJdB5fH85SbUse2McHYUoR1uTtYaVbHalSicy0L92HA6qCsFe
 RZnV3MfX0gInwltp9FK0WJspJZHzpwfUEG5FuCkfeVdKfkYYe4cAKQdmApazSg7z3iMk
 Hikhp+EpnVB7u6jOwfL3HuNU9sJI4xlLU+EtIwIFBNu9MN03oFJQYO8jR7sHywwX3sxL yw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qguwkrskq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 11:39:32 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2D273100039;
        Fri, 12 May 2023 11:39:32 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 275592248B0;
        Fri, 12 May 2023 11:39:32 +0200 (CEST)
Received: from localhost (10.201.21.213) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 12 May
 2023 11:39:31 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Subject: [PATCH v3 3/4] ARM: dts: stm32: Update reset declarations
Date:   Fri, 12 May 2023 11:39:25 +0200
Message-ID: <20230512093926.661509-4-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230512093926.661509-1-arnaud.pouliquen@foss.st.com>
References: <20230512093926.661509-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.21.213]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_06,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the introduction of the SCMI for the management
of the MCU hold boot in OP-TEE, management of the hold boot by SMC call
is deprecated.
- Clean the st,syscfg-tz  which allows to determine if the trust
zone is enable.
- Add reset-names properties to be able to differentiate the MCU reset and
  the MCU HOLD BOOT.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 arch/arm/boot/dts/stm32mp151.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index 63f4c78fcc1d..56d73d8d5cfe 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -1820,8 +1820,8 @@ m4_rproc: m4@10000000 {
 			      <0x30000000 0x40000>,
 			      <0x38000000 0x10000>;
 			resets = <&rcc MCU_R>;
+			reset-names = "mcu_rst";
 			st,syscfg-holdboot = <&rcc 0x10C 0x1>;
-			st,syscfg-tz = <&rcc 0x000 0x1>;
 			st,syscfg-pdds = <&pwr_mcu 0x0 0x1>;
 			st,syscfg-rsc-tbl = <&tamp 0x144 0xFFFFFFFF>;
 			st,syscfg-m4-state = <&tamp 0x148 0xFFFFFFFF>;
-- 
2.25.1

