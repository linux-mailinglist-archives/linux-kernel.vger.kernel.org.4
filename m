Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741A674982B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 11:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjGFJUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 05:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjGFJU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 05:20:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BB51BD4;
        Thu,  6 Jul 2023 02:20:29 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3668eXK7016802;
        Thu, 6 Jul 2023 09:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=cyUTwwhy//DJPF6ZbzXPnExvWpVj4WTRSjU6hgyA4Rs=;
 b=bWuNj8kqXNJz6ckgfhuxRV2zuBxzqwMFnwiGj1zUmPfK/SKn58AOKo+olHQCytpQnsx0
 GyBR4qxJ2eevq036+jlq9MwUgRhYWWcQeif4H7ge5f3oQx9YQwH9Z/0UG1oa3/Ng11pR
 ZuRU2EyTXeixCsdtv0QejwOemt5LUIEbsWqjOCtQpdiPjvd6el+/2pppU4NrEWKmfyx2
 vVhTvseoLDg66Fc4xMfN1/D4QnwZ24Y10D7y1kJJwLbVJctHi+ttfuzAVu5eG0f9uIwf
 huGGu5qg+oNAq+7htNJQNpY1wSz2eJcy4DWLSidIDdA0LqMlQN9lAL/BfX/hWL1R201f YA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rndvp1ced-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 09:20:24 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3669KLP1015094;
        Thu, 6 Jul 2023 09:20:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3rjd7ky0x8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 06 Jul 2023 09:20:21 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3669KKX2014745;
        Thu, 6 Jul 2023 09:20:20 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3669KK14014586;
        Thu, 06 Jul 2023 09:20:20 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id E2EAE5FCC; Thu,  6 Jul 2023 14:50:19 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 0/3] Refactor the rpmhpd macros
Date:   Thu,  6 Jul 2023 14:50:15 +0530
Message-Id: <1688635218-23779-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ffTEqaG-ZyJqQjulibDfpdej3nOZ-c5Z
X-Proofpoint-GUID: ffTEqaG-ZyJqQjulibDfpdej3nOZ-c5Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_06,2023-07-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=500
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060082
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

This series updates the rpmhpd macros defined to use a more generic
set of macros to avoid adding SoC specific entry everytime. This increases
the reusability of the macros and almost deletes 300 lines of code.

The macros are arranged based on the frequencies in the SoC entry
in the driver to avoid extra wastage of memory.

Thanks,
Rohit.

Rohit Agarwal (3):
  dt-bindings: power: rpmpd: Remove the SoC specific entries
  soc: qcom: rpmpd: Update the entries of PD macros
  soc: qcom: rpmphd: Update the entries of PD macros

 drivers/soc/qcom/rpmhpd.c              | 338 ++++++++++++++--------------
 drivers/soc/qcom/rpmpd.c               | 216 +++++++++---------
 include/dt-bindings/power/qcom-rpmpd.h | 389 ++++-----------------------------
 3 files changed, 323 insertions(+), 620 deletions(-)

-- 
2.7.4

