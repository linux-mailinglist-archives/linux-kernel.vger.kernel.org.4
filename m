Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EED6D0441
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 14:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjC3MDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 08:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjC3MDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 08:03:07 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193F64204
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 05:03:06 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so11588501wmq.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 05:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112; t=1680177784;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=aDhiTImEy8g6luxO+RzLJfBSTXKM3IhPiycrVlIdxhI=;
        b=f+PugFily1kZ+Fvc1V52KTsyl/9YhHJAmNobFbz60ZeToSkwFYRXhsR5hevIQvsOBw
         iAoEJPQLTkkjAArcl0wmdXFWVXq6ea23bWTks2k3S85wPiKRphWT9J1iLIljSJBjyBdV
         Mw5R00uP7gIQ5+B99dgkSUKwLx3n3sq6M67DhRvWj7tfv1f9xQSGwdDQAM+9girnCzNL
         2xd1ZHIMpgkJHEizNy1XG/RpzYz3rPh5RTReDA1tLmy/nk3FEOEvuC7P/+uZcQKS+iix
         46ftS8llwdWlj0OEFSagJb15jC0/6ayycoqGKDF1sLeASyEd5iZi4pk5D72aAhv7LEDv
         1BnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680177784;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDhiTImEy8g6luxO+RzLJfBSTXKM3IhPiycrVlIdxhI=;
        b=sfEMITbnc37AQYRzBcfeUZEBo9fJ6sruHIWTHdmkhXOAPzKjruLr6muri25Lz7Rb/N
         z4E31Z6tmiTSSKvPt5GyMp1zHbEVdA3Yt0arOQeVCV0rWvQRO7GS5BBQgSYTxKXOcO+z
         Au3mQWMd/xCXG7MGEX8+Npc3MBTiuL0rG20rEYgaLlvBm80y3Hy0AXHOiWAoa33pvPtw
         KTIHhNvrqlSt5EvTbVpHi2LsOBf9vme/KnrVaiN/2xH5BokgV7CR3MTX3dFszB352IzJ
         2CpwfBovBJiq1wbjwrfvhdaokpDpy52XyKOXy95/pMOaQcMUQgXCa+gTDXo5YVVw/WJ0
         K6kw==
X-Gm-Message-State: AO0yUKXxfXs8ChYS+rtOx1vglvvy7C7+yGIQN7wWm9Diz5p88gXEDiWj
        h8JXVWKaxMrXxZF8au0UzL2spQ==
X-Google-Smtp-Source: AK7set97KAJhfM8PBq4MPaXeNclKkaCf8DiLP2D62aeASwc61kH8n6I0i86fuHqdrnK+cHoD77xg7g==
X-Received: by 2002:a1c:7206:0:b0:3ed:2352:eebd with SMTP id n6-20020a1c7206000000b003ed2352eebdmr18179525wmc.11.1680177784507;
        Thu, 30 Mar 2023 05:03:04 -0700 (PDT)
Received: from localhost ([165.225.194.221])
        by smtp.gmail.com with ESMTPSA id a13-20020a05600c224d00b003edef091b17sm5670855wmm.37.2023.03.30.05.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 05:03:04 -0700 (PDT)
References: <20230329223239.138757-1-y86-dev@protonmail.com>
 <20230329223239.138757-2-y86-dev@protonmail.com>
 <877cuy5ur2.fsf@metaspace.dk>
User-agent: mu4e 1.9.18; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Andreas Hindborg <nmi@metaspace.dk>
Cc:     y86-dev@protonmail.com, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj?= =?utf-8?Q?=C3=B6rn?= Roy Baron 
        <bjorn3_gh@protonmail.com>, Alice Ryhl <alice@ryhl.io>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v3 01/13] rust: macros: add `quote!` macro
Date:   Thu, 30 Mar 2023 14:01:21 +0200
In-reply-to: <877cuy5ur2.fsf@metaspace.dk>
Message-ID: <87355m5tvs.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Andreas Hindborg <nmi@metaspace.dk> writes:

