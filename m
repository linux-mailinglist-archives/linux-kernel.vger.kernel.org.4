Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A150D64668B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 02:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiLHBgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 20:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLHBgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 20:36:10 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02836900D7
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 17:36:10 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id fa4-20020a17090af0c400b002198d1328a0so4965870pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 17:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z7fsxClu+Jd0NjsKaMgykMd0B6rUNb/ikhiPp8Ecv50=;
        b=jSOCGFfQXTv7C6fiSj3keLmm2Sq4F2mY9D9nO4IYVKX1hPEC61qXF+irZ0+ybvsab5
         ek9riN+E1ArwCXK9mkJ/u/01U8/LVzcpI9XLH6lQrfE1hurbZsz9u1XOGHytDPmYVFtn
         U+0okgzsa5kX6h846rbZAlzgLKkDoih61YnNOxdzvKiYjjg4kOxZNskp+OBHpmYbo7TN
         JeXcNfP9k34kF4B7S3eMfEJ9U4FJNYW6qjEGmIglAmpoEHci+8wxtqmcVF5C+en5q4YJ
         HBh2DBmLyg6kXgDZ9nb0iu9WiGqW8sQNlnBSm5ZLrnFk9Pj0VOHd6tPnxqbV2rYR0zLC
         k/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z7fsxClu+Jd0NjsKaMgykMd0B6rUNb/ikhiPp8Ecv50=;
        b=s1M/yRlJngwYe802PKXFjj3JQCiDWf64D077+Y3/ETSU8+/joTcbSfVhUR+oGXmhbf
         Z17kE4G+Zy36rdholoCoT/CmHztTk7VDr4B7b7RtDAAIKw8HeBF7irY5UtCXx23qQ4uZ
         +DCZs8WNCt7wS8qpjCOXTt0RGZMO7YJwPP7ZOj+b/LA9Ud5bZtYhKJDUZ7u1nqwmKtJ/
         XU7YkF1eAAEb+EsFInwjXNyj7o/TTevOF/2Iz1BE4vxux6vbtH8qy23Wn0Sap7ktaV/M
         biAQZ29E2/RxhBNhKKU5V/n+Xfp1UBEa6yaNR9LlwVohfCTAHPWFUGmgTrvTD5i68hbn
         rzfQ==
X-Gm-Message-State: ANoB5pmrnJw4pr2BuAqVjRuQ9csoQwEb2Ff/HJ42qWdrldLXrRHTzlB2
        EARy6Tas0ZfYTqLzvCpsQN6eIg==
X-Google-Smtp-Source: AA0mqf5lVcwscHjcTHlexgdjucEx1RkH82KSuPvdJV0UjV2u7ZYNBp0UlKILRUfrDVy0Stgnws+aig==
X-Received: by 2002:a17:902:b416:b0:186:a22a:177e with SMTP id x22-20020a170902b41600b00186a22a177emr76022166plr.163.1670463369398;
        Wed, 07 Dec 2022 17:36:09 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id f29-20020aa79d9d000000b00576ee69c130sm6464039pfq.4.2022.12.07.17.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 17:36:08 -0800 (PST)
Message-ID: <e05d3b3d-223f-ecf9-0e41-25bbae33eb54@kernel.dk>
Date:   Wed, 7 Dec 2022 18:36:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: next: LTP: syscalls: epoll_clt() if fd is an invalid fd expected
 EBADF: EINVAL (22)
Content-Language: en-US
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, regressions@lists.linux.dev,
        lkft-triage@lists.linaro.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, chrubis <chrubis@suse.cz>
References: <CA+G9fYv_UU+oVUbd8Mzt8FkXscenX2kikRSCZ7DPXif9i5erNg@mail.gmail.com>
 <b7d8193c-7e15-f5cd-08d4-8ef788d9bb36@kernel.dk>
 <CADYN=9LaiBU-Q5=FSvFKTi_qzE1C45DkdUAfbaZH7FZhn2tbYw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADYN=9LaiBU-Q5=FSvFKTi_qzE1C45DkdUAfbaZH7FZhn2tbYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/22 3:27 PM, Anders Roxell wrote:
> On Wed, 7 Dec 2022 at 17:22, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 12/7/22 8:58?AM, Naresh Kamboju wrote:
>>> LTP syscalls epoll_ctl02 is failing on Linux next master.
>>> The reported problem is always reproducible and starts from next-20221205.
>>>
>>> GOOD tag: next-20221202
>>> BAD tag: next-20221205
>>>
>>> tst_test.c:1524: TINFO: Timeout per run is 0h 05m 00s
>>> epoll_ctl02.c:87: TPASS: epoll_clt(...) if epfd is an invalid fd : EBADF (9)
>>> epoll_ctl02.c:87: TPASS: epoll_clt(...) if fd does not support epoll : EPERM (1)
>>> epoll_ctl02.c:87: TFAIL: epoll_clt(...) if fd is an invalid fd
>>> expected EBADF: EINVAL (22)
>>> epoll_ctl02.c:87: TPASS: epoll_clt(...) if op is not supported : EINVAL (22)
>>> epoll_ctl02.c:87: TPASS: epoll_clt(...) if fd is the same as epfd : EINVAL (22)
>>> epoll_ctl02.c:87: TPASS: epoll_clt(...) if events is NULL : EFAULT (14)
>>> epoll_ctl02.c:87: TPASS: epoll_clt(...) if fd is not registered with
>>> EPOLL_CTL_DEL : ENOENT (2)
>>> epoll_ctl02.c:87: TPASS: epoll_clt(...) if fd is not registered with
>>> EPOLL_CTL_MOD : ENOENT (2)
>>> epoll_ctl02.c:87: TPASS: epoll_clt(...) if fd is already registered
>>> with EPOLL_CTL_ADD : EEXIST (17)
>>
>> This should fix it:
>>
>>
>> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
>> index ec7ffce8265a..de9c551e1993 100644
>> --- a/fs/eventpoll.c
>> +++ b/fs/eventpoll.c
>> @@ -2195,6 +2195,7 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
>>         }
>>
>>         /* Get the "struct file *" for the target file */
>> +       error = -EBADF;
>>         tf = fdget(fd);
>>         if (!tf.file)
>>                 goto error_fput;
> 
> Yes this patch fixed the issue [1].
> 
> Cheers,
> Anders
> [1] https://lkft.validation.linaro.org/scheduler/job/5931365#L1371

Great, thanks for confirming. I did queue up the fix.

-- 
Jens Axboe


