Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CC36ED047
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 16:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjDXOZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 10:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjDXOZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 10:25:42 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BBF3598;
        Mon, 24 Apr 2023 07:25:41 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1878560f69cso3200384fac.1;
        Mon, 24 Apr 2023 07:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682346340; x=1684938340;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jS4zaQqcPkNp7M88XvyrTeX0TNUIx13eFiunuAfe8Gk=;
        b=bWamxTgEtEPof8g2gvxIpztfjws1hLO3qmNdkgEG5wJO+NWhdycLvdemgrR0dNB7wu
         EJCSWu4ExVsWpZNe8tHB8i8jMtxUwkO7gdTwtfR0vSi5Mvmnpm6Nd1B0yE0pSj0t6bKe
         XuCX1IyqfnBOxJSn4k40tnOg0Sq+mifXXSzYnOTFjwaQcg9UfdHR24mw+Q2jptFb4ZtT
         k0cvWSOQ4iY0iUcWHFNkMn24RnkkZyeswST6OfdbT6YXNDRw47XM6F4bZbnb3s5FTEq0
         rrMg26llwtAwBV39nipsxVN/yAqCPUryroQMQ1sSRFTu0d2aYLy3UEFfI+r3mrutfM27
         BAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682346340; x=1684938340;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jS4zaQqcPkNp7M88XvyrTeX0TNUIx13eFiunuAfe8Gk=;
        b=RJfbkRcnKSjOPIPJ67foUAvvHKrbXbxeknPxLKo4pPhUbRV+l4C+Qn5ZKNAc/myyc8
         j/5k6g7uwvjmNfEAEF5L1M8OWJXeScKISrbD8pyEl93wHuRkMr+l6hLJZBUmzxjgo5kT
         KvbUyioTd1K1kaDITmodVROeIG68KsxyGQTC4D4xCDRu+kKuLV2lfBrNiFpQrnwoD6Xf
         lFAom/qiyXRUBkbCOLl9VOR6dRyI7iTn1o155XyEcyrlxqz78P5QueIJNDsUGhL2xypV
         THiDXimhQ99TulXYHOdTLABEqtrPIIk61w0P1FChc8bEgnUvtMxL0WXg/F/CzsLdDBYp
         js4Q==
X-Gm-Message-State: AAQBX9c8NTgypiHZ/yy+4P8jZ+KwnGCH/N+pj6HqIDbi1l1aMvZsPmNw
        5BWzKEfSWhH5MACs3WM+AVY=
X-Google-Smtp-Source: AKy350YUky1Ah+S8bAyZmQVXXdafkGtTGngGunTmbNzzsklDg7fIauaxwQQNVH9tGpcq/6GL7NFxfQ==
X-Received: by 2002:a05:6870:214:b0:18b:1d56:b846 with SMTP id j20-20020a056870021400b0018b1d56b846mr9400542oad.48.1682346340437;
        Mon, 24 Apr 2023 07:25:40 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id e7-20020a056870920700b0016b0369f08fsm4531014oaf.15.2023.04.24.07.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 07:25:40 -0700 (PDT)
Message-ID: <350adcd2-e26e-6b6c-fee5-063cf5540a52@gmail.com>
Date:   Mon, 24 Apr 2023 10:01:23 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/4] rust: macros: refactor generics parsing of
 `#[pin_data]` into its own function
Content-Language: en-US
To:     Benno Lossin <benno.lossin@proton.me>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
References: <20230424081112.99890-1-benno.lossin@proton.me>
 <20230424081112.99890-2-benno.lossin@proton.me>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230424081112.99890-2-benno.lossin@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/23 05:11, Benno Lossin wrote:
