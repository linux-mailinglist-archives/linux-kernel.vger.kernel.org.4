Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25EC68E6C3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 04:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjBHDql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 22:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjBHDqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 22:46:39 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570A93C25;
        Tue,  7 Feb 2023 19:46:38 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3181B7wq027054;
        Wed, 8 Feb 2023 03:46:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=h8V+MS1HBo6xwgF5OKdG/5/JzZdkrKe8hs4S/NjMLN0=;
 b=Z4pm/bLH2zllXwG+im7WcCvv9lKIulKSYRk7Si3ecI5StUP+/GB2/EbXH3ziHgXJbfTJ
 tJz5m8uzMl0Ly3EGhzuv2ldhtpZmU7VntjWcW3zB2oEH2x0u3aZAS6mPneCveQ0KmBSI
 rzgjNs1ofoRp9LS7sVbmYPtIRxZ3rhVysChZw3Mv8Dp8Rk0VxF1xx22WWG5kovwaII/2
 /N3ZNGF9oVdODJQkgd+mXU7qHrHD4minE6XTMEO/kf3kKSfkf34Wfgsg2ZphnzoT9lqQ
 p7ZPwxrfuiVcJK67+yLPvn225D7zzdUtd2FtG4upvQw7c1IKElYUI2E4fqwDcp1NFH/1 hA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nkgafk1he-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 03:46:27 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3183kQ0v022209
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Feb 2023 03:46:26 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 7 Feb 2023 19:46:25 -0800
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
Subject: [PATCH 0/4] arm64: dts: qcom: sc8280xp: Enable external display
Date:   Tue, 7 Feb 2023 19:46:16 -0800
Message-ID: <20230208034620.2048744-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: F8RMydHrw9dJ2Sdt2EQuEw0B4QUjrETq
X-Proofpoint-ORIG-GUID: F8RMydHrw9dJ2Sdt2EQuEw0B4QUjrETq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_15,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 clxscore=1011 bulkscore=0 spamscore=0
 mlxlogscore=726 mlxscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302080032
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

 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     | 191 +++++++++++++++++-
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 191 +++++++++++++++++-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 170 +++++++++++++++-
 arch/arm64/configs/defconfig                  |   2 +
 4 files changed, 546 insertions(+), 8 deletions(-)

-- 
2.39.1

