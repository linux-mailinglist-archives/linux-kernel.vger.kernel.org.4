Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CFD72D43C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 00:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238772AbjFLWPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 18:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238500AbjFLWPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 18:15:07 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E774010D5;
        Mon, 12 Jun 2023 15:15:06 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CLYQk3006674;
        Mon, 12 Jun 2023 22:15:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=92A7sWmY3DqiWHnz6ED8fB3lIzVvkd55/1DTc2WAPIc=;
 b=QVnCQZflO6GzxfNikRYOMpe0y+lbyAIp1AsRZ45Tj/EUU5mHNFrydwL1OBJF6sjQH3rq
 K5XYyaWFt5ssiUEmX6yC83frxyQzc7W12IDdtpXELzUn/1YfOcQ3mxOe4d7b1nuAlAZn
 U6cwQIvVUBNiuH1RGrYVb81o/SgTsDZICO/G8eFEZdko1KpMq7Qgvb/VZ45y+ZFGc1fY
 lnNtcvnMiD/ss3RyItgRy+lyzzdi2tady4cv5dQ/6IZxuqckcES79Yk8IPYo/NyFmezU
 wSTaE/CoD6SLVxdzBA9VEfKizdlw1brswQiyun5zWVU+pQxPIsKPM1CVX7q1GCjk8wzl CA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r60pesfk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 22:15:03 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35CMF2bE021895
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 22:15:02 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 12 Jun 2023 15:15:01 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] arm64: dts: qcom: sc8180x: USB TypeC plumbing
Date:   Mon, 12 Jun 2023 15:14:53 -0700
Message-ID: <20230612221456.1887533-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1qg8OP1QMAkVPCl_MFjGLpt1VdINvniR
X-Proofpoint-ORIG-GUID: 1qg8OP1QMAkVPCl_MFjGLpt1VdINvniR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_16,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 mlxlogscore=723 impostorscore=0 mlxscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306120191
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This wires up USB Type-C and pmic_glink to provide battery monitoring,
external display and orientation switching of the SuperSpeed pins.

Note that the external display has a functional dependency on INTF/PHY
selection in the DPU driver.

Bjorn Andersson (3):
  arm64: dts: qcom: sc8180x: Add USB Type-C of_graph anchors
  arm64: dts: qcom: sc8180x-primus: Wire up USB Type-C
  arm64: dts: qcom: sc8180x-flex5g: Wire up USB Type-C

 .../boot/dts/qcom/sc8180x-lenovo-flex-5g.dts  | 196 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc8180x-primus.dts   | 196 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc8180x.dtsi         |  48 +++++
 3 files changed, 440 insertions(+)

-- 
2.25.1

