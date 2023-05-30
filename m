Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B17716EE0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 22:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbjE3UeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 16:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbjE3UeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 16:34:02 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C801B3;
        Tue, 30 May 2023 13:33:27 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 32CF03200962;
        Tue, 30 May 2023 16:32:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 30 May 2023 16:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1685478737; x=1685565137; bh=1g
        7wCby6gdLY4jovUh0//kEDEi26QbSZsUz9aHtBM2E=; b=PTeqRnmYVEq0wVDDJD
        v2NgZMyQcplu/m14wNSYj0ve2VYJmp8/HYabLKde0hrBjhqPZg+BxcpirBxApwy2
        KvE46HYM5wnhC/4Udrw7hIu2L32qAPNxDFZSBSqYYIz8YujdBJci/NpTNo+p53K/
        ZP8rfzYLpird6egQYWSHAANqz/RZSLswiBplOl2A/y0OyIu1BxIicwKMkAPHGDmV
        WessmjZhCG8zKV4Ukgz9PvctwW0ATp+S5OvpXekfubo5VoPLDLWvcXJBYNxtQwjv
        35EuDW8XkpOFiyYumD6qGJ1/GAkIvB5AhpkolWi7yQxyzJUOn5vpE8RhOvgoL7fS
        IUPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685478737; x=1685565137; bh=1g7wCby6gdLY4jovUh0//kEDEi26QbSZsUz
        9aHtBM2E=; b=r0rkmSaGTkR2+3ZnA69S5XdEOZnX5eZ1eqBMohYZ6j1pDR1bBh3
        P1bQkHb1aiBf1/paYWLWZ6AQv38yySL0NXXisjeAkN/2Fw6/19D61jXb67QHtocH
        nY2dPHsGsa+vj/j56DVnnMYRzaWKLjV/o+G6vMbtTDRYca8UuWRp7PMHxrv2wb8g
        cdHne0mqgpSzSUcH6DyBsqFNuKPGlHeL7aPXNEEqKgjzioAq5o9+iWqS12vVJbzI
        VeUakDmBw1pkRDsIoh9JGCA82dK2Ag5zfwJrLSviRxJc/0zfHHW/oSddQhvVWtM4
        21jj9qe9xf4rI1JLfrZVS7uAi/G3uQwtsKw==
X-ME-Sender: <xms:UV12ZJsB7-6thDBOW04ZBm8dwA1w8OqPQmWsHPIsTD85Gotn6oCtAQ>
    <xme:UV12ZCcND6TvIARXd8QOOkdba5asaIVOCge4bX4g8CQ5jmO5RYFcsdAxDLYUr6xpT
    K7j0UTQ4KOSnXg>
X-ME-Received: <xmr:UV12ZMz7jUkHkkTvC4PaB0pWjhII28OE1-d4VoJYh3Rk5KoK5polsbsvSHQ6A82D-keKTXHm8f0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepffgv
    mhhiucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhih
    hnghhslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepkeefieekhfdtgeeuueelleeg
    vdetieehgfejteduvedvvdejudetudelfedukefhnecuffhomhgrihhnpehinhguihhrvg
    gtthdrnhhrpdhinhguihhrvggtthdrihgunecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhslh
    grsgdrtghomh
X-ME-Proxy: <xmx:UV12ZAPqoC6ugOyhqw12hilSeplCRnKjnOlJfmhYkOVrSOBnWerfZA>
    <xmx:UV12ZJ8Zyv2sMdGJ8yUkzVbNcYb8OnOE3NDfnKK7_d4J77we3bDJpQ>
    <xmx:UV12ZAVfjKO8vuRkhvcAjXEFakWAjuI2n5mclwt9ec30GFsNgGodag>
    <xmx:UV12ZCMvAk4xGoCgzeqg5Gt0J8JIuCFJuktUAcqyZrosY5iMdZIIaw>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 May 2023 16:32:16 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH v2 15/16] xen-blkback: Minor cleanups
Date:   Tue, 30 May 2023 16:31:15 -0400
Message-Id: <20230530203116.2008-16-demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530203116.2008-1-demi@invisiblethingslab.com>
References: <20230530203116.2008-1-demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a couple of BUILD_BUG_ON()s and moves some arithmetic after
the validation code that checks the arithmetic’s preconditions.  The
previous code was correct but could potentially trip sanitizers that
check for unsigned integer wraparound.

Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
---
 drivers/block/xen-blkback/blkback.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index c362f4ad80ab07bfb58caff0ed7da37dc1484fc5..ac760a08d559085ab875784f1c58cdf2ead95a43 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -1342,6 +1342,8 @@ static int dispatch_rw_block_io(struct xen_blkif_ring *ring,
 	nseg = req->operation == BLKIF_OP_INDIRECT ?
 	       req->u.indirect.nr_segments : req->u.rw.nr_segments;
 
+	BUILD_BUG_ON(offsetof(struct blkif_request, u.rw.id) != 8);
+	BUILD_BUG_ON(offsetof(struct blkif_request, u.indirect.id) != 8);
 	if (unlikely(nseg == 0 && operation_flags != REQ_PREFLUSH) ||
 	    unlikely((req->operation != BLKIF_OP_INDIRECT) &&
 		     (nseg > BLKIF_MAX_SEGMENTS_PER_REQUEST)) ||
@@ -1365,13 +1367,13 @@ static int dispatch_rw_block_io(struct xen_blkif_ring *ring,
 		preq.sector_number     = req->u.rw.sector_number;
 		for (i = 0; i < nseg; i++) {
 			pages[i]->gref = req->u.rw.seg[i].gref;
-			seg[i].nsec = req->u.rw.seg[i].last_sect -
-				req->u.rw.seg[i].first_sect + 1;
-			seg[i].offset = (req->u.rw.seg[i].first_sect << 9);
 			if ((req->u.rw.seg[i].last_sect >= (XEN_PAGE_SIZE >> 9)) ||
 			    (req->u.rw.seg[i].last_sect <
 			     req->u.rw.seg[i].first_sect))
 				goto fail_response;
+			seg[i].nsec = req->u.rw.seg[i].last_sect -
+				req->u.rw.seg[i].first_sect + 1;
+			seg[i].offset = (req->u.rw.seg[i].first_sect << 9);
 			preq.nr_sects += seg[i].nsec;
 		}
 	} else {
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

