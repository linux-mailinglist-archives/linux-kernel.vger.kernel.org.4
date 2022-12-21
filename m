Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A98A652C9F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 07:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbiLUGBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 01:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbiLUGBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 01:01:31 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DAFA451
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 22:01:29 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id s196so9765683pgs.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 22:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HuceivYszxi1dsfcy+qfUy+FliXIAedgU34LI+yN1BM=;
        b=aGtdxygNXyEXuRO3SRKTDU0SZ1mamJ3u2QLuOlZJU9ZbDar1Whyk3PK667jGVxmijC
         Bk8F6SC8m75KaEJ5ydRynN4bUNA/UMcZ80AVvMenXVzBDgPLYIjrqoNiivTxpTbgz/vn
         8bdhOgfTr11AiPiCwW6CfsdW5VLxa4994y1i+hwomVHEvoJedGcXi9ecdhEdc65GgF+g
         PNe1cPzOc87xidWqyQvv+kpEDNeoDTwTA5Vxbrd5YKI1d7QBy6SDupLRlpw5kgTZyD8h
         0euRLBHTIqmDxHdluH23+8Q+cxl82qABHBU3s+y3dlp0icpcHkIbZv+Gu/KYh0An1Lx8
         syHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HuceivYszxi1dsfcy+qfUy+FliXIAedgU34LI+yN1BM=;
        b=fV/S3O8VG2Iw8IDVbMvjzASAt3f3K0ZGZPUP0Q8q0TuReS45uAZAWGfBQsrPVAbPJt
         K0kzzqMhHhOtNRJmVPMzG79yuA4Zqu4Ryej61voV5SW7Cy3kN0NwZc53HXbRP2Se1CRq
         qnucz1UkZvG2RIsVGnR5Mp4SMtrFvQDyx3mR2jser6BUYIswkKviKksTvyY7i1FYccfd
         GlpZ26a4u334Cwz1vi0NIKwrpMQuqE1Rq5ZQnKrmhz+sU+psKe4aUPw48avhNoIsLVz7
         74xR7LqZHOsGOmT1qwgpdntmfYkUVOX/NtpC4JSll+i5gdfDR7cGC4PUNN1VtLnsVMmr
         7M8A==
X-Gm-Message-State: AFqh2koZQncU7fRmSP0YcmARmIkqNk47c/jKOMvVxfXYPGzg6nHJjXFN
        eTEVpDUD5b5xpq30CwpZXwI=
X-Google-Smtp-Source: AMrXdXvS3Z6kpgiVXNdjEzMajBtalFI1ekmEFXKRKgxnGDl9CSYVxZCL/XtEfH5QaXRGMQLgHYra2w==
X-Received: by 2002:a05:6a00:3027:b0:577:8d87:d8f4 with SMTP id ay39-20020a056a00302700b005778d87d8f4mr1064981pfb.34.1671602489177;
        Tue, 20 Dec 2022 22:01:29 -0800 (PST)
Received: from vernon-pc.. ([114.231.52.81])
        by smtp.gmail.com with ESMTPSA id w7-20020a626207000000b00562677968aesm9598886pfb.72.2022.12.20.22.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 22:01:28 -0800 (PST)
From:   Vernon Yang <vernon2gm@gmail.com>
To:     Liam.Howlett@oracle.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>
Subject: [PATCH v2 2/7] maple_tree: remove extra return statement
Date:   Wed, 21 Dec 2022 14:00:53 +0800
Message-Id: <20221221060058.609003-3-vernon2gm@gmail.com>
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

For functions with a return type of void, it is unnecessary to
add a reurn statement at the end of the function, so drop it.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Vernon Yang <vernon2gm@gmail.com>
---
 lib/maple_tree.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 8ace65a5eea5..34aa93c85d6e 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1276,7 +1276,6 @@ static inline void mas_alloc_nodes(struct ma_state *mas, gfp_t gfp)
 	if (mas->alloc && !(((unsigned long)mas->alloc & 0x1)))
 		mas->alloc->total = success;
 	mas_set_err(mas, -ENOMEM);
-	return;
 }
 
 /*
@@ -4710,8 +4709,6 @@ static inline void mas_rewalk(struct ma_state *mas, unsigned long index)
 	mas_state_walk(mas);
 	if (mas_is_start(mas))
 		goto retry;
-
-	return;
 }
 
 /*
-- 
2.34.1

