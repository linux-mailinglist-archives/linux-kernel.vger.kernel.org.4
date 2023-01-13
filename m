Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3605669B98
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjAMPN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjAMPNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:13:21 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534C3DF4B;
        Fri, 13 Jan 2023 07:03:36 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DD2YD8009953;
        Fri, 13 Jan 2023 15:03:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=hUDF0wtTXoGC0u8E8pYAlz/i5+80rim9nx2laYrtKA0=;
 b=YLubSubeTp7NZ3tM8d2FjJ71v9eINUAt1UZqpSpLBtJb1qTI6+V4BkqrqDxRJwas0Mii
 IpX88hYrj2xYBB9Vdp721iIdaL7TPAFXzZnHc6riltaNanf/uFG+UWoj3/LpLfNoBIRr
 wBqwNpiS4LZKfdiM7POo48brVu8VI2zGAW1xwDqGaKtYeUiX9irO3MIauBdVgvJSYn2z
 pdGIBhT/ltGnAKaFXTzG4azbZXGcExq5aCYXHJyNEfXVqb7dW0SDQizJxfqRsvUhscri
 ntJygEjNj8ymFE4YjqpGVvYIEcMTGFOO6R2wsb6uxyFBf4sEmtNWyDcSYDh+rFsa3Wy1 IA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n32wu98cq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 15:03:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30DF3VXC025433
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 15:03:31 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 13 Jan 2023 07:03:26 -0800
From:   devi priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
Subject: [PATCH 0/6] Add regulator support for IPQ9574 SoC
Date:   Fri, 13 Jan 2023 20:33:04 +0530
Message-ID: <20230113150310.29709-1-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GKDD1FDfc07vVMo0jJ37Dqpl-J7NS08f
X-Proofpoint-ORIG-GUID: GKDD1FDfc07vVMo0jJ37Dqpl-J7NS08f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_07,2023-01-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxlogscore=684 spamscore=0 clxscore=1011 lowpriorityscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130099
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ9574 SoC uses the PMIC MP5496 and SMPA1 regulator is used for
APSS voltage scaling.
This patch series adds the support for the same.
Also enables the RPM communication over the RPMSG framework

This series depends on the below patchset
https://lore.kernel.org/linux-arm-msm/20230113143647.14961-1-quic_devipriy@quicinc.com/

devi priya (6):
  soc: qcom: smd-rpm: Add IPQ9574 compatible
  dt-bindings: soc: qcom: smd-rpm: Add IPQ9574 compatible string
  regulator: qcom_smd: Add MP5496 regulators
  regulator: qcom_smd: Add PMIC compatible for IPQ9574
  arm64: dts: qcom: ipq9574: Add cpufreq & RPM related nodes
  regulator: qcom_smd: Add support to define the bootup voltage

 .../regulator/qcom,smd-rpm-regulator.yaml     |  3 +-
 .../bindings/soc/qcom/qcom,smd-rpm.yaml       |  1 +
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 80 +++++++++++++++++++
 drivers/regulator/qcom_smd-regulator.c        | 20 +++++
 drivers/soc/qcom/smd-rpm.c                    |  1 +
 5 files changed, 104 insertions(+), 1 deletion(-)


base-commit: 1fe4fd6f5cad346e598593af36caeadc4f5d4fa9
-- 
2.17.1

