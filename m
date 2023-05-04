Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AE76F692A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 12:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjEDKhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 06:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjEDKgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 06:36:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5A046BF;
        Thu,  4 May 2023 03:36:50 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3449OPVT029931;
        Thu, 4 May 2023 10:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=Gs+DmOhHRWHDYg1cDXfBkKwqM3LiqqL9QX4bgbbO2oc=;
 b=PJk9ATm7T9vFeMUidYGdKu2BRENBKjy78VM51Cxm+2Q6qmXzrNG1lleYMlCNJnmxpVNY
 sR01czAWpOHkNR6YC7YrOEmHzMQaZ1HO67gguHJZH1DbrVY9YnURkJ0PcLZEForCa15b
 WSZXlLoaYs77pHk1MddCqX7xNxCrL7+mzJdu+jn+PJznQQwnvLNh6xyz3jgCHvGQ9Dgt
 y8UCu6P3qyPm/FcNjbIjyP9DNkFdRky8SDjM9A4CN4iCXz9ESva3+vBSTtR13pb0zStM
 KVyDeTYojq9pdZTTgY1pFfR+eyVSfSL3Bn9wad5FMkFWRCR3sSferxBPKfEypIO9nlce Bg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qca1j857v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 10:36:46 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 344AagOF002434;
        Thu, 4 May 2023 10:36:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3q8vakt1q8-1;
        Thu, 04 May 2023 10:36:42 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 344Aafcd002428;
        Thu, 4 May 2023 10:36:41 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 344AafR7002427;
        Thu, 04 May 2023 10:36:41 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
        id DBEA2BE0; Thu,  4 May 2023 16:06:40 +0530 (+0530)
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
To:     linux-media@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH 0/4] venus: add support for 10 bit decoding
Date:   Thu,  4 May 2023 16:06:35 +0530
Message-Id: <1683196599-3730-1-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fzzC3Lg326eNa3mP2W50YPXS_YjhxHoG
X-Proofpoint-GUID: fzzC3Lg326eNa3mP2W50YPXS_YjhxHoG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_06,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 mlxlogscore=902 spamscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305040086
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes the changes to
  - add V4L2_PIX_FMT_P010 as supported decoder format.
  - consider dpb color format while calculating buffer
    size for dpb buffers.
  - update dpb and opb color format when bit depth
    changes is detected, also update preferred color
    format to P010 in this case.

With this series, divided the previous version [1] into
multiple patches as suggested in review comments.

[1] https://patchwork.linuxtv.org/project/linux-media/list/?series=10376

Dikshita Agarwal (4):
  venus: add support for V4L2_PIX_FMT_P010 color format
  venus: update calculation for dpb buffers
  venus: add handling of bit depth change from firmwar
  venus: return P010 as preferred format for 10 bit decode

 drivers/media/platform/qcom/venus/helpers.c        | 24 ++++++++++++++++++++++
 drivers/media/platform/qcom/venus/hfi_plat_bufs.h  |  3 +++
 .../media/platform/qcom/venus/hfi_plat_bufs_v6.c   |  8 +++++++-
 drivers/media/platform/qcom/venus/vdec.c           | 16 +++++++++++++--
 4 files changed, 48 insertions(+), 3 deletions(-)

-- 
2.7.4

