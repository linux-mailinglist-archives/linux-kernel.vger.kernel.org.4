Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C06169537D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjBMV4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjBMV4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:56:40 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEDB13D47;
        Mon, 13 Feb 2023 13:56:39 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DKKK1k021245;
        Mon, 13 Feb 2023 21:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=1d9Z7CMTqAWcpWGEO13jJID68YgM2T15rUVTC/xGtAc=;
 b=dj1i95v/l7BrcyHc+5GhA04GrukM9Pix4guIXcnHYn829m2azjfj7Y1bWgLHURrZs5Rc
 KoSdHYVFEaF+zmp6VsL1JCx8LS+poQbGTQot0sbaFigfrE9+ajRZX7Jfq+sL6sKS1LY/
 HSpYe339dKqT0pKv2wLM+b+OAzMs/qHIpL6sK4ws3PWCS4t7MZcxRg4iIiKbHNfrWSf0
 5s0fItUvv5gUhXa1Ee/za+tP0ewxmKCk75cWfppjsSmBq2BgpjMl3FasE3pUqihRjEXD
 OD3apq4mM04sSDbs5EGXuM3rhhjXla6YGu2xbtFHsxXrmwKrvRYqcxIpWq7xofA2Hm/4 jA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3npmvrkyrn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 21:56:26 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31DLuPW2022452
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 21:56:25 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 13 Feb 2023 13:56:25 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 0/4] arm64: dts: qcom: sc8280xp: Enable external display
Date:   Mon, 13 Feb 2023 13:56:15 -0800
Message-ID: <20230213215619.1362566-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _yuFjEL3FgZIVlpQn2W5bX80HqW12SaV
X-Proofpoint-GUID: _yuFjEL3FgZIVlpQn2W5bX80HqW12SaV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_12,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxscore=0 impostorscore=0 mlxlogscore=726 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130190
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces support for external display on the SC8280XP laptops.

Support for swapping orientation and changing the mode of the SuperSpeed
lanes is being implemented in the QMP driver, so at this point in time
this is not supported.

Bjorn Andersson (4):
  arm64: dts: qcom: sc8280xp: Add USB-C-related DP blocks
  arm64: dts: qcom: sc8280xp-crd: Introduce pmic_glink
  arm64: dts: qcom: sc8280xp-x13s: Enable external display
  arm64: defconfig: Enable DisplayPort on SC8280XP laptops

 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     | 196 +++++++++++++++++-
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 180 +++++++++++++++-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 189 ++++++++++++++++-
 arch/arm64/configs/defconfig                  |   2 +
 4 files changed, 559 insertions(+), 8 deletions(-)

-- 
2.25.1

