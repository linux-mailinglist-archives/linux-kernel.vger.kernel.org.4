Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743D6665291
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 04:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjAKD70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 22:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjAKD7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 22:59:23 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9A312607;
        Tue, 10 Jan 2023 19:59:22 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30B1Ox8R019020;
        Wed, 11 Jan 2023 03:59:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=IWq9y7KfatGVbXL0j6/HvhAAYEguNq4kD+jCx/cWFNg=;
 b=PkHqu1fNy/yRGLRGtWvoiJde+9p38w7OBdFsfRdHQRlyX3kC8urFq4VjVb1JkyRkX4se
 E/UzxMR6+bIJ6oRh2o04Pd7gOb3EFX7negMEqjgFpVXQvzOyVqtqswkoWcGnWXSHWuhA
 m71kY+YZyULWta4R/o0da2Pcadk6h2rIcJWfTOwJ0v/8a0m5YDxHYv5FCgymY7+/Oc9n
 yhlTuaB/Kl0yrhGtmW6M48C4K14utIo5sFNm5ENaJc+ndlBExPPKbn3Qy1jPUsu2uC90
 qp8bs83fWDKdvNqKLPZXysdF47y5qpcWeHMnPnw1eL/ODXDXfSRrgCn5kU4yS3uSxVuN iQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n1kax87qg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 03:59:14 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30B3xD5x013135
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Jan 2023 03:59:13 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 10 Jan 2023 19:59:13 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Johan Hovold <johan@kernel.org>
CC:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v7 0/4] arm64: dts: qcom: sc8280xp: Enable display
Date:   Tue, 10 Jan 2023 19:59:02 -0800
Message-ID: <20230111035906.2975494-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eNZznCzDLs_DubeTKCI67Bxrof-2MoNB
X-Proofpoint-GUID: eNZznCzDLs_DubeTKCI67Bxrof-2MoNB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_10,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 suspectscore=0 mlxlogscore=674 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301110029
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The display subsystem and display port drivers for SC8280XP has been merged, so
they are dropped from this series.

The necessary defconfig update is also added to the series.

Bjorn Andersson (4):
  arm64: dts: qcom: sc8280xp: Define some of the display blocks
  arm64: dts: qcom: sc8280xp-crd: Enable EDP
  arm64: dts: qcom: sa8295-adp: Enable DP instances
  arm64: defconfig: Enable SC8280XP Display Clock Controller

 arch/arm64/boot/dts/qcom/sa8295p-adp.dts  | 243 ++++++-
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts |  73 +-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi    | 811 ++++++++++++++++++++++
 arch/arm64/configs/defconfig              |   1 +
 4 files changed, 1125 insertions(+), 3 deletions(-)

-- 
2.37.3

