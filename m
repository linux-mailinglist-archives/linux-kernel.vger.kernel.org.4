Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDC16056CA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 07:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiJTF3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 01:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiJTF3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 01:29:37 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D91D110
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 22:29:31 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id a67so28222834edf.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 22:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L5uleha1nzv3NDWgFG6RrLUbIce/IAvJbRw2gmfM1nA=;
        b=srti/7oukxRPtb2grUZHENT66I4LILCUrUfd7ojAmtn382Wyv7k5sbPiF3OVSXnh2T
         3wklQxQZ2t3IUaZ2m8l/ngPT3gLsAVREUTWivdYrAcj4CwqAtX30lwGr2xyW2yr5G2+l
         X1Z8CvpD2XIA0Kd9pEuaKemfo0iQugYJT8LdVNgXxzQUYmMjOSksFPAowjza0dLnV3Fx
         DVk3QlV6MiQqAaoNk697eKgCXcrql7dAoJXRHOtsrGq6FKYghKQMyX2/Rid7ubFnOfKZ
         xcNp4g8dNb3IHM1ws+EZhrkd93kCPdmFDXzBbRC+OTJt/LrnOLI66hTM4AfYnfLON2rN
         UNSw==
X-Gm-Message-State: ACrzQf1navW18LYHET0R0sGJb74Y91t+1LYl2ERWilJ2pIrfpmeBTXE7
        eUnGRU6jA2HKODtGMwh3WQGl8Y7KuXrg8w==
X-Google-Smtp-Source: AMsMyM5cRIqOwXdmST/afDgqAJBDMBSMmyDmi4u4wtHf0dwji3CpnU+xSolltQn1imdV6iXcMdliWQ==
X-Received: by 2002:aa7:d651:0:b0:459:d1c:394e with SMTP id v17-20020aa7d651000000b004590d1c394emr10827647edr.10.1666243769081;
        Wed, 19 Oct 2022 22:29:29 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id a16-20020aa7d910000000b00459ad800bbcsm11493000edr.33.2022.10.19.22.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 22:29:28 -0700 (PDT)
Message-ID: <effb4a2a-2bdd-a4b7-f6db-948666515996@kernel.org>
Date:   Thu, 20 Oct 2022 07:29:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH -next] tty: hvc: make hvc_rtas_dev static
Content-Language: en-US
To:     ruanjinjie <ruanjinjie@huawei.com>, gregkh@linuxfoundation.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20221019064412.3759874-1-ruanjinjie@huawei.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20221019064412.3759874-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 10. 22, 8:44, ruanjinjie wrote:
> The symbol is not used outside of the file, so mark it static.
> 
> Fixes the following warning:
> 
> drivers/tty/hvc/hvc_rtas.c:29:19: warning: symbol 'hvc_rtas_dev' was
> not declared. Should it be static?

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
> ---
>   drivers/tty/hvc/hvc_rtas.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/hvc/hvc_rtas.c b/drivers/tty/hvc/hvc_rtas.c
> index e8b8c645482b..184d325abeed 100644
> --- a/drivers/tty/hvc/hvc_rtas.c
> +++ b/drivers/tty/hvc/hvc_rtas.c
> @@ -26,7 +26,7 @@
>   #include "hvc_console.h"
>   
>   #define hvc_rtas_cookie 0x67781e15
> -struct hvc_struct *hvc_rtas_dev;
> +static struct hvc_struct *hvc_rtas_dev;
>   
>   static int rtascons_put_char_token = RTAS_UNKNOWN_SERVICE;
>   static int rtascons_get_char_token = RTAS_UNKNOWN_SERVICE;

-- 
js
suse labs

