Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E69716EBC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 22:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbjE3Ubx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 16:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbjE3Ubp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 16:31:45 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42893102;
        Tue, 30 May 2023 13:31:44 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 07F803200914;
        Tue, 30 May 2023 16:31:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 30 May 2023 16:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1685478702; x=1685565102; bh=pmcUjAGIZx
        Pp5PqEOgEqhVPemyqe9EdThZVOp4My7W0=; b=dxLeUTcWcURIKF3tIdl1etnJR5
        N5UmHb7gYi+h6qFr1h6Z9SC0wxIykswHISO17mCPtNq0NeJ2R7ZcfGGhLXwnTney
        w8vxVkRbqSYZPBXyoXLHByjIvnG7lVS1jupBNpog/rJiveBJkSUPozGoVJ7YSQ2s
        5WwQwq4OgSFQTe9eiKn7KoyWGFsUiGRonLvgMZjB7AU41/HyAj9TrO8UFizlMc2Z
        kjC/rqLsVAqk9UrzpS9OE5eKXjHUQXPwX7RzgO3B8+rrUSBY/uIyHCeXOIFrFBUx
        973IopAKjgCl01cB9/nuRm3U4VY/cNn+Itf/ju/WYCERZTrBTExuvORyanOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685478702; x=
        1685565102; bh=pmcUjAGIZxPp5PqEOgEqhVPemyqe9EdThZVOp4My7W0=; b=R
        UawBqS8r1YDIM4po3y2qsUXbp4zg/tVMtIWDUkXk2Kttv3pfjWUl31EWtaAo+jxK
        /kXxCsfVJzLogYbQFIxM2poNZdJNrkxjSdHCH5xBtj6GqDUUr/oIGSviHONsPWSr
        5v6LrhEM6HNy5GTorYKFgU7SqRGmewjInn2Q1ucsg36zNhg2F569jrlQRLrzGISB
        VIPuAEgV8JZufoZHXDa5LvBF0VsBt0uhRJzkJEAj0jc5U4TnTzHUo0/sRvcLbXSc
        m5CjwzswZE+AcQvkKG85UgCo8pJ17KM+Ph8DKWcmh0kLvVw8cL/Rv4b9TOLUJLWc
        mOiGUxDYt8n0bB7FAA8WA==
X-ME-Sender: <xms:Ll12ZG3ypkz4lUPkIh0DuuQJncBHG735YKqtwU_ktkPdRq3r_9RvgA>
    <xme:Ll12ZJFCVeuAe8Vsr8iAvdOZolH1VlPf7VqJi3_telOOU7kNKuGYsc6DpT14VVJ1H
    FGXcz41JK2iJiQ>
X-ME-Received: <xmr:Ll12ZO71J-CEsAY4_Mr_pTBBQiwUFmjqPIVJ-vTjQf3Y3pRLiM1GadCnVubwZ2flnJFCr-gRBvM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeejffejgffgueegudevvdejkefg
    hefghffhffejteekleeufeffteffhfdtudehteenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:Ll12ZH32Qri6hjgGiJ0FllRPCLo39f-5qy7T3uCDJ8LU5VX4h79TIg>
    <xmx:Ll12ZJEFd3tCtAnkRbIsBqGjfGNkEmSNFU7LjPpUMlqH7CTGrgKV0Q>
    <xmx:Ll12ZA9BQOHMzZIe_5G8lnEVFKz0d1wcyoVCA08ic3b5UkqDI5J22w>
    <xmx:Ll12ZPY1mCG9yLlRFWakggEPeJhZj6eEHLmC5CNrACfoZ9SfSMTPtg>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 May 2023 16:31:41 -0400 (EDT)
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
Subject: [PATCH v2 03/16] device-mapper: do not allow targets to overlap 'struct dm_ioctl'
Date:   Tue, 30 May 2023 16:31:03 -0400
Message-Id: <20230530203116.2008-4-demi@invisiblethingslab.com>
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

This prevents dm_split_args() from corrupting this struct.

Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
---
 drivers/md/dm-ioctl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 64e8f16d344c47057de5e2d29e3d63202197dca0..a1d5fe64e1d0d9d3dcb06924249b89fe661944ab 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1444,6 +1444,12 @@ static int populate_table(struct dm_table *table,
 		return -EINVAL;
 	}
 
+	if (next < sizeof(struct dm_ioctl)) {
+		DMERR("%s: first target spec (offset %u) overlaps 'struct dm_ioctl'",
+		      __func__, next);
+		return -EINVAL;
+	}
+
 	for (i = 0; i < param->target_count; i++) {
 
 		r = next_target(spec, next, end, &spec, &target_params);
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

