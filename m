Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DE36CF25E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 20:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjC2Slh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 14:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjC2Slf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 14:41:35 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99544186
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 11:41:34 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso19497906pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 11:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680115294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxmuN5bOpF+xyVb1w+Z2846HXpRYFN7xoRDxUCB2yvc=;
        b=ABvWcdvFykAzXLyz/5y8SZIkZFb8EKVvkUCDhyuPtUpUZ3r4b/ameXoQzCbADS13ra
         Y988u17lGj1a8cpkZnTTwLs7rO7sy2PJIjHXGxsbOvk8qpK8KfPHwRbYK/dRQxXy4sqP
         dcsEzlTIhoqP+cBCV86poTOie+KuTuCcyfPc+KSVfgXRTluxbS3McJO/ybDZz2thhFy3
         7TJWUZcSY5DXAIq4pwWMD7ezmVctRj/wZ8Xf1OlUNJnDYww054vCZ/qgsAgZX5RIliGY
         zdNnIiQwM0AYbFdNu0p0p9EMcTAh36K58c1WZJK00By/JQOAfhKGjg563j6EfmWUYMJ0
         +UQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680115294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dxmuN5bOpF+xyVb1w+Z2846HXpRYFN7xoRDxUCB2yvc=;
        b=urzaNYDPkyZOZOXcHrKAHRHoQqZcaVRydSWAHGPgphs7SkRQxN0Pf5a5HH6ksZv8e3
         iXPIQiLiues0KkfeDF6sLHDN/FG3FFt4Qc6jiwp6hIn4aBIiPpowrEVcLAsS4q5G2BNP
         2P8dTYa1CYFBzE+vomu5uRuQr7xnY02KGQ1ZcSLYE34Yjwk08xbadUJwJs7rBHpKpWBV
         cNWIlLvHuaEOloYEEcnt/jhYDZNLR4L3Ta97FYlPkX2EK279NisfpHikN7DWID1trvhw
         KvtCzYTc48k5YHLiuwGyqMn5eZrGGgJPbFIa46DfigQ9Cte2IUjU8bSsKe9hr2maLwc8
         xWvA==
X-Gm-Message-State: AAQBX9eUbeKP2CRkzx5YvoS02kP929QwksG7sCoQ2B+V+EZRRa69FA5R
        UQPtq9N5hai1gKFU7IeHjArR5VL88wFRzXykNFdeVFop
X-Google-Smtp-Source: AKy350YWBi8e+i2vlNB8rLjeF2Gqd7dRo4lVWB+6YMTd4uiqg9XZrtffvH0BuKPyY/e6tOecaXaDgxhbZAmmVPUNL7M=
X-Received: by 2002:a17:903:41c6:b0:1a0:7630:8eed with SMTP id
 u6-20020a17090341c600b001a076308eedmr7544643ple.11.1680115293931; Wed, 29 Mar
 2023 11:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <dc432429a6d87f197eefb179f26012c6c1ec6cd9.1680114854.git.andreyknvl@google.com>
 <74d26337b2360733956114069e96ff11c296a944.1680114854.git.andreyknvl@google.com>
In-Reply-To: <74d26337b2360733956114069e96ff11c296a944.1680114854.git.andreyknvl@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 29 Mar 2023 20:41:23 +0200
Message-ID: <CA+fCnZcNynt_fzhikr4SnQfTqmOWMepg-yhnVQfzE7pn3GAS6g@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] arm64: mte: Rename TCO routines
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Weizhao Ouyang <ouyangweizhao@zeku.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        andrey.konovalov@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 8:37=E2=80=AFPM <andrey.konovalov@linux.dev> wrote:
>
> From: Vincenzo Frascino <vincenzo.frascino@arm.com>
>
> The TCO related routines are used in uaccess methods and
> load_unaligned_zeropad() but are unrelated to both even if the naming
> suggest otherwise.
>
> Improve the readability of the code moving the away from uaccess.h and
> pre-pending them with "mte".
>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> ---
>
> Chages v1->v2:
> - Drop __ from mte_disable/enable_tco names, as those functions are to
>   be exported to KASAN code.

Hi Catalin and Vincenzo,

Could you please take a look at this patch and other arm64 parts in
this series and give your ack if they look good?

Thank you!
