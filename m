Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6F96F7D01
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 08:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjEEGhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 02:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjEEGhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 02:37:16 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8153F9ED0;
        Thu,  4 May 2023 23:37:15 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34567Dr7026814;
        Fri, 5 May 2023 06:36:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=s1UdkRzzF8cFAQcoYxajxf72HMv1k5ObWuqkwuK/fiM=;
 b=lD13AUn8nQAnwH9vqOHayl65rJeqVohdmPfJL2Tl5g9vAXAa7YJUew6jRiX9W0izkD9p
 P7vtOqtR0PPGrOSNsphLh1YY8yX3Sy0AagGjlmei0EOTvchqwp3T0V7cxueZgQYdocZ9
 kA7Rk4eMtTh/BWkciRRsWKrds+a9ZueFVjTEU1a4SbyM5uGeW9h5G7I7D8uPQ8maY73Y
 NHdHPGv5GeFGK2tK2LLLAQb4pSyt8lCdTxVA4UgVofIbFh2n9SRnSUnMrZ41gQWR0YSc
 IQLOuN7oVSGQZySctgf3//lCR5aAa3QQDD8pLIsNovjDZLJ5YfKQKsC93AuFau5wq8K5 IQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qctfu897v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 May 2023 06:36:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3456av1s007763
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 5 May 2023 06:36:57 GMT
Received: from hu-schowdhu-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 4 May 2023 23:36:56 -0700
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: [PATCH V23 3/3] MAINTAINERS: Add the entry for DCC(Data Capture and Compare) driver support
Date:   Thu, 4 May 2023 23:36:23 -0700
Message-ID: <ac9186e43afa1334ff54156eeef05e5a95bb93dc.1683265984.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1683265984.git.quic_schowdhu@quicinc.com>
References: <cover.1683265984.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dOba35aUKxDYJDAZyitMJ4OKdpyJBOQo
X-Proofpoint-ORIG-GUID: dOba35aUKxDYJDAZyitMJ4OKdpyJBOQo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_15,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=744 lowpriorityscore=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxscore=0 phishscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050056
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the entries for all the files added as a part of driver support for
DCC(Data Capture and Compare).

Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cb932c6f8959..30b0e23cd31e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5721,6 +5721,14 @@ W:	http://lists.twibble.org/mailman/listinfo/dc395x/
 F:	Documentation/scsi/dc395x.rst
 F:	drivers/scsi/dc395x.*
 
+DCC QTI DRIVER
+M:	Souradeep Chowdhury <quic_schowdhu@quicinc.com>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	Documentation/ABI/testing/debugfs-driver-dcc
+F:	Documentation/devicetree/bindings/misc/qcom,dcc.yaml
+F:	drivers/misc/qcom-dcc.c
+
 DCCP PROTOCOL
 L:	dccp@vger.kernel.org
 S:	Orphan
-- 
2.17.1

