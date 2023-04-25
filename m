Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F966EDE61
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 10:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbjDYIop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 04:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbjDYIoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 04:44:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD641547F;
        Tue, 25 Apr 2023 01:42:08 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33P8dnwS017610;
        Tue, 25 Apr 2023 08:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=CJFda1HHrboza25Ghy1e5r7VY3fKqD57pup/Hc23itc=;
 b=ZwI8yMQw57gIIcSK5P/dqFe7ulG3bKVZlgw7gHgaYxpUUT9OFlphj/47rcktOBNq9aEA
 LpvBwNEv6Rw4hG82td8UR+tGbr7csFM1vBxRkL18T1+7YKjt9j35xgmmkjUdbGoMEmK4
 qg5ry93OBHtUZkL2IL57RS6aWik/OeePBrGqdlctA3oeSp/w8IkFTMUKOEg3JlOhPzoB
 BeIx4Zz01cwHsfHBMZ4Lf6ILbPD5mVMHwHaWHzRcNdPZ39POhpbM6TY+YFs7RKLdfF7K
 rQzUqyG8IId6rqsaURB/tTTw3JZPYSu9hP7JsnTFr4iKyW96gobYw9/Vxo8V+fYx3OCJ SQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q6bgp807u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 08:40:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33P8eVk1001924
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 08:40:31 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 25 Apr 2023 01:40:25 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_poovendh@quicinc.com>
Subject: [PATCH V3 0/6] Incremental patches on minimal boot support
Date:   Tue, 25 Apr 2023 14:10:04 +0530
Message-ID: <20230425084010.15581-1-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LN7GkLXPxYtizxXBwUBFIBVG3NHnHDh9
X-Proofpoint-ORIG-GUID: LN7GkLXPxYtizxXBwUBFIBVG3NHnHDh9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_03,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304250076
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
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

Changes in V3:
	- Detailed change logs are added to the respective patches.

Changes in V2:
https://lore.kernel.org/linux-arm-msm/20230417053355.25691-1-quic_devipriy@quicinc.com/
	- Updated the subject & commit message of [PATCH V2 1/4]
	- No changes were made to any other patches

Changes in V1:
	- The Delta between V9 & V12 is added to the change log of
	  the respective patches for quick reference

Devi Priya (6):
  arm64: dts: qcom: ipq9574: Update the size of GICC & GICV regions
  dt-bindings: clock: qcom,ipq9574-gcc: Add maintainer
  clk: qcom: gcc-ipq9574: Clean up included headers
  clk: qcom: gcc-ipq9574: constify struct clk_init_data
  arm64: dts: qcom: ipq9574: Drop bias_pll_ubi_nc_clk input
  arm64: dts: qcom: ipq9574: rename al02-c7 dts to rdp433

 .../bindings/clock/qcom,ipq9574-gcc.yaml      |   1 +
 arch/arm64/boot/dts/qcom/Makefile             |   2 +-
 ...ipq9574-al02-c7.dts => ipq9574-rdp433.dts} |   2 +-
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         |  14 +-
 drivers/clk/qcom/gcc-ipq9574.c                | 434 +++++++++---------
 5 files changed, 224 insertions(+), 229 deletions(-)
 rename arch/arm64/boot/dts/qcom/{ipq9574-al02-c7.dts => ipq9574-rdp433.dts} (97%)

-- 
2.17.1

