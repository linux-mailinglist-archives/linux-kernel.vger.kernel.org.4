Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204EE6D52CB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 22:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbjDCUpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 16:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbjDCUpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 16:45:14 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E063C3AB3;
        Mon,  3 Apr 2023 13:45:12 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333IQF4D019177;
        Mon, 3 Apr 2023 20:45:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=kKc+yK5bWzVEGmx6JnZYaj30iKE7spko3/F4IKf9Vsw=;
 b=hFDbilA6pTxckQcHf1HiaSKtYvw0ta0q7wPYpm7umptBfDsZ8Q70xGwQ5snxMwBGbi+T
 sac//30lY8ab7eFFOsoTvvEOmkuZ84xnzQ5+T7BtKXsxDEXqEw7sUdWhkv3OyQw1jbgC
 0ZDTySr0VaeSFXkMeCB+n4bdf2oihWETRA62ojIdlhUaIrISO+tLMow0Awa/RQiHHPuE
 ZI8QHYlBwHleXCI7/dmvhpe56bUaW0e/YCSKhh4UipdIM8ir2x9B896W/1DNm/raxMwc
 G+vrP3tRqo15rYNMYDPCEelIVcpGnUStEZXL4fvE7eoc9hb9rM0XL6+SS0RKM4SjJRk4 iw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pquwwskfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 20:45:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 333Kj7wk026309
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Apr 2023 20:45:07 GMT
Received: from hu-gokukris-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 3 Apr 2023 13:45:07 -0700
From:   Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Satya Durga Srinivasu Prabhala" <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        "Guru Das Srinagesh" <quic_gurus@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
Subject: [PATCH v3 1/1] dt-bindings: firmware: qcom: scm: Updating VMID list
Date:   Mon, 3 Apr 2023 13:44:55 -0700
Message-ID: <20230403204455.6758-1-quic_gokukris@quicinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vX7GDrKuvXcSi_o5XBSoiouS0MS1Es9S
X-Proofpoint-GUID: vX7GDrKuvXcSi_o5XBSoiouS0MS1Es9S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_15,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 mlxscore=0 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=729
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304030161
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding the full list of VMID's, which are used by different clients to
pass to the secure world.

Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
---
V3 Fixed comments from V2

V2 Fixed allignment issues in [1]

[1] https://lore.kernel.org/lkml/20230328214703.12093-1-quic_gokukris@quicinc.com/

---
 include/dt-bindings/firmware/qcom,scm.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/dt-bindings/firmware/qcom,scm.h b/include/dt-bindings/firmware/qcom,scm.h
index 1a4e68fa0744..301005b7a02d 100644
--- a/include/dt-bindings/firmware/qcom,scm.h
+++ b/include/dt-bindings/firmware/qcom,scm.h
@@ -2,15 +2,36 @@
 /*
  * Copyright (c) 2010-2015, 2018-2019 The Linux Foundation. All rights reserved.
  * Copyright (C) 2015 Linaro Ltd.
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef _DT_BINDINGS_FIRMWARE_QCOM_SCM_H
 #define _DT_BINDINGS_FIRMWARE_QCOM_SCM_H
 
+#define QCOM_SCM_VMID_TZ		0x1
 #define QCOM_SCM_VMID_HLOS		0x3
+#define QCOM_SCM_VMID_CP_TOUCH		0x8
+#define QCOM_SCM_VMID_CP_BITSTREAM	0x9
+#define QCOM_SCM_VMID_CP_PIXEL		0xA
+#define QCOM_SCM_VMID_CP_NON_PIXEL	0xB
+#define QCOM_SCM_VMID_CP_CAMERA	0xD
+#define QCOM_SCM_VMID_HLOS_FREE	0xE
 #define QCOM_SCM_VMID_MSS_MSA		0xF
+#define QCOM_SCM_VMID_MSS_NONMSA	0x10
+#define QCOM_SCM_VMID_CP_SEC_DISPLAY	0x11
+#define QCOM_SCM_VMID_CP_APP		0x12
+#define QCOM_SCM_VMID_LPASS		0x16
 #define QCOM_SCM_VMID_WLAN		0x18
 #define QCOM_SCM_VMID_WLAN_CE		0x19
+#define QCOM_SCM_VMID_CP_SPSS_SP	0x1A
+#define QCOM_SCM_VMID_CP_CAMERA_PREVIEW 0x1D
+#define QCOM_SCM_VMID_CDSP		0x1E
+#define QCOM_SCM_VMID_CP_SPSS_SP_SHARED 0x22
+#define QCOM_SCM_VMID_CP_SPSS_HLOS_SHARED 0x24
+#define QCOM_SCM_VMID_ADSP_HEAP	0x25
+#define QCOM_SCM_VMID_CP_CDSP		0x2A
 #define QCOM_SCM_VMID_NAV		0x2B
+#define QCOM_SCM_VMID_TVM		0x2D
+#define QCOM_SCM_VMID_OEMVM		0x31
 
 #endif
-- 
2.39.2

