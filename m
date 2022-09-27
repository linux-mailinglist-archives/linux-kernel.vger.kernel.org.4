Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7EF45EC5CF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbiI0OTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiI0OTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:19:31 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58102130;
        Tue, 27 Sep 2022 07:19:30 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28RCdXXY016577;
        Tue, 27 Sep 2022 10:19:27 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3jsxt7c18f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 10:19:27 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 28REJQBn010525
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Sep 2022 10:19:26 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 27 Sep 2022 10:19:25 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 27 Sep 2022 10:19:25 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 27 Sep 2022 10:19:25 -0400
Received: from IST-LT-39247.ad.analog.com (IST-LT-39247.ad.analog.com [10.25.16.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 28REJ325020436;
        Tue, 27 Sep 2022 10:19:18 -0400
From:   Ibrahim Tilki <Ibrahim.Tilki@analog.com>
To:     <jic23@kernel.org>
CC:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        <linux-iio@vger.kernel.org>, <Nuno.Sa@analog.com>,
        <Nurettin.Bolucu@analog.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 3/3] Documentation: ABI: testing: add max11410 doc
Date:   Tue, 27 Sep 2022 17:18:51 +0300
Message-ID: <20220927141851.279-4-Ibrahim.Tilki@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220927141851.279-1-Ibrahim.Tilki@analog.com>
References: <20220927141851.279-1-Ibrahim.Tilki@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Xrrs2Pgu_4gWLjeUvm2RsRXCBD0fhTwt
X-Proofpoint-GUID: Xrrs2Pgu_4gWLjeUvm2RsRXCBD0fhTwt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_05,2022-09-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 phishscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 mlxlogscore=850 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209270088
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding documentation for Analog Devices max11410 adc userspace sysfs.

Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
---
 .../ABI/testing/sysfs-bus-iio-adc-max11410          | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-max11410

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-max11410 b/Documentation/ABI/testing/sysfs-bus-iio-adc-max11410
new file mode 100644
index 0000000000..2a53c6b373
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-max11410
@@ -0,0 +1,13 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_filterY_notch_en
+Date:		September 2022
+KernelVersion:  6.0
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Enable or disable a notch filter.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_filterY_notch_center
+Date:		September 2022
+KernelVersion:  6.0
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Center frequency of the notch filter in Hz.
-- 
2.25.1

