Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775B0730505
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbjFNQfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234558AbjFNQf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:35:26 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896622689;
        Wed, 14 Jun 2023 09:34:55 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1a2c85ef3c2so5496753fac.0;
        Wed, 14 Jun 2023 09:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686760495; x=1689352495;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P02UcLI2//J8LvUgRFLkUqu+ureKnlEB4HrY9Uc3j4k=;
        b=J0jSJqDukYcfhA7sISg8YT5j2AJRPy7WWscY0Pmtmu1xD+4jgXykkAo2CVR7ZJbtH2
         LxJMgSOX9Tg84S4auSG+Dq4bdv6+pfcoAoGw0s+Kk3HbW7J93Rt+B3bMKIPPwBykdcai
         dUor7roPb9xBLCf2UMlIcU4vkKdW4qmSSnleDsM6wQxxBd/MhNTCJSUlnsOHyI73W7sb
         QR3xW8HF6/YWt7RuA0xR79c2aH0UnKegkHc+zZyDEGgOgp02w6poDo5FYWyG0LTlDF3n
         juTk/s3ZSRipEKSmANiG9qYT4AmNRq8DglCgqd8Imj5iR7qnG2im3Oa8eFSh/8ZmjGCl
         ZNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686760495; x=1689352495;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P02UcLI2//J8LvUgRFLkUqu+ureKnlEB4HrY9Uc3j4k=;
        b=ZAymgT/AAYGAD5jTszhz9rbq1QwYn1ZFM9PkhCXK2JRY3dU/0yjyaO7Tpk/lzouxN7
         Sd2nnf2EmOex3+nRzk1g2q92pE+aQEU37dOHneShFhK33eI7w99CLhLLUJlw1lY5IcBf
         aJ8JIGj9bj8hNtOkwMhNqo3/18hAf9K7D6UmajjKSRH434eQ0GBw+6kynqwPuronxhKk
         5Hd8Rf+UB9z5WyEz6tmOMnjSIQTnz1xSDHzJfxohio3Kwqrd2jW5km19LuNpWoJ58/uv
         VYSy6d+2upohLpyvuSnRrnibKfAFX9WmZC7lomWYUrCK4oJCMoxxSXsvONFaOGZWYLrI
         cc5Q==
X-Gm-Message-State: AC+VfDzbc/V4AIsT9gt7HN7QWNbq+t7pMc+DW1pAm4MFvtXi3GPl57wm
        6g5yWWBNTG0fEXUgGSbeeqA=
X-Google-Smtp-Source: ACHHUZ6LPh/lBfJJZiZ/JXibWTrWDOw5+WfS7pNTIAJ13gUHKTNkU1bHLYeyD6Kf/khV7txSsY69SA==
X-Received: by 2002:a05:6870:a695:b0:19e:475:9df1 with SMTP id i21-20020a056870a69500b0019e04759df1mr13490656oam.27.1686760494607;
        Wed, 14 Jun 2023 09:34:54 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id ld10-20020a0568702b0a00b001762ce27f9asm8848922oab.23.2023.06.14.09.34.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 09:34:54 -0700 (PDT)
Message-ID: <6e61f06f-2411-0bcb-926b-0a6927096f20@gmail.com>
Date:   Wed, 14 Jun 2023 13:30:54 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] rust: allocator: Prevents mis-aligned allocation
Content-Language: en-US
To:     Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Fox Chen <foxhlchen@gmail.com>,
        John Baublitz <john.m.baublitz@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andreas Hindborg <nmi@metaspace.dk>, stable@vger.kernel.org
References: <20230613164258.3831917-1-boqun.feng@gmail.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230613164258.3831917-1-boqun.feng@gmail.com>
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

On 6/13/23 13:42, Boqun Feng wrote:
> Currently the KernelAllocator simply passes the size of the type Layout
> to krealloc(), and in theory the alignment requirement from the type
> Layout may be larger than the guarantee provided by SLAB, which means
> the allocated object is mis-aligned.
> 
> Fixes this by adjusting the allocation size to the nearest power of two,
> which SLAB always guarantees a size-aligned allocation. And because Rust
> guarantees that original size must be a multiple of alignment and the
> alignment must be a power of two, then the alignment requirement is
> satisfied.
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Co-developed-by: Andreas Hindborg (Samsung) <nmi@metaspace.dk>
> Signed-off-by: Andreas Hindborg (Samsung) <nmi@metaspace.dk>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Cc: stable@vger.kernel.org # v6.1+
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
