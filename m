Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26810713A27
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 16:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjE1Ojl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 10:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjE1Ojj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 10:39:39 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF962B8;
        Sun, 28 May 2023 07:39:38 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6af873d1d8bso1011371a34.3;
        Sun, 28 May 2023 07:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685284778; x=1687876778;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zqwAEtWjCPT8dGp7Hg7XLpqKdzj6HDs5vCuNUoe3jXY=;
        b=oC4dgXq5JL56+5e6LQPqolZoKF28dXEppYncf52s5VGYpuuP480KIoe2w3NO7sdpSN
         4h4eCP/jlUst3C1JHGKwir/s5b2LDtwR3ZbtMJPunUaJnw5PiJOfywUOJftuz+Owrv8O
         u05FmRg3d18D76IWldMwZZIAMDxsV4BuxY4knZ9WTNJLPn72Kkw9tGtnhCY9r3qFHK41
         W6MODjaBromzN8gMFlRCAtIiaozmxCzfMp189Y/64YziL9Gg+Kf4eqTzE6ArrtOkXvWc
         XrrrUBPSXbRw3aShePlzZ7EdDd25YdPFrxI1aVjZf9ywRJvWiALbZvv5i2O9lksvCAaV
         Wm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685284778; x=1687876778;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zqwAEtWjCPT8dGp7Hg7XLpqKdzj6HDs5vCuNUoe3jXY=;
        b=DvU5M3yUg0Rutwob0eynqdOIDwLRM76fRRdI5mTj4uYr1mptFMiq0wP1v3U3adp/xl
         jXGdBf881Mw8uN1iJvIWqiQ96hvQOcbMYxzRfVQpBl9/HV+UaK9xZ5z3oEgWlrYEAXMW
         1BMqOVpo2M4jRI0I6KZtYPzRj3/A2VrThXXy3Ip8RG/qS0mDwFSOhE+U5LKSqHsKbCVf
         fJKRxUT89G2sJpHcrYRufd7lg5x1c1rFY9Zc3pW0QUQQvewrjVPDRHdtJ5NGgRmDGdTU
         kBHaONATbyPG2L3gBnjLWW6Bz1v6vmqmAG2L9WP8oeKRqRWpcySLGBcerLP9VE8nokGr
         056w==
X-Gm-Message-State: AC+VfDwIO6rOw81qq21awyQ322K2CmwvI9uO6MNfqvZUHV/azbROTBYg
        stidx21l+V746feTr2rQw7E=
X-Google-Smtp-Source: ACHHUZ5Dwd/WEqOatrum1wODC6I6Zd0zd+J7X7PsjIvPXaoJbkkCMmdC04e9U8BkvLBnUlq1CfGnFQ==
X-Received: by 2002:a05:6830:4dc:b0:6a4:2ad5:9aa0 with SMTP id s28-20020a05683004dc00b006a42ad59aa0mr4087810otd.20.1685284778088;
        Sun, 28 May 2023 07:39:38 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id y23-20020a0568301d9700b006a662e9f074sm3647708oti.58.2023.05.28.07.39.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 May 2023 07:39:37 -0700 (PDT)
Message-ID: <525fee98-c694-6a38-cd1e-dd7efd806620@gmail.com>
Date:   Sun, 28 May 2023 11:39:32 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 1/1] scripts/rust_is_available: Fix clang version check
To:     "Ethan D. Twardy" <ethan.twardy@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Tiago Lam <tiagolam@gmail.com>,
        Kees Cook <keescook@chromium.org>, Finn Behrens <me@kloenk.de>,
        "open list:RUST" <rust-for-linux@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CLANG/LLVM BUILD SUPPORT" <llvm@lists.linux.dev>
References: <20230528131802.6390-1-ethan.twardy@gmail.com>
 <20230528131802.6390-2-ethan.twardy@gmail.com>
Content-Language: en-US
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230528131802.6390-2-ethan.twardy@gmail.com>
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

On 5/28/23 10:18, Ethan D. Twardy wrote:
> [...]
> --- a/scripts/rust_is_available.sh
> +++ b/scripts/rust_is_available.sh
> @@ -102,8 +102,8 @@ fi
>   # Check that the `libclang` used by the Rust bindings generator is suitable.
>   bindgen_libclang_version=$( \
>   	LC_ALL=C "$BINDGEN" $(dirname $0)/rust_is_available_bindgen_libclang.h 2>&1 >/dev/null \
> -		| grep -F 'clang version ' \
> -		| grep -oE '[0-9]+\.[0-9]+\.[0-9]+' \
> +		| grep -oE 'clang version [0-9]+\.[0-9]+\.[0-9]+' \
> +		| cut -d' ' -f3 \
>   		| head -n 1 \
>   )
>   bindgen_libclang_min_version=$($min_tool_version llvm)

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Tested-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
