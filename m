Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E51267C3A1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 04:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjAZDei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 22:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236437AbjAZDeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 22:34:23 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAED4F358;
        Wed, 25 Jan 2023 19:34:17 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 2472C5C05B7;
        Wed, 25 Jan 2023 22:34:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 25 Jan 2023 22:34:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1674704057; x=1674790457; bh=fly1TGtjPYQFqq0ZAbmMb6xmSvsz35BqaEQ
        byQNg2OA=; b=D1MtYf7memgXbJNrc512Gsyf7cLrgjr6PQo/+5SRDUNVexrSxSC
        Jkb5mc4UepBZHaS+WfVmJOPzRnlte6IdRUwS2LchBnaoWtesjoO1buvJGixk1ZWt
        W2JlzBei3s3Q+yUEq/btspULrZTxS5BYxXousMYLYeRrAQ8Vz/bDNL7SjKPt/1HO
        V+D/T8GldIOZR/fE2l3RLQw7uXqbjeBid6SdZxtWQPQmjG+VNO/1ntp5kbEu7oFI
        lnzGP/sb+Mtlukny0sQD11buwfGcg/H2paeQWwfapygyZ1QbCpdMapdr3yZZzAOu
        2nJkuttV4wyUT8tSgLLiVazf/HXYBehvrdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1674704057; x=1674790457; bh=fly1TGtjPYQFq
        q0ZAbmMb6xmSvsz35BqaEQbyQNg2OA=; b=ctkpfx7SZRRL6KeO6bFZhCqe3XQGd
        ddY9ADAEaPF42/Pdj3OYxAFRo254vZsVEa8tWSr/KSF+zVoyu2EteDsynPXOj/iu
        63IO7MJyBbRlf7+vQey7wd0POoDgEkJdxFADcHNTYc1/FbN9ZjueKRKqVShvQjKd
        H52kTj6LTGwltBqYV4MSsF9pfN6Ngjul1V6orbHr317ENrVkDkF04ZJyJ/u6siGZ
        040psDMjFLte9H8xZp2q3BlERdUWC3vFfHvaXpbUYvoMJDuxj/eP7uesva1h1NAJ
        A31HPEIeEK62hAR0XVgh41M6lyaOiUZeQlINouPHd1OF+PYrKk/UTJ/5g==
X-ME-Sender: <xms:uPTRY-UJugvRHQWqLPTevHKqWNImygoOOyYewPe_uQqS9qbczCFzJQ>
    <xme:uPTRY6kQLCCCct-1GcPEKU697zRbqex5ZNGMVHmm5m1c95TxOkO3SEzC1ScFo6NML
    oOwjeNEzEMil4k>
X-ME-Received: <xmr:uPTRYyZG5ypvub0AjxhcULUmMs0YaTlx0iWR3IkE2nr6D7XtDdxS9uvROL8aCXQoMnZS-iuZdIud>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvfedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepheehvdekudfffeelkeelvdevffej
    ieetudeifeeliefgleffiedvgefhheehgfeunecuffhomhgrihhnpehinhguihhrvggtth
    drnhhrpdhinhguihhrvggtthdrihgunecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhslhgrsg
    drtghomh
X-ME-Proxy: <xmx:ufTRY1VuavHbMeRfNh8kDPgSScRHLLvGJKom87ozljBfd7VtLvnXOw>
    <xmx:ufTRY4kcERKeOg3A5RFmTzfWgpLEQfKpt-p4qEWyUhIR0g086pbcKg>
    <xmx:ufTRY6fYHq4xTO6jgFUdjKJN8TzKE92H_QhdqAHrdujMm1gOVJ1NeA>
    <xmx:ufTRY3ufM2M8yw78lZ1XU9KjM0U4Iyf08R5809m_oRpfv3KY2kmPCQ>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jan 2023 22:34:16 -0500 (EST)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Jens Axboe <axboe@kernel.dk>, Juergen Gross <jgross@suse.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 6/7] Minor blkback cleanups
Date:   Wed, 25 Jan 2023 22:33:57 -0500
Message-Id: <20230126033358.1880-6-demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126033358.1880-1-demi@invisiblethingslab.com>
References: <20230126033358.1880-1-demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change intended.

Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
---
 drivers/block/xen-blkback/blkback.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index a5cf7f1e871c7f9ff397ab8ff1d7b9e3db686659..8a49cbe81d8895f89371bdf50d1b445c088c9b6a 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -1238,6 +1238,8 @@ static int dispatch_rw_block_io(struct xen_blkif_ring *ring,
 	nseg = req->operation == BLKIF_OP_INDIRECT ?
 	       req->u.indirect.nr_segments : req->u.rw.nr_segments;
 
+	BUILD_BUG_ON(offsetof(struct blkif_request, u.rw.id) != 8);
+	BUILD_BUG_ON(offsetof(struct blkif_request, u.indirect.id) != 8);
 	if (unlikely(nseg == 0 && operation_flags != REQ_PREFLUSH) ||
 	    unlikely((req->operation != BLKIF_OP_INDIRECT) &&
 		     (nseg > BLKIF_MAX_SEGMENTS_PER_REQUEST)) ||
@@ -1261,13 +1263,13 @@ static int dispatch_rw_block_io(struct xen_blkif_ring *ring,
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

