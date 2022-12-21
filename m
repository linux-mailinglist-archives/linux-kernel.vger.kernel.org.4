Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8A5652C9E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 07:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiLUGBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 01:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbiLUGB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 01:01:28 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7B99FED
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 22:01:26 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id g1so9995201pfk.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 22:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMWDOSwDa2fJZaK2qvEdhPYi5mJW5ESN2yWnqdHTXKY=;
        b=d1XJ0LC7K62G/BE2GJcMMB4lKX9S5DOWXKebJXBuG/f7WGlZYWo0Y/8x2TsIPYhQRo
         pa7+Zr+vV9Yx72kCfj+DM0gedruzyMtl2bPAcBEPFY2rP+7qu4MZYbGdxTPsIkp1EvvE
         twKa/x/J5/vM0gn+jcde+3MBUbrnLoAWIdfzhh63cunZPKW5iP+BzOJKLeGD13VSuKcL
         FupTfz5c9Euqf2z+ULNQOqw7T13CK5ke7g03R02/TkJ6G6mpuPUn0w3ToDSvMid1QouI
         os8jivNy3tPNgFuw4UM+0J1X0mx2vUHH787gV0q3ZuTjcxGSHd36s/QhOYvBPzzRDuoD
         ShRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qMWDOSwDa2fJZaK2qvEdhPYi5mJW5ESN2yWnqdHTXKY=;
        b=Qa8mru8aL5i4gULJzaDuFKiqgsQ4ysGEDg9fW44mZA6jWHuFM8hrOjlR42vrBEpceL
         0whciGoN7bxVrkN6apcemzi5fX9/oqQTCtyNXnblLr4ZkQ4pT/0A5Ucal3tgzAg2VUjV
         ibyP+znmYHYa5hAv4Th6qoJq9mlVyZ4Bl2+8L7pdEmZ5ZSavgQvdcFXzkS3in5u6k5KP
         micznzfI4kduqOe8hRIaNrPdmlQk+jxviZyLgwCYzCXlOiiJ0rq7SmixNOwVZEHwVvp3
         tyXud29NyKM5TSbeS7YAZR7XsWYyCUV3uncgT5LgDmx92QNUKzmqskHsVptV525wF8gP
         dfkA==
X-Gm-Message-State: AFqh2koXF1iD0n3S0pNGGd9gyA7QtKTtyIcQxRJ/frayHkbcM4nLgax5
        Cv0RUKgL9ZyCdHelxLoEzio=
X-Google-Smtp-Source: AMrXdXsCM96KvIVOVe3Zhf07YYI64smG+DMZpPQxHyRJJeMjLIijY/PARh+DkRgyM1DYJcTeBFUlgw==
X-Received: by 2002:aa7:9d1e:0:b0:56c:3ed0:1f9d with SMTP id k30-20020aa79d1e000000b0056c3ed01f9dmr972403pfp.17.1671602486390;
        Tue, 20 Dec 2022 22:01:26 -0800 (PST)
Received: from vernon-pc.. ([114.231.52.81])
        by smtp.gmail.com with ESMTPSA id w7-20020a626207000000b00562677968aesm9598886pfb.72.2022.12.20.22.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 22:01:25 -0800 (PST)
From:   Vernon Yang <vernon2gm@gmail.com>
To:     Liam.Howlett@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>
Subject: [PATCH v2 1/7] maple_tree: remove extra space and blank line
Date:   Wed, 21 Dec 2022 14:00:52 +0800
Message-Id: <20221221060058.609003-2-vernon2gm@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221221060058.609003-1-vernon2gm@gmail.com>
References: <20221221060058.609003-1-vernon2gm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These extra space and blank line is unnecessary, so drop it.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Vernon Yang <vernon2gm@gmail.com>
---
 include/linux/maple_tree.h |  2 --
 lib/maple_tree.c           | 14 ++++----------
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index e594db58a0f1..4ee5a969441c 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -517,7 +517,6 @@ static inline void mas_reset(struct ma_state *mas)
  * entry.
  *
  * Note: may return the zero entry.
- *
  */
 #define mas_for_each(__mas, __entry, __max) \
 	while (((__entry) = mas_find((__mas), (__max))) != NULL)
@@ -639,7 +638,6 @@ static inline void mt_set_in_rcu(struct maple_tree *mt)
 }
 
 static inline unsigned int mt_height(const struct maple_tree *mt)
-
 {
 	return (mt->ma_flags & MT_FLAGS_HEIGHT_MASK) >> MT_FLAGS_HEIGHT_OFFSET;
 }
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index fe3947b80069..8ace65a5eea5 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -183,7 +183,6 @@ static void ma_free_rcu(struct maple_node *node)
 	call_rcu(&node->rcu, mt_free_rcu);
 }
 
-
 static void mas_set_height(struct ma_state *mas)
 {
 	unsigned int new_flags = mas->tree->ma_flags;
@@ -468,7 +467,7 @@ static inline
 void mte_set_parent(struct maple_enode *enode, const struct maple_enode *parent,
 		    unsigned char slot)
 {
-	unsigned long val = (unsigned long) parent;
+	unsigned long val = (unsigned long)parent;
 	unsigned long shift;
 	unsigned long type;
 	enum maple_type p_type = mte_node_type(parent);
@@ -502,7 +501,7 @@ void mte_set_parent(struct maple_enode *enode, const struct maple_enode *parent,
  */
 static inline unsigned int mte_parent_slot(const struct maple_enode *enode)
 {
-	unsigned long val = (unsigned long) mte_to_node(enode)->parent;
+	unsigned long val = (unsigned long)mte_to_node(enode)->parent;
 
 	/* Root. */
 	if (val & 1)
@@ -1278,7 +1277,6 @@ static inline void mas_alloc_nodes(struct ma_state *mas, gfp_t gfp)
 		mas->alloc->total = success;
 	mas_set_err(mas, -ENOMEM);
 	return;
-
 }
 
 /*
@@ -2946,7 +2944,7 @@ static inline void *mtree_range_walk(struct ma_state *mas)
 	mas->min = prev_min;
 	mas->max = prev_max;
 	mas->node = last;
-	return (void *) next;
+	return (void *)next;
 
 dead_node:
 	mas_reset(mas);
@@ -3464,7 +3462,6 @@ static inline bool mas_push_data(struct ma_state *mas, int height,
  */
 static int mas_split(struct ma_state *mas, struct maple_big_node *b_node)
 {
-
 	struct maple_subtree_state mast;
 	int height = 0;
 	unsigned char mid_split, split = 0;
@@ -3890,7 +3887,7 @@ static inline void *mtree_lookup_walk(struct ma_state *mas)
 			goto dead_node;
 	} while (!ma_is_leaf(type));
 
-	return (void *) next;
+	return (void *)next;
 
 dead_node:
 	mas_reset(mas);
@@ -4708,7 +4705,6 @@ static inline void *mas_next_nentry(struct ma_state *mas,
 
 static inline void mas_rewalk(struct ma_state *mas, unsigned long index)
 {
-
 retry:
 	mas_set(mas, index);
 	mas_state_walk(mas);
@@ -4716,7 +4712,6 @@ static inline void mas_rewalk(struct ma_state *mas, unsigned long index)
 		goto retry;
 
 	return;
-
 }
 
 /*
@@ -5618,7 +5613,6 @@ static void mas_wr_store_setup(struct ma_wr_state *wr_mas)
 				mas_reset(wr_mas->mas);
 		}
 	}
-
 }
 
 /* Interface */
-- 
2.34.1

