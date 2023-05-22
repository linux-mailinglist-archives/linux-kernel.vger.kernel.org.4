Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC4D70B925
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbjEVJgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbjEVJgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:36:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160C3C2;
        Mon, 22 May 2023 02:36:32 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M71f48006749;
        Mon, 22 May 2023 09:36:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=IU5GSpNQam5JXVy8c8hUt0xYtifKOQabGtvABMt9bXw=;
 b=MzotGntYcg1s4EJDmx7c1JgBQ/I7Y5FPrmk/AjrRlUqHAIG8FcAg1PZxikFJEE2t4B7H
 mh0ks3VqfhyMAaJDzuI5LlUVJczgEHiDNfKMgHvP9FvQdtDRKNj9RZZ0drqwE3/k5322
 vwMZDFcmZWaU7na9EQekhmRnV0eLNteZNY0rwpJMY5Wuc/E9rS2swfHhPgVN/ObtolI+
 UPgutracXWROqo2k+MoVX1GnSA5CUYbc6b/g8QqkLGqzxpKfYgCdKA/JE6NUgRQOwjq1
 9ZA4pZ1nntphTyIOfjgqD9LhuueMa0340DzAQmZKbFfUvlOZfYNbacA9sfyiUIalndGM Sw== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qppe9b8vx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 09:36:27 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34M9aNKW026218;
        Mon, 22 May 2023 09:36:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3qpq9kn8ey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 22 May 2023 09:36:23 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34M9aN9Q026210;
        Mon, 22 May 2023 09:36:23 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-kbajaj-hyd.qualcomm.com [10.147.247.189])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 34M9aNu0026209;
        Mon, 22 May 2023 09:36:23 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2340697)
        id 57FB35001C2; Mon, 22 May 2023 15:06:22 +0530 (+0530)
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
Subject: [PATCH v2 0/4] arm64: dts: qcom: qdu1000: add SDHCI
Date:   Mon, 22 May 2023 15:06:16 +0530
Message-Id: <20230522093620.3568-1-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yyEZHFxXD5hXcXyaObS5Y4UD5rUAu8Dr
X-Proofpoint-ORIG-GUID: yyEZHFxXD5hXcXyaObS5Y4UD5rUAu8Dr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_06,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015
 mlxlogscore=679 priorityscore=1501 mlxscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220081
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
  arm: dts: qcom: qdu1000: Add SDHCI node
  arm64: dts: qcom: qdu1000: Add SDHCI1 pin configuration to DTSI
  arm64: dts: qcom: qdu1000-idp: add SDHCI for emmc

 .../devicetree/bindings/mmc/sdhci-msm.yaml    |   1 +
 arch/arm64/boot/dts/qcom/qdu1000-idp.dts      |  23 ++++
 arch/arm64/boot/dts/qcom/qdu1000.dtsi         | 101 ++++++++++++++++++
 3 files changed, 125 insertions(+)

-- 
2.17.1

