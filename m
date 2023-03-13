Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50B26B7B5E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjCMPA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjCMPAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:00:38 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6547431A;
        Mon, 13 Mar 2023 08:00:06 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id i19so7054536ila.10;
        Mon, 13 Mar 2023 08:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678719602;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=FgVKhx2kcA+V8IC8841Q8H45xpodMNO1QkCCaCiDE3k=;
        b=XtsvffYIYo34LM5M6aq6T1VtS4zl60wl6mIxyhiVeq0Ingqxv6C0OPkcDYOnqjWOK1
         dq6fTTOxDMQq8guLWCjV0HPqnIjlLjJYuRNjXNkj9UhngLoC9Xd1/WDc0SAQ7NwK3MN4
         ZB37GL8yLVsBkxZp7JK/qNRAT3c0I+EXL1275IGwa06bxXhk9Y1IpEGDG9Phen7roKee
         hdUFSmI5ZBYkhqmj+X8p5B57WJoLNOX4MxBvmv/wRlYj8+jPkhrE+HnRapDAAfLWo90t
         6nlNvvFcytETlRNSiiyyrWiJC9+P3zphAYiWxyxdVxXJtlLUCvueaW51JiHVsgfahmSq
         lAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678719602;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FgVKhx2kcA+V8IC8841Q8H45xpodMNO1QkCCaCiDE3k=;
        b=poc/MOZGgK0QXDE1a1ivs4VHizBDC3ITLKeQQEt0ZC8d1jUbVbjlefyXMAashfrlgl
         9366sSd8amv4U+U5KEvz4TAn8vkEt9crih1RAszJVfqGalxeoQXuvz/Cf6QLm6YXIV9e
         VQlrX+GzIVaVfMqNMn8ifAaDNSe+2ZZy2Wis5FfeFphfNmlRJcoX+X3QEUfyDutj0cqq
         sAYK1M+nQy8x0N32x4GQHd0SInh0veSdLGQDmBqNiDJDbZLA3V9Vcg36qRZxIlTvFMAC
         20j25wd7VSUQsVum6G+yEoU8CBTwB6jGZEqIQmnt6X6rb8uo8fApJ+WAL8Hp5vwQyQmr
         5r7w==
X-Gm-Message-State: AO0yUKVMx2sxst2CMsAqwv+U3u/Mu190K9gxwuY9eEUElVdv469wA0jD
        ov5d0r5N38lsLvWbs8xRSbf9FmPHpaE=
X-Google-Smtp-Source: AK7set9PYlM3wD46u/efdsGd7Mp7J3XWNn9P1Uf83PyMZ1T/Y/69gtdcpO9/9hz6s0dFXwrswZtFaA==
X-Received: by 2002:a05:6e02:1d17:b0:323:338:cc3a with SMTP id i23-20020a056e021d1700b003230338cc3amr18204ila.16.1678719602743;
        Mon, 13 Mar 2023 08:00:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l14-20020a02cd8e000000b003c5178055fdsm2567724jap.62.2023.03.13.08.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 08:00:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9f2aa199-58c5-2abb-44dc-8aea50fa209d@roeck-us.net>
Date:   Mon, 13 Mar 2023 07:59:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] watchdog: avoid usage of iterator after loop
Content-Language: en-US
To:     Jakob Koschel <jkl820.git@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
References: <20230301-watchdog-avoid-iter-after-loop-v2-1-8411e3bbe0de@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230301-watchdog-avoid-iter-after-loop-v2-1-8411e3bbe0de@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/23 06:59, Jakob Koschel wrote:
> If potentially no valid element is found, 'p' would contain an invalid
> pointer past the iterator loop. To ensure 'p' is valid under any
> circumstances, the kfree() should be within the loop body.
> 
> Additionally, Linus proposed to avoid any use of the list iterator
> variable after the loop, in the attempt to move the list iterator
> variable declaration into the macro to avoid any potential misuse after
> the loop [1].
> 
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
> Signed-off-by: Jakob Koschel <jkl820.git@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes in v2:
> - avoid returning within the list iterator
> - Link to v1: https://lore.kernel.org/r/20230301-watchdog-avoid-iter-after-loop-v1-1-851f583be9f7@gmail.com
> ---
>   drivers/watchdog/watchdog_pretimeout.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/watchdog_pretimeout.c b/drivers/watchdog/watchdog_pretimeout.c
> index 376a495ab80c..e5295c990fa1 100644
> --- a/drivers/watchdog/watchdog_pretimeout.c
> +++ b/drivers/watchdog/watchdog_pretimeout.c
> @@ -207,10 +207,9 @@ void watchdog_unregister_pretimeout(struct watchdog_device *wdd)
>   	list_for_each_entry_safe(p, t, &pretimeout_list, entry) {
>   		if (p->wdd == wdd) {
>   			list_del(&p->entry);
> +			kfree(p);
>   			break;
>   		}
>   	}
>   	spin_unlock_irq(&pretimeout_lock);
> -
> -	kfree(p);
>   }
> 
> ---
> base-commit: c0927a7a5391f7d8e593e5e50ead7505a23cadf9
> change-id: 20230301-watchdog-avoid-iter-after-loop-a197bf201435
> 
> Best regards,

