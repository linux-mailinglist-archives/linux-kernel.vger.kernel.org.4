Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B2B6A7187
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 17:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjCAQtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 11:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCAQtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 11:49:19 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E05D31C;
        Wed,  1 Mar 2023 08:49:18 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id q15so11240366oiw.11;
        Wed, 01 Mar 2023 08:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677689358;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c9wdsbMNTHgMb7ajw9hv0Rh+JOQBVAyLx532BC1s6iE=;
        b=U1Yl+mNkFHrt0SXv9IwKGhR8sXq06pVxP6InfL46oF1B7cpqJQ5/jFIdZhzAXciBU1
         l5yI/qvq+6jMiFutnpJjOvP0HIuqQHANRIzY5mFJjyrsZvv9de1xrDsA/qF0m8hAwVEW
         6OIUajzzrKDyv8teNK4qHCseQZmzYRoxvZiLmyFgJvRhP2AZsOFeOjPGVwQuxrZ3zlcV
         GcWcD8uTK6i4qOaruxIeVPc15UovbtiyQW4jkR5jkP31/nKGKASM/T2UwUMk1CaVrTSi
         Uxqm3+NQBWwLQZC7P4jV9u65bl6f2XRQ7+RjLi+gyzQNM/mKNO+zFI7ecvRV4HDGqCDO
         bdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677689358;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c9wdsbMNTHgMb7ajw9hv0Rh+JOQBVAyLx532BC1s6iE=;
        b=n5AKNOeJnoEWrfmr3N16SuWLezQsaiiX65MecVH6sntJB3qdy/ndosJvMwSyuWTism
         PNgvvPNwRz9E8p/pnygcYmPT4xCWS5ZLlpPbaBawlEgoxD9K7ZFZiljqmrO79PELb7p+
         goiLvfcSi9I8rY4h53JaxnFTl2WRc8XgzRd61B8T/Unt3A8ZqfAv0gTB0/WLle7eenWD
         0rEitcLNjeSfr8ifBjDFfZ7gGXRa3qi2CL1D+k4bqFTh7EgaVoQ8QPi8IQrFEY2MMPNu
         mfFM6mOGYVFmRSS/5+pQe8Vozdc723NcnfwJcai2nnZW+o6Ixb3x2H7iy2f0zaBwE1Gc
         posQ==
X-Gm-Message-State: AO0yUKVrQNEjqIdR4i974ZS+5QDh28zWhCayXfqTzKYmQtWJ2yO7aln1
        v2SrJC0DfuDFo4KyseXaUK95vPS5yHI=
X-Google-Smtp-Source: AK7set+XgZ2E22V1a/xAX5ViVgWp2cA9EwhZpIk5PZsoOGa0dx98vAEyBEUwVcKcC2Gi3WUi9G/Zvw==
X-Received: by 2002:a05:6808:5d0:b0:37f:a486:c92a with SMTP id d16-20020a05680805d000b0037fa486c92amr3095080oij.22.1677689357859;
        Wed, 01 Mar 2023 08:49:17 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:404a:d987:1f3d:2ea? ([2600:1700:2442:6db0:404a:d987:1f3d:2ea])
        by smtp.gmail.com with ESMTPSA id j19-20020a9d7f13000000b00690dd5e7345sm5088031otq.26.2023.03.01.08.49.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 08:49:17 -0800 (PST)
Message-ID: <f26ffb41-f542-2809-9818-903947dd6eb4@gmail.com>
Date:   Wed, 1 Mar 2023 10:49:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 1/2] of: create of_root if no dtb provided
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230223213418.891942-1-frowand.list@gmail.com>
 <20230223213418.891942-2-frowand.list@gmail.com>
 <CAL_JsqLR9sm+GRU8EP4eO_Ln2UhD=ztdAU834CzP8RSv2s2jQg@mail.gmail.com>
 <cbf76155-4355-5241-d7a5-816e6721ce1b@gmail.com>
 <20230301030003.GA263873-robh@kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20230301030003.GA263873-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/23 21:00, Rob Herring wrote:
> On Tue, Feb 28, 2023 at 08:05:58PM -0600, Frank Rowand wrote:
>> On 2/27/23 11:17, Rob Herring wrote:
>>> On Thu, Feb 23, 2023 at 3:34 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>>>
>>>> When enabling CONFIG_OF on a platform where of_root is not populated by
>>>> firmware, we end up without a root node. In order to apply overlays and
>>>> create subnodes of the root node, we need one. Create this root node
>>>> by unflattening an empty builtin dtb.
>>>>
>>>> If firmware provides a flattened device tree (FDT) then the FDT is
>>>> unflattened via setup_arch().  Otherwise, setup_of() which is called
>>>> immediately after setup_arch(), and will create the default root node
>>>> if it does not exist.
>>>
>>> Why do we need a hook after setup_arch() rather than an initcall?
>>>
>>> Rob
>>
>> It might work as an initcall today.  Maybe not in the future as other
>> initcalls are added.
> 
> That's an argument for never using initcalls (not a bad one either). But 
> we have them and we have little reason not to use them. Also, it's 
> better to do things as late as possible I've found. The earlier you do 
> things, the more architecture specific stuff you hit. That's a big 
> reason for the remaining differences in FDT init across architectures. 
> Maybe after setup_arch is late enough. IDK.
> 
>> But my main stream of thinking is that before the patch "we know" that
>> the device tree data structure exists when setup_arch() returns.
>> Adding setup_of() immediately after setup_arch() retains that
>> guarantee, but one line later in start_kernel().
> 
> I get the logic. I'd just rather not add another hook between the DT 
> code and the core/arch code. Especially for this niche usecase.
> 
> We already have the secondary init when sysfs is up. Can't we just do 
> this there?

In general, I agree with your sentiments about an initcall being a preferred
solution.

But when I was looking at the suggested alternatives, I noticed one sticking
point.  The new setup_of() calls unflatten_device_tree(), which calls
unittest_unflatten_overlay_base().  The call to unittest_unflatten_overlay_base()
is deliberately very early in the boot, so that the memory allocator used
for this very small portion of the devicetree nodes created for unittest
is the same early boot allocator that is used to unflatten an FDT passed
to the kernel from a bootloader.

Digging through this led me to another issue.  I have not tested this patch
series on a user mode linux kernel (on my todo list...).  For user mode linux,
unittest_data_add() is called directly from the late initcall of_unittest().
So for user mode linux, unittest_data_add() will be called a second time - I
need to remove that second call and make sure unittest still works on user
mode linux.

> 
>> I could have instead put the call to setup_of() into each architectures'
>> setup_arch(), but that would just be duplicating the same code for each
>> architecture, which did not seem like a good choice.
> 

> Uhh, no!

Agreed, I guess I was too subtle with "did not seem like a good choice". :-)

> 
> Rob

