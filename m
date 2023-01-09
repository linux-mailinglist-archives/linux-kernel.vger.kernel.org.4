Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DF9662898
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 15:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjAIObz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 09:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbjAIObn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 09:31:43 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23414F46;
        Mon,  9 Jan 2023 06:31:42 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309CY0h6015630;
        Mon, 9 Jan 2023 14:31:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=To2M7m8ifpIWIdwpFICEz3ryGg079W9y4tN8/QOGdV4=;
 b=C8hhFRcNZoSAPYaBcWSIn41fhcMKbBRPq0+XpDXrxiYoeFElBGJe7WXV2Wgrgv7ETwW1
 tFlpzy2g4immZDqO4v0U6sifj/Lb7pa7KJ0z6fozAR8C55omc+8jIW/E0FZ02eq79K4E
 eFOjxy07sm04gP2Br904yWKwUXgpOTTeh1CfEotCihmDtY+L9hwXu289h3fBJwoeAgw5
 jEfDT3H3VCyaBr3WFwkvOrPcyLO4FSwPwHGxR3cuM1hGJbURpG0P0q2O5OM5t34xl+DB
 OC7kmV+sZ1L82lhQ81kR0XX4xpG9GUvOJrKaz67rZpGqnRhIM5JXpXIE/Sk8fpd/1bZC nw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3my0yab96p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 14:31:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 309EVYIk008829
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Jan 2023 14:31:34 GMT
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 9 Jan 2023 06:31:31 -0800
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: [PATCH V0 1/1] bootconfig: Increase max size of bootconfig from 32 KB to 256 KB for DCC support
Date:   Mon, 9 Jan 2023 20:01:05 +0530
Message-ID: <654357bcbfd3974072a558c494a51edafaa73e1a.1673261071.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1673261071.git.quic_schowdhu@quicinc.com>
References: <cover.1673261071.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NsW1RMkj6V-w0IFwYdL-EqcGWixwojvg
X-Proofpoint-ORIG-GUID: NsW1RMkj6V-w0IFwYdL-EqcGWixwojvg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_08,2023-01-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=988 adultscore=0
 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 impostorscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301090104
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increasing the memory size of bootconfig to be able to handle a max number of
8192 nodes to be fitted in memory size of 256KB.

Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
---
 include/linux/bootconfig.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index 1611f9d..64d233b 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -55,11 +55,11 @@ struct xbc_node {
 } __attribute__ ((__packed__));
 
 #define XBC_KEY		0
-#define XBC_VALUE	(1 << 15)
-/* Maximum size of boot config is 32KB - 1 */
+#define XBC_VALUE	(1 << 18)
+/* Maximum size of boot config is 256KB - 1 */
 #define XBC_DATA_MAX	(XBC_VALUE - 1)
 
-#define XBC_NODE_MAX	1024
+#define XBC_NODE_MAX	8192
 #define XBC_KEYLEN_MAX	256
 #define XBC_DEPTH_MAX	16
 
-- 
2.7.4

