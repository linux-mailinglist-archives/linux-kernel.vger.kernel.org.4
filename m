Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDEB6A429D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 14:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjB0N2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 08:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjB0N2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:28:44 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A194F974
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 05:28:42 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id o15so23285831edr.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 05:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=+mE5gZc6viG/xXOsPF+F+4EMY6E1n4H7xrKSm+Ny0wU=;
        b=RPsVl1pelawQdZFTgN5E3b042km9q3OpmP9vlTAn4emotmAngVfbo2/rBicZ1Pdcqg
         UYEcT4Blo5vl3aTuUFSetJwe+nQQtI/wDeUezLQ58XypftLtLEx49mtLeaY7uOMfPzGQ
         TJdpPF0ROiLD+uEDJf+tsXWsB+i8iIDr36RK6JyOG+T+rlMiBtpZCJlSd2gb3RRMVyyC
         UrSdmqYR0QvV6bsS3ZUwIgegzKA28O4nA/Rj9eUMDMSV6kfpBoI06+eJu7Pc+Nfk+OFP
         FnApEHPONZNf5TPHnrSjqTXbmg+01oeMKes6LRSVYawaUL3/bmaJKkwA5oBEsj/exO2l
         up0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mE5gZc6viG/xXOsPF+F+4EMY6E1n4H7xrKSm+Ny0wU=;
        b=fQAEpIAIY4/972M/rjETXMwwrTC+wlq6P017zU/BeC2cHd51GCYSAhQLJvZb36q7b3
         njr7zscQNA3cVJOnprJy0/L2HaOE+1qM7KCDX58293s5vxAwxIOIlwHB+sV6aMpKuxjJ
         0uYaqSaHW0b9W5UmVw3LM4qhwdKJWdTt5a83utJd+ubl6GPwhgX1c1cv3tLUb6ahB3xI
         aSvGw2OAPna9+GRIwRtALOzZntowEuc8FYH2HHrwSLlDkjR9blV91P60fZp0ZMKdNpvb
         bKqPmIjLjuQvip/HswnwKf6JM2rmgwWQzdr4T9a74S5A9XogphSj4HyA5uvMvcWtwPHG
         mbDg==
X-Gm-Message-State: AO0yUKUsSBqrcysCXtQjrnm+h07/AXVZKBUVbk+J7rc4Jf/N8BbN613S
        otj6CuLVCEElKZM8rlQGoyyR4A==
X-Google-Smtp-Source: AK7set9nqaifHxGsTvMKC77HnKFJJaZIb/iugkiKGlhVtmtoXmZ+i/7pzOdwMnhvj2jkpONQrSu7GA==
X-Received: by 2002:a05:6402:31fb:b0:4ac:d2bc:32f9 with SMTP id dy27-20020a05640231fb00b004acd2bc32f9mr24372223edb.4.1677504520550;
        Mon, 27 Feb 2023 05:28:40 -0800 (PST)
Received: from localhost ([194.62.217.2])
        by smtp.gmail.com with ESMTPSA id jj22-20020a170907985600b008b17879ec95sm3206035ejc.22.2023.02.27.05.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 05:28:40 -0800 (PST)
References: <20230224-rust-error-v1-0-f8f9a9a87303@asahilina.net>
 <20230224-rust-error-v1-2-f8f9a9a87303@asahilina.net>
User-agent: mu4e 1.9.18; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Asahi Lina <lina@asahilina.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH 2/5] rust: error: Add Error::from_kernel_errno()
Date:   Mon, 27 Feb 2023 14:27:44 +0100
In-reply-to: <20230224-rust-error-v1-2-f8f9a9a87303@asahilina.net>
Message-ID: <87edqb9r08.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Asahi Lina <lina@asahilina.net> writes:

> From: Miguel Ojeda <ojeda@kernel.org>
>
> Add a function to create `Error` values out of a kernel error return,
> which safely upholds the invariant that the error code is well-formed
> (negative and greater than -MAX_ERRNO). If a malformed code is passed
> in, it will be converted to EINVAL.
>
> Lina: Imported from rust-for-linux/rust as authored by Miguel and Fox
> with refactoring from Wedson.
>
> Co-developed-by: Fox Chen <foxhlchen@gmail.com>
> Signed-off-by: Fox Chen <foxhlchen@gmail.com>
> Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>

>  rust/kernel/error.rs | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 8611758e27f4..3b439fdb405c 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -72,6 +72,25 @@ pub mod code {
>  pub struct Error(core::ffi::c_int);
>  
>  impl Error {
> +    /// Creates an [`Error`] from a kernel error code.
> +    ///
> +    /// It is a bug to pass an out-of-range `errno`. `EINVAL` would
> +    /// be returned in such a case.
> +    pub(crate) fn from_kernel_errno(errno: core::ffi::c_int) -> Error {
> +        if errno < -(bindings::MAX_ERRNO as i32) || errno >= 0 {
> +            // TODO: Make it a `WARN_ONCE` once available.
> +            crate::pr_warn!(
> +                "attempted to create `Error` with out of range `errno`: {}",
> +                errno
> +            );
> +            return code::EINVAL;
> +        }
> +
> +        // INVARIANT: The check above ensures the type invariant
> +        // will hold.
> +        Error(errno)
> +    }
> +
>      /// Returns the kernel error code.
>      pub fn to_kernel_errno(self) -> core::ffi::c_int {
>          self.0

