Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E8B6A200F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 17:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjBXQwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 11:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjBXQwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 11:52:09 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411523B870;
        Fri, 24 Feb 2023 08:52:08 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OCRaQx021753;
        Fri, 24 Feb 2023 16:52:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=IXOV/Pl+6HvvKUoHRdbwlBYeiO8T+VIFrZd+vLHC6YQ=;
 b=ZF1tTUH/L+BUjdth+u3hseN0SJoR6EwgNG7XY0bjRESTW8PJetwFRHWKTYsooAlNODW4
 ry+MxlBbIPzrRWf6ukdMm8MHopaCkNyNN6LkW0USz4OzG1OjDp48OMXZZNTDIRscOsDe
 7l025oeZBV6USVBwpKxJd5qWG3H/DEcxvCq/Xv5iu/r2ioQq6K+o6ix1uMAeb8ORUtY4
 O/5nw2rvgkPzFJKeiGYTuXypOyc/LNFxVzw299DWfsZB3JJMLxFaEax7C5d0k0uqnsNc
 otaszT9A3tzpSUSHiLknpav+N0MCVZwKxMK2AW9R1zlc95Ak+EeVshtT2UgiB/rJawO4 wg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nxugh90bv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 16:52:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31OGpxol005921
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Feb 2023 16:51:59 GMT
Received: from hu-gokukris-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 24 Feb 2023 08:51:58 -0800
From:   Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        "Elliot Berman" <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        "Gokul krishna Krishnakumar" <quic_gokukris@quicinc.com>
Subject: [PATCH v1 0/1] Add trace events for remoteproc
Date:   Fri, 24 Feb 2023 08:51:41 -0800
Message-ID: <20230224165142.17745-1-quic_gokukris@quicinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nqWJHhb-VMnb-HG-oTCJ2gGjjAbeDVbV
X-Proofpoint-ORIG-GUID: nqWJHhb-VMnb-HG-oTCJ2gGjjAbeDVbV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_12,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 bulkscore=0 phishscore=0 mlxlogscore=529 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302240132
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch attempts to add traces for important remoteproc events,
this will help in debugging errors with the subsystem restart and
also helps in getting an estimate on how long each event takes to run.

Gokul krishna Krishnakumar (1):
  remoteproc: qcom: Add remoteproc tracing

 drivers/remoteproc/Makefile           |  3 ++-
 drivers/remoteproc/qcom_common.c      | 25 +++++++++++++++++++
 drivers/remoteproc/qcom_q6v5.c        |  3 +++
 drivers/remoteproc/qcom_q6v5_pas.c    | 17 +++++++++++++
 drivers/remoteproc/qcom_sysmon.c      | 13 ++++++++++
 drivers/remoteproc/qcom_tracepoints.c | 10 ++++++++
 include/trace/events/rproc_qcom.h     | 36 +++++++++++++++++++++++++++
 7 files changed, 106 insertions(+), 1 deletion(-)
 create mode 100644 drivers/remoteproc/qcom_tracepoints.c
 create mode 100644 include/trace/events/rproc_qcom.h


base-commit: 7c855ef7137a67bcff0e039691b969428dd8ef6a
-- 
2.39.2

