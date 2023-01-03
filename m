Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB0F65C83D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 21:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238644AbjACUjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 15:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238185AbjACUj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 15:39:29 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B61140B1;
        Tue,  3 Jan 2023 12:39:28 -0800 (PST)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303FqhaA002162;
        Tue, 3 Jan 2023 20:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=al/Ef0C92ImNI1kNBTLBBJVhL8XTRBsg0D+8TuZLa9Y=;
 b=dT31nGYLRiuzSX5BfMPcs7PA4ZlmsU/deiNXuZ2IjVfrpSx+TXl+l1/GUQwcjPFbRyIo
 lTAa/Pww0WwjWA2lIeTL/ComClQQUHQBV0e6vjOzz2MNPS8Zi8pAUJon7BNLDHriWdeh
 jZyjpD++uZJtPdssKTz5d60f4PtXhgqHWoyFTtXmoXggWo1FQ9Pzb61KuzJ64Pee5Arr
 Ohq8jf1TWWunzRRX8FNrEIkeYDZu9aUKr9tGit4GBHj4SJSgMvB1+o/Rn2X6/ziUHgmP
 zDNTqmTC69eAiJS7arWUEYOQhkpGqyhvr221unYLO8XXKdWhy01/+o/PgbRR225J4VlC Wg== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3mvga34aan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 20:38:53 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 958003019B;
        Tue,  3 Jan 2023 20:38:52 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 043AE80B777;
        Tue,  3 Jan 2023 20:38:51 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, jdelvare@suse.com,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, corbet@lwn.net,
        linux@armlinux.org.uk, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 5/5] MAINTAINERS: add gxp fan controller and documents
Date:   Tue,  3 Jan 2023 14:36:54 -0600
Message-Id: <20230103203654.59322-6-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230103203654.59322-1-nick.hawkins@hpe.com>
References: <20230103203654.59322-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: fVGRulWC9473xP_W2k6T2Rs19JCWB8oK
X-Proofpoint-ORIG-GUID: fVGRulWC9473xP_W2k6T2Rs19JCWB8oK
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_07,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301030174
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Reviewed-by: Guenter Roek <linux@roek-us.net>

---
v4:
 *No change
v3:
 *No change
v2:
 *Added missing gxp-fan-ctrl.yaml
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1daadaa4d48b..00b52be102d6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2216,13 +2216,16 @@ ARM/HPE GXP ARCHITECTURE
 M:	Jean-Marie Verdun <verdun@hpe.com>
 M:	Nick Hawkins <nick.hawkins@hpe.com>
 S:	Maintained
+F:	Documentation/hwmon/gxp-fan-ctrl.rst
 F:	Documentation/devicetree/bindings/arm/hpe,gxp.yaml
+F:	Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml
 F:	Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml
 F:	Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
 F:	arch/arm/boot/dts/hpe-bmc*
 F:	arch/arm/boot/dts/hpe-gxp*
 F:	arch/arm/mach-hpe/
 F:	drivers/clocksource/timer-gxp.c
+F:	drivers/hwmon/gxp-fan-ctrl.c
 F:	drivers/spi/spi-gxp.c
 F:	drivers/watchdog/gxp-wdt.c
 
-- 
2.17.1

