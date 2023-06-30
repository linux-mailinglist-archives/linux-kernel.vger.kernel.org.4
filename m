Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F0F7431CC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 02:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjF3Ajy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 20:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjF3Ajt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 20:39:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2111FDF;
        Thu, 29 Jun 2023 17:39:47 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35U009Ir012570;
        Fri, 30 Jun 2023 00:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=qcppdkim1; bh=SysdLdmDMZCMaTmCcM1eV8civzpb1b91kq5t0uIhQak=;
 b=YpRPvwTlx1jsk/hJ1ZYDxexnneaaNUNuilC+3OWQuqgwVo6qaKenZy8yKgkVtOpt+5OB
 UrEPAn9woS/zIYHyXauiOcR7+VK1IssK/ZZe3ydzNcAX8ojalt2MfV4dPtoi/tXwNW2/
 YNSUG6mtgrh5WLgK5UqUqYcxve1Xe0ev+5MEt6XIDB0J+s5EajBtHjT00RgYJzJvV3zO
 UHUDbaqG4AzJDW29SEYZqMBfnftK7twS6otb8TLy5hMz/I0vP1DIYtw2pj0hEsYD6nv4
 F70aodvdqPsE35KLADFI7qHktTbLlATXf5o+SDUruo3SQmkOolRfmKa6WkRm5BdfyCUz eg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rh2ks256x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 00:39:32 +0000
Received: from pps.filterd (NASANPPMTA05.qualcomm.com [127.0.0.1])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 35U0dVsw008897;
        Fri, 30 Jun 2023 00:39:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA05.qualcomm.com (PPS) with ESMTPS id 3rhfskkbxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 00:39:31 +0000
Received: from NASANPPMTA05.qualcomm.com (NASANPPMTA05.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35U0dVeq008888;
        Fri, 30 Jun 2023 00:39:31 GMT
Received: from stor-presley.qualcomm.com ([192.168.141.44])
        by NASANPPMTA05.qualcomm.com (PPS) with ESMTPS id 35U0dVbF008886
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 00:39:31 +0000
Received: by stor-presley.qualcomm.com (Postfix, from userid 359480)
        id 0C32C21B95; Thu, 29 Jun 2023 17:39:31 -0700 (PDT)
From:   Can Guo <quic_cang@quicinc.com>
To:     quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        bvanassche@acm.org, mani@kernel.org, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        junwoo80.lee@samsung.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Lu Hongfei <luhongfei@vivo.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Daniil Lunev <dlunev@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] scsi: ufs: core: Update contact email for monitor sysfs nodes
Date:   Thu, 29 Jun 2023 17:39:09 -0700
Message-Id: <20230630003913.3713155-1-quic_cang@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: f1fEPAKiN33dsraWJ5FzLD33XcbLSa7h
X-Proofpoint-ORIG-GUID: f1fEPAKiN33dsraWJ5FzLD33XcbLSa7h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_10,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300004
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update contact email addresses for Can Guo and Asutosh Das, replace
Subhash Jadavani's contact.

