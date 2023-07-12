Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274D574FE28
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 06:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjGLETv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 00:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjGLETk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 00:19:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E053E77;
        Tue, 11 Jul 2023 21:19:39 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36C3gAUF023501;
        Wed, 12 Jul 2023 04:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=7k1xhVCkwfclCKhQ2y58SznlKWKEGuMf3KXACHqEPDw=;
 b=ZXEhuE1CFUhAmVo/648RNptlf8p97WZU9Xo/L+d2glWo+ta+FDG8CcRKJjg/n6M85o+L
 6ifhGpEpoHGIe9y3+C9kAfnguy1rRkFxlOR79InYNgED1TdEgdd0/UBo4UdJwLBLNGsp
 lxbW+nuRezQvZOPRpPw02/m/GVCHnSt0f/nzMa/cTiMGAGNzMpld7eVRRm+MsSnUbKGQ
 6FCTRjJJ/shD2ay5jYgAmN9uMHU3gTmZbhD5ni2guu5GqOYtVnbyW84HEbBGpmxQhAcC
 DwOYC5ijTQMPS1rttLreytTLIlMWQy//yMzXKlBLqZ16CKRceGO0GeJKGt09IiFG8Y0k cg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rsfeq0gag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 04:19:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36C4JZHP023903
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 04:19:35 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 11 Jul 2023 21:19:32 -0700
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <quic_saahtoma@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH V2 2/2] soc: qcom: socinfo: drop the IPQ5019 SoC ID
Date:   Wed, 12 Jul 2023 09:49:12 +0530
Message-ID: <20230712041912.398724-3-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712041912.398724-1-quic_kathirav@quicinc.com>
References: <20230712041912.398724-1-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BzVFQQhSFH5tx14OWbaUvs9dM2Fo4BmS
X-Proofpoint-GUID: BzVFQQhSFH5tx14OWbaUvs9dM2Fo4BmS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_02,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=812 suspectscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307120037
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ5019 SoC is never productized. So lets drop it.

Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
---
Changes in V2:
	- Updated the commit message with the precise information for
	  dropping this ID

 drivers/soc/qcom/socinfo.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 4d49945b3a35..78293ab13c87 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -406,7 +406,6 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(QRU1000) },
 	{ qcom_board_id(QDU1000) },
 	{ qcom_board_id(QDU1010) },
-	{ qcom_board_id(IPQ5019) },
 	{ qcom_board_id(QRU1032) },
 	{ qcom_board_id(QRU1052) },
 	{ qcom_board_id(QRU1062) },
-- 
2.34.1

