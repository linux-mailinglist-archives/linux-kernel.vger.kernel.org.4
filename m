Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE7561F701
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbiKGPCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbiKGPCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:02:13 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0ABF6B;
        Mon,  7 Nov 2022 07:01:02 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id h14so10828188pjv.4;
        Mon, 07 Nov 2022 07:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a0MrqnbHPZnDvh/YpC+oycujWgyQq2BY4Rq8WwgBPyw=;
        b=gf+4os4CFbzoytcTmyouVV+SBCfcWn3M3q0115f5hUF8Kug831WhRXFU1qn8e+eE2B
         BFjcWCzER4cDh/yA0fZCdBhf8btgzhoApFnbskmcXvMiP5WZSj1bER25cnjbZpnGMGmI
         tHJ8tYZMo/7JZcIZD/TE/jzBumgqS09ZaeQifyT1jq2Y1evMkLfscKzSeff6MqzGduLd
         cNVeuOlMTYVA0qNRtGvDkQ31pUNJROQ8sovkPmibMHnCBt14iAXtrHGsF3M5rwVpgSXC
         3cNOgVmb+6Tzzoh7mlk/+QSX/8TzWhP8bkxT3OqI6hj9ABxOuaKR5EptcbZUg1sN3g5I
         HQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a0MrqnbHPZnDvh/YpC+oycujWgyQq2BY4Rq8WwgBPyw=;
        b=u+KqUwAF4SA+N6VRvFqztGKo/bqTXOhziWSiSOqvMudQB0H2Blul0T+P3DuauLMoji
         73I4F15TyMM76z4d4W9L7TFH13wnH/G9iGliUDcBmQWVHZpqYDKsigK2Ah0bFAmuN1W4
         tTf02HWDyqug08SBPX7UNzdjlKRktgeWP5ieNtP15G5XCszR3hh5ho2gWdOfmHND9FPd
         3ZcFsyjNTbz2aaksz0UEMkq1GNGKtupAL3PjgVvGIel3v/vp4OIngkPvJY47PRhL4wa9
         rMGRkAtNCrcYqJHyDIS7ziHI94iTrBxrkSeDOOfloyYHpLag3r6leKXFrdmcGBdqtYJc
         V83Q==
X-Gm-Message-State: ACrzQf3x4SOM1udOWasZYsMQ6NxSn3EfSGk1n3ja6/T2w2OxPXFSZTr9
        Onk8ssbfjSJN3y+U8gThkCc=
X-Google-Smtp-Source: AMsMyM4dhXjxI6tSHJRZYru9IUeKo5ZSr4xx+gkS1g0EFbj/Oywe3OWzjGzt3OJG9YhODGa+e09LTA==
X-Received: by 2002:a17:90b:4c46:b0:213:d3e3:ba44 with SMTP id np6-20020a17090b4c4600b00213d3e3ba44mr43930855pjb.18.1667833262146;
        Mon, 07 Nov 2022 07:01:02 -0800 (PST)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id w31-20020a17090a6ba200b0020063e7d63asm4390386pjj.30.2022.11.07.07.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 07:01:01 -0800 (PST)
Message-ID: <6e64768e-d245-dbd5-7258-2b1b72fab5ee@gmail.com>
Date:   Tue, 8 Nov 2022 00:00:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] docs/ja_JP/howto: Update for v6.1
Content-Language: en-US
To:     Tsugikazu Shibata <shibata@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kosuke Fujimoto <fujimotokosuke0@gmail.com>,
        Akira Yokosawa <akiyks@gmail.com>
References: <20221030115209.25924-1-akiyks@gmail.com>
 <CAO+cJp20skpBaWwG+yoRJtwv+L98HYfonZxc_qfEZL2JJp_9EA@mail.gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <CAO+cJp20skpBaWwG+yoRJtwv+L98HYfonZxc_qfEZL2JJp_9EA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2022 21:01:28 +0900, Tsugikazu Shibata wrote:
> On Sun, Oct 30, 2022 at 8:52 PM Akira Yokosawa <akiyks@gmail.com> wrote:
>>
>> Reflect changes made in commits listed below:
>>
>>   388f9b20f98d ("Documentation/process/howto: Only send regression fixes after -rc1").
>>   bc0ef4a7e4c3 ("Doc: Delete reference to the kernel-mentors mailing list")
>>   bcd3cf0855c5 ("Doc: Remove outdated info about bugzilla mailing lists")
>>   dad051395413 ("Doc: add a missing cross-reference")
>>   9799445af124 ("Doc: tidy up TOCs and refs to license-rules.rst")
>>   fb0e0ffe7fc8 ("Documentation: bring process docs up to date")
>>   e7b4311ebcac ("Replace HTTP links with HTTPS ones: Documentation/process")
>>   f1eebe92c265 ("Documentation/HOWTO: adjust external link references")
>>   da514157c4f0 ("docs: make reporting-bugs.rst obsolete")
>>   cf6d6fc27936 ("docs: process/howto.rst: make sections on bug reporting match practice")
>>
>> Co-developed-by: Kosuke Fujimoto <fujimotokosuke0@gmail.com>
>> Signed-off-by: Kosuke Fujimoto <fujimotokosuke0@gmail.com>
>> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
>> Cc: Tsugikazu Shibata <shibata@linuxfoundation.org>
>> ---
>> Brief history of the change:
>>
>> I (Akira) asked Kosuke of updating ja_JP/howto.rst after the merge of
>> his earlier contributions:
>>   e0bd6f14c28f ("docs/ja_JP/index: update section title in Japanese")
>>   6548e96edb50 ("docs/trans/ja_JP/howto: Don't mention specific kernel versions")
>>
>> Kosuke made his WIP commits public at:
>>     https://github.com/KosukeFujimoto/linux/tree/WIP-docs-ja-jp-howto
>>
>> He moved over to other responsibilities soon after and could not make
>> them ready for submission. Seeing almost half a year had passed without
>> any activity, I took over and assembled those small changes into a single
>> patch.
>>
>> I picked Kosuke's S-o-b from his github commits.
>> As I also improved some of translations along the way, I assigned myself
>> as the author and added Kosuke's co-developed-by tag.
>>
>> Shibata-san, hopefully can you review this update?
>>
>> Jon, I'll ask you when I feel like this one is ready to be applied.
>>
>>         Thanks, Akira
>> --
>>  Documentation/translations/ja_JP/howto.rst | 66 ++++++++++------------
>>  1 file changed, 31 insertions(+), 35 deletions(-)
>>
[...]
> 
> Thank you for the patches and all the patches look good to me.
> Acked-by: Tsugikazu Shibata <shibata@linuxfoundation.org>

Thank you Shitata-san for taking the time to review.

Jon, looks like this is ready for v6.2.

        Thanks, Akira

> 
> Tsugikazu Shibata
