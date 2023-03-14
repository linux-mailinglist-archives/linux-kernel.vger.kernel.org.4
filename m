Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D77B6B97EB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 15:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbjCNO2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 10:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjCNO2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 10:28:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E01AAB8BA;
        Tue, 14 Mar 2023 07:27:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B1A161F899;
        Tue, 14 Mar 2023 14:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678804075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FqlDj5UjmiMEvoSqLoc8v4qWW4pHq8z/st4qCe4e2C4=;
        b=XedR/elBQfI+Fz7FgpPVP+ZbOWuN0G/kycE+YIYHG4ucOgb2jqbq/RsT3P01YYQc+jh+sD
        p7AUUWfpWVa3R7aQTs5LIveOP60zG+VFTOWn/LG+1mrwU+jRNEANIJTd2m81lRdJqETmfr
        76hrkOJfJyw/GrSMrGqgR2qjN60oV4I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7913413A26;
        Tue, 14 Mar 2023 14:27:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 799bHGuEEGSwHQAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 14 Mar 2023 14:27:55 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>, xen-devel@lists.xenproject.org
Subject: [PATCH v2 2/4] xen/blkback: remove stale prototype
Date:   Tue, 14 Mar 2023 15:27:39 +0100
Message-Id: <20230314142741.24917-3-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230314142741.24917-1-jgross@suse.com>
References: <20230314142741.24917-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no function xen_blkif_purge_persistent(), so remove its
prototype from common.h.

Signed-off-by: Juergen Gross <jgross@suse.com>
Acked-by: Roger Pau Monné <roger.pau@citrix.com>
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

