Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED97A6C0D99
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjCTJp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjCTJp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:45:26 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169271689D;
        Mon, 20 Mar 2023 02:45:25 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32K8O9am030427;
        Mon, 20 Mar 2023 09:45:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=JDuIQbKMao+wWW6Ufi3gVOnNAyYqAbOG9yFVNg7be5Y=;
 b=Yeo8/u9jBE5uCrUZyGt6RqWRcXS1OvONA06TrfeyQcGYuDDYzW3NBQ8TmHGpIeo4AX5m
 2YaC/X2sSWAAtAFQyHvDzEEBmARnLMZ2dX18dbk0wDel+R2HPl7CX0zNzyKcWCh0pR6v
 ZaiQz31jS8Hh5LdY6uJQsSV3K/fjNtCUJXz1HPlF2kNY1KYFODNctt4yJhnblGrGUlnI
 fBLjNMzZw/TQjtt3IFIS5n0ggsxMeHm5aNsLbWUrDH5FbRFnLVzJDiBtsIFMJv/03gvv
 IiKfermdHMpvpuEFFjOPRAe7b7uqUHklH2o3TIUTDIwduTa1TZP/P0IBpUQCa7vJjlbl 2A== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pek4fg9kb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 09:45:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32K9j8xn025415
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 09:45:08 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 20 Mar 2023 02:45:04 -0700
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH 0/2] Add few device nodes for IPQ5332 SoC
Date:   Mon, 20 Mar 2023 15:14:48 +0530
Message-ID: <20230320094450.8015-1-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: viC1bv77-4i7UpfGZG_9bWTSkB2mz4Ud
X-Proofpoint-ORIG-GUID: viC1bv77-4i7UpfGZG_9bWTSkB2mz4Ud
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_06,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxscore=0 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 mlxlogscore=643 suspectscore=0 phishscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303200084
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the support for QUP peripherals, PRNG, WDT for IPQ5332
SoC.

This series depends on the below patch, due to the node ordering
https://lore.kernel.org/linux-arm-msm/20230217083308.12017-6-quic_kathirav@quicinc.com/#t


Kathiravan T (2):
  dt-bindings: watchdog: qcom-wdt: add qcom,apss-wdt-ipq5332 compatible
  arm64: dts: qcom: ipq5332: add few device nodes

 .../bindings/watchdog/qcom-wdt.yaml           |  1 +
 arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts   | 14 ++++
 arch/arm64/boot/dts/qcom/ipq5332.dtsi         | 67 +++++++++++++++++++
 3 files changed, 82 insertions(+)

-- 
2.17.1

