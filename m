Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC285FE3C4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJMVIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiJMVIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:08:35 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A62C188AA0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:08:34 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id s196so1307435pgs.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 14:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tRiTLwAuwPYUgBPKA1FJZY2eXZvOzFOFrZPEJVwL26o=;
        b=ZX0Pz3OHWIBikjl2nin8p8bzMVA7qsaOOx+VSaA0VKLo+/pf0qHeeQl3K5fxn0rdTZ
         r9qMgMOk8s0AmblqGYuF2UbJRtlRQbBXjtkbtMfd8sdrEdYG/v8ZQ4XmM7+Mzzbbqeh2
         ipvwHZDHRwmHrSZlicLhTGIPfoYcEv3iN8EgWNCvBotWji5BFRklZYqQvTPgqZHr+QQp
         mN+h5iNP0y80aYsn9p6ZeHY6LgoDvXns2/3KGUmkS4ky9DUxtW8aSUfGvgmH7ZxWMl8B
         RzuRZm5fw9FJwG48IIlTDzo8JIow8l32ibjXd0H6+zLBuS2QSjjLQVuxseheI+gn7qDk
         Luxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tRiTLwAuwPYUgBPKA1FJZY2eXZvOzFOFrZPEJVwL26o=;
        b=lkQH5QeWZClGz9UeDmULMmeFSqBcPf9VctLrYco1TUSN+SE/hMoa3o7cohPDoozb5d
         b8LhDXbHaoBGrkfFNEjv7HhSZtN7p9UeliHKMyGhY283cWqgStm/ztWfRc2Ks93VwZ8B
         3SwlbEZWgzBkMNZEW2kmvF0rhNvMEGmOOhq+hkXMe4rpO0attciGPptCJwksSjgPhriU
         ZGUrrK/LpwlLdmjIENWsyFHBi9LO8lza3CqqHQL/Ohq2mdFK3yTifiyfk/gZdahmTKwv
         LKsXZMm9mz0zVNa5kSgjGu0eln9WJ067ujQUJJJEp5ChR04KkKk3UwxoadCnLUNrtkQE
         XGOw==
X-Gm-Message-State: ACrzQf1kN9earFmjdtmTb8AqLUseutZpKD6rg0n0EZqW9kidK528vHDj
        gvMN4XNCCeUTkyif3Uo7ZZ2DueLS3SB+O9fbQ+zMFA==
X-Google-Smtp-Source: AMsMyM7snGxVrR2t3EbMMIs4TvcOoMOGRD6Tu7kzSv5Zv/o49eR/+vqSHdC2ZvT4bGguSviHW8LS/+p9WBJplynpf4U=
X-Received: by 2002:a62:1a97:0:b0:562:5587:12d6 with SMTP id
 a145-20020a621a97000000b00562558712d6mr1606541pfa.37.1665695313619; Thu, 13
 Oct 2022 14:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9prBJHmo9Bw6aobuGLjtxLsjxKJ9wopOv5+BY6ZtuKaNg@mail.gmail.com>
In-Reply-To: <CAHmME9prBJHmo9Bw6aobuGLjtxLsjxKJ9wopOv5+BY6ZtuKaNg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 13 Oct 2022 14:08:22 -0700
Message-ID: <CAKwvOd=_gfTD24zEh9YpoNuBr_D+xjsefeb8sNXnSaU_UgnVRw@mail.gmail.com>
Subject: Re: gcc 5 & 6 & others already out of date?
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-toolchains@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 6:37 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi,
>
> I've been working on a (still in development) patch that tries to
> apply a few compile-time constant folding tricks to a widely used
> library function, so I wanted to make sure my trickery worked across
> all supported gcc versions for as many call sites as possible.

I'd imagine the kernel's inconsistent use of -ffreestanding per
architecture would be a blocker, if by library function you're
referring to a symbol that would typically be provided by the libc?

Do you have more info about what the specific issue you've observed is?

> Naturally, this means allyesconfig builds on the monster box.
>
> So all went well with a recent gcc and with clang. Then I tried gcc 5
> and gcc 6, and it wasn't fine. But it wasn't not fine because of my
> new code -- that all compiled just fine. Rather, it wasn't fine
> because of a modicum of other odd errors and fatal warnings
> throughout. I tried this with gcc 5 and gcc 6 and then got bored. I
> could test more versions need be. And I guess I could submit bug
> reports or write patches or work on fixing all those, if I actually
> cared about it. But I don't really care about it, and apparently
> neither does anybody else, because this isn't brand new breakage. And
> this all got me thinking...

Are the defconfigs totally broken with gcc-5 and gcc-6 and no one has noticed?

I wonder what versions of GCC KernelCI and linux kernel robot are testing with?

We have to maintain CI for all supported clang versions. You can see a
2D slice of our 5D build matrix: https://clangbuiltlinux.github.io/.
"I've never seen so much red in the galaxy!" "Hey, get back to work!"

We'd like to have the large window of supported versions that GCC
currently has; Clang's release cycle is also different from GCC's
though.  I wouldn't point to clang's smaller version support window as
justification for GCC; we'd rather be more like GCC in that sense, not
the other way round!
-- 
Thanks,
~Nick Desaulniers
