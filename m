Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28049611382
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiJ1NrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiJ1Nqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:46:43 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF7F1C1157;
        Fri, 28 Oct 2022 06:45:40 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SCimPw006338;
        Fri, 28 Oct 2022 09:45:36 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3kfagcw9r0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 09:45:36 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 29SDjZX0062337
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Oct 2022 09:45:35 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 28 Oct
 2022 09:45:34 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 28 Oct 2022 09:45:34 -0400
Received: from rbolboac.ad.analog.com ([10.48.65.139])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 29SDjIQL013050;
        Fri, 28 Oct 2022 09:45:26 -0400
From:   Ramona Bolboaca <ramona.bolboaca@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ramona Bolboaca <ramona.bolboaca@analog.com>
Subject: [PATCH 1/2] dt-bindings:iio:accel: Add docs for ADXL359
Date:   Fri, 28 Oct 2022 16:44:53 +0300
Message-ID: <20221028134454.669509-2-ramona.bolboaca@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221028134454.669509-1-ramona.bolboaca@analog.com>
References: <20221028134454.669509-1-ramona.bolboaca@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: znL1yKMk2fVLAoLoDCnO3NFGJJGwRgYL
X-Proofpoint-ORIG-GUID: znL1yKMk2fVLAoLoDCnO3NFGJJGwRgYL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 mlxlogscore=999 clxscore=1011 impostorscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210280085
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update ADXL355 existing documentation with documentation
for ADXL359 dedvice.

Signed-off-by: Ramona Bolboaca <ramona.bolboaca@analog.com>
---
 .../devicetree/bindings/iio/accel/adi,adxl355.yaml        | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
index 14b487088ab4..93ad7ff6b355 100644
--- a/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
@@ -4,20 +4,22 @@
 $id: http://devicetree.org/schemas/iio/accel/adi,adxl355.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Analog Devices ADXL355 3-Axis, Low noise MEMS Accelerometer
+title: Analog Devices ADXL355 and ADXL359 3-Axis, Low noise MEMS Accelerometer
 
 maintainers:
   - Puranjay Mohan <puranjay12@gmail.com>
 
 description: |
-  Analog Devices ADXL355 3-Axis, Low noise MEMS Accelerometer that supports
-  both I2C & SPI interfaces
+  Analog Devices ADXL355 and ADXL359 3-Axis, Low noise MEMS Accelerometer that
+  supports both I2C & SPI interfaces
     https://www.analog.com/en/products/adxl355.html
+    https://www.analog.com/en/products/adxl359.html
 
 properties:
   compatible:
     enum:
       - adi,adxl355
+      - adi,adxl359
 
   reg:
     maxItems: 1
-- 
2.25.1

