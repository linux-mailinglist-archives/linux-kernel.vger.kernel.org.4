Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFF25F193D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 05:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiJADJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 23:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiJADHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 23:07:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738CCE2CC9;
        Fri, 30 Sep 2022 20:06:57 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29135JQ5031873;
        Sat, 1 Oct 2022 03:06:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=nmR0nhFxx2ft7N+7Oelb110DS4QuH8fub5Md6HnZewg=;
 b=OMs7QGQ12RAtrj8fs3TivCAbpSfm/ULHfs2yxLihQizRote2CH1nNPAHKc7UD4SPjofe
 ThFUTRcRzg1g7910lzVxX+lcsHxz7Yn+WtvScmSkg1X34X4pGY+JzGQEiWPO2RVodtNW
 JV8HdVx3ue+TpbCaPAhs887RcsueV/9B1OtBb2tPO4J29bFg0DlVK5Ky7Bu9/98UvO/i
 BUCTRPkczoPF5apdXWnJELqtNQmooG73W6Nbjt14IDHEnX2LL4Y7zASiYdsuB0NYHkHe
 4FYhcLUiElrChCaxQwAzqAdm5Q6EqI5ZuiC07QN0DM+7GIGmXBqHkX6L3y0lYAJczcyW qA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jwwfck4ce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 01 Oct 2022 03:06:55 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29136smg004975
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 1 Oct 2022 03:06:54 GMT
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 30 Sep 2022 20:06:54 -0700
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH 0/5] Add misc support for QDU1000/QRU1000 SoCs
Date:   Fri, 30 Sep 2022 20:06:36 -0700
Message-ID: <20221001030641.29354-1-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: L8MJ4cvqcn59ln0Dm1qpkCN4-xpnT1Ar
X-Proofpoint-ORIG-GUID: L8MJ4cvqcn59ln0Dm1qpkCN4-xpnT1Ar
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-01_02,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210010016
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series firmware, SoC, rpmpd, tz-log, and mmc bindings as well as
pmic, rpmpd, and socinfo support for QDU1000 and QRU1000 SoCs.

This patchset is based off of [1] and [2] YAML conversion patches.

The Qualcomm Technologies, Inc. Distributed Unit 1000 and Radio Unit
1000 are new SoCs meant for enabling Open RAN solutions. See more at
https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/qualcomm_5g_ran_platforms_product_brief.pdf

[1] https://lore.kernel.org/r/20220708090431.30437-1-david@ixit.cz
[2] https://lore.kernel.org/r/20220815100952.23795-8-a39.skl@gmail.com

Melody Olvera (5):
  dt-bindings: firmware: scm: Add QDU1000/QRU1000 compatibles
  dt-bindings: arm: qcom: Document QDU1000/QRU1000 SoCs and boards
  dt-bindings: power: rpmpd: Add QDU1000/QRU1000 to rpmpd binding
  soc: qcom: rpmhpd: Add QDU1000/QRU1000 power domains
  soc: qcom: socinfo: Add QDU1000/QRU1000 and variant IDs

 Documentation/devicetree/bindings/arm/qcom.yaml  | 16 ++++++++++++++++
 .../devicetree/bindings/firmware/qcom,scm.yaml   |  2 ++
 .../devicetree/bindings/power/qcom,rpmpd.yaml    |  2 ++
 drivers/soc/qcom/rpmhpd.c                        | 13 +++++++++++++
 drivers/soc/qcom/socinfo.c                       |  6 ++++++
 include/dt-bindings/power/qcom-rpmpd.h           |  6 ++++++
 6 files changed, 45 insertions(+)


base-commit: 987a926c1d8a40e4256953b04771fbdb63bc7938
prerequisite-patch-id: 54cfdb75ec88e75b31d5c1df0d4a361434334d2b
prerequisite-patch-id: b0108c3601b8ed11cefe4366aa506b2dca364866
-- 
2.37.3

