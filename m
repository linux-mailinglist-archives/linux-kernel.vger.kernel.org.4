Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879066A23D3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 22:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjBXVcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 16:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjBXVcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 16:32:15 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083206F023
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 13:31:57 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id c1so866652plg.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 13:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cvJN8dmrmNJu4tTYhdlBrzcRSinLAy+Jhaplp/kCRiA=;
        b=wh807lSO9v29Yu6tO13IzDLOgiVo3Y9CLLlEMCaN5Bfph5SWKk/ief3r4cZyouTDq3
         ekQ8BZiAaegZvDAKUQ41D41hsAmetgk6oRbzZgr5tZ8Ebv6rouEL0se6NNr8O8vuHMuA
         Y9E1KcrrOfgbPedMh8QVliNBmDLSSk306iIqsN5Z3WjNY4Kf8EbTZS61IOkrrZWWRWux
         SIrlqYQU9Ed7MRpv4GK6gK/n40iENTbOVq0sI7jnPIv4ay32p0xTWuzO+r4e3KUxS3Aw
         mV9fpIWYF+zc1nWP6gzHkwKwUixXjTuaac3chNZcBChKKjLuR16rINK9a4ShFPJKhkRy
         dJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvJN8dmrmNJu4tTYhdlBrzcRSinLAy+Jhaplp/kCRiA=;
        b=CYkpijfti1h+TNYWTXMaiolY1GJmN+zB2i10+xV/DWj9J0vl1WfwWCo8z398L9z1Rc
         OCMYcGOdx7qHbm71rB18IStSKVALHQk3yFGWN7k3FM7Akkf9uxebJSjHHSoO/X8TXLDY
         99KhRGU7i7OsRcpk2siE+QlxBvQL/XzZsdN7nQf3ZN1xiYHQK0/ufX2h2ZPpCi9Jubq9
         AE1PAQ4i6o/sRLj4zV4RVcOzu4eacT/WVBkD9j2SDCOJ8ap3Bsf3aEY6mNpDYmwx826h
         Cp0gf9qhB3XDcMhsvzjwunc7T7Hu5pfqHT4YJcaP8qeBbb/Ewzyw/jPkYVYNUnV6ZPFO
         8YdQ==
X-Gm-Message-State: AO0yUKUNbIwzn5wBnrcC3rmQPxsVBiVjzxaWZMbnmHFq84qYbq2L+58P
        jp4n6sJONEZStUKwEVDSTTvBGA==
X-Google-Smtp-Source: AK7set+inR9Bfe356VnjZRrkMmucPTHHx4QOqBABEwJbFOr2cvrtN9y1cnMB0g/q9qfmCnSJDZEm5g==
X-Received: by 2002:a17:902:d506:b0:199:4d25:6a4d with SMTP id b6-20020a170902d50600b001994d256a4dmr997355plg.10.1677274316335;
        Fri, 24 Feb 2023 13:31:56 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id jw9-20020a170903278900b0019a7d58e595sm6071070plb.143.2023.02.24.13.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 13:31:55 -0800 (PST)
Date:   Fri, 24 Feb 2023 13:31:55 -0800 (PST)
X-Google-Original-Date: Fri, 24 Feb 2023 13:31:09 PST (-0800)
Subject:     Re: [RFC 0/2] RISC-V: enable rust
In-Reply-To: <20230224133609.2877396-1-conor.dooley@microchip.com>
CC:     linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Conor Dooley <conor@kernel.org>, ojeda@kernel.org,
        alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
        gary@garyguo.net, bjorn3_gh@protonmail.com, corbet@lwn.net,
        Paul Walmsley <paul.walmsley@sifive.com>, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com,
        rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Message-ID: <mhng-f429a40f-1869-4c5b-ab4f-e7eec94489e8@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2023 05:36:08 PST (-0800), Conor Dooley wrote:
> This is a somewhat blind (and maybe foolish) attempt at enabling Rust
> for RISC-V. I've tested this on Icicle, and the modules seem to work.
> I'd like to play around with Rust on RISC-V, but I'm not interested in
> using downstream kernels, so figured I should try and see what's
> missing...
> I've tagged this as RFC in case I've missed some "WAaaaa you can't do
> this" somewhere :)

I'm fine with it, but IIRC the Rust support for most targets was pulled 
out as they weren't deemed ready to go yet.  If the Rust folks are OK 
turning on RISC-V support then it's fine with me, but I think it's 
really more up to them at this point.

So

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

in case folks want to take it via some Rust-related tree, but I'm also 
fine taking it via the RISC-V tree if that's easier.

>
> Thanks,
> Conor.
>
> CC: Miguel Ojeda <ojeda@kernel.org>
> CC: Alex Gaynor <alex.gaynor@gmail.com>
> CC: Wedson Almeida Filho <wedsonaf@gmail.com>
> CC: Boqun Feng <boqun.feng@gmail.com>
> CC: Gary Guo <gary@garyguo.net>
> CC: Björn Roy Baron <bjorn3_gh@protonmail.com>
> CC: Jonathan Corbet <corbet@lwn.net>
> CC: Paul Walmsley <paul.walmsley@sifive.com>
> CC: Palmer Dabbelt <palmer@dabbelt.com>
> CC: Nathan Chancellor <nathan@kernel.org>
> CC: Nick Desaulniers <ndesaulniers@google.com>
> CC: Tom Rix <trix@redhat.com>
> CC: rust-for-linux@vger.kernel.org
> CC: linux-doc@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> CC: linux-riscv@lists.infradead.org
> CC: llvm@lists.linux.dev
>
> Miguel Ojeda (2):
>   scripts: generate_rust_target: enable building on RISC-V
>   RISC-V: enable building the 64-bit kernels with rust support
>
>  Documentation/rust/arch-support.rst |  2 ++
>  arch/riscv/Kconfig                  |  1 +
>  arch/riscv/Makefile                 |  3 ++-
>  scripts/generate_rust_target.rs     | 19 +++++++++++++++++++
>  4 files changed, 24 insertions(+), 1 deletion(-)
