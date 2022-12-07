Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8726464AF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 00:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiLGXCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 18:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiLGXCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 18:02:02 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C666D7BC3F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 15:01:59 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id k88-20020a17090a4ce100b00219d0b857bcso3191821pjh.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 15:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ihy8jPmuCwZF2NUxckyF8mvKKJAfgGLMAeVZly3BYIQ=;
        b=aRW3STV7RblLr2UZyt0OTfxbCMJqzXcDNCvfPBFSL8j4JPwCmtZkBnAWT2aBKleJxM
         S3/S1x1bm1MpdH3mCRtHaNVJoA9agm3kV/DY2R4ALu1LaFoVxFx25litGpXvg0Pvv3gh
         uoVb7nRNI9Qsr8wEjAMXHbfKT2kJbq0+RJAy9yhPqI+XBxbk4puqiVriF0clbfnRW70s
         BoqZQTnhKW+xtH8CD1pB7fQKPmCtUiJwD+YIRriTaJAr7X6qPNEhR1gMWRbwuwhYFKuc
         8gjib0AzihFb9ybVk0MTROBvleagUuf+5ZDDM3BziLgRNQJLYQgKz7T7B91ISD3U5F+A
         JrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ihy8jPmuCwZF2NUxckyF8mvKKJAfgGLMAeVZly3BYIQ=;
        b=slKiGllHB9p9VdxnEVLoIuCJStdUXqqMJ2fc/hKTnsPmtN+dPm+nRxP9eaONc6XThW
         z8ZErqB7JRA8JPMnFT/5H869QxewsqlMCqDlRHpWEi0Bv7eu+9OuUmYufvv9q8o82pI0
         doL841qnCNcY3RG1tKffA1cQz1EKmCoMOguf6jbIA77C7xfif9uByUa93zuk92KhMnIU
         zFXU5tZ67Q/psBJOw/2AexDQbewAnjk9lTdDOXVfDks2GUbVLJ2ZyA/ybQ3/TL5v6qLV
         1Om3v0tBYLQrs06tCu4Y3WUEowK4PHeEhRiANAC4jMDzDcjtT/vf10n7QT5/b4xl3B0Q
         3zkw==
X-Gm-Message-State: ANoB5plMuiuDrFSUAwt93B+kLdRPac70tUjjyVpW2iQ2dFH3Pew6Hoqr
        4mZQqAYt+w0qymijOsnpeno=
X-Google-Smtp-Source: AA0mqf5OWOMX/v4jZwZzxW/+LnUXUxbUa7hAE7DKvC2Aq3cLs4HP8zm+Fl2Ofy4HrmxmV6JJeb1A1A==
X-Received: by 2002:a05:6a20:a028:b0:9d:efbe:52b2 with SMTP id p40-20020a056a20a02800b0009defbe52b2mr2023625pzj.34.1670454119220;
        Wed, 07 Dec 2022 15:01:59 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::2c6b])
        by smtp.googlemail.com with ESMTPSA id pc16-20020a17090b3b9000b00212cf2fe8c3sm5411033pjb.1.2022.12.07.15.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 15:01:58 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     damon@lists.linux.dev, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, sj@kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 2/3] mm/damon: Convert damon_pa_mark_accessed_or_deactivate() to use folios
Date:   Wed,  7 Dec 2022 15:01:51 -0800
Message-Id: <20221207230152.22938-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221207230152.22938-1-vishal.moola@gmail.com>
References: <20221207230152.22938-1-vishal.moola@gmail.com>
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

This change replaces 2 calls to compound_head() with one. This is in
preparation for the conversion of deactivate_page() to
folio_deactivate().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/damon/paddr.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index e1a4315c4be6..73548bc82297 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -238,15 +238,18 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 
 	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
 		struct page *page = damon_get_page(PHYS_PFN(addr));
+		struct folio *folio;
 
 		if (!page)
 			continue;
+		folio = page_folio(page);
+
 		if (mark_accessed)
-			mark_page_accessed(page);
+			folio_mark_accessed(folio);
 		else
-			deactivate_page(page);
-		put_page(page);
-		applied++;
+			deactivate_page(&folio->page);
+		folio_put(folio);
+		applied += folio_nr_pages(folio);
 	}
 	return applied * PAGE_SIZE;
 }
-- 
2.38.1

