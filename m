Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605D0704FCB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbjEPNuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbjEPNus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:50:48 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005E5193;
        Tue, 16 May 2023 06:50:46 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GDJqU1009636;
        Tue, 16 May 2023 13:50:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=X9gwxQr/tw5gPqEr1p2tZ3sy6Xl/TEE6xQ3YJK5FPdc=;
 b=gHLImuCSJvCw9qWt6ylEd31TvjyXWiApdmsdaZCsZ6XRYxdGyt/uiqG5Bj+xsd0DfBeQ
 K3u9DwjRof4eyKVHQfzA2/1dbsQawSGxvz8HtBA9xrtlzK6PI0XfR4M5tGKWhkactZSf
 /vHG03klnl0g0DoclRsQcXRBLi+XRdHpRN8+O531tHbHBsyAdAUVGjWRIP+K+/T1GyrN
 31ulUH+Hv2XgBT5fFSKQ5n8T69gDOw7OXlCs06+4M9ModemH5awKnpRbJe0Oz0kTiJva
 nkmqhKUcnZxB+Li4iG5lqIHqwrKyURNgbJdOcUP2H1b9HEHDrTBJV8kZF9giIxcRfV55 GA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qkwmj1jsy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 13:50:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34GDoffT010690
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 13:50:41 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 16 May 2023 06:50:37 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>
Subject: [PATCH 0/2] Add initial support for RDP449 of IPQ9574 family
Date:   Tue, 16 May 2023 19:20:11 +0530
Message-ID: <20230516135013.3547-1-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DUsWyftJU4K8Sx5U3MHwrNTr61rhDylV
X-Proofpoint-ORIG-GUID: DUsWyftJU4K8Sx5U3MHwrNTr61rhDylV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_06,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=691 clxscore=1015 spamscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305160115
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the initial device tree support for the Reference Design
Platform(RDP) 449 based on IPQ9574 family of SoCs. This patch series adds
support for Console UART, SPI NOR and SMPA1 regulator node.

The series depends on the below patch sets which adds support for
SPI NOR and SMPA1 regulator nodes.
https://lore.kernel.org/linux-arm-msm/20230329053726.14860-3-quic_kathirav@quicinc.com/
https://lore.kernel.org/linux-arm-msm/20230407155727.20615-1-quic_devipriy@quicinc.com/

Devi Priya (2):
  dt-bindings: arm: qcom: document AL02-C6 board based on IPQ9574 family
  arm64: dts: qcom: ipq9574: add support for RDP449 variant

 .../devicetree/bindings/arm/qcom.yaml         |  2 +
 arch/arm64/boot/dts/qcom/Makefile             |  1 +
 arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts   | 80 +++++++++++++++++++
 3 files changed, 83 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts

-- 
2.17.1

