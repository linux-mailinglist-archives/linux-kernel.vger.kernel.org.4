Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08626E7166
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 05:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjDSDET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 23:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjDSDEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 23:04:15 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654051999;
        Tue, 18 Apr 2023 20:04:12 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6a5f765d595so881801a34.0;
        Tue, 18 Apr 2023 20:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681873451; x=1684465451;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vqy9obDZIsKYRaRdBaeKmhCuZAq4kt0Nx5h/9mD9nOE=;
        b=A64I/55zfIX2eYL+tHsfpsyxyfgA2xV5F3MS0SNYQswNukj4eB6KIIlmgLRfpcAqU9
         pR7BuUAgrPi44s5prY4B4GzdMpWASzgt2JzlE0suzXJtxqjwesWGcQdy8oTB0BG+uGBg
         jxB8F/ss4HIxsiYf8jhyP0jbY3FL/Ovynxka2eXx5KZggmGXr77mhxUv/jMl52FRWO8P
         esSVv+kauIhzSA/V3sPnW9wABzFQHh5DhRa8x61okbcHMm89ewhC8O4COCJfONREw/CI
         I2cpqev2uPqgFeQzXmXSo6C9gBZyE6x66oXlT5fyI7TsTrRMQLd9+LxUWjJICRY7Zkoa
         dg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681873451; x=1684465451;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vqy9obDZIsKYRaRdBaeKmhCuZAq4kt0Nx5h/9mD9nOE=;
        b=K9BJvsTokXuFzzqPNmvSmNKrgJ6A76NM8vS4h3kEeRZbOM3N8KmHqgD4mFIoxJNw+x
         IHQy0xIfwwtgqpHy3/34vDOdpKSdPcMro98HX6dVW0uUPG/G/bx917FCFSsJLGe5d4Ek
         RgccERxRlgayLVuplSdMbwf1z0t7I+yzUv01qXmrIiOUotSZhVN/CCQGbx0uX4c4lQ6M
         oDKT8vLcvf2BMmbO/SwvffNzOhLOJ4lT02orKORttWyvIOWwgOWjcWD6KYmUAK9IP+tm
         h64AfzIVp+Y2bm9fL1yWJrXhuPfqtvqXUnjQUt+T/bn2m+yPKVq+COdAPUdzlaNu8eHL
         O9Qw==
X-Gm-Message-State: AAQBX9d9rt215JX4m6ogMSzPlbA9tDzXKOV5eCoWdcUm/Cvu20eHabzV
        lmVUK6faoXViYnoaebZz6vDU/l+Et2E=
X-Google-Smtp-Source: AKy350YFiI0NAWpwFzIrAkC63w04jgUXNL65RJ+sEzA6dY6uIMTvDW8Is0ssPCsKpreiaWSlI48ExQ==
X-Received: by 2002:a05:6830:4da:b0:6a5:f6f6:4ebf with SMTP id s26-20020a05683004da00b006a5f6f64ebfmr2356875otd.37.1681873451795;
        Tue, 18 Apr 2023 20:04:11 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id v16-20020a05683011d000b0069457b86060sm6391395otq.47.2023.04.18.20.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 20:04:11 -0700 (PDT)
Message-ID: <d96b061f-737c-5f8c-0856-47faa3852074@gmail.com>
Date:   Tue, 18 Apr 2023 23:51:34 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/3] rust: alloc: clarify what is the upstream version
Content-Language: en-US
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Josh Stone <jistone@redhat.com>,
        William Brown <william.brown@suse.com>,
        Georgy Yakovlev <gyakovlev@gentoo.org>,
        Jan Alexander Steffens <jan.steffens@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
References: <20230418214347.324156-1-ojeda@kernel.org>
 <20230418214347.324156-2-ojeda@kernel.org>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230418214347.324156-2-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/23 18:43, Miguel Ojeda wrote:
> It may be unclear for readers which upstream Rust version these files
> are based on. They may be unaware that they are intended to match the
> minimum (and only, so far) supported version of Rust in the kernel.
> 
> Thus clarify it.
> 
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  rust/alloc/README.md | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/rust/alloc/README.md b/rust/alloc/README.md
> index c89c753720b5..eb6f22e94ebf 100644
> --- a/rust/alloc/README.md
> +++ b/rust/alloc/README.md
> @@ -10,6 +10,9 @@ upstream. In general, only additions should be performed (e.g. new
>  methods). Eventually, changes should make it into upstream so that,
>  at some point, this fork can be dropped from the kernel tree.
>  
> +The Rust upstream version on top of which these files are based matches
> +the output of `scripts/min-tool-version.sh rustc`.
> +
>  
>  ## Rationale
>  

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
