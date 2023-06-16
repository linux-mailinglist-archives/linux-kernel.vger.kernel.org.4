Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9B9733424
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345865AbjFPPCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345806AbjFPPBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:01:54 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4591FDD;
        Fri, 16 Jun 2023 08:01:44 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-39e86b3da52so643277b6e.0;
        Fri, 16 Jun 2023 08:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686927703; x=1689519703;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vnS17URyKoXX82bjyvptn2/y/no/LqSPUxwsdFAi0+o=;
        b=UNgcpZ4I2DbFEtaOiJW5oc++TWDq0TFw4eTp2I1NlBs8kbKAjvinMsrW6s41n2edia
         NT9dn7D6bqZ2YGOKk9hGxRsrbJtX6TX0/uV1ZdsBIqvN0EHuDsjy243CfNwQpuWL3gYS
         90onoMzuWss0ta6AEjXmryFyiL14KpE4CgC/cVc6nz72IPZh3Ewo+Lqs9GCK+YuU1Efb
         BqpkiZMAVOw/QFSsvgGnJYNOlZ5IJkezHpJRGxu4SwMEm93v9RlEFubQmidjx878f2mU
         nyhL0TjZU8L9Kqq/ONM1eQniEBLAqURMkJ9+gJi0TGLc9XfxSJsKHWHfqY/xFHlpsIww
         Uz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686927703; x=1689519703;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vnS17URyKoXX82bjyvptn2/y/no/LqSPUxwsdFAi0+o=;
        b=D544W4qBY56srxF3ff9dXtcsY0UZN+XvNq71LFe+95BMAjbZj7VtircU2ichVMDKIv
         RlS0eJZm4dF9yNzmQk26pLV9PFhJnmJFiyPhVUZ6F1Tot6vUlLLSi/yqCZT0JiGph4e5
         leUsxUBoWDf9QHGU3152b+HYzbEx7fEg6SItiJwpo3qdAw/9qaUehh4oKKbIdf4sl24I
         2knnDwLrvP2W39Qd1yOUwZ08R5BhymJkayz9XgssyCJroap1mzzQJ1q5Xig+sC9Yo86g
         hmKHXjZw7Qep8AYI3+HXOTGY7poeQ30IxTw0jHi8ViNul3EwBKvarYi0Bn3vTWY3MPR1
         XWLw==
X-Gm-Message-State: AC+VfDxpiE5OiwXbxzCHfY8CCVTIVEJZnbWGIiM8L3NBux+5hG2JrRUl
        DL5xaPrOMBc60DLm7Z1NlfO6WMblFNQ=
X-Google-Smtp-Source: ACHHUZ5aqF2rzLL7LJVdUWNYEW1f9IcXPk+Mb2UA7Vv54UBKJAa/5DNDz+HBuJl+MrG+sbpnt6D8Uw==
X-Received: by 2002:aca:f102:0:b0:39e:af33:2d with SMTP id p2-20020acaf102000000b0039eaf33002dmr766947oih.0.1686927703287;
        Fri, 16 Jun 2023 08:01:43 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id q8-20020a0568080a8800b0039c7c757dc1sm7818826oij.24.2023.06.16.08.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 08:01:42 -0700 (PDT)
Message-ID: <dcc699f8-a770-cd55-7822-65c1d3daa275@gmail.com>
Date:   Fri, 16 Jun 2023 11:12:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 08/11] kbuild: rust_is_available: normalize version
 matching
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
 <20230616001631.463536-9-ojeda@kernel.org>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230616001631.463536-9-ojeda@kernel.org>
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
> In order to match the version string, `sed` is used in a couple
> cases, and `grep` and `head` in a couple others.
> 
> Make the script more consistent and easier to understand by
> using the same method, `sed`, for all of them.
> 
> This makes the version matching also a bit more strict for
> the changed cases, since the strings `rustc ` and `bindgen `
> will now be required, which should be fine since `rustc`
> complains if one attempts to call it with another program
> name, and `bindgen` uses a hardcoded string.
> 
> In addition, clarify why one of the existing `sed` commands
> does not provide an address like the others.
> 
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
