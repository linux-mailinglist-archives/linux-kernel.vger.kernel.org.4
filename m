Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4AA27064D7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 12:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjEQKFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 06:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjEQKFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 06:05:18 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0812D1B3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 03:05:17 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34H95PZL007704;
        Wed, 17 May 2023 10:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=rvNs+xJ4Glk8VQVvH9h4zQaGKCGXxEqOiDaxft/uHy8=;
 b=R9BCWlCD9GqOxZlXx6xrOhxLPRvH3LshQGY+UU7eY6CAwm+k2yEa9jfQRntc0hN9L98q
 JTX5FSAsd8a8ye4x7F2PhXfpeVfqBQVVDqabNs9AFQudwAQxkARRTSTSQ9Po7sCqIzwH
 dveUoD0l8ZTgLkE9xWQZ+PdS48BrQKPuUEG4FrBArjxzUI1Zuh/0dDZEsVlV/L6E2+lU
 TIkhLZNO2H3b/OqnS+Ia1iI7VLVpLxwA0d3TWVDMjVLahB+uy7jhFn4Ug9nWn1r/EFK6
 osJqJIHEiuAsEURtuXFl21tJC20gPYY3WDLOZ5ooWkya5zHCJFbvq5hA0P2VzHXm6Rtl xQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qme0m9qbu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 10:05:09 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34HA59Tp009624
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 10:05:09 GMT
Received: from hu-pbaronia-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 17 May 2023 03:05:07 -0700
From:   Prathu Baronia <quic_pbaronia@quicinc.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Prathu Baronia <quic_pbaronia@quicinc.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64/cpucaps: increase string width to properly format cpucaps.h
Date:   Wed, 17 May 2023 15:34:50 +0530
Message-ID: <20230517100452.382174-1-quic_pbaronia@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: W7bEwo3kgpyoKOPhxIlV3mskB3aYF-YZ
X-Proofpoint-ORIG-GUID: W7bEwo3kgpyoKOPhxIlV3mskB3aYF-YZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 spamscore=0 adultscore=0 mlxlogscore=690 mlxscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170082
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lengthiest capability is `WORKAROUND_TRBE_OVERWRITE_FILL_MODE` and
its length is 35 characters so increase the width of left justified
strings to 35 and adjust the tab space for `ARM64_NCAPS` accordingly.
Now the generated cpucaps.h is properly formatted.

Signed-off-by: Prathu Baronia <quic_pbaronia@quicinc.com>
---
 arch/arm64/tools/gen-cpucaps.awk | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/tools/gen-cpucaps.awk b/arch/arm64/tools/gen-cpucaps.awk
index 00c9e72a200a..1e6167be4052 100755
--- a/arch/arm64/tools/gen-cpucaps.awk
+++ b/arch/arm64/tools/gen-cpucaps.awk
@@ -24,12 +24,12 @@ BEGIN {
 }
 
 /^[vA-Z0-9_]+$/ {
-	printf("#define ARM64_%-30s\t%d\n", $0, cap_num++)
+	printf("#define ARM64_%-35s\t%d\n", $0, cap_num++)
 	next
 }
 
 END {
-	printf("#define ARM64_NCAPS\t\t\t\t%d\n", cap_num)
+	printf("#define ARM64_NCAPS\t\t\t\t\t%d\n", cap_num)
 	print ""
 	print "#endif /* __ASM_CPUCAPS_H */"
 }
-- 
2.25.1

