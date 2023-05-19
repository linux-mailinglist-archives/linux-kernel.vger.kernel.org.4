Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F1A7092A6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjESJJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjESJJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:09:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7822CFB;
        Fri, 19 May 2023 02:09:47 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34J8MQSU032453;
        Fri, 19 May 2023 09:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=fTRLxEVzOxMuk/v9zpEfwn4zvLM3oGwH+v661aO1/AA=;
 b=YU1XTNNDprSFX7rwvYf9UHuo1wiEbttrSM6NinU+aQHaF/vjjR7DCFxhCJRmtftDipbK
 4f4Rv7f0QwM2tHa90iJUvLt1qO+XFSGRgaSsoIvcNxElxDPMAlsYeMwTrsATVHoLLnHp
 NJB73CPV5cgmIKvPfKzsaF12hQiQem0r1yauZ+M8QHJRVUrT+SeGYwywXrYU6p0xKqE+
 4cTX9Y+c0uWzykGMweBzPRcZ8igNZU5s0hCq1UpD1Oy47nU8Do8o+UEGP37SVW0548p3
 JhdzDOos9e7eofjBf0GW/kvt7ECZ2n05a+6buj5EPCHZDTW6OQDaEEHeEFBEOiKfjHR6 Gg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qp4ccr8hw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 09:09:18 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34J99Crb031620;
        Fri, 19 May 2023 09:09:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3qj3mm5584-1;
        Fri, 19 May 2023 09:09:12 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34J99C9K031608;
        Fri, 19 May 2023 09:09:12 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 34J99CxE031603;
        Fri, 19 May 2023 09:09:12 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 6DDE95EB5; Fri, 19 May 2023 14:39:11 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, tglx@linutronix.de, maz@kernel.org,
        will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        robimarko@gmail.com, quic_gurus@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 0/8] Add devicetree support for SDX75 Modem and IDP
Date:   Fri, 19 May 2023 14:39:02 +0530
Message-Id: <1684487350-30476-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AQxRS3EvvsXKaI1ApuPcmnHtCll51H6O
X-Proofpoint-ORIG-GUID: AQxRS3EvvsXKaI1ApuPcmnHtCll51H6O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_05,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0
 phishscore=0 mlxlogscore=636 suspectscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305190076
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds devicetree support for Qualcomm SDX75 platform and IDP
board. This series functionally depends on GCC and RPMh Clock support
series [1], and pinctrl support for SDX75 [2] which are under review.

With this current devicetree support, the IDP can boot into initramfsshell.

[1] https://lore.kernel.org/lkml/20230419133013.2563-3-quic_tdas@quicinc.com/
[2] https://lore.kernel.org/all/1684409015-25196-1-git-send-email-quic_rohiagar@quicinc.com/

Thanks,
Rohit.


Imran Shaik (1):
  arm64: dts: qcom: Add support for GCC and RPMHCC for SDX75

Rohit Agarwal (7):
  dt-bindings: arm: qcom: Document SDX75 platform and boards
  dt-bindings: firmware: scm: Add compatible for SDX75
  dt-bindings: interrupt-controller: Add SDX75 PDC compatible
  dt-bindings: arm-smmu: Add SDX75 SMMU compatible
  arm64: dts: qcom: Add SDX75 platform and IDP board support
  arm64: dts: qcom: Add QUPv3 UART console node for SDX75
  arm64: dts: qcom: Enable the QUPv3 UART console for SDX75

 Documentation/devicetree/bindings/arm/qcom.yaml    |   7 +
 .../devicetree/bindings/firmware/qcom,scm.yaml     |   1 +
 .../bindings/interrupt-controller/qcom,pdc.yaml    |   1 +
 .../devicetree/bindings/iommu/arm,smmu.yaml        |   1 +
 arch/arm64/boot/dts/qcom/Makefile                  |   1 +
 arch/arm64/boot/dts/qcom/sdx75-idp.dts             |  34 ++
 arch/arm64/boot/dts/qcom/sdx75.dtsi                | 618 +++++++++++++++++++++
 7 files changed, 663 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sdx75-idp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sdx75.dtsi

-- 
2.7.4

