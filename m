Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD6C68171E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 18:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237290AbjA3RCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 12:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236938AbjA3RCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 12:02:21 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC78EFF11;
        Mon, 30 Jan 2023 09:02:18 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UEO31n006571;
        Mon, 30 Jan 2023 17:02:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=2z6IWrm09lruGKFJYOS7E9jOrBVTkH7sZzY1C69I47M=;
 b=Ki2k9TDS5dn77XJSTPpOjE/huCb4bxeX7TSLHChF7aV53DqBIEZk/CFt0Ir+bI/M8stW
 Ds3IksC/lkiqnDxCP+Xk3gLm7ECkYumeUf9Croa3kzz1Sx/ManGrKlH5yPM0P+48hajt
 p11qbXJXI14Kemy7lbnjUMjA2lyS952EwMI6aJPXkh5AZ9IsGxCugyx+/NRBKatwP4UY
 rUNX5yxpPbThW08HJLtO/nOdkMO60grVqy3aZUwHBS/qiEzeL6yyajDESRJZySe+/u/v
 DUMEDv3MYqg7fP/Uw2uvy1TASO4qL7KNrjKZJ2jAEY5FmWk1jNU09HN9GXGzeKuiQ7KE rQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nefmfrbh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 17:02:13 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30UH2CHO018066
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 17:02:12 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 30 Jan 2023 09:02:09 -0800
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH 0/3] Add the download mode support for IPQ5332
Date:   Mon, 30 Jan 2023 22:31:52 +0530
Message-ID: <20230130170155.27266-1-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SOo-i6PkPgabvng6LOiwL1fU8rfMW87d
X-Proofpoint-GUID: SOo-i6PkPgabvng6LOiwL1fU8rfMW87d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_16,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 priorityscore=1501 mlxlogscore=679 suspectscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301300165
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the support for download mode to collect the RAM dumps if
system crashes, to perform the post mortem analysis.

During the bootup, bootloaders initialize the SMEM. However the bootup
after crash, SMEM will not be intialized again. If the memory for the
SMEM is not reserved, linux consumes that region, which leads to the
loss of SMEM data. So, during the next bootup after crash, bootloaders
will hang due to invalid data present in the SMEM region. Due to this,
added the SMEM support along with this series.

This series depends on the IPQ5332 baseport patches
https://lore.kernel.org/linux-arm-msm/20230130114702.20606-1-quic_kathirav@quicinc.com/T/#t

Kathiravan T (3):
  dt-bindings: mfd: qcom,tcsr: add compatible for IPQ5332
  arm64: dts: qcom: ipq5332: enable the download mode support
  arm64: dts: qcom: ipq5332: add SMEM support

 .../devicetree/bindings/mfd/qcom,tcsr.yaml    |  1 +
 arch/arm64/boot/dts/qcom/ipq5332.dtsi         | 20 +++++++++++++++++++
 2 files changed, 21 insertions(+)

-- 
2.17.1

