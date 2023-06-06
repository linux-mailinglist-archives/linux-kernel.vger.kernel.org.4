Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226247234C9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 03:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbjFFBrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 21:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbjFFBrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 21:47:11 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9045B183;
        Mon,  5 Jun 2023 18:46:53 -0700 (PDT)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 355Mg313000677;
        Tue, 6 Jun 2023 01:46:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=rHoljbO33cFER8FhWsNFfr7tEtzMu+wbXLMn0fVj+KM=;
 b=MzwICaCrNhl7VpMOcfS6b9MYi5ahPYVpzlA/4qVIfkB/pJ9jq97ylvcW8RHIXwWp0ww/
 3TmSimg4+MLrqokAYP+7MZ+WWBjRQWnK4Ji3t0Mo2HN807y6eIqDZ0I95iEviPr+Y9Qv
 VD8dG5KYNKIXv91HyvtU6rkM4qv/A7VVl9gvzl3PDt3UdqVku6mzd3NTLwS7hSb3K4c6
 xoT+1BkxjLGMDl6Jv5eAecNRo/AgisfFdV6EIiMjDgq/GBd3aZHJRSuzpdPL49mRinE+
 F+YN9JS7XJkLd97+snRJima1aeP86CdKFCXErd5TyJYtogcWmc1FIR6XH+00P+iSk6Wq xw== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3r18ay0tgv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 01:46:33 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 7524B80018D;
        Tue,  6 Jun 2023 01:46:32 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id C3EC180A565;
        Tue,  6 Jun 2023 01:46:31 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jdelvare@suse.com,
        linux@roeck-us.net, andy.shevchenko@gmail.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: [PATCH v3 3/5] dt-bindings: hwmon: hpe,gxp-fan-ctrl: remove fn2 and pl registers
Date:   Mon,  5 Jun 2023 20:42:32 -0500
Message-Id: <20230606014234.29491-4-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230606014234.29491-1-nick.hawkins@hpe.com>
References: <20230606014234.29491-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: xoxprL_jLYW4E3RUtDAWWoh7rWVFBm7E
X-Proofpoint-ORIG-GUID: xoxprL_jLYW4E3RUtDAWWoh7rWVFBm7E
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-05_35,2023-06-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306060014
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

Reduce the hpe,gxp-fan-ctrl register references from 3 to 1. The
function2 (fn2) and programmable logic (pl) references are removed.
The purpose of removal being their functionality will be consumed by a
new GPIO driver.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

---

v3:
 *Modify the subject.
 *Remove mention of fan driver receiving data from GPIO as it is no
  longer applicable
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

