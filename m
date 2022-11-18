Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DBB62FDE6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 20:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbiKRTXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 14:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbiKRTXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 14:23:03 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6369965855;
        Fri, 18 Nov 2022 11:23:02 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AIFuDVb018305;
        Fri, 18 Nov 2022 19:22:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=8jQiITS0fM+Mr8QA6U5AC4uhe77ah3q3akm+ii7AUok=;
 b=Nps2RCLqPMRy+svbtsMjtzVgpZN3vX5EdValZHodW6s0aXCMuCZwV1NFS1m84BnXUlVG
 y7N9LHQkryYHBxy6dkFqGHNuWRLJ+V/GzbjNOadGW/V2bycVtk385N4WbluHHZuZ+Mwu
 a2XzYon7NPlLpaws1KkqSIdyiXZdhDNjdk8FQQ2ydMLIDw+O44WORjsdYBNImQFBaj/v
 Au2OjSrLZqXcZMjsCfVi0KWxvTa/8AFonEBf8Akr8VdK6OqbQSW3Nw4XZai0DVmyzpmU
 nSJYciddcPU6eR2iy2uP+re5uBLkK/NOzNmGUd/k/gNDI77BRJJc/LyLvLIF/lo021h3 AA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kx0s5jpka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 19:22:58 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AIJMv65012082
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 19:22:58 GMT
Received: from hu-molvera-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 18 Nov 2022 11:22:57 -0800
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Subject: [PATCH v4 0/2] Add base device tree files for QDU1000/QRU1000
Date:   Fri, 18 Nov 2022 11:22:39 -0800
Message-ID: <20221118192241.29384-1-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PYEGCMpp9j5scYSVBju68TGMPmqAh0_m
X-Proofpoint-ORIG-GUID: PYEGCMpp9j5scYSVBju68TGMPmqAh0_m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_06,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=519 suspectscore=0 impostorscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211180115
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the base device tree files and DTS support for the
Qualcomm QDU1000 and QRU1000 IDP SoCs, including the clocks, tlmm, smmu,
regulators, mmc, interconnects, cpufreq, and qup. 

This patchset is based off of [1] which adds support for the PMIC arb used
on these SoCs. It also requires the dt-bindings from [2-10].

The Qualcomm Technologies, Inc. Distributed Unit 1000 and Radio Unit
1000 are new SoCs meant for enabling Open RAN solutions. See more at
https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/qualcomm_5g_ran_platforms_product_brief.pdf

[1] https://lore.kernel.org/all/20220914165212.3705892-3-vkoul@kernel.org/
[2] https://lore.kernel.org/all/20221118181826.28269-2-quic_molvera@quicinc.com/
[3] https://lore.kernel.org/all/20221118182039.29236-2-quic_molvera@quicinc.com/
[4] https://lore.kernel.org/all/20221118182245.31035-1-quic_molvera@quicinc.com/
[5] https://lore.kernel.org/all/20221026190534.4004945-2-quic_molvera@quicinc.com/
[6] https://lore.kernel.org/all/20221118182416.4920-1-quic_molvera@quicinc.com/
[7] https://lore.kernel.org/all/20221118182439.10670-1-quic_molvera@quicinc.com/
[8] https://lore.kernel.org/all/20221118182512.10916-1-quic_molvera@quicinc.com/
[9] https://lore.kernel.org/all/20221118182535.11156-1-quic_molvera@quicinc.com/
[10] https://lore.kernel.org/all/20221118182614.11774-1-quic_molvera@quicinc.com/

Changes from v3:
- added PCIE and USB clocks
- added missing qdu1000 compats

Changes from v2:
- Revised device nodes to match updated dt-bindings
- Revised rpmh-rsc bindings to allow for generic regulator nodes
- Updated soc ordering
- Moved clock node to DTS files
- Updated regulator nodes to be generic
- Removed some unnecessary whitespace

Melody Olvera (2):
  arm64: dts: qcom: Add base QDU1000/QRU1000 DTSIs
  arm64: dts: qcom: Add base QDU1000/QRU1000 IDP DTs

 arch/arm64/boot/dts/qcom/Makefile        |    2 +
 arch/arm64/boot/dts/qcom/qdu1000-idp.dts |  266 ++++
 arch/arm64/boot/dts/qcom/qdu1000.dtsi    | 1406 ++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/qru1000-idp.dts |  266 ++++
 arch/arm64/boot/dts/qcom/qru1000.dtsi    |   27 +
 5 files changed, 1967 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/qdu1000-idp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qdu1000.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/qru1000-idp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qru1000.dtsi


base-commit: 147307c69ba4441ee90c1f8ce8edf5df4ea60f67
prerequisite-patch-id: 71560eb092532bd776fd114ce98f47a04d6d1419
prerequisite-patch-id: c39bef976384eacd3ff0c28168bca355e3c1609d
prerequisite-patch-id: ea9b02a15cff4d70f7c6942a6fad3214adf0175c
prerequisite-patch-id: f8cc7d94d174033226b5fc222284c9db61f78680
prerequisite-patch-id: 6a546e15d9d98fe441daed1889bd416658b3a6ec
prerequisite-patch-id: e927a2eb2f856c847f6fecf4cf750039ead05fad
prerequisite-patch-id: 58e23632fbba1fe4c8879d5313c6a1091fb5d2c1
prerequisite-patch-id: 5bc60b1a424af0297cfd64647c41cb3d3e76acc2
prerequisite-patch-id: 0a0f671fae0526d96f745ff1329b0ff8cbec1082
-- 
2.38.1

