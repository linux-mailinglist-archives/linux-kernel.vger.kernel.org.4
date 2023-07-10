Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480F374D16D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjGJJ22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjGJJ16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:27:58 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC61A8;
        Mon, 10 Jul 2023 02:27:57 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36A9M0fQ019101;
        Mon, 10 Jul 2023 09:27:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=O0cjyRoFYmP1r3Hn8Jm2bXotg1uYFhr0WynRIRIF4ts=;
 b=UEBTG8rAw8ObDSpPjsSAgw7K/nIOCXhtGMGXzFwFFddm2zvCC9cDlbKIGwzjiPSmWDzG
 hsaxeNzfOb1nSGwtqLeYDC0o+QgZVbyhr5acwT0Na1TAU/MWlI7VaNEMz+dUgKLt9Sa+
 rC05qzk8pKDtbdwtpgO7BCeF5n4RMhMpU4mX7LKtn3xs8ZM8Km6jIDscp2pOYijsXkR/
 ubIuqfdc0yRMi37jmmFrk005po92dR6wvEA68LQScRN8t4nWRwaV8oTEpr/yepXpwq9H
 pkUPln/uIDHN8a03fQtmPcDL1vPAIRhOWRrX4FKEZGkZhlzV/47SQF7aKQYpbI49cpo7 XQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rrf9t832b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 09:27:50 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36A4lSXS000448;
        Mon, 10 Jul 2023 09:27:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3rpy2e1592-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 09:27:49 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36A9Rj2w35848498
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 09:27:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE6622004B;
        Mon, 10 Jul 2023 09:27:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BCC3B20040;
        Mon, 10 Jul 2023 09:27:43 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com.com (unknown [9.43.85.154])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 10 Jul 2023 09:27:43 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, disgoel@linux.ibm.com,
        kjain@linux.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/10] docs: ABI: sysfs-bus-event_source-devices-hv_gpci: Document processor_config sysfs interface file
Date:   Mon, 10 Jul 2023 14:57:11 +0530
Message-Id: <20230710092717.55317-5-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230710092717.55317-1-kjain@linux.ibm.com>
References: <20230710092717.55317-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: J-iL1w3sUknsKhznqqGJaWh40oW7B3ro
X-Proofpoint-GUID: J-iL1w3sUknsKhznqqGJaWh40oW7B3ro
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_07,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 suspectscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307100082
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add details of the new hv-gpci interface file called
"processor_config" in the ABI documentation.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 .../sysfs-bus-event_source-devices-hv_gpci    | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_gpci b/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_gpci
index 2eeeab9a20fa..aff52dc3b05c 100644
--- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_gpci
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_gpci
@@ -112,3 +112,35 @@ Description:	admin read only
 			   more information.
 
 		* "-EFBIG" : System information exceeds PAGE_SIZE.
+
+What:		/sys/devices/hv_gpci/interface/processor_config
+Date:		July 2023
+Contact:	Linux on PowerPC Developer List <linuxppc-dev@lists.ozlabs.org>
+Description:	admin read only
+		This sysfs file exposes the system topology information by making HCALL
+		H_GET_PERF_COUNTER_INFO. The HCALL is made with counter request value
+		PROCESSOR_CONFIG(0x90).
+
+		* This sysfs file will be created only for power10 and above platforms.
+
+		* User needs root privileges to read data from this sysfs file.
+
+		* This sysfs file will be created, only when the HCALL returns "H_SUCESS",
+		  "H_AUTHORITY" and "H_PARAMETER" as the return type.
+
+		  HCALL with return error type "H_AUTHORITY", can be resolved during
+		  runtime by setting "Enable Performance Information Collection" option.
+
+		* The end user reading this sysfs file must decode the content as per
+		  underlying platform/firmware.
+
+		Possible error codes while reading this sysfs file:
+
+		* "-EPERM" : Partition is not permitted to retrieve performance information,
+			    required to set "Enable Performance Information Collection" option.
+
+		* "-EIO" : Can't retrieve system information because of invalid buffer length/invalid address
+			   or because of some hardware error. Refer getPerfCountInfo documentation for
+			   more information.
+
+		* "-EFBIG" : System information exceeds PAGE_SIZE.
-- 
2.31.1

