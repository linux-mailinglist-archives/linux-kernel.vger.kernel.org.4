Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412A46F9CA8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 01:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjEGXQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 19:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjEGXP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 19:15:59 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E5055A6;
        Sun,  7 May 2023 16:15:58 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-54ca586a3b4so2105693eaf.0;
        Sun, 07 May 2023 16:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683501358; x=1686093358;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=39pa+zYrSAhBZrw5yqjNa16fen8+bjk5IjKC1kvtfe0=;
        b=MgV7BeY3PNetBfpSUs4ZzFTektayUzOvgtdhpOnfhw2ArKVafi+taH7PqEsk9ngzf9
         WFKmXpyX1fIDL2VeIrE666jD/3QohQUk9hkltZeRVuyE3Y0a95iTE+E0N4qlva1miBpp
         oYn1Knhm7jdXEzPAvhJjLFulAcckvk7NAekT7jXXr+nIzAIR+5Epbo55G++EL5i4oOvV
         fNrW3L9xOWiOFDosT9kJg2FnYxDWVKRtkVAKQ0vD9CHFPROhXSGvjq4VV1uJfCiYoBbw
         mu1JBn2QePC7RFasraXG5668t5T6IIKUYwHN6cLpPH9SNkAZLahvxJn7eVAdcPkfz7cQ
         sAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683501358; x=1686093358;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=39pa+zYrSAhBZrw5yqjNa16fen8+bjk5IjKC1kvtfe0=;
        b=GbFTQPNA/1x5Y0OMsiPq5NWsXJddkxi8BGh+WGw0B+1V5G5k7NgFBNoocDVH6ow5xu
         HIpQqPgppdUE1tpWVk0XwBdxquWakufxufZNO8mbgjWoafN07gc4BQCcFvGyQaZdRIay
         fNOHimSG6HzDl0bVFvYy5lMz45Bc7diEo4c1MRvC+k6r+/lW3psRxPstxoPCUpA5w8Pi
         g4xN4COWxLsYxLf6WlMamcV+eSZvjfhSynkoTCdmJh5obus2Zk1O3Y537GTTj+c6isZn
         rdkTR4BGV5M6OaPObPepk+9iU7VpPRSjHFokesvpkEzqlleBNyqXDR3Pyn9I6Uxyi3WC
         bmDQ==
X-Gm-Message-State: AC+VfDx0Tafxyi5q8ZReCQdAyKCDNLa37Hk1wWbMbK3QELLSgGf+kjAk
        WB21DWKSU2egCzIaDhy4uZc=
X-Google-Smtp-Source: ACHHUZ6MFPlDYGyBsr9K/EyvsfpP9Y8cKvWHYRK4w8yUtZEctrzDRpWP4UaVgM5wfxD8bThImmqRvQ==
X-Received: by 2002:a4a:3242:0:b0:546:ecb3:f42 with SMTP id s2-20020a4a3242000000b00546ecb30f42mr3713986ooe.8.1683501357694;
        Sun, 07 May 2023 16:15:57 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id u22-20020a4ae696000000b0054f2a39e35fsm2949767oot.44.2023.05.07.16.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 16:15:57 -0700 (PDT)
Message-ID: <44dc8206-a42b-047b-bd2d-62b54fbe8ee8@gmail.com>
Date:   Sun, 7 May 2023 20:15:54 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] scripts: rust_is_available: check for empty libclang
 version
Content-Language: en-US
To:     Matthew Leach <dev@mattleach.net>, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230507084116.1099067-1-dev@mattleach.net>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230507084116.1099067-1-dev@mattleach.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/23 05:41, Matthew Leach wrote:
> If bindgen can't find libclang, then bindgen will panic with the
> following error:
> 
> thread 'main' panicked at 'Unable to find libclang: "couldn't find any
> valid shared libraries matching: ['libclang.so', 'libclang-*.so',
> 'libclang.so.*', 'libclang-*.so.*'], set the `LIBCLANG_PATH` environment
> variable to a path where one of these files can be found.
> 
> This is outputted to stderr, leaving stdout empty. The empty string is
> then passed to get_canonical_version and the following is show to the
> user:
> 
> $ make LLVM=1 rustavailable
> ./scripts/rust_is_available.sh: line 21: 100000 *  + 100 *  + : syntax error: operand expected (error token is "+ ")
> make: *** [Makefile:1825: rustavailable] Error 1
> 
> Note: bindgen's bad exit code isn't caught by 'set -e' since it is ran
> in a subshell.
> 
> Fix this by prnting out a more helpful error message if the output of
> bindgen is empty.
> 
> Signed-off-by: Matthew Leach <dev@mattleach.net>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
