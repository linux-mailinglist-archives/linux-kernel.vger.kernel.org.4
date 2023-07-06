Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533F2749CAB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbjGFMuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbjGFMut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:50:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F2E1FCB;
        Thu,  6 Jul 2023 05:50:17 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366CaDAH012996;
        Thu, 6 Jul 2023 12:50:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=e1TGd3+wLyDl8VI1Izw1MfpNNgf5pMn/87NhrPgcREQ=;
 b=Un+CA1D7R038SRsfVbe26WAz8rAxXzQlM24WvTR9jNnsPEWcgMlOa+SsbkawGhJSOjFm
 OPrjHJgQIyhJZPlZHvIGhopp91WRQ6p277qrygneL35pd1C/wjcSx2FlgLRVpmOBDNDs
 tYHoI2HSjIFxVkSSx+UCm2donJRSdqAM1uW+PeMIKuOSm8GQttf16mPUUwOSJMjWCc8r
 t+rA0PyhEz+URGdams+D8l8r7YCeia6LsGJ2KmtML5DaXh+PI+jsC5jq+yikCSNlnG6c
 aeqIEzrFChMnT1q7O5SOXPUbvyQXZc6Pk9YXlGEbuPE90muo+B8S46m91BaHo3oQasfR Ig== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rntctrdhs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 12:50:03 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 366Co0Pq024162;
        Thu, 6 Jul 2023 12:50:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3rjd7kywah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 06 Jul 2023 12:50:00 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 366Cnx8M024150;
        Thu, 6 Jul 2023 12:49:59 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 366Cnxtv024146;
        Thu, 06 Jul 2023 12:49:59 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id F36F85FE1; Thu,  6 Jul 2023 18:19:58 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 0/3] Add support of rpmhpd for SDX75
Date:   Thu,  6 Jul 2023 18:19:50 +0530
Message-Id: <1688647793-20950-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YIVp2Ad2cswwqsOWhDP6zjkzSg4qFxhu
X-Proofpoint-ORIG-GUID: YIVp2Ad2cswwqsOWhDP6zjkzSg4qFxhu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_09,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=535 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060115
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds the support of rpmhpd for sdx75 and also
adds the generic bindings for the PD to be used henceforth.

Thanks,
Rohit.

Rohit Agarwal (3):
  dt-bindings: power: rpmpd: Add Generic RPM(h) PD indexes
  dt-bindings: power: Add compatible for sdx75
  soc: qcom: rpmhpd: Add SDX75 power domains

 .../devicetree/bindings/power/qcom,rpmpd.yaml      |  1 +
 drivers/soc/qcom/rpmhpd.c                          | 16 +++++++
 include/dt-bindings/power/qcom-rpmpd.h             | 49 ++++++++++++++++++++++
 3 files changed, 66 insertions(+)

-- 
2.7.4

