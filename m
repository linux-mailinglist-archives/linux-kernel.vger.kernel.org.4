Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA44749D62
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjGFNXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGFNXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:23:48 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B671996;
        Thu,  6 Jul 2023 06:23:46 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-992dcae74e0so86525466b.3;
        Thu, 06 Jul 2023 06:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688649825; x=1691241825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KXOwe/OoiOsg3u6jeXshSKZbJW8vs60/BO9XDGBs3Y=;
        b=jY0NxM1fOsvqjqWcv8woY/9bHhNdhAj4dl2++BNcG5i7ocYXmRGvyPZwCMgzdOtv7R
         Cio8rSxIVPC/CJe8aMvoozBaNyWxXWh4esvng3yb5GD5DQfskWdra+UcZrxOvd4K0Dhx
         BMxw9tMQFf/YdE5CpZifgUr81pUEyjW5+rYfn503xzcMvxO56x7awEIczgPBq2beWWRB
         bUPQrklEpLUPnuM4qurvS9axsQq/GDKyh0v1fka3eSK1F6hPDXcy7EjzpBrAa2sPcfT5
         e0RTd0TDoTzR2zEydWF4HwqBtltWICv7h1E3j2GBpGToOerboTptctEzhLtC6hJCiek/
         swjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688649825; x=1691241825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8KXOwe/OoiOsg3u6jeXshSKZbJW8vs60/BO9XDGBs3Y=;
        b=RxjU00sYf1BEgkJF21eN+4dAJdEqh9/eNo5wB+U2KZ76+6q9vD0liGzty/uQaaw4Al
         15EhXwEN7/12jy/CU+Oy8XXAM+vLc03e+uI+ANkL33TGlo4hOtNcYzp1jnnFQxvsY5Xz
         28+K5/xajYWKtvrtZ3DBm9YbIhGTlZiQKPFSE3q7rn8YhQiIRH70kZJfU5Bnq6scX4L8
         W2H8IT/bIl62khqRV42TfESCNIRwQ9vynj/1QfaLkSgEl5TkuohHvA+JsBWKSP0fwDji
         7rhe1e+IhyCmhJ3Pm8w6ZfFoxIaoBwpho7hns3wboS3VnCOMhcMWRTTKC9DWlCyVndpB
         +Ohw==
X-Gm-Message-State: ABy/qLbhiykYl3L2QoFejoLnI/DebmMzdJE/lXnXd3DeQ0KAo4J9AsO4
        SxN9V8FSQyR/DvNFLLGO3UyxgC7fn9MGjO+9
X-Google-Smtp-Source: APBJJlGI7creXc4Ga4EfBmjJ6RQ4w4zxDFSml/GbNcxZd2+jyZ2HidG77CKc8cf4T57PN7IqTu3PGg==
X-Received: by 2002:a17:906:74da:b0:988:6491:98e3 with SMTP id z26-20020a17090674da00b00988649198e3mr1380778ejl.68.1688649824631;
        Thu, 06 Jul 2023 06:23:44 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-008-088-179.77.8.pool.telefonica.de. [77.8.88.179])
        by smtp.gmail.com with ESMTPSA id r2-20020a170906364200b00988dbbd1f7esm808024ejb.213.2023.07.06.06.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:23:44 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 02/20] selinux: avtab: avoid implicit conversions
Date:   Thu,  6 Jul 2023 15:23:17 +0200
Message-Id: <20230706132337.15924-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230706132337.15924-1-cgzones@googlemail.com>
References: <20230706132337.15924-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return u32 from avtab_hash() instead of int, since the hashing is done
on u32 and the result is used as an index on the hash array.

Use the type of the limit in for loops.

Avoid signed to unsigned conversion of multiplication result in
avtab_hash_eval().

Use unsigned loop iterator for index operations, to avoid sign
extension.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/avtab.c | 38 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 6766edc0fe68..fbf51986afcf 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -29,7 +29,7 @@ static struct kmem_cache *avtab_xperms_cachep __ro_after_init;
 /* Based on MurmurHash3, written by Austin Appleby and placed in the
  * public domain.
  */
-static inline int avtab_hash(const struct avtab_key *keyp, u32 mask)
+static inline u32 avtab_hash(const struct avtab_key *keyp, u32 mask)
 {
 	static const u32 c1 = 0xcc9e2d51;
 	static const u32 c2 = 0x1b873593;
@@ -66,7 +66,7 @@ static inline int avtab_hash(const struct avtab_key *keyp, u32 mask)
 }
 
 static struct avtab_node*
