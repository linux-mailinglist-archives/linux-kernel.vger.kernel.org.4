Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B9E6CAAAA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjC0Qdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjC0Qds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:33:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403D12699;
        Mon, 27 Mar 2023 09:33:27 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32RDNW0t029977;
        Mon, 27 Mar 2023 16:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=KTYq0H+n5QnNPVgJ4qydeRprJdLzVKJuG4fkcEqI/8o=;
 b=Gn47S7P5Q+M/xlbKa8n6ck95hoRjiUxyZKb1Rza7UWfRsUrMdRU5kHPYgfWHljSS1mfb
 1c57Tk/dMapNvX5W3TwN/qebDUuMM05HJgXbi+onM5QPsiRYQ+Uh1aJs9PQVNSwm2RqP
 68yanff8rfdZYDFdPj7+Y50lx5jAqkGn3KCj+H637VGheeUoKlyLpeyIy8nj7mVSqI9S
 jmQe+wW541T698qSRsdK840xmqpq7KxyB7VnD3UTRno946gMO+iCCzf6rAJGV6cQfj2k
 QxRpmH4mmf9bTHEEu5fNx2zJsAdWqCrFlw9DNsAECDmgwue6Bms+lec8w3QFP3BmW2V7 Rg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pkbyw8k6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 16:33:17 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32RGXH0w012872
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 16:33:17 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 27 Mar 2023 09:33:12 -0700
From:   Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To:     <swboyd@chromium.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <broonie@kernel.org>, <quic_plai@quicinc.com>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <quic_visr@quicinc.com>
CC:     Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: [PATCH v1 0/4] Remove the qdsp6ss register from lpasscc
Date:   Mon, 27 Mar 2023 22:02:45 +0530
Message-ID: <20230327163249.1081824-1-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lKEliUnVx_yQL4_j-Vb9GnSnY7aFvr3M
X-Proofpoint-ORIG-GUID: lKEliUnVx_yQL4_j-Vb9GnSnY7aFvr3M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=747 spamscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303270133
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is to remove the qdsp6ss register from lpasscc to
resolve memory conflict's between lpascc and ADSP remoteproc driver.

Mohammad Rafi Shaik (4):
  arm64: dts: qcom: sc7280: Modify lpasscc node name
  dt-bindings: clock: qcom,sc7280-lpasscc: Remove qdsp6ss register
    region
  arm64: dts: qcom: sc7280: Remove qdsp6ss regmap region
  clk: qcom: lpasscc-sc7280: Remove qdsp6ss clock registration

 .../bindings/clock/qcom,sc7280-lpasscc.yaml   |  8 +--
 arch/arm64/boot/dts/qcom/sc7280.dtsi          |  7 +--
 drivers/clk/qcom/lpasscc-sc7280.c             | 63 +------------------
 3 files changed, 7 insertions(+), 71 deletions(-)

-- 
2.25.1

