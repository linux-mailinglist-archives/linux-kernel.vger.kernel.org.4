Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A411C749CB3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjGFMwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjGFMwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:52:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755621FC3;
        Thu,  6 Jul 2023 05:52:12 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366BqHia017619;
        Thu, 6 Jul 2023 12:51:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=rl4qgmzdzUpkt+gryXJrNNSFG+X/Mq/aKu6DBvXjUkU=;
 b=c/6AR+eHnXpcVS41pczBkj/SrRW6lajvEjotkhscw/JLmceKVqm8WNIFGKm5OUeC8OXC
 BiF2qD8BmrhPW/NAjYkWQQ4O7t3P3S+2FxL7rlB/m7WJ3YncNf0Nl0oYgB/7TBDiNkN4
 o90kLRl+FXcUKzKmRSx45F6bZB+qM2IUGqVM9hfPw1JSHeZFrywvQ8y7+mPWY3r2X19I
 pRouJ5O5gkX5k1EexxcPOy8UqR7um34okpBuZjxbFOtZe9K9FejV0euRrSpOL+XgwLma
 QYzJtLVsyQEjQ/TjhYgQWPOgFgHqhi67hrCNw0OA1BVKvcnMvy3TFDbdfENZt2iutFCs fg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rnvaa8650-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 12:51:57 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 366Cpuqs003181
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Jul 2023 12:51:56 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 6 Jul 2023 05:51:53 -0700
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>
Subject: [PATCH v3 0/2] arm64: dts: qcom: qdu1000: Update reserved memory region
Date:   Thu, 6 Jul 2023 18:21:27 +0530
Message-ID: <20230706125129.20969-1-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3dD9ntr0FQQ61j5HwbE9lkjfG27AHCCO
X-Proofpoint-ORIG-GUID: 3dD9ntr0FQQ61j5HwbE9lkjfG27AHCCO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_09,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=412 impostorscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060115
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update reserved memory region for QDU1000 and QRU1000 SoCs.

Changes in v3:
 - Changes the node name as names should reflect the purpose of node.

Changes in v2:
 - Changed the node name.
 - Dropped unnecessary properties.

Komal Bajaj (2):
  arm64: dts: qcom: qdu1000-idp: Update reserved memory region
  arm64: dts: qcom: qru1000-idp: Update reserved memory region

 arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 22 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/qru1000-idp.dts | 12 ++++++++++++
 2 files changed, 34 insertions(+)

-- 
2.40.1

