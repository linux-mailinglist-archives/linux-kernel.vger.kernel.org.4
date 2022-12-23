Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E94654CF1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 08:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbiLWHmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 02:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiLWHmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 02:42:09 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44EE1572E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 23:42:07 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id e13so1654016ljn.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 23:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X7B4Jzr3nCQ8aBE4OWYgB5L9zdAQEcYwFl6VLpITFEA=;
        b=ezlYFg+E2H4kErUPN9PR8SWR54phwDtF/RGqRAaG5FNgC3wkWNeksV20QULgYvbSf1
         lVxBKgGZkNOYdK/3DqtNXIx7IlMY761dkZ/a6N5lWH3hgfXR7g1/6XyHrngMm4LtHGAc
         2G6y+2bvb86UcASCok0iqtModQ9Go124J4gGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X7B4Jzr3nCQ8aBE4OWYgB5L9zdAQEcYwFl6VLpITFEA=;
        b=x/lXStnXNGA0NgAeOTD4Cp7ADmER5r1WMBCfo6VbRJy8Adn8NG0Zl2PJFQ2N89tMs2
         t5xjfWC2l7XK5X6Q2nf3CAeGLbBVo15evdRAtdTli4jUm18TYelmGLq3nzhAu7g3JFyQ
         BmI9B8W5SrDqRuGxc2POssJJPhKvzhJC60/gjqjTaoX73y3A0NND+tRFVO796y4IWk99
         KDXhKgRzt6rzHFXeiE80KBcty0GvoLYwNboSKHRxgzquAw77GgfoJbhs5rZYxQNY8PSW
         WWhFclJEUjYkR8IzGxbVfnHyydcEFgDtDAXGhSJRpyBy9MEO+CbJWYNy3Mp2n4B5huQu
         A78Q==
X-Gm-Message-State: AFqh2koviVqi+rzWOI20o6gs617H6dTlmMwKI29JI1NLbGoO4kWFal/f
        5/+FenhCVKojAuzS+wHHOE4mhA==
X-Google-Smtp-Source: AMrXdXvCU49cLUvGM3VawyPWCHi+gaF9bGfdFHytOPjdGuJcpyMZNyZmVaK3bYzmg++lSpPBs5g0Ug==
X-Received: by 2002:a2e:a481:0:b0:277:913:aed0 with SMTP id h1-20020a2ea481000000b002770913aed0mr2210750lji.4.1671781326312;
        Thu, 22 Dec 2022 23:42:06 -0800 (PST)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id i63-20020a2e2242000000b002799d097c02sm294953lji.32.2022.12.22.23.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 23:42:05 -0800 (PST)
Message-ID: <590d85c7-ef06-78d8-2459-d60739288c03@rasmusvillemoes.dk>
Date:   Fri, 23 Dec 2022 08:42:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] string.c: test *cmp for all possible 1-character strings
Content-Language: en-US, da
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20221222140506.1961281-1-linux@rasmusvillemoes.dk>
 <Y6R0qP5orygWO9vS@zx2c4.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <Y6R0qP5orygWO9vS@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/12/2022 16.15, Jason A. Donenfeld wrote:
> On Thu, Dec 22, 2022 at 03:05:06PM +0100, Rasmus Villemoes wrote:

>> This is only intended to help find other latent bugs and can/should be
>> ripped out again before v6.2, or perhaps moved to test_string.c in
>> some form, but for now I think it's worth doing unconditionally.
>>
> This probably belongs in some config-gated selftest file that can be
> compiled out, rather than running unconditionally on every boot, right?

I believe this was already answered in the last paragraph of the commit log.

Rasmus

