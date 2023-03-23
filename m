Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261A06C63B6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjCWJe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjCWJeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:34:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B13237710;
        Thu, 23 Mar 2023 02:31:39 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N6ORQ5027642;
        Thu, 23 Mar 2023 09:31:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=Ez0KkBPbRCLG25DyICiiLl48c2y3BoVKHymClDKFNps=;
 b=b88h4L4HEIgObB5KGn46Xyu1VJMoIKoAtmvhQkyqhQ35Q1qDj6lme8neVOWRgVjtPd9L
 JxyBGW4BjplJQDucQSRYKwxQgX/Emhy9n3n4Kw/bfI+15Pa7FySaPrEgdpvzq/8slqgt
 LXUd4+ITN8/qgQjMpS0ul2hcChrjgzUfC47qD5j1rebLTaOhBe3PGBFgJ3y66PV5mbnV
 ldnIhw9MFL7dU6cwjtvqIuhzv6smJ+GEYaWe95dg17jNRZB1IpNxqBtUEXTJneggTeU9
 eMb9diFzRRhGbPPSOEgKmmRQhs/XNw0irRzZW69ghUmk42qRSZQq9p9kk7x7HXjFeer2 zg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pfyy72wb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 09:31:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32N9VanB021284
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 09:31:36 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 23 Mar 2023 02:31:32 -0700
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH V2 0/2] Add initial support for RDP468 of IPQ5332 family
Date:   Thu, 23 Mar 2023 15:01:18 +0530
Message-ID: <20230323093120.20558-1-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4mAs6YcmJ8TEo3mzHGRS2cu7VPGBsM-z
X-Proofpoint-ORIG-GUID: 4mAs6YcmJ8TEo3mzHGRS2cu7VPGBsM-z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 mlxlogscore=831 adultscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230071
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the initial device tree support for the RDP(Reference Design
Platform)468 based on IPQ5332 family of SoCs. This patch carries the
support for Console UART, SPI NOR, eMMC.

This series depends on the below which adds support the SPI NOR
https://lore.kernel.org/linux-arm-msm/20230320104530.30411-1-quic_kathirav@quicinc.com/

V1 can be found here
https://lore.kernel.org/linux-arm-msm/20230323044929.8694-1-quic_kathirav@quicinc.com/

Kathiravan T (2):
  dt-bindings: arm: qcom: document MI01.6 board based on IPQ5332 family
  arm64: dts: qcom: ipq5332: add support for the RDP468 variant

 .../devicetree/bindings/arm/qcom.yaml         |   2 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts   | 103 ++++++++++++++++++
 3 files changed, 106 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts

-- 
2.17.1

