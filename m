Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B99718638
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbjEaPYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjEaPXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:23:47 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D0B12C;
        Wed, 31 May 2023 08:23:43 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VE6miu013343;
        Wed, 31 May 2023 15:23:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=CX8m3IafaZCWCyhKM430jhiPZ3NiZ8wGoz6WuA445Ls=;
 b=ahP3adCDIxvbrd2017YbAXhKIx2NHwUbGZHRP8CTDlW/9NLPrd86Q3pIO34JUX612k/A
 MqrPkzjGm8YPYLiZR06Mc5AehQeXPy0aBY9X6jGTbR0/snLiZKp35Suqu7oVxuRetNQ2
 nbr33kEdhO/o6rHGLFKNvx+SAhGnflqgTQFu7fAEJ/ylNSpgV2K9ydkGQGUXdd1ZOHzN
 U7IWseZ2XL+EHnDIYmUrHQQu88JL2cGqJ/taMHObpSnG6I1E1jJz2OKsugXtnY9fOB3Y
 3aMzFT6v6d9tbL0SaQpAQ7ss6i4r7/rf9clftiUQqMoSaGbdAXpgIyb4zIsYx8K66jYa 8A== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3qx4qt2euy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 15:23:25 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id D2D0A130C9;
        Wed, 31 May 2023 15:23:13 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 4D94B80BB23;
        Wed, 31 May 2023 15:23:13 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, andy.shevchenko@gmail.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [PATCH v2 3/5] dt-bindings: hwmon: hpe,gxp-fanctrl: remove fn2 and pl regs
Date:   Wed, 31 May 2023 10:19:16 -0500
Message-Id: <20230531151918.105223-4-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230531151918.105223-1-nick.hawkins@hpe.com>
References: <20230531151918.105223-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: _Y8_Z-6KBuduOcjSBagC6pmTjW5MknMG
X-Proofpoint-ORIG-GUID: _Y8_Z-6KBuduOcjSBagC6pmTjW5MknMG
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_10,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 phishscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305310131
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Remove the fn2 register and pl register references as these memory areas
are now consumed by the GXP GPIO driver. The fan driver now gathers fan
information from GPIO driver.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

---

v2:
 *Added more detailed subject and patch description
---
 .../bindings/hwmon/hpe,gxp-fan-ctrl.yaml         | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml b/Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml
index 4a52aac6be72..963aa640dc05 100644
--- a/Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml
+++ b/Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml
@@ -18,21 +18,12 @@ properties:
     const: hpe,gxp-fan-ctrl
 
   reg:
-    items:
-      - description: Fan controller PWM
-      - description: Programmable logic
-      - description: Function 2
-
-  reg-names:
-    items:
-      - const: base
-      - const: pl
-      - const: fn2
+    description: Fan controller PWM
+    maxItems: 1
 
 required:
   - compatible
   - reg
-  - reg-names
 
 additionalProperties: false
 
@@ -40,6 +31,5 @@ examples:
   - |
     fan-controller@1000c00 {
       compatible = "hpe,gxp-fan-ctrl";
-      reg = <0x1000c00 0x200>, <0xd1000000 0xff>, <0x80200000 0x100000>;
-      reg-names = "base", "pl", "fn2";
+      reg = <0x1000c00 0x200>;
     };
-- 
2.17.1

