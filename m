Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9E8654F58
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 11:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236068AbiLWKyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 05:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiLWKye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 05:54:34 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7389BB7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 02:54:32 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id d14so6595364edj.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 02:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c3Ai4+DxosA1/61sV6PGYs4sO3EYuPD5PzZdBIzR+sU=;
        b=qJkLMsjsiMN7xE7QHtPdZ8YsI38AZtzg5vsoM2CxdFzPJ0vxA8bxwhpFmwJnsK47XC
         mbGNN8JAtYKMo/FAT5qkSAAvJq2jMQi+JWYfzqnoUm9KAdGfQ2iyB0vhyC1UsRyV2GYV
         jUWdoRHqVpMYKDr+W0vHOLbBxFRLl4Hk3AX4nVM3dS2UZpVWXZQ5baSGocS1GtXMpdtj
         nBbhyGmui0DgdWiNNtQQRxMpi9qaCc2sRTg55+6ii4UI3ibWHDuzqG7k1sACQSoQXOSI
         RBXhdIbJUPPRMEOJXk8a26nWAiJQFG//695i/YWWAy/1B69RewL7RwIqki5zaN6keB98
         4BSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c3Ai4+DxosA1/61sV6PGYs4sO3EYuPD5PzZdBIzR+sU=;
        b=pJ4LXZxFPTr/hntHlVt4gHlN3HjD8tPGTzeWz6peuYUCI2aLQnfhxcLKpOD8KYGBPQ
         IuY2RaGn8Y/qyJesedmNqO0xJB78SPFt7TWehQDU3CELWAixw/pWHBgTpPw8J3rsfbtA
         7PHx178b/jm/SGf74WCbbzlMoYij5rFPbYN6atS7kc7WyBuy0fW6UmHWAdULDHBq0Sip
         CvM04w7wY/Y+OcIz3WcuP5BwQaR3p8ruOrSeLsj3VxE4q1Y694xEZNcwqX+X8FLnkCYr
         fq9OpGqv8NynWPwKhaIfltaHcPh1Ah30uYwpeNA7khHGa9teRF/NHSp3PHXUsfcTdCU1
         shoA==
X-Gm-Message-State: AFqh2kr+KfDxU5UJdYVADXT5hoCgOZs2y+EZTiwPwOKCUGTlzZR04XSk
        pt+w6OUCRsXgaZaJs/WByVH9GA==
X-Google-Smtp-Source: AMrXdXtK6YyBxH+/xdw/Cg4+BOcd6l9QAxB+tthAQ4VcZWZ/GvX4AGBrVy0z+2fPmkV01o7gzzJlkw==
X-Received: by 2002:aa7:d445:0:b0:482:ab74:643a with SMTP id q5-20020aa7d445000000b00482ab74643amr21172edr.22.1671792871434;
        Fri, 23 Dec 2022 02:54:31 -0800 (PST)
Received: from ?IPV6:2003:d9:9705:6f00:2d39:1f1b:859:e49b? (p200300d997056f002d391f1b0859e49b.dip0.t-ipconnect.de. [2003:d9:9705:6f00:2d39:1f1b:859:e49b])
        by smtp.googlemail.com with ESMTPSA id u22-20020a056402111600b0046ee136fa3bsm1352923edv.69.2022.12.23.02.54.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 02:54:30 -0800 (PST)
Message-ID: <1540f1d0-4fda-aaf4-acda-f5aaa6952a00@colorfullife.com>
Date:   Fri, 23 Dec 2022 11:54:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 3/3] kernel/irq/manage.c: disable_irq() might sleep.
To:     "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc:     "1vier1@web.de" <1vier1@web.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>
References: <20221216150155.200389-1-manfred@colorfullife.com>
 <20221216150441.200533-1-manfred@colorfullife.com>
 <20221216150441.200533-3-manfred@colorfullife.com>
 <ca1972cec9724189b5a97a09069f3ee4f8c3f97c.camel@siemens.com>
Content-Language: en-US
From:   Manfred Spraul <manfred@colorfullife.com>
In-Reply-To: <ca1972cec9724189b5a97a09069f3ee4f8c3f97c.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

On 12/20/22 07:58, Sverdlin, Alexander wrote:
> Hi Manfred!
>
> On Fri, 2022-12-16 at 16:04 +0100, Manfred Spraul wrote:
>> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
>> index 5b7cf28df290..8ce75495e04f 100644
>> --- a/kernel/irq/manage.c
>> +++ b/kernel/irq/manage.c
>> @@ -723,10 +723,13 @@ EXPORT_SYMBOL(disable_irq_nosync);
>>    *     to complete before returning. If you use this function while
>>    *     holding a resource the IRQ handler may need you will
>> deadlock.
>>    *
>> - *     This function may be called - with care - from IRQ context.
>> + *     Can only be called from preemptible code as it might sleep
>> when
>> + *     an interrupt thread is associated to @irq.
>> + *
>>    */
>>   void disable_irq(unsigned int irq)
>>   {
>> +       might_sleep();
> I'm not sure about this, latest wait_event() inside synchronize_irq()
> has it already.
>
>>          if (!__disable_irq_nosync(irq))
>>                  synchronize_irq(irq);
>>   }

That is the whole point: might_sleep() should be always called. We are 
clarifying an API definition. Everyone who uses disable_irq() from 
non-sleeping context should get a warning, 100% of the time.

Not just within synchronize_irq() if there is an active threaded irq 
handler.

--

     Manfred

