Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB69664485
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 16:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238432AbjAJPXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 10:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbjAJPW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:22:58 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49E015726
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 07:22:57 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 36so8440926pgp.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 07:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WaQuPnZwXAWUOTqnnnLbIofVzJJAgGIsrKFXOI0f+T0=;
        b=LJ23lixYKBW24CDhyFXekLWKIQf+L527jx8RoSqGh5an+VcS30ohxNO2LG6GwJlldR
         eYXIOjcNH4ujS+8/8DZfl301X/m4IHwL0Dqf4qni59CqQnWHmo7GBHxXZEcSVv0Qj9gk
         XERzxQNjyiJLB4+Uc6c2Yk9t5NMJB62FWIvQz6omKE5tcnKz4qwS8Z7sJ3BiiVjiWLIj
         LwLXx4AE/+hQTcPwFvXxmRZecX7pnE4mGJK8PypwYg8PzF9K2vqyQbywT46juti5Oqnt
         swbDFOxSwQv4Dg7nh6krgQMHU2oifNlpVY/AumW9wFS0V+g/htF8mWYufAwLjKu/t+Ae
         CbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WaQuPnZwXAWUOTqnnnLbIofVzJJAgGIsrKFXOI0f+T0=;
        b=GentoJ7/eKVIXh45abjnJAtkL1f5FrBjQFGPL/cy2q33d5tADxUQp/s1h/g3CiQ0oj
         /pw0SyhD+dDKYov/muNosHqg+RerPB1ZAEkZ4Yal0mOwWH593jXB6fA5vBik073dt/NP
         5X25OMvWCZcZpTWC50E+QGiO4BkGVVTFsxJOvZaL0EHxZathMD3H8S8+alwDgOpwoQFU
         lGln60RaSSQKbZkv6mL/r4166fui4lGEmbHD1XbFVlPhZ83QJ8FIFveYp36skeno0xzn
         +6S6dHqFPBYxgdwyJ/qIt49+z5agd8i4gWqw9zHUP/QV2F5KUg0LBfuVyL05NX6SHRSy
         fdKQ==
X-Gm-Message-State: AFqh2koIY+TyIim3QVNkjpccACBF7s7TSxsz2MM0kIL2p8NlqGoOTpfL
        Gu0lTRV0bgKdIN1tQr64WCs=
X-Google-Smtp-Source: AMrXdXvDi9GX48Qoy6k+RdToi3pXWSfdn/j2AcK/s9irRhFS9c/ImfIQlOw3zmyAHjSkwE3IFL6eyQ==
X-Received: by 2002:a05:6a00:198c:b0:582:d44f:3948 with SMTP id d12-20020a056a00198c00b00582d44f3948mr24595692pfl.18.1673364177032;
        Tue, 10 Jan 2023 07:22:57 -0800 (PST)
Received: from vernon-pc.. ([49.67.3.29])
        by smtp.gmail.com with ESMTPSA id z19-20020aa79593000000b00582388bd80csm8253064pfj.83.2023.01.10.07.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 07:22:56 -0800 (PST)
From:   Vernon Yang <vernon2gm@gmail.com>
To:     Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        willy@infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vernon Yang <vernon2gm@gmail.com>
Subject: [PATCH] maple_tree: fix comment of mte_destroy_walk
Date:   Tue, 10 Jan 2023 23:22:16 +0800
Message-Id: <20230110152216.1712120-1-vernon2gm@gmail.com>
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

The parameter name of maple tree is mt, so make the comment to correct.

Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Vernon Yang <vernon2gm@gmail.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 26e2045d3cda..69be9d3db0c8 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5591,7 +5591,7 @@ static void mt_destroy_walk(struct maple_enode *enode, unsigned char ma_flags,
 /*
  * mte_destroy_walk() - Free a tree or sub-tree.
  * @enode - the encoded maple node (maple_enode) to start
- * @mn - the tree to free - needed for node types.
+ * @mt - the tree to free - needed for node types.
  *
  * Must hold the write lock.
  */
-- 
2.34.1

