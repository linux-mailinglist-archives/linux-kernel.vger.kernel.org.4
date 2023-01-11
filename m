Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAF1665D20
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjAKNy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238770AbjAKNyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:54:02 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60853E0E5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:53:58 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 141so10592437pgc.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+fAG7U9M59m9Mb4ZykFnz74kqztm1/k7/WyzvUXSzdY=;
        b=LcDIkeDo1tArU/8EqZnunU3/ul/Zic5H5jDl5cA9InhTDvk9iodYF2JmEoKGbMmDi0
         V+ZszmlSFWgcYZx7oZYFGmOwnQVbnbylua3nX9noUkgKOFitoXy+PHVBMDH2JlkxveUY
         JjgHLnDdRng2kNfowFVpN+wpO3WHvUmXn6NcjRg/RsA4KoRzJCkkAPwAb1TQbnLTntNi
         HryPbKMhDeGwDLNNotSKBrNfErsFshluY0OjmcTthMXOo9TBFhh2NMe33juueYs+Y4K0
         LpZWp8ZJar4S5nD+zsXeZgzZDhSv2AWBq11vKVLSg7992wOKP6Tm+w0/KgYCryuXUa6U
         V9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+fAG7U9M59m9Mb4ZykFnz74kqztm1/k7/WyzvUXSzdY=;
        b=b9I87CcyPkqF/pG+blHF5ZbQSvUuM/SkniboGop+uG41E8zHKAVWbiql5X9IdMDXH/
         nj7RtwgLikanYssUHMmesF6AiFwemhWN+yYDaTyQbs0CU/9xLNWjuIjNkMJOJSXlYnjb
         SKer+yUSe/I7SALpFAim1QVRxf5Epp84CwE0iPlfMmeqw9PWBRC0MoHCdiCSLLc0XaZS
         jNsIZqYgp0vJRnHQHULcXb3FFERQAEGXFaWExh+4PocR4GDXKaf/ainQgbx/zDEl0xxn
         I9XrHXAhEjOL5N7fLah9pHZvl9F9pUqgKG/ko+iNHr0+o5E5FE1l6fBPw1lzgxdu+fmO
         9QAA==
X-Gm-Message-State: AFqh2krVg+x1kidAh0/KL+0xO3k7mRk21VR5JZfmX7jRGE9pO+tKgOu5
        MGC9iBOqo5DvGNPbPtxOt5g=
X-Google-Smtp-Source: AMrXdXuUbLvvUXI8f/6iy/JxKz0eduGfNeyHa4kTyvRwhJD3kgycntZbGVTcixARpHtAE3jZlJH4iQ==
X-Received: by 2002:a05:6a00:2997:b0:582:1f25:5b8 with SMTP id cj23-20020a056a00299700b005821f2505b8mr41513164pfb.19.1673445237833;
        Wed, 11 Jan 2023 05:53:57 -0800 (PST)
Received: from vernon-pc.. ([49.67.3.29])
        by smtp.gmail.com with ESMTPSA id x14-20020aa79a4e000000b005811c421e6csm9880856pfj.162.2023.01.11.05.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 05:53:56 -0800 (PST)
From:   Vernon Yang <vernon2gm@gmail.com>
To:     Liam.Howlett@oracle.com, willy@infradead.org,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vernon Yang <vernon2gm@gmail.com>
Subject: [PATCH v2] maple_tree: fix comment of mte_destroy_walk
Date:   Wed, 11 Jan 2023 21:53:48 +0800
Message-Id: <20230111135348.803181-1-vernon2gm@gmail.com>
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

The parameter name of maple tree is mt, make the comment to be mt
instead of mn, and the separator between the parameter name and
the description to be : instead of -.

Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Vernon Yang <vernon2gm@gmail.com>
---

Changes since v1:
 - fix the separator between the parameter name and
   the description to be : instead of -.

v1: https://lore.kernel.org/linux-mm/20230110152216.1712120-1-vernon2gm@gmail.com/

 lib/maple_tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 26e2045d3cda..3f5005261618 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5590,8 +5590,8 @@ static void mt_destroy_walk(struct maple_enode *enode, unsigned char ma_flags,

 /*
  * mte_destroy_walk() - Free a tree or sub-tree.
- * @enode - the encoded maple node (maple_enode) to start
- * @mn - the tree to free - needed for node types.
+ * @enode: the encoded maple node (maple_enode) to start
+ * @mt: the tree to free - needed for node types.
  *
  * Must hold the write lock.
  */
--
2.34.1

