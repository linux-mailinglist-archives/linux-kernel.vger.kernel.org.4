Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3AF76C5E33
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 05:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjCWEt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 00:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjCWEtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 00:49:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B4935AA;
        Wed, 22 Mar 2023 21:49:50 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N4mIGb009059;
        Thu, 23 Mar 2023 04:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=vZZIDWj/xZzVL9y/f11rlVtYZwpu3vAL3tdgFLOtvGQ=;
 b=dLOtMOdpVrz1AadpeBrtaXVnhXnpHbnfj9XvY79WutN3kM+w8rUYLsnSyhj8AuKouJMP
 wYtJSk1Gxq99kA8Y96ESIpYu4MVhUQaikKoZqobqvgpfnkCW3kB4vEchGoZGlpxkIu50
 QnBhV89BMiw0OY4w+n9z1Pjfv1LX3M1n+7AXZdltd3laIGHWYGcwJegXr4bPVWUKbu73
 RPLbbjJKYnPtBjk/ztnMAt9nQ92ZyiTf1fp6VWNKcEHKnY+/MM+aKau8inY2mrqO7Ns9
 r87FZuXCmlhNRKQNr3iBWozKvVL3BSqYlAkI8sgyeA0LviI6sCBY2nuiha6PynitH/3p 0g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pg9nagspp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 04:49:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32N4njgI004941
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 04:49:45 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 22 Mar 2023 21:49:41 -0700
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH 0/2] Add initial support for RDP468 of IPQ5332 family
Date:   Thu, 23 Mar 2023 10:19:27 +0530
Message-ID: <20230323044929.8694-1-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rPUsDb9aX09ppIZNirf-3FoJmmvArP1J
X-Proofpoint-ORIG-GUID: rPUsDb9aX09ppIZNirf-3FoJmmvArP1J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=751 suspectscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230036
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

Kathiravan T (2):
  arm: qcom: document MI01.6 board based on IPQ5332 family
  arm64: dts: qcom: ipq5332: add support for the RDP468 variant

 .../devicetree/bindings/arm/qcom.yaml         |   2 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts   | 103 ++++++++++++++++++
 3 files changed, 106 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts

-- 
2.17.1

