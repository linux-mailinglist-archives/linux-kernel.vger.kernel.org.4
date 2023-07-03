Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649DA745EBB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 16:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjGCOmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 10:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjGCOmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:42:50 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA4B10D7;
        Mon,  3 Jul 2023 07:42:41 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363DGb7d014214;
        Mon, 3 Jul 2023 14:42:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=MZdnB0+YVKr0J+qNVmUklG4YkhW78DJg7w3EcyBWxy0=;
 b=cdy1o0J/q8aAMFXrJwexGYZOSzrjaMm3F/3yZX6Yvwoa0CqRMrE2f1Bb+n8XtPYV10y6
 Cxb3McQ9EB+t5yQCo/iGsvti5BM9yOdo3kH/ahwMSQ18WchLXS3aded5CdVNMbPMVN3C
 FaMadGiQju2LoEETvfHTD1N7hMsGYEUBS///RB/Z2EtmDJTynPcEaGxN0aHUJLBRE02L
 5HD7T8dCCYtyewTnDUxJkzLGvJP0kLOhKnDn2yhV2ggWhnoDJT1WCVSOWQEgaskGYdxL
 +cHXYrVO6vn3+5MaSHKNiTANaDCnGLU7PbtKe+CA7B7XGpaGN8Xwh7vku3LdjPtY6RqA hQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rjb5dc9je-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jul 2023 14:42:31 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 363EgSDr031505;
        Mon, 3 Jul 2023 14:42:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3rjd7k8ge9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 03 Jul 2023 14:42:28 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 363EgRgL031491;
        Mon, 3 Jul 2023 14:42:27 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 363EgRvp031478;
        Mon, 03 Jul 2023 14:42:27 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id F39BE5008; Mon,  3 Jul 2023 20:12:26 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        sboyd@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 00/10] Add Power Domains and Regulators in SDX75
Date:   Mon,  3 Jul 2023 20:12:16 +0530
Message-Id: <1688395346-3126-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EuYxm1tG7z7m0Ylh_Ta08J2TEPNZh-jB
X-Proofpoint-GUID: EuYxm1tG7z7m0Ylh_Ta08J2TEPNZh-jB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_11,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 mlxlogscore=683 spamscore=0
 clxscore=1011 mlxscore=0 adultscore=0 phishscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030132
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds driver and dt-bindings related changes
in SDX75 to add power domains and regulators.

Thanks,
Rohit.

Rohit Agarwal (10):
  dt-bindings: regulator: Add PMX75 compatibles
  dt-bindings: power: Add rpm power domains for SDX75
  dt-bindings: mfd: Add compatible for pm7550ba
  dt-bindings: pinctrl: qcom-pmic-gpio: Add pm7550ba support
  dt-bindings: mfd: Add compatible for pmx75
  dt-bindings: pinctrl: qcom-pmic-gpio: Add pmx75 support
  soc: qcom: rpmhpd: Add SDX75 power domains
  regulator: qcom-rpmh: Add support for SDX75
  pinctrl: qcom-pmic-gpio: Add support for pm7550ba
  pinctrl: qcom-pmic-gpio: Add support for pmx75

 .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |  2 ++
 .../bindings/pinctrl/qcom,pmic-gpio.yaml           |  6 ++++
 .../devicetree/bindings/power/qcom,rpmpd.yaml      |  1 +
 .../bindings/regulator/qcom,rpmh-regulator.yaml    |  2 ++
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c           |  2 ++
 drivers/regulator/qcom-rpmh-regulator.c            | 38 ++++++++++++++++++++++
 drivers/soc/qcom/rpmhpd.c                          | 16 +++++++++
 include/dt-bindings/power/qcom-rpmpd.h             |  8 +++++
 8 files changed, 75 insertions(+)

-- 
2.7.4

