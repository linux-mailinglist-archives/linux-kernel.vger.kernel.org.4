Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1999561A139
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 20:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiKDTjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 15:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiKDTip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 15:38:45 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C56F55;
        Fri,  4 Nov 2022 12:38:43 -0700 (PDT)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4HCuvm007567;
        Fri, 4 Nov 2022 19:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=6geuEyB7ckkbgQkSjct01gPVjmifmj4oh4boE7RZ7n8=;
 b=n14p2WQU1LFNYcXZcoAKvkRx0sJSgIBpX2nvuEv1m7DDxH7jxAtb+P3kPp7JTCATMdDx
 4xK4KTYyqveSQN9eFx3s7lbdGtiRKL2Y+jYDMXEiDk4DkszWIRZpk6zx0uKUYOakDoyn
 M94taZHOISwzMEmcQZDbm3NPqeVezfRfMC159UvmmV0PteHATy6M8EUv75VW7n1w/4Pl
 YbNu7Ju45wQM/pC8VxyC6Qku93+9mqXhlXuEvxxDUIoflPHGQo+ztoLzOM//Ug/VtQkH
 JDkE2PH4k/J8oFzBD/LhhHFT+OE6umPmCkYQ8nN0C1KQqBMjJ/KMd1qGCRYE9VQeecEN uQ== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3kn6xh0xh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 19:38:13 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id AAEEDD291;
        Fri,  4 Nov 2022 19:38:12 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 1FF868089A9;
        Fri,  4 Nov 2022 19:38:12 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com,
        nick.hawkins@hpe.com, corbet@lwn.net, linux@armlinux.org.uk,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 6/6] MAINTAINERS: add gxp fan controller and documents
Date:   Fri,  4 Nov 2022 14:36:57 -0500
Message-Id: <20221104193657.105130-7-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221104193657.105130-1-nick.hawkins@hpe.com>
References: <20221104193657.105130-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: HcoKe45zvOjU0ZZBb789QNBNO_sqws-d
X-Proofpoint-ORIG-GUID: HcoKe45zvOjU0ZZBb789QNBNO_sqws-d
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_11,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211040122
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Add the gxp-fan-ctrl.c and gxp-fan-ctrl.rst in hwmon
driver/documentation.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 56ff555ed5a4..53f7e4ae8dc8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2177,6 +2177,7 @@ ARM/HPE GXP ARCHITECTURE
 M:	Jean-Marie Verdun <verdun@hpe.com>
 M:	Nick Hawkins <nick.hawkins@hpe.com>
 S:	Maintained
+F:	Documentation/hwmon/gxp-fan-ctrl.rst
 F:	Documentation/devicetree/bindings/arm/hpe,gxp.yaml
 F:	Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml
 F:	Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
@@ -2184,6 +2185,7 @@ F:	arch/arm/boot/dts/hpe-bmc*
 F:	arch/arm/boot/dts/hpe-gxp*
 F:	arch/arm/mach-hpe/
 F:	drivers/clocksource/timer-gxp.c
+F:	drivers/hwmon/gxp-fan-ctrl.c
 F:	drivers/spi/spi-gxp.c
 F:	drivers/watchdog/gxp-wdt.c
 
-- 
2.17.1

