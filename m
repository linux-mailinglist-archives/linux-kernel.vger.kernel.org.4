Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D887563F752
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 19:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiLASP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 13:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiLASPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 13:15:04 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA336248ED
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 10:14:45 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id l127so2002100pfl.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 10:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+qiP+aVyEbFOin+Fo/Yz6dh5ehlyeto99kkZi+uNlNg=;
        b=bLwHx176LOszJh7EjFmxlHoRSrusawe1m/8ONFIvi20Ao1VaNovHngA/dkeAr9PdM6
         HXyqLmIOclACQAJz9XvahXKcNR64jiGkSV2gp2VVafJ/t/8EGFbJrIYhGEV1aMX5xqTt
         j1+/A/Mk4bf9xbt+jBLBQywuGUSoPYAuKjqywUfWHdD/IzmCctJIGHC8g8PIOO8gna0z
         LZ1558q3nJqSv++SBilMpXNgyiGoLv103hh+ZzCzwnxRfKvhjbtqZtXqMpc2D5h9/eVt
         MSjyIjF5HqSDRPNLRETVpOLf/BOuCy2GfaRce6VtPi400GwVMFdkBA1JjPHuntxdehAV
         hrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+qiP+aVyEbFOin+Fo/Yz6dh5ehlyeto99kkZi+uNlNg=;
        b=iYu380Qxl8DelXzJwWoVFIrWyQP1/n5hZEbLmpLtW/tXSWNSZF8cYj4NPPIj09E/cZ
         74SK1QbYZ8/hbWnYaKOtMt9KIbtpGb/sUTkWgaE3hsUyztmHYbqnwuaD5+OnPw5C0uaf
         1A9+l5Kc4XVlrBHcdqFojUjGHiM1XzalUhFR3ry9hewvAm9ZVy+mziASVE9FbSCP50Yr
         6zAL6mhDxuLhidIxiabUJWakZw5XFUdidnOqNXROFSsrBR3M21a1PV46Q26iBy0i9qf7
         AEewkfSCFYOSsBcRG+a5+figFVFFg4mriDBj2U1ZCH62jbeD1mev/B9+u/UlyC7KBE2h
         4ECQ==
X-Gm-Message-State: ANoB5plnfSASQ4yRrKEjGQ8G5w4rVJ2oIM9tFeCA3tEb1/hbGb1QRNNd
        U4YVl7ZsfScxH9TH5m2HnofjCzopNboIsLLs
X-Google-Smtp-Source: AA0mqf4B6/UAlIPQX5wvlJ3k48CdDnGeviR46Lrs1HEVHn73FAxfx55icdrfZVrW9OOfLpFuIcVuaw==
X-Received: by 2002:a62:1417:0:b0:575:c993:acbe with SMTP id 23-20020a621417000000b00575c993acbemr11000843pfu.2.1669918485410;
        Thu, 01 Dec 2022 10:14:45 -0800 (PST)
Received: from ?IPV6:2400:4050:c360:8200:8ae8:3c4:c0da:7419? ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id b1-20020a63d801000000b0046ff7db0984sm2842628pgh.72.2022.12.01.10.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 10:14:45 -0800 (PST)
Message-ID: <18c884cb-dd73-09eb-65da-604cf45cb1b4@daynix.com>
Date:   Fri, 2 Dec 2022 03:14:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] arch: arm64: dts: apple: Remove stdout-path
Content-Language: en-US
To:     Hector Martin <marcan@marcan.st>,
        Mark Kettenis <mark.kettenis@xs4all.nl>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, asahi@lists.linux.dev,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        alyssa@rosenzweig.io, sven@svenpeter.dev
References: <20221201103651.27807-1-akihiko.odaki@daynix.com>
 <877czb42wk.fsf@bloch.sibelius.xs4all.nl>
 <c3b0cee9-032c-0447-37df-3ce5ce280e41@daynix.com>
 <ae89b38f-fd67-e0e5-1439-f376da985be8@marcan.st>
 <8b3c4fe0-4a81-ba47-2f01-3686cfdbd519@daynix.com>
 <647b6572-e5d1-d243-283e-616cef15a1f5@marcan.st>
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <647b6572-e5d1-d243-283e-616cef15a1f5@marcan.st>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/02 2:46, Hector Martin wrote:
> On 02/12/2022 01.38, Akihiko Odaki wrote:
>>   >> In contrary, if you boot the kernel without the hypervisor
>>   >> feature and this change, you will completely lose the console.
>>   >
>>   > How so? The console goes to both places with stdout-path set to serial0.
>>   > What it *does* change is where input is accepted prior to getty startup
>>   > (which is why u-boot specifically conditions this on keyboard presence,
>>   > modulo the USB issue - because if you *don't* have a keyboard then tty
>>   > keyboard input is useless). But if you're booting kernels without u-boot
>>   > along the way, you're probably doing it from the hypervisor or linux.py
>>   > anyway, especially if you plan to do something like "init=/bin/sh",
>>   > because without u-boot (+ optionally some EFI loader) there is no way of
>>   > editing command line arguments at boot time stand-alone.
>>
>> Well, that is not exactly the behavior I saw. In my case, if stdout-path
>> is pointed to serial, there is no output on the framebuffer, and it just
>> printed "_".
>>
>> It looks like the kernel only outputs to either of serial and
>> framebuffer, not both.
> 
> That is not what I've seen in all of my hypervisor runs since the dawn
> of time. You get log output on both.
> 
>> What I experienced is that when I directly booted the kernel from m1n1
>> without hypervisor, it showed no output to the display even though the
>> same kernel worked with U-Boot. While I could tell it used wrong console
>> by running the hypervisor, I wondered why it behaves differently without
>> U-Boot, and found the aforementioned U-Boot change, coming up with this
>> patch.
> 
> Then it sounds like something else is different about our setups,
> because I've booted the kernel from linux.py hundreds of times and I get
> output on both. Looking through the console code, the VT console gets
> added and enabled really early, and the subsequent serial console
> registration later does not disable it.
> 
> Look for "console: colour dummy device 80x25". It should be immediately
> followed by "printk: console [tty0] enabled", and this should all come
> well before the ttySAC0 serial stuff shows up.
> 
> - Hector

I think I understand the situation now. By "console", I was meaning the 
input and output of init, but I failed to clarify that and you thought 
it referring to kernel message output. I saw no messages earlier than 
init because my kernel command line has loglevel=3.

Regards,
Akihiko Odaki
