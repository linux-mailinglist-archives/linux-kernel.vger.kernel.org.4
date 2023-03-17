Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA156BE15E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 07:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjCQGje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 02:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjCQGja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 02:39:30 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A835BDBD;
        Thu, 16 Mar 2023 23:39:11 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32H6JwQt004498;
        Fri, 17 Mar 2023 06:38:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=pDWQnqNyjpbCezBdx2gkQLrqL0n1VlRnEw54BojTBow=;
 b=Z6DKxwmD9c/ZIJ/O/xvns+kbUOlgt4xm6Km4lJ5YW01W8lLBcP8QGhoM4Y7Cta9/fLGE
 jQ+tQyiRROEiX9gkraogii2M8s41jNP5NlA+W5M9pWvNFOlS6/ZLEDaIYdxKeqmqTVmd
 kSpHfY1uf5EQ+qt0/fGs7k3Yu0Oa/u2BZl+gjFII2V1S26JEFNqyeZ1/KYBbcRmDS/Fc
 M2sCMmoQkRA9DvXuACLoyjD1gL0RtrmtNVJRTnvMxfdCUECwXkKxXLwMm1G2dENl5WtH
 GdIc2Cl4zm8TOe+Y/iBYChBKKYkNlR3IfMuUHAn/xnNJ1RoWiux9jas07+KLe9aht3gL YA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pbpxjvbf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 06:38:41 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 32H6ca0o000618;
        Fri, 17 Mar 2023 06:38:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3p8jqmd71c-1;
        Fri, 17 Mar 2023 06:38:36 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32H6cau5000611;
        Fri, 17 Mar 2023 06:38:36 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 32H6cZma000608;
        Fri, 17 Mar 2023 06:38:36 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 5B7184E4A; Fri, 17 Mar 2023 12:08:35 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v3 0/2] Add support for PCIe PHY in SDX65
Date:   Fri, 17 Mar 2023 12:08:32 +0530
Message-Id: <1679035114-19879-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BiUNjYERgVPprdTpwc6GEiNd2q67JLfh
X-Proofpoint-ORIG-GUID: BiUNjYERgVPprdTpwc6GEiNd2q67JLfh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_03,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0
 priorityscore=1501 bulkscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170044
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes in v3:
 - Addressed minor comments from Krzysztof of removing redundant binding
   usage in commit message.

Changes in v2:
 - Addressing Dmitry's comments and adjusting according to new bindings.
 - Rebased on top of 6.3-rc1.

This series adds support for PCIe PHY found in Qualcomm SDX65 platform.
The PHY version is v5.20 which has different register offsets compared with
previous v5.0x and v4.0x versions. So separate defines are introducted to
handle the differences.

Thanks,
Rohit.


Rohit Agarwal (2):
  dt-bindings: phy: qcom,qmp: Add SDX65 QMP PHY
  phy: qcom-qmp: Add support for SDX65 QMP PCIe PHY

 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   |   1 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           | 165 +++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h |   3 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5_20.h      |   1 +
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v5_20.h |  24 +++
 5 files changed, 194 insertions(+)

-- 
2.7.4

