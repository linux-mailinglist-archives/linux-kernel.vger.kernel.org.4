Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E3D67AB75
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 09:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbjAYIOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 03:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234745AbjAYIOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 03:14:42 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378C214238;
        Wed, 25 Jan 2023 00:14:41 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30P823C6024376;
        Wed, 25 Jan 2023 08:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=keL/V4bFVJjqoggiHb3seMd7EdlHsokOIRNrZhWi3n4=;
 b=jOkI/TIpG7rD7usDvSTOYYYNfO/S//pTLv0YOr8Rp8Tdam3BR+JfHEVjyoZ9FUeUbS6G
 ogYq8Eq1MH/Hcy/gEsa0mZDpMGLr3mQ3WrhVba2y5WdzgqirllwsgReIPP6QGMwY3Vpn
 nfTQqzGFpU6KghZ9CtnsxOmiA/gQ/Wyiy+DDN/Z7G7Z7iUP0c0HLkZyeNJlif3iRt6Qq
 R3vyuNdpuLaYHK09rkrJl3DdwpMcCVKdVuvVqSxj5NZul52HEr7axWM00vfJ8GzUQvOe
 xCHjTOXv7Nb32wyOyObvWdQnoRnOjF01dsLr6ThkbSnr1ue8UQ546XMjIf+oKhk4Dl4Q IA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3najqa9bw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 08:14:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30P8EY0D015986
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 08:14:34 GMT
Received: from hu-namajain-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 25 Jan 2023 00:14:31 -0800
From:   Naman Jain <quic_namajain@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        Naman Jain <quic_namajain@quicinc.com>
Subject: [PATCH] soc: qcom: socinfo: Add support for new field in revision 17
Date:   Wed, 25 Jan 2023 13:44:07 +0530
Message-ID: <20230125081407.31833-1-quic_namajain@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ojc2Bmut0we8S9VQ6RJk0mdjzxPaNbwQ
X-Proofpoint-ORIG-GUID: ojc2Bmut0we8S9VQ6RJk0mdjzxPaNbwQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_04,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250075
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for new field coming with socinfo structure under v17 to get
hardware platform's oem variant id. This is to enable OEMs to have minor
changes in the board, but to use the same platform subtype as the one
supported by Qualcomm. The new field is to be used in platform overlay
file. Default value is 0, reserved for Qualcomm platforms. Also, add
debugfs support to read this field for a device.

Change-Id: I18f80084bc75466f3fcccd55fd21b37d69245aa6
---
 drivers/soc/qcom/socinfo.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 10efdbcfdf05..10cdd32ce74d 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -174,6 +174,8 @@ struct socinfo {
 	__le32  pcode;
 	__le32  npartnamemap_offset;
 	__le32  nnum_partname_mapping;
+	/* Version 17 */
+	__le32 oem_variant;
 };
 
 #ifdef CONFIG_DEBUG_FS
@@ -196,6 +198,7 @@ struct socinfo_params {
 	u32 nmodem_supported;
 	u32 feature_code;
 	u32 pcode;
+	u32 oem_variant;
 };
 
 struct smem_image_version {
@@ -519,6 +522,11 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
 			   &qcom_socinfo->info.fmt);
 
 	switch (qcom_socinfo->info.fmt) {
+	case SOCINFO_VERSION(0, 17):
+		qcom_socinfo->info.oem_variant = __le32_to_cpu(info->oem_variant);
+		debugfs_create_u32("oem_variant", 0444, qcom_socinfo->dbg_root,
+				   &qcom_socinfo->info.oem_variant);
+		fallthrough;
 	case SOCINFO_VERSION(0, 16):
 		qcom_socinfo->info.feature_code = __le32_to_cpu(info->feature_code);
 		qcom_socinfo->info.pcode = __le32_to_cpu(info->pcode);
-- 
2.17.1

