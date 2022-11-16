Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1A762BACB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbiKPLFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbiKPLEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:04:24 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9063347329
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:50:50 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AGAQZM3019516;
        Wed, 16 Nov 2022 10:50:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=kKTQWQ1O/GPqGpF+XeetAmZQG6IcDrdaTu4f6MMA+yA=;
 b=RwdZFBMwwYfJnvwYKfY4kYqp6dRUsFTADxLQGmtszn8xhB2R/g3kEAFpNFOqiYQdrmDI
 nVzDMdZ0f0OUmYQcaWKSEQFzE7AQmHd+FbKKleUVBrVCbXX2CW307P4rKc4F9smSCaT2
 p5RmG6TRyX3pINlTVS/BZZ8kXc+Ca+19adyxrx9yMErxfHGbLINrCz7qJwSoWFSt5v5P
 rgK1gqilTV5p9pni7DPh3dgP8VBtvYM6s9gc3tUDtUzWcbcA235l4Ga9fSq0WqmgXE4+
 BJEd9udHrGy+PBzhaPaSMWW+ovdxbK4fx+BIqEZpKKpzVb7+NdWnob/kEJT3Dq/TSNwN fA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kvsq6rsfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 10:50:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AGAolPo017102
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 10:50:47 GMT
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 16 Nov 2022 02:50:45 -0800
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_c_skakit@quicinc.com>, <konrad.dybcio@linaro.org>
Subject: [PATCH] mailmap: Update email address for Satya Priya
Date:   Wed, 16 Nov 2022 16:20:17 +0530
Message-ID: <20221116105017.3018971-1-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -pErDjbQgcVtvp2CbXDKD8hG60b19AsH
X-Proofpoint-GUID: -pErDjbQgcVtvp2CbXDKD8hG60b19AsH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_01,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=718 clxscore=1011 malwarescore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160076
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add and also update email address, skakit@codeaurora.org
is no longer active.

Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 475418fc7e9d..4a14ece4cdb7 100644
--- a/.mailmap
+++ b/.mailmap
@@ -383,6 +383,7 @@ Santosh Shilimkar <santosh.shilimkar@oracle.org>
 Santosh Shilimkar <ssantosh@kernel.org>
 Sarangdhar Joshi <spjoshi@codeaurora.org>
 Sascha Hauer <s.hauer@pengutronix.de>
+Satya Priya <quic_c_skakit@quicinc.com> <skakit@codeaurora.org>
 S.Çağlar Onur <caglar@pardus.org.tr>
 Sean Christopherson <seanjc@google.com> <sean.j.christopherson@intel.com>
 Sean Nyekjaer <sean@geanix.com> <sean.nyekjaer@prevas.dk>
-- 
2.25.1

