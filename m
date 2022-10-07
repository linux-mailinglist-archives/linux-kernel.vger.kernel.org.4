Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CC55F7C5B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 19:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJGRht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 13:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiJGRhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 13:37:47 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1688D18DA
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 10:37:45 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id i9so3522502qvu.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 10:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xNTIyRf+RBhg5JukDW858o3ez1nY+uFTanIdnIwjYwE=;
        b=axcZLMbkwdlAErs2e0QDeAQir0jnBRhgDjvSP5mfif773LRNgil7RTJJ44JAC/7RSf
         pT+pglPENUmxhaGrneRkc2SalERposulk+tqTXvQtwK4L9Go2KfSlukJd+aQ8qYC9Yc8
         mue4Kg1JZhn/lnnG8dJ+1mUoO1FYDZ3JSmKn4ssgQeUTdsLKX9tYj3VXjSyoVVclGpRi
         wAXO+vL4eXHIWt8Q4GsMNlQnRQH4kp9DNSIC8X/6S2KYUcvffA8TL8J+/DtXGDHf+BK+
         vcvq5MVIypIptoDhsyV7nGdhmaFJOpN7SFZyF5pFkCXPlMo1h4pVQUpF3+sx8ED5kkwL
         B+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xNTIyRf+RBhg5JukDW858o3ez1nY+uFTanIdnIwjYwE=;
        b=qFBaz5cBCJCXVPq6tox8HERGhpGhiihPg8Fxal4C2jeKe1MaC/kJW7yyUzntJQQEa4
         eHsB0eV3RMzHJZoSdkqnTWyzXERX1jROU0ieFnKQBCEou5TNsm6u/KjT4eDpF6wp0XXN
         VpThGBneFP9+5vxeHs99wFe11IiePKkeIZVD3mf9d92bZ312v9WN9fpgK/+Mjk4MVNO4
         4n9RpxbWsr+H60iZ2uTgwTDWGhB6UHpxMhc/9nv4M6OdsxyX/nO2y7FpJwDevXmj6Yfn
         w4yZWCVOf6HJdITDJE7/7A1gvOaz1870hgUfYw0kvbvVDHIzNeF+pwy7WlDxB8J3w1M2
         EfUA==
X-Gm-Message-State: ACrzQf2tjDw+b56uoNzXi7daQkovmr8Mj3az5eBHjmq7gIX+LK9DyQZF
        x5a5mNi8xyEYR93qI+7i3/5Rpg==
X-Google-Smtp-Source: AMsMyM6eUd7KVJ28/MYYCooqLj4gm51Q5u3i4TzYWvqsEwPU2HoYgnWVJMdxPMCjsh2/seLzfSZPNA==
X-Received: by 2002:ad4:596b:0:b0:4b1:ee66:1cb8 with SMTP id eq11-20020ad4596b000000b004b1ee661cb8mr5256851qvb.3.1665164264724;
        Fri, 07 Oct 2022 10:37:44 -0700 (PDT)
Received: from [192.168.1.30] (pool-108-4-135-94.albyny.fios.verizon.net. [108.4.135.94])
        by smtp.gmail.com with ESMTPSA id ey23-20020a05622a4c1700b0035cf31005e2sm2500651qtb.73.2022.10.07.10.37.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 10:37:44 -0700 (PDT)
Message-ID: <7a034717-cc9e-c717-7578-3306fe86a5e0@sladewatkins.net>
Date:   Fri, 7 Oct 2022 13:37:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: Reg the next LTS kernel (6.1?)
Content-Language: en-US
To:     Carl Dasantas <dasantas2020@gmail.com>
Cc:     gregkh@linuxfoundation.org, kaiwan.billimoria@gmail.com,
        linux-kernel@vger.kernel.org
References: <CANNVxH_uwnz31kak4fKAVuj8UP4wbWcFiDQ+kFwTametBvixGA@mail.gmail.com>
From:   Slade Watkins <srw@sladewatkins.net>
In-Reply-To: <CANNVxH_uwnz31kak4fKAVuj8UP4wbWcFiDQ+kFwTametBvixGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is now at least the third email I've gotten about Rust support in
the kernel. I've been ignoring them, but I'd like to say something now
and leave it at that.

On 10/7/22 at 11:04 AM, Carl Dasantas wrote:
> Please reconsidrer using 6.1 as the next LTS.
> 
> 6.0 or 5.19 is much more fitting due to not having Rust support, a
> major  change. A lot of the community is hesitant on how Rust will
> work and it would be nice to have a non-Rust capable LTS besides 5.15
> since that is already one year old. Having a more recent non-Rust
> capable LTS would make the transition more smooth as it provides a
> couple years for those of us that are hesitant to see if it goes down
> well or who knows, gets ejected altogether.

The most recent pull request for Rust support was by no means a major
change, it was _only initial support_ for Rust, nothing more than that.
Maybe I'm wrong, but after reading Kees's pull request[1], and reviewing
all the changes (which I also recommend you do, I've dropped a link
below!): it's all minor in the grand scheme of things. It's not changing
much as of me writing this.

Greg, who handles stable releases, doesn't do stable/longterm releases
based on significance, but rather, time. IOW, the yearly LTS kernel is
usually "last kernel of the year." (Greg's words, not mine.) Right now,
that appears to be 6.1 and may or may not stay that way.

I'm truly sorry you (and others, obviously) feel that way about Rust --
I'm not going to weigh in further because I don't have enough experience
with it yet -- but I really don't think it's going anywhere anytime soon.

Thanks,
-srw

[1] https://lore.kernel.org/lkml/202210010816.1317F2C@keescook/
