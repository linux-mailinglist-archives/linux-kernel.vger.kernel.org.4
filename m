Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2CE741D63
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 02:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjF2Awa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 20:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjF2AwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 20:52:25 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE68F2118;
        Wed, 28 Jun 2023 17:52:23 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1b01b43577fso124920fac.0;
        Wed, 28 Jun 2023 17:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687999943; x=1690591943;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gw+0BOjq4yN+eWHXyUzI2LVAIZHQf86ZjZGyLq017bk=;
        b=FBFsmXx6zjT7OEI8fd9vMQ3rKsG+IuC3ThvO0Da+2zY+f69L3m1AZga6IdGXaTLrDb
         PLvPOtGFjC28UNibVxEsrgTAxVWtuprNaO1iOkCOGpkeW8hv2wMq2am9cOw7TWPg4N7d
         S7M2ANJ+OZanxjSYktC7uhYIlIEeCh7xnAjPdVy2u3iyKaCnrzg49edlj7NI5mR+gN+t
         zDyR1EuW15ZNMx0G6vuD5bg4UQdTQpyfZLSR1RogoNi1OyZWqUKDa03/OZDAxMju3swt
         7d01Q0yxdnVt+c29S+gss68y/ln7548Rz/COTBneMi1kz+kj1b//Q1dGJ2U/+C4YAw0C
         HTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687999943; x=1690591943;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gw+0BOjq4yN+eWHXyUzI2LVAIZHQf86ZjZGyLq017bk=;
        b=kywqML6vYPtJR4N8R0EzwRBVm6AXBBzcvXxtSN4+84E1ZtX1RX1SeLu+M8EzMxLfCC
         dqorjkluB5981YTDT2a3kEn+xGhSjXAsqjCZn0pXQcn5I4ui3dkD84UApJ8xt22ab7tI
         fYef6GHO1hfiUg0NHOfeCczYlWxyBdxRz7jbOPHngyL92K2ox0hYd+K59kfSWTkBEron
         sf+J5p6q9MuW+LL29buhcTUmHJvk82fvXPyFm0PVTTJp3TPrdBhWzWvQJqz98vXXNy0j
         2SUZeviiZeLOAU9JXzHyhlwRHDIJlLQUhZy7dRaBRxJeDLnPGG3l1sy2FFxlwTiFsDJd
         ZaCA==
X-Gm-Message-State: AC+VfDzWexeTnZc/YpJo+M32c6xQnlQ7fvuULHnan7opFtfof3DuTTuU
        yl3L9sVD4CgCjXk+0JfxWmM=
X-Google-Smtp-Source: ACHHUZ6dEsmjdMIXr24d/njV7n8FdllB83aFglf6j+as0HzzWQaXDvjI2FQHo6KThlvsc3kqVnyqyQ==
X-Received: by 2002:a05:6870:bc19:b0:1b0:7f57:1e28 with SMTP id oa25-20020a056870bc1900b001b07f571e28mr3384680oab.11.1687999943126;
        Wed, 28 Jun 2023 17:52:23 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id s11-20020a05683004cb00b006b8703c11fesm1831120otd.13.2023.06.28.17.52.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 17:52:22 -0700 (PDT)
Message-ID: <4342b487-7e2c-750b-4de0-cfc03da042ec@gmail.com>
Date:   Wed, 28 Jun 2023 21:51:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] rust: macros: add `paste!` proc macro
Content-Language: en-US
To:     Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>
Cc:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20230628171108.1150742-1-gary@garyguo.net>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230628171108.1150742-1-gary@garyguo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/23 14:11, Gary Guo wrote:
> This macro provides a flexible way to concatenated identifiers together
> and it allows the resulting identifier to be used to declare new items,
> which `concat_idents!` does not allow. It also allows identifiers to be
> transformed before concatenated.
> 
> The `concat_idents!` example
> 
>      let x_1 = 42;
>      let x_2 = concat_idents!(x, _1);
>      assert!(x_1 == x_2);
> 
> can be written with `paste!` macro like this:
> 
>      let x_1 = 42;
>      let x_2 = paste!([<x _1>]);
>      assert!(x_1 == x_2);
> 
> However `paste!` macro is more flexible because it can be used to create
> a new variable:
> 
>      let x_1 = 42;
>      paste!(let [<x _2>] = [<x _1>];);
>      assert!(x_1 == x_2);
> 
> While this is not possible with `concat_idents!`.
> 
> This macro is similar to the `paste!` crate [1], but this is a fresh
> implementation to avoid vendoring large amount of code directly. Also, I
> have augmented it to provide a way to specify span of the resulting
> token, allowing precise control.
> 
> For example, this code is broken because the variable is declared inside
> the macro, so Rust macro hygiene rules prevents access from the outside:
> 
>      macro_rules! m {
>          ($id: ident) => {
>              // The resulting token has hygiene of the macro.
>              paste!(let [<$id>] = 1;)
>          }
>      }
> 
>      m!(a);
>      let _ = a;
> 
> In this versionn of `paste!` macro I added a `span` modifier to allow
> this:
> 
>      macro_rules! m {
>          ($id: ident) => {
>              // The resulting token has hygiene of `$id`.
>              paste!(let [<$id:span>] = 1;)
>          }
>      }
> 
>      m!(a);
>      let _ = a;
> 
> Link: http://docs.rs/paste/ [1]
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
