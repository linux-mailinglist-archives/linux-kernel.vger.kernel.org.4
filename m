Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1663672D405
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 00:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238430AbjFLWEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 18:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238368AbjFLWDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 18:03:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA3010C2;
        Mon, 12 Jun 2023 15:03:50 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CLpUjG007363;
        Mon, 12 Jun 2023 22:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=g0jcez2nstLVW2iarNEvZx6vEL3dr5pkytXSctylQjQ=;
 b=e/aJOlohe9H3ZE05c9nybpvUrEeN7wI8yes0OH38tU6QdytTW6rkNQCbB4c+K96USYt8
 Gg0tvuPHeuG5Yt57q5wKOVrNow/aYP5HkcqZPWYDi7B3alX772qYiv9dTkper2vkVDBq
 ghHmPLxpvyig17Ws1KLIsK/+X2srF/ceI64vLRlX0CQUFHM98FSJWlleDSyIJVu7QbQX
 vCNVp4IhbA+O3dKsjwk3fnnYE/4mYV4hIRz61WK310zpHzaijAS3DVEpAml9WaF6HdnA
 9l4GobkiV43fDtqgu0Qqo3XIbZaGyVqBuUW40Wa0rmwaqSF4KU1hqGM4WufKXxJCyWuJ iw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r68x9896g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 22:03:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35CM3i0g009912
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 22:03:44 GMT
Received: from hu-gokukris-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 12 Jun 2023 15:03:44 -0700
From:   Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        "Elliot Berman" <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
Subject: [PATCH v5 0/2] Patches for introducing traces in remoteproc.
Date:   Mon, 12 Jun 2023 15:03:24 -0700
Message-ID: <cover.1686606835.git.quic_gokukris@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cyt0ApF6NnSrwASddo5e5zU5arhUfkZk
X-Proofpoint-ORIG-GUID: cyt0ApF6NnSrwASddo5e5zU5arhUfkZk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_16,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 suspectscore=0 mlxlogscore=737 mlxscore=0 adultscore=0 malwarescore=0
 clxscore=1011 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120189
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V5: Add more text to Kconfig
    Move this trace point to function rproc_load_segments() and rename
    it to trace_rproc_load_segment_event()
    
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

 drivers/remoteproc/Kconfig                    |   9 ++
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/qcom_common.c              |  37 +++++
 drivers/remoteproc/qcom_q6v5.c                |   9 ++
 drivers/remoteproc/remoteproc_core.c          |   5 +
 drivers/remoteproc/remoteproc_internal.h      |   9 +-
 drivers/remoteproc/remoteproc_tracepoints.c   |  14 ++
 include/trace/events/remoteproc_tracepoints.h | 152 ++++++++++++++++++
 8 files changed, 234 insertions(+), 2 deletions(-)
 create mode 100644 drivers/remoteproc/remoteproc_tracepoints.c
 create mode 100644 include/trace/events/remoteproc_tracepoints.h


base-commit: 1ca04f21b204e99dd704146231adfb79ea2fb366
-- 
2.40.1

