Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273EB6E683B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjDRPcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbjDRPcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:32:10 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2C3125B1;
        Tue, 18 Apr 2023 08:32:08 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IBHK90013970;
        Tue, 18 Apr 2023 15:31:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=dAIIzQaU+Kiqn9GnVIQkPXlXHdyWvMYyRuSKEZVxqpw=;
 b=eV8QatR6OZ46jcsfGDjYtnEm3WWs6/ECPhsgN9abctszN66wrieQLuMwybL+uqlUhguS
 sgZaT1R6YFi0+pb1kEYFt4TNZWSgh0fVHQxNK8tBUviIBksoX9caiS4xgyAsi6WOD12W
 nztcq9y8egggARHhODm9vj/CWxHMUNtZNw5imSiiEhE837mQXiy0r5Rdv/PyFRPne4Js
 JE1oBGUCz/ATP8qmEuv//LMevgTB9FHjgZ8UIWbOdWc04o6JxWw138m6MuDIZZukJdVI
 OJ8MIlMRiXFREPeGimH3gFmDCgdSbuXl7SDRwBu3kz9BSnW3ywAa02XtR7vt0hklzVxr zQ== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3q1t6pj428-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 15:31:42 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 8726913059;
        Tue, 18 Apr 2023 15:31:41 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 8AD4B81532D;
        Tue, 18 Apr 2023 15:31:40 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, linux@armlinux.org.uk,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 9/9] MAINTAINERS: hpe: Add GPIO, PSU
Date:   Tue, 18 Apr 2023 10:28:24 -0500
Message-Id: <20230418152824.110823-10-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230418152824.110823-1-nick.hawkins@hpe.com>
References: <20230418152824.110823-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: D-5jxxe18OTKk68YzM-A06-LVUnk68gS
X-Proofpoint-ORIG-GUID: D-5jxxe18OTKk68YzM-A06-LVUnk68gS
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_11,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304180132
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

List the files added for GPIO and PSU support.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a3b14ec33830..6df959ebf523 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2239,7 +2239,9 @@ M:	Nick Hawkins <nick.hawkins@hpe.com>
 S:	Maintained
 F:	Documentation/hwmon/gxp-fan-ctrl.rst
 F:	Documentation/devicetree/bindings/arm/hpe,gxp.yaml
+F:	Documentation/devicetree/bindings/gpio/hpe,gxp-gpio.yaml
 F:	Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml
+F:	Documentation/devicetree/bindings/hwmon/hpe,gxp-psu.yaml
 F:	Documentation/devicetree/bindings/i2c/hpe,gxp-i2c.yaml
 F:	Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml
 F:	Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
@@ -2247,7 +2249,9 @@ F:	arch/arm/boot/dts/hpe-bmc*
 F:	arch/arm/boot/dts/hpe-gxp*
 F:	arch/arm/mach-hpe/
 F:	drivers/clocksource/timer-gxp.c
+F:	drivers/gpio/gpio-gxp.c
 F:	drivers/hwmon/gxp-fan-ctrl.c
+F:	drivers/hwmon/gxp-psu.c
 F:	drivers/i2c/busses/i2c-gxp.c
 F:	drivers/spi/spi-gxp.c
 F:	drivers/watchdog/gxp-wdt.c
-- 
2.17.1

