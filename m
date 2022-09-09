Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564625B2F9B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiIIHRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiIIHRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:17:33 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282B5B69E4;
        Fri,  9 Sep 2022 00:17:23 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2894noV3031368;
        Fri, 9 Sep 2022 03:17:05 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jf8yc1jcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 03:17:05 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 2897H4le060283
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Sep 2022 03:17:04 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 9 Sep 2022
 03:17:03 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 9 Sep 2022 03:17:03 -0400
Received: from ibrahim-vm.ad.analog.com ([10.158.19.28])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 2897GXRk028680;
        Fri, 9 Sep 2022 03:16:53 -0400
From:   Ibrahim Tilki <Ibrahim.Tilki@analog.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>
CC:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        <linux-hwmon@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 4/4] MAINTAINERS: Add maintainer for hwmon/max31760
Date:   Fri, 9 Sep 2022 10:16:18 +0300
Message-ID: <20220909071618.231246-5-Ibrahim.Tilki@analog.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220909071618.231246-1-Ibrahim.Tilki@analog.com>
References: <20220909071618.231246-1-Ibrahim.Tilki@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: F2wQdz9nagJMnI0irBQgUR4WhJtK8PzJ
X-Proofpoint-ORIG-GUID: F2wQdz9nagJMnI0irBQgUR4WhJtK8PzJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_03,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=698
 lowpriorityscore=0 mlxscore=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209090024
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainer for hwmon/max31760 driver

Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d30f26e07..76c7d6606 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1334,6 +1334,15 @@ F:	drivers/iio/amplifiers/hmc425a.c
 F:	drivers/staging/iio/*/ad*
 X:	drivers/iio/*/adjd*
 
+ANALOG DEVICES INC MAX31760 DRIVER
+M:	Ibrahim Tilki <Ibrahim.Tilki@analog.com>
+S:	Maintained
+W:	http://wiki.analog.com/
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/hwmon/adi,max31760.yaml
+F:	Documentation/hwmon/max31760.rst
+F:	drivers/hwmon/max31760.c
+
 ANALOGBITS PLL LIBRARIES
 M:	Paul Walmsley <paul.walmsley@sifive.com>
 S:	Supported
-- 
2.36.1

