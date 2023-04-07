Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293A36DB2CE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjDGScR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjDGScN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:32:13 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34563BDCF;
        Fri,  7 Apr 2023 11:32:11 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 337CMGfG012601;
        Fri, 7 Apr 2023 20:32:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=JOLfndtl+mN4Grspt7XxETH+EfXqJCgxlmF6LoEPr64=;
 b=QUJkbBVBc/80GLQHPDlw9MoHOck/v5Lz9zgvKd9UFwseVXW7X7xKLXlPVxx0mWKJaKeP
 my2Ve5QzR3Bb5IQSunWVkSl0ztxmLibyAAXE0zrO1I5dCMEgA1qRuUFJyldCBDeR+lpX
 oLs0d6kbpKiUYLfkLLVDDA8JjhYA03oDPzSYBoGtkPx7J1JuUrJo23ai8Zwd+fzyKZ9d
 aecX873mp2Qqb9k7XC+hJDyq3ETTrduX01lmbCFU8vdI0CWUs3vgG3X3LNktoRL8idW9
 frB20Me4FK3AyvfGx7HxDV+PJBGFkA6+FCtGL9UB3wHBq5FKwqPxAYLUHpgqsryUmpyV QA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pteygu570-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 20:32:00 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CE6DA10002A;
        Fri,  7 Apr 2023 20:31:59 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C791225223F;
        Fri,  7 Apr 2023 20:31:59 +0200 (CEST)
Received: from localhost (10.48.0.157) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 7 Apr
 2023 20:31:59 +0200
From:   Patrick Delaunay <patrick.delaunay@foss.st.com>
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     Patrick Delaunay <patrick.delaunay@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] ARM: dts: stm32: add part number for STM32MP15x
Date:   Fri, 7 Apr 2023 20:31:57 +0200
Message-ID: <20230407203151.1.Ia16c922b77242e5832106fedc76d27f7ed4dd952@changeid>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.0.157]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_12,2023-04-06_03,2023-02-09_01
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The STM32MP15x Device Part Number is located in the first 8 bits of OTP4,
this patch add its description as the NVMEM cell.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

 arch/arm/boot/dts/stm32mp151.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index 4e437d3f2ed6..3cf78f706400 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -1620,6 +1620,9 @@ bsec: efuse@5c005000 {
 			reg = <0x5c005000 0x400>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+			part_number_otp: part-number-otp@4 {
+				reg = <0x4 0x1>;
+			};
 			ts_cal1: calib@5c {
 				reg = <0x5c 0x2>;
 			};
-- 
2.25.1

