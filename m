Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D40B69ADDD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 15:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjBQOU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 09:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjBQOUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:20:55 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E90F72B5;
        Fri, 17 Feb 2023 06:20:54 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HDMGgI015952;
        Fri, 17 Feb 2023 14:20:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=W/tQeIpwvzd9QOgomberBEe1ciHC7wdOwg2XVRmVD70=;
 b=PRJNMgq/wJI3yBMtN+p4UhtRp3w6fyMHmAWI8fIdSfKRxdTWt8fGXb8OfxiiFgYF2JEB
 Lk45Gnej0jcH02ZlV0OY1hziziqFjPTar19EePhbrl98nDp3/a3+DWN/GfgnLeVfgdDY
 SzrjOf9stX1ARloM/+dKlZcfRGeybztpISGEjzOkcUyLXML8XZB1EwcFpGlLqd0vyQXn
 FLcq0a15JSU4RAKB0qjaR1J2xdWe5Kg2GAppcvE3sLpVFtUdtI3LE9WAZ2cbl0pgvW/9
 89rm9uPgN5B2TlBB1zqtix2BnGDyWXxHeghGq1XxcCSC4dSqk/DkPoOT0xG0UsG4+uYq Ng== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nshe5m0ch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 14:20:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31HEKnEI019681
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 14:20:49 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 17 Feb 2023 06:20:43 -0800
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_ipkumar@quicinc.com>
Subject: [PATCH V2 0/6] Add regulator support for IPQ9574 SoC
Date:   Fri, 17 Feb 2023 19:50:24 +0530
Message-ID: <20230217142030.16012-1-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vYDtS8EUuErJD8I1oJVrp4Ao3PrByRHP
X-Proofpoint-ORIG-GUID: vYDtS8EUuErJD8I1oJVrp4Ao3PrByRHP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_08,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0
 mlxlogscore=552 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302170128
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ9574 SoC uses the PMIC MP5496 and SMPA1 regulator for
APSS voltage scaling.
This patch series adds the support for the same and also
enables the RPM communication over the RPMSG framework

DTS patch depends on the below series
https://lore.kernel.org/linux-arm-kernel/20230217134107.13946-1-quic_devipriy@quicinc.com/

[V2]:
	- Reordered the patches to have the bindings and driver changes
	  in place before the device tree support
	- Dropped the 'soc: qcom: smd-rpm: Add IPQ9574 compatible' since
	  it is already part of the linux-next/master
	- Detailed change log is added to the respective patches
[V1]:
	https://lore.kernel.org/linux-arm-msm/20230113150310.29709-1-quic_devipriy@quicinc.com/

Devi Priya (6):
  dt-bindings: soc: qcom: smd-rpm: Add IPQ9574 compatible
  regulator: qcom_smd: Add s1 sub-node to mp5496 regulator
  regulator: qcom_smd: Add MP5496 S1 regulator
  regulator: qcom_smd: Add support to define the bootup voltage
  arm64: dts: qcom: ipq9574: Add RPM related nodes
  arm64: dts: qcom: ipq9574: Add cpufreq support

 .../regulator/qcom,smd-rpm-regulator.yaml     |  2 +-
 .../bindings/soc/qcom/qcom,smd-rpm.yaml       |  1 +
 arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts  | 11 +++
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 75 +++++++++++++++++++
 drivers/regulator/qcom_smd-regulator.c        | 18 ++++-
 5 files changed, 104 insertions(+), 3 deletions(-)


base-commit: c068f40300a0eaa34f7105d137a5560b86951aa9
-- 
2.17.1

