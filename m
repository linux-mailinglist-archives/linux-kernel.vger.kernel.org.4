Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFA07391AF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 23:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjFUVgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 17:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjFUVfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 17:35:53 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E031996;
        Wed, 21 Jun 2023 14:35:50 -0700 (PDT)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35LKWEKR005742;
        Wed, 21 Jun 2023 21:35:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=KbLxX+O63lrcD6heRVHuxzRyXrSY2WIVIOJqjf0/100=;
 b=o2PX9q280LddqUvdRcmw3vEXlPzwylQYvTAw9aE8dmM8HZVjxeYpurhaFO5Yfigf3kAY
 JgXq+Ss2uoBCrwjvS4+x64ilAgvct3KELlN/I72fYl+sBFEuf62yapY/LKZ+fIlSmgc6
 ALshQQgoDXbxxPTaqfXMYuoEuPJ1vj/V1zAd5ff+CIscZI/TaBeu44/St9p/1LznkIDx
 uFZ85r/ZEJBjdRddTaYX7qvRrBpIXtSla82Nk1fFZ8WcDddNCaxnHIBqHufc9/AEQ15f
 1bgO4utTjz4Y8zIa9cFAYBKlW5idX+/MSBNoWpXI95Q9Wz3JEgBnNQpMasfPJPF8Och3 gw== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3rc024n8vt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 21:35:27 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 39266800238;
        Wed, 21 Jun 2023 21:35:26 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 9D3E780FEE1;
        Wed, 21 Jun 2023 21:35:25 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, andy.shevchenko@gmail.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [PATCH v4 5/5] MAINTAINERS: hpe: Add GPIO
Date:   Wed, 21 Jun 2023 16:31:15 -0500
Message-Id: <20230621213115.113266-6-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230621213115.113266-1-nick.hawkins@hpe.com>
References: <20230621213115.113266-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: VAFUr4qepx01bMSNcCeEeOuLIWr1Wm-l
X-Proofpoint-ORIG-GUID: VAFUr4qepx01bMSNcCeEeOuLIWr1Wm-l
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_12,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 mlxlogscore=956
 suspectscore=0 impostorscore=0 phishscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210181
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
index a3b14ec33830..6157d9466a58 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2239,6 +2239,7 @@ M:	Nick Hawkins <nick.hawkins@hpe.com>
 S:	Maintained
 F:	Documentation/hwmon/gxp-fan-ctrl.rst
 F:	Documentation/devicetree/bindings/arm/hpe,gxp.yaml
+F:	Documentation/devicetree/bindings/gpio/hpe,gxp-gpio.yaml
 F:	Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml
 F:	Documentation/devicetree/bindings/i2c/hpe,gxp-i2c.yaml
 F:	Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml
@@ -2247,6 +2248,7 @@ F:	arch/arm/boot/dts/hpe-bmc*
 F:	arch/arm/boot/dts/hpe-gxp*
 F:	arch/arm/mach-hpe/
 F:	drivers/clocksource/timer-gxp.c
+F:	drivers/gpio/gpio-gxp.c
 F:	drivers/hwmon/gxp-fan-ctrl.c
 F:	drivers/i2c/busses/i2c-gxp.c
 F:	drivers/spi/spi-gxp.c
-- 
2.17.1

