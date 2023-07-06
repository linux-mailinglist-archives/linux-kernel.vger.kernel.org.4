Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD067499D3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 12:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjGFKvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 06:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjGFKvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:51:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713871BC2;
        Thu,  6 Jul 2023 03:51:40 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36670SRo006415;
        Thu, 6 Jul 2023 10:51:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=0VfJCKUdOpIvVhewtbdCMSF2XmOCnStBUAa4TCfb2+Q=;
 b=Xaq47u7cZaLgrHrtIEQiYu+N5OX9ecokFVZmGWu42/FwY2Os0v/1Jxbqma3gsdSmdK8I
 1gHCxV66CwEJji5QimffVhn9zeoT+JdwXMp3rM08nSTKBMMJQiES4HBPUplO2neoHW5a
 VXg6mk8V715xFxAecDCTAZJaArHmxw//CTG5dMQVJx6hFs0ciLBWtLLpGIGZEF8nbY4d
 IefPpqi/iPqSdNR4F1ZKI8ZjORfLFz/7Z9SRwjONWWoC+1YMawoniYWd17WApTLdAFAO
 fdwwh4mnTIDEMeVyuChkyH+10J6URDxtJ3EK7HTS3DpD/87254+Qk5gMTOJGUmMeBPIC nA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rmxy93ghj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 10:51:36 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 366ApZbT014692
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Jul 2023 10:51:35 GMT
Received: from hu-imrashai-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 6 Jul 2023 03:51:30 -0700
From:   Imran Shaik <quic_imrashai@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Melody Olvera" <quic_molvera@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
Subject: [PATCH V3 0/6] Update GCC clocks for QDU1000 and QRU1000 SoCs
Date:   Thu, 6 Jul 2023 16:20:39 +0530
Message-ID: <20230706105045.633076-1-quic_imrashai@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JN7bSz4MR6787VV2N0KZNMN5A_Vub4sX
X-Proofpoint-ORIG-GUID: JN7bSz4MR6787VV2N0KZNMN5A_Vub4sX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_07,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1011 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 adultscore=0 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2307060096
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update GCC clocks and add support for GDSCs for QDU1000 and QRU1000 SoCs.

Changes since v2:
 - Split the gcc clkref clock changes as per the review comments

Changes since v1:
 - Dropped the v2 variant compatible changes
 - Update tha maintainers list
 - Split the GCC driver patch as per the review comments

Previous series:
v2 - https://patchwork.kernel.org/project/linux-arm-msm/list/?series=760862
v1 - https://patchwork.kernel.org/project/linux-arm-msm/list/?series=757828

Imran Shaik (6):
  dt-bindings: clock: Update GCC clocks for QDU1000 and QRU1000 SoCs
  clk: qcom: gcc-qdu1000: Fix gcc_pcie_0_pipe_clk_src clock handling
  clk: qcom: gcc-qdu1000: Fix clkref clocks handling
  clk: qcom: gcc-qdu1000: Update GCC clocks as per the latest hw version
  clk: qcom: gcc-qdu1000: Add support for GDSCs
  clk: qcom: gcc-qdu1000: Update the RCGs ops

 .../bindings/clock/qcom,qdu1000-gcc.yaml      |   3 +-
 drivers/clk/qcom/gcc-qdu1000.c                | 159 ++++++++++++------
 include/dt-bindings/clock/qcom,qdu1000-gcc.h  |   4 +-
 3 files changed, 110 insertions(+), 56 deletions(-)

-- 
2.25.1

