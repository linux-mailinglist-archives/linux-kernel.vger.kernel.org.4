Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38DA6454B9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 08:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiLGHj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 02:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiLGHjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 02:39:21 -0500
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D406338
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 23:39:21 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id fc4so11872403ejc.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 23:39:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XJz/FRW5OFODuhZ3euwber9Nnkdwp0ukSPoVEU1CvM8=;
        b=PvGk5u4GH9rFtMJfTgqNY8B014MOJEzaEaDa6yd7u1ylavylf1K9wJHhdrUgb/85Xp
         xsW4Z+dpNzXdIlXPQE3n7zKYjqC5yg3E94sMNDLhgS58MsRQJGxdi0E5AL5h30aEv0wO
         v3V4D6w2ykJmq+pBxTVbm12bTX6unG3S37BR36lhUCxUTdZrVxeLh7p6EicQRlJO5Gqh
         iDXjgFT4n6Muo/+r+QxmmDnZItaZeAnF6QhOgYyZL4mGFz4jkWwOpJIghoJQv6dfKSqH
         4OpydhtqAYwnw89D6qVW3uGl/mzCAgP3vrm+L1HMN5o44OKFTK2Urdobn4fMzSDD7xhd
         ZuRQ==
X-Gm-Message-State: ANoB5pkptgXCMrbYwRv4i0hsFWrQGPqUMxxvyulbJDIamYC08IOlnI/N
        EZZfxT1JK+HU1pTgRTI7XVLHzpsGBYQ=
X-Google-Smtp-Source: AA0mqf45M3rzpWrei/tYnNcGzn6REcHQ6s3opWUw+U01Xnxuyc3vCNfYjG3oxXj4zSvZq+YWAhzLgg==
X-Received: by 2002:a17:906:d782:b0:7bc:9d14:a2db with SMTP id pj2-20020a170906d78200b007bc9d14a2dbmr44105534ejb.770.1670398759779;
        Tue, 06 Dec 2022 23:39:19 -0800 (PST)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id z16-20020a1709060f1000b007c1175334basm1002800eji.78.2022.12.06.23.39.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 23:39:19 -0800 (PST)
Message-ID: <fa5d6cbc-8f83-9e41-0513-adcb32422d2f@kernel.org>
Date:   Wed, 7 Dec 2022 08:39:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kbd@lists.altlinux.org, linux-kernel@vger.kernel.org
References: <20221205000739.583233140@ens-lyon.org>
 <20221205000807.751605665@ens-lyon.org>
 <27ade063-79df-dad9-0427-e16f1ddb43ef@kernel.org>
 <20221206203947.5yifmkntf4uy7lt6@begin>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [patch 1/3] VT: Add height parameter to con_font_get/set consw
 operations
In-Reply-To: <20221206203947.5yifmkntf4uy7lt6@begin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06. 12. 22, 21:39, Samuel Thibault wrote:
> Jiri Slaby, le mar. 06 déc. 2022 07:40:30 +0100, a ecrit:
>> On 05. 12. 22, 1:07, Samuel Thibault wrote:
>>> --- linux-6.0.orig/drivers/usb/misc/sisusbvga/sisusb_con.c
>>> +++ linux-6.0/drivers/usb/misc/sisusbvga/sisusb_con.c
>> ...
>>> @@ -1268,7 +1271,7 @@ sisusbcon_font_get(struct vc_data *c, st
>>>    	}
>>>    	/* Copy 256 chars only, like vgacon */
>>> -	memcpy(font->data, sisusb->font_backup, 256 * 32);
>>> +	memcpy(font->data, sisusb->font_backup, 256 * height);
>>
>> Have you tested this?
> 
> Ah, no, I had assumed that this was for a specific arch. But actually I
> wasn't getting it because it depends on BROKEN.

Hmm, for two years... I will remove the con support completely next week 
if noone beats me to it.

thanks,
-- 
js
suse labs

