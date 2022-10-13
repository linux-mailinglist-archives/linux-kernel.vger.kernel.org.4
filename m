Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0175FD42F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 07:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiJMFUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 01:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiJMFUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 01:20:10 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E9580EA4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 22:20:06 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id q9so659929pgq.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 22:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j339I4LKiSmkjT8SwB4/ylltBaTona5Ee0gHV/DqG/M=;
        b=ZYktr17UImf5XPu8Ob2vrY6PSZ0nsHPOPGytdOayvYaZaz2EurrTfnNdPcah4itVBD
         XSawQ1egXSsmRIC+BJhzuyeCV7qah8VuI6z/mkwBdCgOn36VyhN1FlDv942YS8hJoX2g
         yzSQ/mM5iuhV2jMB6DPNE8hzN7+fXKwl1i6YbaSn8NFjapLJp/2LRwf/5ejJGtiYJgpA
         PpAnKmN+PgvogrPmSFWishhpMRNwYLvgk++EB3XxovgnFCDWB0NaB7GsrUQ64fYEhc2q
         bzGK17CTQUastpx/pIJnS18H1mrLdeLT5oz3b9F/tiMtW8t4lwAbR1yBiTEXVAZcAepM
         n/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j339I4LKiSmkjT8SwB4/ylltBaTona5Ee0gHV/DqG/M=;
        b=geUnz1Tp814V2R7bWDkH36lJGM/zbvnZuS5bOLcAqmqmGXAOoH0Gc6HWkA59Jpcf9B
         +XKce/eP4szQMEr2RY2Nu49/UXKUl+fyQ35OOy0T6Q9q1aD7nJUsWdy+d5xPBcucESaQ
         4wcwPItip0AH68az3CxBZDsbX6j9FlcqP4Ao7twBy3H7prF+fIjdZWmVvyb1BbWp1d6d
         ZMGWYcoGJ6tM5eKZJ88h50qvnoNlvbsLBA61uS2qpT+t7YGX2g1xE76KAm+nMtTkr0oe
         1+J7ckmPovQcHbd27n+4TJYPNKs07e9xCbd0jT80rM/spW5Yv7HfXo2to7Z+Oi8LRwxX
         7ixQ==
X-Gm-Message-State: ACrzQf1ky56pTM7CHkyXaEK64eIoB3exnBpLysOkHHItKzY8dzs8hRVD
        jUvXtySELdkq9+A3FkiMacg=
X-Google-Smtp-Source: AMsMyM5AV5Z/58Cx/5fQXKMNAh6hOETtKM5qigRaM9XNRUelZfM2yR4jFNTdf/UxDsMcVv4ATpFdiA==
X-Received: by 2002:a63:1e0f:0:b0:44b:796c:bc14 with SMTP id e15-20020a631e0f000000b0044b796cbc14mr27981439pge.563.1665638405394;
        Wed, 12 Oct 2022 22:20:05 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z8-20020a170903018800b00177c488fea5sm11736743plg.12.2022.10.12.22.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 22:20:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c67aa49c-e260-fedc-4f91-18278dc21f1f@roeck-us.net>
Date:   Wed, 12 Oct 2022 22:20:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ajd@linux.ibm.com, aneesh.kumar@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, christophe.leroy@csgroup.eu,
        cuigaosheng1@huawei.com, david@redhat.com, farosas@linux.ibm.com,
        geoff@infradead.org, gustavoars@kernel.org, haren@linux.ibm.com,
        hbathini@linux.ibm.com, joel@jms.id.au, lihuafei1@huawei.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        lukas.bulwahn@gmail.com, mikey@neuling.org, nathan@kernel.org,
        nathanl@linux.ibm.com, nicholas@linux.ibm.com, pali@kernel.org,
        paul@paul-moore.com, rmclure@linux.ibm.com, ruscur@russell.cc,
        windhl@126.com, wsa+renesas@sang-engineering.com,
        ye.xingchen@zte.com.cn, yuanjilin@cdjrlc.com,
        zhengyongjun3@huawei.com
References: <87edvhntv0.fsf@mpe.ellerman.id.au>
 <20221012141827.GA2405914@roeck-us.net> <Y0biBtCUtc2mowbQ@zx2c4.com>
 <20221012164452.GA2990467@roeck-us.net> <Y0b3ZsTRHWG6jGK8@zx2c4.com>
 <20221012221615.GA364143@roeck-us.net> <87bkqgmvxl.fsf@mpe.ellerman.id.au>
 <20221013002148.GA535574@roeck-us.net> <CNKJ6FE6U35I.3ERMDQR9MHRLX@bobo>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.1-1 tag
In-Reply-To: <CNKJ6FE6U35I.3ERMDQR9MHRLX@bobo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/22 22:03, Nicholas Piggin wrote:
> On Thu Oct 13, 2022 at 10:21 AM AEST, Guenter Roeck wrote:
>> On Thu, Oct 13, 2022 at 11:03:34AM +1100, Michael Ellerman wrote:
>>> Guenter Roeck <linux@roeck-us.net> writes:
>>>> On Wed, Oct 12, 2022 at 11:20:38AM -0600, Jason A. Donenfeld wrote:
>>>>>
>>>>> I've also managed to not hit this bug a few times. When it triggers,
>>>>> after "kprobes: kprobe jump-optimization is enabled. All kprobes are
>>>>> optimized if possible.", there's a long hang - tens seconds before it
>>>>> continues. When it doesn't trigger, there's no hang at that point in the
>>>>> boot process.
>>>>>
>>>>
>>>> I managed to bisect the problem. See below for results. Reverting the
>>>> offending patch fixes the problem for me.
>>>
>>> Thanks.
>>>
>>> This is probably down to me/us not testing with PREEMPT enabled enough.
>>>
>> Not sure. My configuration has
>>
>> CONFIG_PREEMPT_NONE=y
>> # CONFIG_PREEMPT_VOLUNTARY is not set
>> # CONFIG_PREEMPT is not set
> 
> Thanks very much for helping with this. The config snippet you posted here
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2022-October/249758.html
> has CONFIG_PREEMPT=y. How do you turn that into a .config, olddefconfig?
> 
> I can't reproduce this so far using your config and qemu command line,
> but the patch you've bisected it to definitely could cause this. I'll
> keep trying...
> 

Uuh, sorry, I think I got confused with running multiple bisects on the
same branch, and took the above from a different bisect run. You are
correct, PREEMPT is enabled in the configuration.

Timing is definitely involved; I see the problem more often on a loaded
system. To bisect it, I had to repeat the test for each bisect step
several times (I set the limit to 20 retries; that gave me reliable
results).

Guenter
