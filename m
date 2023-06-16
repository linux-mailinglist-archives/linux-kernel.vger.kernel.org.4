Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD8E733418
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjFPPBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344440AbjFPPBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:01:12 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170AA358C;
        Fri, 16 Jun 2023 08:01:07 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-38dec65ab50so674235b6e.2;
        Fri, 16 Jun 2023 08:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686927666; x=1689519666;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aQBQg8OJ1UpfkeRTq/gJupGVgO7j6NLxmO6HZvrEVGw=;
        b=niqXxyx9qWp8kGundlpHNdA2v+eaZgN7tlhzLoYTfWzYkjgc9Vwg8LEVSjolfkAUEM
         jdrRHttQJyq8ugkx0LAYo1JHc8b9Nw+yseEHrqbkiKPJo8HbGcU/yrhaf1oYDo2o1Gyb
         +zEgqe6L94epQndjvu3AhT7WvtQvoeDP9Ijz5OOV5HSa0htd/grbEhZD5LQV7aj9/mqk
         fDoQlDl2kGfp5wcoR7x7ZVH9wdhhGiNvVd+6Gx8p4iv3ThNdcXfCkMZskYy+fiDmxQp+
         /gYJqej1MGP03q0+0lPUuy+D0Cqx4EM2mRjCbiylXaXCX84NQoMxIZlI/oITDlCbC9ZA
         yjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686927666; x=1689519666;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aQBQg8OJ1UpfkeRTq/gJupGVgO7j6NLxmO6HZvrEVGw=;
        b=R3mUt6oIZL6IFgmaB9y9rajJQcCokJ/IYjWqtlXYI4cjJpXBVkXR3pX8BAXZ9VsZeI
         r+x6Y8K4OdFl0FGRvBENurIlVQGCeCBL0S7Cry9Bnize6RWcmFYXsZygoX9m+VRKko27
         pbkZE2d+ohMfxTf+wbhoEn8zwBKP6SFlD9iuWGbHzrSuGT9BsMELcwd3Cfm812l5ZrmS
         Y5NwOhA9Yd0xRW0ZAfLRI28DtoQyAuRTq9U/ZBprbbGW8kNjwF3Im9dHEdTNzFDhkSSZ
         qdNuBh07Bj4n1G1mZY++9yKR5llq3hM76tyZhntp0I2kbv28Myi4+Xz8q+hsAEk5RJmn
         q9dQ==
X-Gm-Message-State: AC+VfDwbAB7thbEPj3XvJ/LQcbxNtcv9oLnkQ7PuDr98BEIHKw2RDLYJ
        tfwCsAxNbkAsCHEhqXZtxpc=
X-Google-Smtp-Source: ACHHUZ6q71Qwdads9516QkoF/PU3flnagm4LfFfVYLH/yE2zqzRHTYjIcJFGLsv6Tel261eGyWVeuQ==
X-Received: by 2002:a05:6808:2907:b0:396:3969:a4a6 with SMTP id ev7-20020a056808290700b003963969a4a6mr2504687oib.18.1686927666357;
        Fri, 16 Jun 2023 08:01:06 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id k8-20020a544408000000b00399dff24197sm7925282oiw.5.2023.06.16.08.01.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 08:01:05 -0700 (PDT)
Message-ID: <f94cc2ce-156d-0d8b-16c9-0512ea4fcee2@gmail.com>
Date:   Fri, 16 Jun 2023 11:00:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 03/11] docs: rust: add paragraph about finding a
 suitable `libclang`
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
 <20230616001631.463536-4-ojeda@kernel.org>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230616001631.463536-4-ojeda@kernel.org>
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
> Sometimes users need to tweak the finding process of `libclang`
> for `bindgen` via the `clang-sys`-provided environment variables.
> 
> Thus add a paragraph to the setting up guide, including a reference
> to `clang-sys`'s relevant documentation.
> 
> Link: https://lore.kernel.org/rust-for-linux/CAKwvOdm5JT4wbdQQYuW+RT07rCi6whGBM2iUAyg8A1CmLXG6Nw@mail.gmail.com/
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
