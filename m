Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C2271F49A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjFAVZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 17:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjFAVZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:25:20 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7B6196;
        Thu,  1 Jun 2023 14:25:19 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id ED3F95C01D0;
        Thu,  1 Jun 2023 17:25:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 01 Jun 2023 17:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1685654718; x=1685741118; bh=YZHd7YYjlD
        K6sv+mkKSJgYpLNyemRttpNw5QnchM4bE=; b=kS5wGTshap2i++C5h1+TcSncc2
        FyNT5Ls4NghWOFzLklCX4jfQm1SrfiXo66GC2isWcdxhTthn0WyMAHJaWEIeAz+d
        BeX9M9RDPL9Y32OquGNX3RVXOvnLAhrGYDV+GrhQoe7w6g3Bo4YXRwDHWmbrjnY0
        WNNLkrPKPXI5Q74v546DBQ2iNrddhKnRHV9xPTCveDoRefQPpBU4KmQqdG48oJ/6
        G/W62z6gUVGPcamLkxaQUnvUXev+4NevkSbPwuH+6MD7sjFaBPbCTNg13yhHJ2EZ
        7tdxmXFToLqpFMwqVK6xCQjEK7EwvWniq9DdGBOQLTmBrufHLPxrPaSi6FAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685654718; x=
        1685741118; bh=YZHd7YYjlDK6sv+mkKSJgYpLNyemRttpNw5QnchM4bE=; b=B
        jqUds5OJLEiOrCvY8DDYia28d8+AGuiTY0nV6LPPKaTx+2zjEBJoQsS49+hlmZjI
        CCTkhS56YM2FuYbq7EQm58qze9jCa9ZEs/C13ZOvxaTI9Tl8pbvJ/knc4WZznSHQ
        MtZATudiq2KU6e7ye3tVGSloyyUNvbAW4ELQtPc0M/qLLs3q2CaW1WRBau8g0Zvz
        wwGCKiBv9yz6zE7qcgA3i62dbnnrgrNXScb/hXZjeWqxGtz9+SC7jIZY8C9L9uu1
        Ydnv/N9NaPZM3jBZJ3mozb75d8Nt6Lv4EhXSHAlAXkNYFIosfaC3dGicb470Oi98
        r+T0c9ScG7TQmBXyjXHMQ==
X-ME-Sender: <xms:vgx5ZJl5JgAUmNufEDYwNrsN-G-EO1QHsCR4dSUnokpwRfYWGjzzaA>
    <xme:vgx5ZE1Yo7CUXEE8RUAbNCt-a2-XbccgbUHqR4kXBCEIbdbgHqUHkViNfzWl5SG6-
    4qFydbJAtancIs>
X-ME-Received: <xmr:vgx5ZPoePhu157xZX-bbv9bP7pmGparlpW5qqGnD907mpClxwjMJ2GaKSQ86f7WG21O_oVMoxrY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeluddgudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeejffejgffgueegudevvdejkefg
    hefghffhffejteekleeufeffteffhfdtudehteenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:vgx5ZJk4owg_jhg1X2Q0y-8-n3Pmh7l4WlNHs6avJIjGRn_608YbQA>
    <xmx:vgx5ZH1TqGmlycWHksJaGk7SzXvvbrAwXecbkgip5uQ5DCMr1NgN8w>
    <xmx:vgx5ZIt20BUPJ49zXBNs04qcnRkE8iYmzz5VaApQ3y7kYwyhrhVP_A>
    <xmx:vgx5ZIwCP6Zwe8ZOcSjHX3FU-hk_ADpXTpOmK0PUcrGICiZQ3__59g>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Jun 2023 17:25:18 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 3/6] device-mapper: structs and parameter strings must not overlap
Date:   Thu,  1 Jun 2023 17:24:52 -0400
Message-Id: <20230601212456.1533-4-demi@invisiblethingslab.com>
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

The NUL terminator for each target parameter string must precede the
following 'struct dm_target_spec'.  Otherwise, dm_split_args() might
corrupt this struct.  Furthermore, the first 'struct dm_target_spec'
must come after the 'struct dm_ioctl', as if it overlaps too much
dm_split_args() could corrupt the 'struct dm_ioctl'.

Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
---
 drivers/md/dm-ioctl.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 64e8f16d344c47057de5e2d29e3d63202197dca0..da6ca26b51d0953df380582bb3a51c2ec22c27cb 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1391,7 +1391,7 @@ static inline fmode_t get_mode(struct dm_ioctl *param)
 	return mode;
 }
 
-static int next_target(struct dm_target_spec *last, uint32_t next, void *end,
+static int next_target(struct dm_target_spec *last, uint32_t next, const char *end,
 		       struct dm_target_spec **spec, char **target_params)
 {
 	static_assert(_Alignof(struct dm_target_spec) <= 8,
@@ -1404,7 +1404,7 @@ static int next_target(struct dm_target_spec *last, uint32_t next, void *end,
 	 * sizeof(struct dm_target_spec) or more, as otherwise *last was
 	 * out of bounds already.
 	 */
-	size_t remaining = (char *)end - (char *)last;
+	size_t remaining = end - (char *)last;
 
 	/*
 	 * There must be room for both the next target spec and the
@@ -1423,10 +1423,7 @@ static int next_target(struct dm_target_spec *last, uint32_t next, void *end,
 	*spec = (struct dm_target_spec *) ((unsigned char *) last + next);
 	*target_params = (char *) (*spec + 1);
 
-	if (*spec < (last + 1))
-		return -EINVAL;
-
-	return invalid_str(*target_params, end);
+	return 0;
 }
 
 static int populate_table(struct dm_table *table,
@@ -1436,8 +1433,9 @@ static int populate_table(struct dm_table *table,
 	unsigned int i = 0;
 	struct dm_target_spec *spec = (struct dm_target_spec *) param;
 	uint32_t next = param->data_start;
-	void *end = (void *) param + param_size;
+	const char *const end = (const char *) param + param_size;
 	char *target_params;
+	size_t min_size = sizeof(struct dm_ioctl);
 
 	if (!param->target_count) {
 		DMERR("%s: no targets specified", __func__);
@@ -1445,6 +1443,13 @@ static int populate_table(struct dm_table *table,
 	}
 
 	for (i = 0; i < param->target_count; i++) {
+		const char *nul_terminator;
+
+		if (next < min_size) {
+			DMERR("%s: next target spec (offset %u) overlaps %s",
+			      __func__, next, i ? "previous target" : "'struct dm_ioctl'");
+			return -EINVAL;
+		}
 
 		r = next_target(spec, next, end, &spec, &target_params);
 		if (r) {
@@ -1452,6 +1457,15 @@ static int populate_table(struct dm_table *table,
 			return r;
 		}
 
+		nul_terminator = memchr(target_params, 0, (size_t)(end - target_params));
+		if (nul_terminator == NULL) {
+			DMERR("%s: target parameters not NUL-terminated", __func__);
+			return -EINVAL;
+		}
+
+		/* Add 1 for NUL terminator */
+		min_size = (size_t)(nul_terminator - (const char *)spec) + 1;
+
 		r = dm_table_add_target(table, spec->target_type,
 					(sector_t) spec->sector_start,
 					(sector_t) spec->length,
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

