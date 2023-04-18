Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DEA6E684C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjDRPck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjDRPc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:32:28 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5C712C90;
        Tue, 18 Apr 2023 08:32:16 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IBHbbV014211;
        Tue, 18 Apr 2023 15:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=+Tejv8VqfudpGt9W4Zi1SowtUWszSWWmt+t1g0HSDDk=;
 b=HReQMNJZ+tU+u+E3hwXaBLnm32mvTf9rfZ/hcsqq2brr4dreuLJk6WdLKgUKUHq2PJIC
 InS2vytZ6xJ4yEwbvZFhpc+YbsYnXprsTwo1IuQWtmBEWpmR5LOGzI/Zcv1cIAEuILUZ
 zVqm1O3bxbT4h8PgRH6hcQv0X/zWdYDOn/iUr9CTpvxUJqYoZZffgB1sODVhTAauGU/N
 XWlNZ1Q1DPz3EWRyMinmyvStsji66G650NXcAXyHaWfund9N5hgb3czesl8bAKKLRQfw
 LWLOgHf/ff0tZRDgoKRWNB1t5q4BJbq65R8LUJfBfeCnfVzHR6FZp95rIO3Tr3EfMmg9 Fw== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3q1t6pj41c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 15:31:38 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id E06E6132CB;
        Tue, 18 Apr 2023 15:31:37 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 2640C8175C0;
        Tue, 18 Apr 2023 15:31:37 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, linux@armlinux.org.uk,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 4/9] dt-bindings: hwmon: Modify hpe,gxp-fan-ctrl
Date:   Tue, 18 Apr 2023 10:28:19 -0500
Message-Id: <20230418152824.110823-5-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230418152824.110823-1-nick.hawkins@hpe.com>
References: <20230418152824.110823-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: jwIB54FRM9lWowhdNps47Qo1GzTVKuRO
X-Proofpoint-ORIG-GUID: jwIB54FRM9lWowhdNps47Qo1GzTVKuRO
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

Remove the fn2 register reference as GPIO will
be using it.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 .../devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml         | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml b/Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml
index 4a52aac6be72..ee70f06787f6 100644
--- a/Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml
+++ b/Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml
@@ -21,13 +21,11 @@ properties:
     items:
       - description: Fan controller PWM
       - description: Programmable logic
-      - description: Function 2
 
   reg-names:
     items:
       - const: base
       - const: pl
-      - const: fn2
 
 required:
   - compatible
@@ -40,6 +38,6 @@ examples:
   - |
     fan-controller@1000c00 {
       compatible = "hpe,gxp-fan-ctrl";
-      reg = <0x1000c00 0x200>, <0xd1000000 0xff>, <0x80200000 0x100000>;
-      reg-names = "base", "pl", "fn2";
+      reg = <0x1000c00 0x200>, <0xd1000000 0xff>;
+      reg-names = "base", "pl";
     };
-- 
2.17.1

