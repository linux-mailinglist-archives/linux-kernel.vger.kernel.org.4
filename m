Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8D9741FE8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 07:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjF2F3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 01:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjF2F3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 01:29:37 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888A5272A;
        Wed, 28 Jun 2023 22:29:35 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T5D9Ib029925;
        Thu, 29 Jun 2023 05:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=qcppdkim1; bh=/eFDHskVH1DwAK+CCleH5QQSVu8wguMDmELrVvMxCBA=;
 b=A9DjIQC8Vru/Sks/m6+/kizJMAgrWEIdhfYA1vhXaeALWbB3HKLl3s4GdOFQOMH3rqqW
 DweKpyA7fwpFFTCCvtXZj1ko74sOo+cEUrRzgdWkdkqQSnsAnKTr8Mdw681NcvXebnYQ
 7Zbg80WXN8fHfaPQly33/qIowtJWq9QE0WxGZXMXjx7qlBKGFwHwN57degTPSdlD9+Wr
 OUb2MgFRCf12ns8SIFi8FDXQuj8TSBWCNca7uNOikivlP5+Gjowazp6HXe2ki2r5MhCi
 3altg7aoA30Az2spujmGGWQ6hcspcMQ/YK+mhxRHGNG+H1pyxocmtqOcEIs8nXjSQbAj Aw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgemk2jmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 05:29:02 +0000
Received: from pps.filterd (NASANPPMTA03.qualcomm.com [127.0.0.1])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 35T5T1uV018684;
        Thu, 29 Jun 2023 05:29:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA03.qualcomm.com (PPS) with ESMTPS id 3rgs7tq081-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 05:29:01 +0000
Received: from NASANPPMTA03.qualcomm.com (NASANPPMTA03.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35T5R9eq015744;
        Thu, 29 Jun 2023 05:29:01 GMT
Received: from stor-presley.qualcomm.com ([192.168.141.44])
        by NASANPPMTA03.qualcomm.com (PPS) with ESMTPS id 35T5T1nr018610
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 05:29:01 +0000
Received: by stor-presley.qualcomm.com (Postfix, from userid 359480)
        id C8C3521B82; Wed, 28 Jun 2023 22:29:00 -0700 (PDT)
From:   Can Guo <quic_cang@quicinc.com>
To:     quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        bvanassche@acm.org, mani@kernel.org, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        junwoo80.lee@samsung.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Lu Hongfei <luhongfei@vivo.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Daniil Lunev <dlunev@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] scsi: ufs: core: Update contact email for monitor sysfs nodes
Date:   Wed, 28 Jun 2023 22:28:54 -0700
Message-Id: <20230629052859.2855841-1-quic_cang@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OU7ViJmP38AcEMaERLnRsH3pbgj8Yhjs
X-Proofpoint-ORIG-GUID: OU7ViJmP38AcEMaERLnRsH3pbgj8Yhjs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0
 mlxlogscore=996 impostorscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290046
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update contact email address for UFS monitor sysfs nodes.

