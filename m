Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880E07134CE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 14:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbjE0Mjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 08:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbjE0Mj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 08:39:28 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A16713D
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 05:39:18 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34RCamUv025606;
        Sat, 27 May 2023 12:39:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=ZA7rAmV7FT1BUimbvY8C5HycfwIgZxN51LCkAF7zIuc=;
 b=MsTt04a/3lCH8eFB/XszUc87pwMoQC3I5OyjrNe5k2W3Zgpi6CpXv4XdXHk/QyBL1/sJ
 LAwwxa5+ykOOWiAwD7a6cfs5WbHWKO1rzaRg6akyqobBJ5Jg+ySxDd039oEB+FkPQmWr
 DXQgoxB+L8RCLZNdc9VXWBJe/cw4zPBOzwugyrkJPUg4olfZTPeX3ijsW7eViFGeCp+f
 8RcpMIkpKjZwkXgYYHBevug36CGTwot8+BsGjC6gHegBpB/tHe/X2EEjhTKewGLjj2Bd
 89qvMryfpCcaH/6jeAaGWYdLmnsaBHcG9+cYvuSGLcflFQcWlfdtSUpc3xpJjw/+SkqZ 5A== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qub5dgdpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 27 May 2023 12:39:11 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34RCdAEb016174
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 27 May 2023 12:39:10 GMT
Received: from hu-pbaronia-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Sat, 27 May 2023 05:39:08 -0700
From:   Prathu Baronia <quic_pbaronia@quicinc.com>
To:     <quic_pbaronia@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] arm64/cpucaps: increase string width to properly format cpucaps.h
Date:   Sat, 27 May 2023 18:08:58 +0530
Message-ID: <20230527123900.680520-1-quic_pbaronia@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230527122734.GA677156@hu-pbaronia-blr.qualcomm.com>
References: <20230527122734.GA677156@hu-pbaronia-blr.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8E1fs2-o094qY10oFZsgfpxODDPTrBzk
X-Proofpoint-GUID: 8E1fs2-o094qY10oFZsgfpxODDPTrBzk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-27_09,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=715 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305270109
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lengthiest capability is `WORKAROUND_TRBE_OVERWRITE_FILL_MODE` and
its length is 35 characters so increase the width of left justified
strings to 40 and adjust the tab space for `ARM64_NCAPS` accordingly.
Now the generated cpucaps.h is properly formatted.

Signed-off-by: Prathu Baronia <quic_pbaronia@quicinc.com>
---
V1 -> V2: increase the width from 35 to 40

 arch/arm64/tools/gen-cpucaps.awk | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/tools/gen-cpucaps.awk b/arch/arm64/tools/gen-cpucaps.awk
index 00c9e72a200a..8525980379d7 100755
--- a/arch/arm64/tools/gen-cpucaps.awk
+++ b/arch/arm64/tools/gen-cpucaps.awk
@@ -24,12 +24,12 @@ BEGIN {
 }
 
 /^[vA-Z0-9_]+$/ {
-	printf("#define ARM64_%-30s\t%d\n", $0, cap_num++)
+	printf("#define ARM64_%-40s\t%d\n", $0, cap_num++)
 	next
 }
 
 END {
-	printf("#define ARM64_NCAPS\t\t\t\t%d\n", cap_num)
+	printf("#define ARM64_NCAPS\t\t\t\t\t%d\n", cap_num)
 	print ""
 	print "#endif /* __ASM_CPUCAPS_H */"
 }

base-commit: 9d646009f65d62d32815f376465a3b92d8d9b046
-- 
2.25.1

