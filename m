Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFCB733415
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345768AbjFPPBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345172AbjFPPBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:01:01 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319FE30E7;
        Fri, 16 Jun 2023 08:01:00 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6b28fc460bcso712580a34.1;
        Fri, 16 Jun 2023 08:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686927659; x=1689519659;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U88tdfNVtbOWIg3yElvA/Pd2Mu59Yv00Wm7QJm0BpI8=;
        b=fd5NRQbNwFNBZqgRfAPNhSSQmAIH7Ulzp8MDABOLBQVW/DgYgvvnt8iMUCdskAyThj
         GC91fisA9oVh+fgns77IccmhuuUAleNPaLb7LNcVEIOz24SPbvQHkpI1SUy594WJYk3P
         Pzq14p9EnJ3X1DZ687E5I7bqyLxJZZT0v1TF0ErYBfonNLDg0N52LWnuvtNdMS5oVLkP
         g2EA+71X/jrnvP+zXWa/5z/geiDPpcff3Fsg/fDorb7fKWeqeMR+mX480MlthDfcm5LY
         SaFPO+HZXL3YkkVtBNLvAvlucGBgTJ5QMxDW7NncDhg/9KyRo+4wCNibIKqQ4Nls7M3B
         mIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686927659; x=1689519659;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U88tdfNVtbOWIg3yElvA/Pd2Mu59Yv00Wm7QJm0BpI8=;
        b=YrGR8BawoHCMqSI94EJWCmm/uc5q8cZyN1FHnl3tEJfBqpi39qXtT0aTdHGnd+5KoK
         Ieh9i07G1XqaOjeF+CnM0V+6tr6JaupyX5gzI2yfgewuQCMHsPtKI/dMnNGBYYfj6pOm
         sMQ7X0b74q4enmF4q/z3UYx7Tv+IzDZ8aTA/zLK0FzFL4AUigA4rYGcCA1mOkwawToWg
         iFM5eZiPbcokFRhGj4KUr78puao1GRmeHl5CLtDY/QnXavkVXVsh9nBFeflibJiWcsR8
         A4WnzWinYMriQ9Mo+IL/EHb1Ga5oOgm34UEy9gF+VlFA1ib/2Mggcz6C9LJ2Y9ogxht/
         OE5A==
X-Gm-Message-State: AC+VfDzoUOg6z20ezwjD7fKrG9eZZ3eYsJ5KdflDSEXjFdPdUKFqerIq
        V7BQn+bC5VC80nxlh1ib0KM=
X-Google-Smtp-Source: ACHHUZ5i1jxlM5V4dv7IaIvZxykSltp2sgkfuVN1xlsYiSMEkPChpddWDIxxXP3Mcw8OLigetRoidw==
X-Received: by 2002:a9d:62d3:0:b0:6b2:ac44:bf88 with SMTP id z19-20020a9d62d3000000b006b2ac44bf88mr2737134otk.10.1686927659363;
        Fri, 16 Jun 2023 08:00:59 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id s10-20020a05683004ca00b006add66c7d73sm7126937otd.27.2023.06.16.08.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 08:00:58 -0700 (PDT)
Message-ID: <ff363ce7-059e-6021-687b-794c532647de@gmail.com>
Date:   Fri, 16 Jun 2023 10:58:27 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 02/11] kbuild: rust_is_available: fix version check
 when CC has multiple arguments
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
        Russell Currey <ruscur@russell.cc>
References: <20230616001631.463536-1-ojeda@kernel.org>
 <20230616001631.463536-3-ojeda@kernel.org>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230616001631.463536-3-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/23 21:16, Miguel Ojeda wrote:
> From: Russell Currey <ruscur@russell.cc>
> 
> rust_is_available.sh uses cc-version.sh to identify which C compiler is
> in use, as scripts/Kconfig.include does.  cc-version.sh isn't designed to
> be able to handle multiple arguments in one variable, i.e. "ccache clang".
> Its invocation in rust_is_available.sh quotes "$CC", which makes
> $1 == "ccache clang" instead of the intended $1 == ccache & $2 == clang.
> 
> cc-version.sh could also be changed to handle having "ccache clang" as one
> argument, but it only has the one consumer upstream, making it simpler to
> fix the caller here.
> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> Fixes: 78521f3399ab ("scripts: add `rust_is_available.sh`")
> Link: https://github.com/Rust-for-Linux/linux/pull/873
> [ Reworded title prefix and reflow line to 75 columns. ]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
