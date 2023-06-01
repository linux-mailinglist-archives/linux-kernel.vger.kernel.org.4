Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4BE7193BF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 08:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjFAG6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 02:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbjFAG6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 02:58:18 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330D2E7;
        Wed, 31 May 2023 23:58:17 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3515bfg7025217;
        Thu, 1 Jun 2023 06:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=oFaI1nJbgP2WPXUecZ+68jMuZFAE6Dz2qina3grRsmQ=;
 b=kw2W0klhFAMBN0uHojxt48n6XgRlyilcQYs+whRmtuZ8oI/93zvE7gA6XalptfUWPM68
 7AfALYqbu62ip+UWTJAqHPGbh8ffdxDWjef8SNKyst3IKEyIKIX1LmflLRnXD0p8c98F
 xqyORkBREllgMniqPVND+DDc9rfCTpzaU5zEMMuSP4Xlh7+smaVCmbUGk5iTdUE7NtwD
 zEsWo4o8EThl08BL5z8Iho9l7jcriPssZvfYgsjO+oi40HdNc21NLWwi3qsHDkqycaDT
 3qN8VMXrZlUvkt6LhVLNV/2ofKrOoCrJs+Oinj+CGZoG1xSgO+la6xrPzGnMC4gEq34z Pg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxc7995pc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 06:58:13 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3516w86l022036;
        Thu, 1 Jun 2023 06:58:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3quaxm7e7y-1;
        Thu, 01 Jun 2023 06:58:08 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3516w8Qq022009;
        Thu, 1 Jun 2023 06:58:08 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-kbajaj-hyd.qualcomm.com [10.147.247.189])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3516w8Nq021944;
        Thu, 01 Jun 2023 06:58:08 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2340697)
        id 09C7E529756; Thu,  1 Jun 2023 12:28:07 +0530 (+0530)
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
Subject: [PATCH v4 0/4] arm64: dts: qcom: qdu1000: add SDHCI
Date:   Thu,  1 Jun 2023 12:28:01 +0530
Message-Id: <20230601065805.18079-1-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sPJy1jAjQsq61BCDEZH2LanzXmY5id4O
X-Proofpoint-ORIG-GUID: sPJy1jAjQsq61BCDEZH2LanzXmY5id4O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_04,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 mlxlogscore=772
 adultscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010061
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sdhc instance for supporting eMMC on QDU1000 and
QRU1000 SoCs.

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

Komal Bajaj (4):
  dt-bindings: mmc: sdhci-msm: Document the QDU1000/QRU1000 compatible
  arm64: dts: qcom: qdu1000: Add SDHCI node
  arm64: dts: qcom: qdu1000: Add SDHCI pin configuration to DTSI
  arm64: dts: qcom: qdu1000-idp: add SDHCI for emmc

 .../devicetree/bindings/mmc/sdhci-msm.yaml    |  1 +
 arch/arm64/boot/dts/qcom/qdu1000-idp.dts      | 23 +++++
 arch/arm64/boot/dts/qcom/qdu1000.dtsi         | 97 +++++++++++++++++++
 3 files changed, 121 insertions(+)

-- 
2.17.1

