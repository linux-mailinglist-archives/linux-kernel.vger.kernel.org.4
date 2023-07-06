Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4297774A685
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 00:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjGFWEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 18:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjGFWED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 18:04:03 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCC2E1;
        Thu,  6 Jul 2023 15:04:02 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366LbJE5010282;
        Thu, 6 Jul 2023 22:03:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=a/CIzDIo/LuW3H+hBwVZl8mkQyaTJLmERQTTKsdaNzM=;
 b=NLsXwy+tP5mzHWvQcW2Fz1X7H2Yyl+Yc3FCjxUAvK4tBbQ64PyjGT7E7BEqWvBOC2zd2
 hx7i+IhZjK7+LgrHiYEpZj4RQfWw0iz7Hy8kCZL/rOirHG5oqHpoMy/C+RqproNV2TwJ
 XxhGI0+Mcx8H/LYIi72sFpttq3Oz//5AYLE4n/Yjh+wcgN3c4Gw21wJurE9iQnuXdPZ4
 PTj++nOgkmFxFfKbYDr4wlaMLRg//qUSjKLqiiSJifGIdbNVxDZxxYDXtEg7eyAKlv5B
 YKMhj2Q8Rpr6+Z/6+mMXhe7hiB66V9psSPeGQtcTDV7UID7me43Mj7P/yw29LmutkdzT tw== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3rp1qp1vdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 22:03:52 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id DBC538047B0;
        Thu,  6 Jul 2023 22:03:50 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 5D05C806B42;
        Thu,  6 Jul 2023 22:03:50 +0000 (UTC)
From:   richard.yu@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, richard.yu@hpe.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] MAINTAINERS: add USB support to GXP
Date:   Thu,  6 Jul 2023 16:59:10 -0500
Message-Id: <20230706215910.78772-4-richard.yu@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230706215910.78772-1-richard.yu@hpe.com>
References: <20230706215910.78772-1-richard.yu@hpe.com>
X-Proofpoint-GUID: -R8Ev15APzs4jRt3aswHA-a2i7J7cxpF
X-Proofpoint-ORIG-GUID: -R8Ev15APzs4jRt3aswHA-a2i7J7cxpF
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_15,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=530 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 spamscore=0 mlxscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2307060193
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Yu <richard.yu@hpe.com>

Add the usb driver and dt-bindinng documents.

Signed-off-by: Richard Yu <richard.yu@hpe.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 27ef11624748..17a806469a18 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2245,6 +2245,7 @@ F:	Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml
 F:	Documentation/devicetree/bindings/i2c/hpe,gxp-i2c.yaml
 F:	Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml
 F:	Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
+F:	Documentation/devicetree/bindings/usb/hpe,gxp-udcg.yaml
 F:	Documentation/hwmon/gxp-fan-ctrl.rst
 F:	arch/arm/boot/dts/hpe-bmc*
 F:	arch/arm/boot/dts/hpe-gxp*
@@ -2253,6 +2254,7 @@ F:	drivers/clocksource/timer-gxp.c
 F:	drivers/hwmon/gxp-fan-ctrl.c
 F:	drivers/i2c/busses/i2c-gxp.c
 F:	drivers/spi/spi-gxp.c
+F:	drivers/usb/gadget/udc/gxp-udc.c
 F:	drivers/watchdog/gxp-wdt.c
 
 ARM/IGEP MACHINE SUPPORT
-- 
2.17.1

