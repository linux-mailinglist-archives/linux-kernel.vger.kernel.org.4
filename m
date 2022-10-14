Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9AB5FEBA9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 11:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiJNJ3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 05:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiJNJ3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 05:29:14 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485231C5A66;
        Fri, 14 Oct 2022 02:29:11 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29E75PjY019894;
        Fri, 14 Oct 2022 11:28:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=VxRBgimP26JpPfojcnUGD1RWSdCB/e3xLalPvah99dU=;
 b=fWW/WAYpFqeXWGSB1//gnfGAK6IvgJhhU2nVigoxlgqw6sSl206XTd2B9R4QwMVpaE+a
 F30pKSyZcZn7Z6pBT4AQxQQbO18kp4JXK177NXtFhLLZPCaeys3vHF76lG63FsTkj4j9
 +yFvLwXgqEh70axC0F8oc2mwfK5upH4SXITgPo9v2EofpB/IHmamk/3BQXtfTTJAAWS/
 r+w5lWnubsZ5ryjVtcRJt2ymslPlN/sFlEfvkHT3XEyKQjn6GpdenFicSqeR3L3BKTKo
 /72dmWSEay2LcaJGdgX8d1f887b+LbapGcCA1wtKsDObK/Pbg8gOE/6bjE5NxZGtfsL/ Rw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3k5v4n7kgt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 11:28:59 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 68026100039;
        Fri, 14 Oct 2022 11:28:55 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6198321A904;
        Fri, 14 Oct 2022 11:28:55 +0200 (CEST)
Received: from localhost (10.75.127.47) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Fri, 14 Oct
 2022 11:28:52 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <alexandre.torgue@foss.st.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <amelie.delaunay@foss.st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@foss.st.com>
Subject: [PATCH 06/10] ARM: dts: stm32: enable USB HS phys on stm32mp135f-dk
Date:   Fri, 14 Oct 2022 11:26:47 +0200
Message-ID: <20221014092651.25202-7-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221014092651.25202-1-fabrice.gasnier@foss.st.com>
References: <20221014092651.25202-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_05,2022-10-13_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amelie Delaunay <amelie.delaunay@foss.st.com>

USBPHYC manages the two USB High-Speed phys. port0 is used by USBH and
port1 is used by USBOTG.
Enable and tune both PHYs on stm32mp135f-dk.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 arch/arm/boot/dts/stm32mp135f-dk.dts | 32 ++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp135f-dk.dts b/arch/arm/boot/dts/stm32mp135f-dk.dts
index 291f05a958fd..af87fb36eabc 100644
--- a/arch/arm/boot/dts/stm32mp135f-dk.dts
+++ b/arch/arm/boot/dts/stm32mp135f-dk.dts
@@ -144,3 +144,35 @@ &uart4 {
 	pinctrl-0 = <&uart4_pins_a>;
 	status = "okay";
 };
+
+&usbphyc {
+	status = "okay";
+};
+
+&usbphyc_port0 {
+	phy-supply = <&vdd_usb>;
+	st,current-boost-microamp = <1000>;
+	st,decrease-hs-slew-rate;
+	st,tune-hs-dc-level = <2>;
+	st,enable-hs-rftime-reduction;
+	st,trim-hs-current = <11>;
+	st,trim-hs-impedance = <2>;
+	st,tune-squelch-level = <1>;
+	st,enable-hs-rx-gain-eq;
+	st,no-hs-ftime-ctrl;
+	st,no-lsfs-sc;
+};
+
+&usbphyc_port1 {
+	phy-supply = <&vdd_usb>;
+	st,current-boost-microamp = <1000>;
+	st,decrease-hs-slew-rate;
+	st,tune-hs-dc-level = <2>;
+	st,enable-hs-rftime-reduction;
+	st,trim-hs-current = <11>;
+	st,trim-hs-impedance = <2>;
+	st,tune-squelch-level = <1>;
+	st,enable-hs-rx-gain-eq;
+	st,no-hs-ftime-ctrl;
+	st,no-lsfs-sc;
+};
-- 
2.25.1

