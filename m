Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DA768A20B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 19:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbjBCSbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 13:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjBCSbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 13:31:32 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6EC9F9F4;
        Fri,  3 Feb 2023 10:31:32 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 313HIY0N019113;
        Fri, 3 Feb 2023 18:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=/xHCVgzwEu8Si5xmF4rnGUMeXh7iW2ylVEuGLmpdCA8=;
 b=N2tzG8E6kK41z2ugRxwcXmynMoMQCDKsFLLVobN4mKNZAJ81bQXydj9rWwwzkrQm170y
 +6JrWJjjybrf74FZfibyXuprfcHByV5obn7xiDgzYlVESk/h/RKUZwEbIlx3K/OKzhSQ
 COK58VFrOU7YnD36SeO1vKS8IGh4+FH44eIK/r6mvTNlK76SPNRNqzb6SCbDAnARzKVZ
 CQcouWgiIw8RmT+lY06Y8s2hcGSXvVo8zqCMOie2px7jJbB1ibXzVF8zX0lW/A+bgzAE
 T5Bxhj5U5KaRYOfbNb+ZtTLT0pkaBMKbxQoGjtA3pWeEFFyCYWAiKn8a55vn2yo59St7 0A== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ngwd01e1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 18:31:29 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 313IVSeB009689
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Feb 2023 18:31:28 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 3 Feb 2023 10:31:27 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] MAINTAINERS: Add include/linux/qcom* to ARM/QUALCOMM
Date:   Fri, 3 Feb 2023 10:31:14 -0800
Message-ID: <20230203183115.2836316-1-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DY5w-TLKt7DRWx41NBK_pSts5fipYwKz
X-Proofpoint-ORIG-GUID: DY5w-TLKt7DRWx41NBK_pSts5fipYwKz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_17,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=849 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302030170
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM/QUALCOMM support currently includes include/linux/*/qcom* but is
missing a few Qualcomm headers directly in include/linux/.

This effectively adds following headers directly under ARM/QUALCOMM.
 - include/linux/qcom-geni-se.h
 - include/linux/qcom_scm.h

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f2c3d471fe8f..752cddd73bf8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2724,6 +2724,7 @@ F:	drivers/spi/spi-qup.c
 F:	drivers/tty/serial/msm_serial.c
 F:	drivers/usb/dwc3/dwc3-qcom.c
 F:	include/dt-bindings/*/qcom*
+F:	include/linux/qcom*
 F:	include/linux/*/qcom*
 F:	include/linux/soc/qcom/
 

base-commit: 3866989ec2c319341e2cf69ec6116269b634a271
-- 
2.39.1

