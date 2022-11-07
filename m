Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E15861F2D3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 13:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbiKGMVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 07:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbiKGMVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 07:21:19 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43971090;
        Mon,  7 Nov 2022 04:21:18 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A7A9or0019781;
        Mon, 7 Nov 2022 07:21:09 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3kpmgu4d2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 07:21:09 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 2A7CL8Hd046758
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Nov 2022 07:21:08 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 7 Nov 2022
 07:21:07 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 7 Nov 2022 07:21:07 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.106])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 2A7CKrRL022057;
        Mon, 7 Nov 2022 07:21:00 -0500
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 3/3] Documentation: ABI: testing: adf4377: add ABI docs
Date:   Mon, 7 Nov 2022 14:02:43 +0200
Message-ID: <20221107120243.57344-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107120243.57344-1-antoniu.miclaus@analog.com>
References: <20221107120243.57344-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: jNfrmbqFreL_Hd80QSYpZ2v5Dfs_vgBw
X-Proofpoint-ORIG-GUID: jNfrmbqFreL_Hd80QSYpZ2v5Dfs_vgBw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_04,2022-11-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=831 clxscore=1015
 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211070100
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the use of the output frequency and muxout select.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v2:
 - remove muxout selectdocumentation, since it is done in the devicetree now
 Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4377 | 6 ++++++
 1 file changed, 6 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4377

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4377 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4377
new file mode 100644
index 000000000000..8888be49754c
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4377
@@ -0,0 +1,6 @@
+What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Stores the PLL frequency in Hz for output channels.
+		Reading returns the frequency in Hz.
-- 
2.38.1

