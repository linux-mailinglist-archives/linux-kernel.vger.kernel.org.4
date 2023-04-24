Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB3D6ED045
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 16:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjDXOZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 10:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjDXOZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 10:25:37 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D54E49;
        Mon, 24 Apr 2023 07:25:35 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-38ef6217221so179240b6e.3;
        Mon, 24 Apr 2023 07:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682346335; x=1684938335;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wJGVDCXIjtgE8I6jWibO2Fo87Fc+rYRldh8WFmA7WaU=;
        b=Qqn/Ax5fgFOfae1JHcEAGG66Vw46HxxtSXbp7B3UF/BsHmKe4Ddmuf0CfLh810P+nH
         MwDh98queuSq2Et95K4hbY2g4dNxGYNuhmwrACACX2S+ObOJn8FkirKI3Jp/Sf3DcoY3
         QO8Oam/5CSuW88qtnEJvNq2hFeoJV/5RwDLAIwvc/ToOSsulxULVKxh46cWuCOcTkigj
         IIIjz4fMoLdbrpRqtjXhjjY8wBD/8Or0/eZpw/MLpJbzOWU4guVB3Up+3O8fw0wGddXj
         qdKa38QO+nHNYwsii+bN4+ZUhymlVJ4hZz8wyZ3fc4JLjtb/s0BCK9w+TYbA1F67MQpV
         TF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682346335; x=1684938335;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wJGVDCXIjtgE8I6jWibO2Fo87Fc+rYRldh8WFmA7WaU=;
        b=IbzY1DaAkXJeKOCBGvbT9q4CMoRoS7rfg6Y2/effHGapqH/rxt9VWsZ1KevROj9E9y
         KH3pormHjBLHzYuLQesU/D7UpVlQTiJpEbfQuvz34PL/cb7DRxbQ16S4h63LtfjXc3D3
         udGUYdsvongWaCUyFJEe06zm/CRnIXGBs/mfC4Fu7lLiIiwpdiFddBMJlO9hJe65PG63
         6XB+W6mwMP5ulEon8Pj0uiY4gEZhB6vy/LctfewSa6HTImNRP+lqU4scy0CkaXNAOs6c
         t5jsSOidDaXfotVANSV44t4JM+M6dopGGjUmc6wQsLo/8273KyVtp/G2wLHhjZagoicR
         5UBQ==
X-Gm-Message-State: AAQBX9fEmewtntGxdVq+YobQBfJwQtxoZ13auyyqF9WXx8BpTWiI5uBG
        KYgfRDPUkWyuHeHkxMim2zF1hdyvxrg=
X-Google-Smtp-Source: AKy350brU3+Ozqaf2A6AcA6Ll7Tqq6W/V0/5VG+e4MaQcItss5KEdx/Z+K27O74zKygjibhAAMePjw==
X-Received: by 2002:a05:6808:11c8:b0:38b:197b:902 with SMTP id p8-20020a05680811c800b0038b197b0902mr8165054oiv.21.1682346335113;
        Mon, 24 Apr 2023 07:25:35 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id n14-20020a4a954e000000b0053b547ebee7sm4912654ooi.1.2023.04.24.07.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 07:25:34 -0700 (PDT)
Message-ID: <2d8d0157-ab17-944b-eb25-ffac71bd2d80@gmail.com>
Date:   Mon, 24 Apr 2023 09:59:02 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/4] rust: macros: fix usage of `#[allow]` in `quote!`
To:     Benno Lossin <benno.lossin@proton.me>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
References: <20230424081112.99890-1-benno.lossin@proton.me>
Content-Language: en-US
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230424081112.99890-1-benno.lossin@proton.me>
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
> When using `quote!` as part of an expression that was not the last one
> in a function, the `#[allow(clippy::vec_init_then_push)]` attribute
> would be present on an expression, which is not allowed.
> This patch refactors that part of the macro to use a statement instead.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
>  rust/macros/quote.rs | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/rust/macros/quote.rs b/rust/macros/quote.rs
> index c8e08b3c1e4c..dddbb4e6f4cb 100644
> --- a/rust/macros/quote.rs
> +++ b/rust/macros/quote.rs
> @@ -39,12 +39,14 @@ impl ToTokens for TokenStream {
>  /// [`quote_spanned!`](https://docs.rs/quote/latest/quote/macro.quote_spanned.html) macro from the
>  /// `quote` crate but provides only just enough functionality needed by the current `macros` crate.
>  macro_rules! quote_spanned {
> -    ($span:expr => $($tt:tt)*) => {
> -    #[allow(clippy::vec_init_then_push)]
> -    {
> -        let mut tokens = ::std::vec::Vec::new();
> -        let span = $span;
> -        quote_spanned!(@proc tokens span $($tt)*);
> +    ($span:expr => $($tt:tt)*) => {{
> +        let mut tokens;
> +        #[allow(clippy::vec_init_then_push)]
> +        {
> +            tokens = ::std::vec::Vec::new();
> +            let span = $span;
> +            quote_spanned!(@proc tokens span $($tt)*);
> +        }
>          ::proc_macro::TokenStream::from_iter(tokens)
>      }};
>      (@proc $v:ident $span:ident) => {};
> 
> base-commit: ea76e08f4d901a450619831a255e9e0a4c0ed162
> --
> 2.40.0
> 
> 

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
