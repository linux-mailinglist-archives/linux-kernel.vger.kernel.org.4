Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551146AB5E4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 06:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjCFFTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 00:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCFFTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 00:19:08 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2512AF950;
        Sun,  5 Mar 2023 21:19:07 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3264XMUX007353;
        Mon, 6 Mar 2023 05:18:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=T2YRtykldqSv9nxcM/r272FE9sEvHFw89ybca6/KIpQ=;
 b=SXB9+JUHxRXZV3QIotX/dtFfv0v7z5E+pNZShX8liDvyrZWPbsvkrpj1N+bsO8cW5Yqr
 I3ToJczFivOjJ2rzpBnUWmYFQisL7vuNYDs4IM7IcfhD3H4hwPtMV4jzi98SY/60waGE
 PpBRokfGULYJhQCZkcS3R4aUTbsKjmGjrnG75i01g0Q+q5T9Yyb/n/sqMz2eFx9NCZl1
 yapzu1YVKM3fPTclniztyTUss4zfgeLv1vT3v3I/YD7MyfYAT3/XKWkNg7EHHMcKqoK2
 kw0iMGXEiTl4iH1k2LWfb7BHNmUN4zYjLh4tB8Z4HXs9HZEcOf809I0tu6E6a62D3wvR dQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p420c3b5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 05:18:52 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3265Il2w011020;
        Mon, 6 Mar 2023 05:18:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3p4fgk72et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 06 Mar 2023 05:18:47 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3265IlZl011012;
        Mon, 6 Mar 2023 05:18:47 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3265Ik5L011011;
        Mon, 06 Mar 2023 05:18:47 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id 172EC4F98; Mon,  6 Mar 2023 10:48:46 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, manivannan.sadhasivam@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 0/2] Add support for PCIe PHY in SDX65
Date:   Mon,  6 Mar 2023 10:48:31 +0530
Message-Id: <1678079913-27945-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pRjMpeR0P27gfHGdAkp4lVCwsHw5nJ53
X-Proofpoint-GUID: pRjMpeR0P27gfHGdAkp4lVCwsHw5nJ53
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-05_12,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0 mlxlogscore=798
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303060042
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds support for PCIe PHY found in Qualcomm SDX65 platform.
The PHY version is v5.20 which has different register offsets compared with
previous v5.0x and v4.0x versions. So separate defines are introducted to 
handle the differences.

Thanks,
Rohit.

Rohit Agarwal (2):
  dt-bindings: phy: qcom,qmp: Add SDX65 QMP PHY binding
  phy: qcom-qmp: Add support for SDX65 QMP PCIe PHY

 .../bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml    |   3 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           | 163 +++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h |   3 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5_20.h      |   1 +
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v5_20.h |  24 +++
 5 files changed, 194 insertions(+)

-- 
2.7.4

