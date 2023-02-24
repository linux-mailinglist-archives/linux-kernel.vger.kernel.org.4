Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2BE6A2462
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 23:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjBXWir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 17:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjBXWio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 17:38:44 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB0213D63;
        Fri, 24 Feb 2023 14:38:40 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-53852143afcso19670467b3.3;
        Fri, 24 Feb 2023 14:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IiZXfgYrspTV0X/zg/5bl8O+J9jjbguyQkrt9WII1A0=;
        b=bzK+Jq7kLQRRdxUfI3rrYPnfSI3JnEffWb9iDWXTH0zft44uEZTbkiVOJXDQdTrACx
         59XzqxmqHVQCjrcalYuHfMAMDZKQoxSe2WvnX0XCrmjwY/IdV9J+qg1BogLexreysUe/
         SokQYPWnZtnNi5IN3KBC6XGp6n88V1leOyFWNsyofCONgxYyK8yVnls6D6c15HzNTcPP
         jzTeweizmYsODUhNV63ps10xzbOpXTwQQGV+HGZen1SeStHtArDAsMd+sxc68prDIqlS
         bUM99cfGDG0fEihCtelGXCu922xUv5H42Pa6/jdLojJVOXzmFnr8QNaJ+entRlwl65be
         kCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IiZXfgYrspTV0X/zg/5bl8O+J9jjbguyQkrt9WII1A0=;
        b=hvSF0GlAKCUJ0nAwn/k/kx4WG9izUXGsHrd5XMJ3XHpEFngWU3lTQt2NkJWPvavURA
         Xtc2S4ofhJIufa+3lA2BfrvBaGvRHlQqBrAF5xwXeoowJUa/PECd7dLLju/qTjPn/jha
         zTu2qBmhs1tLET8v2aDcbbg/BRsXMNK0J40CMvODkZOEsXfgaa0M2I7oJGPYOi2mIaxA
         y7cOGbt5viY+81cnrnq7oolxz1GCHWoHczERkkWz+YhpqMparBXWMX2WTW2I5cdIx3ys
         Q/f6hGrhj61ghwr/HxYjfwb5xqHHzEfFIi5PXA9aksQ6fY0eRDcTn56UVVNcpAqDUeXo
         6JQg==
X-Gm-Message-State: AO0yUKUA8wHa7cWS32Onz0OoAipR/BPkxuzckhXOFCW9r3V8/Ziiau5j
        R68rbuUWurTuz1SZaNy6/mrV/9V9a8W37IFFLHE=
X-Google-Smtp-Source: AK7set+BcHZfCoW3YN7rlFFqlBxmBE2vpUFQA6KfIVb53xV/67tx3iho0pA7G0cJLfST92ibrVpx3iDHTpAZS3zFhwo=
X-Received: by 2002:a81:ac5c:0:b0:533:9b80:a30e with SMTP id
 z28-20020a81ac5c000000b005339b80a30emr5513757ywj.10.1677278319933; Fri, 24
 Feb 2023 14:38:39 -0800 (PST)
MIME-Version: 1.0
References: <20230224133609.2877396-1-conor.dooley@microchip.com> <mhng-f429a40f-1869-4c5b-ab4f-e7eec94489e8@palmer-ri-x1c9a>
In-Reply-To: <mhng-f429a40f-1869-4c5b-ab4f-e7eec94489e8@palmer-ri-x1c9a>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 24 Feb 2023 23:38:28 +0100
Message-ID: <CANiq72nfGfqnk4QyKsf3kmjgBVPG3WFLQqd7_+jLcYh9jG+fQw@mail.gmail.com>
Subject: Re: [RFC 0/2] RISC-V: enable rust
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
        corbet@lwn.net, Paul Walmsley <paul.walmsley@sifive.com>,
        nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
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

On Fri, Feb 24, 2023 at 10:32 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> I'm fine with it, but IIRC the Rust support for most targets was pulled
> out as they weren't deemed ready to go yet.  If the Rust folks are OK

So we trimmed the original series from v8 to v9 as much as possible in
order to upstream things piece by piece, get maintainers involved, and
so on; i.e. they were not trimmed because they were not ready.

Having said that, for the architectures support in particular, what we
had is indeed a prototype: each architecture we added was able to
compile, boot into QEMU, load the sample Rust modules, pass a few
tests, and so on in our CI, using a couple kernel configs. But that is
just the basic support, and it does not mean it works for other kernel
configs, all hardware, all security features, and so on.

So it depends on how you want to approach it, whether you are
interested in the basic support or not, etc. In any case, I would
recommend having an expert on the architecture take a look to
double-check things look sane, run some tests on real hardware, etc.

> turning on RISC-V support then it's fine with me, but I think it's
> really more up to them at this point.
>
> So
>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>
> in case folks want to take it via some Rust-related tree, but I'm also
> fine taking it via the RISC-V tree if that's easier.

Thanks Palmer! We are trying to get maintainers of the different
subsystems/archs/... involved so that they maintain the different Rust
bits we are upstreaming, so ideally it would go through the RISC-V
tree.

Cheers,
Miguel
