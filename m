Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E312C716EC1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 22:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbjE3UcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 16:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjE3Uby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 16:31:54 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937E4118;
        Tue, 30 May 2023 13:31:50 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id E7B28320091C;
        Tue, 30 May 2023 16:31:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 30 May 2023 16:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1685478708; x=1685565108; bh=9dA8w08Lf6
        yLxBKaYsZib4B6okJI6Rf5TV9rO9Rq5kQ=; b=RqK1KJ1X1SLFXUPUiLR1ErkxSG
        wtKH1zEfrkJGt+cTam8om+jkJorj31HumCzC/S/NBs42VK9J2wPDcvRJtfbOY/PF
        LzxWIsfwLXWGb7AxPlJ+e9IZ0X7jZ/z50ke/BXkU2TVtU0G1j5omrVQ2OdS1YxCW
        t/51b1V8oIA+9ZyeONf7TZzODRQdx/JUayG7fSa+zO2QmmQE8w63GnLlKq+2l5bP
        J5JFEIp5z0YHGwPY8OdfIQlO1/OuUlcVKYbTHF8/ZPUYhtPBuBVIxIylNt97ox2P
        MzGhApOEsQ6j1W/JMW5aBKxVbzfonneR3x5JGYO5PGF86JEMjtyBJwlxTCUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685478708; x=
        1685565108; bh=9dA8w08Lf6yLxBKaYsZib4B6okJI6Rf5TV9rO9Rq5kQ=; b=D
        Msesq2aD/zsowges6BdJEmb3SXxsFD50z2JBIaZKcphdbkZ8bDmxUs+DpndiTUmB
        28v8uLd5dcZv2la0SPjq1IwvKXdC+gIuyMcnYmia7XsERzw2uH7FI8XCSafdXsu5
        EwMa0FI0jMTfRMekX9dRzZzq/aXRflH8qoHSxBLO1INLOvf1SoFV0H7bKQGsjupU
        NaniLmIVlRC/FaEd2D59ZYclkFgzLdscGM91ChlBj2LB5LbIQ847VIEasOMlHpNj
        nXWlcHyU433Z0l3bCdc9lS+C0bcphxZM4Q8ER2dJu2pRsL2pebnHxAxThnCbO/IS
        edfGYluS8mDU8v5EtX9dg==
X-ME-Sender: <xms:NF12ZPsxzLb6qiNMX1P2rmKAhz4tbssdhxqb5b2W4EpVXzuVeLIYuA>
    <xme:NF12ZAfmMk9oJ8u-mhK6Ui9Ulx5bvQ75B1qWdW7mwmhy1E8VWdhGqMqT5i45iBhrL
    5_Kp9tH1jr-geA>
X-ME-Received: <xmr:NF12ZCyTKoszpzg74E1caX7SPMUAsM7ZbJgaQdN_fT3vsPw-0CdsBuS4E3sGSm5CMXcpcrCEQj8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeejffejgffgueegudevvdejkefg
    hefghffhffejteekleeufeffteffhfdtudehteenucevlhhushhtvghrufhiiigvpedune
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:NF12ZOOdzZrmzTTxQPerP2vAcrpzO6xwvMZsOM5HHfWIHjdkHwKsOw>
    <xmx:NF12ZP_v7UgW9QNz5GrWbg7QsOI10Y-VgTtA-VukT93FIMsnJVueuQ>
    <xmx:NF12ZOXl6LQXxBP_VPj-MHje4cHa370IULNKDufIrLuGd68vCXJiiw>
    <xmx:NF12ZLSelBIStPRHT1mOrFfztO0x3Inl8EpbIXnSumWL1iS8_dkzOg>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 May 2023 16:31:47 -0400 (EDT)
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
Subject: [PATCH v2 05/16] device-mapper: Target parameters must not overlap next target spec
Date:   Tue, 30 May 2023 16:31:05 -0400
Message-Id: <20230530203116.2008-6-demi@invisiblethingslab.com>
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

The NUL terminator for each target parameter string must preceed the
following 'struct dm_target_spec'.  Otherwise, dm_split_args() might
corrupt this struct.

Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
---
 drivers/md/dm-ioctl.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 9f505abba3dc22bffc6acb335c0bf29fec288fd5..491ef55b9e8662c3b02a2162b8c93ee086c078a1 100644
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
@@ -1423,7 +1423,7 @@ static int next_target(struct dm_target_spec *last, uint32_t next, void *end,
 	*spec = (struct dm_target_spec *) ((unsigned char *) last + next);
 	*target_params = (char *) (*spec + 1);
 
-	return invalid_str(*target_params, end);
+	return 0;
 }
 
 static int populate_table(struct dm_table *table,
@@ -1433,24 +1433,21 @@ static int populate_table(struct dm_table *table,
 	unsigned int i = 0;
 	struct dm_target_spec *spec = (struct dm_target_spec *) param;
 	uint32_t next = param->data_start;
-	void *end = (void *) param + param_size;
+	const char *const end = (const char *) param + param_size;
 	char *target_params;
+	size_t min_size = sizeof(struct dm_ioctl);
 
 	if (!param->target_count) {
 		DMERR("%s: no targets specified", __func__);
 		return -EINVAL;
 	}
 
-	if (next < sizeof(struct dm_ioctl)) {
-		DMERR("%s: first target spec (offset %u) overlaps 'struct dm_ioctl'",
-		      __func__, next);
-		return -EINVAL;
-	}
-
 	for (i = 0; i < param->target_count; i++) {
-		if (next < sizeof(*spec)) {
-			DMERR("%s: next target spec (offset %u) overlaps 'struct dm_target_spec'",
-			      __func__, next);
+		const char *nul_terminator;
+
+		if (next < min_size) {
+			DMERR("%s: next target spec (offset %u) overlaps %s",
+			      __func__, next, i ? "previous target" : "'struct dm_ioctl'");
 			return -EINVAL;
 		}
 
@@ -1460,6 +1457,15 @@ static int populate_table(struct dm_table *table,
 			return r;
 		}
 
+		nul_terminator = memchr(target_params, 0, (size_t)(end - target_params));
+		if (nul_terminator == NULL) {
+			DMERR("%s: target parameters not NUL-terminated", __func__);
+			return -EINVAL;
+		}
+
+		/* Add 1 for NUL terminator */
+		min_size = (nul_terminator - (const char *)spec) + 1;
+
 		r = dm_table_add_target(table, spec->target_type,
 					(sector_t) spec->sector_start,
 					(sector_t) spec->length,
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