> Other macros might also want to parse generics. Additionally this makes
> the code easier to read, as the next commit will introduce more code in
> `#[pin_data]`. Also add more comments to explain how parsing generics
> work.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
>  rust/macros/helpers.rs  | 86 ++++++++++++++++++++++++++++++++++++++++-
>  rust/macros/pin_data.rs | 70 +++++----------------------------
>  2 files changed, 94 insertions(+), 62 deletions(-)
> 
> diff --git a/rust/macros/helpers.rs b/rust/macros/helpers.rs
> index b2bdd4d8c958..afb0f2e3a36a 100644
> --- a/rust/macros/helpers.rs
> +++ b/rust/macros/helpers.rs
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
> 
> -use proc_macro::{token_stream, Group, TokenTree};
> +use proc_macro::{token_stream, Group, Punct, Spacing, TokenStream, TokenTree};
> 
>  pub(crate) fn try_ident(it: &mut token_stream::IntoIter) -> Option<String> {
>      if let Some(TokenTree::Ident(ident)) = it.next() {
> @@ -69,3 +69,87 @@ pub(crate) fn expect_end(it: &mut token_stream::IntoIter) {
>          panic!("Expected end");
>      }
>  }
> +
> +pub(crate) struct Generics {
> +    pub(crate) impl_generics: Vec<TokenTree>,
> +    pub(crate) ty_generics: Vec<TokenTree>,
> +}
> +
> +/// Parses the given `TokenStream` into `Generics` and the rest.
> +///
> +/// The generics are not present in the rest, but a where clause might remain.
> +pub(crate) fn parse_generics(input: TokenStream) -> (Generics, Vec<TokenTree>) {
> +    // `impl_generics`, the declared generics with their bounds.
> +    let mut impl_generics = vec![];
> +    // Only the names of the generics, without any bounds.
> +    let mut ty_generics = vec![];
> +    // Tokens not related to the generics e.g. the `where` token and definition.
> +    let mut rest = vec![];
> +    // The current level of `<`.
> +    let mut nesting = 0;
> +    let mut toks = input.into_iter();
> +    // If we are at the beginning of a generic parameter.
> +    let mut at_start = true;
> +    for tt in &mut toks {
> +        match tt.clone() {
> +            TokenTree::Punct(p) if p.as_char() == '<' => {
> +                if nesting >= 1 {
> +                    // This is inside of the generics and part of some bound.
> +                    impl_generics.push(tt);
> +                }
> +                nesting += 1;
> +            }
> +            TokenTree::Punct(p) if p.as_char() == '>' => {
> +                // This is a parsing error, so we just end it here.
> +                if nesting == 0 {
> +                    break;
> +                } else {
> +                    nesting -= 1;
> +                    if nesting >= 1 {
> +                        // We are still inside of the generics and part of some bound.
> +                        impl_generics.push(tt);
> +                    }
> +                    if nesting == 0 {
> +                        break;
> +                    }
> +                }
> +            }
> +            tt => {
> +                if nesting == 1 {
> +                    // Here depending on the token, it might be a generic variable name.
> +                    match &tt {
> +                        // Ignore const.
> +                        TokenTree::Ident(i) if i.to_string() == "const" => {}
> +                        TokenTree::Ident(_) if at_start => {
> +                            ty_generics.push(tt.clone());
> +                            // We also already push the `,` token, this makes it easier to append
> +                            // generics.
> +                            ty_generics.push(TokenTree::Punct(Punct::new(',', Spacing::Alone)));
> +                            at_start = false;
> +                        }
> +                        TokenTree::Punct(p) if p.as_char() == ',' => at_start = true,
> +                        // Lifetimes begin with `'`.
> +                        TokenTree::Punct(p) if p.as_char() == '\'' && at_start => {
> +                            ty_generics.push(tt.clone());
> +                        }
> +                        _ => {}
> +                    }
> +                }
> +                if nesting >= 1 {
> +                    impl_generics.push(tt);
> +                } else if nesting == 0 {
> +                    // If we haven't entered the generics yet, we still want to keep these tokens.
> +                    rest.push(tt);
> +                }
> +            }
> +        }
> +    }
> +    rest.extend(toks);
> +    (
> +        Generics {
> +            impl_generics,
> +            ty_generics,
> +        },
> +        rest,
> +    )
> +}
> diff --git a/rust/macros/pin_data.rs b/rust/macros/pin_data.rs
> index 954149d77181..c593b05d9e8c 100644
> --- a/rust/macros/pin_data.rs
> +++ b/rust/macros/pin_data.rs
> @@ -1,71 +1,19 @@
>  // SPDX-License-Identifier: Apache-2.0 OR MIT
> 
> -use proc_macro::{Punct, Spacing, TokenStream, TokenTree};
> +use crate::helpers::{parse_generics, Generics};
> +use proc_macro::TokenStream;
> 
>  pub(crate) fn pin_data(args: TokenStream, input: TokenStream) -> TokenStream {
>      // This proc-macro only does some pre-parsing and then delegates the actual parsing to
>      // `kernel::__pin_data!`.
> -    //
> -    // In here we only collect the generics, since parsing them in declarative macros is very
> -    // elaborate. We also do not need to analyse their structure, we only need to collect them.
> 
> -    // `impl_generics`, the declared generics with their bounds.
> -    let mut impl_generics = vec![];
> -    // Only the names of the generics, without any bounds.
> -    let mut ty_generics = vec![];
> -    // Tokens not related to the generics e.g. the `impl` token.
> -    let mut rest = vec![];
> -    // The current level of `<`.
> -    let mut nesting = 0;
> -    let mut toks = input.into_iter();
> -    // If we are at the beginning of a generic parameter.
> -    let mut at_start = true;
> -    for tt in &mut toks {
> -        match tt.clone() {
> -            TokenTree::Punct(p) if p.as_char() == '<' => {
> -                if nesting >= 1 {
> -                    impl_generics.push(tt);
> -                }
> -                nesting += 1;
> -            }
> -            TokenTree::Punct(p) if p.as_char() == '>' => {
> -                if nesting == 0 {
> -                    break;
> -                } else {
> -                    nesting -= 1;
> -                    if nesting >= 1 {
> -                        impl_generics.push(tt);
> -                    }
> -                    if nesting == 0 {
> -                        break;
> -                    }
> -                }
> -            }
> -            tt => {
> -                if nesting == 1 {
> -                    match &tt {
> -                        TokenTree::Ident(i) if i.to_string() == "const" => {}
> -                        TokenTree::Ident(_) if at_start => {
> -                            ty_generics.push(tt.clone());
> -                            ty_generics.push(TokenTree::Punct(Punct::new(',', Spacing::Alone)));
> -                            at_start = false;
> -                        }
> -                        TokenTree::Punct(p) if p.as_char() == ',' => at_start = true,
> -                        TokenTree::Punct(p) if p.as_char() == '\'' && at_start => {
> -                            ty_generics.push(tt.clone());
> -                        }
> -                        _ => {}
> -                    }
> -                }
> -                if nesting >= 1 {
> -                    impl_generics.push(tt);
> -                } else if nesting == 0 {
> -                    rest.push(tt);
> -                }
> -            }
> -        }
> -    }
> -    rest.extend(toks);
> +    let (
> +        Generics {
> +            impl_generics,
> +            ty_generics,
> +        },
> +        mut rest,
> +    ) = parse_generics(input);
>      // This should be the body of the struct `{...}`.
>      let last = rest.pop();
>      quote!(::kernel::__pin_data! {
> --
> 2.40.0
> 
> 

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
