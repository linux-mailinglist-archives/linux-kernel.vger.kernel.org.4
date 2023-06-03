Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6757210AA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 16:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236733AbjFCOxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 10:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235476AbjFCOxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 10:53:19 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19CC196;
        Sat,  3 Jun 2023 07:53:17 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 503095C00C8;
        Sat,  3 Jun 2023 10:53:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 03 Jun 2023 10:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1685803997; x=1685890397; bh=YZHd7YYjlD
        K6sv+mkKSJgYpLNyemRttpNw5QnchM4bE=; b=TnOxlFpRryRJNsR7dpT46fcwU5
        WqmiJVKfcJVhI69FXcnQw0XXlGXPg9eAkwuvXv+2oNga3YcKAjpqy3i488+aRrQ1
        R5lK/T/ytfC9Y2lXcCgBAXPny4UlKg2y68Bt3b/hiAhg5WH1yPTucdXexc89KnxJ
        j1CGz+TJS3grfw+G1Cgjm9Sv6qjcOTvodT7ihTNrN5QIGI3I/RfTsbBk56hQq/dj
        N7LCPY8GSBfWjfzC+P7v6OLtBIxGKpPF8y4q8AUbXmHRxPMcNYoKVzQn/38pKOrn
        cgHs49N9IOZLlTsTUhzfV30H3FLTnOs/+4aE9dCOlJCooyPlIaVG0RbUS6tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685803997; x=
        1685890397; bh=YZHd7YYjlDK6sv+mkKSJgYpLNyemRttpNw5QnchM4bE=; b=R
        KSwHSh5CbZGFPlBIs95J+lFNUW+CiVOmBjXlwhhHamgOnD6blPnTsSZctV6KhZa6
        rc8xKQZcZgcSqnTJqDP5e2MCQGsgvnwfyadaEXHClMLKu3tG5xQA54ukTJZzIqI/
        8+MC0YPY2gS6iy9ukE0ol1BYlctioyi3n6uC5y5zxKZgigk8d0sFaEj9Xw0UuXA0
        74ubqf28G7Zee6IfmuHYdlAINdOLRb1ZELv1M+ysGpADDiI1rdxdyjLfQJ4PqBMT
        U+jozsg5GFP3J/LvN5+U9Et3QjGPM8kIC19TnhmtyaZqCZHvDxVA51pJD/AQn00W
        t2Gm+rYVbFTgUUbmGkvcA==
X-ME-Sender: <xms:3VN7ZIjtvr-hGPa2eAqMGPPBk3kg81-uNdIgPs7fp1jqnHyTjgj4Hg>
    <xme:3VN7ZBBvCV_lM-ebsJpvXTDXbKa3LYrMufYXqA_Qq5FioHXC6N1TG0qwg0IwPkDwN
    QN-AF1eNhKWPdU>
X-ME-Received: <xmr:3VN7ZAEC7SpFyijRN8PCmYeHNBTy04K3zEJDn0XHNJ3ic_SG0N35QtYbbGuNgTElKjkTX16rGlM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelhedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgvmhhi
    ucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhngh
    hslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepjeffjefggfeugeduvedvjeekgfeh
    gffhhfffjeetkeelueefffetfffhtdduheetnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhs
    lhgrsgdrtghomh
X-ME-Proxy: <xmx:3VN7ZJQshjK0OPVZRyMOvUkjEAlvzktF87-H0QbB09KdHmXGg6sWtw>
    <xmx:3VN7ZFy34bsTIjkJyP1YL7_JyTO9CUp-wBx04YlnaD85tT2hAKbiKg>
    <xmx:3VN7ZH5WjhtCzpfyFr5-AGu7p4R-itSBC6XJQDOH4CO-SmF-BWypGA>
    <xmx:3VN7ZN_N75wSI2u1kCUoeJH0pfb-_0GlDNZhJ9UYKwPA8R1ujP-npA>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Jun 2023 10:53:16 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2 3/6] device-mapper: structs and parameter strings must not overlap
Date:   Sat,  3 Jun 2023 10:52:41 -0400
Message-Id: <20230603145244.1538-4-demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230603145244.1538-1-demi@invisiblethingslab.com>
References: <20230601212456.1533-1-demi@invisiblethingslab.com>
 <20230603145244.1538-1-demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
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

