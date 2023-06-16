Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B4373341C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345776AbjFPPBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345797AbjFPPB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:01:28 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534B330EB;
        Fri, 16 Jun 2023 08:01:22 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-55b171c1e16so565899eaf.1;
        Fri, 16 Jun 2023 08:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686927682; x=1689519682;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7YzLkZ7R/8qUwBNf++ojl6KCaGOyRjez93untqJDgCQ=;
        b=IVQVw15/AYeIaQrf6ByOLNtHAKZaTuY9e752LuCYmu4j99mC13t/vQksIuc9WeqJza
         sKda+8z3cBRqhGT4Kr4Li6SGtIa8+P895ZA0VRm16wj11EUNqvL5f9B2BPZWhE/THY3L
         qrXK4RLUcgsglARS6war7oox9qTc0LK2+Hb4fAWoJHTEcJ7FEIJ1ap7IBaeuTVS713yG
         bXI/bcEiFuf0O2Q/AtOl6yFdkjBAoi9HI5K6cHdDF293iFw37VRuCIXTC79vs9H3t/Zy
         pr1QyXN0wGyaIz3V9n7RKVBmSE6idL3AYX7HsThS3oyXEIhbX4yi8h5gLnfdx1sK7pGQ
         xmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686927682; x=1689519682;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7YzLkZ7R/8qUwBNf++ojl6KCaGOyRjez93untqJDgCQ=;
        b=CtaTLpyVxWv7MVBv9ZtbJFqb148hCJ8VW2BMjuSfu33+FDUjDzv29HZhRgtEpBDRdF
         koy18qbQXiabXFwvX/jwqg7B8ATqVHLNOYR/zr/2EJfd5CoVHkNNqSrwGwdOjpvqG8K2
         5o0Raz2AXCGpb58LcIp1LqYRuDa0TIko2gynacurKUzYhKjV2AWgJdpKAyYm4K4jDR4+
         1eWctwkUFXHqQ61+Yhc3n6mUJMjAHyn/kRTOCrIt4tm8Xck3+l1cAp1J5fI1IIoR9Jf4
         516LtqIXx8w5JmyhqbtHkdpsSTys3biB2STdna/vbr9soUzFWfPH4AOICRJEbPFXDDAM
         sI2A==
X-Gm-Message-State: AC+VfDy28DxnA3jlZdJwdQwxJUT5m67WTU+tX0wxjR1HAuIzwAMqnyCB
        x9WpgOvJeXyVIn+tJ96FcL0=
X-Google-Smtp-Source: ACHHUZ5XCC0eJC8IgkdWVr7dEKNpmAJ7utnREMBjazTMwxXxfuRbHNtEKMWjJ1qnr7zaUR0E2yJKOg==
X-Received: by 2002:a4a:e78f:0:b0:55c:6812:27c5 with SMTP id x15-20020a4ae78f000000b0055c681227c5mr1787573oov.9.1686927681955;
        Fri, 16 Jun 2023 08:01:21 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id n1-20020a9d4d01000000b006af99ac5832sm7928823otf.47.2023.06.16.08.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 08:01:21 -0700 (PDT)
Message-ID: <51e0fd1d-4d8f-8ef6-f910-6fb1a92755d0@gmail.com>
Date:   Fri, 16 Jun 2023 11:06:46 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 05/11] kbuild: rust_is_available: add check for
 `bindgen` invocation
Content-Language: en-US
To:     Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        linux-kbuild@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        =?UTF-8?Q?Fran=c3=a7ois_Valenduc?= <francoisvalenduc@gmail.com>,
        Alexandru Radovici <msg4alex@gmail.com>,
        Matthew Leach <dev@mattleach.net>
References: <20230616001631.463536-1-ojeda@kernel.org>
 <20230616001631.463536-6-ojeda@kernel.org>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230616001631.463536-6-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/23 21:16, Miguel Ojeda wrote:
> `scripts/rust_is_available.sh` calls `bindgen` with a special
> header in order to check whether the `libclang` version in use
> is suitable.
> 
> However, the invocation itself may fail if, for instance, `bindgen`
> cannot locate `libclang`. This is fine for Kconfig (since the
> script will still fail and therefore disable Rust as it should),
> but it is pretty confusing for users of the `rustavailable` target
> given the error will be unrelated:
> 
>      ./scripts/rust_is_available.sh: 21: arithmetic expression: expecting primary: "100000 *  + 100 *  + "
>      make: *** [Makefile:1816: rustavailable] Error 2
> 
> Instead, run the `bindgen` invocation independently in a previous
> step, saving its output and return code. If it fails, then show
> the user a proper error message. Otherwise, continue as usual
> with the saved output.
> 
> Since the previous patch we show a reference to the docs, and
> the docs now explain how `bindgen` looks for `libclang`,
> thus the error message can leverage the documentation, avoiding
> duplication here (and making users aware of the setup guide in
> the documentation).
> 
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Link: https://lore.kernel.org/rust-for-linux/CAKwvOdm5JT4wbdQQYuW+RT07rCi6whGBM2iUAyg8A1CmLXG6Nw@mail.gmail.com/
> Reported-by: François Valenduc <francoisvalenduc@gmail.com>
> Closes: https://github.com/Rust-for-Linux/linux/issues/934
> Reported-by: Alexandru Radovici <msg4alex@gmail.com>
> Closes: https://github.com/Rust-for-Linux/linux/pull/921
> Reported-by: Matthew Leach <dev@mattleach.net>
> Closes: https://lore.kernel.org/rust-for-linux/20230507084116.1099067-1-dev@mattleach.net/
> Fixes: 78521f3399ab ("scripts: add `rust_is_available.sh`")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
