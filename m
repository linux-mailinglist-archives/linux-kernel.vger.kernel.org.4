Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A44A667034
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjALKwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjALKwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:52:02 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6FE5B49A
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 02:44:46 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 048003FBCA;
        Thu, 12 Jan 2023 10:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673520285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=99LNhMNwJJ0OIHglNiNV2Fp19hku9zsdWhMyk+Sn67U=;
        b=eKa2Kr8+BKcdUeoQTUSuQbmMQL0S5FwZ0L/6z9qcG2tCKM+uNT1eKg5qRMaONWlE5Y9uhl
        bsFKStYM8Ii4Ls3oz5Ozpc6seXBM7S4yJF26xWJFA9TRs0lXjRiffhLmtQixsnND8ocbFV
        OZZlylbzNYa+QK6UckG9dfjIZ6UQgQw=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id ACC0013958;
        Thu, 12 Jan 2023 10:44:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 2diKJpzkv2NuOQAAGKfGzw
        (envelope-from <antonio.feijoo@suse.com>); Thu, 12 Jan 2023 10:44:44 +0000
From:   Antonio Alvarez Feijoo <antonio.feijoo@suse.com>
To:     linux-kernel@vger.kernel.org
Cc:     Antonio Alvarez Feijoo <antonio.feijoo@suse.com>
Subject: [PATCH] initramfs: fix typo in comment
Date:   Thu, 12 Jan 2023 11:43:46 +0100
Message-Id: <20230112104346.14502-1-antonio.feijoo@suse.com>
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

virtul -> virtual

Signed-off-by: Antonio Alvarez Feijoo <antonio.feijoo@suse.com>
---
 init/initramfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 62321883fe61..3c29a1f1eae9 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -586,7 +586,7 @@ void __init reserve_initrd_mem(void)
 	phys_addr_t start;
 	unsigned long size;
 
-	/* Ignore the virtul address computed during device tree parsing */
+	/* Ignore the virtual address computed during device tree parsing */
 	initrd_start = initrd_end = 0;
 
 	if (!phys_initrd_size)
-- 
2.35.3

