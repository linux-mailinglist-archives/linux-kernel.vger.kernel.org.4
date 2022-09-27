Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A09E5EBF9D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiI0KVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiI0KV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:21:26 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF290D4AA7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 03:21:24 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so5190327wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 03:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=vgh002MbzGIvX+WNWBnASqpqcHfioqqk7UDCUr0BcD0=;
        b=c8x5vdCdVwrSPGUJ1zvOAX9uZUIiOuP+7WTSPGV0j+E5BC2CTlKzoCNqDCQK0dcCRJ
         RUvuyPK/+wwRCIZb1QH3UTRCnfH3yV8f8O64CKllJKBV8wUzPtHXJZeeHaJ0ARHobGmV
         pyK64xm5laaM1/dinPPzsezrdg22/KQc8PfkluC6Z1bg06nMaKYjsgKQBHJcQA6jBk+k
         1gUWEj5rPDlnsM6dKUFiOq+IzDP73Xo41tfX3G3BBlRZkaROLNOS0/wPk/ZaNsy6QfLn
         UmoyajtfWyLolR2Q4ZKet6eJQfNScXlzkaZ7rcj6Mj3ZioSuSC9cP7bnwo4XjnPmpztJ
         QTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=vgh002MbzGIvX+WNWBnASqpqcHfioqqk7UDCUr0BcD0=;
        b=fP+JiUc6c6SunfR2khjY7t5Kbxqsvr8QP1macARvEHHjqXZD1aJxhR9UPt5HL45KaC
         gFuRZu42m/qkFZcRe1IZfZlCG43S0iP4bIFMfrM10Qh4X2k9rSq3/W5TcxEsDYsSCOMZ
         1vnulSG0Ymv8qRKOBMa6/j507MlC1XCi9ObQvh8AZE9919inYU2PsaniZmK6sJ/EJl0U
         xa73mxxDDKezzvH6+7I4IutEnDDWBUf+67/hSL4p5yXO52qj3c/woi4e+p9+Ryu5M3KG
         1tdd9660MfNSSG8trbNOMi66myWTN2tKEBcmz10grCiCFefESh0hxJ/xLWIsN/BX3hcv
         Rc+g==
X-Gm-Message-State: ACrzQf2NpDqCBlxGpD7oJt7IKIuBAlx5Bnbu1ZLVQof4rpXXxyquDBSV
        FCqonN6RVVemG74NGHhsOOMDsQ==
X-Google-Smtp-Source: AMsMyM5KigCTNRehqfnJPf5L8G60+lZ4zECOx1Of9PDTtLY1fplC++hd5EXvPKgw9T2j3xArGysK3A==
X-Received: by 2002:a05:600c:524b:b0:3b4:8c0c:f3b6 with SMTP id fc11-20020a05600c524b00b003b48c0cf3b6mr2137807wmb.50.1664274082579;
        Tue, 27 Sep 2022 03:21:22 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id l9-20020a5d4809000000b00228b3ff1f5dsm1503944wrq.117.2022.09.27.03.21.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 03:21:21 -0700 (PDT)
Message-ID: <c5c5cedb-4b32-2569-1d55-fc95cad1b260@isovalent.com>
Date:   Tue, 27 Sep 2022 11:21:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/2] libbpf: add fPIC option for static library
Content-Language: en-GB
To:     Xin Liu <liuxin350@huawei.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        yanan@huawei.com, wuchangye@huawei.com, xiesongyang@huawei.com,
        zhudi2@huawei.com, kongweibin2@huawei.com
References: <20220924101209.50653-1-liuxin350@huawei.com>
 <20220924101209.50653-2-liuxin350@huawei.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220924101209.50653-2-liuxin350@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sat Sep 24 2022 11:12:08 GMT+0100 ~ Xin Liu <liuxin350@huawei.com>
> Some programs depned on libbpf.a(eg:bpftool). If libbpf.a miss -fPIC,

Typo "depned"

> this will cause a similar error at compile time:
> 
> /usr/bin/ld: .../libbpf.a(libbpf-in.o): relocation
> R_AARCH64_ADR_PREL_PG_HI21 against symbol `stderr@@GLIBC_2.17' which
> may bind externally can not be used when making a sharedobject;
> recompile with -fPIC
> 
> Use -fPIC for static library compilation to solve this problem.
> 
> Signed-off-by: Xin Liu <liuxin350@huawei.com>
> ---
>  tools/lib/bpf/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> index 4c904ef0b47e..427e971f4fcd 100644
> --- a/tools/lib/bpf/Makefile
> +++ b/tools/lib/bpf/Makefile
> @@ -91,9 +91,10 @@ override CFLAGS += $(INCLUDES)
>  override CFLAGS += -fvisibility=hidden
>  override CFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64
>  override CFLAGS += $(CLANG_CROSS_FLAGS)
> +override CFLAGS += -fPIC
>  
>  # flags specific for shared library
> -SHLIB_FLAGS := -DSHARED -fPIC
> +SHLIB_FLAGS := -DSHARED
>  
>  ifeq ($(VERBOSE),1)
>    Q =

Hi, the two patches look OK to me, but it would be nice to have a bit
more context on what the flags do other than “fixing this particular
issue” and how they improve bpftool security. It would also be
interesting to have a note on what it does on various architectures, my
understanding is that only some archs are supported (I read AArch64,
m68k, PowerPC and SPARC), I guess the flags are silently ignored on x86
for example?

Thanks,
Quentin
