Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F5C6632C2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237903AbjAIVW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237699AbjAIVV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:21:57 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273CB1B9D3;
        Mon,  9 Jan 2023 13:20:33 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id p17so7174552qvn.1;
        Mon, 09 Jan 2023 13:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJEqa+Tto0uZChApOqUQ2j2+Od/K35yIfKV8/pb19Cg=;
        b=kU8C+PjPb/OlrFnQtciboURZCvGxqFiuYXXLOgzYDYrLrfVe3KBYM4TI/sCXZSk3wt
         np6YnhMybvx06KIuBtei/ZE4RpwRlYekyJJLz+Q0UEw0AmHbvWqFhHU5DnDLz4rlZbgy
         nTwUJNdc4nmcsYvifsTng+C+Wntn9Tl1KrcZ4lVQdt1sgyAc3Ki5aKwDD1vWhGM95zgE
         ldpMxcuFo0L9nj+gLYEeyAvbbJ7WGRMsyVzg/wB9Taq9WDYDVNFZwr1K4YbXPSTJi4HS
         RMHm2DBeXTCcIP/nroyVaD8SBA+fi8WxxcxB/UmzK8uH9nSoqoeMjpDtkJddtBSIyaW0
         3C+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJEqa+Tto0uZChApOqUQ2j2+Od/K35yIfKV8/pb19Cg=;
        b=gHIhNYG72L62Vkar/FeTCNV6JH2BEi55dSz8Qb4fQyZ/2xVAY7VYTDJYxJdqUKvA9R
         KTshlxkbfc1fzF/ywJxjLUrnudOQUS6HvHpATS7gchf9wQFonecQtRyYEmUrFAGX5Vnk
         UqKXl5uQi0Sa9peXtI8hJmJs/S1/MAhwG20MGWzMaP0cSMKWlgqOH2w3H3HWxumkkvUc
         KdX3U1+ztbuowCCL/wMxYAqK89e7M+ivPdO6ZMqvP8341flXteWgUYz0/uQZUmEaqEGw
         lJ51pM6/qy3hRKPe01Klwt5kBH1qyrugWLslfWemU/67TSaNQyQ6/bu19/ay9FlNiu1u
         /znA==
X-Gm-Message-State: AFqh2krTGvvvNws9vi/O47jhk0mQgVl7Pw0Uw3Dtl25vJkvqu/usQnju
        zO+7gVJfLO12mS0iSWm+g/g=
X-Google-Smtp-Source: AMrXdXsoGAtbX1x6PQupFaB5OZUfIqyN8s8i8d7r91SylZ3iP39IbvEcjkT1oyukw0l03wP3b3ROeg==
X-Received: by 2002:a05:6214:5f8a:b0:4c7:1d2c:bd93 with SMTP id ls10-20020a0562145f8a00b004c71d2cbd93mr52052916qvb.47.1673299232973;
        Mon, 09 Jan 2023 13:20:32 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id t11-20020a05620a034b00b006fa31bf2f3dsm5940430qkm.47.2023.01.09.13.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 13:20:32 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 14F1427C005A;
        Mon,  9 Jan 2023 16:20:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 09 Jan 2023 16:20:32 -0500
X-ME-Sender: <xms:H4W8Y6jQsuyf0tgC_J2VVvZ1JGl0PbiD-j7G7HPNIAkUxS6CSouz9Q>
    <xme:H4W8Y7Djb8I--r2BWIiJw5uQGJcBOV4vsWcIdUTwboOcaR60XvtrFfd4tRe6XeiZV
    XD7Akh100_46EWngg>
X-ME-Received: <xmr:H4W8YyFq1M3OBkQZ68GBrMMzXMGIh3sCs0PgAQEw9XKrBKZNNzWtBfM5RXs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrkeeigddugeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefftdeihfeigedtvdeuueffieetvedtgeejuefhhffgudfgfeeggfeftdei
    geehvdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:H4W8YzRCGjQ8gvwPO0-vxJFdHNkChVe9ecJevEAQy38uBVGqhmjDBg>
    <xmx:H4W8Y3ys3CJlO_54rH_uNgmMYLCUG0XA6qdqRgcTLdALfeOnzWF7DQ>
    <xmx:H4W8Yx51IyZcJ5k2q7RWvLi2Nh5c-EPZTGPf2kdjBsMLuFqb3Sdd-A>
    <xmx:H4W8Y-kcZpqgp5J8QaFzCL0lggJKMGbVtBKJJrUVr12kzT9cMSr8tg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Jan 2023 16:20:30 -0500 (EST)
Date:   Mon, 9 Jan 2023 13:19:14 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev,
        Domen Puncer Kugler <domen.puncerkugler@nccgroup.com>
Subject: Re: [PATCH] rust: print: avoid evaluating arguments in `pr_*` macros
 in `unsafe` blocks
Message-ID: <Y7yE0pWJeWRbok3V@boqun-archlinux>
References: <20230109204912.539790-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109204912.539790-1-ojeda@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 09:49:12PM +0100, Miguel Ojeda wrote:
> At the moment it is possible to perform unsafe operations in
> the arguments of `pr_*` macros since they are evaluated inside
> an `unsafe` block:
> 
>     let x = &10u32 as *const u32;
>     pr_info!("{}", *x);
> 
> In other words, this is a soundness issue.
> 
> Fix it so that it requires an explicit `unsafe` block.
> 
> Reported-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Reported-by: Domen Puncer Kugler <domen.puncerkugler@nccgroup.com>
> Link: https://github.com/Rust-for-Linux/linux/issues/479
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

> ---
>  rust/kernel/print.rs | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/rust/kernel/print.rs b/rust/kernel/print.rs
> index 29bf9c2e8aee..30103325696d 100644
> --- a/rust/kernel/print.rs
> +++ b/rust/kernel/print.rs
> @@ -142,17 +142,24 @@ pub fn call_printk_cont(args: fmt::Arguments<'_>) {
>  macro_rules! print_macro (
>      // The non-continuation cases (most of them, e.g. `INFO`).
>      ($format_string:path, false, $($arg:tt)+) => (
> -        // SAFETY: This hidden macro should only be called by the documented
> -        // printing macros which ensure the format string is one of the fixed
> -        // ones. All `__LOG_PREFIX`s are null-terminated as they are generated
> -        // by the `module!` proc macro or fixed values defined in a kernel
> -        // crate.
> -        unsafe {
> -            $crate::print::call_printk(
> -                &$format_string,
> -                crate::__LOG_PREFIX,
> -                format_args!($($arg)+),
> -            );
> +        // To remain sound, `arg`s must be expanded outside the `unsafe` block.
> +        // Typically one would use a `let` binding for that; however, `format_args!`
> +        // takes borrows on the arguments, but does not extend the scope of temporaries.
> +        // Therefore, a `match` expression is used to keep them around, since
> +        // the scrutinee is kept until the end of the `match`.
> +        match format_args!($($arg)+) {
> +            // SAFETY: This hidden macro should only be called by the documented
> +            // printing macros which ensure the format string is one of the fixed
> +            // ones. All `__LOG_PREFIX`s are null-terminated as they are generated
> +            // by the `module!` proc macro or fixed values defined in a kernel
> +            // crate.
> +            args => unsafe {
> +                $crate::print::call_printk(
> +                    &$format_string,
> +                    crate::__LOG_PREFIX,
> +                    args,
> +                );
> +            }
>          }
>      );
>  
> 
> base-commit: b7bfaa761d760e72a969d116517eaa12e404c262
> -- 
> 2.39.0
> 
