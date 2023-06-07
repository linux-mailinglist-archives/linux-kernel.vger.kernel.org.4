Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096FD726946
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 20:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbjFGSyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 14:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbjFGSyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:54:02 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BD81BD8;
        Wed,  7 Jun 2023 11:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1686164042; x=1717700042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9Xz9nGSy0yeRWGlp2DV6RWzFo2eunHtyb2l98NdWpAM=;
  b=sdpfKsZJg/5RKQIfLVxMeVeQJInpWT03zqMi9opgVWQhyjTUkcA4prb6
   zqD8tjnbPRqYGkw1XcmdOZcvh0bE/5DXP0z1+N0+UGXqgT6nT4eH6OHSj
   5MMtwacZjuUNymyxGs3RnFDBBO7HrZCuCc6aDtmKr83DrHPFozBB0lX0l
   c=;
X-IronPort-AV: E=Sophos;i="6.00,224,1681171200"; 
   d="scan'208";a="219315540"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-af372327.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 18:54:02 +0000
Received: from EX19MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-m6i4x-af372327.us-west-2.amazon.com (Postfix) with ESMTPS id D145760A3F;
        Wed,  7 Jun 2023 18:54:00 +0000 (UTC)
Received: from EX19D002UWA003.ant.amazon.com (10.13.138.235) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 7 Jun 2023 18:53:53 +0000
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19D002UWA003.ant.amazon.com (10.13.138.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 7 Jun 2023 18:53:53 +0000
Received: from dev-dsk-risbhat-2b-8bdc64cd.us-west-2.amazon.com
 (10.189.73.169) by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP
 Server id 15.2.1118.26 via Frontend Transport; Wed, 7 Jun 2023 18:53:52 +0000
Received: by dev-dsk-risbhat-2b-8bdc64cd.us-west-2.amazon.com (Postfix, from userid 22673075)
        id ACE5C222F; Wed,  7 Jun 2023 18:53:52 +0000 (UTC)
From:   Rishabh Bhatnagar <risbhat@amazon.com>
To:     <gregkh@linuxfoundation.org>
CC:     <sfrench@samba.org>, <stable@vger.kernel.org>,
        <linux-cifs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Paulo Alcantara <pc@cjr.nz>, Aurelien Aptel <aaptel@suse.com>,
        Steve French <stfrench@microsoft.com>,
        Rishabh Bhatnagar <risbhat@amazon.com>
Subject: [PATCH 5.10 1/2] cifs: get rid of unused parameter in reconn_setup_dfs_targets()
Date:   Wed, 7 Jun 2023 18:53:12 +0000
Message-ID: <20230607185313.11363-2-risbhat@amazon.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230607185313.11363-1-risbhat@amazon.com>
References: <20230607185313.11363-1-risbhat@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paulo Alcantara <pc@cjr.nz>

commit baf3f08ef4083b76ca67b143e135213a7f941879 upstream.

The target iterator parameter "it" is not used in
reconn_setup_dfs_targets(), so just remove it.

Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Rishabh Bhatnagar <risbhat@amazon.com>
---
 fs/cifs/connect.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 6c8dd7c0b83a..b5cd3dc479ce 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -469,8 +469,7 @@ static void reconn_inval_dfs_target(struct TCP_Server_Info *server,
 }
 
 static inline int reconn_setup_dfs_targets(struct cifs_sb_info *cifs_sb,
-					   struct dfs_cache_tgt_list *tl,
-					   struct dfs_cache_tgt_iterator **it)
+					   struct dfs_cache_tgt_list *tl)
 {
 	if (!cifs_sb->origin_fullpath)
 		return -EOPNOTSUPP;
@@ -515,7 +514,7 @@ cifs_reconnect(struct TCP_Server_Info *server)
 	} else {
 		cifs_sb = CIFS_SB(sb);
 
-		rc = reconn_setup_dfs_targets(cifs_sb, &tgt_list, &tgt_it);
+		rc = reconn_setup_dfs_targets(cifs_sb, &tgt_list);
 		if (rc && (rc != -EOPNOTSUPP)) {
 			cifs_server_dbg(VFS, "%s: no target servers for DFS failover\n",
 				 __func__);
-- 
2.39.2

