Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285045ECA66
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiI0REH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiI0REE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:04:04 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52F6F685A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:04:03 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id l9-20020a17090a4d4900b00205e295400eso1323693pjh.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=QmJLfS9I7/XuHeCFFZi2uIbypQ74PjFxFiPtGwFHQJ8=;
        b=BxjMcXoLXoNYNUPdzcbi/78Oibd6uaYGwAlT8y0Nl0Hyq3vNOU9bMt4uF9NcUiv9Xg
         Lo2IUTtZg9tGzwyhsReuYpMV0kcB+8smOYpUn+VTYvnertSyaknGZxR/2u4aHVc8T752
         sGdNueCTpO5Fw0Zkvv3aVb0IesMI+RGjx09QW5+YqY0iaQueORggUv5/R7GmR+kmFfzW
         9wUwEJwK2HJNIS7wEEjf+EWxRjlWGDdSc+BdqjzyQRDiIBPDZ3E8a1V3z199kRTBZdWp
         xm5SC0ITCZYd0EKOZKej5BzisjHpu0ECjWRPBR4fXKFex6Ypwlux617XNqq1x1055oxM
         MkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=QmJLfS9I7/XuHeCFFZi2uIbypQ74PjFxFiPtGwFHQJ8=;
        b=4ufBTG+n2oVz4Wt0pCAnRU2bJbrQMEQ1qtUD/mWxXKuqGHnAlLlnr+5DxhE1KlLZQ/
         iQyjh5uqsoj2AHzNcviKBuWZLLbEye7MVNRqaVgaTSy4GWaiM+0uo7ZGZBDvROvV8ALZ
         KaTJu+vJkKNSY+oKxyeX/gN45gnSF74cH/8f3TaZUWD8eWXHggl6fyieA6omOlA0TIyW
         R32rivGW0pUqNIb3B/jlB9J/q3Q8vYv31eSq+4tDCNToemDBEc/tdRtzKuNKUF/EB16B
         f37EsGpCo8uIFMJFS4cPPpxOvETRY0xSe/bQPrtGFS2bw/VG/8zXs+VC/hAPkwtcSNpd
         xC5g==
X-Gm-Message-State: ACrzQf1phD0kLJn9WIafRK5LFQhS3/o2tdkUQWDaP6H2+p1t/1k2UvYL
        6T4FAGSt0LsyQGiZWmXSK5LnBPLod5fycCmoynulgQ==
X-Google-Smtp-Source: AMsMyM6kYnpRlYHqWr7mBolKj7FIiU8kpVyQAGsF9gNj5/CQn5NeSQV/ko0g0gQ0HfgDCJcO4YZNzhyC/icWPmYVRyo=
X-Received: by 2002:a17:90a:74c4:b0:203:336d:dd36 with SMTP id
 p4-20020a17090a74c400b00203336ddd36mr5470661pjl.107.1664298243152; Tue, 27
 Sep 2022 10:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220923170218.1188423-1-ndesaulniers@google.com>
 <CAHk-=wiAwEA5KekL4+t+v6qAdKLSOQvBkGbumvk+Rxhaay8aFg@mail.gmail.com>
 <CAKwvOd=r+9X6JkikpuTvjdTn7DXusevoJBFjXtGQ1SZYCZ6f6g@mail.gmail.com> <CAHk-=whknQuJCqbzjtBrkjGOPrZPX6fjv8HSms2p0kw-NTdMZA@mail.gmail.com>
In-Reply-To: <CAHk-=whknQuJCqbzjtBrkjGOPrZPX6fjv8HSms2p0kw-NTdMZA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 27 Sep 2022 10:03:51 -0700
Message-ID: <CAKwvOd=a+0VNP-d=mHnbM4ujdtPrujru4dxHtfDo+EEM+b6deg@mail.gmail.com>
Subject: Re: [PATCH] x86, mem: move memmove to out of line assembler
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, yeah my patch essentially _is_
commit 9599ec0471de ("x86-64, mem: Convert memmove() to assembly file
and fix return value bug")
but for 32b (and no return value bug).  I should probably amend a
reference to that in the commit message for this patch.

Also, I'm missing an EXPORT_SYMBOL in my v1, so modules that reference
memmove will fail to build during modpost. v2 is required.

On Fri, Sep 23, 2022 at 11:06 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But I'm looking at that x86-64 memcpy_orig, and I think it looks
> fairly good as a template for doing the same on x86-32. And we could
> get rid of the duplication on the x86-64 side.

Is the suggestion that 64b memcpy_orig could be replaced with __memmove?

Sorry, I'm not sure I follow either suggestions for code reuse opportunities.

Also, any ideas which machines for QEMU don't have ERMS for testing
these non-ERMS implementations?

>
> That said, your patch looks fine too, as a "minimal changes" thing.
>
>                 Linus

--
Thanks,
~Nick Desaulniers
