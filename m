Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAD070DE51
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237101AbjEWN6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237146AbjEWN6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:58:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FB9130;
        Tue, 23 May 2023 06:57:44 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NDslAA032160;
        Tue, 23 May 2023 13:57:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=gW5eRtveF2FwSHEpiEFVed17/QTNq+DA/YTAEZagdJM=;
 b=N82MzKg8htjWCHvjDQyXPTQ3WFAF26caAALyG7I7tTd1bW1JpvHh8W4z1suYhlvmTO2B
 xcSRwOSUPMlIdLQRvMUgLlg15mfy1WgjkHPCAgAyD50akjJrAMjALn6zHragn8UiVU0w
 UC8rE1TBU1ip5vfmgG2VLQZWyZ42f2QPpvBQbYGmithy21GjK4y3PF9sc52d9Bp4KWv1
 c4hW1jbeGgCblTWf6XDr1matWR2ldSKt9BtxMd8tTSz4NAB3+zjNOWcXLchEAIyUpioU
 QxVwLcRYlbKwluezLI1yAwYBB6Y0m170vPqTmM/70O4Ie/j+Bcpj6FzgUBSj7hp8DKXW JA== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qr6h0u7aw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 13:57:41 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34NDvaDV032137;
        Tue, 23 May 2023 13:57:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3qpq9kjvsv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 23 May 2023 13:57:36 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34NDvart032132;
        Tue, 23 May 2023 13:57:36 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-kbajaj-hyd.qualcomm.com [10.147.247.189])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 34NDvZPN032131;
        Tue, 23 May 2023 13:57:36 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2340697)
        id 25C54529754; Tue, 23 May 2023 19:27:35 +0530 (+0530)
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
Subject: [PATCH v3 0/4] arm64: dts: qcom: qdu1000: add SDHCI
Date:   Tue, 23 May 2023 19:27:29 +0530
Message-Id: <20230523135733.3852-1-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CiwWHCh7sqbc92iBA0pTR93-5fXN8EQ7
X-Proofpoint-ORIG-GUID: CiwWHCh7sqbc92iBA0pTR93-5fXN8EQ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_09,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=756 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230109
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sdhc instance for supporting eMMC on QDU1000 and
QRU1000 SoCs.

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
  arm: dts: qcom: qdu1000: Add SDHCI node
  arm64: dts: qcom: qdu1000: Add SDHCI pin configuration to DTSI
  arm64: dts: qcom: qdu1000-idp: add SDHCI for emmc

 .../devicetree/bindings/mmc/sdhci-msm.yaml    |  1 +
 arch/arm64/boot/dts/qcom/qdu1000-idp.dts      | 23 +++++
 arch/arm64/boot/dts/qcom/qdu1000.dtsi         | 97 +++++++++++++++++++
 3 files changed, 121 insertions(+)

--
2.17.1

