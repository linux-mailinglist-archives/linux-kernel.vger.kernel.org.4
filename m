Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2117160CCD4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbiJYNBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbiJYNAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:00:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDBB18DD47
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 05:57:47 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MxX6521b3zHv6r;
        Tue, 25 Oct 2022 20:57:33 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 20:57:44 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <paul@paul-moore.com>, <casey@schaufler-ca.com>,
        <davem@davemloft.net>, <lucien.xin@gmail.com>,
        <omosnace@redhat.com>, <gnoack3000@gmail.com>,
        <cuigaosheng1@huawei.com>, <mortonm@chromium.org>,
        <fred@cloudflare.com>, <cgzones@googlemail.com>,
        <viro@zeniv.linux.org.uk>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] LSM: Remove obsoleted comments for security hooks
Date:   Tue, 25 Oct 2022 20:57:44 +0800
Message-ID: <20221025125744.2393200-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the following obsoleted comments for security hooks:

1. sb_copy_data, the hook function has been removed since
commit 5b4002391153 ("LSM: turn sb_eat_lsm_opts() into a method").

2. sb_parse_opts_str, the hook function has been removed since
commit 757cbe597fe8 ("LSM: new method: ->sb_add_mnt_opt()").

They are obsoleted comments, so remove them.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 include/linux/lsm_hooks.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index fad93a6d5293..ef2e8a484798 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -136,15 +136,6 @@
  *	@flags contains the mount flags.
  *	@data contains the filesystem-specific data.
  *	Return 0 if permission is granted.
- * @sb_copy_data:
- *	Allow mount option data to be copied prior to parsing by the filesystem,
- *	so that the security module can extract security-specific mount
- *	options cleanly (a filesystem may modify the data e.g. with strsep()).
- *	This also allows the original mount data to be stripped of security-
- *	specific options to avoid having to make filesystems aware of them.
- *	@orig the original mount data copied from userspace.
- *	@copy copied data which will be passed to the security module.
- *	Returns 0 if the copy was successful.
  * @sb_mnt_opts_compat:
  *	Determine if the new mount options in @mnt_opts are allowed given
  *	the existing mounted filesystem at @sb.
@@ -180,10 +171,6 @@
  *	Copy all security options from a given superblock to another
  *	@oldsb old superblock which contain information to clone
  *	@newsb new superblock which needs filled in
- * @sb_parse_opts_str:
- *	Parse a string of security data filling in the opts structure
- *	@options string containing all mount options known by the LSM
- *	@opts binary data structure usable by the LSM
  * @move_mount:
  *	Check permission before a mount is moved.
  *	@from_path indicates the mount that is going to be moved.
-- 
2.25.1

