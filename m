Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA7E6A0C8F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 16:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbjBWPH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 10:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234953AbjBWPHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 10:07:21 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C149532BD;
        Thu, 23 Feb 2023 07:07:20 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31NB496V015214;
        Thu, 23 Feb 2023 15:07:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=sq8uvt1NViWyHNAXmly9UKKOFzxewtugXdsvilv+m0k=;
 b=Hw6gypJcvR3CNE+P18dn3xdf4Df792qJUgn7hvy2HKE+daDQuD1Sq76riQkuH/hHY0Gh
 pdo8L+grEfh9pkTshTyEXr6TPTejOUjdE9pv7qiT5OEPA6WsEeHI0xOcri+N2eMKLGnp
 V+Wrz51nZqvOAhL9AdLehiFQAJmzI7ObFVT+N5bOYp8tWgUVHYYkE0uE/VYgd6Rg13VK
 qeYATJou3JdUy0HX1aE7nImcP1SZ28JD/t/+6xfz6sr3DBmO7LKj6S7A7QVD7A4neoOB
 9Tj4raPznOWxtFenTWqH+wff1Ksp2b6gp7CTnhR05ZCD6pMUBQ6uYRxW8/R8I6Eezs0Y 6w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nwy8m1p07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 15:07:08 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31NF78sN021006
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 15:07:08 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 23 Feb 2023 07:07:00 -0800
From:   Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To:     <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>,
        <krzysztof.kozlowski@linaro.org>, <mathieu.poirier@linaro.org>,
        <corbet@lwn.net>, <quic_visr@quicinc.com>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH v5 2/2] docs: remoteproc: Update section header name requirement
Date:   Thu, 23 Feb 2023 20:35:59 +0530
Message-ID: <20230223150559.2429562-3-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230223150559.2429562-1-quic_mohs@quicinc.com>
References: <20230223150559.2429562-1-quic_mohs@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2Kb6C0fZY61HRDvR5cEfZvUVJ2ry5Q7q
X-Proofpoint-ORIG-GUID: 2Kb6C0fZY61HRDvR5cEfZvUVJ2ry5Q7q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_09,2023-02-23_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 mlxlogscore=978 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302230123
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>

Add section header name requirement specification in elf segments.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 Documentation/staging/remoteproc.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/staging/remoteproc.rst b/Documentation/staging/remoteproc.rst
index 348ee7e508ac..0c9c10a30c3d 100644
--- a/Documentation/staging/remoteproc.rst
+++ b/Documentation/staging/remoteproc.rst
@@ -244,7 +244,10 @@ according to the specified device address (might be a physical address
 if the remote processor is accessing memory directly).
 
 In addition to the standard ELF segments, most remote processors would
-also include a special section which we call "the resource table".
+also include a special section which we call the "resource table".
+A "resource table" section name must start with the ".resource_table" prefix,
+optionally having a more descriptive string appended. For example,
+".resource_table.my_rproc" is a valid section name.
 
 The resource table contains system resources that the remote processor
 requires before it should be powered on, such as allocation of physically
-- 
2.25.1

