Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968587482AC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 13:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjGELGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 07:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGELGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 07:06:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1089170D;
        Wed,  5 Jul 2023 04:06:44 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365AiLho031838;
        Wed, 5 Jul 2023 11:06:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=p8MwJb2WMDWj9TNABl42MjVlznLfy+1V9SozlI4Uavw=;
 b=PelSDe7Rr0Mze6bAZOnPaTgrVA1nVYxu7Svhu0x8BBjHpPGhqYP4r8Qv54XmQUxQRZdi
 ZDp3naNFeSKbNSmWGJBgSGqvH0uR7Sz8Up2do3zpPtwYY1nidoCsBIW9OXOd9BW9wBKD
 IpjYpmmsPeOnCkPMOmTjZZMPpdQL+NPyhxoQ+WINTObRk47UCptZZlpeHc8YKGIggvh2
 9VxtjsTjTuhxYZi+IQ4HchhVTq7Jnz6888Wu4rSpRM+SHXJTHf5lydAIQRVJS8K7R7H8
 4QP0hLp2g4d0tN+V+3MtqY3bnyIQnlq6NS5qznsoJf+iV90oGxQgZMgZxWrwhZ4l0VsZ ZQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rn2w58ghr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 11:06:40 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 365B6dIJ016328
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Jul 2023 11:06:39 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 5 Jul 2023 04:06:36 -0700
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>
Subject: [PATCH v2 0/2] arm64: dts: qcom: qdu1000: Update reserved memory region
Date:   Wed, 5 Jul 2023 16:36:18 +0530
Message-ID: <20230705110620.7687-1-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CAMIJktElHWV6UZgAqF9fNPZ5XFJXIqE
X-Proofpoint-GUID: CAMIJktElHWV6UZgAqF9fNPZ5XFJXIqE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_02,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=404
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307050097
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update reserved memory region for QDU1000 and QRU1000 SoCs.

Changes in v2:
 - Changed the node name.
 - Dropped unnecessary properties.

Komal Bajaj (2):
  arm64: dts: qcom: qdu1000-idp: Update reserved memory region
  arm64: dts: qcom: qru1000-idp: Update reserved memory region

 arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 22 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/qru1000-idp.dts | 12 ++++++++++++
 2 files changed, 34 insertions(+)

-- 
2.40.1

