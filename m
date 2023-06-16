Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52830733724
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 19:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345528AbjFPRHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 13:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjFPRHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 13:07:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2A81BC3;
        Fri, 16 Jun 2023 10:07:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10A8761EFB;
        Fri, 16 Jun 2023 17:07:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4DDC433C0;
        Fri, 16 Jun 2023 17:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686935223;
        bh=ANYkmBJGUK3gxGc6i6+SY4srcN3mW7UlL+HWDMqvql4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tkwlJyy+ithOeGX55qP22gsPP8xYfhBsmhhjjzi1BAu26df1sHKyOdzmQJjopZEts
         Ke16g5xnhJ95uYc8EGRdG0h5R7jrEPkAx1lseksGYwRWCSK6WAV0KwtRrkrwC+C8dl
         8SMzwnGIy5+5eRx/FIydAdNDT7ea13hzI0KSyObCzhfGwswwloAqYTRcr96YRWDasI
         DXy23rokJ31kdc4/TkBwUkLoYePPfABueB8t3/QWAeZah9URjt6wx5Owy6LbJgDDRJ
         YSxUA4CGAqOTwW3tBb82tYKws6ZXeCsh2HT0ZZFPzxGT5iflr+eQly5iwGip0E6J68
         f4UmAd8oVJWgw==
Date:   Fri, 16 Jun 2023 10:07:00 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        linux-kbuild@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v2 03/11] docs: rust: add paragraph about finding a
 suitable `libclang`
Message-ID: <20230616170700.GB3474164@dev-arch.thelio-3990X>
References: <20230616001631.463536-1-ojeda@kernel.org>
 <20230616001631.463536-4-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616001631.463536-4-ojeda@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 02:16:23AM +0200, Miguel Ojeda wrote:
> Sometimes users need to tweak the finding process of `libclang`
> for `bindgen` via the `clang-sys`-provided environment variables.
> 
> Thus add a paragraph to the setting up guide, including a reference
> to `clang-sys`'s relevant documentation.
> 
> Link: https://lore.kernel.org/rust-for-linux/CAKwvOdm5JT4wbdQQYuW+RT07rCi6whGBM2iUAyg8A1CmLXG6Nw@mail.gmail.com/
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  Documentation/rust/quick-start.rst | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/rust/quick-start.rst b/Documentation/rust/quick-start.rst
> index 13b7744b1e27..a635be69e062 100644
> --- a/Documentation/rust/quick-start.rst
> +++ b/Documentation/rust/quick-start.rst
> @@ -100,6 +100,23 @@ Install it via (note that this will download and build the tool from source)::
>  
>  	cargo install --locked --version $(scripts/min-tool-version.sh bindgen) bindgen
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
> +  or to the directory containing it.
> +
> +* Or ``CLANG_PATH`` can be pointed to a ``clang`` executable.
> +
> +For details, please see ``clang-sys``'s documentation at:
> +
> +	https://github.com/KyleMayes/clang-sys#environment-variables
> +
>  
>  Requirements: Developing
>  ------------------------
> -- 
> 2.41.0
> 
