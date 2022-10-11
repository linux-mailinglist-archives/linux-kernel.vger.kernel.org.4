Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765B65FB89C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 18:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJKQx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 12:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiJKQxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 12:53:21 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFE5A59AF;
        Tue, 11 Oct 2022 09:53:17 -0700 (PDT)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 29BGr4dR018005;
        Wed, 12 Oct 2022 01:53:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 29BGr4dR018005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1665507185;
        bh=f8HvnuVAteWRI5ncBuuE0MgQLi5Hb1h+j3HTVM2jcno=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qf8UL9ba1bhUo0chFLLB20TY56gnxZVwRMDNLwKGRx5d8SBtKu723evzOB1ogKA54
         MCsmRZgqE4FtDWOTviTId/6CU4JJl6ENThC45ijm8cy2RogCD8v/PNpFzNx8mG0L46
         lbWzNeelzbfNAeKbEolTII7gQdBVawu/+xMtL7vigjAu3XPZuYYt8oKFhswWK0KHuf
         Oj4P8BZdP81GOX1vLa71zZGvb0tPxgRmpUjfFUFiw/3/alI+bKqPBzB445m2aCCmcG
         9a/5PQ/3ElYCrySigHsvHQXx/Bd6aVLDUpIUNVxigUVZAjtkb2P8w20bSID/79Iug6
         WELXf5efwYahA==
X-Nifty-SrcIP: [209.85.167.171]
Received: by mail-oi1-f171.google.com with SMTP id n130so274293oia.6;
        Tue, 11 Oct 2022 09:53:04 -0700 (PDT)
X-Gm-Message-State: ACrzQf05KPYxF2ZFLO+7/vXdPJGt7WbcqduTYG4emOtYEqmH+qKG/uVK
        gQ0cuCSbEdN/3TM+1yNWywFkjV+/8HdwXB8x5YQ=
X-Google-Smtp-Source: AMsMyM60Tso+KMnUhy3DtJsunnEn/q5/4uBQ3277fO82D6ZNQB96rIUQqv8lGiPwNNRorBX3UApuHH5XmivLJygZy+I=
X-Received: by 2002:aca:bbd4:0:b0:353:f167:6fd3 with SMTP id
 l203-20020acabbd4000000b00353f1676fd3mr945oif.287.1665507183814; Tue, 11 Oct
 2022 09:53:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221011031843.960217-1-masahiroy@kernel.org> <CANiq72k9wAVCbHKVZFE=E3xv+2ZamUMsJ=uV43NxsSUQ4wXGdw@mail.gmail.com>
In-Reply-To: <CANiq72k9wAVCbHKVZFE=E3xv+2ZamUMsJ=uV43NxsSUQ4wXGdw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 12 Oct 2022 01:52:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNASP74qJ5fjjcVYcw4CyZ1psPnnyzLHsUu0b+MxLq-W1eQ@mail.gmail.com>
Message-ID: <CAK7LNASP74qJ5fjjcVYcw4CyZ1psPnnyzLHsUu0b+MxLq-W1eQ@mail.gmail.com>
Subject: Re: [RFC PATCH] Remove Intel compiler support
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ia64@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>, Len Brown <lenb@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Tom Rix <trix@redhat.com>, devel@acpica.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 8:55 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Tue, Oct 11, 2022 at 5:19 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> >  include/linux/compiler-intel.h            |  34 -----
> >  include/linux/compiler_types.h            |   2 -
>
> You can also remove a few lines from `compiler_attributes.h`:
>
>     * Optional: not supported by icc
>
> Thanks for this!
>
> Cheers,
> Miguel



Thanks.


Maybe, we can drop #if ... #else ... #endif
around __assume_aligned(a, ...), but I will leave it to you.


I will just drop the comment lines for now.
(Then, you will clean up compiler_attributes.h in the next cycle)
Is this your expectation for v2 ?




-- 
Best Regards
Masahiro Yamada
