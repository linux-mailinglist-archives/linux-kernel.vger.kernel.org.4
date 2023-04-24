Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40AD16ED049
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 16:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjDXO0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 10:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjDXOZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 10:25:48 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D848A61;
        Mon, 24 Apr 2023 07:25:46 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-187fc21f6acso1549148fac.2;
        Mon, 24 Apr 2023 07:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682346346; x=1684938346;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GcDTPzyvQk0uhldGo/zvt1Ts91eOwZogXhIoFNClOuU=;
        b=gpxAkDg3asrgdw8QBqLXY9DCnRkT5S7sBtlXIuw5ds4UB+Qo/yh1EZndIo21PAtx8+
         RSbQZKKBXJz2S3YJ1od0peZOqb4OOk9MVs7/z86R6mezbacNJUVng9pgZREmTrPCpVZV
         O7T3rqbqL0GzIjVKjFkPabdzPsiT06HFwTUcH/vdPMwXQHbHiO1HDsF5QJSvx9acy6ff
         HGdkbCBewnQ4AwQM5Cshvw7Pq+J4CwWkoC8dc6mSZguM95llUlMqIC0/RlgmXifJUI1J
         plLYhsREulKYS+KrWTvUogNTUhSr4v9k6dmEMYtqtMVkfH3OT0H8EnjXR4sSKSjHsNyf
         Mgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682346346; x=1684938346;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GcDTPzyvQk0uhldGo/zvt1Ts91eOwZogXhIoFNClOuU=;
        b=ceaFrINkXzBukS3XqhCIkOexXycOUZd3qvNPEmbAGQz6nrN/llM7tGg0a/jcfIxTxr
         WnzQNqE4Cb+wYvWY22ZfhcSUfpcCFHK6VCXQ6WKGTDOU96YKepIXChPkrMHGGzBM/pvG
         +9NPGGnpviOfyGZ6Pb+xvSgAMd0SnaFmxsFE3udf5kHeO3EIQIWDr6caNXFe+dFGbBis
         dJCYXMGy6CHSj4+hk6gZ4v6QtZFe70VApKzoGqnhqKpfOJyQxZYiBTGJ3udazMBMMh7i
         B9oNo+R4P+Ulz2PSEzIqgI+RIXeeYsEX7HIWyeWpl0j9k6i6fXU9Jh3LuSSfPATYeC5I
         hCbA==
X-Gm-Message-State: AAQBX9e5XCmvObqmYyGJV+cGqvoN1E81Mt0UBE9d1+6WLg+CSYZvc+/a
        8+Gu1lZvI6jBxUhQ0nsuXuw=
X-Google-Smtp-Source: AKy350YNX1CMaoKBD8mQBKxTmnTyUwvWCnJy95q2RtMrjuCScamX3wwGEZTMhl1FHOO/OUjqihSL7g==
X-Received: by 2002:a05:6871:690:b0:17e:9b7:387b with SMTP id l16-20020a056871069000b0017e09b7387bmr9677795oao.11.1682346345848;
        Mon, 24 Apr 2023 07:25:45 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id z137-20020a4a498f000000b00545442d89b3sm4934732ooa.23.2023.04.24.07.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 07:25:45 -0700 (PDT)
Message-ID: <b7f39b6a-8db2-5f7c-293d-2d41815b157e@gmail.com>
Date:   Mon, 24 Apr 2023 11:21:53 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/4] rust: macros: replace Self with the concrete type in
 #[pin_data]
