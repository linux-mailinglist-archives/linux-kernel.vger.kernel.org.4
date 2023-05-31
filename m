Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519AC717258
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 02:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbjEaASM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 20:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjEaASK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 20:18:10 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66458100
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:18:02 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-51b33c72686so3256582a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685492282; x=1688084282;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MiX5kKBgyHn7Q2uueehDrf1adzHRm5bDWm/e4F6Anxg=;
        b=F0S0BOKGLFqXikNeyUoqjigXLViNvD0x3BGX6c3oA6Jv13keqly43YCI3oi8/N1IyE
         G5hxcXETvy5iQwDC9scKKXtObF+mxkE0Fo/3h3ORwU3DmuZ5F6vJzMMU1NIkSOTRDsps
         FgyyKY33oFnU/okha3b4dWQBtFZzMhzX0/U4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685492282; x=1688084282;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MiX5kKBgyHn7Q2uueehDrf1adzHRm5bDWm/e4F6Anxg=;
        b=TY/24ctRIsUbNp20Yi4CElsGYq8jAxBafKBMK9LBo5ol/5XuFAh54n4YNNExqFR99X
         wV76OlnMbSG/jPHcCpBVgyHEW3bA0/3Rkg+qoRoE76MkQ/WjSdxQs/WRQjcviVJSAxIa
         KBTRdkQD/D9oTpPduSNkAnlq0LacLAGAAdgPppH9IlD4tfFvc96tedBiagfOSPhhVxxd
         Q1spzsFo/glQeMHXZ5soZ+9cJW9NKMegKBUtIl16nfeTK8tA1D0wlBO7WWZiBbqhA8aN
         1+PYMwSDFnWrlEf4pyydRZSVqNuKJgOxX7SIgK9AUCYts5cWY/80s49/4I33dlHv8EoN
         q/lQ==
X-Gm-Message-State: AC+VfDyt+SG4o8iyZuGzxbKZzP7ay9CwGOyS4GJIR8Kqy+V02Zsq+N78
        jklVg0WF9GKKHdri2nVSlaR0mw==
X-Google-Smtp-Source: ACHHUZ61jT+R5XlE0zI6sSl36bwS+gpPkJUCYi8bMvkEGyWkyNKU9KHZ8+PzdgGwByE8HptulMa9Sg==
X-Received: by 2002:a17:903:32d2:b0:1b0:3841:bcda with SMTP id i18-20020a17090332d200b001b03841bcdamr4612548plr.0.1685492281828;
        Tue, 30 May 2023 17:18:01 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l6-20020a170903120600b001b016313b1esm8794203plh.82.2023.05.30.17.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 17:18:01 -0700 (PDT)
Date:   Tue, 30 May 2023 17:18:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joan Bruguera =?iso-8859-1?Q?Mic=F3?= <joanbrugueram@gmail.com>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: build error while building arch/x86/purgatory/sha256.o: invalid
 'asm': operand is not a condition code [...]
Message-ID: <202305301658.BF6ECF65C@keescook>
References: <175578ec-9dec-7a9c-8d3a-43f24ff86b92@leemhuis.info>
 <20230528164031.266590-1-joanbrugueram@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230528164031.266590-1-joanbrugueram@gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2023 at 04:40:31PM +0000, Joan Bruguera Micó wrote:
> I can also reproduce the problem with Arch's linux-next-git, see config:
> https://aur.archlinux.org/cgit/aur.git/tree/config?h=linux-next-git&id=f9a384e1c582321651fb613782ebc5a581146af0
> 
> I've bisected it to df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3"),
> which explains why it only happens on GCC13.

Okay, this was a wild ride. Bottom line, -fstrict-flex-arrays=3 means
that CONFIG_FORTIFY_SOURCE wrappers will be included in new places now
that trailing arrays aren't ignored any more. The trailing array in
question was for struct sha256_state:

struct sha256_state {
        u32 state[SHA256_DIGEST_SIZE / 4];
        u64 count;
        u8 buf[SHA256_BLOCK_SIZE];
};

And this "buf" is a memcpy() destination, it was being runtime bounds
checked, which means FORTIFY might emit wrappers, which will call the
WARN wrappers, which will hit this asm, which isn't supported in
purgatory.

> 
> The problematic expansion that causes the error seems to be this fragment
> from `_BUG_FLAGS` in `arch/x86/include/asm/bug.h`:
>     asm(".long %c0 - .\n": : "i" (__FILE__));
> 
> Along with the fact that this file is built with `-mcmodel=large`
> (see `PURGATORY_CFLAGS` in `arch/x86/purgatory/Makefile`).

So, we can either disable fortify (which seems a big hammer) or disable
the warning. Disabling the warning kind of hides the problem, though
that seems to be the intention of purgatory.c's empty warn()
implementation. :P

I think it's best to disable fortify, though, as we're in a
DISABLE_EXPORTS state, and probably others are going to need it too, as
most other have already done so:

arch/arm64/kernel/pi/Makefile:             -D__DISABLE_EXPORTS -ffreestanding -D__NO_FORTIFY \
arch/riscv/kernel/pi/Makefile:CFLAGS_cmdline_early.o += -D__NO_FORTIFY
arch/riscv/kernel/pi/Makefile:CFLAGS_lib-fdt_ro.o += -D__NO_FORTIFY
drivers/firmware/efi/libstub/Makefile: -D__NO_FORTIFY \

These should probably gain -D__NO_FORTIFY:

arch/riscv/purgatory/Makefile:CFLAGS_sha256.o := -D__DISABLE_EXPORTS
arch/riscv/purgatory/Makefile:CFLAGS_string.o := -D__DISABLE_EXPORTS
arch/riscv/purgatory/Makefile:CFLAGS_ctype.o := -D__DISABLE_EXPORTS
arch/s390/purgatory/Makefile:CFLAGS_sha256.o := -D__DISABLE_EXPORTS
arch/x86/purgatory/Makefile:CFLAGS_sha256.o := -D__DISABLE_EXPORTS

I'll send patches.

-Kees

-- 
Kees Cook
