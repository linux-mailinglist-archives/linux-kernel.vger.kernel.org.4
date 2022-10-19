Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC284604FBC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 20:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbiJSSfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 14:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiJSSf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 14:35:27 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FF0171CDF
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:35:16 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id a5so11302525qkl.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 11:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACgkRQxyXnmQDF+sB8DMoTPhEE8CQwyDBe0OxQ0a5d4=;
        b=FLO928z4698khsXbYP99gJcn+4iPcsJIclC9tz/Dw2W/uIVAHAD1hOh6mPRerryV+p
         P2WRw2QK9W5faPHikFR/BFSjGtfm4xAOZWQ3lEw96QDTqiOSqmtDaE4eEycyR/L07Efo
         B4qMykGytnfksjO2xaIhSTJoUCdYaF7eAHb7QlJ5OZJScEzHUsuvvrfprtX07+Bc2EPQ
         U78LZrRQm/s7lFZqq38q21Jmd84ziz56cTiFWffsHJCXdENbFLXW2rkpvsbSsS499Ckv
         IxaasZY6Z5h61F9VoXSQwhCm8+1qWMZ5kHTeUlSioITmU0W00GgZ4xU7DwP6PQ7z+rG/
         Ns5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ACgkRQxyXnmQDF+sB8DMoTPhEE8CQwyDBe0OxQ0a5d4=;
        b=uBSae1VtNEj4g0swxlCtNdtHuooW1gXRgk91dV2KKjlvGGbPnGI+Wu+GMxh0cUgQNU
         1ZC5a3f7bSV7ldTs0yfk0t9OZ5hgVlNAYKW6qAcSrDLey3b4woGWTW0iJj93Bw87aAN4
         eKZSS8b+Pua0T54+XU29JBbVkpJcV3ZiZ+srUw6ysIZjUQGS/gUwT07eh/7JqbQWtWtR
         R5H30zPoqcKxHfA6QyzYMNmL1MYCu1o9IjBPii/lzI0Q1jq73keVQW+Y3sSR01AFCrtB
         g3m9YEjBn755p5gMJ10WC/Kcy+AeBds2nG/M941wv7wS+PCIus+lUDvL6ooPTXW2c+fW
         f+QQ==
X-Gm-Message-State: ACrzQf0Z6/0JLmrXVfngZWg4mTPrFC5GN0lLKxNoGb4Iw/Bb/sIo5ARQ
        1RHx19SGghQnkaiIaqBh5ppMeC9HsQYn9g==
X-Google-Smtp-Source: AMsMyM6FliwLvDxbi3XkcpDsvL39EYrzBIQrMnqx237RxV7Qw9xLuaDhIOjoswwXGkiSHjaBoOsIjQ==
X-Received: by 2002:a05:620a:4487:b0:6ee:bcfd:bd38 with SMTP id x7-20020a05620a448700b006eebcfdbd38mr6505111qkp.468.1666204514686;
        Wed, 19 Oct 2022 11:35:14 -0700 (PDT)
Received: from sophie ([143.244.47.100])
        by smtp.gmail.com with ESMTPSA id x27-20020a05620a0b5b00b006ecdfcf9d81sm5286189qkg.84.2022.10.19.11.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 11:35:14 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v3 5/5] memblock tests: remove completed TODO item
Date:   Wed, 19 Oct 2022 13:34:12 -0500
Message-Id: <1edc87f3605af4668f7d842c30425259203714d8.1666203644.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1666203642.git.remckee0@gmail.com>
References: <cover.1666203642.git.remckee0@gmail.com>
MIME-Version: 1.0
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

Remove completed item from TODO list.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/TODO | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/testing/memblock/TODO b/tools/testing/memblock/TODO
index 33044c634ea7..cb7fac47a643 100644
--- a/tools/testing/memblock/TODO
+++ b/tools/testing/memblock/TODO
@@ -8,10 +8,5 @@ TODO
                 likely that the current MEM_SIZE won't be enough for these
                 test cases. Use realloc to adjust the size accordingly.
 
-2. Add test cases using this functions (implement them for both directions):
-   + memblock_alloc_raw()
-   + memblock_alloc_exact_nid_raw()
-   + memblock_alloc_try_nid_raw()
-
-3. Add tests for memblock_alloc_node() to check if the correct NUMA node is set
+2. Add tests for memblock_alloc_node() to check if the correct NUMA node is set
    for the new region
-- 
2.25.1