Content-Language: en-US
To:     Benno Lossin <benno.lossin@proton.me>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Alice Ryhl <aliceryhl@google.com>
References: <20230424081112.99890-1-benno.lossin@proton.me>
 <20230424081112.99890-3-benno.lossin@proton.me>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230424081112.99890-3-benno.lossin@proton.me>
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
> When using `#[pin_data]` on a struct that used `Self` in the field
> types, a type error would be emitted when trying to use `pin_init!`.
> Since an internal type would be referenced by `Self` instead of the
> defined struct.
> This patch fixes this issue by replacing all occurrences of `Self` in
> the `#[pin_data]` macro with the concrete type circumventing the issue.
> Since rust allows type definitions inside of blocks, which are
> expressions, the macro also checks for these and emits a compile error
> when it finds `trait`, `enum`, `union`, `struct` or `impl`. These
> keywords allow creating new `Self` contexts, which conflicts with the
> current implementation of replacing every `Self` ident. If these were
> allowed, some `Self` idents would be replaced incorrectly.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> Reported-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/macros/pin_data.rs | 108 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 104 insertions(+), 4 deletions(-)
> 
> diff --git a/rust/macros/pin_data.rs b/rust/macros/pin_data.rs
> index c593b05d9e8c..6d58cfda9872 100644
> --- a/rust/macros/pin_data.rs
> +++ b/rust/macros/pin_data.rs
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: Apache-2.0 OR MIT
> 
>  use crate::helpers::{parse_generics, Generics};
> -use proc_macro::TokenStream;
> +use proc_macro::{Group, Punct, Spacing, TokenStream, TokenTree};
> 
>  pub(crate) fn pin_data(args: TokenStream, input: TokenStream) -> TokenStream {
>      // This proc-macro only does some pre-parsing and then delegates the actual parsing to
> @@ -12,16 +12,116 @@ pub(crate) fn pin_data(args: TokenStream, input: TokenStream) -> TokenStream {
>              impl_generics,
>              ty_generics,
>          },
> -        mut rest,
> +        rest,
>      ) = parse_generics(input);
> +    // The struct definition might contain the `Self` type. Since `__pin_data!` will define a new
> +    // type with the same generics and bounds, this poses a problem, since `Self` will refer to the
> +    // new type as opposed to this struct definition. Therefore we have to replace `Self` with the
> +    // concrete name.
> +
> +    // Errors that occur when replacing `Self` with `struct_name`.
> +    let mut errs = TokenStream::new();
> +    // The name of the struct with ty_generics.
> +    let struct_name = rest
> +        .iter()
> +        .skip_while(|tt| !matches!(tt, TokenTree::Ident(i) if i.to_string() == "struct"))
> +        .nth(1)
> +        .and_then(|tt| match tt {
> +            TokenTree::Ident(_) => {
> +                let tt = tt.clone();
> +                let mut res = vec![tt];
> +                if !ty_generics.is_empty() {
> +                    // We add this, so it is maximally compatible with e.g. `Self::CONST` which
> +                    // will be replaced by `StructName::<$generics>::CONST`.
> +                    res.push(TokenTree::Punct(Punct::new(':', Spacing::Joint)));
> +                    res.push(TokenTree::Punct(Punct::new(':', Spacing::Alone)));
> +                    res.push(TokenTree::Punct(Punct::new('<', Spacing::Alone)));
> +                    res.extend(ty_generics.iter().cloned());
> +                    res.push(TokenTree::Punct(Punct::new('>', Spacing::Alone)));
> +                }
> +                Some(res)
> +            }
> +            _ => None,
> +        })
> +        .unwrap_or_else(|| {
> +            // If we did not find the name of the struct then we will use `Self` as the replacement
> +            // and add a compile error to ensure it does not compile.
> +            errs.extend(
> +                "::core::compile_error!(\"Could not locate type name.\");"
> +                    .parse::<TokenStream>()
> +                    .unwrap(),
> +            );
> +            "Self".parse::<TokenStream>().unwrap().into_iter().collect()
> +        });
> +    let impl_generics = impl_generics
> +        .into_iter()
> +        .flat_map(|tt| replace_self_and_deny_type_defs(&struct_name, tt, &mut errs))
> +        .collect::<Vec<_>>();
> +    let mut rest = rest
> +        .into_iter()
> +        .flat_map(|tt| {
> +            // We ignore top level `struct` tokens, since they would emit a compile error.
> +            if matches!(&tt, TokenTree::Ident(i) if i.to_string() == "struct") {
> +                vec![tt]
> +            } else {
> +                replace_self_and_deny_type_defs(&struct_name, tt, &mut errs)
> +            }
> +        })
> +        .collect::<Vec<_>>();
>      // This should be the body of the struct `{...}`.
>      let last = rest.pop();
> -    quote!(::kernel::__pin_data! {
> +    let mut quoted = quote!(::kernel::__pin_data! {
>          parse_input:
>          @args(#args),
>          @sig(#(#rest)*),
>          @impl_generics(#(#impl_generics)*),
>          @ty_generics(#(#ty_generics)*),
>          @body(#last),
> -    })
> +    });
> +    quoted.extend(errs);
> +    quoted
> +}
> +
> +/// Replaces `Self` with `struct_name` and errors on `enum`, `trait`, `struct` `union` and `impl`
> +/// keywords.
> +///
> +/// The error is appended to `errs` to allow normal parsing to continue.
> +fn replace_self_and_deny_type_defs(
> +    struct_name: &Vec<TokenTree>,
> +    tt: TokenTree,
> +    errs: &mut TokenStream,
> +) -> Vec<TokenTree> {
> +    match tt {
> +        TokenTree::Ident(ref i)
> +            if i.to_string() == "enum"
> +                || i.to_string() == "trait"
> +                || i.to_string() == "struct"
> +                || i.to_string() == "union"
> +                || i.to_string() == "impl" =>
> +        {
> +            errs.extend(
> +                format!(
> +                    "::core::compile_error!(\"Cannot use `{i}` inside of struct definition with \
> +                        `#[pin_data]`.\");"
> +                )
> +                .parse::<TokenStream>()
> +                .unwrap()
> +                .into_iter()
> +                .map(|mut tok| {
> +                    tok.set_span(tt.span());
> +                    tok
> +                }),
> +            );
> +            vec![tt]
> +        }
> +        TokenTree::Ident(i) if i.to_string() == "Self" => struct_name.clone(),
> +        TokenTree::Literal(_) | TokenTree::Punct(_) | TokenTree::Ident(_) => vec![tt],
> +        TokenTree::Group(g) => vec![TokenTree::Group(Group::new(
> +            g.delimiter(),
> +            g.stream()
> +                .into_iter()
> +                .flat_map(|tt| replace_self_and_deny_type_defs(struct_name, tt, errs))
> +                .collect(),
> +        ))],
> +    }
>  }
> --
> 2.40.0
> 
> 

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
