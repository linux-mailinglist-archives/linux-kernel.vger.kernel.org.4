Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD3365227D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbiLTO02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbiLTO0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:26:18 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0565186FF
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:26:15 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so16630808pjr.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wmaEWyMbq+SYIJlOtMV18tUNIDRg/JjfkI+PyxC7ahM=;
        b=q0iadfazHe1+IYlSrbvINbM/UqFTgpwMPAdYMg32CpBaw23LmNYrPTOY4q24Ypc8BO
         x83WeHv7BpZvpAmNG8UykDNwB7N1eHH0tU3vsW0dEGp6OmT1NOA8BAbXLMEQ388m75ac
         WsSGbG6EDSGTKTTGNZDkrLXn5rrnQ58zKNbTX7sWPrDzi7atbtOJhzB+ARshj9xXLXPk
         QNXqyyG3AXW5kgkU67oKqg6BJ5fqKrbiCd85rt7EVI+0eJzXhAz41Tr21OImahokj+LU
         jWbk/Rfk6UMs/AN6wEGMVQeo168rC3lMGyPpqVozdC7jaaoEyxO/Ea5buZokqqg4VCHP
         drkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wmaEWyMbq+SYIJlOtMV18tUNIDRg/JjfkI+PyxC7ahM=;
        b=VjofOSVvZxusZwBj2rRWDpubQ4k3pZqT9zaK+ONtDEv2QP9cH1ZaUIBHuJJb8WgTJM
         na3qvdekdJNcYput0cC4O0y1pW+H8/NaMeM4QUbO/7atsiCpBIOHovuut6akveAAo9TI
         IUEMwoTfwO99gT3TLcEdRzc1KBWmllhtZZZF0WCCdK7CPwbJgVNGag+3tFPkR6sWOVpv
         07GIrOIZJk1MaHzdejq/LW+IfgEhrevhkk6TucY1rnzTZvKXFhUliEyw38p5E/ZPD4WX
         knNkM76aeMjuRzqzTcwgAKrTXdMYWYnn3DHq1e/Z4CxbSSaKZPb6NFaBPdA1+qiaP9YO
         n1PQ==
X-Gm-Message-State: AFqh2kp6jegOnOafVneTKdCTEUbdpOH7RJoF40129Gc5lVrZjBDd+Ugz
        522bI8FIWimGZf9Y14hIt3jF6FzwlN04KWjpYG0=
X-Google-Smtp-Source: AMrXdXvoD+iGmReeb5JKab243eLrMYXIN99GpTYIiexm5QnyOVU5OGfi0zTUQfU5m4nD77zHZ1ufmg==
X-Received: by 2002:a17:902:e549:b0:191:3993:801e with SMTP id n9-20020a170902e54900b001913993801emr2473900plf.56.1671546375405;
        Tue, 20 Dec 2022 06:26:15 -0800 (PST)
Received: from vernon-pc.. ([114.231.52.81])
        by smtp.gmail.com with ESMTPSA id ik11-20020a170902ab0b00b001897bfc9800sm9383398plb.53.2022.12.20.06.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 06:26:14 -0800 (PST)
From:   Vernon Yang <vernon2gm@gmail.com>
To:     Liam.Howlett@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vernon Yang <vernon2gm@gmail.com>
Subject: [PATCH 1/8] maple_tree: remove extra space and blank line
Date:   Tue, 20 Dec 2022 22:25:59 +0800
Message-Id: <20221220142606.1698836-2-vernon2gm@gmail.com>
X-Mailer: git-send-email 2.34.1
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

