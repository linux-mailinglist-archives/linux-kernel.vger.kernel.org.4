Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F342D6E0A44
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjDMJ3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjDMJ3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:29:06 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAF07D96;
        Thu, 13 Apr 2023 02:29:05 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33D9Qnrl004679;
        Thu, 13 Apr 2023 09:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=wLg6bFDRbhWlSEd0FB3HC3klJjPMFejYMgCtToFRl/c=;
 b=Z9PCHBe6HcFBJc9gTz5i4GTPM2A/dsgYu3aI83nvMs0/rPSmQQ00sKW+vCWsCv0en4Ws
 LKDKyg5Pq2IFVPXNTiG0dABekGqUI+DWIG5mKQwsikP0oH4nLvXJQn1+xanx0RkXUwPZ
 zOHbuyCyc4lkdJA3iCDxqFCLfWAmYBD+g68dc6zDZau+i+8eUChgmWeu8/OXwh41cIVr
 30f4KTbXVDxqkn0mFP/vz2wh9i+TeMBGlrNlq6Ah7PkFma5tLLI8NLeXYJypsv3Kvym/
 Yv0odXzpRq18JNi8KFQBIAxFHUe1p7FmXLEGTdLamC07uqNnp8vBWWFWOW9d83+FLQGj lg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pwqnq31vu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 09:28:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33D9Sv91031979
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 09:28:57 GMT
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 13 Apr 2023 02:28:53 -0700
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: [PATCH V3 3/3] MAINTAINERS: Add the entry for boot_stats driver support
Date:   Thu, 13 Apr 2023 14:58:18 +0530
Message-ID: <bac8b9f7de40800142a80c54e60a2d75c1fe6876.1681375949.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1681375949.git.quic_schowdhu@quicinc.com>
References: <cover.1681375949.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xn4VlJZMtegzw9rjUrXuYqsJ2zE7k1EA
X-Proofpoint-GUID: xn4VlJZMtegzw9rjUrXuYqsJ2zE7k1EA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_05,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 clxscore=1015 spamscore=0 adultscore=0 mlxlogscore=905
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304130085
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the entries for all the files added as a part of driver support for
boot stats.

Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0e64787..20b96e9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17055,6 +17055,13 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/ipa/
 
+QCOM BOOT_STATS DRIVER
+M:	Souradeep Chowdhury <quic_schowdhu@quicinc.com>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	Documentation/ABI/testing/debugfs-driver-bootstat
+F:	drivers/soc/qcom/boot_stats.c
+
 QEMU MACHINE EMULATOR AND VIRTUALIZER SUPPORT
 M:	Gabriel Somlo <somlo@cmu.edu>
 M:	"Michael S. Tsirkin" <mst@redhat.com>
-- 
2.7.4

