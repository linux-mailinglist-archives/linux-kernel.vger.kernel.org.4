Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD8A64B35B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 11:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbiLMKkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 05:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbiLMKkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 05:40:09 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0785F1C13B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 02:40:08 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id d20so17143604edn.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 02:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b6QgqvSEkJ40dC/g0yqPFcNIxsg/4vW/2+57F7Oid/Y=;
        b=qyPBF6YT9Xn248ZrdPXuPB1iYqmrQJq5As9iv++aogWesOtLuRL0RJxgJ51zJIq70c
         Be1kuM//pctf3XqUOIwyqWA7kgpvZ75wLYt9drvmXnNg7ejpUpCJkVwO2GixxAulv+YM
         at68rTBLfCdLzdLX9S+UaBiotychJ2ZMJCqh85ymo4HuFjdsWOzKhu3or5N1NuIN2JPo
         dYFkT+5ioC212i5Jlqv3TtNNmnXO7T/xZJgWx7XV6Q2RzHqDhkqN1/NV7LEQ+lMqzsCH
         E+U1pYd7EGoiju+dQQGtNF3dnmwk02ceOKqkdYLdYTrPe+EgH+CnGnuCYnmahsbqkLNO
         RcVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b6QgqvSEkJ40dC/g0yqPFcNIxsg/4vW/2+57F7Oid/Y=;
        b=zOQymSRcr58HDw1KvEUpISJeiPokdVWjvswYApfc4pDLl3OiuJr5VupOR/rLnUyqTr
         0sF0JxY5WzJ3sWO1gZtTESSXeWstACTuTOPFImY26ERb/y2U+Hp/Zv1L7EUqt600elBV
         E0XVjabmyVV20ooRtCzB0Dv57ib3QaWUd1IuJ4HdjA/FTcrpOwOHp0az0vFls7s+Pro9
         se4o91MmaKkfkLuJ5QdskF4eByg4z44s7SkZYteVntjc+KPtbX81alfUbfMQABE3jSym
         tdxRTH0H70ApQIkM433epJ8BUhO9mnftC/8NCnOKKviwwVLORGK/Yn2SDI2hsBt9OdX3
         hq4g==
X-Gm-Message-State: ANoB5plqyYF7NPnjfhnhhhu4dUexhQHQ7RR/14KMtUO72SD/ZqPOF6Dk
        byy2KXqdZlvi+eUP4fxcTUydXt6v9L0Erk8DsGU=
X-Google-Smtp-Source: AA0mqf6wCLpjfemS8Nj3roe5a42WEA4O81RCNzxHkA5WO3DoNDPwBN4uF8wG4Mqpmjmvn5gw7dERye6LIGNcpehrgmk=
X-Received: by 2002:aa7:d841:0:b0:46d:692e:8572 with SMTP id
 f1-20020aa7d841000000b0046d692e8572mr7011724eds.25.1670928006558; Tue, 13 Dec
 2022 02:40:06 -0800 (PST)
MIME-Version: 1.0
References: <Y5hTTGf/RA2kpqOF@debian>
In-Reply-To: <Y5hTTGf/RA2kpqOF@debian>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Tue, 13 Dec 2022 10:39:30 +0000
Message-ID: <CADVatmM4Xr7gKqkeNX90KjmhB-E6H8rSfsK_E+42wp8OmALbDw@mail.gmail.com>
Subject: Re: mainline build failure due to e240e53ae0ab ("mm, slub: add CONFIG_SLUB_TINY")
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>
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

On Tue, 13 Dec 2022 at 10:26, Sudip Mukherjee (Codethink)
<sudipm.mukherjee@gmail.com> wrote:
>
> Hi All,
>
> The latest mainline kernel branch fails to build xtensa allmodconfig
> with gcc-11 with the error:

And, also powerpc allmodconfig with the error:

fs/f2fs/inline.c: In function 'f2fs_move_inline_dirents':
./include/linux/fortify-string.h:59:33: error: '__builtin_memset'
pointer overflow between offset [28, 898293814] and size [-898293787,
-1] [-Werror=array-bounds]
   59 | #define __underlying_memset     __builtin_memset
      |                                 ^
./include/linux/fortify-string.h:337:9: note: in expansion of macro
'__underlying_memset'
  337 |         __underlying_memset(p, c, __fortify_size);
         \
      |         ^~~~~~~~~~~~~~~~~~~
./include/linux/fortify-string.h:345:25: note: in expansion of macro
'__fortify_memset_chk'
  345 | #define memset(p, c, s) __fortify_memset_chk(p, c, s,
         \
      |                         ^~~~~~~~~~~~~~~~~~~~
fs/f2fs/inline.c:430:9: note: in expansion of macro 'memset'
  430 |         memset(dst.bitmap + src.nr_bitmap, 0, dst.nr_bitmap -
src.nr_bitmap);
      |         ^~~~~~

Note: the powerpc failure is also with gcc-11 only. gcc-12 builds fine.


-- 
Regards
Sudip
