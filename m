Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096AD7417F9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 20:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjF1SYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 14:24:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131]:45210 "EHLO
        mx0b-0031df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231952AbjF1SYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 14:24:14 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SGuh4A018711;
        Wed, 28 Jun 2023 18:24:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=FmEnIv47O8LpshBv/+Ww/G89f3pFv2vELTGe0c+7Z/k=;
 b=iIqpVuXapdXKGFfMK9TbjAU+czUOatz8GUUCFMxVcdWEbPe64C/sYZ9X6VIS8VDUiVrp
 ZUHbgN+c0jg5mEFlxVpQXUUPFTFRKgX2dh4+STsikho3/Tqkn8Ap5/FiUtSgVXTBuj8Y
 eHoutUwEQIojrWgZZSn/6jUp3LzRZi/MXv7JQHELucGuMEHTKL061lF90lA6SlBbbW46
 OcvSq++NiOOFvyBVz8aOipT79bnXl6ytRK/sdjiEsmKSPzsQQ1R7fNriNFogcfKZt6o6
 7hN7P9CmrNd8qOyAQS7kzhmXOD28dT9n4uO53e/LZS5KXg3C16X1REQ/60EI+O3VKOgl QA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgnxr8mnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 18:24:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35SIO1Ll007466
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 18:24:01 GMT
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.7; Wed, 28 Jun 2023 11:24:00 -0700
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
To:     <mani@kernel.org>, <andersson@kernel.org>
CC:     <mhi@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: [PATCH] docs: ABI: sysfs-bus-mhi: Update contact info
Date:   Wed, 28 Jun 2023 12:23:46 -0600
Message-ID: <20230628182346.3855-1-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SJQiqnD7wGssbmJPhMV0fiV-w4Z9KUFO
X-Proofpoint-GUID: SJQiqnD7wGssbmJPhMV0fiV-w4Z9KUFO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_13,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 impostorscore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280162
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@codeaurora.org email addresses are no longer valid and will bounce to
sender.  Also, Bhaumik has previously indicated he is no longer interested
in participating in MHI bus discussions.

Update contact info from Bhaumik to the mhi mail list so that mails will
be routed to the MHI maintainers and interested parties.

Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
---
 Documentation/ABI/stable/sysfs-bus-mhi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-bus-mhi b/Documentation/ABI/stable/sysfs-bus-mhi
index 96ccc3385a2b..1a47f9e0cc84 100644
--- a/Documentation/ABI/stable/sysfs-bus-mhi
+++ b/Documentation/ABI/stable/sysfs-bus-mhi
@@ -1,7 +1,7 @@
 What:		/sys/bus/mhi/devices/.../serialnumber
 Date:		Sept 2020
 KernelVersion:	5.10
-Contact:	Bhaumik Bhatt <bbhatt@codeaurora.org>
+Contact:	mhi@lists.linux.dev
 Description:	The file holds the serial number of the client device obtained
 		using a BHI (Boot Host Interface) register read after at least
 		one attempt to power up the device has been done. If read
@@ -12,7 +12,7 @@ Users:		Any userspace application or clients interested in device info.
 What:		/sys/bus/mhi/devices/.../oem_pk_hash
 Date:		Sept 2020
 KernelVersion:	5.10
-Contact:	Bhaumik Bhatt <bbhatt@codeaurora.org>
+Contact:	mhi@lists.linux.dev
 Description:	The file holds the OEM PK Hash value of the endpoint device
 		obtained using a BHI (Boot Host Interface) register read after
 		at least one attempt to power up the device has been done. If
-- 
2.40.1

