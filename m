Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B8264ED45
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 15:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiLPO66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 09:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbiLPO6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 09:58:37 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8565EDE9;
        Fri, 16 Dec 2022 06:58:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3370A3431A;
        Fri, 16 Dec 2022 14:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1671202711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DdtkNadGDanVmd8kJX65xjdddaLea0RGEwD4P1a+J98=;
        b=lODXEK7ebePxLiw4PLu3KgzPfwzpEJ8IAv4i/mfs4SKHCuKJrxjbYg1qOAihkqBC6oD+9U
        nhSOPxk8HT/dVvpZHdqnBP9Yo3K27sS+sbEM7f/LIiYFCQXYHMP0OtPzTqT1jic8TKGPY9
        KjNkKTIBe7WLq0e05vK4e9zGRsdkFbs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EB6A1138FD;
        Fri, 16 Dec 2022 14:58:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id D5wpOJaHnGPAeAAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 16 Dec 2022 14:58:30 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org
Subject: [PATCH 2/4] xen/blkback: remove stale prototype
Date:   Fri, 16 Dec 2022 15:58:14 +0100
Message-Id: <20221216145816.27374-3-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221216145816.27374-1-jgross@suse.com>
References: <20221216145816.27374-1-jgross@suse.com>
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

There is no function xen_blkif_purge_persistent(), so remove its
prototype from common.h.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/block/xen-blkback/common.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
index 9a13a6b420a6..fab8a8dee0da 100644
--- a/drivers/block/xen-blkback/common.h
+++ b/drivers/block/xen-blkback/common.h
@@ -384,7 +384,6 @@ void xen_blkif_xenbus_fini(void);
 
 irqreturn_t xen_blkif_be_int(int irq, void *dev_id);
 int xen_blkif_schedule(void *arg);
-int xen_blkif_purge_persistent(void *arg);
 void xen_blkbk_free_caches(struct xen_blkif_ring *ring);
 
 int xen_blkbk_flush_diskcache(struct xenbus_transaction xbt,
-- 
2.35.3

