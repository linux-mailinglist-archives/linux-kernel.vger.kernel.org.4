Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0511C73D656
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 05:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjFZDeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 23:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjFZDeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 23:34:23 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B00111C;
        Sun, 25 Jun 2023 20:34:22 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6b5ef64bca6so2875101a34.3;
        Sun, 25 Jun 2023 20:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687750461; x=1690342461;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fu4n9jHXHJkJpHSK4BRSmkocgPDfhvvStvvCo/xt2Nc=;
        b=HCL26C2A/aJv9gHULSICVE2IrBp9fxfck5h9M2pdONm4d9VviTvo/LMcMZadIay68B
         o3dVKDsBPLN2zn1oW36ewMEhkhmZy/lf2+Ujn+KoBOVyG4i6yMz0wYaeW0bf2tHJm76G
         yZQVyhUlNZpTCkXj68CorrA/qudyU4TJxfOmDG21BFKo3wxyYuxHHXQ84U6LMzHQnpzu
         21oxPkWCpyYoiCFgN1RPjKLHjmHjWsl0cToxFVTb/+ErkbSvVslVycv2/cvynAId5TpC
         bbJ6waCysywW6Mar7f6uuNWlVUrynYmi4aMO78boZOq7H6aVj/m8YYnhbbxJ7TZ4Jx0M
         uxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687750461; x=1690342461;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fu4n9jHXHJkJpHSK4BRSmkocgPDfhvvStvvCo/xt2Nc=;
        b=OLseFI8GvnDfsfFhmgpAPQh4YaLLVcRir44xkEGnPa986WDmsTiesSpNUh8dN2gPAx
         /hyOY7hC0F3AfWzwHNBJeuM3xWQfGRESqMcmNxx2gK5Yakt5vyflxYd9Z0Xs+vTTDNVZ
         gYnYDNPhXIIs1gHcidOLQDszheXbXzH4563GGd4JI4M5wSD2MWr5KdJCk+8VsSpuy1MU
         r8qhgLTaQ1Ay9jkX6irQjX1GaNBM1MruoM238lqyAhbJTMlELwKrcEve9T3/sihQmLhq
         hCCQvjXL1muZApq+nHwgCJP2UrWttst0auR/V4+GAFwfbcsIU/JCQvmoSPUZeMBoHaBo
         O+nQ==
X-Gm-Message-State: AC+VfDz4P+3fijO5yoyZHaxRcWN7UAU/ocQ2azd3bYSWlwSxFttyUQLj
        +0g/wQ0JgQaNQroJklbcWSE=
X-Google-Smtp-Source: ACHHUZ5IhaRjbiSgQ+nKpRBHUR8LbxzQKjq9up0EkobcEnZYUNvZaLM8FMuiWEUI5M1FTT5hfEhHxg==
X-Received: by 2002:a05:6870:8702:b0:1aa:19fb:df64 with SMTP id k2-20020a056870870200b001aa19fbdf64mr22870186oam.54.1687750461543;
        Sun, 25 Jun 2023 20:34:21 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id hl17-20020a0568701b1100b0019e8deb387bsm3056117oab.53.2023.06.25.20.34.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 20:34:21 -0700 (PDT)
Message-ID: <a79002ec-aa2d-1eec-58be-372c3b2a0efa@gmail.com>
Date:   Mon, 26 Jun 2023 00:34:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] rust: alloc: Add realloc and alloc_zeroed to the
 GlobalAlloc impl
To:     Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>
References: <20230625232528.89306-1-boqun.feng@gmail.com>
Content-Language: en-US
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230625232528.89306-1-boqun.feng@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/23 20:25, Boqun Feng wrote:
> While there are default impls for these methods, using the respective C
> api's is faster. Currently neither the existing nor these new
> GlobalAlloc method implementations are actually called. Instead the
> __rust_* function defined below the GlobalAlloc impl are used. With
> rustc 1.71 these functions will be gone and all allocation calls will go
> through the GlobalAlloc implementation.
> 
> Link: https://github.com/Rust-for-Linux/linux/issues/68
> Signed-off-by: Björn Roy Baron <bjorn3_gh@protonmail.com>
> [boqun: add size adjustment for alignment requirement]

I think that this should go above Link and Signed-off-bys, although I'm
not sure if maintainers do it when is merged.

> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
> Miguel, I fold my diff into Björn's original patch and make a v2, it
> relies on the other patch:
> 
> 	https://lore.kernel.org/rust-for-linux/6e61f06f-2411-0bcb-926b-0a6927096f20@gmail.com/
> 
> So this v2 (if all goes well) is targeted for v6.6, JFYI.
> 
> v1 -> v2:
> 
> *	Add size adjustment for align requirement.
> 
> [...]

Newbie question, aren't tabs in the commit message verboten?

Aside from those two nits everything else LGTM.

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
