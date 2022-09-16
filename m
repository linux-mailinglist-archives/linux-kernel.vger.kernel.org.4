Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86B25BAF05
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbiIPOM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbiIPOMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:12:06 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2866DB08AE;
        Fri, 16 Sep 2022 07:12:05 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28GE36HU020563;
        Fri, 16 Sep 2022 10:12:03 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jm8x5pbbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 10:12:03 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 28GEC2mr057789
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Sep 2022 10:12:02 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 16 Sep 2022 10:12:01 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 16 Sep 2022 10:12:01 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 16 Sep 2022 10:12:01 -0400
Received: from debian.ad.analog.com ([10.48.65.127])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 28GEBfso020264;
        Fri, 16 Sep 2022 10:11:54 -0400
From:   Ciprian Regus <ciprian.regus@analog.com>
To:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ciprian Regus <ciprian.regus@analog.com>
Subject: [PATCH 5/5] drivers: iio: adc: Rename the LTC2499 iio device
Date:   Fri, 16 Sep 2022 17:09:22 +0300
Message-ID: <20220916140922.2506248-6-ciprian.regus@analog.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220916140922.2506248-1-ciprian.regus@analog.com>
References: <20220916140922.2506248-1-ciprian.regus@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: t7NyyDnvjP0QQERHa8bvwnhTrVE8H0g3
X-Proofpoint-ORIG-GUID: t7NyyDnvjP0QQERHa8bvwnhTrVE8H0g3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-16_08,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2209160105
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the iio device's name based on the chip used for the
LTC2499 only. The most common way for IIO clients to interact
with a device is to address it based on it's name. By using
the dev_name() function, the name will be set based on a
i2c_client's kobj name, which has the format i2c_instance-i2c_address
(1-0076 for example). This is not ideal, since it makes a
requirement for userspace to have knowledge about the hardware
connections of the device.

The name field is set to NULL for the LTC2497 and LTC2496, so
that the old name can kept as it is, since changing it will
result in an ABI breakage.

Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
---
 changes in v3:
  - moved the chip info name field setting in this patch.
 drivers/iio/adc/ltc2496.c      |  1 +
 drivers/iio/adc/ltc2497-core.c | 10 +++++++++-
 drivers/iio/adc/ltc2497.c      |  2 ++
 drivers/iio/adc/ltc2497.h      |  1 +
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ltc2496.c b/drivers/iio/adc/ltc2496.c
index bf89d5ae19af..2593fa4322eb 100644
--- a/drivers/iio/adc/ltc2496.c
+++ b/drivers/iio/adc/ltc2496.c
@@ -89,6 +89,7 @@ static void ltc2496_remove(struct spi_device *spi)
 
 static const struct ltc2497_chip_info ltc2496_info = {
 	.resolution = 16,
+	.name = NULL,
 };
 
 static const struct of_device_id ltc2496_of_match[] = {
diff --git a/drivers/iio/adc/ltc2497-core.c b/drivers/iio/adc/ltc2497-core.c
index b2752399402c..f52d37af4d1f 100644
--- a/drivers/iio/adc/ltc2497-core.c
+++ b/drivers/iio/adc/ltc2497-core.c
@@ -169,7 +169,15 @@ int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev)
 	struct ltc2497core_driverdata *ddata = iio_priv(indio_dev);
 	int ret;
 
-	indio_dev->name = dev_name(dev);
+	/*
+	 * Keep using dev_name() for the iio_dev's name on some of the parts,
+	 * since updating it would result in a ABI breakage.
+	 */
+	if (ddata->chip_info->name)
+		indio_dev->name = ddata->chip_info->name;
+	else
+		indio_dev->name = dev_name(dev);
+
 	indio_dev->info = &ltc2497core_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = ltc2497core_channel;
diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
index 36248423a7a6..ea76436adaf3 100644
--- a/drivers/iio/adc/ltc2497.c
+++ b/drivers/iio/adc/ltc2497.c
@@ -126,9 +126,11 @@ static int ltc2497_remove(struct i2c_client *client)
 static const struct ltc2497_chip_info ltc2497_info[] = {
 	[TYPE_LTC2497] = {
 		.resolution = 16,
+		.name = NULL,
 	},
 	[TYPE_LTC2499] = {
 		.resolution = 24,
+		.name = "ltc2499",
 	},
 };
 
diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
index 71957fc7e1ba..e023de0d88c4 100644
--- a/drivers/iio/adc/ltc2497.h
+++ b/drivers/iio/adc/ltc2497.h
@@ -6,6 +6,7 @@
 
 struct ltc2497_chip_info {
 	u32 resolution;
+	const char *name;
 };
 
 struct ltc2497core_driverdata {
-- 
2.30.2

