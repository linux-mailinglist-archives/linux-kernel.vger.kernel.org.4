Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580F66AD2C3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 00:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjCFXRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 18:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCFXRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 18:17:37 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7373D0AD;
        Mon,  6 Mar 2023 15:17:36 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326LKKcc028230;
        Mon, 6 Mar 2023 23:17:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=AW0wcVCWpuj4USY+2+sS3505mnxlahyE1fGqYZPyiNA=;
 b=H0w3qptKAaCgP6MmOKzgxDTCPiEnyc7IwgDJ0ZgBpx9ZN8ugO0kE/auOMM12Sy1rAkiZ
 U+Ymwa+z9dTl9lxePRK2DSulBtnNWm1qAWGF9WPZ4+wl6Nm85ogSJ6a8lD0LJSXVXeIO
 ZdNNRsfKh+4LjxXoWu3w66PzDaHKYdGG9s+YdNRsnIw1dS4JyPvgLdwRhdbsosQBZ4GW
 LPVDl+CAU4w+X3nhoL5aG8sruIoKYgbtWqa2sWoJcuUz4ihluwMji0JX7rbm1uusWkSM
 r35uye7X4xuWGSMxipnSj6Obvc66VtGrDdpor056im7ceUgliQAanazhfd8N23Tuad7x rw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p41876b84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 23:17:33 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 326NHWkI027826
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Mar 2023 23:17:32 GMT
Received: from hu-molvera-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 6 Mar 2023 15:17:32 -0800
From:   Melody Olvera <quic_molvera@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/3] arm64: dts: qcom: Add mpss support to QDU1000/QRU1000 SoCs
Date:   Mon, 6 Mar 2023 15:17:16 -0800
Message-ID: <20230306231719.22263-1-quic_molvera@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GZJmy9_wUHZ4xCcqT_3jS4gli3YCDn8d
X-Proofpoint-ORIG-GUID: GZJmy9_wUHZ4xCcqT_3jS4gli3YCDn8d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_14,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=381 bulkscore=0 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303060202
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the mpss found in the QDU1000 and QRU1000 SoCs.
It needs an RMB register space to be specified to enable a handshake
with the mpss to late attach the device. The firmware file paths are
also added in the IDP board DTs.

This patch set depends on the bindings from [1].

[1] https://lore.kernel.org/all/20230306231202.12223-1-quic_molvera@quicinc.com/

Changes from v1:
* Removed power domain cells from aoss qmp node
* Renamed firmwares to follow convention

Melody Olvera (3):
  arm64: dts: qcom: qdu1000: Add IPCC, MPSS, AOSS nodes
  arm64: dts: qcom: qdu1000-idp: Enable mpss
  arm64: dts: qcom: qru1000-idp: Enable mpss

 arch/arm64/boot/dts/qcom/qdu1000-idp.dts |   6 ++
 arch/arm64/boot/dts/qcom/qdu1000.dtsi    | 104 +++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/qru1000-idp.dts |   6 ++
 3 files changed, 116 insertions(+)


base-commit: dc837c1a5137a8cf2e9432c1891392b6a66f4d8d
prerequisite-patch-id: ddc43db334e06b6938219e12964a5e943641126d
prerequisite-patch-id: 7c8c18aef7f693eb0749ee9f296bfb59ca202eb7
prerequisite-patch-id: a87ffdabbfee46017956f62034219e6a0cb01724
prerequisite-patch-id: 3a012cc3a5b28208ecf23b2a1b5a0310d15aa4ac
prerequisite-patch-id: ad32654fa37f8c5fb00162d093b577f81a511bd0
prerequisite-patch-id: d699495a3b22bb97c9d114024a82a9fadcc40082
prerequisite-patch-id: def4c2cb2a10130f67cdfb90f9c2de3d3d738f77
-- 
2.25.1