> y86-dev@protonmail.com writes:
>
>> From: Gary Guo <gary@garyguo.net>
>>
>> Add the `quote!` macro for creating `TokenStream`s directly via the
>> given Rust tokens. It also supports repetitions using iterators.
>>
>> It will be used by the pin-init API proc-macros to generate code.
>>
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
>> ---
>>  rust/macros/lib.rs   |   2 +
>>  rust/macros/quote.rs | 145 +++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 147 insertions(+)
>>  create mode 100644 rust/macros/quote.rs
>>
>> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
>> index c1d385e345b9..82b520f024dd 100644
>> --- a/rust/macros/lib.rs
>> +++ b/rust/macros/lib.rs
>> @@ -2,6 +2,8 @@
>>
>>  //! Crate for all kernel procedural macros.
>>
>> +#[macro_use]
>> +mod quote;
>>  mod concat_idents;
>>  mod helpers;
>>  mod module;
>> diff --git a/rust/macros/quote.rs b/rust/macros/quote.rs
>> new file mode 100644
>> index 000000000000..7efb009c25a9
>> --- /dev/null
>> +++ b/rust/macros/quote.rs
>> @@ -0,0 +1,145 @@
>> +// SPDX-License-Identifier: Apache-2.0 OR MIT
>> +
>> +use proc_macro::{TokenStream, TokenTree};
>> +
>> +pub(crate) trait ToTokens {
>> +    fn to_tokens(&self, tokens: &mut TokenStream);
>> +}
>> +
>> +impl<T: ToTokens> ToTokens for Option<T> {
>> +    fn to_tokens(&self, tokens: &mut TokenStream) {
>> +        if let Some(v) = self {
>> +            v.to_tokens(tokens);
>> +        }
>> +    }
>> +}
>> +
>> +impl ToTokens for proc_macro::Group {
>> +    fn to_tokens(&self, tokens: &mut TokenStream) {
>> +        tokens.extend([TokenTree::from(self.clone())]);
>> +    }
>> +}
>> +
>> +impl ToTokens for TokenTree {
>> +    fn to_tokens(&self, tokens: &mut TokenStream) {
>> +        tokens.extend([self.clone()]);
>> +    }
>> +}
>> +
>> +impl ToTokens for TokenStream {
>> +    fn to_tokens(&self, tokens: &mut TokenStream) {
>> +        tokens.extend(self.clone());
>> +    }
>> +}
>> +
>> +/// Converts tokens into [`proc_macro::TokenStream`] and performs variable interpolations with
>> +/// the given span.
>> +///
>> +/// This is a similar to the
>> +/// [`quote_spanned!`](https://docs.rs/quote/latest/quote/macro.quote_spanned.html) macro from the
>> +/// `quote` crate but provides only just enough functionality needed by the current `macros` crate.
>> +#[allow(unused_macros)]
>> +macro_rules! quote_spanned {
>> +    ($span:expr => $($tt:tt)*) => {
>> +    #[allow(clippy::vec_init_then_push)]
>> +    {
>> +        let mut tokens = Vec::new();
>> +        let span = $span;
>> +        quote_spanned!(@proc tokens span $($tt)*);
>> +        proc_macro::TokenStream::from_iter(tokens)
>
> Should this be `::alloc::vec::Vec` and
> `::proc_macro::TokenStream::from_iter` ?
>
> Best regards,
> Andreas
>
>> +    }};
>> +    (@proc $v:ident $span:ident) => {};
>> +    (@proc $v:ident $span:ident #$id:ident $($tt:tt)*) => {
>> +        let mut ts = proc_macro::TokenStream::new();
>> +        crate::quote::ToTokens::to_tokens(&$id, &mut ts);
>> +        $v.extend(ts.into_iter());
>> +        quote_spanned!(@proc $v $span $($tt)*);
>> +    };
>> +    (@proc $v:ident $span:ident #(#$id:ident)* $($tt:tt)*) => {
>> +        for token in $id {
>> +            let mut ts = proc_macro::TokenStream::new();
>> +            crate::quote::ToTokens::to_tokens(&token, &mut ts);
>> +            $v.extend(ts.into_iter());

Also, could this be without `into_iter()`: `$v.extend(ts)`?

BR Andreas

>> +        }
>> +        quote_spanned!(@proc $v $span $($tt)*);
>> +    };
>> +    (@proc $v:ident $span:ident ( $($inner:tt)* ) $($tt:tt)*) => {
>> +        let mut tokens = Vec::new();
>> +        quote_spanned!(@proc tokens $span $($inner)*);
>> +        $v.push(proc_macro::TokenTree::Group(proc_macro::Group::new(
>> +            proc_macro::Delimiter::Parenthesis,
>> +            proc_macro::TokenStream::from_iter(tokens)
>> +        )));
>> +        quote_spanned!(@proc $v $span $($tt)*);
>> +    };
>> +    (@proc $v:ident $span:ident [ $($inner:tt)* ] $($tt:tt)*) => {
>> +        let mut tokens = Vec::new();
>> +        quote_spanned!(@proc tokens $span $($inner)*);
>> +        $v.push(proc_macro::TokenTree::Group(proc_macro::Group::new(
>> +            proc_macro::Delimiter::Bracket,
>> +            proc_macro::TokenStream::from_iter(tokens)
>> +        )));
>> +        quote_spanned!(@proc $v $span $($tt)*);
>> +    };
>> +    (@proc $v:ident $span:ident { $($inner:tt)* } $($tt:tt)*) => {
>> +        let mut tokens = Vec::new();
>> +        quote_spanned!(@proc tokens $span $($inner)*);
>> +        $v.push(proc_macro::TokenTree::Group(proc_macro::Group::new(
>> +            proc_macro::Delimiter::Brace,
>> +            proc_macro::TokenStream::from_iter(tokens)
>> +        )));
>> +        quote_spanned!(@proc $v $span $($tt)*);
>> +    };
>> +    (@proc $v:ident $span:ident :: $($tt:tt)*) => {
>> +        $v.push(
>> +            proc_macro::TokenTree::Punct(proc_macro::Punct::new(':', proc_macro::Spacing::Joint))
>> +        );
>> +        $v.push(
>> +            proc_macro::TokenTree::Punct(proc_macro::Punct::new(':', proc_macro::Spacing::Alone))
>> +        );
>> +        quote_spanned!(@proc $v $span $($tt)*);
>> +    };
>> +    (@proc $v:ident $span:ident : $($tt:tt)*) => {
>> +        $v.push(
>> +            proc_macro::TokenTree::Punct(proc_macro::Punct::new(':', proc_macro::Spacing::Alone))
>> +        );
>> +        quote_spanned!(@proc $v $span $($tt)*);
>> +    };
>> +    (@proc $v:ident $span:ident , $($tt:tt)*) => {
>> +        $v.push(
>> +            proc_macro::TokenTree::Punct(proc_macro::Punct::new(',', proc_macro::Spacing::Alone))
>> +        );
>> +        quote_spanned!(@proc $v $span $($tt)*);
>> +    };
>> +    (@proc $v:ident $span:ident @ $($tt:tt)*) => {
>> +        $v.push(
>> +            proc_macro::TokenTree::Punct(proc_macro::Punct::new('@', proc_macro::Spacing::Alone))
>> +        );
>> +        quote_spanned!(@proc $v $span $($tt)*);
>> +    };
>> +    (@proc $v:ident $span:ident ! $($tt:tt)*) => {
>> +        $v.push(
>> +            proc_macro::TokenTree::Punct(proc_macro::Punct::new('!', proc_macro::Spacing::Alone))
>> +        );
>> +        quote_spanned!(@proc $v $span $($tt)*);
>> +    };
>> +    (@proc $v:ident $span:ident $id:ident $($tt:tt)*) => {
>> +        $v.push(proc_macro::TokenTree::Ident(proc_macro::Ident::new(stringify!($id), $span)));
>> +        quote_spanned!(@proc $v $span $($tt)*);
>> +    };
>> +}
>> +
>> +/// Converts tokens into [`proc_macro::TokenStream`] and performs variable interpolations with
>> +/// mixed site span ([`Span::mixed_site()`]).
>> +///
>> +/// This is a similar to the [`quote!`](https://docs.rs/quote/latest/quote/macro.quote.html) macro
>> +/// from the `quote` crate but provides only just enough functionality needed by the current
>> +/// `macros` crate.
>> +///
>> +/// [`Span::mixed_site()`]: https://doc.rust-lang.org/proc_macro/struct.Span.html#method.mixed_site
>> +#[allow(unused_macros)]
>> +macro_rules! quote {
>> +    ($($tt:tt)*) => {
>> +        quote_spanned!(proc_macro::Span::mixed_site() => $($tt)*)
>> +    }
>> +}

