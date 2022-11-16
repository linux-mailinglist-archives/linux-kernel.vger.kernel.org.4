Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E3A62B73C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbiKPKKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbiKPKKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:10:44 -0500
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110691E3FD
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:10:44 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id h186-20020a1c21c3000000b003cfe48519a6so1258549wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:10:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ty1Id4ftuY2J/moyYs8ypYuJmz79C5rQqwhw+oW8TYY=;
        b=JXU+Fm0JcrIvKAxwYGIIkiDhpYhj6dmDwMAaXiFK6nnSugGOwOpB4b0yHSBzEH8t2v
         Jotjz3V8DkTe0zPxtK5UKqUi6oZmxmXMrCnRj4LGlUSGQwYOD0sl8PYL36+F8ytV6T9y
         H4cENq0SL0nNhbWM7BWdPI+s/rWuhHSC4XuwIr4v9PJda/j4xEDoBBS/ZjuNP0ByTzRF
         R3X7wcSmuNDnXVsvLyASACxORkDILCf1uOsQXFh1NnoyJxky9PAr7ebJxDBiJWPiP5+c
         7MWLNBvRO5w+lJiWIhy/b++bIAL/hX4psxWX3pbtEwDTwKKaKNu1yCj4xY5hwXM/jNtO
         yJUg==
X-Gm-Message-State: ANoB5pl+4YzwHjg7CTHQkE+DUWI4+uJknb7xBWwxmhm/0PeFynHsQG73
        K1PsXod6XvzoIFutViT+xPpNn7EsN0o=
X-Google-Smtp-Source: AA0mqf4QP0oXLZAAGkkqAlP2YKjaYDEAHbaoz2IzqW+bp+iIvI4Q1I9Of0sJCm4hdCvIYc2rqkhHEw==
X-Received: by 2002:a05:600c:3d0c:b0:3cf:8279:c80c with SMTP id bh12-20020a05600c3d0c00b003cf8279c80cmr1597841wmb.169.1668593442383;
        Wed, 16 Nov 2022 02:10:42 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id e1-20020a5d5001000000b002368424f89esm14435384wrt.67.2022.11.16.02.10.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 02:10:41 -0800 (PST)
Message-ID: <77be348e-3e9d-7bbf-5581-95d78124daa7@kernel.org>
Date:   Wed, 16 Nov 2022 11:10:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] misc: hpilo: relicense HPE iLO driver as Dual MIT/GPL
Content-Language: en-US
To:     matt.hsiao@hpe.com, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        christophe.jaillet@wanadoo.fr, gustavoars@kernel.org,
        nishadkamdar@gmail.com, torvalds@linux-foundation.org,
        dhaval.experiance@gmail.com, viro@zeniv.linux.org.uk,
        arvind.yadav.cs@gmail.com, standby24x7@gmail.com,
        wfp5p@virginia.edu, prarit@redhat.com, tj@kernel.org,
        adobriyan@gmail.com
References: <20221116094712.14312-1-matt.hsiao@hpe.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20221116094712.14312-1-matt.hsiao@hpe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16. 11. 22, 10:47, matt.hsiao@hpe.com wrote:
> From: Matt Hsiao <matt.hsiao@hpe.com>
> 
> Currently, the hpilo driver is licensed as GPL. To run OpenBSD on HPE
> servers with BMC (HPE iLO) functionality, a dual MIT/GPL license is needed
> for porting the hpilo driver to OpenBSD.

What about the MODULE_LICENSE() change to "Dual MIT/GPL" too?

Acked-by: Jiri Slaby <jirislaby@kernel.org>

> Signed-off-by: Matt Hsiao <matt.hsiao@hpe.com>
> ---
> 
> Hello contributors in the CC list,
> 
> Thanks for your contributions to the hpilo driver. Please kindly review
> the license change and hopefully you would agree and approve it. Thanks!
> 
>   drivers/misc/hpilo.c | 2 +-
>   drivers/misc/hpilo.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/hpilo.c b/drivers/misc/hpilo.c
> index 8d00df9243c4..6a06b6485950 100644
> --- a/drivers/misc/hpilo.c
> +++ b/drivers/misc/hpilo.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>   /*
>    * Driver for the HP iLO management processor.
>    *
> diff --git a/drivers/misc/hpilo.h b/drivers/misc/hpilo.h
> index d57c34680b09..581dfd7834b8 100644
> --- a/drivers/misc/hpilo.h
> +++ b/drivers/misc/hpilo.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */
>   /*
>    * linux/drivers/char/hpilo.h
>    *

-- 
js
suse labs

