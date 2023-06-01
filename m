Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8C2719AAC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 13:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbjFALLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 07:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjFALLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 07:11:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B6B107;
        Thu,  1 Jun 2023 04:11:39 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351Au0ik025517;
        Thu, 1 Jun 2023 11:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=JaqcpbTTaQeCo4nvGyRTbJ+Ro+hMel/HHf2SIx4Z5BM=;
 b=VtARMNBE3ySnlYQsGgoObdch4YYP8vHE9NyD3gKGFhwQrurgwvpHQ068CdlXhEOJ8ham
 b6JzxKMotmoykiChEb5Zwan2iKezayxiTKIDkZnK9rw3Eg10po3dy9PbUT2B0bbe+znR
 /dmRyt3segWm8NJbCF2oP1ZKKdpkrbTuyMfRLRcdXLCtM9AexW2gQz4YMQWg9VFgCevE
 KOF1634kTF3z9hL3OL3x3IlyXJvwzv2VdOnJ7e0Dc26jf3YdRonAnUFGGhdPp7NxkLBl
 kX0H75tz9Q0jHmbYjpvPPPDofOM9/dB6porPqqv5JWrN0aS4aCrQB8+w6dPD0TE2izrV lQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxpt70gfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 11:11:36 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 351BBVva010973;
        Thu, 1 Jun 2023 11:11:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3quaxm8j1w-1;
        Thu, 01 Jun 2023 11:11:31 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 351BBVtQ010967;
        Thu, 1 Jun 2023 11:11:31 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-kbajaj-hyd.qualcomm.com [10.147.247.189])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 351BBV91010966;
        Thu, 01 Jun 2023 11:11:31 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2340697)
        id BFDAC529754; Thu,  1 Jun 2023 16:41:30 +0530 (+0530)
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     Komal Bajaj <quic_kbajaj@quicinc.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v5 0/3] arm64: dts: qcom: qdu1000: add SDHCI
Date:   Thu,  1 Jun 2023 16:41:25 +0530
Message-Id: <20230601111128.19562-1-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vdccAigW2QydXYrlUq7gXPA_XYKtqB-O
X-Proofpoint-GUID: vdccAigW2QydXYrlUq7gXPA_XYKtqB-O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_07,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0
 mlxlogscore=878 priorityscore=1501 phishscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010098
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v5 -
 * Combined sdhc node addition and pin configuration into one commit.

Changes in v4 -
 * Fixed the subject prefix to arm64.
 * Updated the pinctrl entries alphabetically.

Changes in v3 -
 * Removed aliases and dropped "_1" suffix as suggested by Bjorn.
 * Changed pinconfig names.

Changes in v2-
 * Updated the binding alphabetically.
 * Removed extra comments as suggested by Bhupesh.
 * Moved non-removable, no-sd, no-sdio and other properties from
   soc to board dts file as suggested by Bhupesh and Konrad.
 * Removed extra newlines and leading zeroes as suggested by Konrad.
 * Modified sdhc1_opp_table.
 * Updated the SDHC node entries alphabetically.
 * Moved the status entry at the end.

Komal Bajaj (3):
  dt-bindings: mmc: sdhci-msm: Document the QDU1000/QRU1000 compatible
  arm64: dts: qcom: qdu1000: Add SDHCI node
  arm64: dts: qcom: qdu1000-idp: add SDHCI for emmc

 .../devicetree/bindings/mmc/sdhci-msm.yaml    |  1 +
 arch/arm64/boot/dts/qcom/qdu1000-idp.dts      | 23 +++++
 arch/arm64/boot/dts/qcom/qdu1000.dtsi         | 97 +++++++++++++++++++
 3 files changed, 121 insertions(+)

--
2.17.1

