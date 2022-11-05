Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E1761D8A6
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 09:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiKEINO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 04:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKEINN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 04:13:13 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362202B247;
        Sat,  5 Nov 2022 01:13:12 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id a13so10679685edj.0;
        Sat, 05 Nov 2022 01:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bsgs5v64dtrb9BK/zWIG40Cs+14Xzy/n1UZhAs2SA7Y=;
        b=Hpkuv3FuzjPSSr0s6F44u38vgcNHlm+qRMjeYeN7DIsx21Rsy9qLhJ5oEBuE8cQ/7f
         gOpz2Bj3B67JNdQamqt+Ozf3edx8hu0xz2RHktD9bpO+nylhjuNAMYwnNwIo6b8qnozZ
         fg+ig/rNBELojRZmBxz/AFPKmosHpIsdl3Ju11XgzLo3q5iaKErlZ2h+34ofKgjDmYMx
         u2/wfAHx5OKbtXlQlZ6UHEX9imLI/gmldPXHirM2E3tNxpKd9wKRRnpSDehfprqIsuRW
         iIw7B+dKVDa8x/owDtPwtAVGd1JZmZFj1TbtOAEO2j4z80eTYAYboWNN9dEvDbq0JYlh
         ivww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bsgs5v64dtrb9BK/zWIG40Cs+14Xzy/n1UZhAs2SA7Y=;
        b=hiMlnlF3YzbFur/6FkV4sdwRt9c9f0QGbYVPzCjf9v531POBorPuGxgI9vHXRX678R
         jua+a6Yfrg0U0mC4UHNX6eSjAcT9P7iWJKOKKmFGOF9LGWYPjg4mPprZf72b96uG26U+
         wxsB4h5vuCQwmyfsDLlgTd+EDRSvMKrQ5F9kJJW+vzpBeMfkpoueLB+ha+IyPbxA6+ot
         7/BOD3xe2fwCu5WrBaOOz3xPpBgry2otWUcY2IyobkzM7etlvcH34Jmes0KFKaAaYj1e
         zbbeR3fEkfacjWO+ReJZg57nyNs34U2bCVkfA4N6/JVd0F2kdxgc2mvzZ1YcDh12G6F5
         Doqw==
X-Gm-Message-State: ACrzQf3aZSbnuaTNXpiiGghv/nKTJSR7ir4rUI7jUYz7QmXhPAJqXYJC
        0l7t02xgERHoRkGZngNmhF3WoA7y12E=
X-Google-Smtp-Source: AMsMyM7fGIPxzSTLIQa+n/MHhyw5CshqI5Un4z11aCmNOAlJoBCo/++l8HBiFLG3r6/zKNcOCfRZrQ==
X-Received: by 2002:aa7:c956:0:b0:43b:206d:c283 with SMTP id h22-20020aa7c956000000b0043b206dc283mr39516948edt.381.1667635959118;
        Sat, 05 Nov 2022 01:12:39 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:9819:17f5:ee0c:a9e6? ([2a02:908:1256:79a0:9819:17f5:ee0c:a9e6])
        by smtp.gmail.com with ESMTPSA id cm21-20020a0564020c9500b00461a6997c5dsm804192edb.83.2022.11.05.01.12.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Nov 2022 01:12:38 -0700 (PDT)
Message-ID: <d50ea531-c5cf-81d5-9cc5-0ab92b39232d@gmail.com>
Date:   Sat, 5 Nov 2022 09:12:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [Linaro-mm-sig] Re: [RFC][PATCH v3 12/33] timers: dma-buf: Use
 timer_shutdown_sync() before freeing timer
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
References: <20221104054053.431922658@goodmis.org>
 <20221104054914.085569465@goodmis.org>
 <20221104015444.57f73efb@rorschach.local.home>
 <d916e29d-d098-c3f3-940a-37be6772ecb5@amd.com>
 <20221104145804.4ec8404e@rorschach.local.home>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20221104145804.4ec8404e@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 04.11.22 um 19:58 schrieb Steven Rostedt:
> On Fri, 4 Nov 2022 08:15:53 +0100
> Christian König <christian.koenig@amd.com> wrote:
>
>>> index fb6e0a6ae2c9..5d3e7b503501 100644
>>> --- a/drivers/dma-buf/st-dma-fence.c
>>> +++ b/drivers/dma-buf/st-dma-fence.c
>>> @@ -412,7 +412,7 @@ static int test_wait_timeout(void *arg)
>>>    
>>>    	err = 0;
>>>    err_free:
>>> -	del_timer_sync(&wt.timer);
>>> +	timer_shutdown_sync(&wt.timer);
>> Mhm, what exactly is the benefit of renaming the function?
>>
>> Not that I'm against the change, but my thinking is more if there are
>> more functions which don't re-arm the time than those which do that then
>> why not forbid it in general?
> Timers are more often re-armed then not. I had to look for the
> locations where del_timer*() was called just before freeing, and other
> locations where they are freed later.
>
> I didn't rename del_timer_sync() to timer_shutdown_sync(), this version
> renamed the new "del_timer_shutdown()" to "timer_shutdown_sync()".
>
> Maybe I'm just confused at what you are asking.

No, that explains it a bit better. I was just wondering what exactly the 
different to del_timer_sync() is.

Maybe shorten the summary in the cover letter a bit. The history how 
this change came to be is not as interesting as why we are changing 
something.

Regards,
Christian.

>
> -- Steve
> _______________________________________________
> Linaro-mm-sig mailing list -- linaro-mm-sig@lists.linaro.org
> To unsubscribe send an email to linaro-mm-sig-leave@lists.linaro.org

