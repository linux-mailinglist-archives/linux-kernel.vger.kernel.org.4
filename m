Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9175D740D1F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbjF1Jd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:33:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131]:38766 "EHLO
        mx0a-0031df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233533AbjF1J3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:29:08 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35S7x3nn018679;
        Wed, 28 Jun 2023 09:29:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=JurXvFvN3FaVuLqjt8uyVfMyx7nh5fOnI9auSwATcA4=;
 b=Wq5ErT4Xt4uuIL2abzOhKhi7Xg/Tc+9S6ehBm0a40bqBfcvU9RP4+5UnF6ch5tJiFAHK
 nfdd6xX411d4Gs8i9p+YbF2AbzUrLAnY1p3zf3za7UgzDSDH7U8HXyvel7S6a2C5I0b7
 /TedKu38s9Xo56xxfatIcwab4kRq+o/ejczm3O57237IVr8pAdhAYj2RiCaC3+w8Ms2P
 +0ffqZMxFAVlYtVKguCQc+9+HHXTTESikinAvnUAjcAouGAXX5rrodnavE9Xge+ei2MV
 P8HmWiAyPDcUHel5wUUB7u9wgVrYdwITLRY2f9rxBDfheK1PQKbVOSc6her8BO16xcg8 hg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgextgj5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 09:29:04 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35S9T3li018703
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 09:29:03 GMT
Received: from hu-imrashai-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 28 Jun 2023 02:28:58 -0700
From:   Imran Shaik <quic_imrashai@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Taniya Das <quic_tdas@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
Subject: [PATCH V2 0/5] Update GCC clocks for QDU1000 and QRU1000 SoCs
Date:   Wed, 28 Jun 2023 14:58:32 +0530
Message-ID: <20230628092837.3090801-1-quic_imrashai@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2NHyfz5RNxMSXs-zn84WUtFs7K2TglkA
X-Proofpoint-GUID: 2NHyfz5RNxMSXs-zn84WUtFs7K2TglkA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 mlxlogscore=934 spamscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280083
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update GCC clocks and add support for GDSCs for QDU1000 and QRU1000 SoCs.

Changes since v1:
 - Dropped the v2 variant compatible changes
 - Update tha maintainers list
 - Split the GCC driver patch as per the review comments

Previous series:
v1: https://patchwork.kernel.org/project/linux-arm-msm/list/?series=757828

Imran Shaik (5):
  dt-bindings: clock: Update GCC clocks for QDU1000 and QRU1000 SoCs
  clk: qcom: gcc-qdu1000: Fix gcc_pcie_0_pipe_clk_src clock handling
  clk: qcom: gcc-qdu1000: Update GCC clocks as per the latest hw version
  clk: qcom: gcc-qdu1000: Add support for GDSCs
  clk: qcom: gcc-qdu1000: Update the RCGs ops

 .../bindings/clock/qcom,qdu1000-gcc.yaml      |   3 +-
 drivers/clk/qcom/gcc-qdu1000.c                | 159 ++++++++++++------
 include/dt-bindings/clock/qcom,qdu1000-gcc.h  |   4 +-
 3 files changed, 110 insertions(+), 56 deletions(-)

-- 
2.25.1

