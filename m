Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B19D73341F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344440AbjFPPB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345795AbjFPPBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:01:38 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE42B359F;
        Fri, 16 Jun 2023 08:01:30 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1a9d57f8f9fso582841fac.3;
        Fri, 16 Jun 2023 08:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686927690; x=1689519690;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I2cPag5aN0MWJAFLWvbMyNtH5T6S8+Vc3THjxE3SzjY=;
        b=W+p57BBqvE6vEIGynnEcGkcirKwbw1ptyeFjMPbtqTG3SGjnb3uYqiiHozshYO/6HJ
         1qSdqohr+yo7gI4nd9qLBvMJ+sCLfTeO4sEHGFm6vjR2Igrno7VnujIyGduO8yi/JUtm
         1XO3aFy44jOZJ5sC/rYkqm6LvdNuq+IwlAaE2Xu6DsyAbRLk2BPyG+avwAQStzkAaNoI
         ue4XvfU12TU28nWnesTeSGBXxVM4JREiOvCQCHrVrhh9mJAU25z8Z3+Wb5VZ8q0DaH1O
         R7ukxlytxBaetNWVGMm3fzaLe2x5VDh63rlk8HCdM1Ul8lFqd+lOoOHaN6UGbe3rrpCs
         9T7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686927690; x=1689519690;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I2cPag5aN0MWJAFLWvbMyNtH5T6S8+Vc3THjxE3SzjY=;
        b=aH83Ll5zD04ujGmthLkNhEcYRM7F+6XhARa+tUVdeYsItuvU1AurjLj5MAIQ0gQcXc
         0Zz7LpCKnFhZoK8DtTb73pk6uGLR5yB+cRNQfODasARm3WN3cm3RMENQzlU0L/k3nu0R
         W7xlR6M86dh8q4l8/reGEh/FVt5OvSTIfGjWvVsoNIMOrmdjOG7cLm/tliS/hJWPy35M
         IBQiwz9K/VS8RXSmcMiVsGYVXA+DZJr6ww+4Q+h9Hjh3TIpioAPif2rdQiScMUMRkeD1
         gbMUH8QbkkrzaNud/TXjq+efoI/TafifCtTXZ9TPZVPAQZhg0RLT7h1H/8aM+dkUS8Dc
         yoNQ==
X-Gm-Message-State: AC+VfDyra9UOkHQtpa2ZnbBBBCtyJ1KhbeajbH7sOdYKvtTJS96LUDBR
        bXZvUZ2QBxBOivTJS/FhCh0=
X-Google-Smtp-Source: ACHHUZ5tmQXBdCH0Bmja7Xhdz4f/k6mMEDWuBdBMFjqEXJnnkwS+GUUn2WO6K4oJIq+FLAWB2rDn4g==
X-Received: by 2002:a05:6870:1a93:b0:1a2:f7ca:61af with SMTP id ef19-20020a0568701a9300b001a2f7ca61afmr2446890oab.2.1686927688697;
        Fri, 16 Jun 2023 08:01:28 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id l1-20020a05687040c100b001a2d569558dsm4155233oal.35.2023.06.16.08.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 08:01:28 -0700 (PDT)
Message-ID: <f278ea82-e949-f4d2-a48e-e615fa5491f6@gmail.com>
Date:   Fri, 16 Jun 2023 11:08:52 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 06/11] kbuild: rust_is_available: check that
 environment variables are set
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
 <20230616001631.463536-7-ojeda@kernel.org>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230616001631.463536-7-ojeda@kernel.org>
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
> Sometimes [1] users may attempt to setup the Rust support by
> checking what Kbuild does and they end up finding out about
> `scripts/rust_is_available.sh`. Inevitably, they run the script
> directly, but unless they setup the required variables,
> the result of the script is not meaningful.
> 
> We could add some defaults to the variables, but that could be
> confusing for those that may override the defaults (compared
> to their kernel builds), and `$CC` would not be a simple default
> in any case.
> 
> Therefore, instead, explicitly check whether the expected variables
> are set (`$RUSTC`, `$BINDGEN` and `$CC`). If not, print an explanation
> about the fact that the script is meant to be called from Kbuild,
> since that is the most likely cause for the variables not being set.
> 
> Link: https://lore.kernel.org/oe-kbuild-all/Y6r4mXz5NS0+HVXo@zn.tnic/ [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
