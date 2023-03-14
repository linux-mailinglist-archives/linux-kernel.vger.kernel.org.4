Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A066B8963
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 05:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjCNEPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 00:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjCNEPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 00:15:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CC59035;
        Mon, 13 Mar 2023 21:15:48 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32E3WDQp011071;
        Tue, 14 Mar 2023 04:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=+m9gUtW7WjTbknqyppngDKvu+Dk6IaA7Thd8taIo7yE=;
 b=br4liCbnwuDhUIthHwJUJnLpJcdd77gd1f9PYC4fq5wA1xpoD3AKkTb5LnQx4R10jKN6
 BrBDUw59/mhM2JL7yazX4r4iGdIN3pFMB7+hZjEfLCT1D5ib4LrxQ6bihedA/dd6KsIJ
 mS8mD8JE/QP/ajaSBt87fuWfDQYhqd2N6bNMUWU0xsYe89k1D4upC7kiA00xdze3bHdO
 MVHzKvTIbSqx8LlQTFDLfgynrIbcFKTz+10LRZEpwbZkO8sVCLHTTwyfjLgLOQ4BWYhA
 HFe+rTREjw7b/CgsEcd8GQi73FmNQHhBFzK+wRrdduTvDR3BvoZW2kJCZdylWwjjwcEW jQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pa44bt568-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 04:15:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32E4FiZ4018000
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 04:15:44 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 13 Mar 2023 21:15:41 -0700
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH 0/3] rework mailbox compatibles for Qualcomm IPQ SoCs
Date:   Tue, 14 Mar 2023 09:45:12 +0530
Message-ID: <20230314041515.15883-1-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mtHOR8dsolWwPwJm7dxaiJRX31bLuYGu
X-Proofpoint-ORIG-GUID: mtHOR8dsolWwPwJm7dxaiJRX31bLuYGu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_13,2023-03-13_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=579 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303140037
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As suggested by Krzysztof[1], we can use the fallback compatible to
avoid duplicating the same device data.

Krzysztof already submitted a series[2] for this by reworking entire
binding and driver and it is conflicting with the Dmitry's series as
mentioned by Krzysztof[3].

So this series addresses IPQ SoCs alone, as I see no dependency with it.

[1]
https://lore.kernel.org/linux-arm-msm/1b75ab1a-44c9-c4a8-7fa4-d601fc710d2a@linaro.org/
[2]
https://lore.kernel.org/linux-arm-msm/20230202161856.385825-1-krzysztof.kozlowski@linaro.org/
[3]
https://lore.kernel.org/linux-arm-msm/fa6dc60c-3799-d384-da24-f282b7cbd3ef@linaro.org/

Kathiravan T (2):
  dt-bindings: mailbox: qcom: use fallback for IPQ8074 SoC
  mailbox: qcom-apcs-ipc: drop the IPQ8074 and IPQ5332 compatible

Krzysztof Kozlowski (1):
  arm64: dts: qcom: ipq8074: add compatible fallback to mailbox

 .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml   | 5 +----
 arch/arm64/boot/dts/qcom/ipq8074.dtsi                        | 3 ++-
 drivers/mailbox/qcom-apcs-ipc-mailbox.c                      | 2 --
 3 files changed, 3 insertions(+), 7 deletions(-)

-- 
2.17.1

