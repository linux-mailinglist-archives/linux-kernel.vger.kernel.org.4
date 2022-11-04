Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35393619379
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 10:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbiKDJ3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 05:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbiKDJ2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 05:28:53 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5572326578;
        Fri,  4 Nov 2022 02:28:52 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A48TPiS031522;
        Fri, 4 Nov 2022 05:28:49 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3kmpqjbb5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 05:28:49 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 2A49SmTk062039
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Nov 2022 05:28:48 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 4 Nov 2022
 05:28:47 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 4 Nov 2022 05:28:47 -0400
Received: from amiclaus-VirtualBox.ad.analog.com ([10.65.47.228])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 2A49SOqc016780;
        Fri, 4 Nov 2022 05:28:39 -0400
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 4/4] MAINTAINERS: add maintainer for ADF4377 driver
Date:   Fri, 4 Nov 2022 11:28:02 +0200
Message-ID: <20221104092802.90725-5-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221104092802.90725-1-antoniu.miclaus@analog.com>
References: <20221104092802.90725-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: gNeaGI--Q3SpCmrQgNswg4XDaKEBXEQn
X-Proofpoint-ORIG-GUID: gNeaGI--Q3SpCmrQgNswg4XDaKEBXEQn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_06,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=853 lowpriorityscore=0 mlxscore=0 clxscore=1015 malwarescore=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211040061
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as maintainer for the ADF4377 driver.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e1bc31a6624b..19a2f689e43e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1189,6 +1189,14 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
 F:	drivers/iio/amplifiers/ada4250.c
 
+ANALOG DEVICES INC ADF4377 DRIVER
+M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/frequency/adi,adf4377.yaml
+F:	drivers/iio/frequency/adf4377.c
+
 ANALOG DEVICES INC ADGS1408 DRIVER
 M:	Mircea Caprioru <mircea.caprioru@analog.com>
 S:	Supported
-- 
2.38.1

