Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EF171F496
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjFAVZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 17:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjFAVZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:25:19 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B3B184;
        Thu,  1 Jun 2023 14:25:18 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 85EE95C01DB;
        Thu,  1 Jun 2023 17:25:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 01 Jun 2023 17:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1685654717; x=1685741117; bh=aSjkzE25S8
        BxmyJfHmxx2kjK812O0BGlmJS9UYp63Y4=; b=l1QRMld4HT61hs5D/NwPdFVT8i
        oLYi6LDHCqiBkgvcqQXsObJksonX1R1o0vJzWl5xO8LQpP66ixDBpNT+xKcYinHa
        5gEutmzEBfhG9wbnq7gIuhJx7/m06WFwH9VKZyMZQl75wNr6tWNxZvRrBPuJ3WBU
        tSTOetyK7AML5Bdtm/k6YR3rL3V5pPxAsuisQtEuD0NikrdzPvQ31rh4icqmuKNe
        1tnlcwk89P3puxhb4vgTQlSpzjWMsp4aPWAijOfbdNkPq8sNWTqz8kavYLZKdqEc
        TFNNV3U69HP9aKyik46iO8LpjGMN9t6bhM232FzLpsIRzD7qA+MSfFnMkkpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685654717; x=
        1685741117; bh=aSjkzE25S8BxmyJfHmxx2kjK812O0BGlmJS9UYp63Y4=; b=d
        F7DfCZGlFoFRWdE4a0L4fK8mg1yy7Xj2devYGeeWHz12mMNDZcdG2gVhM2uLpa8o
        87MPBdZW18Tj0BNrvZZaSQzUlzJp+VZwGw5crlSVzU1OZuKsSrieNijJG4JVIlEJ
        Ca9zONBGWxs35RtWYiG59IK5iE3jyRes2HUj4slcJoASX+q9uqreiUIy/bdtSNYO
        CvIE3Bc6Q3mIJZn4sieEGmsOEVfRlUtXTQxRfbsFbuFi0eEKWlyIP1+qQr85dD1i
        rPLvLy5JlrJqOPGLTT2uYATtLjqMScRR83owCkU5o56gAGpUqLPskVs2IEj+gkJy
        tCyy0acVlqNfyPM0nMYXw==
X-ME-Sender: <xms:vQx5ZJiFOPDS_L-qPRHAaHG3SnLTPnA8bg02T_q311Bl-zwI81tcfA>
    <xme:vQx5ZOCNLVAIjjKbxcLZbhi7B68V5Pv1ssQl3HF5nU5tVgKoFmNPSlyPQvsFcq7_q
    R6agQuNDOeMSZo>
X-ME-Received: <xmr:vQx5ZJEAvRI_K4AYnyyWTRb9OuU0LigTVsiHhLDnT5Li_nhPBo7nhmSzQobG85JKEn0ACfCn4Yc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeluddgudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeejffejgffgueegudevvdejkefg
    hefghffhffejteekleeufeffteffhfdtudehteenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:vQx5ZOTvilGJIEZqjXUeRpl9a0mSlMratywuPnq5Zv7Pbm6ul2jK7Q>
    <xmx:vQx5ZGzAIqYv7Mn7c3BV46X2hZzmkEJ14ablZml4YEWFYl80qdDHeA>
    <xmx:vQx5ZE6SI4LQk0g-gHkL3jZw9Uy5x987uSFrst6RCBC7dswNUzsR8w>
    <xmx:vQx5ZK-zYlvuQsMwWOaA0DeVtVF1zY09s3XjhifsIP3QUO7wTWtJHg>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Jun 2023 17:25:16 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 2/6] device-mapper: Avoid pointer arithmetic overflow
Date:   Thu,  1 Jun 2023 17:24:51 -0400
Message-Id: <20230601212456.1533-3-demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601212456.1533-1-demi@invisiblethingslab.com>
References: <20230601212456.1533-1-demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Especially on 32-bit systems, it is possible for the pointer arithmetic
to overflow and cause a userspace pointer to be dereferenced in the
kernel.

Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
---
 drivers/md/dm-ioctl.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 34fa74c6a70db8aa67aaba3f6a2fc4f38ef736bc..64e8f16d344c47057de5e2d29e3d63202197dca0 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1396,6 +1396,25 @@ static int next_target(struct dm_target_spec *last, uint32_t next, void *end,
 {
 	static_assert(_Alignof(struct dm_target_spec) <= 8,
 		      "struct dm_target_spec has excessive alignment requirements");
+	static_assert(offsetof(struct dm_ioctl, data) >= sizeof(struct dm_target_spec),
+		      "struct dm_target_spec too big");
+
+	/*
+	 * Number of bytes remaining, starting with last. This is always
+	 * sizeof(struct dm_target_spec) or more, as otherwise *last was
+	 * out of bounds already.
+	 */
+	size_t remaining = (char *)end - (char *)last;
+
+	/*
+	 * There must be room for both the next target spec and the
+	 * NUL-terminator of the target itself.
+	 */
+	if (remaining - sizeof(struct dm_target_spec) <= next) {
+		DMERR("Target spec extends beyond end of parameters");
+		return -EINVAL;
+	}
+
 	if (next % 8) {
 		DMERR("Next target spec (offset %u) is not 8-byte aligned", next);
 		return -EINVAL;
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

