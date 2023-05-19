Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0461C70921E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 10:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjESIvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 04:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjESIvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 04:51:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30B3E60;
        Fri, 19 May 2023 01:51:34 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34J5kX8k011304;
        Fri, 19 May 2023 08:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=NqfMSGyejtd7hHlos/ybp52anLKXsVayULsLsvj27AQ=;
 b=pPmpvWcTjcg4u+aIl3e1MWgQUaSUbpqszX6shatJ2pBq1wyPciCWDrUn1y2oa+x3QhLB
 zbNGrEb3ARlV4Yq+kOlwbSeoOlR+DL+c5vqUvpzeNbHm9vXTcREw2YnIpr3emKfTTeLv
 mOVkuFfxTlf2zDmx4ibFZHdtxmlXPACQ/PJsJuzqLfUpm3EKlQiwxSqBwzum7UFylap9
 Qo9WevX2yyeyuWbOYm9AWyXpU3w8rhUnX0yCRre6RIwx4IyEzzKfpyekhRJO29VK5HAu
 FG94WPhogJrub9sfWhiiJITHCLIi6JqDKkx/iuM4ecW6SgFl/KGt0rqGOq+WmJ+II+x7 +g== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qn73uusp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 08:51:30 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34J8pQ1s012724;
        Fri, 19 May 2023 08:51:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3qj3mkd0pp-1;
        Fri, 19 May 2023 08:51:26 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34J8pQce012717;
        Fri, 19 May 2023 08:51:26 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-kbajaj-hyd.qualcomm.com [10.147.247.189])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 34J8pQRK012715;
        Fri, 19 May 2023 08:51:26 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2340697)
        id 482E5529754; Fri, 19 May 2023 14:21:25 +0530 (+0530)
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
Subject: [PATCH 0/4] arm64: dts: qcom: qdu1000: add SDHCI
Date:   Fri, 19 May 2023 14:21:18 +0530
Message-Id: <20230519085122.15758-1-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gGksuK6rdwpiFzhDXhNebqUicjr-_utd
X-Proofpoint-GUID: gGksuK6rdwpiFzhDXhNebqUicjr-_utd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_05,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=674 malwarescore=0
 impostorscore=0 bulkscore=0 mlxscore=0 clxscore=1015 adultscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190074
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sdhc instance for supporting eMMC on QDU1000 and
QRU1000 SoCs.

Komal Bajaj (4):
  dt-bindings: mmc: sdhci-msm: Document the QDU1000/QRU1000 compatible
  arm: dts: qcom: qdu1000: Add SDHCI node
  arm64: dts: qcom: qdu1000: Add SDHCI1 pin configuration to DTSI
  arm64: dts: qcom: qdu1000-idp: add SDHCI for emmc

 .../devicetree/bindings/mmc/sdhci-msm.yaml    |   1 +
 arch/arm64/boot/dts/qcom/qdu1000-idp.dts      |  11 ++
 arch/arm64/boot/dts/qcom/qdu1000.dtsi         | 110 ++++++++++++++++++
 3 files changed, 122 insertions(+)

--
2.17.1

