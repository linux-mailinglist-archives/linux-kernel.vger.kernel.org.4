Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2A564CC37
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 15:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238713AbiLNO1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 09:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238675AbiLNO1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 09:27:20 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7103227B02;
        Wed, 14 Dec 2022 06:27:13 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BEBCYgP006823;
        Wed, 14 Dec 2022 09:26:56 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3mf6rn2tqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Dec 2022 09:26:56 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 2BEEQtl3028770
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Dec 2022 09:26:55 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 14 Dec 2022 09:26:54 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 14 Dec 2022 09:26:54 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 14 Dec 2022 09:26:54 -0500
Received: from IST-LT-40003.ad.analog.com (IST-LT-40003.ad.analog.com [10.25.36.26])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 2BEEQLND022112;
        Wed, 14 Dec 2022 09:26:44 -0500
From:   Sinan Divarci <Sinan.Divarci@analog.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Sinan Divarci <Sinan.Divarci@analog.com>
Subject: [PATCH v2 2/3] docs: hwmon: add max31732 documentation
Date:   Wed, 14 Dec 2022 17:22:05 +0300
Message-ID: <20221214142206.13288-3-Sinan.Divarci@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221214142206.13288-1-Sinan.Divarci@analog.com>
References: <20221214142206.13288-1-Sinan.Divarci@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: SuS4rJQ4cQAaAUE6GLHZtto4J7ph7VrE
X-Proofpoint-ORIG-GUID: SuS4rJQ4cQAaAUE6GLHZtto4J7ph7VrE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-14_06,2022-12-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212140114
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding documentation for max31732 quad remote temperature sensor

Signed-off-by: Sinan Divarci <Sinan.Divarci@analog.com>
---
 Documentation/hwmon/index.rst    |  1 +
 Documentation/hwmon/max31732.rst | 62 ++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)
 create mode 100644 Documentation/hwmon/max31732.rst

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index fe2cc6b73..e521bf555 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -133,6 +133,7 @@ Hardware Monitoring Kernel Drivers
    max20751
    max31722
    max31730
+   max31732
    max31760
    max31785
    max31790
diff --git a/Documentation/hwmon/max31732.rst b/Documentation/hwmon/max31732.rst
new file mode 100644
index 000000000..67bfcf393
--- /dev/null
+++ b/Documentation/hwmon/max31732.rst
@@ -0,0 +1,62 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Kernel driver max31732
+======================
+
+Supported chips:
+
+  * Analog Devices MAX31732
+
+    Prefix: 'max31732'
+
+    Addresses scanned: none
+
+Author: Sinan Divarci <Sinan.Divarci@analog.com>
+
+
+Description
+-----------
+
+This driver implements support for Maxim MAX31732.
+
+The MAX31732 is a multi-channel temperature sensor that monitors its
+own temperature and the temperatures of up to four external diodeconnected
+transistors. The device operates with 3.0V to 3.6V supply range
+and consume TBDμA of current in standby mode of operation. Resistance
+cancellation feature compensates for high series resistance between
+circuit-board traces and the external thermal diode, while beta
+compensation corrects for temperature-measurement errors due to lowbeta
+sensing transistors.
+
+The MAX31732 offers two open-drain, active-low alarm outputs,
+ALARM1 and ALARM2. When the measured temperature of a channel
+crosses the respective primary over/under temperature threshold levels
+ALARM1 asserts low and a status bit is set in the corresponding thermal
+status registers. When the measured temperature of a channel crosses the
+secondary over/under temperature threshold levels, ALARM2 asserts low
+and a status bit is set in the corresponding thermal status registers.
+
+Temperature measurement range: from -64°C to 150°C
+
+Temperature Resolution: 12 Bits, ±0.0625°C
+
+Sysfs entries
+-------------
+
+===================== == =======================================================
+temp[1-5]_enable      RW Temperature enable/disable
+                         Set to 1 to enable channel, 0 to disable
+temp[1-5]_input       RO Temperature input
+temp[2-5]_fault       RO Fault indicator for remote channels
+temp[1-5]_max         RW Temperature max value. Asserts "ALARM1" pin when exceeded
+temp[1-5]_max_alarm   RO Temperature max alarm status
+temp[1-5]_crit        RW Temperature critical value. Asserts "ALARM2" pin when exceeded
+temp[1-5]_crit_alarm  RO Temperature critical alarm status
+temp[1-5]_min         RW Temperature min value. Common for all channels.
+                         Only temp1_min is writeable. Asserts "ALARM1" pin when exceeded
+temp[1-5]_min_alarm   RO Temperature min alarm status
+temp[1-5]_lcrit       RW Temperature critical low value. Common for all channels.
+                         Only temp1_min is writeable. Asserts "ALARM2" pin when exceeded
+temp[1-5]_lcrit_alarm RO Temperature critical low alarm status
+temp[2-5]_offset      RW Temperature offset for remote channels
+===================== == =======================================================
-- 
2.25.1

