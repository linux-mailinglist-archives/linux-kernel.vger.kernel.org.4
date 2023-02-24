Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5C26A2339
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 21:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjBXUmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 15:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjBXUmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 15:42:22 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32796DDAE;
        Fri, 24 Feb 2023 12:42:20 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-536af432ee5so13451347b3.0;
        Fri, 24 Feb 2023 12:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2ldkH3+tipVLOPM0MWXmtHwekgdqITx22yGZynxWxbI=;
        b=dtF6STP7th/ajy1mC0vEUSVWlM9pVmOG3Gn6XA5sl3LA9B9wF3UHwni7+m64GxjbOR
         VJ8YtDgIepMCXzo3IqidR6Cotkep2peyv5PLBE1o4qjySmPFQpBz1gTEVu5KwgHz/Avx
         eYeoxs0AEnbKsW+Lwxf7bJsfpZIVDXS8zZWVLrJl03lvJ4GG2rCmVqfdsSFMTAvwZ9hp
         Jvc/8QtR/Kx/MlWRP2gXnMW5ZZ1S0BWrIDDqfxxr2ZopFa9eZs9Inw++1fPcqsN9pfeu
         HkTMFCZv5T8sYU5ua56Z/XQ4SqtIwDjglQCvQA22GnAvaT5WFS0PSBOy/wmaUJuWNFfX
         HUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ldkH3+tipVLOPM0MWXmtHwekgdqITx22yGZynxWxbI=;
        b=jW9+ZTM3iDQ2E7WfMURhEnAxogubst5+o0JtQotgrK/oX8uLq3C8bQbvmohD4O1211
         vWtksCXzUUkkragdKzLc4IsD9xjvUB5NpcnOgrdIFQ95G2hx5Faf5rox1Jkwprrs9KUH
         VaDt+Ppgq+5g0Gfp5SCbhwJNtNcTxxwVI2rhliGKo5wtQMmVpvN39/tSjkMcsxOoBEkZ
         Y5QugFGmgqg/uGOHS8njLSqK3EI/8lHi0LqjcC/w9vKSXpLwTO1gTU0FC8TN2xAVc4iJ
         RxQ+WzAHlPRCSvb5tqp0nkjljqqQDUSlAi5UVav1tFjVeqMMKSczD3XJZZguMHdR65CZ
         lw6g==
X-Gm-Message-State: AO0yUKVMdYMK/8bBN6SO4pBxsOZckp3E6Mrr2Pxp5zcnCxc86czT15TQ
        29OjT4MGCVt5+RdQHxIK3DSTKyfp33QNfCWhx54HSsDYknA=
X-Google-Smtp-Source: AK7set/+ywY8A6LUpNjag7/xfz0UOWYQ6RUky53j75FCT+hoIcIZqEDUzCcFtByz4LcO4y0MEBVqzL7jJFm3tgkYRFc=
X-Received: by 2002:a05:6902:1602:b0:8a3:d147:280b with SMTP id
 bw2-20020a056902160200b008a3d147280bmr810737ybb.3.1677271339810; Fri, 24 Feb
 2023 12:42:19 -0800 (PST)
MIME-Version: 1.0
References: <20230224133609.2877396-1-conor.dooley@microchip.com>
In-Reply-To: <20230224133609.2877396-1-conor.dooley@microchip.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 24 Feb 2023 21:42:08 +0100
Message-ID: <CANiq72=4ZhV=u2ZUr=x-iAS_iMnV8GSiq0tEn7Tj0NanO=D+xQ@mail.gmail.com>
Subject: Re: [RFC 0/2] RISC-V: enable rust
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, conor@kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, rust-for-linux@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
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

Hi Conor,

On Fri, Feb 24, 2023 at 2:37 PM Conor Dooley <conor.dooley@microchip.com> wrote:
>
> This is a somewhat blind (and maybe foolish) attempt at enabling Rust
> for RISC-V. I've tested this on Icicle, and the modules seem to work.
> I'd like to play around with Rust on RISC-V, but I'm not interested in
> using downstream kernels, so figured I should try and see what's
> missing...
> I've tagged this as RFC in case I've missed some "WAaaaa you can't do
> this" somewhere :)

Thanks for sending this and taking the lead on RISC-V -- I appreciate
you put me as the author, but in this case, it was actually Gary that
started the RISC-V port [1], and then I sent three PRs on top later
on.

When submitting something on behalf of somebody else, I suggest being
very careful and ideally contacting the authors beforehand. In
particular, if there has been any modification (including to the
commit message), then a note should be added explaining so.

Therefore, please double-check everybody that contributed to the lines
you are sending (e.g. via `git-blame`) and add them as
`Co-developed-by`. Also, please add a note of what you changed/wrote
e.g. square brackets, and `Link` tags to the original PRs/discussions.

See, for instance, what Jamie did at [2] for arm64 or Lina at [3].

[1] https://github.com/Rust-for-Linux/linux/pull/225
[2] https://lore.kernel.org/rust-for-linux/20230125163739.3798252-2-Jamie.Cunliffe@arm.com/
[3] https://lore.kernel.org/rust-for-linux/20230224-rust-vec-v1-4-733b5b5a57c5@asahilina.net/

Cheers,
Miguel
