Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFAEA671DA2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjARNYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjARNXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:23:46 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCD23C3F;
        Wed, 18 Jan 2023 04:50:21 -0800 (PST)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30IBB4qd002543;
        Wed, 18 Jan 2023 13:49:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=linwnaEWaqbZU3PC233U2YpghYMe3CfWgXBH/zbTiZ0=;
 b=vmy13VNT9+DV5uroxs7W4WKUMH1wWVokOnVCYL8E/8zGRvjXbKir7vOQfHU3TMPNbH+o
 /kBFL6gkxIUfjqjlte+xCIQI/Itf5dtDqlHgxSh/K43fn2oW/ql4aQNNH/yJllgKS8Ij
 BKEHLEX6r+Hy5HUpMgCcOunhwcjN/ppsBSxngM42591+I4VlnUkr4HJI4kpMepQ4vQzQ
 xOsvBwbBCnCXVFIEfyz2i720HjivUFt58HQWwXwpNkacc9Go07O//o7dMgOidsYKGGcZ
 Lzrf5LjergcDiG1YznxNw/ki+ZZGeTxvoa1Luw1KXEM/gONUhcZJ6Ns63e6kVBmuS+Au 3A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3n5mc4sxux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Jan 2023 13:49:57 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 74DE110002A;
        Wed, 18 Jan 2023 13:49:55 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4BB9A21684A;
        Wed, 18 Jan 2023 13:49:55 +0100 (CET)
Received: from localhost (10.48.0.157) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Wed, 18 Jan
 2023 13:49:54 +0100
From:   Patrick Delaunay <patrick.delaunay@foss.st.com>
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Patrick Delaunay <patrick.delaunay@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH] ARM: dts: stm32: Update part number NVMEM description on stm32mp131
Date:   Wed, 18 Jan 2023 13:49:51 +0100
Message-ID: <20230118134948.1.Ica923e4a2407c976dcf3d65c266c27c883734dd8@changeid>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.0.157]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The STM32MP13x Device Part Number (also named RPN in reference manual)
only uses the first 12 bits in OTP4, all the other bit are reserved and
they can be different of zero; they must be masked in NVMEM result, so
the number of bits must be defined in the nvmem cell description.

Fixes: 1da8779c0029 ("ARM: dts: stm32: add STM32MP13 SoCs support")
Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

 arch/arm/boot/dts/stm32mp131.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/stm32mp131.dtsi
index f50051e81ee3..2f186a0ae92e 100644
--- a/arch/arm/boot/dts/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/stm32mp131.dtsi
@@ -1233,6 +1233,7 @@ bsec: efuse@5c005000 {
 
 			part_number_otp: part_number_otp@4 {
 				reg = <0x4 0x2>;
+				bits = <0 12>;
 			};
 			ts_cal1: calib@5c {
 				reg = <0x5c 0x2>;
-- 
2.25.1

