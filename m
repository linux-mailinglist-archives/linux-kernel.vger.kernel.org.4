Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06636183CD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbiKCQIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbiKCQH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:07:57 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5442218397;
        Thu,  3 Nov 2022 09:07:54 -0700 (PDT)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3FxnBn027310;
        Thu, 3 Nov 2022 16:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=QSk1OKq1KTLOe0DWMcTX1bXrnC//dX11HNzcBpa1eCo=;
 b=X9IIsU5FDSsZs87yzj+lc86GL5vtWMjJANL0oUqxUx1QAxo26dVWUxZUGL1GXUlaFJV5
 4TzNmdj45PK88yZotqta7oVf/C/lw0laIe+R8q7G+vCmbYHVU1WGhm8z2IgLF988eafY
 +6RdTiCo4XGkP094IpYStrJ1eGp6cyK/0YHl62zxDUZEkx0mD56SdJ/Jl/S5dhzT+mUb
 yNoOrFbEJAL0Rja/SDTBP9Rp75rL/4xztosTMhXkdG58y3KOXvV64PIy35wbiCmyj4V8
 6qWAnG5IQ/3/DoytctiAhKCq/Sk5BzhOXuSnY3+jfaX/FMv56vurOGlkCYf9JeNvh7eN ZA== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kmgs5r3f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 16:07:36 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id B2ECAD263;
        Thu,  3 Nov 2022 16:07:35 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 28823803A9B;
        Thu,  3 Nov 2022 16:07:35 +0000 (UTC)
From:   richard.yu@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, richard.yu@hpe.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux@armlinux.org.uk,
        balbi@kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 5/7] ARM: dts: hpe: Add UDC nodes
Date:   Thu,  3 Nov 2022 11:06:23 -0500
Message-Id: <20221103160625.15574-6-richard.yu@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221103160625.15574-1-richard.yu@hpe.com>
References: <20221103160625.15574-1-richard.yu@hpe.com>
X-Proofpoint-GUID: E-eg5tWKBw8-X6UKYJjrMfsa-cP6M_hN
X-Proofpoint-ORIG-GUID: E-eg5tWKBw8-X6UKYJjrMfsa-cP6M_hN
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=384 spamscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030107
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Yu <richard.yu@hpe.com>

Add support for the USB drivers on HPE GXP SoC.

Signed-off-by: Richard Yu <richard.yu@hpe.com>
---
 arch/arm/boot/dts/hpe-gxp.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/hpe-gxp.dtsi b/arch/arm/boot/dts/hpe-gxp.dtsi
index cf735b3c4f35..60f2d3b15d90 100644
--- a/arch/arm/boot/dts/hpe-gxp.dtsi
+++ b/arch/arm/boot/dts/hpe-gxp.dtsi
@@ -59,6 +59,36 @@
 			ranges = <0x0 0xc0000000 0x30000000>;
 			dma-ranges;
 
+			vuhc0: vuhc@80400000 {
+				compatible = "hpe,gxp-vuhc", "syscon";
+				reg = <0x80400000 0x80>;
+			};
+
+			udc_system_controller: system-controller@80400800 {
+				compatible = "hpe,gxp-udcg", "syscon";
+				reg = <0x80400800 0x200>;
+			};
+
+			gadget0: udc@80401000 {
+				compatible = "hpe,gxp-udc";
+				reg = <0x80401000 0x1000>;
+				interrupts = <13>;
+				interrupt-parent = <&vic1>;
+				vdevnum = <0>;
+				fepnum = <7>;
+				hpe,syscon-phandle = <&udc_system_controller>;
+			};
+
+			gadget1: udc@80402000 {
+				compatible = "hpe,gxp-udc";
+				reg = <0x80402000 0x1000>;
+				interrupts = <13>;
+				interrupt-parent = <&vic1>;
+				vdevnum = <1>;
+				fepnum = <7>;
+				hpe,syscon-phandle = <&udc_system_controller>;
+			};
+
 			vic0: interrupt-controller@eff0000 {
 				compatible = "arm,pl192-vic";
 				reg = <0xeff0000 0x1000>;
-- 
2.17.1

