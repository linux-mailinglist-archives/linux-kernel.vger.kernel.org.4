Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C816D92E9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 11:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236484AbjDFJls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 05:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjDFJlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 05:41:45 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9419361BA
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 02:41:44 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3367w0XN000434
        for <linux-kernel@vger.kernel.org>; Thu, 6 Apr 2023 09:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=9Rh6fujRYTDAYsidn5Til/fX9Ra7FYxG88KiIN6dyjQ=;
 b=NOexCn/J8tRphwOszQPvzAXjbNA7UoY/TT01nVRcSSXg39U4+xFkp1sxUzCAJdCREZia
 vUCYZFeiawEoO1hEEgMBXoNyUlA+nasCmPE/hIJ8iHiz9C19BXnp1THun6Fv6+rrIz2R
 FwiUfUVP9dAci/l/FyXjvKpgnEjQDb6vc1PC/CV/WRxSdzYXb0BRv/Q8sicm5Qoo+ndd
 vd255S7qQ+yjVevdCe6d5MkXITLH/TWW1fU/jMaTlss3yMdzg1DXA78rycNI5c9IoIJj
 UA0fsqC4J2XCU0PCy6nRtytp3TEE5U/oa2N/PJqSvT3H0iXvTniij6tuT5cKTyEU4ecd wQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pss7e8b07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 09:41:43 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3369fgxk017132
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 6 Apr 2023 09:41:42 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 6 Apr 2023 02:41:41 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH] mailmap: add entries for Mukesh Ojha
Date:   Thu, 6 Apr 2023 15:11:28 +0530
Message-ID: <1680774088-18729-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AOv3h8FrhF1wu-TJ9BOZV6ael5Slmc-O
X-Proofpoint-ORIG-GUID: AOv3h8FrhF1wu-TJ9BOZV6ael5Slmc-O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_04,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 mlxlogscore=516
 adultscore=0 mlxscore=0 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304060084
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Map all my old email addresses to my current address.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index e424863..129c3ad 100644
--- a/.mailmap
+++ b/.mailmap
@@ -340,6 +340,8 @@ Morten Welinder <terra@gnome.org>
 Morten Welinder <welinder@anemone.rentec.com>
 Morten Welinder <welinder@darter.rentec.com>
 Morten Welinder <welinder@troll.com>
+Mukesh Ojha <quic_mojha@quicinc.com> <mojha@codeaurora.org>
+Mukesh Ojha <quic_mojha@quicinc.com> <mukesh02@linux.vnet.ibm.com>
 Mythri P K <mythripk@ti.com>
 Nadia Yvette Chambers <nyc@holomorphy.com> William Lee Irwin III <wli@holomorphy.com>
 Nathan Chancellor <nathan@kernel.org> <natechancellor@gmail.com>
-- 
2.7.4

