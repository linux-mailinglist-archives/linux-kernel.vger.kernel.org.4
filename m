Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6811568CBDA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 02:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjBGBTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 20:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBGBTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 20:19:09 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860AE1A4AF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 17:19:08 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 0D99332008FD;
        Mon,  6 Feb 2023 20:19:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 06 Feb 2023 20:19:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding:date
        :date:from:from:in-reply-to:message-id:mime-version:reply-to
        :sender:subject:subject:to:to; s=fm3; t=1675732744; x=
        1675819144; bh=zYPj50UvVEIOsgADXJp+oJsb7O+roahlWS7jztV/S9A=; b=d
        gkINF9MygUXfd1bB4N9gmnLi686uzaq6pqgf+ye9RW5DDdi7SJEFDGDak/HvVCm+
        Jsm6mLu6t274pUa82bhmrP0nSwPz26yG6CymyFblzcvq97dIyW5dlLV4fvZJVvDx
        Htko471RBmfnCZ6AJAims5MzFeYKb68UyKm6eBadkvheWl7pMZmMJAa3ghgh+OgG
        bCXlAIG2OI7B5xvkjnTBNgohd/wE0GDZIBrJgyKZRg86etnUeoliFcGKHyAPfJET
        zr6itNKCgcG2KLW0WmIgDz5bj9CpszH1HMunFz4GYMEK83dGTobHu6V9o/ZbndiK
        uyYT3Ngys6ED+cqFmJJWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1675732744; x=1675819144; bh=zYPj50UvVEIOsgADXJp+oJsb7O+roahlWS7
        jztV/S9A=; b=TjtVQ2ZEIp1gCY+/1sP43JqJpyFvx7k95CwP8kXCM7DCQyuQFSl
        NkhncWZ0yAYLGZmwT/+fVcPqr675oPVmMvZIxMPd/dzXVm/lSueg96US154JsLCh
        8jlDZPkZ5aQgu7xOrSTfY7+jcHvJvVcwRaAoaaeywjGV2lbC8yoU+FGgXH8yLE6C
        VhnDaZCjD7YA6bE6hpvSPWMIhSkjmuOuiY4fEmzSLAJsO+5MEhIR94Njq9tmiV0e
        ViS/NdLIJSd548kHJt6uU7ONVCIlHlxjvXkJyEqD2Ktbn0bDZS1Nt9vV6oTYViw9
        ADE5+nmRRDW24UzwRnqmQSs200ZIEw97bzg==
X-ME-Sender: <xms:CKfhY5ZvTjLwfiybMAqx2xh49i_HCyry6qI8tI0G5F5DMlQw5WMO_w>
    <xme:CKfhYwZj5B1TSoUMUmIQmuevI_xMHZxvjNb4hNgrXIc5OiaaBrxJSZedKPZlKzPqZ
    iIVH1n7JBXQpIA>
X-ME-Received: <xmr:CKfhY7_lHWBNEimbxE6iiCU8KJ3UdvmWKUqAiQ0aMAD6fBI_aiJ528E0Qy07qaEKFudDIQ2Y4FQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegjedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgvmhhiucfo
    rghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhnghhslh
    grsgdrtghomheqnecuggftrfgrthhtvghrnhepvdefgeekvdekgfffgeekhfeijedtffek
    hefhleehfeejueetgfelgefgtdevieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhslhgr
    sgdrtghomh
X-ME-Proxy: <xmx:CKfhY3rYG3wiVsBDFyfuiwAWLwuYq7pH0P4KcwmBs6Z-OPFkQ9XJow>
    <xmx:CKfhY0qMFHVn6M_W2vXDDb3zi42VT6PToq0bG5xObwtVNM7n5nw9gw>
    <xmx:CKfhY9TT6FCTfP33sttJChAcWtaceJ2EQgbMVKx-jmqcKkoCkDuErA>
    <xmx:CKfhY_Vf4DiFi7KbOSfNr4J22dR2iDI2aST25ufFzZHDe7F66lDDMg>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Feb 2023 20:19:03 -0500 (EST)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Fail I/O to thin pool devices
Date:   Mon,  6 Feb 2023 20:18:48 -0500
Message-Id: <20230207011849.1343-1-demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.39.1
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

A thin pool device currently just passes all I/O to its origin device,
but this is a footgun: the user might not realize that tools that
operate on thin pool metadata must operate on the metadata volume.  This
could have security implications.

Fix this by failing all I/O to thin pool devices.

Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
---
 drivers/md/dm-thin.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index 64cfcf46881dc5d87d5dfdb5650ba9babd32cd31..d85fdbd782ae5426003c99a4b4bf53818cc85efa 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -3405,19 +3405,14 @@ static int pool_ctr(struct dm_target *ti, unsigned argc, char **argv)
 
 static int pool_map(struct dm_target *ti, struct bio *bio)
 {
-	int r;
-	struct pool_c *pt = ti->private;
-	struct pool *pool = pt->pool;
-
 	/*
-	 * As this is a singleton target, ti->begin is always zero.
+	 * Previously, access to the pool was passed down to the origin device.
+	 * However, this turns out to be error-prone: if the user runs any of
+	 * the thin tools on the pool device, the tools could wind up parsing
+	 * potentially attacker-controlled data.  This mistake has actually
+	 * happened in practice.  Therefore, fail all I/O on the pool device.
 	 */
-	spin_lock_irq(&pool->lock);
-	bio_set_dev(bio, pt->data_dev->bdev);
-	r = DM_MAPIO_REMAPPED;
-	spin_unlock_irq(&pool->lock);
-
-	return r;
+	return -EIO;
 }
 
 static int maybe_resize_data_dev(struct dm_target *ti, bool *need_commit)
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

