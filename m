Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3E2749849
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 11:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjGFJYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 05:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjGFJYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 05:24:34 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B727B1FEB;
        Thu,  6 Jul 2023 02:24:10 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366883hk016922;
        Thu, 6 Jul 2023 09:23:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=+ddTAqEFapc95RWWRsn5/YwUtcuwKZezMY2an+oncbQ=;
 b=kItYJSawY2/ceclaKRgUtbOV5yA7Aeqe5lm3wmbYEr+YNSzcROeTrQ83F8F9jZ2L9ohf
 3fI4KmgEpk50EaxLEeq3UDmijqIDrjk/i8RhPWXscTK34jmMp+wrP4zlmRLrNCW7HcYi
 eORlef9N+uJudHhD+L5Rdq4vuG96aGGlo2LIaPxR+UvyhGsUg56bbYDxN0ReyvK0zmyL
 UIjZSfcZDMec809gdJFW/9jbfyt3GnEl+dEmiznCKGStSkHXUXXyjYktgiZyL/xhib46
 CeirsfhUVQgai7ZezoJTIbm50RrxBD4zxyMHGTGTrshgt01pzPP/mrJfyXYQNTlyRX8I KQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rnsu704ac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 09:23:54 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3669NoaC019299;
        Thu, 6 Jul 2023 09:23:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3rjd7ky1d7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 06 Jul 2023 09:23:50 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3669NoNq019290;
        Thu, 6 Jul 2023 09:23:50 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3669NnjS019289;
        Thu, 06 Jul 2023 09:23:50 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 34F6F5FCC; Thu,  6 Jul 2023 14:53:49 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 0/2] Update PD Macros
Date:   Thu,  6 Jul 2023 14:53:46 +0530
Message-Id: <1688635428-25127-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: J-sj5WuNxCaHJC1g4kIfxLfinko_5hNT
X-Proofpoint-ORIG-GUID: J-sj5WuNxCaHJC1g4kIfxLfinko_5hNT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_06,2023-07-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=260
 adultscore=0 bulkscore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307060082
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series updates the PD macros for the Qualcomm chipsets
in the devicetree files based on [1].

[1] https://lore.kernel.org/all/1688635218-23779-1-git-send-email-quic_rohiagar@quicinc.com/

Thanks,
Rohit.

Rohit Agarwal (2):
  ARM: dts: qcom: Update the PD macros in dts
  arm64: dts: qcom: Update the PD macros in dts

 arch/arm/boot/dts/qcom/qcom-msm8226.dtsi     |   2 +-
 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi       |   6 +-
 arch/arm/boot/dts/qcom/qcom-sdx65.dtsi       |   6 +-
 arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi |   4 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi        |   8 +-
 arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi |   6 +-
 arch/arm64/boot/dts/qcom/msm8939.dtsi        |   8 +-
 arch/arm64/boot/dts/qcom/msm8953.dtsi        |  16 +--
 arch/arm64/boot/dts/qcom/msm8996.dtsi        |   8 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi        |  10 +-
 arch/arm64/boot/dts/qcom/qcm2290.dtsi        |  10 +-
 arch/arm64/boot/dts/qcom/qdu1000.dtsi        |   2 +-
 arch/arm64/boot/dts/qcom/sa8155p.dtsi        |  12 +--
 arch/arm64/boot/dts/qcom/sa8775p.dtsi        |  94 ++++++++---------
 arch/arm64/boot/dts/qcom/sc7180.dtsi         |  88 ++++++++--------
 arch/arm64/boot/dts/qcom/sc7280.dtsi         | 126 +++++++++++-----------
 arch/arm64/boot/dts/qcom/sc8180x.dtsi        |  22 ++--
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi       | 150 +++++++++++++--------------
 arch/arm64/boot/dts/qcom/sdm630.dtsi         |  12 +--
 arch/arm64/boot/dts/qcom/sdm660.dtsi         |   2 +-
 arch/arm64/boot/dts/qcom/sdm670.dtsi         |  34 +++---
 arch/arm64/boot/dts/qcom/sdm845.dtsi         |  88 ++++++++--------
 arch/arm64/boot/dts/qcom/sm6115.dtsi         |  14 +--
 arch/arm64/boot/dts/qcom/sm6125.dtsi         |   4 +-
 arch/arm64/boot/dts/qcom/sm6350.dtsi         |  18 ++--
 arch/arm64/boot/dts/qcom/sm6375.dtsi         |  28 ++---
 arch/arm64/boot/dts/qcom/sm8150.dtsi         |  20 ++--
 arch/arm64/boot/dts/qcom/sm8250.dtsi         |  76 +++++++-------
 arch/arm64/boot/dts/qcom/sm8350.dtsi         |  74 ++++++-------
 arch/arm64/boot/dts/qcom/sm8450.dtsi         |  36 +++----
 arch/arm64/boot/dts/qcom/sm8550.dtsi         |  28 ++---
 31 files changed, 506 insertions(+), 506 deletions(-)

-- 
2.7.4

