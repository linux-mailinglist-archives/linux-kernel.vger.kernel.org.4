Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147FF73F91A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjF0Jvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjF0Ju4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:50:56 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C9B2691;
        Tue, 27 Jun 2023 02:50:53 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35R9I5Ts021331;
        Tue, 27 Jun 2023 09:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=UCMdUGcNH4Y4v+vkxVyugrhTcuee/Lzy+IzYvZ8/JME=;
 b=C1NVtt4LkxT6ULVshTl675TkU8OujXNA91+5x6/r6f+I5jNi63zsHXRymjoPEYpiAx5C
 561/0P195PXl2JASPQ7Sk4O2jBW+MFJX6zOjYJHILnTC/OdHxlLRa5dCej5wKluECeQT
 8vouvBBpu0799uhY/jj9hu/IkA02kjKbO7hkMgoxaZFNpFPYPtPIOOuDrGE/DccEDXJL
 coaHx3hrOem9FOghERyBj7BQ29rH99NkBkNvx+Y0TP6prk1BZIvvtUO1ignm+ZOd4wQS
 wRQuUkYlBQ5OfbSrLaGKNTX8LuCZH/T8ybCoONiSPgcBFr3BgegMJ68a8ZnQKEI6CfOP pw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rf8gtjkma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jun 2023 09:50:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35R9oTEd028187
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jun 2023 09:50:29 GMT
Received: from hu-schowdhu-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 27 Jun 2023 02:50:24 -0700
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
Subject: [PATCH V24 3/3] MAINTAINERS: Add the entry for DCC(Data Capture and Compare) driver support
Date:   Tue, 27 Jun 2023 15:19:26 +0530
Message-ID: <1125de60c070ac1d826e88650a5b40d91c3c4566.1687855361.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1687855361.git.quic_schowdhu@quicinc.com>
References: <cover.1687855361.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WTnUw3S3nWvxgA8hLMOQe8536inY5hu2
X-Proofpoint-ORIG-GUID: WTnUw3S3nWvxgA8hLMOQe8536inY5hu2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_05,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=775 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306270092
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

