Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4EC64C24A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 03:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbiLNCjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 21:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLNCjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 21:39:18 -0500
Received: from out30-1.freemail.mail.aliyun.com (out30-1.freemail.mail.aliyun.com [115.124.30.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE26A13F60;
        Tue, 13 Dec 2022 18:39:16 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VXGKkRd_1670985553;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VXGKkRd_1670985553)
          by smtp.aliyun-inc.com;
          Wed, 14 Dec 2022 10:39:14 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     lsahlber@redhat.com
Cc:     sprasad@microsoft.com, tom@talpey.com, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] cifs: Remove duplicated include in cifsglob.h
Date:   Wed, 14 Dec 2022 10:39:11 +0800
Message-Id: <20221214023911.85141-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

./fs/cifs/cifsglob.h: linux/scatterlist.h is included more than once.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3459
Fixes: f7f291e14dde ("cifs: fix oops during encryption")
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/cifs/cifsglob.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 703685e2db5e..82f2d3070c26 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -23,7 +23,6 @@
 #include "cifs_fs_sb.h"
 #include "cifsacl.h"
 #include <crypto/internal/hash.h>
-#include <linux/scatterlist.h>
 #include <uapi/linux/cifs/cifs_mount.h>
 #include "../smbfs_common/smb2pdu.h"
 #include "smb2pdu.h"
-- 
2.20.1.7.g153144c

