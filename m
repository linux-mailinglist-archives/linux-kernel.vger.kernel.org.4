Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A35663202
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237740AbjAIU4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237670AbjAIUz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:55:59 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0213887F32
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:54:36 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id d10so6734959pgm.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 12:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bCpbMmW0eLev9FdtuyFUocFIcOdmXfyBWebTqFK5CIA=;
        b=h4agD+4jNY3gjy2SULguao1y1SDRTBALR9O8Bjx0eLoYRsDA2ETD9q9AMY5zysnq+q
         6GujFw61YQklfxifLoM25/Qx27WxO+muJS7gQ2/y584ocSmZlbkb+YerHNikmmopMt8Q
         8rlV/PMlrHVvPBQwSUX45mQgkl/lnEsPItg7VmFwxpKVkQ0wxzMolPIiKpSrMm9vWf91
         BdnidegVeoi+AAnpJEtgYYuR8Hj6cvvQ4gLOYJJiMwV7jAU647pgrMmjixSWC4tlr/XH
         6G2iG/BNRvOLrlnG/a3jkymflXl2P3YV8Dio+cecoWhApoEiT0ZHCb/LmhkfF6l0Q1eF
         Zn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bCpbMmW0eLev9FdtuyFUocFIcOdmXfyBWebTqFK5CIA=;
        b=XOmLmtr095cbP+RFBAIcGFfulcjSMrYgqXWfGZrGb0xTU0sSgzmBeDksPMxy2ZtAdI
         fMHbt/agj7Ph1QdbDQqRIjzW/+ebpaNfPPJWVwSVmxCf+6JX4RsmpQC5o05tVfJIU2yU
         dXN+wshtIqjCmPafOPyIBlEIt3WfZBMF6PEfKLiNSOZZ8TS6O/MklTbLKPiNyQZwP44G
         MR6XCiZ2IqI6rZin3mcQdWBuKGl8u5NG6J4MFhI93Ys9/+o8PXhlTXEvl15i2wn5aAM6
         455g20t4r+4au0GT246JXdu7CeqSRcS1Qw/UizknQDrfjZ2rqxhX1lZPCisWk1ZS3t6J
         EVaw==
X-Gm-Message-State: AFqh2kpyE/ICdUXkuTFt8EZf+edIMt/w1gsBzUs8Osd92w/nEDpgCEt3
        tmwAVa1PP+sKgm3vt/m13ggvcFJcx0axUqWRxqX9Ig==
X-Google-Smtp-Source: AMrXdXtJwhfbhqPtlK+wteYA6wJbhqZXNYUZFPHzEbZJNaISXYOe+1yfLa+PUkvrtxjs8n0M+KBV1ndODf+qq8fq670=
X-Received: by 2002:aa7:914e:0:b0:578:202d:a33a with SMTP id
 14-20020aa7914e000000b00578202da33amr3345635pfi.23.1673297676007; Mon, 09 Jan
 2023 12:54:36 -0800 (PST)
MIME-Version: 1.0
References: <20230109204520.539080-1-ojeda@kernel.org>
In-Reply-To: <20230109204520.539080-1-ojeda@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 9 Jan 2023 12:54:24 -0800
Message-ID: <CAKwvOdkr6mAdNOkZqGdkosAN6JABHRU3bHg=K8ujjbw2GxEsKQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] docs: rust: add paragraph about finding a suitable `libclang`
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
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

On Mon, Jan 9, 2023 at 12:45 PM Miguel Ojeda <ojeda@kernel.org> wrote:
>
> Sometimes users need to tweak the finding process of `libclang`
> for `bindgen` via the `clang-sys`-provided environment variables.
>
> Thus add a paragraph to the setting up guide, including a reference
> to `clang-sys`'s relevant documentation.
>
> Link: https://lore.kernel.org/rust-for-linux/CAKwvOdm5JT4wbdQQYuW+RT07rCi6whGBM2iUAyg8A1CmLXG6Nw@mail.gmail.com/
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

This is super helpful for me, since I build clang from source and
would like to use my libclang.so! Thanks for this documentation
Miguel!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  Documentation/rust/quick-start.rst | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/Documentation/rust/quick-start.rst b/Documentation/rust/quick-start.rst
> index 13b7744b1e27..cae21ea7de41 100644
> --- a/Documentation/rust/quick-start.rst
> +++ b/Documentation/rust/quick-start.rst
> @@ -100,6 +100,23 @@ Install it via (note that this will download and build the tool from source)::
>
>         cargo install --locked --version $(scripts/min-tool-version.sh bindgen) bindgen
>
> +``bindgen`` needs to find a suitable ``libclang`` in order to work. If it is
> +not found (or a different ``libclang`` than the one found should be used),
> +the process can be tweaked using the environment variables understood by
> +``clang-sys`` (the Rust bindings crate that ``bindgen`` uses to access
> +``libclang``):
> +
> +* ``LLVM_CONFIG_PATH`` can be pointed to an ``llvm-config`` executable.
> +
> +* Or ``LIBCLANG_PATH`` can be pointed to a ``libclang`` shared library
> +  or to the directoy containing it.
> +
> +* Or ``CLANG_PATH`` can be pointed to a ``clang`` executable.
> +
> +For details, please see ``clang-sys``'s documentation at:
> +
> +       https://github.com/KyleMayes/clang-sys#environment-variables
> +
>
>  Requirements: Developing
>  ------------------------
> --
> 2.39.0
>


-- 
Thanks,
~Nick Desaulniers