Signed-off-by: Can Guo <quic_cang@quicinc.com>
---
 Documentation/ABI/testing/sysfs-driver-ufs | 76 +++++++++++-----------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index d5f44fc5b9dc..e487f969a15e 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -994,7 +994,7 @@ Description:	This file shows the amount of physical memory needed
 What:		/sys/bus/platform/drivers/ufshcd/*/rpm_lvl
 What:		/sys/bus/platform/devices/*.ufs/rpm_lvl
 Date:		September 2014
-Contact:	Subhash Jadavani <subhashj@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This entry could be used to set or show the UFS device
 		runtime power management level. The current driver
 		implementation supports 7 levels with next target states:
@@ -1021,7 +1021,7 @@ Description:	This entry could be used to set or show the UFS device
 What:		/sys/bus/platform/drivers/ufshcd/*/rpm_target_dev_state
 What:		/sys/bus/platform/devices/*.ufs/rpm_target_dev_state
 Date:		February 2018
-Contact:	Subhash Jadavani <subhashj@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This entry shows the target power mode of an UFS device
 		for the chosen runtime power management level.
 
@@ -1030,7 +1030,7 @@ Description:	This entry shows the target power mode of an UFS device
 What:		/sys/bus/platform/drivers/ufshcd/*/rpm_target_link_state
 What:		/sys/bus/platform/devices/*.ufs/rpm_target_link_state
 Date:		February 2018
-Contact:	Subhash Jadavani <subhashj@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This entry shows the target state of an UFS UIC link
 		for the chosen runtime power management level.
 
@@ -1039,7 +1039,7 @@ Description:	This entry shows the target state of an UFS UIC link
 What:		/sys/bus/platform/drivers/ufshcd/*/spm_lvl
 What:		/sys/bus/platform/devices/*.ufs/spm_lvl
 Date:		September 2014
-Contact:	Subhash Jadavani <subhashj@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This entry could be used to set or show the UFS device
 		system power management level. The current driver
 		implementation supports 7 levels with next target states:
@@ -1066,7 +1066,7 @@ Description:	This entry could be used to set or show the UFS device
 What:		/sys/bus/platform/drivers/ufshcd/*/spm_target_dev_state
 What:		/sys/bus/platform/devices/*.ufs/spm_target_dev_state
 Date:		February 2018
-Contact:	Subhash Jadavani <subhashj@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This entry shows the target power mode of an UFS device
 		for the chosen system power management level.
 
@@ -1075,7 +1075,7 @@ Description:	This entry shows the target power mode of an UFS device
 What:		/sys/bus/platform/drivers/ufshcd/*/spm_target_link_state
 What:		/sys/bus/platform/devices/*.ufs/spm_target_link_state
 Date:		February 2018
-Contact:	Subhash Jadavani <subhashj@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This entry shows the target state of an UFS UIC link
 		for the chosen system power management level.
 
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
 
@@ -1226,7 +1226,7 @@ Description:	This file shows the total latency (in micro seconds) of write
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/wb_presv_us_en
 What:		/sys/bus/platform/devices/*.ufs/device_descriptor/wb_presv_us_en
 Date:		June 2020
-Contact:	Asutosh Das <asutoshd@codeaurora.org>
+Contact:	Asutosh Das <quic_asutoshd@quicinc.com>
 Description:	This entry shows if preserve user-space was configured
 
 		The file is read only.
@@ -1234,7 +1234,7 @@ Description:	This entry shows if preserve user-space was configured
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/wb_shared_alloc_units
 What:		/sys/bus/platform/devices/*.ufs/device_descriptor/wb_shared_alloc_units
 Date:		June 2020
-Contact:	Asutosh Das <asutoshd@codeaurora.org>
+Contact:	Asutosh Das <quic_asutoshd@quicinc.com>
 Description:	This entry shows the shared allocated units of WB buffer
 
 		The file is read only.
@@ -1242,7 +1242,7 @@ Description:	This entry shows the shared allocated units of WB buffer
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/wb_type
 What:		/sys/bus/platform/devices/*.ufs/device_descriptor/wb_type
 Date:		June 2020
-Contact:	Asutosh Das <asutoshd@codeaurora.org>
+Contact:	Asutosh Das <quic_asutoshd@quicinc.com>
 Description:	This entry shows the configured WB type.
 		0x1 for shared buffer mode. 0x0 for dedicated buffer mode.
 
@@ -1251,7 +1251,7 @@ Description:	This entry shows the configured WB type.
 What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/wb_buff_cap_adj
 What:		/sys/bus/platform/devices/*.ufs/geometry_descriptor/wb_buff_cap_adj
 Date:		June 2020
-Contact:	Asutosh Das <asutoshd@codeaurora.org>
+Contact:	Asutosh Das <quic_asutoshd@quicinc.com>
 Description:	This entry shows the total user-space decrease in shared
 		buffer mode.
 		The value of this parameter is 3 for TLC NAND when SLC mode
@@ -1262,7 +1262,7 @@ Description:	This entry shows the total user-space decrease in shared
 What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/wb_max_alloc_units
 What:		/sys/bus/platform/devices/*.ufs/geometry_descriptor/wb_max_alloc_units
 Date:		June 2020
-Contact:	Asutosh Das <asutoshd@codeaurora.org>
+Contact:	Asutosh Das <quic_asutoshd@quicinc.com>
 Description:	This entry shows the Maximum total WriteBooster Buffer size
 		which is supported by the entire device.
 
@@ -1271,7 +1271,7 @@ Description:	This entry shows the Maximum total WriteBooster Buffer size
 What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/wb_max_wb_luns
 What:		/sys/bus/platform/devices/*.ufs/geometry_descriptor/wb_max_wb_luns
 Date:		June 2020
-Contact:	Asutosh Das <asutoshd@codeaurora.org>
+Contact:	Asutosh Das <quic_asutoshd@quicinc.com>
 Description:	This entry shows the maximum number of luns that can support
 		WriteBooster.
 
@@ -1280,7 +1280,7 @@ Description:	This entry shows the maximum number of luns that can support
 What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/wb_sup_red_type
 What:		/sys/bus/platform/devices/*.ufs/geometry_descriptor/wb_sup_red_type
 Date:		June 2020
-Contact:	Asutosh Das <asutoshd@codeaurora.org>
+Contact:	Asutosh Das <quic_asutoshd@quicinc.com>
 Description:	The supportability of user space reduction mode
 		and preserve user space mode.
 		00h: WriteBooster Buffer can be configured only in
@@ -1295,7 +1295,7 @@ Description:	The supportability of user space reduction mode
 What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/wb_sup_wb_type
 What:		/sys/bus/platform/devices/*.ufs/geometry_descriptor/wb_sup_wb_type
 Date:		June 2020
-Contact:	Asutosh Das <asutoshd@codeaurora.org>
+Contact:	Asutosh Das <quic_asutoshd@quicinc.com>
 Description:	The supportability of WriteBooster Buffer type.
 
 		===  ==========================================================
@@ -1310,7 +1310,7 @@ Description:	The supportability of WriteBooster Buffer type.
 What:		/sys/bus/platform/drivers/ufshcd/*/flags/wb_enable
 What:		/sys/bus/platform/devices/*.ufs/flags/wb_enable
 Date:		June 2020
-Contact:	Asutosh Das <asutoshd@codeaurora.org>
+Contact:	Asutosh Das <quic_asutoshd@quicinc.com>
 Description:	This entry shows the status of WriteBooster.
 
 		== ============================
@@ -1323,7 +1323,7 @@ Description:	This entry shows the status of WriteBooster.
 What:		/sys/bus/platform/drivers/ufshcd/*/flags/wb_flush_en
 What:		/sys/bus/platform/devices/*.ufs/flags/wb_flush_en
 Date:		June 2020
-Contact:	Asutosh Das <asutoshd@codeaurora.org>
+Contact:	Asutosh Das <quic_asutoshd@quicinc.com>
 Description:	This entry shows if flush is enabled.
 
 		== =================================
@@ -1336,7 +1336,7 @@ Description:	This entry shows if flush is enabled.
 What:		/sys/bus/platform/drivers/ufshcd/*/flags/wb_flush_during_h8
 What:		/sys/bus/platform/devices/*.ufs/flags/wb_flush_during_h8
 Date:		June 2020
-Contact:	Asutosh Das <asutoshd@codeaurora.org>
+Contact:	Asutosh Das <quic_asutoshd@quicinc.com>
 Description:	Flush WriteBooster Buffer during hibernate state.
 
 		== =================================================
@@ -1351,7 +1351,7 @@ Description:	Flush WriteBooster Buffer during hibernate state.
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/wb_avail_buf
 What:		/sys/bus/platform/devices/*.ufs/attributes/wb_avail_buf
 Date:		June 2020
-Contact:	Asutosh Das <asutoshd@codeaurora.org>
+Contact:	Asutosh Das <quic_asutoshd@quicinc.com>
 Description:	This entry shows the amount of unused WriteBooster buffer
 		available.
 
@@ -1360,7 +1360,7 @@ Description:	This entry shows the amount of unused WriteBooster buffer
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/wb_cur_buf
 What:		/sys/bus/platform/devices/*.ufs/attributes/wb_cur_buf
 Date:		June 2020
-Contact:	Asutosh Das <asutoshd@codeaurora.org>
+Contact:	Asutosh Das <quic_asutoshd@quicinc.com>
 Description:	This entry shows the amount of unused current buffer.
 
 		The file is read only.
@@ -1368,7 +1368,7 @@ Description:	This entry shows the amount of unused current buffer.
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/wb_flush_status
 What:		/sys/bus/platform/devices/*.ufs/attributes/wb_flush_status
 Date:		June 2020
-Contact:	Asutosh Das <asutoshd@codeaurora.org>
+Contact:	Asutosh Das <quic_asutoshd@quicinc.com>
 Description:	This entry shows the flush operation status.
 
 
@@ -1385,7 +1385,7 @@ Description:	This entry shows the flush operation status.
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/wb_life_time_est
 What:		/sys/bus/platform/devices/*.ufs/attributes/wb_life_time_est
 Date:		June 2020
-Contact:	Asutosh Das <asutoshd@codeaurora.org>
+Contact:	Asutosh Das <quic_asutoshd@quicinc.com>
 Description:	This entry shows an indication of the WriteBooster Buffer
 		lifetime based on the amount of performed program/erase cycles
 
@@ -1399,7 +1399,7 @@ Description:	This entry shows an indication of the WriteBooster Buffer
 
 What:		/sys/class/scsi_device/*/device/unit_descriptor/wb_buf_alloc_units
 Date:		June 2020
-Contact:	Asutosh Das <asutoshd@codeaurora.org>
+Contact:	Asutosh Das <quic_asutoshd@quicinc.com>
 Description:	This entry shows the configured size of WriteBooster buffer.
 		0400h corresponds to 4GB.
 
-- 
2.25.1

