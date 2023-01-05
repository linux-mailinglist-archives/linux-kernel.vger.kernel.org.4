Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E7165ED84
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbjAENox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbjAENos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:44:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14CA37277
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 05:44:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D73961A4D
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 13:44:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE021C43398
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 13:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672926286;
        bh=oUowVryprpSKh0x6r/UB6C3j62vFgmCCkaUhgHs/5bg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y9aS4xKZagBkJ4xEjwJ1aVMalSYiqIyd/2WGPUtnTtF7ewiH81nwiw9+HF9utsu3c
         BTxAK3VIfTB40jxSle0t0cebx2RaZPAm0HoZf1b+L+g53eQeDbLleckOSTwvp4wNTN
         NyJgaY86T9FB8MSX68chb6VT/FhZS0m25sU0NU314rnXveBymvHGMPqeCi69UROXfo
         GLkQLP/+e2lIhB1UN9jPatWmOGrWX/rLSF0wHRpFyAU++2arv3hR94ksSEMf0j93FC
         b8A+cgaiQ310ZQUMXjxFgERGwQv+8B9LOmKVEMfQSEL0BU6vH32dq6kefB+SLyR0Zk
         gLmldlujrDqgA==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-14fb7fdb977so36337383fac.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 05:44:46 -0800 (PST)
X-Gm-Message-State: AFqh2kranrp5ueTIxLoqj+DVNVz/RZ74y32cHaOfemXOfIgq2AQyb7dl
        +VxYbzjNrBVv8Rq8vEZH0hV35cFfDFLZbQz75EQ=
X-Google-Smtp-Source: AMrXdXtjTcSGauAbJOJaeSxN/8SnHXcdjIM55w4UWd31JvE7FrPEgv9MHXCBvxWYp75vIetYJotMnEIUpyaEjpkJwfU=
X-Received: by 2002:a05:6870:514c:b0:150:7e4a:2f00 with SMTP id
 z12-20020a056870514c00b001507e4a2f00mr1126149oak.194.1672926285969; Thu, 05
 Jan 2023 05:44:45 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wim8DMRzjyYTJ3UbdqZ26keQyZSU02NZb-JY1=9OpcO1w@mail.gmail.com>
 <20230102225656.GA3532398@roeck-us.net> <CAHk-=wjZPPscjDhsHQw_ttHOaQS69rADLm0KuRhbNavBiO62OQ@mail.gmail.com>
 <20230103014535.GA313835@roeck-us.net> <CAHk-=whmeBkyu3iS_s-yk0=t3GEoW3sQb-wJFHKykOjG=iQVFw@mail.gmail.com>
 <CAMj1kXHqQoqoys83nEp=Q6oT68+-GpCuMjfnYK9pMy-X_+jjKw@mail.gmail.com> <CAHk-=wg6K2qge_MWHX9DurBUpbd54ih482gV5rf8ts7v8TUipA@mail.gmail.com>
In-Reply-To: <CAHk-=wg6K2qge_MWHX9DurBUpbd54ih482gV5rf8ts7v8TUipA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 5 Jan 2023 22:44:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQz6f_1jsp22HRRQqwfb6jh8_BGMgyUtE9TK8ENoHzJxQ@mail.gmail.com>
Message-ID: <CAK7LNAQz6f_1jsp22HRRQqwfb6jh8_BGMgyUtE9TK8ENoHzJxQ@mail.gmail.com>
Subject: Re: Linux 6.2-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 4, 2023 at 3:34 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Jan 3, 2023 at 2:59 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > The purpose of this change is to prevent .note.GNU-stack from deciding
> > the section type of the .notes output section, and so keeping it in
> > its own section should be sufficient. E.g.,
> >
> > -       /DISCARD/ : { *(.note.GNU-stack) }                              \
> > +       .note.GNU-stack : { *(.note.GNU-stack) }                        \
>
> This seems to work for everybody, so let's go with this. Masahiro?
>
>                Linus



Sorry for the delay, I completely missed this thread.


Tested-by: Masahiro Yamada <masahiroy@kernel.org>



It works for me, but the comment block above should be
changed accordingly, for example:

  /*
 - * Discard .note.GNU-stack, which is emitted as PROGBITS by the compiler.
 + * Separte note.GNU-stack, which is emitted as PROGBITS by the compiler.
   * Otherwise, the type of .notes section would become PROGBITS
instead of NOTES.
   */


This change, however, leaves an empty .note.GNU-stack section in vmlinux.



I personally prefer discarding .note.GNU-stack entirely because
GNU linker does not leave empty .note.GNU-stack when linking
user-space programs.



Because I did not notice the discussion was happening in this thread,
I submitted a different approach for fixing s390, and it was quickly merged:

  https://lore.kernel.org/lkml/20230105031306.1455409-1-masahiroy@kernel.org/

This approach requires RUNTIME_DISCARD_EXIT for each architecture, though.

I do not know how Michael will fix powerpc.







While I was looking into this issue,
I noticed the real issue is,
how to discard sections is up to arch maintainers.



[1] Most architectures discard .exit.* sections at run-time.

     Just run
      git grep EXIT_TEXT
       or
     find . -name vmlinux.lds.S | xargs grep "at runtime"


[2] If .exit.* is allocated, then later discarded, it is kept.
    (the first occurrence wins, in other words,
    the sections defined in /DISCARD/ are not necessarily discarded)


[3]  Despite the fact of [1], many architectures forget to
     define RUNTIME_DISCARD_EXIT.
     They still work because they put DISCARD
     at the end of their linker scripts.


[4]  arm64 puts DISCARD at the beginning of the linker
     script, and defines RUNTIME_DISCARD_EXIT because otherwise
     .exit* are discarded due to the "first wins" rule.


[5]  If we really want to discard more sections, we often end
     up with moving DISCARD up, and at this point, we realize
     that RUNTIME_DISCARD_EXIT is missing.





I think it is unreadable (and fragile)
to keep/discard sections depending on the particular
order in the linker scripts.


Is there any better approach to make sure to discard
sections defined in DISCARDS?






--
Best Regards
Masahiro Yamada
