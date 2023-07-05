Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86250748E53
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbjGETuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbjGETuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:50:16 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EC0199E;
        Wed,  5 Jul 2023 12:50:14 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365H2ApZ012208;
        Wed, 5 Jul 2023 19:49:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=5x3OxXEwu0z070b92aDOhncsAuFg1T2+MQocbqikStQ=;
 b=Zyj4W4YsyRXvjYy//+Eawjq8l+FuHJx+j96098Z1b5adgzx5b3fuceDvaZj2AGvnlTCB
 ZHPL38zGE5jI/wGogVS+95gpR5nvdIIjD9RgG0uSgvqvfzTzC1Szzix1wVTsQoyLcJFq
 gRMuGNgA3WmdhBoJ0zScShHZs7i18jwaHpgKKynu7AbQyTUFOgk1M2K9UpWOBW7qksIU
 K2sWbHGl+tFHWbO5bKeyxIvwDK7y1FB8edNe6+SDQu6VDv/yPw74GmwBv9gghnz/OedK
 HIAsayEtqJeD0639Ey2TH8NhvrQTyF7YM2L0vUsvg7wSDFn5KmyQAyzqIy8YRNtsBzqi nw== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3rn65h49yh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 19:49:48 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 9A5458014CC;
        Wed,  5 Jul 2023 19:49:46 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id F34B9808DBD;
        Wed,  5 Jul 2023 19:49:45 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, andy.shevchenko@gmail.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [PATCH v5 5/5] MAINTAINERS: hpe: Add GPIO
Date:   Wed,  5 Jul 2023 14:45:44 -0500
Message-Id: <20230705194544.100370-6-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230705194544.100370-1-nick.hawkins@hpe.com>
References: <20230705194544.100370-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: SvNEoVgX5QQsL72i0ZSYxikjGwIw1es_
X-Proofpoint-ORIG-GUID: SvNEoVgX5QQsL72i0ZSYxikjGwIw1es_
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_11,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307050180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

List the files added for GPIO.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

---

v5:
 *Remove gpio-gxp.c reference as it has been discarded for separate
  commit
 *Added missing gpio-gxp-pl.c reference
v4:
 *No change
v3:
 *No change
v2:
 *Removed reference to PSU changes as they have been discarded.
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 27ef11624748..559d4ecb65e9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2241,6 +2241,7 @@ M:	Jean-Marie Verdun <verdun@hpe.com>
 M:	Nick Hawkins <nick.hawkins@hpe.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/hpe,gxp.yaml
+F:	Documentation/devicetree/bindings/gpio/hpe,gxp-gpio.yaml
 F:	Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml
 F:	Documentation/devicetree/bindings/i2c/hpe,gxp-i2c.yaml
 F:	Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml
@@ -2250,6 +2251,7 @@ F:	arch/arm/boot/dts/hpe-bmc*
 F:	arch/arm/boot/dts/hpe-gxp*
 F:	arch/arm/mach-hpe/
 F:	drivers/clocksource/timer-gxp.c
+F:	drivers/gpio/gpio-gxp-pl.c
 F:	drivers/hwmon/gxp-fan-ctrl.c
 F:	drivers/i2c/busses/i2c-gxp.c
 F:	drivers/spi/spi-gxp.c
-- 
2.17.1

