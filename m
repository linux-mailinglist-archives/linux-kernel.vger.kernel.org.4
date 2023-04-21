Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369596EADC5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 17:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjDUPLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 11:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjDUPLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 11:11:15 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F5D12C9A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 08:10:54 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-506c04dd879so2982373a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 08:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682089852; x=1684681852;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1U9T8AS9cjrS3s9uITV3twM/U96KCqFNw0iG6buaIPE=;
        b=zmhDusaW8TTAW6Vr95DNpJ5jqHZ5HwnfZEdA9VP2+WDvNqA23UvxwzQv8h8V1mBMYF
         8biWtA8zCbdwRDNRXP80CcYVjbx5YHu/id55Z9bBFr2q2QW6nt2WpmHigPU2UoqqOCm6
         4nNkUl+2s12mHW216cw0SqklmX9mJRLNrv32tywdYz354himN7+Cp839Qb7+z8Q95W+1
         /fajuVy/rdfRN9fE/nh28IJVZvOUj3cTMTNrsG3aTl+Lxx2/rFY0Pq1WGQ/OChlomJUJ
         NwnY9vGAO8EuQt+JffUfIE639JdiW+7VyL5IKJokIqHqIhvI3BLr8ICKew/oEoKiJsgg
         EbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682089852; x=1684681852;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1U9T8AS9cjrS3s9uITV3twM/U96KCqFNw0iG6buaIPE=;
        b=BQQzZWrMKh+FL8Ca6N3Gf9bnNqXPWTQAG4UePLZ/g0rXEaXAwZ18ZVEy74OY8MplWC
         Mg8xXSj/6T8YtSaAV4eCL2yUH2zCB0DZpqwhGhFL9q/3GD0NDnQ9yeX1is6jpbFaq9I4
         W+i2y79ehiWWC1nOvQBvlINLmwSGlEsdYCQ/7sxoHYhTwa6hfXkAZg8jSjDr0KKerVem
         mOiVTHj1WWehW10fl03czwXJn5Av6ImNHHMmGolDBIr2sJrTl0XSkKYV7Nj2AhRy4YwR
         0b0LF8CAXlw1vjEIlJWPAma+KF8x8IFcUhLcBxE42+MKRxFYzdcJTS6l17z/Iqf2lptB
         vHMw==
X-Gm-Message-State: AAQBX9dxxoFzMBHR3+4pnaliljNePsgLR4pJPRL+a6FbJxOxDhsRwY7C
        EJibRyZ+9aALYnw4/RPeX20FHQ==
X-Google-Smtp-Source: AKy350ZUvt8W0YLUNRC+2yZAEZEoEaJ9B2Ng8mmI1fbNoP/iiYmsOVan9Q7Gk6nHMn7GZKhJMkV7eg==
X-Received: by 2002:a17:906:52cc:b0:94e:6504:d134 with SMTP id w12-20020a17090652cc00b0094e6504d134mr2574638ejn.42.1682089852729;
        Fri, 21 Apr 2023 08:10:52 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.230])
        by smtp.gmail.com with ESMTPSA id n21-20020a1709062bd500b0094e729d333fsm2131198ejg.222.2023.04.21.08.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 08:10:52 -0700 (PDT)
Message-ID: <e46dd2bb-16d1-0c99-56f0-f8c2c4bbc79b@linaro.org>
Date:   Fri, 21 Apr 2023 16:10:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] Kconfig.debug: disable CONFIG_FRAME_WARN for KASAN_STACK
 && CC_IS_CLANG by default
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     joneslee@google.com, Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        zhaoyang.huang@unisoc.com,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Mark Brown <broonie@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>, nogikh@google.com
References: <20230421130111.4041641-1-tudor.ambarus@linaro.org>
 <5d13e927-3713-4b9e-b007-6be5671d46f2@app.fastmail.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <5d13e927-3713-4b9e-b007-6be5671d46f2@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Arnd,

On 4/21/23 15:30, Arnd Bergmann wrote:
> On Fri, Apr 21, 2023, at 15:01, Tudor Ambarus wrote:
> 
>> The conclusion is that when KASAN is enabled the stack usage increases a
>> bit, but nothing unmanageable ~30-70 bytes, whereas when enabling
>> KASAN_STACK the stack usage is excessive, from ~1.7K to ~5.8K for these
>> cases.
>>
>> Disable CONFIG_FRAME_WARN for KASAN_STACK && CC_IS_CLANG by default.
>> Adventurers can still override the default value by input prompt or
>> explicit values in defconfigs in case they feel that some real warnings
>> are missed.
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> 
> I think we are still better off with the warning enabled. When someone
> really wants to run a kernel with KASAN_STACK enabled, they should have
> a chance to see what they are getting into and not report any runtime
> bugs that come from stack overflow. 
> 

Are such stack overflows warnings reliable when we know that stack
instrumentation causes excessive stack usage? Until clang is fixed one
shall hunt frame-larger-than warnings with KASAN_STACK disabled.

Cheers,
ta
