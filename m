Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131E262BB53
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239185AbiKPLTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239182AbiKPLS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:18:28 -0500
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669A630568
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:06:57 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id l14so29326800wrw.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 03:06:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YxTM59J83z+pazLL7ANp+YpqFi4aASa5TkwxlBCrr4Y=;
        b=UJBbiTveaVBEF/8xIllp8lsWbz44qorpp9h/W6CMI0w0KfmsC9na9cl27rEAb6C9eL
         /H9dG2kVNLol2Cf7kxhGO4oxkJBhlD2/XJk0fFO+U9DBibBwxp/TZ4W1a6iS3NFFxNZw
         zFMQhbRzhbRYwv/+Qjn+9HZRXPQyI3eQplS7VfG+0mZSKdxrEdIoeWGm9AeMyHubxOcO
         TdwYmXVtYUBoKe4vpTNkdHbh6vBDgec18RGvYKR6IDty/NwpCh+fLWYJOJc2N78upUfp
         jMh/4/f396VOpWdGj5pWg5zQAK/VGbkrn56B/f3724Kmzp/kEZ2PJkqv3XylZDRigWnK
         9Gbg==
X-Gm-Message-State: ANoB5pmtdCyX34/lV7XB0lNqWwwoc3d5CmsxA4y1XJ+grqUCNgyoTwzD
        Vp9sNkUkP2ZSk28g3vo9VVs=
X-Google-Smtp-Source: AA0mqf713gOnjaw7TYQHBams3opu6yqkgjhBrSfCICHeCz5VfVKYJ9eGPn0LvRt1QeTrL7kb4KAkZw==
X-Received: by 2002:adf:e6ca:0:b0:22c:e009:a201 with SMTP id y10-20020adfe6ca000000b0022ce009a201mr13838286wrm.70.1668596815876;
        Wed, 16 Nov 2022 03:06:55 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id z11-20020a05600c0a0b00b003c6f1732f65sm1888494wmp.38.2022.11.16.03.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 03:06:55 -0800 (PST)
Message-ID: <3cda3e14-8029-10d8-4377-3a927057cff9@kernel.org>
Date:   Wed, 16 Nov 2022 12:06:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2] misc: hpilo: relicense HPE iLO driver as Dual MIT/GPL
Content-Language: en-US
To:     matt.hsiao@hpe.com, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        christophe.jaillet@wanadoo.fr, gustavoars@kernel.org,
        nishadkamdar@gmail.com, torvalds@linux-foundation.org,
        dhaval.experiance@gmail.com, viro@zeniv.linux.org.uk,
        arvind.yadav.cs@gmail.com, standby24x7@gmail.com,
        wfp5p@virginia.edu, prarit@redhat.com, tj@kernel.org,
        adobriyan@gmail.com
References: <20221116103457.27486-1-matt.hsiao@hpe.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20221116103457.27486-1-matt.hsiao@hpe.com>
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

On 16. 11. 22, 11:34, matt.hsiao@hpe.com wrote:
> From: Matt Hsiao <matt.hsiao@hpe.com>
> 
> Currently, the hpilo driver is licensed as GPL. To run OpenBSD on HPE
> servers with BMC (HPE iLO) functionality, a dual MIT/GPL license is needed
> for porting the hpilo driver to OpenBSD.

Acked-by: Jiri Slaby <jirislaby@kernel.org>

> Signed-off-by: Matt Hsiao <matt.hsiao@hpe.com>
> ---
> 
> Hello contributors in the CC list,
> 
> Thanks for your contributions to the hpilo driver. Please kindly review
> the license change and hopefully you would agree and approve it. Thanks!
> 
> Patch v2:
> ---------
> - Change MODULE_LICENSE to Dual MIT/GPL too
> 
>   drivers/misc/hpilo.c | 4 ++--
>   drivers/misc/hpilo.h | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/hpilo.c b/drivers/misc/hpilo.c
> index 8d00df9243c4..137063857e8d 100644
> --- a/drivers/misc/hpilo.c
> +++ b/drivers/misc/hpilo.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>   /*
>    * Driver for the HP iLO management processor.
>    *
> @@ -924,7 +924,7 @@ MODULE_VERSION("1.5.0");
>   MODULE_ALIAS(ILO_NAME);
>   MODULE_DESCRIPTION(ILO_NAME);
>   MODULE_AUTHOR("David Altobelli <david.altobelli@hpe.com>");
> -MODULE_LICENSE("GPL v2");
> +MODULE_LICENSE("Dual MIT/GPL");
>   
>   module_param(max_ccb, uint, 0444);
>   MODULE_PARM_DESC(max_ccb, "Maximum number of HP iLO channels to attach (8-24)(default=16)");
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

