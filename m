Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7116D7C8F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 14:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237986AbjDEM12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 08:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237878AbjDEM1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 08:27:25 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D785FF0;
        Wed,  5 Apr 2023 05:27:03 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id ja10so34250514plb.5;
        Wed, 05 Apr 2023 05:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680697623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nSvnKg+6McgJprhw+if0EMirzUlxLZrKLELfH8kmkS0=;
        b=fM4nuxkN1Ei+BgN0LfgInD/FqvdDFyrcUJt6tJ9MGBcbHfDzOvDgdjMfDv1xwok/Aa
         9RjaLwxsBr2IuiM89fnTkhckVTwYkS2yjfmKhfiwNcxjPH4ByAuC8n6iaFqACu1uL670
         pxXkSSGIikzz/GeTjhj1sBDY5Spq7ZwhOVsjk92/0K4Kp2QZcn2z02Ocb3w3qkhfwtWq
         U9AysHle5TBRsinBVNCyhTa28PO84v+vV+OItmsQQZZgdYAmnhsmhuFAUMrg9s9tdJAY
         mN9taF/HO+BqEHwFP2OBMidoI8e+lQDL5cPUxlJ+UjygOvwR+YotbhUdGUwEFwN1KP1k
         GYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680697623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nSvnKg+6McgJprhw+if0EMirzUlxLZrKLELfH8kmkS0=;
        b=BrPKWxrZcDFs2UUNq1vdzPudspG83JVG4Ue3apwn8ep/2Cs7uqn5AyDSdQ4Skq1rHc
         f0Tfhxe8Vjthfhsr98fU2wqzTuGr6dRZHNsxoQ815SvHtC2upiq7uf/Q1SpvZ7IbAZW2
         95AUpakE94D4+OqL1Op0UHgEI7O1wWmswhNuNL9dL23r+EorL4TNg2BZpLSyDI6CYgaN
         ipwkB6qIrCT6sehyYJkf2UOYnkwFWLVD8eoGxgicWaCX0tCI+Zizq02dUaqxXBYzP0e+
         +RTlGbkAIC8BJwqvPB8pJSrYrMIsCt+uwrlB++kAy5lVAAziIO6vnkxqy2WRZHEu/aWZ
         /Irg==
X-Gm-Message-State: AAQBX9cVYvu559dGXwAPoHs9pPRc2ESt0GHJF1+etLO1LaklLikdaHiX
        Y+BCntxIWB87d1626HNuK3qhq8RWYej0MGLp
X-Google-Smtp-Source: AKy350ZMkRxurclMd6nCYANZunIt1p5smgB/rGPfUYGFhir3yWVrLgE+h08qu9R7KxqBDQ43zijgbg==
X-Received: by 2002:a17:90b:1c91:b0:23b:4388:7d8a with SMTP id oo17-20020a17090b1c9100b0023b43887d8amr6718995pjb.21.1680697623102;
        Wed, 05 Apr 2023 05:27:03 -0700 (PDT)
Received: from [192.168.0.6] ([211.108.101.96])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902789700b0019ac7319ed1sm10055186pll.126.2023.04.05.05.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 05:27:02 -0700 (PDT)
Message-ID: <b7a7c5d7-d3c8-503f-7447-602ec2a18fb0@gmail.com>
Date:   Wed, 5 Apr 2023 21:26:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH RFC] Randomized slab caches for kmalloc()
To:     "GONG, Ruiqi" <gongruiqi1@huawei.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
References: <20230315095459.186113-1-gongruiqi1@huawei.com>
Content-Language: en-US
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
In-Reply-To: <20230315095459.186113-1-gongruiqi1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/2023 6:54 PM, GONG, Ruiqi wrote:
> When exploiting memory vulnerabilities, "heap spraying" is a common
> technique targeting those related to dynamic memory allocation (i.e. the
> "heap"), and it plays an important role in a successful exploitation.
> Basically, it is to overwrite the memory area of vulnerable object by
> triggering allocation in other subsystems or modules and therefore
> getting a reference to the targeted memory location. It's usable on
> various types of vulnerablity including use after free (UAF), heap out-
> of-bound write and etc.
>
> There are (at least) two reasons why the heap can be sprayed: 1) generic
> slab caches are shared among different subsystems and modules, and
> 2) dedicated slab caches could be merged with the generic ones.
> Currently these two factors cannot be prevented at a low cost: the first
> one is a widely used memory allocation mechanism, and shutting down slab
> merging completely via `slub_nomerge` would be overkill.
>
> To efficiently prevent heap spraying, we propose the following approach:
> to create multiple copies of generic slab caches that will never be
> merged, and random one of them will be used at allocation. The random
> selection is based on the location of code that calls `kmalloc()`, which
> means it is static at runtime (rather than dynamically determined at
> each time of allocation, which could be bypassed by repeatedly spraying
> in brute force). In this way, the vulnerable object and memory allocated
> in other subsystems and modules will (most probably) be on different
> slab caches, which prevents the object from being sprayed.
>
> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
> ---

I'm not yet sure if this feature is appropriate for mainline kernel.

I have few questions:

1) What is cost of this configuration, in terms of memory overhead, or 
execution time?


2) The actual cache depends on caller which is static at build time, not 
runtime.

     What about using (caller ^ (some subsystem-wide random sequence)),

     which is static at runtime?

