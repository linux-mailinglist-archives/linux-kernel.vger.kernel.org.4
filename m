Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE286E3EED
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 07:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjDQFec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 01:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjDQFe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 01:34:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5A8212F;
        Sun, 16 Apr 2023 22:34:23 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33H47Fk6010753;
        Mon, 17 Apr 2023 05:34:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=0cwRhtA6ZuctV5zzxJgO5tpv4VIFRXFeL+rOLiyTj1s=;
 b=Sct7ZHC0XNDvPqdf3aWRMBx707acSOCAjZzJWhhWt8GkQHZ/nv96hmZPgEZAEe6Bhfjy
 khbn2OObwz0+Djr0WQMwWjUuMx7eaN1487vu9p2Wr+p0kwFyHwYqoClc/uFqtBVxF99T
 Tu4UdY+nKCJc9cesCqghRkca+1Vm5wffaOkT4qMX2a1FD9sHps6ItjzfNntLgNuOkG8t
 Lnk+GIk/IClclu+4L4zAtVulpp9RgEMzEZFvO7pIjXfhwxjVoJHZvv+Ik0eaggqzWrou
 N/95NvF/jX7OBbFaBOW70l7Ghugqsr6AtwJzNV4FABHr0QKLGHQ3tzNzFJaCh9kuXIAu Kg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pymnf2n6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 05:34:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33H5YJOl028373
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 05:34:19 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sun, 16 Apr 2023 22:34:13 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_poovendh@quicinc.com>
Subject: [PATCH V2 0/4] Incremental patches on minimal boot support
Date:   Mon, 17 Apr 2023 11:03:51 +0530
Message-ID: <20230417053355.25691-1-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: v3r8vzuiB8QTuTrIwVLgnBs11-7X10KY
X-Proofpoint-ORIG-GUID: v3r8vzuiB8QTuTrIwVLgnBs11-7X10KY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_02,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304170050
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patchset V9 of the series: Add minimal boot support for IPQ9574 has been
merged and is available in linux-next/master.
V12 being the latest revision posted in the series, the delta between
revisions V9 and V12 is posted as a separate series as suggested by 
Bjorn to avoid possible confusions.

This series adds the delta changes between revisions V9 and V12.

V9 can be found at:
https://lore.kernel.org/linux-arm-msm/20230316072940.29137-1-quic_devipriy@quicinc.com/

V12 can be found at:
https://lore.kernel.org/linux-arm-msm/20230410135948.11970-1-quic_devipriy@quicinc.com/

Changes in V2:
	- Updated the subject & commit message of [PATCH V2 1/4]
	- No changes were made to any other patches

Changes in V1:
	- The Delta between V9 & V12 is added to the change log of
	  the respective patches for quick reference

Devi Priya (4):
  dt-bindings: clock: qcom,ipq9574-gcc: Drop bias_pll_ubi_nc_clk input
  clk: qcom: gcc-ipq9574: Drop bias_pll_ubi_nc_clk & add const to
    clk_init_data
  arm64: dts: qcom: ipq9574: Drop bias_pll_ubi_nc_clk & update intc node
  arm64: dts: qcom: ipq9574: rename al02-c7 dts to rdp433

 .../bindings/clock/qcom,ipq9574-gcc.yaml      |   3 +-
 arch/arm64/boot/dts/qcom/Makefile             |   2 +-
 ...ipq9574-al02-c7.dts => ipq9574-rdp433.dts} |   2 +-
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         |  13 +-
 drivers/clk/qcom/gcc-ipq9574.c                | 475 +++++++++---------
 5 files changed, 232 insertions(+), 263 deletions(-)
 rename arch/arm64/boot/dts/qcom/{ipq9574-al02-c7.dts => ipq9574-rdp433.dts} (97%)

-- 
2.17.1

