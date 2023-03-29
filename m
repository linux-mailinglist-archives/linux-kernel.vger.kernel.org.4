Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587AF6CD1B6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 07:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjC2FiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 01:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjC2FiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 01:38:09 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48400107;
        Tue, 28 Mar 2023 22:38:03 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32T3TC8p025806;
        Wed, 29 Mar 2023 05:37:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=d4fdF3BZtPLjU8XFgyLiilyqhaZsSMcYoJkj/8bWDt8=;
 b=G0+aanufiL8xSc+OyhqHAKK8dxrDZnBHw/fQsn5bLu4e0d2gpsMMrDO8LZobjro+K9oB
 hcgsCY+lTHq4Vuh0hKS//JbceoZVq6L2Bq/UFLmKsasws/1uCKBELvS4Ql56lhe9Knsi
 2Qkoo5FZvkdsMZCfSlFqohW4sDOONKqd0BPkH11FLpFqsd18hvi0SZb8Z0+rJB/xm9ci
 gVbtfTkeRzQIbvAJrrOqFB18JDuFuDHNhc7bFjdJJsmZcNjztH16TBrYp4zHICIjfeYb
 k7ZCathTIWtxBSu0nax0qBvJXURdHSqP6G50CGmzuHW/ifDLnPJeP3I/Y4PRZGweqxym cA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pky702dsn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 05:37:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32T5biHE011929
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 05:37:44 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 28 Mar 2023 22:37:40 -0700
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH 0/2] Add few device nodes for IPQ9574 SoC
Date:   Wed, 29 Mar 2023 11:07:24 +0530
Message-ID: <20230329053726.14860-1-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EcgnSPWvgmPFiVDGgP2nvqVRR1IIjHoZ
X-Proofpoint-GUID: EcgnSPWvgmPFiVDGgP2nvqVRR1IIjHoZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=763 priorityscore=1501 spamscore=0
 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303290044
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the support for QUP peripherals, PRNG, WDT for IPQ9574
SoC.

This series depends on the below one
https://lore.kernel.org/linux-arm-msm/20230328102013.21361-2-quic_poovendh@quicinc.com/

Kathiravan T (2):
  dt-bindings: watchdog: qcom-wdt: add qcom,apss-wdt-ipq9574 compatible
  arm64: dts: qcom: ipq9574: add few device nodes

 .../bindings/watchdog/qcom-wdt.yaml           |   1 +
 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts   |  21 ++
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 202 ++++++++++++++++++
 3 files changed, 224 insertions(+)

-- 
2.17.1

