Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52866FE395
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 20:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbjEJSF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 14:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjEJSF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 14:05:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21551BB;
        Wed, 10 May 2023 11:05:24 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34AEpUeI027058;
        Wed, 10 May 2023 18:05:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=XwFAqRWE5C/7K1tsbuVyI4+mFw3Ho+3Ag5twKuA69s4=;
 b=VTGeUaWKXiBlnZ22kT9uHK55KupceWN5paeo7KogS/pdY6cQvTF7cXq26yDm7OsyI7du
 x062flI6gFJK5zjW7y9wH99g0d+L5dm8DwZrcH+IdWdK6yU9qefXKuxUqbX6RSagCQDA
 wbmEA6/cpgJqYjUsglWPumiI3uMWLoo0oc2iGy5xHkzyiS9MvcXcsFwQOAqwNBJjnZqU
 Dzjt9PVgvpb8HjB3uz+uXTrzqYbYE+tkMQTLvMnNAKShTn6NBfxZhZia+beEmUu7kU02
 ewMKo1+Uvo6WzJT7hi3TKOW7wFcRv9gOBlOqyBz+CggP6M4r1Kd070qc/Rk4rBuLeamn MA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qgdd9regf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 18:05:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34AI5J3m022885
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 May 2023 18:05:19 GMT
Received: from hu-gokukris-sd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 10 May 2023 11:05:19 -0700
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
Subject: [PATCH v3 0/2] Add trace events for remoteproc
Date:   Wed, 10 May 2023 11:05:02 -0700
Message-ID: <cover.1683741283.git.quic_gokukris@quicinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2eKuBBJbbMtJsI8XAtGXKugewEP3Zg8j
X-Proofpoint-ORIG-GUID: 2eKuBBJbbMtJsI8XAtGXKugewEP3Zg8j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=418 mlxscore=0 adultscore=0 clxscore=1011 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305100145
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patches for introducing traces in remoteproc.

V3: Split the Patch to 2 as per suggestion from Mukesh, fixed format
error from v2. 

V2: Moved the traces to common code from the qcom_pas driver as per
Bjorns review, fixed text as per Triloks suggestion, Updated QuiC
copyright to 2023.

[1]: https://lore.kernel.org/all/20230224165142.17745-2-quic_gokukris@quicinc.com/

Gokul krishna Krishnakumar (2):
  remoteproc: Introduce traces for remoteproc events
  remoteproc: qcom: Add remoteproc tracing

 drivers/remoteproc/Makefile           |   1 +
 drivers/remoteproc/qcom_common.c      |  37 ++++++++
 drivers/remoteproc/qcom_q6v5.c        |   9 ++
 drivers/remoteproc/qcom_tracepoints.c |  12 +++
 drivers/remoteproc/remoteproc_core.c  |   8 ++
 include/trace/events/rproc_qcom.h     | 128 ++++++++++++++++++++++++++
 6 files changed, 195 insertions(+)
 create mode 100644 drivers/remoteproc/qcom_tracepoints.c
 create mode 100644 include/trace/events/rproc_qcom.h


base-commit: 47f64e7ef95a58e5c56f2ec62cbadbe868661149
-- 
2.40.1

