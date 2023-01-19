Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C42673EB4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjASQ0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjASQ0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:26:37 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579BA4F34A;
        Thu, 19 Jan 2023 08:26:36 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JD1ldf019543;
        Thu, 19 Jan 2023 16:26:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=fxEqCJ6Eyu2B6HdFbbL+rFgS3BmR8Vw49sjAoVUA4N4=;
 b=CPp2SRiFMICzKgyXstwlmkYo69M2W2b2YVJKjG121BECw/S5g1JvK5Q4dk7IQM7iPkqE
 vq9blWFbFgNZziBkAV15WqR0zDTTKGScQz62vuvvomgngTTKTWnYuoyv2JUuGl6Kk8Sq
 vsdDUsMX9NmGEIwJUvFr43X2Wxhm5JYOMDxqBlc4h/fPhJRMlAVzOmLML+TQJvfZoGON
 jM9uUAzGVhrzzmSuIi4iIJCez+qRzgJeOEht8daTeDBnOBeoWeqddqcvdGHNyv/MDBYJ
 9dWS38hRPYd5hkJDftNQQIblY93fwiUIxsTJs90/M0LOsY313mhvmfMCLo6WZIuK/JwB wg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n6vjbhwcd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 16:26:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30JGQWLD008720
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 16:26:32 GMT
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 19 Jan 2023 08:26:31 -0800
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
To:     <ogabbay@kernel.org>, <corbet@lwn.net>
CC:     <dri-devel@lists.freedesktop.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: [PATCH] docs: accel: Fix debugfs path
Date:   Thu, 19 Jan 2023 09:26:08 -0700
Message-ID: <1674145568-31513-1-git-send-email-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eLVhhrsWMJ-Ci9r95qLTQ4tkkxiMBWBD
X-Proofpoint-GUID: eLVhhrsWMJ-Ci9r95qLTQ4tkkxiMBWBD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_10,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 clxscore=1011 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 impostorscore=0 mlxlogscore=808
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301190133
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device specific directory in debugfs does not have "accel".  For
example, the documentation says device 0 should have a debugfs entry as
/sys/kernel/debug/accel/accel0/ but in reality the entry is
/sys/kernel/debug/accel/0/

Fix the documentation to match the implementation.

Fixes: 8c5577a5ccc6 ("doc: add documentation for accel subsystem")
Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
---
 Documentation/accel/introduction.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/accel/introduction.rst b/Documentation/accel/introduction.rst
index 6f31af1..11cade5 100644
--- a/Documentation/accel/introduction.rst
+++ b/Documentation/accel/introduction.rst
@@ -69,7 +69,7 @@ The accelerator devices will be exposed to the user space with the dedicated
 
 - device char files - /dev/accel/accel*
 - sysfs             - /sys/class/accel/accel*/
-- debugfs           - /sys/kernel/debug/accel/accel*/
+- debugfs           - /sys/kernel/debug/accel/*/
 
 Getting Started
 ===============
-- 
2.7.4

