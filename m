Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E236F68FC85
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 02:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjBIBPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 20:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjBIBO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 20:14:59 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99743A9B;
        Wed,  8 Feb 2023 17:14:58 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31916pxr007136;
        Thu, 9 Feb 2023 01:14:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=5HkVoBso17Q0ZfNSQwDCMkp3fIKK2V/U+HZqxQK0ws8=;
 b=pDQ3SCAZMuuW3fpocltk9dmbn+n+YtO+cDbIcEqAxhKyQMpYqTzRg0ZeYgx9CTPsCieC
 oL++as1glMHJ4lJbBs4Ovpqj/Tn2ah2t7ygLu9yiV4mXJIj8ruCgWgHllZpNeB/VkTZv
 TTkyUwfMDmlIAZvTOePZEMBMTPiYw09U0nya2Yhnqw2X5QrjyQCYZPh0m787OcFSEYms
 70rdo0LBGGLwPufsVsnQZS/dq6ZX2XJTa8exaLQEdLzbNSezW6baoVopecnUsz3J8JaG
 lLLr6akWFPyPfih3j7vO4lyhrBlyJ9R1nxU0CKI/kvm2CDnDzyTzi8f3qNbxMOy3DchM Sw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nmjfprhwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 01:14:46 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3191Ei1U015201
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Feb 2023 01:14:45 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 8 Feb 2023 17:13:31 -0800
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
Subject: [PATCH v2 0/4] arm64: dts: qcom: sc8280xp: Enable external display
Date:   Wed, 8 Feb 2023 17:13:21 -0800
Message-ID: <20230209011325.2603663-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YN1IbNYIf7mKksoKIf58T9WrWABJyGm0
X-Proofpoint-GUID: YN1IbNYIf7mKksoKIf58T9WrWABJyGm0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_11,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 mlxlogscore=726 bulkscore=0 suspectscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302090010
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     | 200 +++++++++++++++++-
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 188 +++++++++++++++-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 179 +++++++++++++++-
 arch/arm64/configs/defconfig                  |   2 +
 4 files changed, 561 insertions(+), 8 deletions(-)

-- 
2.25.1

