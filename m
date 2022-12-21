Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E44652F53
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 11:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbiLUKXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 05:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234633AbiLUKWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 05:22:12 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F8213F87;
        Wed, 21 Dec 2022 02:21:30 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BL8iXI5001160;
        Wed, 21 Dec 2022 10:21:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=MCWvNDHZ4u8ehQkpYRwQotBi9IyItvZvp/bt9JT5p8s=;
 b=pgfkrXEB/Xhn+SUDwnkRwktIcrKoBPhXZ+TNSWWh7m6uheuNpPF75OIj3owjbW4jKReD
 sILelvhgsDsAf1Xf7jv9lfVd8NbjRQ1tCjdX7kJSHTwqxgtm9xyOl0ztFerIO1/bAXqZ
 v2SqzceVQUW/O4tJt9L9AiEiNLRsq6RcyUP74gH0+xs+XgjLyNxRyA75kHL6PbLQP2eW
 2vk3ETtqeXkRkjBvETYfpw9rXtb9/fFW7vl8U4YrOVQQ5qot5JJnkfJk9hB8Xlu45u9e
 1vI2fDwwFxLUkqB9tL0aFqVcKkgFmiG021BtubbR9Dvcpl4xwURCDSO4/mv/0c+WKF11 hQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mk39tbntr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 10:21:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BLALLKs008565
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 10:21:21 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 21 Dec 2022 02:21:17 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <swboyd@chromium.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <robh+dt@kernel.org>, <broonie@kernel.org>,
        <quic_plai@quicinc.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH 0/2] Add resets for ADSP based audio clock controller driver.
Date:   Wed, 21 Dec 2022 15:50:59 +0530
Message-ID: <1671618061-6329-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 15gR521WN9KUW8SFa4F8OCF_xISm7gbS
X-Proofpoint-GUID: 15gR521WN9KUW8SFa4F8OCF_xISm7gbS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-21_04,2022-12-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=879 spamscore=0 clxscore=1011 adultscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212210083
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add resets for audio clock controller on audioreach based platforms. 

Srinivasa Rao Mandadapu (2):
  dt-bindings: clock: SC7280:  Add resets for LPASS audio clock
    controller
  clk: qcom: lpasscc: Add resets for SC7280 audioreach clock controller

 .../devicetree/bindings/clock/qcom,sc7280-lpasscc.yaml |  4 ++++
 drivers/clk/qcom/lpasscc-sc7280.c                      | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+)

-- 
2.7.4

