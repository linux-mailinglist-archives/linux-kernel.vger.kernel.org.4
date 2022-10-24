Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B6560987B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 05:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiJXDKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 23:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiJXDKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 23:10:36 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B491444AB
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 20:10:28 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id y4so7429118plb.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 20:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xFOqFhoWJpS93ZCZ48P1kJuHexoFYaiqPnMocVGwfOQ=;
        b=AG5I+OSVaYk4VTCeoBVkbhGMd2NP8Vvd2z/Rhm+qB8/C31/l/ih4g7DBY0izT+bblh
         G0CZkpfhP3FAohgmHickoqmGcSSI1GeZWlVlJYn5rK6u514g9hVqlPOD0mAEyJBE/vBC
         2pPAlJMOAp8cvwc0hMOXK85K6K8O4MIqP3viAJbCj+YSoa9t6iJJkzLa2FQcr7u3fhIe
         ARYvlql7KXWHA7rhT1Sbn4/KtV2GI0uZc2CSTGTREqEG9pEDpxSU7sUj8jr8HulqyAVq
         InrZg2g2YMa9yKdR6iLlmJsgTV1PP6iMlAi670C6j7lnBh81CU0zkevdK48BYNQPOQHW
         g8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xFOqFhoWJpS93ZCZ48P1kJuHexoFYaiqPnMocVGwfOQ=;
        b=hM7qGrSL7lO48HIMsondHaCvnspBX3BHvcui1CMSUcVLM+sUQcRVTLNh9yPM+D1G/Z
         A7VdQe6L59brTgobFVv4kO/WAOl1Cpu8zXsBz9X4ZKd5d5rFqR56EqVVx9XbveOyo9vN
         MR5kqRG3D3irsu5/C9QNGlG/sm7ndvOsKeeRhjMKL9mu6QTMuDWWPdosOaeQ2cotuiy4
         /vZDS1yo4qiqWyomf0T4rvVFkUgaPnPsy/sTddO4sL+2xXqGr750JfonKw85rsZFRf5k
         7JUx1G6R3PYhUFcty2ZEEL5BLJD1bATuRbKcAJ6fUMBTGNPzqUY+igibMD7N5TbchWQQ
         qzeg==
X-Gm-Message-State: ACrzQf1g/M+1txaIGhsw3q9LfuUZr9Kd8YvvgZ6VGkHCLS0AyWiB5B5E
        kzOWSMbFkU8kpssVIoa3kFA=
X-Google-Smtp-Source: AMsMyM7jNjuZYxY6eLkUM0zJNq69ZpUCr+R8c42Zto8XuziIMzH4R2/yg30+JQhvjSz6f5KDvKaGJg==
X-Received: by 2002:a17:90b:3808:b0:212:ca53:b509 with SMTP id mq8-20020a17090b380800b00212ca53b509mr19546397pjb.44.1666581028066;
        Sun, 23 Oct 2022 20:10:28 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-9.three.co.id. [180.214.232.9])
        by smtp.gmail.com with ESMTPSA id ge12-20020a17090b0e0c00b0020aa1bd91e4sm5138033pjb.4.2022.10.23.20.10.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 20:10:27 -0700 (PDT)
Message-ID: <9a979e2a-5f6c-fa3c-ea39-bbac0d0ad8c6@gmail.com>
Date:   Mon, 24 Oct 2022 10:10:23 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2] staging: wlan-ng: remove commented debug printk
 messages
To:     Deepak R Varma <drv@mailo.com>
Cc:     outreachy@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <Y1L0FiKvrM9jjZG9@debian-BULLSEYE-live-builder-AMD64>
 <Y1VDM2kWIi1I5dqI@debian.me>
 <Y1Mf7IVccbst10iP@debian-BULLSEYE-live-builder-AMD64>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <Y1Mf7IVccbst10iP@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/22 05:40, Deepak R Varma wrote:
> On Sun, Oct 23, 2022 at 08:35:47PM +0700, Bagas Sanjaya wrote:
>> On Sat, Oct 22, 2022 at 01:03:42AM +0530, Deepak R Varma wrote:
>>> diff --git a/drivers/staging/wlan-ng/p80211netdev.c b/drivers/staging/wlan-ng/p80211netdev.c
>>> index e04fc666d218..6bef419e8ad0 100644
>>> --- a/drivers/staging/wlan-ng/p80211netdev.c
>>> +++ b/drivers/staging/wlan-ng/p80211netdev.c
>>> @@ -881,55 +881,42 @@ static int p80211_rx_typedrop(struct wlandevice *wlandev, u16 fc)
>>>  		wlandev->rx.mgmt++;
>>>  		switch (fstype) {
>>>  		case WLAN_FSTYPE_ASSOCREQ:
>>> -			/* printk("assocreq"); */
>>>  			wlandev->rx.assocreq++;
>>>  			break;
>>>  			wlandev->rx.ctl_unknown++;
>>>  			break;
>>>  		}
>>> -		/* printk("\n"); */
>>>  		drop = 2;
>>>  		break;
>>>
>>> @@ -1007,7 +986,6 @@ static int p80211_rx_typedrop(struct wlandevice *wlandev, u16 fc)
>>>  			wlandev->rx.cfack_cfpoll++;
>>>  			break;
>>>  		default:
>>> -			/* printk("unknown"); */
>>>  			wlandev->rx.data_unknown++;
>>>  			break;
>>>  		}
>>
>> Shouldn't these printks be guarded under CONFIG_DEBUG_KERNEL instead?
> 
> Hi Sanjaya,
> Sure they can, but I think they are very basic tracing message and do not appear
> to carry much of information useful the event of debugging. Do you have a
> suggestion on what additional information may be added to make them more useful?
> 
> If you still think we should have then in the CONFIG_DEBUG_KERNEL guard, let me
> know and I will attempt to improve these.
> 
> Thank you,
> ./drv
> 

Greg said we should just deleting these printks [1].

[1]: https://lore.kernel.org/lkml/Y1VL%2FwITM64U6qLi@kroah.com/

Thanks anyway.

-- 
An old man doll... just what I always wanted! - Clara

