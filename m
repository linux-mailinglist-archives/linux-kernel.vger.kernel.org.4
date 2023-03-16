Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350026BC916
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 09:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjCPI13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 04:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjCPI1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 04:27:25 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640FDB1B01;
        Thu, 16 Mar 2023 01:27:07 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32G8AD5h026305;
        Thu, 16 Mar 2023 08:26:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=2m6JDE9NY+sbW+Rj+LHW7Dj8/784CJgrhW6r+Ropmas=;
 b=oiRN7JtwwpemvOrEFX1C4wJfSoUhGSdr2Bu9DnugAokoqg7ecTtc0rAidJDZReBaGkdR
 XWyr82oA86zJlZ3gDbAdCVnIhhCEDBMuXE2eFQZoMoTxMExvs1vm6pyPYmxrgooVs2gZ
 MCpKRJQK6D9Nr3Rmigbl6a1HF2OmxzdLakugI8naJMMS6JqkiIu18ioiKFjCahddI7Hb
 q8ZzDZE2Q3+zepBhgZSxA1pcJK8oVWJz21MCxbnDBZajcJn8M0zbAvd2/1fvu0r0V99X
 ZgyeM9zqENz2A6uJbRy9ZsQca7I5Q8AONBZ11qFXlkNH4PHQDQAoLQusyRQYYTcdElfg 1Q== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pbpyd16cs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 08:26:47 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 32G8QVNp032735;
        Thu, 16 Mar 2023 08:26:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3p8jqm760d-1;
        Thu, 16 Mar 2023 08:26:31 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32G8QV28032729;
        Thu, 16 Mar 2023 08:26:31 GMT
Received: from vboma-linux.qualcomm.com (vboma-linux.qualcomm.com [10.204.65.94])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 32G8QVfX032728;
        Thu, 16 Mar 2023 08:26:31 +0000
Received: by vboma-linux.qualcomm.com (Postfix, from userid 72083)
        id 6008C900889; Thu, 16 Mar 2023 13:56:30 +0530 (IST)
From:   quic_vboma@quicinc.com
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Viswanath Boma <quic_vboma@quicinc.com>
Subject: [PATCH 0/1] Add support for qp min/max.
Date:   Thu, 16 Mar 2023 13:56:26 +0530
Message-Id: <20230316082627.19279-1-quic_vboma@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mImbhoWX_1RVoJXUKfPlhMgEh9o7qZ-K
X-Proofpoint-ORIG-GUID: mImbhoWX_1RVoJXUKfPlhMgEh9o7qZ-K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_06,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 spamscore=0 mlxlogscore=847 adultscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303160071
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viswanath Boma <quic_vboma@quicinc.com>

Tested the changes on v5.15 kernel .
For testing Chrome Utilities were used .

Viswanath Boma (1):
  venus: Add support for min/max qp range.

 drivers/media/platform/qcom/venus/hfi_cmds.c  | 27 +++++++++++-
 .../media/platform/qcom/venus/hfi_helper.h    | 18 ++++++++
 drivers/media/platform/qcom/venus/venc.c      | 41 +++++++++++++++----
 3 files changed, 77 insertions(+), 9 deletions(-)

-- 
2.17.1

