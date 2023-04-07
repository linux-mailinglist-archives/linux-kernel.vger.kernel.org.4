Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF406DAE97
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 16:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240440AbjDGOHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 10:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240170AbjDGOG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 10:06:56 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455FB59F2;
        Fri,  7 Apr 2023 07:06:55 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 337DuWnV018844;
        Fri, 7 Apr 2023 14:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=nUIpIqqCfTUgi+eWWw0Gtsf+cKupOLPw8gVVhpAckm8=;
 b=hxIkf4buHF/wUMneglFet5XqyTV/ooy1DLxMdxoYXjmdnrEvMVg9udKHOVTwACsM+UBm
 47mrVwyqdK5GvC90iEqIQ0BQ8QE7fPmMvKfw/ydcHynrxMYTmKfDh23qK+6KAc2K/2Gk
 Ea+cjCJLmuIlyszQlyanju5tiHB477IOdKwS+Dn2zeu8mzqk369qEQctkP9mlPnp8MyX
 bsM8oKQojSBek+bzW7Z3FoSW5tbJut7dPvDaohBf4HQu4Hg5RqwZ0+YRUhIK42H1+vS9
 xhLwF0A1zhINp+P5OZUdoLI82qjzvw1lPBjwbniwSx4gZHSiVjIy1yxmXWFeZ6OkAmn+ Zw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ptgpk0ffk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 14:06:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 337E6jf1017412
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Apr 2023 14:06:45 GMT
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 7 Apr 2023 07:06:41 -0700
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
Subject: [PATCH V2 3/3] MAINTAINERS: Add the entry for boot_stats driver support
Date:   Fri, 7 Apr 2023 19:34:37 +0530
Message-ID: <de6a3f66a8fadca620b8eff7df04038f1abd3c85.1680874520.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1680874520.git.quic_schowdhu@quicinc.com>
References: <cover.1680874520.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Its-cE4DU8oE1szGzGhwBGfCiZoPaD00
X-Proofpoint-GUID: Its-cE4DU8oE1szGzGhwBGfCiZoPaD00
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_08,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=867
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304070129
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the entries for all the files added as a part of driver support for
boot stats.

Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f2c3d47..c591dff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17071,6 +17071,12 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/ipa/
 
+QCOM BOOT_STATS DRIVER
+M:	Souradeep Chowdhury <quic_schowdhu@quicinc.com>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	drivers/soc/qcom/boot_stats.c
+
 QEMU MACHINE EMULATOR AND VIRTUALIZER SUPPORT
 M:	Gabriel Somlo <somlo@cmu.edu>
 M:	"Michael S. Tsirkin" <mst@redhat.com>
-- 
2.7.4

