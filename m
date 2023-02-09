Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F0F691328
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 23:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjBIWVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 17:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjBIWVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 17:21:20 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EE828D11
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 14:21:19 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id ay1so2316071pfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 14:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1675981279;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=INi0TWgkRSLsbjVpaGDFPzQPHb0f2T5aCT1XYe2Z1mU=;
        b=l4GZzGUs4iwqALdBT1nng7ENnjNApXxSAe7gFo1wDjZK3CcEQQcytBT9RjV2hS487J
         iLPWhCoHgGEwQ8Wje5CuUSKm0tRu/xLa6b1uAA0iiFeu6IK23bgbd+r/OuUKS2LAIqYa
         SNGXZOSY7oOVcbMnKbQp/w5Wyj/HNjknqAvH4NSZTIHKI9hPIolVLsQd1fo6uv+q5WXx
         kswiqJbS5b7DMaMuCjSNEXpimzFuTqAnupW5XqyXM8wTzLddX4s9GCxl4URWvw3NJeg0
         UmWimymTrp0fISsOyI8YqeWTJRnGT7a4gYp93ChcRjGnyCPsNeMe+jUBmUr/H7LtcBWO
         EZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1675981279;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=INi0TWgkRSLsbjVpaGDFPzQPHb0f2T5aCT1XYe2Z1mU=;
        b=f3oNiiFIliRVa4n6/QiqEna+7TjLYo/OWXDM3a9nty2jEVqQtfRbLkRfSRrolFGoEe
         +o3G4glPURHV+Wu2Oix5MYJYFZwnUvREV5GC5TouAgr6oF+npEp41OBJaaJD3Rtisv0v
         VGeZ6KE3DUCHGXj5smvcJoKc0foYMWZ3oMpg4xGbMbgq4BmtkntA2+pQJgCMX4xotxqc
         cGCJ31zALyZCGrjic/NUUCbtlnVKJUXIyhQoBd2uv24sfZ4MYe1cznD2wqdBhESo3mZD
         X4C6TAWz6SFj34NqXKA6uPKeZP0g7BzvNE1BQ//bYjXWu2F+ug5FARY+ckWGKVPkj+qE
         6rgw==
X-Gm-Message-State: AO0yUKWbfdn3H7wa7e9c6l6N1yZ0c8uq06KaDtDwds5hBJr9kD7MAlYu
        eXX6NqB7J9ofgGPgMWbMcis7HvZQCVnAHJLls5U=
X-Google-Smtp-Source: AK7set9Zb2XVF3aLUAZ2wGf+htOd4S/StdXwXwM0398AxxTqrXUBKz8Os/qa2ZXd2z6eHputQ1wQdGbcxaIXQ36SsBY=
X-Received: by 2002:a62:79cf:0:b0:593:b73e:49af with SMTP id
 u198-20020a6279cf000000b00593b73e49afmr2777705pfc.24.1675981279155; Thu, 09
 Feb 2023 14:21:19 -0800 (PST)
MIME-Version: 1.0
References: <20230201071312.2224452-1-arnd@kernel.org>
In-Reply-To: <20230201071312.2224452-1-arnd@kernel.org>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 9 Feb 2023 23:21:08 +0100
Message-ID: <CA+fCnZfKAF3AF+m0_Jpv8Di3G7ZOLe5-TBXuLiASCC7y1Onjsg@mail.gmail.com>
Subject: Re: [PATCH] kasan: use %zd format for printing size_t
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marco Elver <elver@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 1, 2023 at 8:13 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The size_t type depends on the architecture, so %lu does not work
> on most 32-bit ones:
>
> In file included from include/kunit/assert.h:13,
>                  from include/kunit/test.h:12,
>                  from mm/kasan/report.c:12:
> mm/kasan/report.c: In function 'describe_object_addr':
> include/linux/kern_levels.h:5:25: error: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
> mm/kasan/report.c:270:9: note: in expansion of macro 'pr_err'
>   270 |         pr_err("The buggy address is located %d bytes %s of\n"
>       |         ^~~~~~
>
> Fixes: 0e301731f558 ("kasan: infer allocation size by scanning metadata")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  mm/kasan/report.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index e0492124e90a..89078f912827 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -268,7 +268,7 @@ static void describe_object_addr(const void *addr, struct kasan_report_info *inf
>         }
>
>         pr_err("The buggy address is located %d bytes %s of\n"
> -              " %s%lu-byte region [%px, %px)\n",
> +              " %s%zu-byte region [%px, %px)\n",
>                rel_bytes, rel_type, region_state, info->alloc_size,
>                (void *)object_addr, (void *)(object_addr + info->alloc_size));
>  }
> --
> 2.39.0
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thanks!
