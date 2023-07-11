Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F73974F376
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjGKPbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjGKPbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:31:19 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B42136;
        Tue, 11 Jul 2023 08:31:17 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-76d846a4b85so1876094241.1;
        Tue, 11 Jul 2023 08:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689089477; x=1691681477;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WBa3P+eEVlY2aRMtEhjsbjDGKwifpPvBC3/YijKd1zM=;
        b=RcUMizs/By5jF0CkNsnUcHm97N9tDyRBomTSUO8f/MQqgE5AIcbCDPzebTKSlrrp86
         PCbY96sH/ga4QZvMEBxgZ9EfPJAYhEQx4VVpuRB9F8/I2xM4OqLWDHKMh68DpoocGeVS
         9G263gquD76qdpZq1NOurRzmXJdWaqJP+y7K3OLX7LRmkzkwf4XbrTyaw4ODS1j9+7jE
         uoqHGWtnK0sC7TTnFmdZ8WbyZMbw64hv2rm5DHad8cTmUETkgqGcuz2TpwntzTrYk3GA
         V8adSO2ufgH1m7eZqJkSZ3sSlgpsfZaSR74tI/o/Ly/dWaMAnsOxEPSuB7x5CvtkUF+m
         0iEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689089477; x=1691681477;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WBa3P+eEVlY2aRMtEhjsbjDGKwifpPvBC3/YijKd1zM=;
        b=GN8E74uuY5aOrtiaWAgRZBJslSf4VYlGnzKSGUM5Mpk9ED/mnemVElTAy4MJdpAtc0
         Z7ANG+3RdDx6RWTF/6nfdZRAAPYI8rulFsUlqu5u58eoSWzji6q2mfzZdi1M6HPascNg
         0OfiT030a1rTRFg2ZqDt6hdPolWo4bE3G/1Cmr4YoWC7bU9VtvDuZJdnhP7T68nEWrqZ
         jLheI4frz6qYmF20WhGG9Ixnp89RbfehGi/RrS6RkXF2HKdhvagemC0SX90+2Ry5jvh1
         Tzza5u6ojjqEx8Yn3fTuzOZC5ZisbuwDy01YQVbiEEMniEkW4UA+2n1KlUFPUP/3tpyK
         sngg==
X-Gm-Message-State: ABy/qLYWYIavRo5W7JwyXOZoN1aUvTaZ5cFSbKvWHpS898t+D1WS/8N5
        feyhNluSxRFwEBhwOxKOGo0=
X-Google-Smtp-Source: APBJJlF9h9p1YUlLtGH7ForrOd2qNsHj1qOUdTRLpWWYRr6I1ehhoCDU/l2MAzWC3Dkj11ioQPqYNw==
X-Received: by 2002:a67:eed3:0:b0:443:8ca0:87a1 with SMTP id o19-20020a67eed3000000b004438ca087a1mr7787302vsp.6.1689089476863;
        Tue, 11 Jul 2023 08:31:16 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id h30-20020a67cb9e000000b0042d50a6c251sm295561vsl.14.2023.07.11.08.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 08:31:16 -0700 (PDT)
Message-ID: <3e51a479-ed30-b11c-a98a-e3a4aa246f0b@gmail.com>
Date:   Tue, 11 Jul 2023 12:31:12 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] rust: fix bindgen build error with UBSAN_BOUNDS_STRICT
To:     Andrea Righi <andrea.righi@canonical.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Kees Cook <keescook@chromium.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230711071914.133946-1-andrea.righi@canonical.com>
Content-Language: en-US
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230711071914.133946-1-andrea.righi@canonical.com>
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

On 7/11/23 04:19, Andrea Righi wrote:
> With commit 2d47c6956ab3 ("ubsan: Tighten UBSAN_BOUNDS on GCC") if
> CONFIG_UBSAN is enabled and gcc supports -fsanitize=bounds-strict, we
> can trigger the following build error due to bindgen lacking support for
> this additional build option:
> 
>     BINDGEN rust/bindings/bindings_generated.rs
>   error: unsupported argument 'bounds-strict' to option '-fsanitize='
> 
> Fix by adding -fsanitize=bounds-strict to the list of skipped gcc flags
> for bindgen.
> 
> Fixes: 2d47c6956ab3 ("ubsan: Tighten UBSAN_BOUNDS on GCC")
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