-avtab_insert_node(struct avtab *h, int hvalue,
+avtab_insert_node(struct avtab *h, u32 hvalue,
 		  struct avtab_node *prev,
 		  const struct avtab_key *key, const struct avtab_datum *datum)
 {
@@ -106,7 +106,7 @@ avtab_insert_node(struct avtab *h, int hvalue,
 static int avtab_insert(struct avtab *h, const struct avtab_key *key,
 			const struct avtab_datum *datum)
 {
-	int hvalue;
+	u32 hvalue;
 	struct avtab_node *prev, *cur, *newnode;
 	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
 
@@ -152,7 +152,7 @@ struct avtab_node *avtab_insert_nonunique(struct avtab *h,
 					  const struct avtab_key *key,
 					  const struct avtab_datum *datum)
 {
-	int hvalue;
+	u32 hvalue;
 	struct avtab_node *prev, *cur;
 	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
 
@@ -182,7 +182,7 @@ struct avtab_node *avtab_insert_nonunique(struct avtab *h,
 
 struct avtab_datum *avtab_search(struct avtab *h, const struct avtab_key *key)
 {
-	int hvalue;
+	u32 hvalue;
 	struct avtab_node *cur;
 	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
 
@@ -218,7 +218,7 @@ struct avtab_datum *avtab_search(struct avtab *h, const struct avtab_key *key)
 struct avtab_node *avtab_search_node(struct avtab *h,
 				     const struct avtab_key *key)
 {
-	int hvalue;
+	u32 hvalue;
 	struct avtab_node *cur;
 	u16 specified = key->specified & ~(AVTAB_ENABLED|AVTAB_ENABLED_OLD);
 
@@ -278,13 +278,12 @@ avtab_search_node_next(struct avtab_node *node, int specified)
 
 void avtab_destroy(struct avtab *h)
 {
-	int i;
 	struct avtab_node *cur, *temp;
 
 	if (!h)
 		return;
 
-	for (i = 0; i < h->nslot; i++) {
+	for (u32 i = 0; i < h->nslot; i++) {
 		cur = h->htable[i];
 		while (cur) {
 			temp = cur;
@@ -356,14 +355,14 @@ int avtab_alloc_dup(struct avtab *new, const struct avtab *orig)
 
 void avtab_hash_eval(struct avtab *h, const char *tag)
 {
-	int i, chain_len, slots_used, max_chain_len;
+	unsigned int chain_len, slots_used, max_chain_len;
 	unsigned long long chain2_len_sum;
 	struct avtab_node *cur;
 
 	slots_used = 0;
 	max_chain_len = 0;
 	chain2_len_sum = 0;
-	for (i = 0; i < h->nslot; i++) {
+	for (u32 i = 0; i < h->nslot; i++) {
 		cur = h->htable[i];
 		if (cur) {
 			slots_used++;
@@ -404,13 +403,13 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 {
 	__le16 buf16[4];
 	u16 enabled;
-	u32 items, items2, val, vers = pol->policyvers;
+	u32 items, items2, val;
 	struct avtab_key key;
 	struct avtab_datum datum;
 	struct avtab_extended_perms xperms;
 	__le32 buf32[ARRAY_SIZE(xperms.perms.p)];
-	int i, rc;
-	unsigned set;
+	int rc;
+	unsigned int set, vers = pol->policyvers;
 
 	memset(&key, 0, sizeof(struct avtab_key));
 	memset(&datum, 0, sizeof(struct avtab_datum));
@@ -470,7 +469,7 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 			return -EINVAL;
 		}
 
-		for (i = 0; i < ARRAY_SIZE(spec_order); i++) {
+		for (u32 i = 0; i < ARRAY_SIZE(spec_order); i++) {
 			if (val & spec_order[i]) {
 				key.specified = spec_order[i] | enabled;
 				datum.u.data = le32_to_cpu(buf32[items++]);
@@ -508,7 +507,7 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 	}
 
 	set = 0;
-	for (i = 0; i < ARRAY_SIZE(spec_order); i++) {
+	for (u32 i = 0; i < ARRAY_SIZE(spec_order); i++) {
 		if (key.specified & spec_order[i])
 			set++;
 	}
@@ -540,7 +539,7 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 			pr_err("SELinux: avtab: truncated entry\n");
 			return rc;
 		}
-		for (i = 0; i < ARRAY_SIZE(xperms.perms.p); i++)
+		for (u32 i = 0; i < ARRAY_SIZE(xperms.perms.p); i++)
 			xperms.perms.p[i] = le32_to_cpu(buf32[i]);
 		datum.u.xperms = &xperms;
 	} else {
@@ -569,7 +568,7 @@ int avtab_read(struct avtab *a, void *fp, struct policydb *pol)
 {
 	int rc;
 	__le32 buf[1];
-	u32 nel, i;
+	u32 nel;
 
 
 	rc = next_entry(buf, fp, sizeof(u32));
@@ -588,7 +587,7 @@ int avtab_read(struct avtab *a, void *fp, struct policydb *pol)
 	if (rc)
 		goto bad;
 
-	for (i = 0; i < nel; i++) {
+	for (u32 i = 0; i < nel; i++) {
 		rc = avtab_read_item(a, fp, pol, avtab_insertf, NULL);
 		if (rc) {
 			if (rc == -ENOMEM)
@@ -646,7 +645,6 @@ int avtab_write_item(struct policydb *p, const struct avtab_node *cur, void *fp)
 
 int avtab_write(struct policydb *p, struct avtab *a, void *fp)
 {
-	unsigned int i;
 	int rc = 0;
 	struct avtab_node *cur;
 	__le32 buf[1];
@@ -656,7 +654,7 @@ int avtab_write(struct policydb *p, struct avtab *a, void *fp)
 	if (rc)
 		return rc;
 
-	for (i = 0; i < a->nslot; i++) {
+	for (u32 i = 0; i < a->nslot; i++) {
 		for (cur = a->htable[i]; cur;
 		     cur = cur->next) {
 			rc = avtab_write_item(p, cur, fp);
-- 
2.40.1

