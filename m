Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57408718BC9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 23:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjEaV3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 17:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjEaV3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 17:29:05 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58BA12F;
        Wed, 31 May 2023 14:29:03 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VKoMrY014425;
        Wed, 31 May 2023 21:29:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=rApv4sUJLYfAI0nOdKLeu9I3ORwewunV2k+JVYFJSn4=;
 b=nSpODrt3Z1IiQ8c3GI/V27pCxDocbgQ640diMTc3wnlxn8xRFDu3Y+yuT1bh7w3bukO9
 yTI6L08Vf7+XsCWwtCRVhac7Wyrd2r5RaFLRQXluGZrn6d1yf2eGpUYUdsFwPIiVrhFw
 r5rYnq/8DpS+oKfUmZCXYEs9afvtVkiekMpyGQqrgXey639hID5bbt8Oome0Huwg9FhG
 iQKLU9OhbYucr8/q9fU+DLEJDsk4J1uGv7S9pcW8zR0gPXVWeIJtnU8SxOijw6SH/FAH
 laZWfS3rsWjaDHdZlP07VeTKyW6fMxZEf6TFxfQq6X7ubquDsF2HP1Ow+YGQVF/m2Ooi xg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qx81x8wqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 21:28:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34VLSwxu008028
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 21:28:58 GMT
Received: from hu-gokukris-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 31 May 2023 14:28:58 -0700
From:   Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
To:     <linux-remoteproc@vger.kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        "Elliot Berman" <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
Subject: [PATCH v4 0/2] Patches for introducing traces in remoteproc.
Date:   Wed, 31 May 2023 14:28:38 -0700
Message-ID: <cover.1685486994.git.quic_gokukris@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8G7ePeS4rLkPq7KfDD5AkqyY7k6svIwv
X-Proofpoint-ORIG-GUID: 8G7ePeS4rLkPq7KfDD5AkqyY7k6svIwv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_16,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=609 malwarescore=0
 adultscore=0 bulkscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305310180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V4: Add config symbol REMOTEPROC_TRACEPOINTS to enable traces
    Rename rproc_qcom.h to remoteproc_tracepoints.h
    Rename qcom_tracepoints.c to remoteproc_tracepoints.c
    Switch to EXPORT_SYMBOL_GPL

V3: Split the Patch to 2 as per suggestion from Mukesh, fixed format
error from v2. 

V2: Moved the traces to common code from the qcom_pas driver as per
Bjorns review, fixed text as per Triloks suggestion, Updated QuiC
copyright to 2023.

[1]: https://lore.kernel.org/all/20230224165142.17745-2-quic_gokukris@quicinc.com/

Gokul krishna Krishnakumar (2):
  remoteproc: Introduce traces for remoteproc events
  remoteproc: qcom: Add remoteproc tracing

 drivers/remoteproc/Kconfig                    |   5 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/qcom_common.c              |  37 +++++
 drivers/remoteproc/qcom_q6v5.c                |   9 ++
 drivers/remoteproc/remoteproc_core.c          |   8 ++
 drivers/remoteproc/remoteproc_tracepoints.c   |  13 ++
 include/trace/events/remoteproc_tracepoints.h | 129 ++++++++++++++++++
 7 files changed, 202 insertions(+)
 create mode 100644 drivers/remoteproc/remoteproc_tracepoints.c
 create mode 100644 include/trace/events/remoteproc_tracepoints.h

-- 
2.40.1

