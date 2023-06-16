Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACFDC733428
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345882AbjFPPC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345816AbjFPPCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:02:00 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2443C06;
        Fri, 16 Jun 2023 08:01:51 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-39cc64e4a44so645891b6e.0;
        Fri, 16 Jun 2023 08:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686927710; x=1689519710;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DxvpAG4J+ncX4wjsATHNc8YjZ8LQGJET/TwvjpevhY0=;
        b=bft5y/q6N2cJnK7RZdxHBJnMPDNOx4FPkCTruY73NA75WZhoMszi/W09rQ0Ay+eOQt
         mB9+7ezzSUgcI0zrDzpRQECCzIQIBn6WZF18uPPMSLkxqYaj0c7dm0izI92s1x0VKppx
         wQDAM8U5GvbCCEF+m+0l6aUgJk/XSLnYEj3SUrbbneuCwCG2yuCzrxgPTMTdVdhFh/Uz
         JSqdWA0UeVQhi35eggNFwmcpzZwNp5MIWPyc0x04HIl3/ZCAobBwx4N4BPSsCT95QSwI
         9YcscfLl8BdUwTqBi0PUA2NR+bLSm7SsTaGf+HpUHqiYrtV1HbF94MLvG0DO2N+I4g8R
         6Kqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686927710; x=1689519710;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DxvpAG4J+ncX4wjsATHNc8YjZ8LQGJET/TwvjpevhY0=;
        b=JGWNeRM+daUYHUIbBiq7pd0EyyXlymvR3tqYykCV+Gm9/sVUfmgb8shCrTRPeWYWlB
         rFBIygTQfEUoKFvo6Z7aw42wbG2Z8h4NDjsmX2I1PEpq0BDnJC3lnFImlLuWkXeDlU0N
         rj8nPNpfrNSK/JaMjMgLzL1m92YJZuVnYYPhZDRCH2wr+YEZPl45Ub0rLS7otmbXZY8i
         tXS7MFfD1uxKeqLXan05zKLbKjgvMdzTY5VBReTkxFCJCpjuOv0J5P2nQcHimqSuZDFc
         LykjcEc94M6Yq2YlskQiIjWjIKnEaDkudHA1lfRxR9Py1qu0VR7EQR+35/Yp9WWcl/6P
         JwSg==
X-Gm-Message-State: AC+VfDxOcHrtOg05dqGIM7Uu9s/I+B8KWZb3aR2bAJKIlykhvxSm55OY
        +P4RQTVq14IAX2jmy5oveXI=
X-Google-Smtp-Source: ACHHUZ6+g8AH+7G7rC2jeemrHg4xjipfdzcCXkWhef7csdyVByg+yXh0rWMjCQgkPswn/EPIA3JZ5A==
X-Received: by 2002:a05:6808:1a88:b0:398:26f0:67a7 with SMTP id bm8-20020a0568081a8800b0039826f067a7mr1898162oib.59.1686927710308;
        Fri, 16 Jun 2023 08:01:50 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id x62-20020acae041000000b00397f453aae6sm8364983oig.38.2023.06.16.08.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 08:01:49 -0700 (PDT)
Message-ID: <e7c6b538-fc98-c9e2-dd15-3961aa441302@gmail.com>
Date:   Fri, 16 Jun 2023 11:14:39 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 09/11] kbuild: rust_is_available: handle failures
 calling `$RUSTC`/`$BINDGEN`
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
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <20230616001631.463536-1-ojeda@kernel.org>
 <20230616001631.463536-10-ojeda@kernel.org>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230616001631.463536-10-ojeda@kernel.org>
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

On 6/15/23 21:16, Miguel Ojeda wrote:
> The script already checks if `$RUSTC` and `$BINDGEN` exists via
> `command`, but the environment variables may point to a
> non-executable file, or the programs may fail for some other reason.
> While the script successfully exits with a failure as it should,
> the error given can be quite confusing depending on the shell and
> the behavior of its `command`. For instance, with `dash`:
> 
>      $ RUSTC=./mm BINDGEN=bindgen CC=clang scripts/rust_is_available.sh
>      scripts/rust_is_available.sh: 19: arithmetic expression: expecting primary: "100000 *  + 100 *  + "
> 
> Thus detect failure exit codes when calling `$RUSTC` and `$BINDGEN` and
> print a better message, in a similar way to what we do when extracting
> the `libclang` version found by `bindgen`.
> 
> Link: https://lore.kernel.org/rust-for-linux/CAK7LNAQYk6s11MASRHW6oxtkqF00EJVqhHOP=5rynWt-QDUsXw@mail.gmail.com/
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
