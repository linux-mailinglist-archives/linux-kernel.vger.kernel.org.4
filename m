Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027E3716EAF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 22:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbjE3Ubo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 16:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjE3Ubi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 16:31:38 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D64AFC;
        Tue, 30 May 2023 13:31:38 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id E111C3200564;
        Tue, 30 May 2023 16:31:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 30 May 2023 16:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1685478696; x=1685565096; bh=YCzACzClxG
        a/ktYTHwJaaNWjaN7phPISbw1cPfpWZUo=; b=A2bqaqsodYaS3trUBnAvHbPHd3
        LVnzv94OZsAab6NwgPLjBRfIiWlcKcR9Am7w7rrKWKhPylPRgC/Z2VcNnFU62eUL
        QTY6dlRFGDe23eZCW+dp0yNNmIRdMnyt2GgAGoiZhtgYvFZOA0VagWHCdhatNzfh
        TUgJDh+kiXR5cwVFR2KVVnJ7q4TZ5ZwBzCrj9Ax6A1mxFH11UB3jAjTrIxT82ler
        iv2JQNpLTLFvHis5VI4rWrAU32RDGijA49HX+5RYgB9Kc80xrRJg46IUUWg09Whp
        OfnQ4sOEVlnEOjG350bX8Xu2+XWR1rAuxgIrN4SPyci767A9fPU8B1J2jDPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685478696; x=
        1685565096; bh=YCzACzClxGa/ktYTHwJaaNWjaN7phPISbw1cPfpWZUo=; b=W
        WCIJ4Q1thNeJ9imoVk0+dlu1mJom8VM4vHfRKeLxMXjDqr0PwWHi8Pq8EqycYuWd
        pRyrl8aldz+pjfYnAgy+Kh35P1CyNuQUI3mrEIQOCMgmmSGUUCfVBQT72wavTR/V
        4z3iS7j2NEdfQcwwDSR32YarwaCCyQuGbfUgprJEbygrw8xplcCYQEFQbiREHXnq
        Bl8hQ68TiF84tjWjP2sbeAf3ceMf3sytqQt110go28ao3jtHtBvxsYJ0Fby4sCtP
        d3nB1fS6fQM0vzfbFfklzcPFwD3Fcw3Mj0ihhxf+Z72Q9IW+KDqdO2d8eoW5rmDb
        GSIQ01eTKLxX0YWgJcCqA==
X-ME-Sender: <xms:KF12ZIcWTu9BgYWVnhEkNCgyldRjiIIivqliwszOsduSmFm4IdqoPQ>
    <xme:KF12ZKP95io6VvF4anqN-RsGY3JIHPM2H_NNrf4hAiPKulV0tnnZybCWntLhxeqO4
    -Lik-Rhg1tlrDQ>
X-ME-Received: <xmr:KF12ZJjI3u9l3-RJvdt8Vo8A2EOjQ1fCbipCpT13Yne0YnV48t4V2u40avU4A8Q9pgTwxkx9Nw4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeejffejgffgueegudevvdejkefg
    hefghffhffejteekleeufeffteffhfdtudehteenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:KF12ZN9kF0sGBlydds97tAta0NfieJK6SAd2g6wQaosp7uuxUJxIOg>
    <xmx:KF12ZEsRbplVPcJ71hKhLybUZMBxmbbFJybIQOln5uajLbXnbU2EaQ>
    <xmx:KF12ZEFbcbNdqbMxc5DAHolQq6sk_b8v92Q6aZJ8BV3hV8qPPuHfEQ>
    <xmx:KF12ZCAHscFGlI7DgBCVB9vwCGwd2SVURCYci4wh5OyMxMxUjfbZtA>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 May 2023 16:31:35 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        stable@vger.kernel.org
Subject: [PATCH v2 01/16] device-mapper: Check that target specs are sufficiently aligned
Date:   Tue, 30 May 2023 16:31:01 -0400
Message-Id: <20230530203116.2008-2-demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530203116.2008-1-demi@invisiblethingslab.com>
References: <20230530203116.2008-1-demi@invisiblethingslab.com>
MIME-Version: 1.0
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

Otherwise subsequent code will dereference a misaligned
`struct dm_target_spec *`, which is undefined behavior.

Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
---
 drivers/md/dm-ioctl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index cc77cf3d410921432eb0c62cdede7d55b9aa674a..34fa74c6a70db8aa67aaba3f6a2fc4f38ef736bc 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1394,6 +1394,13 @@ static inline fmode_t get_mode(struct dm_ioctl *param)
 static int next_target(struct dm_target_spec *last, uint32_t next, void *end,
 		       struct dm_target_spec **spec, char **target_params)
 {
+	static_assert(_Alignof(struct dm_target_spec) <= 8,
+		      "struct dm_target_spec has excessive alignment requirements");
+	if (next % 8) {
+		DMERR("Next target spec (offset %u) is not 8-byte aligned", next);
+		return -EINVAL;
+	}
+
 	*spec = (struct dm_target_spec *) ((unsigned char *) last + next);
 	*target_params = (char *) (*spec + 1);
 
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

