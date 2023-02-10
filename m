Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FB869183D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 07:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjBJGE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 01:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjBJGEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 01:04:25 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B729774317;
        Thu,  9 Feb 2023 22:04:24 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31A3aLcs032297;
        Fri, 10 Feb 2023 06:04:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=gDA2MQFXb60qZy6HEjn2cwH4rNVoFK6GgR2aLIiKKTQ=;
 b=OreSFFCBdQjKy6eHS+uH6vMYLCRlafIVtm0JsKK77OrnygVrcDfAsnZKHw7zCQsJHnFv
 tNnYVrXGlwrxTP++K6+wwGGca+eb6YztiZMn3w1a1Ywirxux6r6H5ekNwGx6c9dEJO8x
 36xH7RvEpSrVwPnTTEZwTvlGp+w1PUSUkSueIvWQRPSZ6te1K9dJt6RnaKRbJQ3tPxuq
 FP8XcBSwBX5WqHsiNZBAugfUkP1H1WRZxT9hxEMA9PusncXQKSaFrzV3zZUhXbTUHgny
 DkQMrf4UfGveNNuTAdXMwDtV80lMX7tW5LMAlg7OQzh8pKy/ihZ7GWHenRbbFHjy7WYB 2Q== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nmww6tgdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 06:04:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31A64J2V005752
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 06:04:19 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 9 Feb 2023 22:04:15 -0800
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>, <quic_srichara@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH V2 0/2] Add the download mode support for IPQ5332
Date:   Fri, 10 Feb 2023 11:33:59 +0530
Message-ID: <20230210060401.24383-1-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0pIjTi5apczT4EIRozi3lSa405n6yCj8
X-Proofpoint-ORIG-GUID: 0pIjTi5apczT4EIRozi3lSa405n6yCj8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_01,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0 mlxlogscore=329
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100052
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the support for download mode to collect the RAM dumps if
system crashes, to perform the post mortem analysis.

During the bootup, bootloaders initialize the SMEM. However the bootup
after crash, SMEM will not be initialized again. If the memory for the
SMEM is not reserved, linux consumes that region, which leads to the
loss of SMEM data. So, during the next bootup after crash, bootloaders
will hang due to invalid data present in the SMEM region. Due to this,
added the SMEM support along with this series.

This series depends on the IPQ5332 baseport patches
https://lore.kernel.org/linux-arm-msm/20230208155232.11500-1-quic_kathirav@quicinc.com/

Changes in V2:
	- Dropped the qcom,tcsr binding patch, since it is part of
	  linux-next/master

Kathiravan T (2):
  arm64: dts: qcom: ipq5332: enable the download mode support
  arm64: dts: qcom: ipq5332: add SMEM support

 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

-- 
2.17.1

