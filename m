Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C4C5BE807
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiITOFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiITOFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:05:13 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652A8100F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:05:11 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id g8so2370197iob.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=tSt+TIRAC+j8jmijeG7Slz9mQYvn4dIMqWXdxkZMwII=;
        b=pDZq9O89zt5c9P9djLhNuRMJjotd1+aXB7XJH/VMdJC20UE3ZZEKnXAyGkCDIMuTKB
         pVq/bjEuIwaRbDNl79xe2dlR5CUTvP1pB0uCV/YeONAnWgl3NkdaolR7MtLZnYr6acqi
         sF+7P2OQWc794yd0Xg+vItcDjpARQig/FvYvRfkZ/gFUpl6rBH/4PoWVnZbfza2iTtbd
         vPe04lTNR2oJamlEVQAn2RlSRO4Mho27ZdYCpH1CyUC4k6U2sGJIHYswO/PU3+CYiWGC
         93ofJYWlivrPMce3nN19QiRVl1Pyo+dMpA9AE5ogYUheoxsyPr6YnbSoTLITZscuutWP
         /PMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=tSt+TIRAC+j8jmijeG7Slz9mQYvn4dIMqWXdxkZMwII=;
        b=c7u8wkIObqffyryS6SAcwmkKXyhxM0djJzIw+uN2VCXjOMGdcBArtF5UPDbaBia6WV
         RW8gBZ8cm+icfskUJm14XgKUxbKLMe4t9xxi++amQo1XbH25M1kyUpEpRUndggpgarlw
         8AmnLmnTzYXTwz5TkOBLyCYNQeCGe+sWqxerJpB+gieYNioVQe9B8DZyFpRlOQGF0zyS
         TETfWOPLPPyNejC+YXWpzBPKCkAY8Dc9/9nwjqjTmKAaH6Hog7dQV2KShn/ZLeBXGmS3
         4cBrl4Y8m17v9CWCUBoodEj1Zh+25gbjk9RVLx/UJj70ZSTsUQp5rZe2pMWb8bpwGBpW
         DzJA==
X-Gm-Message-State: ACrzQf0fhA9PG0VGbBdWWPd7/JFIEpOx2Qbr72wazjDpGXa9fvw5oVCf
        e3jluuAVVZHguqfBn5qeEUHFEVpPC60vEQ==
X-Google-Smtp-Source: AMsMyM59GVInxWbQJpAoFsryT8RMGZ/gj3CIiidUTPZsyRhsYv7uE5TGbwRxR4macqcUYIT41f8uuA==
X-Received: by 2002:a05:6638:140e:b0:35a:7a8e:86e5 with SMTP id k14-20020a056638140e00b0035a7a8e86e5mr10502979jad.276.1663682710679;
        Tue, 20 Sep 2022 07:05:10 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x10-20020a0566380caa00b00356726330a4sm640575jad.154.2022.09.20.07.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 07:05:10 -0700 (PDT)
Message-ID: <d39e9149-fcb6-1f7c-4c19-234e74f286f8@kernel.dk>
Date:   Tue, 20 Sep 2022 08:05:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: regression caused by block: freeze the queue earlier in
 del_gendisk
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Dusty Mabe <dusty@dustymabe.com>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <017845ae-fbae-70f6-5f9e-29aff2742b8c@dustymabe.com>
 <YxBZ4BBjxvAkvI2A@T590> <20220907073324.GB23826@lst.de>
 <Yxr4SD4d0rZ9TZik@T590> <20220912071618.GA4971@lst.de>
 <Yx/jLTknQm9VeHi4@T590> <95cbd47d-46ed-850e-7d4f-851b35d03069@dustymabe.com>
 <f2c28043-59e6-0aee-b8bf-df38525ee899@leemhuis.info>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <f2c28043-59e6-0aee-b8bf-df38525ee899@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/22 3:11 AM, Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker.
> 
> On 13.09.22 04:36, Dusty Mabe wrote:
>> On 9/12/22 21:55, Ming Lei wrote:
>>> On Mon, Sep 12, 2022 at 09:16:18AM +0200, Christoph Hellwig wrote:
>>>> On Fri, Sep 09, 2022 at 04:24:40PM +0800, Ming Lei wrote:
>>>>> On Wed, Sep 07, 2022 at 09:33:24AM +0200, Christoph Hellwig wrote:
>>>>>> On Thu, Sep 01, 2022 at 03:06:08PM +0800, Ming Lei wrote:
>>>>>>> It is a bit hard to associate the above commit with reported issue.
>>>>>>
>>>>>> So the messages clearly are about something trying to open a device
>>>>>> that went away at the block layer, but somehow does not get removed
>>>>>> in time by udev (which seems to be a userspace bug in CoreOS).  But
>>>>>> even with that we really should not hang.
>>>>>
>>>>> Xiao Ni provides one script[1] which can reproduce the issue more or less.
>>>>
>>>> I've run the reproduced 10000 times on current mainline, and while
>>>> it prints one of the autoloading messages per run, I've not actually
>>>> seen any kind of hang.
>>>
>>> I can't reproduce the hang too.
>>
>> I obviously can reproduce the issue with the test in our Fedora CoreOS
>> test suite. It's part of a framework (i.e. it's not simple some script
>> you can run) but it is very reproducible so one can add some instrumentation
>> to the kernel and feed it through a build/test cycle to see different
>> results or logs.
>>
>> I'm willing to share this with other people (maybe a screen share or
>> some written down instructions) if anyone would be interested.
> 
> This thread looked stalled, or was there any progress in the past week?
> If not: Fedora apparently removed the patch in their kernels a while
> ago, as quite a few users where hitting it. What is preventing us from
> doing the same in mainline and 5.19.y until the issue can be resolved?
> The description of a09b314005f3 ("block: freeze the queue earlier in
> del_gendisk") doesn't sound like the change does something crucial that
> can't wait a bit. I might be totally wrong with that, but I think it's
> my duty to ask that question at this point.

Christoph and I discussed this one last week, and he has a plan to try
a flag approach. Christoph, did you get a chance to bang that out? Would
be nice to get this one wrapped up.

-- 
Jens Axboe


