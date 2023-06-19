Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0147D734C09
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 09:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjFSHDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 03:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFSHDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 03:03:18 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9164B199
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 00:03:17 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-988c30a540aso59036966b.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 00:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1687158196; x=1689750196;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q3rqfHA0Nd19rgAWfp2F5qidNzud1h37rmbnwQb682o=;
        b=TGQDNU0BpqGYdHGjy6BrrzEce5pZhCjmiFId+J7p3+ABmZTiOJTNg1QcGRDkgGhylR
         9C0/AzW3S/Y6Pty3mgwSXw5mA0AUtuxM3I67N1yIJkAmNHw8H/HhHaixgCEs95JVdwCM
         W1naNHiVgkZ32W/m1Ykl7HZI+bmpXUhzCXv123nuskQVmdXG8Pi/upKUT3QiTBQ3zaec
         M3KLb+gkZf66b6GLtBOAo6lfxQrcOKpUt4st9hsgD34IvGRFS13FnxL713rnafk4qtmc
         MwAbAX6vz+qnIkf4aiO5yWnLd4CIlKcOHSE/stGSW79QTo2x5YOQN7JIbLHjFf5aJNkC
         T15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687158196; x=1689750196;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q3rqfHA0Nd19rgAWfp2F5qidNzud1h37rmbnwQb682o=;
        b=dzHs19AwAsFQNfBJZxkFMVBaAzgcEnewF764x0fnLxbXAJ8YUFOozQ5GQrJk7fRqlY
         6eqAXea6yST4nwX13qMH1aFEd31Y3iEpUBmg8qYcJaF6qQxH/lPZw55JT6OfuxderDLK
         sgvZDjFbRpFw0gjT6ipSwj0JYgaAXRtH27OlJwsDWhv7t1tT+Cc05ZcPhFmNE6rd7jEZ
         WLhVaujAsIQM4IkagREfPuKcnKeh9h/w6S2uV4+4r5ied/6OyrUZdkLqGxSCkuQZEBtr
         n3EiUAVAwpIjiarqSl6Tdr406k9lcViF551BYsW6PNSRBPZp621R7n+xChvUY2eD/Ckv
         OVGw==
X-Gm-Message-State: AC+VfDxiVcfFjzwmX7Ef3bkUmLP5+NTS3nsaQtCqJxrBLaMmNsajmcHA
        QlMQ81d1sK9v3UKvM2NsrO+A+g==
X-Google-Smtp-Source: ACHHUZ74DXiBzeGvqRXm3wJinBjsQHDL9fxXFtrROkbzhJ1C0WjNOxrr2DIcDghun9+0rHpM3Y4WgA==
X-Received: by 2002:a17:907:1b0b:b0:978:90cc:bf73 with SMTP id mp11-20020a1709071b0b00b0097890ccbf73mr7230696ejc.48.1687158195918;
        Mon, 19 Jun 2023 00:03:15 -0700 (PDT)
Received: from ?IPV6:2003:f6:af18:b100:f20f:c000:6662:fd49? (p200300f6af18b100f20fc0006662fd49.dip0.t-ipconnect.de. [2003:f6:af18:b100:f20f:c000:6662:fd49])
        by smtp.gmail.com with ESMTPSA id p4-20020a1709060dc400b0096f937b0d3esm14220377eji.3.2023.06.19.00.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 00:03:15 -0700 (PDT)
Message-ID: <2d6def18-58d4-6a24-22ab-9fd065809e7f@grsecurity.net>
Date:   Mon, 19 Jun 2023 09:03:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] tick/common: Align tick period during sched_timer setup.
To:     Greg KH <gregkh@linuxfoundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Luiz Capitulino <luizcap@amazon.com>,
        Sven-Haegar Koch <haegar@sdinet.de>,
        "Bhatnagar, Rishabh" <risbhat@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "sashal@kernel.org" <sashal@kernel.org>, abuehaze@amazon.com,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
References: <12c6f9a3-d087-b824-0d05-0d18c9bc1bf3@amazon.com>
 <c4724b40-89f6-5aa7-720d-c4a4af57cf45@amazon.com>
 <2023061428-compacter-economic-b648@gregkh>
 <20230614092045.tNY8USjq@linutronix.de>
 <4c4178a1-1050-ced4-e6fb-f95c3bdefc98@amazon.com>
 <2a3fa097-8ba0-5b0e-f506-779fee5b8fef@sdinet.de>
 <f5d2cc62-4aae-2579-1468-2e6e389f28dc@amazon.com>
 <23fb8ad7-beb0-ae1c-fa5a-a682a57f79b0@grsecurity.net>
 <20230615091830.RxMV2xf_@linutronix.de>
 <2023061944-uprising-applaud-990a@gregkh>
Content-Language: en-US, de-DE
From:   Mathias Krause <minipli@grsecurity.net>
In-Reply-To: <2023061944-uprising-applaud-990a@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.06.23 08:18, Greg KH wrote:
> On Thu, Jun 15, 2023 at 11:18:30AM +0200, Sebastian Andrzej Siewior wrote:
>> From: Thomas Gleixner <tglx@linutronix.de>
>>
>> The tick period is aligned very early while the first clock_event_device
>> is registered. The system runs in periodic mode and switches later to
>> one-shot mode if possible.
>>
>> The next wake-up event is programmed based on aligned value
>> (tick_next_period) but the delta value, that is used to program the
>> clock_event_device, is computed based on ktime_get().
>>
>> With the subtracted offset, the devices fires in less than the exacted
>> time frame. With a large enough offset the system programs the timer for
>> the next wake-up and the remaining time left is too little to make any
>> boot progress. The system hangs.
>>
>> Move the alignment later to the setup of tick_sched timer. At this point
>> the system switches to oneshot mode and a highres clocksource is
>> available. It safe to update tick_next_period ktime_get() will now
>> return accurate (not jiffies based) time.
>>
>> [bigeasy: Patch description + testing].
>>
>> Reported-by: Mathias Krause <minipli@grsecurity.net>
>> Reported-by: "Bhatnagar, Rishabh" <risbhat@amazon.com>
>> Fixes: e9523a0d81899 ("tick/common: Align tick period with the HZ tick.")
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Link: https://lore.kernel.org/5a56290d-806e-b9a5-f37c-f21958b5a8c0@grsecurity.net
>> Link: https://lore.kernel.org/12c6f9a3-d087-b824-0d05-0d18c9bc1bf3@amazon.com
>> ---
>>  kernel/time/tick-common.c | 11 +----------
>>  kernel/time/tick-sched.c  | 13 ++++++++++++-
>>  2 files changed, 13 insertions(+), 11 deletions(-)
> 
> What's the status of this fix, I didn't see it in -rc7, am I looking in
> the wrong place?

It's in the tip tree since Friday, but yeah, no pull request yet:

https://git.kernel.org/tip/13bb06f8dd42

Thanks,
Mathias
