Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3635564B2B6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbiLMJuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234897AbiLMJuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:50:05 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27244F5D;
        Tue, 13 Dec 2022 01:50:04 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BD7U8NS008201;
        Tue, 13 Dec 2022 09:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=WrklWuF+aB1VX6PUMihXwQAJi2MdBml231PZGx5ug5M=;
 b=ULfIClm/P2TLKehI1K965MnlZv4mjyFRpUPBYuVMMhUW8KotScYgwSebI60fsNPurbrm
 kRRlJvKBs6K0x+fvzsBOfgz8EYFP7OfhsDqqicJ88JNSAUBAOkA3e7WdUhlD74/fLeK/
 GSP29ekpBeVgAoPYmKkT5O8gE5X9fnljlclXjHBVc1l32pO+nVpS70GCL47f8XryJFPv
 KmWX6y4dKQ3MwEf6xX2NhQ+OLehIPUsdbpMuGPxR2eufFHhBthqC9ZG6yshZEysOMgk2
 lXF+QV1U5ZOAEXbu+hOm89ktranL33N0azfAf5GC8o/0tr2ATOaNwDLr7mD2Fr8Nsvxg 0A== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3meh1pgutf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 09:49:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BD9nL9R004454
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 09:49:21 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 13 Dec 2022 01:49:15 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>,
        <krzysztof.kozlowski@linaro.org>, <mathieu.poirier@linaro.org>,
        <corbet@lwn.net>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v2 2/2] docs: remoteproc: Update section header name requirement
Date:   Tue, 13 Dec 2022 15:18:49 +0530
Message-ID: <1670924929-26507-3-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1670924929-26507-1-git-send-email-quic_srivasam@quicinc.com>
References: <1670924929-26507-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cnBhuEDuNYBftybO7lliTweOHQI4G4ko
X-Proofpoint-GUID: cnBhuEDuNYBftybO7lliTweOHQI4G4ko
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 impostorscore=0 mlxscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 mlxlogscore=982
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212130087
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add section header name requirement specification in elf segments.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
---
 Documentation/staging/remoteproc.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/staging/remoteproc.rst b/Documentation/staging/remoteproc.rst
index 348ee7e..3125030 100644
--- a/Documentation/staging/remoteproc.rst
+++ b/Documentation/staging/remoteproc.rst
@@ -245,6 +245,8 @@ if the remote processor is accessing memory directly).
 
 In addition to the standard ELF segments, most remote processors would
 also include a special section which we call "the resource table".
+This resource table section name may have anything appended after it,
+but it must start with ".resource_table"
 
 The resource table contains system resources that the remote processor
 requires before it should be powered on, such as allocation of physically
-- 
2.7.4

