Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6E568AC03
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 20:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbjBDTFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 14:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjBDTFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 14:05:11 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D582684B;
        Sat,  4 Feb 2023 11:05:07 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id bk15so23824879ejb.9;
        Sat, 04 Feb 2023 11:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+DlghB0YJ67hLvTX4yJkS05i+iy4cNCXn01Nrycq50=;
        b=bL7y+r2ajCGekbQLvKC28XGrbQg17hQDcLXQy5DdbojFYQbaerQQE45ROpxPh75jvo
         4guka4GB0+M/RoZx5aj8eKMxnZVkJ4shlj14FEp76kDjNkyFsdbRiEK2wIkFu6GwJskg
         +ZoKC5tFlDlo6+P0MgFOopwBBLXlwA1qpo1E1eblxdO4NAVvEYgQjIvMqIb0RO1mA47a
         TAP0CgR3Bih86Pwhh/UzSutDQVO080J5Wb1c7d8OilYt+XmRxR8zCGBl+YQ340fyspkI
         zWb5+4LnPr9T0G0qHveSzjN/GQDLmsmc/fCx+lJWqI6TIWSqrwqJbo9dOOCjMNxVUvjQ
         lL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J+DlghB0YJ67hLvTX4yJkS05i+iy4cNCXn01Nrycq50=;
        b=EwzTuO0i3cuE4rNn+zdblcX8jBtet/n8NRlZaQW2VjBD3fWaXJj0ajyhJwelupNy7b
         XPUZsGeI2Fg1cBU0z1dm0A+m9PiOHssoJBhC9/vnkzDNuYS3owkuo6oeb4eBKtZzVBag
         /4Cp10TCiFLuG5ki6AAkfltHVXn0T5GkYmmxu70AeKoFaSI1+GqhpClqeWH0it0Zj6mC
         CNfn9laQ8iMxzCdWe6QiKcEPSTnhLF1vshrs0QHKnGNi3o9fHqMitF6mNRnMCv6DyDXE
         Zc0pvcUDMefoIQiAKMTowZ9RoEFvLSVSzTC5VrBzsoPfENGLeq1LGzDnxChr2EnUaxpU
         D/Gw==
X-Gm-Message-State: AO0yUKVacImp8Q1SUJH8Mk4n+nt+AmAY7ArDExhf7V2Kjvm6FYUhw+R0
        AC+q6wbDf9ZI9Q38DVCVnZJOgIXQG28xHBpnsR0=
X-Google-Smtp-Source: AK7set/s5kLN3P1WUlmaq35ShIUiV6+IMJV6AOxXhLgmHMO9GPyka+8Brx95YbvJPmuGwYtYvzh0vA==
X-Received: by 2002:a17:906:53d5:b0:88c:8c2e:af17 with SMTP id p21-20020a17090653d500b0088c8c2eaf17mr13000055ejo.2.1675537505570;
        Sat, 04 Feb 2023 11:05:05 -0800 (PST)
Received: from localhost ([2001:b07:5d37:537d:8c1:b772:7521:b7bd])
        by smtp.gmail.com with ESMTPSA id f25-20020a170906391900b0084d4b8f5889sm3170969eje.102.2023.02.04.11.05.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Feb 2023 11:05:04 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 04 Feb 2023 20:05:03 +0100
Message-Id: <CQA0H2Z1SGIG.I9OPJD8ADX24@vincent>
Cc:     "Will Deacon" <will@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Subject: Re: [RFC 5/5] sample: rust: print: Add sampe code for Arc printing
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To:     "Boqun Feng" <boqun.feng@gmail.com>,
        <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0-38-gb2afc8117fb7
References: <20230201232244.212908-1-boqun.feng@gmail.com>
 <20230201232244.212908-6-boqun.feng@gmail.com>
In-Reply-To: <20230201232244.212908-6-boqun.feng@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Feb 2, 2023 at 12:22 AM CET, Boqun Feng wrote:
> This both demonstrates the usage of different print format in Rust and
> serves as a selftest for the `Display` and `Debug` implementation of
> `Arc` and its friends.
>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
Reviwed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>

>  samples/rust/rust_print.rs | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/samples/rust/rust_print.rs b/samples/rust/rust_print.rs
> index 8b39d9cef6d1..165a8d7b1c07 100644
> --- a/samples/rust/rust_print.rs
> +++ b/samples/rust/rust_print.rs
> @@ -15,6 +15,30 @@ module! {
> =20
>  struct RustPrint;
> =20
> +fn arc_print() -> Result {
> +    use kernel::sync::*;
> +
> +    let a =3D Arc::try_new(1)?;
> +    let b =3D UniqueArc::try_new("hello, world")?;
> +
> +    // Prints the value of data in `a`.
> +    pr_info!("{}", a);
> +
> +    // Uses ":?" to print debug fmt of `b`.
> +    pr_info!("{:?}", b);
> +
> +    let a: Arc<&str> =3D b.into();
> +    let c =3D a.clone();
> +
> +    // Uses `dbg` to print, will move `c`.
> +    dbg!(c);
> +
> +    // Prints debug fmt with pretty-print "#" and number-in-hex "x".
> +    pr_info!("{:#x?}", a);
> +
> +    Ok(())
> +}
> +
>  impl kernel::Module for RustPrint {
>      fn init(_module: &'static ThisModule) -> Result<Self> {
>          pr_info!("Rust printing macros sample (init)\n");
> @@ -43,6 +67,8 @@ impl kernel::Module for RustPrint {
>          pr_cont!(" is {}", "continued");
>          pr_cont!(" with {}\n", "args");
> =20
> +        arc_print()?;
> +
>          Ok(RustPrint)
>      }
>  }
> --=20
> 2.39.1

