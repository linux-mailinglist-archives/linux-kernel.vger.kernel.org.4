Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D5664C2AE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 04:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237272AbiLNDRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 22:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237285AbiLNDRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 22:17:02 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531C027B16
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 19:17:00 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id g10so1966798plo.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 19:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=zjoUL1OFj4FUNqJzzW9IevB/AH024BCp8wmz9LscwDA=;
        b=Bg2FP3HI+WEXQvFSI0TqRDR4m1oL6bTW0FrDv+c06vvkLtYqiPJUmZJOJY2IMmpDYc
         yXF9WSsfJFZ4TmnRaKa9iPxJs+F9fa8zvzoMt56jjv5GEo8FeuedhMqnveEOPS0H45xF
         h6gy3Jvx/IX4vtLEw5bgy8x7gV8C6DNdcLW63QrZTuifecsh8DcXZNEXxNpWT3ubHbg3
         zhbz/ILvgzd4clijyw47zUgkuPYbpjd0sTL275TrBb1IkI5D5Cn+h6MElaLkd1JK4qOi
         JliqwHIwsfx819pNkqf0AGpV50Ph7FIdWiBi2XPnhyrD0D4BqVz8Qzp7RHtsIhxM+he/
         AEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjoUL1OFj4FUNqJzzW9IevB/AH024BCp8wmz9LscwDA=;
        b=0MWsc/QcLuyfgo/Exbw7t23CjGw4csjcFRTvyKRi5UndH/0r4c2pO75KTYkaHv7a5R
         HMgJ51e3HcC9dj/7HHPTzVsOZbdfxANHQqDvi/2+VzM2+zBL9+GWTzHl+4JSxNHLQnP+
         HGmrqPlQoXpxY+8b8TZlsRORHI3ur2bxxkrpRF4FB9L/pyfDCUYl8x9K/MYXO1Y692Jo
         5O1CQfuZaiYYo8ZAOP6SOiw9b0iqxduHkHaLYXHTgfn3wT0i5XU4T8+6XfrJeKoxCwv5
         QPZ0JVu4j7bIJ29ORPt7lw3XfFMwLvGIzCYKDmIzM7tWkHjs1Q4L+J5cNMjSJDu7CjwM
         2x/g==
X-Gm-Message-State: ANoB5pk+D8tvfRpEzitKkGYVpR+6PB8SPMF+81SLgefvXXh5YoeKpXJt
        iOKeKWzCWY/61zCqQYmBnPHYi9cKFm6+VA==
X-Google-Smtp-Source: AA0mqf69EfFCdvv9HMZYDsuIdsnWrILf95v4hW03+BwNiLvXJbkkqznMV4X41PRmPP8P8TG5vY/Lfg==
X-Received: by 2002:a05:6a20:13a3:b0:a5:df86:f0e1 with SMTP id w35-20020a056a2013a300b000a5df86f0e1mr34252993pzh.16.1670987819802;
        Tue, 13 Dec 2022 19:16:59 -0800 (PST)
Received: from MBP ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id n6-20020a63ee46000000b0047681fa88d1sm7472285pgk.53.2022.12.13.19.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 19:16:58 -0800 (PST)
References: <20221115140233.21981-1-schspa@gmail.com>
 <m2zgc2vzwx.fsf@gmail.com> <Y5a3rAm21mCf2xrG@bombadil.infradead.org>
 <m2bko8c0yh.fsf@gmail.com> <m2pmcoag55.fsf@gmail.com>
 <Y5kE2eAa8EZUxx5b@bombadil.infradead.org>
User-agent: mu4e 1.8.10; emacs 29.0.60
From:   Schspa Shi <schspa@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org,
        syzbot+10d19d528d9755d9af22@syzkaller.appspotmail.com,
        syzbot+70d5d5d83d03db2c813d@syzkaller.appspotmail.com,
        syzbot+83cb0411d0fcf0a30fc1@syzkaller.appspotmail.com
Subject: Re: [PATCH] umh: fix UAF when the process is being killed
Date:   Wed, 14 Dec 2022 10:28:11 +0800
In-reply-to: <Y5kE2eAa8EZUxx5b@bombadil.infradead.org>
Message-ID: <m2v8me8yjj.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Luis Chamberlain <mcgrof@kernel.org> writes:

> On Mon, Dec 12, 2022 at 09:38:31PM +0800, Schspa Shi wrote:
>> I'd like to upload a V2 patch with the new solution if you prefer the
>> following way.
>> 
>> diff --git a/kernel/umh.c b/kernel/umh.c
>> index 850631518665..8023f11fcfc0 100644
>> --- a/kernel/umh.c
>> +++ b/kernel/umh.c
>> @@ -452,6 +452,11 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
>>                 /* umh_complete() will see NULL and free sub_info */
>>                 if (xchg(&sub_info->complete, NULL))
>>                         goto unlock;
>> +               /*
>> +                * kthreadd (or new kernel thread) will call complete()
>> +                * shortly.
>> +                */
>> +               wait_for_completion(&done);
>>         }
>
> Yes much better. Did you verify it fixes the splat found by the bots?
>

Yes, it will fix it.

>   Luis


-- 
BRs
Schspa Shi
