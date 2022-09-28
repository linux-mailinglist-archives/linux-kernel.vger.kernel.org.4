Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C395EE6CF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 22:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbiI1Uuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 16:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbiI1Uuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 16:50:37 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5881D1DA55
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 13:50:26 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h7so9161571wru.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 13:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=froggi.es; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=jAAJD3w5sdA6YPrQ8HDZfXTLyfYSu7U8SkD58CzhzYM=;
        b=Wr1qscpdvmstMPRpHnFQm4q12sDyD5wrYdsSjFoNRK7U7FITW77layboGpP+Md1sG3
         QpKDEnkRO/i3wXYFV5PbCkWXyduqYp5BFIHu5bZQeISwFgTSYZyCFYYo6UCcsI6XBzYV
         JlZmueR+dlDmiLjTrPLzWeWTxF8nDWaHlW9ojS3k3lFtbJb8r30dQIbvBjCMBeTKLrZu
         qmY97AbgeLtH26RCRAFrlxayZ+AT/dMH5CN/8QH/YLCUIlmXHO4pikRR+dfN0dB11ltI
         Oqbh5a8bFFNoN8goklw3XNNNm6O/2CWUtLR/C3CmSrlcw2kpnc/QqlajXSKeubFpsO9t
         BjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=jAAJD3w5sdA6YPrQ8HDZfXTLyfYSu7U8SkD58CzhzYM=;
        b=K5W8CgKgE0rX0VUzuhvN78Nu0KyZcSq8Z8f+X+CGt/lJkV4rbMqN1l9qXF/YKHtdbI
         znV0Kfjyld35rlxHKojkk2PXNX6+K58X9CnlBR+hHqMpqURGKHcBtLyWU0xGJ9DSkTKb
         DtNdzWM1Cmu3OVts3viuWO7mP+lhDaS3cv7lj166ppSCIKeIdF6R9SOuU9Syf2np2yDv
         IUyFK/Vkc0xG9/qMR+TLP2L4RSUOnEl2NrUdzURp2XSP5Nzqs6uqQQaFZPkzp6NzBJ6b
         9a1dGVMhEDdOu+DK7mXdEXjgrvPQtQyOsou8dFa3/A2WEB6M14PhT33CIZ0UN31CFdf9
         Xx2A==
X-Gm-Message-State: ACrzQf3zlfXeWnviF1YyXn2FT5BdxDZxeRxSG4CyuPzguPSQkgbwYd6e
        DJLppxs+Vi8y2CX+i6yJ0+QPcQ==
X-Google-Smtp-Source: AMsMyM5lvk+D/A5CbmxM1my48h9iodEj/ixNMloHt+GMFB0CcmsdJofws2yM8rb+5lEpjTFWWgKNGg==
X-Received: by 2002:a05:6000:1881:b0:22c:bee7:96e with SMTP id a1-20020a056000188100b0022cbee7096emr6834742wri.418.1664398224789;
        Wed, 28 Sep 2022 13:50:24 -0700 (PDT)
Received: from [192.168.0.86] (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
        by smtp.gmail.com with ESMTPSA id hg6-20020a05600c538600b003b4e009deb2sm2976513wmb.41.2022.09.28.13.50.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 13:50:24 -0700 (PDT)
Message-ID: <f568c82c-738b-c5ec-5059-36659b3f5b44@froggi.es>
Date:   Wed, 28 Sep 2022 18:20:23 -0230
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] x86/split_lock: Restore warn mode (and add a new one) to
 avoid userspace regression
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Pavel Machek <pavel@denx.de>,
        Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
        Melissa Wen <mwen@igalia.com>
References: <20220928142109.150263-1-gpiccoli@igalia.com>
 <SJ1PR11MB6083113884DD0B3031FE372CFC549@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Joshua Ashton <joshua@froggi.es>
In-Reply-To: <SJ1PR11MB6083113884DD0B3031FE372CFC549@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/28/22 17:54, Luck, Tony wrote:
>> So let's revamp the idea of having another option/mode for the split
>> lock detector, which is hereby called "seq" (based on the original
>> "sequential" naming in [0]). Also introduces a Kconfig option to give
>> the option of Linux vendors have a choice what mode should be their
>> default. While at it, fix/improve the documentation about bus locking.
>>
>> [1] https://github.com/doitsujin/dxvk/issues/2938
> 
> Why not just use the workaround suggested in that bug report:
> 
>     "so manual switching from default setting to split_lock_detect=off helps as workaround here"
> 
> If you add this extra mode, I'm going to argue that the kernel default
> should be "seq" rather than "warn". So these game players will need
> to add a split_lock_detect=off (or warn) option.
> 
> Has a bug report been filed against the God Of War game? Probably worth fixing,
> the performance penalty for split lock is only going to get worse as numbers of
> cores keeps increasing.

It's not just about God of War specifically.
There are many old titles that will never, ever, get updated to fix this 
problem.
These titles worked perfectly fine and were performant before.

I completely understand that split-locks are bad, and developers should 
fix their code, but applications paying penalties like this really 
doesn't make sense for the Linux desktop.

If server-oriented distributions want to set their default to `seq`, 
then that's completely fine, and I would completely encourage them doing 
that -- but I really don't think the Linux kernel should be essentially 
breaking compatibility with these applications by default and throwing 
desktop Linux usecases under the bus.

- Joshie 🐸✨

> 
> -Tony
> 

