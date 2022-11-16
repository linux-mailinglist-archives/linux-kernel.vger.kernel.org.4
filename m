Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C06B62B6DE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbiKPJrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbiKPJrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:47:43 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B651C1A05E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:47:41 -0800 (PST)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AG827UW020471;
        Wed, 16 Nov 2022 09:47:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id; s=pps0720;
 bh=ycJwqCMbkamNm9OjhgF+aA5+LBPYf0FftuKwdKDW+8Y=;
 b=HIly/AYQFdBjy7pEixrIbK2eNocY2RfamWUNqP1MfyyFFAi4xgcymRHiWDUBdhbtCXtG
 cV9hrPI4T+6M1sjFxv/iewAHlm8LWtikYR9CLfSKio37XCXjHm6+ZlOu5DvWbT909DYT
 mcZMPPtqOc3ng/VkEr7JUhfbFT5wQ8cb+/jKql3uLg2IOrZCD7v0IzF0m153tjNytrKw
 DRNifca1e+ludFGASkqY8NjV5GsT+GKs9pPMqF6bFnRFuJ/pPs96pLR+jIWdoQ1tftmC
 eNDMn/k0uIFLtI7rWcfpDmwMZcU5KA/EH+ZGfKySQz1QN86c3CJJ6kwALw9KOUp81DNf tw== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kvv0bh07g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 09:47:31 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 384C24B5C9;
        Wed, 16 Nov 2022 09:47:30 +0000 (UTC)
Received: from blofly.os1.tw (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id E16FD80328F;
        Wed, 16 Nov 2022 09:47:25 +0000 (UTC)
From:   matt.hsiao@hpe.com
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        christophe.jaillet@wanadoo.fr, gustavoars@kernel.org,
        nishadkamdar@gmail.com, torvalds@linux-foundation.org,
        dhaval.experiance@gmail.com, viro@zeniv.linux.org.uk,
        arvind.yadav.cs@gmail.com, standby24x7@gmail.com,
        wfp5p@virginia.edu, jslaby@suse.cz, prarit@redhat.com,
        tj@kernel.org, adobriyan@gmail.com, Matt Hsiao <matt.hsiao@hpe.com>
Subject: [PATCH] misc: hpilo: relicense HPE iLO driver as Dual MIT/GPL
Date:   Wed, 16 Nov 2022 17:47:12 +0800
Message-Id: <20221116094712.14312-1-matt.hsiao@hpe.com>
X-Mailer: git-send-email 2.16.6
X-Proofpoint-GUID: 5MLy5IOjS4qFNt-SDgmSeOXOObkfJktT
X-Proofpoint-ORIG-GUID: 5MLy5IOjS4qFNt-SDgmSeOXOObkfJktT
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=928
 impostorscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0 mlxscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160068
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Hsiao <matt.hsiao@hpe.com>

Currently, the hpilo driver is licensed as GPL. To run OpenBSD on HPE
servers with BMC (HPE iLO) functionality, a dual MIT/GPL license is needed
for porting the hpilo driver to OpenBSD.

Signed-off-by: Matt Hsiao <matt.hsiao@hpe.com>
---

Hello contributors in the CC list,

Thanks for your contributions to the hpilo driver. Please kindly review
the license change and hopefully you would agree and approve it. Thanks!

 drivers/misc/hpilo.c | 2 +-
 drivers/misc/hpilo.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/hpilo.c b/drivers/misc/hpilo.c
index 8d00df9243c4..6a06b6485950 100644
--- a/drivers/misc/hpilo.c
+++ b/drivers/misc/hpilo.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
  * Driver for the HP iLO management processor.
  *
diff --git a/drivers/misc/hpilo.h b/drivers/misc/hpilo.h
index d57c34680b09..581dfd7834b8 100644
--- a/drivers/misc/hpilo.h
+++ b/drivers/misc/hpilo.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
 /*
  * linux/drivers/char/hpilo.h
  *
-- 
2.16.6

