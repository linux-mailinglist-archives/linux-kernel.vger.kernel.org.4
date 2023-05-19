Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE70D7094CD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 12:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjESKbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 06:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjESKbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 06:31:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A242F3;
        Fri, 19 May 2023 03:31:51 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34J5lU4O013551;
        Fri, 19 May 2023 10:31:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=qjcoW5vuw7bUv+S7SNKWcWXyfhTSHNiKl95sYQjlnG0=;
 b=J8t6zEUvKfs3Mty3iBiBYeXieBjiHPtrQSvaDG61cpNtJtUBMtXyPQ9ZRR3Xqcy5Eb8N
 ugG/jZfbizNYOzT0+5aVGpq1N4FUXGBHSYGYlvR3bSTKk5NVNiCjm7KCFX6D/jaM81RO
 tkLKpjcfUQnoYZSIS1KqF2xDoUoJR38kfrCZgk3CSFw1AfViY01dx5L+eqxiYXSj6Rac
 PUlpHPtRCh5ePZyMgLbp9MeY1VNi2oV2yWn6CcKUnKj3Ua5CarmwVBWhd77CkIjfcklI
 e6qfxvycChIHczYNkwsDriKet/qiQamc9G7Q0uT5QRXm+8SsQsxnEW2aCPYHqh7aGw85 lQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qp2e98nx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 10:31:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34JAVlET006928
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 10:31:47 GMT
Received: from poovendh-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 19 May 2023 03:31:42 -0700
From:   Poovendhan Selvaraj <quic_poovendh@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_devipriy@quicinc.com>
Subject: [PATCH 0/2] Add initial support for RDP454 of IPQ9574 family
Date:   Fri, 19 May 2023 16:01:26 +0530
Message-ID: <20230519103128.30783-1-quic_poovendh@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6luPCjqnIL165bDI_v04jfEwSNBNi8WY
X-Proofpoint-ORIG-GUID: 6luPCjqnIL165bDI_v04jfEwSNBNi8WY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_06,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=704
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190089
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: POOVENDHAN SELVARAJ <quic_poovendh@quicinc.com>

Add the initial device tree support for the Reference Design
Platform(RDP) 454 based on IPQ9574 family of SoCs. This patch series adds
support for Console UART, SPI NOR and SMPA1 regulator node.

The series depends on the below patch sets which adds support for
SPI NOR and SMPA1 regulator nodes.
https://lore.kernel.org/linux-arm-msm/20230329053726.14860-3-quic_kathirav@quicinc.com/
https://lore.kernel.org/linux-arm-msm/20230407155727.20615-1-quic_devipriy@quicinc.com/

Poovendhan Selvaraj (2):
  dt-bindings: arm: qcom: document AL02-C9 board based on IPQ9574 family
  arm64: dts: qcom: ipq9574: add support for RDP454 variant

 .../devicetree/bindings/arm/qcom.yaml         |  2 +
 arch/arm64/boot/dts/qcom/Makefile             |  1 +
 arch/arm64/boot/dts/qcom/ipq9574-rdp454.dts   | 92 +++++++++++++++++++
 3 files changed, 95 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp454.dts


base-commit: 4272e06e19f388ccfe1f04f19060ea84d2a19a8b
-- 
2.17.1

