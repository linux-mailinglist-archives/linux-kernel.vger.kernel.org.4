Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC5E740EAD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjF1K1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 06:27:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131]:21908 "EHLO
        mx0a-0031df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231454AbjF1KYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 06:24:47 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35S5hCQO026329;
        Wed, 28 Jun 2023 10:24:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=UCMdUGcNH4Y4v+vkxVyugrhTcuee/Lzy+IzYvZ8/JME=;
 b=RIw6/Cz4SzDPIRVT5ZRQaCb4m+eaL6PojiuK3h76f4V0CqmIDY9HPbw+VZSv6fTrvinX
 ntRwYe1wOQZ+RqBSRZbZDS7ngtsDcq43xpIeKjJoHGZD4vfiIYaZiqclFKhXldFDZcu1
 7Pt8+7Ii2PF1mHqCzQSzjNPtcNBWNCiRLhn3E5ZnpwKW7FofstTuyZ1pcSKUbcvnwCB4
 X8P/zgmQsv/cK0zUGl5R6usIcRq/dbegpkLuUx1ToLiCjXyq4z1G+Vo7wcEY5btlu0BM
 beR+6JibwfuCX3j3VR/ZUdy1V57kBFYMAll6V24H/PDtSlrrZyKWNllrIu40I7Zz532o Pg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgextgn7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 10:24:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35SAOBVW027966
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 10:24:12 GMT
Received: from hu-schowdhu-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.7; Wed, 28 Jun 2023 03:24:07 -0700
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: [PATCH V25 3/3] MAINTAINERS: Add the entry for DCC(Data Capture and Compare) driver support
Date:   Wed, 28 Jun 2023 15:53:32 +0530
Message-ID: <0c67400c5e530dd8c33c85187aa4c1a23efe4853.1687945879.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1687945879.git.quic_schowdhu@quicinc.com>
References: <cover.1687945879.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XrFT7uuCWXQJIxuSLnf478RvFruq9yCa
X-Proofpoint-GUID: XrFT7uuCWXQJIxuSLnf478RvFruq9yCa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 mlxlogscore=776 spamscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the entries for all the files added as a part of driver support for
DCC(Data Capture and Compare).

Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 27ef11624748..4eba5e88c6b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5710,6 +5710,14 @@ W:	http://lists.twibble.org/mailman/listinfo/dc395x/
 F:	Documentation/scsi/dc395x.rst
 F:	drivers/scsi/dc395x.*
 
+DCC QTI DRIVER
+M:	Souradeep Chowdhury <quic_schowdhu@quicinc.com>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	Documentation/ABI/testing/debugfs-driver-dcc
+F:	Documentation/devicetree/bindings/misc/qcom,dcc.yaml
+F:	drivers/misc/qcom-dcc.c
+
 DCCP PROTOCOL
 L:	dccp@vger.kernel.org
 S:	Orphan
-- 
2.17.1

