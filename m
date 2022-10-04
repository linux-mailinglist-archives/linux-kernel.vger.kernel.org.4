Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917B15F3E78
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiJDIhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiJDIhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:37:21 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B67337F85;
        Tue,  4 Oct 2022 01:37:20 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x59so7871300ede.7;
        Tue, 04 Oct 2022 01:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=kShu3JiHXeOC6qlCggCXPdZVbnNPqXavY4BcrnK5Xm4=;
        b=IB39GjvKSpw8yqo7YB/mEkBVWTY3fslQk1Pr3I9rSGi3MTuep5N992Nuo/RDn8cQhw
         kOFr+GMG7/tOszPtpOvRF7TZvul0ACRc20XmqAqhp8a100tZ+Am9zvuVs7XholdFvMDB
         YAqYbghk+ZcAkIWWJvZ5ksCCJ4KnRYSPwP3cJFjLXkm+iEkjZWjxkb4qknzBZjByflpv
         m4OwglJgaocdKWdr9SmnDVxJTFI5j9+Y8ngyM4NvGuJDXaD5w09eou3VUUXQ7QYVBTLt
         GjxY6XWX4OMf3p4GEU+X2ZO1QLULkXCjID8MmyDBsgMA36tb/2ly5Ga3EYmXGQ2m+ZOs
         X6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=kShu3JiHXeOC6qlCggCXPdZVbnNPqXavY4BcrnK5Xm4=;
        b=lv+d5yVyUhRLj+Kh/J9vyAhmhNhvMzs8GDX7UHlz1nKX1G0/9+9dQcoNzewlC4MLu2
         0xaQTq8Lsbrdt2XU++ZSDBr1wKqy2tnvbPHUG5qFrKRKKWoSh4cwS+wyjXF9hfCJHwlj
         qT0bGWsPRxIGnNR2i7B24hrXQTP08Kd6eBwmr8HSsdcvg8xUP0bm+TkHY6qMUfU/yggO
         t5LHIZO3zlRUm8pDlMbBysSOUdWmADzI4MLa37ACl7gDobc336BvYF8ba2gDVzQk+mCG
         1bxKv2Y/46El+AfCUsyXiSdbKxtTmEoxh2ho+vHiPl69Q65LU26OPUKAMJd71bdY3sgW
         GL/Q==
X-Gm-Message-State: ACrzQf0zxYhrPkm3LzkqvogP5dNU0x5bsVsdwmqBNNrgSz1bw8dJ2KtY
        08mMFAkaXqRc7hv32D5TaSU=
X-Google-Smtp-Source: AMsMyM6YLvR1ANtP1eIM53wbtO7p9Dy69ONkLPyiAfdkULPu9rbPRWjvRaO++DfvlF2nnUicUF6C7w==
X-Received: by 2002:a05:6402:33c5:b0:447:e4a3:c930 with SMTP id a5-20020a05640233c500b00447e4a3c930mr22278878edc.401.1664872638877;
        Tue, 04 Oct 2022 01:37:18 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id kv20-20020a17090778d400b00787a6adabe9sm6598376ejc.75.2022.10.04.01.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 01:37:18 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     ansuelsmth@gmail.com, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 1/2] mtd: core: simplify (a bit) code find partition-matching dynamic OF node
Date:   Tue,  4 Oct 2022 10:37:09 +0200
Message-Id: <20221004083710.27704-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

1. Don't hardcode "partition-" string twice
2. Use simpler logic & use ->name to avoid of_property_read_string()
3. Use mtd_get_of_node() helper

Cc: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/mtd/mtdcore.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 18aa54460d36..2211e0ed6cc9 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -551,18 +551,16 @@ static void mtd_check_of_node(struct mtd_info *mtd)
 	struct device_node *partitions, *parent_dn, *mtd_dn = NULL;
 	const char *pname, *prefix = "partition-";
 	int plen, mtd_name_len, offset, prefix_len;
-	struct mtd_info *parent;
 	bool found = false;
 
 	/* Check if MTD already has a device node */
-	if (dev_of_node(&mtd->dev))
+	if (mtd_get_of_node(mtd))
 		return;
 
 	/* Check if a partitions node exist */
 	if (!mtd_is_partition(mtd))
 		return;
-	parent = mtd->parent;
-	parent_dn = dev_of_node(&parent->dev);
+	parent_dn = mtd_get_of_node(mtd->parent);
 	if (!parent_dn)
 		return;
 
@@ -575,15 +573,15 @@ static void mtd_check_of_node(struct mtd_info *mtd)
 
 	/* Search if a partition is defined with the same name */
 	for_each_child_of_node(partitions, mtd_dn) {
-		offset = 0;
-
 		/* Skip partition with no/wrong prefix */
-		if (!of_node_name_prefix(mtd_dn, "partition-"))
+		if (!of_node_name_prefix(mtd_dn, prefix))
 			continue;
 
 		/* Label have priority. Check that first */
-		if (of_property_read_string(mtd_dn, "label", &pname)) {
-			of_property_read_string(mtd_dn, "name", &pname);
+		if (!of_property_read_string(mtd_dn, "label", &pname)) {
+			offset = 0;
+		} else {
+			pname = mtd_dn->name;
 			offset = prefix_len;
 		}
 
-- 
2.34.1

