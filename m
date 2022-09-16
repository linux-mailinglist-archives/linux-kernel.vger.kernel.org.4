Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0CF5BAF07
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiIPOMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiIPOMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:12:05 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8413BB08A0;
        Fri, 16 Sep 2022 07:12:04 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28GDngPu007244;
        Fri, 16 Sep 2022 10:12:02 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jm8x66dfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 10:12:01 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 28GEC0Q0056055
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Sep 2022 10:12:00 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 16 Sep
 2022 10:11:59 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 16 Sep 2022 10:11:59 -0400
Received: from debian.ad.analog.com ([10.48.65.127])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 28GEBfsl020264;
        Fri, 16 Sep 2022 10:11:50 -0400
From:   Ciprian Regus <ciprian.regus@analog.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ciprian Regus <ciprian.regus@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/5] dt-bindings: iio: adc: Add docs for LTC2499
Date:   Fri, 16 Sep 2022 17:09:19 +0300
Message-ID: <20220916140922.2506248-3-ciprian.regus@analog.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220916140922.2506248-1-ciprian.regus@analog.com>
References: <20220916140922.2506248-1-ciprian.regus@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Xi395CL0LURswvEIkMf68MDlavg8uNlD
X-Proofpoint-GUID: Xi395CL0LURswvEIkMf68MDlavg8uNlD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-16_08,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1011 malwarescore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209160105
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the bindings documentation for ltc2497 to include the ltc2499.

Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 changes in V3:
  - moved the MAINTAINERS entry in another patch.
 .../devicetree/bindings/iio/adc/lltc,ltc2497.yaml         | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
index c1772b568cd1..875f394576c2 100644
--- a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
@@ -13,10 +13,14 @@ description: |
   16bit ADC supporting up to 16 single ended or 8 differential inputs.
   I2C interface.
 
+  https://www.analog.com/media/en/technical-documentation/data-sheets/2497fb.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/2499fe.pdf
+
 properties:
   compatible:
-    const:
-      lltc,ltc2497
+    enum:
+      - lltc,ltc2497
+      - lltc,ltc2499
 
   reg: true
   vref-supply: true
-- 
2.30.2

