Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9337418C0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 21:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjF1TQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 15:16:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131]:37622 "EHLO
        mx0b-0031df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229622AbjF1TQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 15:16:32 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SIWEEx005881;
        Wed, 28 Jun 2023 19:16:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=FQwzeHmbIM0Euxm6oEsZxszzIMDVVE6jcsQBFWvDU8s=;
 b=C/135k2Y6pKLmmNhUc5Oi9I95FAYMd3ReWtv+Iw86I+TYjRGrNVrN5IAAPi9It5JTSxh
 KYU9O+G9qGCKT6iZ7mN2OZ1g/smeS0rAFubf/+ktNsJUiNm4Okpri3Mbll116v4imJf6
 i40r8GrqDFf9V89PsFQF6UC1ATkh0T4sLC7DX6cfOQ+fZgOmrc4qRL6ABVL5/H+8U1FI
 6r83Ozs3N8l0eq/Sv71BG2XRi7gGEJrQ1F8BqT5CJWp+j4j254sEJYNyIFp33H2+wVPo
 gUuSI9QedoEaYx8vTyXTdVmhjfEFduhLUoNsMcb6Gv+ivUfj7fVNUVi/aIEFEdUw2HOo OA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rg7x3tf9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 19:16:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35SJGLIg016766
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 19:16:21 GMT
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.7; Wed, 28 Jun 2023 12:16:19 -0700
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
To:     <quic_subashab@quicinc.com>, <quic_stranche@quicinc.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <corbet@lwn.net>, <andersson@kernel.org>
CC:     <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: [PATCH] docs: networking: Update codeaurora references for rmnet
Date:   Wed, 28 Jun 2023 13:16:06 -0600
Message-ID: <20230628191606.25483-1-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JdkZxa_cpm4G8N6Qmh1659DTuz0zTIEv
X-Proofpoint-GUID: JdkZxa_cpm4G8N6Qmh1659DTuz0zTIEv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_13,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306280168
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

source.codeaurora.org is no longer accessible and so the reference link
in the documentation is not useful.  The content was mirrored over to
Code Linaro so lets update the references to point there instead.

Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
---
 .../networking/device_drivers/cellular/qualcomm/rmnet.rst     | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst b/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
index 4118384cf8eb..a3d91034ef30 100644
--- a/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
+++ b/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
@@ -191,7 +191,7 @@ MAP header|IP Packet|Optional padding|MAP header|Command Packet|Optional pad...
 ==========================
 
 rmnet userspace configuration is done through netlink library librmnetctl
-and command line utility rmnetcli. Utility is hosted in codeaurora forum git.
+and command line utility rmnetcli. Utility is hosted in Code Linaro git.
 The driver uses rtnl_link_ops for communication.
 
-https://source.codeaurora.org/quic/la/platform/vendor/qcom-opensource/dataservices/tree/rmnetctl
+https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/dataservices/
-- 
2.40.1

