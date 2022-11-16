Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B4D62B9EB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238963AbiKPKsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239201AbiKPKre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:47:34 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B11048743
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:35:21 -0800 (PST)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AGAWQ2V003406;
        Wed, 16 Nov 2022 10:35:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id; s=pps0720;
 bh=WNs+HcR+QNWT2YDAGWmbUqdwl5tguMshyXbrCyDQhCY=;
 b=YYbR6kPGA1bsKZJdb1lhmvP0YBhVbblkdVaXbpjzMHNfnlUbqEbo7WaYM7AzlAN6O1oO
 gfBZWFjdrt3Ea56iPJpLQZLy65maFZH0Jw7yi95OJoREgCTV4iiFHQhfJaHQ17ta9dQH
 E8TZzkFiSIJlzNoaPRTCg+uiQFuqG5EbkXJ78r0EWyTgUiE1DBpIMWK5HX0Hk1Ey8kU7
 vYRHfqGmKftp/oEPXhCa6AApsbE4QmfpGdU1M1hlKfcWIChEaXFBPU4GTSkVj6csaIbi
 uJdzJ6ocnTm/NuhN5MV8r5lB2TXGoQ0JfrLR2XXAhpt818ePOM2Drv64Hfmo2F5vyNMl WA== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kvx6p00tc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 10:35:06 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id DCFA62FD00;
        Wed, 16 Nov 2022 10:35:05 +0000 (UTC)
Received: from blofly.os1.tw (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 2CB21804081;
        Wed, 16 Nov 2022 10:35:00 +0000 (UTC)
From:   matt.hsiao@hpe.com
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        christophe.jaillet@wanadoo.fr, gustavoars@kernel.org,
        nishadkamdar@gmail.com, torvalds@linux-foundation.org,
        dhaval.experiance@gmail.com, viro@zeniv.linux.org.uk,
        arvind.yadav.cs@gmail.com, standby24x7@gmail.com,
        wfp5p@virginia.edu, jslaby@suse.cz, prarit@redhat.com,
        tj@kernel.org, adobriyan@gmail.com, Matt Hsiao <matt.hsiao@hpe.com>
Subject: [PATCH v2] misc: hpilo: relicense HPE iLO driver as Dual MIT/GPL
Date:   Wed, 16 Nov 2022 18:34:57 +0800
Message-Id: <20221116103457.27486-1-matt.hsiao@hpe.com>
X-Mailer: git-send-email 2.16.6
X-Proofpoint-GUID: 8CMyYqZ-qzxY5PQW7Q4LkMcIYrrr3I2g
X-Proofpoint-ORIG-GUID: 8CMyYqZ-qzxY5PQW7Q4LkMcIYrrr3I2g
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_01,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160073
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

Patch v2:
---------
- Change MODULE_LICENSE to Dual MIT/GPL too

 drivers/misc/hpilo.c | 4 ++--
 drivers/misc/hpilo.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/hpilo.c b/drivers/misc/hpilo.c
index 8d00df9243c4..137063857e8d 100644
--- a/drivers/misc/hpilo.c
+++ b/drivers/misc/hpilo.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
  * Driver for the HP iLO management processor.
  *
@@ -924,7 +924,7 @@ MODULE_VERSION("1.5.0");
 MODULE_ALIAS(ILO_NAME);
 MODULE_DESCRIPTION(ILO_NAME);
 MODULE_AUTHOR("David Altobelli <david.altobelli@hpe.com>");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("Dual MIT/GPL");
 
 module_param(max_ccb, uint, 0444);
 MODULE_PARM_DESC(max_ccb, "Maximum number of HP iLO channels to attach (8-24)(default=16)");
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

