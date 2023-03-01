Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B615A6A7376
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjCASbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjCASbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:31:43 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E5242BFC;
        Wed,  1 Mar 2023 10:31:42 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id r4so8882038ila.2;
        Wed, 01 Mar 2023 10:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677695502;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=a/YclZa16B+dv50g9dZnP2lIX+zrcQhTqU5677uxE5I=;
        b=RjeIERGXJCr3qI0RC7ybrOmq1mjkTvW5LL/dsIO5PY0j96XzYZXWfM0X3cNgQ5wLdS
         SdoHbeLFacDRPUbu42j6BAB1Uf3r1ebji2quBUcYl8FzH+IOHJEar/yOWboCan5zMtfq
         +M6DN2SitzfF39tu2D1ueMCdVEmqupYOfrvEeZK5yNcKHWoIoKwDfnPReB4Dl2fk8KXG
         NXshQUMOLUBPOVZPPKwtv8+ChRA7WjhnC+f/LaHV9hnXzZejDH7gFUUEWOhD/cJ9cXd1
         bFARtgmw/AyV1NV0YgeSugjiPEkRLYKLZgJRzfnLurOt3SuritmPd3eZeycgfdkYHnx4
         8bng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677695502;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/YclZa16B+dv50g9dZnP2lIX+zrcQhTqU5677uxE5I=;
        b=ACPcuo5gA8HzH+tGcEIZ9AvX09gGkJbWk9gGySOa8nQ2YOqkHowJujvq5HNYPwrQUM
         G0F7ug9WVl67IYY7KJ28tl8boiZHKqRTrFnVBLsXKsQZuZmkyfmxP7zNHXqGhHPWZ53e
         3pFS/LeVHEvLf5430wk5i69C//qyYE5/NvPwx7WfBDM61jEIVdjNinC+PZiDK1NrnRY+
         H0v4N8lrzjIfESCwE91PVmnJVwMrh2eSYXwJJVj/v73VjHWapuj2ocCb26NLVlmidCwI
         Ll12+uKX+7xJgwlgeiGnKaH9tfVw4teTdpWpRzfuuPiPc8NmY36ZPBNh/KIF/NEGigBS
         syRg==
X-Gm-Message-State: AO0yUKWA7Z8SG2iONsbU+p8B2rauajrAHY5mApJ/bBYlGmBn7drgY+H5
        zyYjTs10fDRU7575aoX+NVb04kxeevY=
X-Google-Smtp-Source: AK7set9xJ2YQU4WS7eYhgtrqloRddxtCth6qjD5+C2kxWwxKPiRlV/i5iGDJldk7BqCslKy69rGReA==
X-Received: by 2002:a05:6e02:1bc9:b0:315:4793:f7b4 with SMTP id x9-20020a056e021bc900b003154793f7b4mr7115054ilv.31.1677695501863;
        Wed, 01 Mar 2023 10:31:41 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l3-20020a02a883000000b003c4f97d41d2sm3767491jam.116.2023.03.01.10.31.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 10:31:41 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1570650d-ea9d-c3b5-801a-60e246947242@roeck-us.net>
Date:   Wed, 1 Mar 2023 10:31:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] watchdog: avoid usage of iterator after loop
To:     Jakob Koschel <jkl820.git@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
References: <20230301-watchdog-avoid-iter-after-loop-v1-1-851f583be9f7@gmail.com>
Content-Language: en-US
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230301-watchdog-avoid-iter-after-loop-v1-1-851f583be9f7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/23 09:17, Jakob Koschel wrote:
> If potentially no valid element is found, 'p' would contain an invalid
> pointer past the iterator loop. To ensure 'p' is valid under any
> circumstances, the kfree() should be within the loop body.
> 
> Additionally, Linus proposed to avoid any use of the list iterator
> variable after the loop, in the attempt to move the list iterator
> variable declaration into the marcro to avoid any potential misuse after

macro

> the loop [1].
> 
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
> Signed-off-by: Jakob Koschel <jkl820.git@gmail.com>
> ---
>   drivers/watchdog/watchdog_pretimeout.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/watchdog_pretimeout.c b/drivers/watchdog/watchdog_pretimeout.c
> index 376a495ab80c..d8c78696eaf5 100644
> --- a/drivers/watchdog/watchdog_pretimeout.c
> +++ b/drivers/watchdog/watchdog_pretimeout.c
> @@ -207,10 +207,10 @@ void watchdog_unregister_pretimeout(struct watchdog_device *wdd)
>   	list_for_each_entry_safe(p, t, &pretimeout_list, entry) {
>   		if (p->wdd == wdd) {
>   			list_del(&p->entry);
> -			break;
> +			spin_unlock_irq(&pretimeout_lock);
> +			kfree(p);
> +			return;

Please just make it
			kfree(p);
			break;

There is no need to drop the spinlock here and/or to return
directly.

Thanks,
Guenter

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

