Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195C3669CD5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjAMPuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjAMPtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:49:43 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C64A7BCFD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:42:18 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 481F86B9D6;
        Fri, 13 Jan 2023 15:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673624537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=b/Q1WydWTydxVFn34G4TBcpDtVUFA1zCat3BRDSsBWs=;
        b=MXynMrBcC9bTzoykEbCRjfhBrju1QQxxYdpPIW1F7q8QqjhIuaen652mphAcqehOlhAFrf
        lBmzn7H7Vqg985EExgStWqYvrdIkgGsqZe8wMPghMu3Phu92/DMuq9V6VSf++B1ZjgkIsd
        meZQ5VVqwc13Cet7O7MfsCiVRa4+uHg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC9E91358A;
        Fri, 13 Jan 2023 15:42:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id y0LTNdh7wWOuPwAAMHmgww
        (envelope-from <antonio.feijoo@suse.com>); Fri, 13 Jan 2023 15:42:16 +0000
From:   Antonio Alvarez Feijoo <antonio.feijoo@suse.com>
To:     linux-kernel@vger.kernel.org
Cc:     Antonio Alvarez Feijoo <antonio.feijoo@suse.com>
Subject: [PATCH] gen_initramfs.sh: replace spaces with tab
Date:   Fri, 13 Jan 2023 16:39:36 +0100
Message-Id: <20230113153936.529-1-antonio.feijoo@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up indentation, replace spaces with tab.

Signed-off-by: Antonio Alvarez Feijoo <antonio.feijoo@suse.com>
---
 usr/gen_initramfs.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/usr/gen_initramfs.sh b/usr/gen_initramfs.sh
index 63476bb70b41..159992a45196 100755
--- a/usr/gen_initramfs.sh
+++ b/usr/gen_initramfs.sh
@@ -170,7 +170,7 @@ input_file() {
 		print_mtime "$1" >> $cpio_list
 		cat "$1"         >> $cpio_list
 		if [ -n "$dep_list" ]; then
-		        echo "$1 \\"  >> $dep_list
+			echo "$1 \\"  >> $dep_list
 			cat "$1" | while read type dir file perm ; do
 				if [ "$type" = "file" ]; then
 					echo "$file \\" >> $dep_list
-- 
2.35.3

