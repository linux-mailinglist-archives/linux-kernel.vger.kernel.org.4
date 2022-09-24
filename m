Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFAB5E876E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 04:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbiIXCbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 22:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbiIXCbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 22:31:21 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8C4ED5C6;
        Fri, 23 Sep 2022 19:31:20 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso8755871pjq.1;
        Fri, 23 Sep 2022 19:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=PlrfWlpdqt+xjgKL+9XUICyPlvBbkUl0DMPU2Xl4+oc=;
        b=Q7ZkxgV/zpidkkl8W5NQ9L17EWFBen+v6rHHNZhWZeObfzSJYsm5LtFtAfu/tX5R13
         OialadSdL+h7AunTW40BC5eE3YQAdv8BCPPHMP7fieqHd/NT/RYt+49rvKw/UU63JNSZ
         MtAgwo6W1G69cWLTgDdHtFmK3dDp5xwM0Vokoqcx69SmwN7QYQ39gcBBMflKY0Mk1/gm
         z5WIaiQ9oU79KYeoBZuBa7l0kuv1MgLtxfozDt4qtbm0d5AGqW9KHp921W23zq2OxjeZ
         ytvSpnYblDxatYSl+XB9lzwe2lV6EtKPzaBceWBD0zaen7kswqvWVrQc/OtyJaMARPzO
         S5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=PlrfWlpdqt+xjgKL+9XUICyPlvBbkUl0DMPU2Xl4+oc=;
        b=4rYU/fN8RaozX0zjaa8SUQx6kHPAzPGtZApTS1B+D4Gm6ukXNdOvFevOSJ7grqUrj3
         /oGkYLoPNE8gveiRvnkn0WbkOYsg4dVIbePXfNSjryXeW45It/sJ5kU5z031dugkks0G
         p+TGdo/tqC7qZHuGxXWlCQ+Nzju0xKz4UB7GpPBT0n9yBe5Jbu6cQhO9RAvtlmEbU0je
         WauyDCnjLFjdPZ4sF0cTij93IkwQVvKnz3N52GlowLsCsbHMPP2uJkLXO6SxmYM4wij2
         QkdN1oEh0xd3mr0puu6RNd58xYxteObV3PSY9Q5j+hVRy6CfRUgCOxPCaui/DTCpQ/Y8
         qzSg==
X-Gm-Message-State: ACrzQf2uC63rA6XWjIWX/6v2DuhSPh0M0DX/jl0sYdLF2rO0rUBTOHMM
        /ik35P0HluVmCLGCXxyu28Q=
X-Google-Smtp-Source: AMsMyM6jvUot8t6GrHmTP41IkTux0bIlddfaTyuuU2n8pCxP/xihsPczbyUjdGWhHOIsNbeIbXyhaQ==
X-Received: by 2002:a17:902:efd2:b0:176:b888:2481 with SMTP id ja18-20020a170902efd200b00176b8882481mr11128332plb.144.1663986679861;
        Fri, 23 Sep 2022 19:31:19 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id e23-20020aa79817000000b00540b35628a4sm7230424pfl.123.2022.09.23.19.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 19:31:19 -0700 (PDT)
Message-ID: <d9e15a0b-0ec9-894b-b0a6-3425af2ddeff@gmail.com>
Date:   Sat, 24 Sep 2022 11:31:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] string: Rewrite and add more kern-doc for the str*()
 functions
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Akira Yokosawa <akiyks@gmail.com>
References: <20220922062817.2283352-1-keescook@chromium.org>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20220922062817.2283352-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Wed, 21 Sep 2022 23:28:17 -0700, Kees Cook wrote:
> While there were varying degrees of kern-doc for various str*()-family
> functions, many needed updating and clarification, or to just be
> entirely written. Update (and relocate) existing kern-doc and add missing
> functions, sadly shaking my head at how many times I have written "Do
> not use this function". Include the results in the core kernel API doc.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Follow up to https://lore.kernel.org/lkml/20220902223507.2537469-1-keescook@chromium.org
> Note that this is on top of my recent fortify-string.h series:
> https://lore.kernel.org/lkml/20220920192202.190793-1-keescook@chromium.org/
I wanted to test this change, but I've not able to find a good commit
where the fortify-string.h series and this one can be applied cleanly.

Would you mind creating a topic branch somewhere on your git tree
and sharing it?

Regards,
Akira

> ---
>  Documentation/core-api/kernel-api.rst |   3 +
>  include/linux/fortify-string.h        | 133 ++++++++++++++++++++++++--
>  lib/string.c                          |  82 ----------------
>  scripts/kernel-doc                    |   4 +
>  4 files changed, 130 insertions(+), 92 deletions(-)
> 
[...]
