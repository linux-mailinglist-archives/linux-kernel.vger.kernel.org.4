Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409FE653DA0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 10:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbiLVJn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 04:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbiLVJnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 04:43:23 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC5127B0D;
        Thu, 22 Dec 2022 01:43:21 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BM9VDUL028348;
        Thu, 22 Dec 2022 09:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=ZA9aiMuDfTe57weeO8ZbbwCNHKGLW6mCJATAj6eTStc=;
 b=X8RN/KWGcaGCwZvqFbeXhjjKbneL9X6KjO9v9AHvLk/43r6Iv0dx9wqrXQRBnk9gYYYM
 Dp1dae0ELq0TAbwC9gZwPIfU71DT2MUO2uDcWH1TcjfnDgScdzYw48xY1yLMW/rIsQVu
 wkHM98ZX5ThbBy8w9WDybDVFuvVMyla3dnOYQFBqvbqi0aMv82I5VQGGmTvrMycawro9
 b7J+v28zWlWokDtMq703D1WYcImF6eBOA98ztAiQZlyqKvRF1qubhW5iPcXo3ANCkxtM
 i3/YIIDtrSTuvBmKslhY9sAVduoLZ/o0iJdunUJkbs2nY5eEHM0irx1qRIju9GTcfDED kQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mm8x4hcck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Dec 2022 09:43:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BM9hGaD008468
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Dec 2022 09:43:16 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 22 Dec 2022 01:43:12 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_rohkumar@quicinc.com>,
        <srinivas.kandagatla@linaro.org>, <dianders@chromium.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <konrad.dybcio@linaro.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH 0/7] Add SC7280 audioreach device tree nodes.
Date:   Thu, 22 Dec 2022 15:12:43 +0530
Message-ID: <1671702170-24781-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: --KfMHHyZ7yser72wwwSOVXoBYKQh4Ry
X-Proofpoint-ORIG-GUID: --KfMHHyZ7yser72wwwSOVXoBYKQh4Ry
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-22_03,2022-12-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=814 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212220085
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SC7280 audioreach device tree nodes and extract audio specific
dtsi nodes and add them in new file.

Srinivasa Rao Mandadapu (7):
  arm64: dts: qcom: sc7280: Extract audio nodes from common idp dtsi
    file
  arm64: dts: qcom: sc7280: audioreach: Add sound node
  arm64: dts: qcom: sc7280: audioreach: Add lpass pil node
  arm64: dts: qcom: sc7280: audioreach: Update lpasscc reg property
  arm64: dts: qcom: sc7280: audioreach: Add CGCR reset property
  arm64: dts: qcom: sc7280: audioreach: Update VA/RX/TX macro clock
    nodes
  arm64: dts: qcom: sc7280: audioreach: Disable legacy path clock nodes

 arch/arm64/boot/dts/qcom/sc7280-audio-idp.dtsi     | 242 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts         |  24 +-
 .../qcom/sc7280-herobrine-audioreach-wcd9385.dtsi  | 283 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi           | 230 -----------------
 arch/arm64/boot/dts/qcom/sc7280-idp2.dts           |   1 +
 5 files changed, 527 insertions(+), 253 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-audio-idp.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-audioreach-wcd9385.dtsi

-- 
2.7.4

