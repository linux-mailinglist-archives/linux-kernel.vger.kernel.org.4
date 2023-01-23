Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303CF6778D1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 11:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjAWKOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 05:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjAWKOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 05:14:17 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE4FEB61;
        Mon, 23 Jan 2023 02:13:52 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30N7AcHS011874;
        Mon, 23 Jan 2023 10:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=Pz/uSWU8RRFgeloSr/VELxSNKiGWuMyh4YQShX3kEss=;
 b=OK6LpETJHUTAl333CR4DGkCkZgR/8W7M7nyKK/zhItKrKfqVmF3uAOGlSqoyZpUc3/6Y
 4HpqpAjzzxH9qMHB0kSJ01DuEEvkeBsf+mkINu6eQuE9SX7qZtY6NNYjcUEtyPeTBmaz
 AAErCXd5/Ybj3ab8fKw3bO+EFAeToGqensCbJdvjw4yCaz3TIX1D+zxPRFFKQYbAOzt9
 Sl45QE0V49ZXwCbfON4s9yMDh8zlT8PAM2ah7BmY8E2n2JJ8oUfeTuzEX+u+BA3FdFeM
 JxpmBjDppBipe5gOZBoO51g5zeZwlAUv05XDyLT8ZWu1bKUNY0IPRm6J5HdlvUSD6PVJ 8g== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n89gtanqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 10:13:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30NADfl3014385
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 10:13:41 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 23 Jan 2023 02:13:35 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>,
        <srinivas.kandagatla@linaro.org>, <quic_rohkumar@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>,
        <konrad.dybcio@linaro.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v3 0/2] Update lpass dt-bindings
Date:   Mon, 23 Jan 2023 15:43:20 +0530
Message-ID: <1674468802-14834-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IPGpIi0nV2YSX4YvslEXb0mFcpdG0CWK
X-Proofpoint-ORIG-GUID: IPGpIi0nV2YSX4YvslEXb0mFcpdG0CWK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_05,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 suspectscore=0 impostorscore=0 bulkscore=0 mlxlogscore=833 adultscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301230095
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update va-macro driver dt-bindings and add missing properties in sc7280 
machine driver dt-bindings.

Changes since v2:
    -- Update commit message and example in "Add platform property" patch.
    -- Update commit message in "Update clock name" patch.
Changes since v1:
    -- Remove sound-dai cells property patch.
    -- Update example in clock name change patch.
    -- Update commit message and add maxItems in platform proerty patch.

Srinivasa Rao Mandadapu (2):
  ASoC: qcom: dt-bindings: lpass-va-macro: Update clock name
  ASoC: dt-bindings: google,sc7280-herobrine: Add platform property

 .../devicetree/bindings/sound/google,sc7280-herobrine.yaml   | 12 ++++++++++++
 .../devicetree/bindings/sound/qcom,lpass-va-macro.yaml       |  4 ++--
 2 files changed, 14 insertions(+), 2 deletions(-)

-- 
2.7.4