Signed-off-by: Can Guo <quic_cang@quicinc.com>

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index d5f44fc5b9dc..86d2d63c18ba 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -1084,7 +1084,7 @@ Description:	This entry shows the target state of an UFS UIC link
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/monitor_enable
 What:		/sys/bus/platform/devices/*.ufs/monitor/monitor_enable
 Date:		January 2021
-Contact:	Can Guo <cang@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This file shows the status of performance monitor enablement
 		and it can be used to start/stop the monitor. When the monitor
 		is stopped, the performance data collected is also cleared.
@@ -1092,7 +1092,7 @@ Description:	This file shows the status of performance monitor enablement
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/monitor_chunk_size
 What:		/sys/bus/platform/devices/*.ufs/monitor/monitor_chunk_size
 Date:		January 2021
-Contact:	Can Guo <cang@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This file tells the monitor to focus on requests transferring
 		data of specific chunk size (in Bytes). 0 means any chunk size.
 		It can only be changed when monitor is disabled.
@@ -1100,7 +1100,7 @@ Description:	This file tells the monitor to focus on requests transferring
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/read_total_sectors
 What:		/sys/bus/platform/devices/*.ufs/monitor/read_total_sectors
 Date:		January 2021
-Contact:	Can Guo <cang@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This file shows how many sectors (in 512 Bytes) have been
 		sent from device to host after monitor gets started.
 
@@ -1109,7 +1109,7 @@ Description:	This file shows how many sectors (in 512 Bytes) have been
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/read_total_busy
 What:		/sys/bus/platform/devices/*.ufs/monitor/read_total_busy
 Date:		January 2021
-Contact:	Can Guo <cang@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This file shows how long (in micro seconds) has been spent
 		sending data from device to host after monitor gets started.
 
@@ -1118,7 +1118,7 @@ Description:	This file shows how long (in micro seconds) has been spent
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/read_nr_requests
 What:		/sys/bus/platform/devices/*.ufs/monitor/read_nr_requests
 Date:		January 2021
-Contact:	Can Guo <cang@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This file shows how many read requests have been sent after
 		monitor gets started.
 
@@ -1127,7 +1127,7 @@ Description:	This file shows how many read requests have been sent after
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/read_req_latency_max
 What:		/sys/bus/platform/devices/*.ufs/monitor/read_req_latency_max
 Date:		January 2021
-Contact:	Can Guo <cang@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This file shows the maximum latency (in micro seconds) of
 		read requests after monitor gets started.
 
@@ -1136,7 +1136,7 @@ Description:	This file shows the maximum latency (in micro seconds) of
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/read_req_latency_min
 What:		/sys/bus/platform/devices/*.ufs/monitor/read_req_latency_min
 Date:		January 2021
-Contact:	Can Guo <cang@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This file shows the minimum latency (in micro seconds) of
 		read requests after monitor gets started.
 
@@ -1145,7 +1145,7 @@ Description:	This file shows the minimum latency (in micro seconds) of
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/read_req_latency_avg
 What:		/sys/bus/platform/devices/*.ufs/monitor/read_req_latency_avg
 Date:		January 2021
-Contact:	Can Guo <cang@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This file shows the average latency (in micro seconds) of
 		read requests after monitor gets started.
 
@@ -1154,7 +1154,7 @@ Description:	This file shows the average latency (in micro seconds) of
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/read_req_latency_sum
 What:		/sys/bus/platform/devices/*.ufs/monitor/read_req_latency_sum
 Date:		January 2021
-Contact:	Can Guo <cang@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This file shows the total latency (in micro seconds) of
 		read requests sent after monitor gets started.
 
@@ -1163,7 +1163,7 @@ Description:	This file shows the total latency (in micro seconds) of
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/write_total_sectors
 What:		/sys/bus/platform/devices/*.ufs/monitor/write_total_sectors
 Date:		January 2021
-Contact:	Can Guo <cang@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This file shows how many sectors (in 512 Bytes) have been sent
 		from host to device after monitor gets started.
 
@@ -1172,7 +1172,7 @@ Description:	This file shows how many sectors (in 512 Bytes) have been sent
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/write_total_busy
 What:		/sys/bus/platform/devices/*.ufs/monitor/write_total_busy
 Date:		January 2021
-Contact:	Can Guo <cang@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This file shows how long (in micro seconds) has been spent
 		sending data from host to device after monitor gets started.
 
@@ -1181,7 +1181,7 @@ Description:	This file shows how long (in micro seconds) has been spent
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/write_nr_requests
 What:		/sys/bus/platform/devices/*.ufs/monitor/write_nr_requests
 Date:		January 2021
-Contact:	Can Guo <cang@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This file shows how many write requests have been sent after
 		monitor gets started.
 
@@ -1190,7 +1190,7 @@ Description:	This file shows how many write requests have been sent after
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/write_req_latency_max
 What:		/sys/bus/platform/devices/*.ufs/monitor/write_req_latency_max
 Date:		January 2021
-Contact:	Can Guo <cang@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This file shows the maximum latency (in micro seconds) of write
 		requests after monitor gets started.
 
@@ -1199,7 +1199,7 @@ Description:	This file shows the maximum latency (in micro seconds) of write
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/write_req_latency_min
 What:		/sys/bus/platform/devices/*.ufs/monitor/write_req_latency_min
 Date:		January 2021
-Contact:	Can Guo <cang@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This file shows the minimum latency (in micro seconds) of write
 		requests after monitor gets started.
 
@@ -1208,7 +1208,7 @@ Description:	This file shows the minimum latency (in micro seconds) of write
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/write_req_latency_avg
 What:		/sys/bus/platform/devices/*.ufs/monitor/write_req_latency_avg
 Date:		January 2021
-Contact:	Can Guo <cang@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This file shows the average latency (in micro seconds) of write
 		requests after monitor gets started.
 
@@ -1217,7 +1217,7 @@ Description:	This file shows the average latency (in micro seconds) of write
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/write_req_latency_sum
 What:		/sys/bus/platform/devices/*.ufs/monitor/write_req_latency_sum
 Date:		January 2021
-Contact:	Can Guo <cang@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This file shows the total latency (in micro seconds) of write
 		requests after monitor gets started.
 
-- 
2.25.1

