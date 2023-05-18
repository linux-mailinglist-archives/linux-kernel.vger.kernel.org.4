Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E2E707C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 10:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjERIaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 04:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjERI36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 04:29:58 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBDE198A;
        Thu, 18 May 2023 01:29:57 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I7JD7R023367;
        Thu, 18 May 2023 08:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=1fi0Vf7Z9eUFZq54XD4aCZyuxVaubtBpsoxN9DObvwE=;
 b=g0F4VUz2LpMgWbVDr7PwF8OUEkkSUjCbJ1XPDH1Z8dIvGQLIwBC1O6+LI32S5G1Qybli
 bJLnKSNyVxfLfYIfXOTjNCIyAzGgMuzhNCPa3dzYgXcseCpbNLLIcrYHzvdXmFLDf7TY
 tzyWEiIwkqHEdjboZX3si3/VBfKLoqZnAV6QSW1I7s2EWcMSxvFUxBvw8nAKy0lmel1K
 OybA8bFX/U0UaiiWTVq8pao2V+DEjiSYRywvrrBvlTjVS4fMR9dxaLZS1EO8RVTeoN2i
 L0EiXNZ1ikK+N9i0Jb93Z5WqUeQREesBQisqb7oy4VPaP/P/5+hnHa/MRef0hjJzB2Ir DQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qned3085g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 08:29:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34I8TqS7022809
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 08:29:52 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 18 May 2023 01:29:49 -0700
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH V2 0/3] Minor updates in the IPQ5332 DTS files
Date:   Thu, 18 May 2023 13:59:31 +0530
Message-ID: <20230518082934.24129-1-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WI0OVESAixf0nxxD-K36pqwL_paHkSA-
X-Proofpoint-GUID: WI0OVESAixf0nxxD-K36pqwL_paHkSA-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_05,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 phishscore=0
 mlxlogscore=525 priorityscore=1501 clxscore=1015 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305180062
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the MI01.2 DTS after Reference Design Platform(RDP) number to align
with ipq5332-rdp468.dts, add UART1 node and reserve memory for U-boot
and SBL to avoid losing the RAM contents which will be used in post
morterm analysis.

Kathiravan T (3):
  arm64: dts: qcom: ipq5332: rename mi01.2 dts to rdp441
  arm64: dts: qcom: ipq5332: define UART1
  arm64: dts: qcom: ipq5332: add few more reserved memory region

 arch/arm64/boot/dts/qcom/Makefile             |  2 +-
 ...{ipq5332-mi01.2.dts => ipq5332-rdp441.dts} |  0
 arch/arm64/boot/dts/qcom/ipq5332.dtsi         | 24 ++++++++++++++++++-
 3 files changed, 24 insertions(+), 2 deletions(-)
 rename arch/arm64/boot/dts/qcom/{ipq5332-mi01.2.dts => ipq5332-rdp441.dts} (100%)

-- 
2.17.1

