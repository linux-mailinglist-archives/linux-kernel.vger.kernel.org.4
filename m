Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC83745F51
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjGCPAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjGCPAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:00:50 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D3CE5F
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 08:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lEjQPsDxtRvLE8zahWewvCEDc9M1w1GJ+mEScSJMMVI=; b=DCkVBEqraHjIzrkzpVAu1I1fMd
        x3M/MmqmMrkVCu9Ew6c43mRhieNKUGOms4QP8dpBCjOZAB0UWS8JNJcENWnCEtO/+uvs9T3VV24Xq
        NB+i1YpIkToHgtjWBn5P/VNcB3QRPnSEApYb3Gt3m+DFB1AlMRyDR6OjuPoJKq9pVl6AykNL+zf4R
        NpgK2Olt4YDPJkE0m4UsEZSwHol2ZztANfqDUJ14FhzAfzMDSqEXaFjXU39+Ek/9+rQX6/CKKbGm9
        9hBkn1s0AKmt8gtoXeZRxNBo0Nk+iHLuJt+EC9N9OHFt+qW1Vyb3NyOgGHQdNuQr6UNq9cP0k5Zth
        EbyfCPUA==;
Received: from [187.74.70.209] (helo=[192.168.1.111])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qGL2R-007fhp-7K; Mon, 03 Jul 2023 17:00:27 +0200
Message-ID: <cedc57a5-779a-3ec6-cfbd-f51dfb17f2dc@igalia.com>
Date:   Mon, 3 Jul 2023 12:00:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 1/1] drm/doc: Document DRM device reset expectations
To:     Pekka Paalanen <ppaalanen@gmail.com>
Cc:     =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
        pierre-eric.pelloux-prayer@amd.com,
        Sebastian Wick <sebastian.wick@redhat.com>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>,
        amd-gfx@lists.freedesktop.org,
        =?UTF-8?Q?Timur_Krist=c3=b3f?= <timur.kristof@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        alexander.deucher@amd.com,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        kernel-dev@igalia.com, christian.koenig@amd.com
References: <20230627132323.115440-1-andrealmeid@igalia.com>
 <CA+hFU4z1pc=KUVVqyqfXEceUqMXQgh-qUnuB=1nkPELghvQO7w@mail.gmail.com>
 <CADnq5_MNVdtdcWKSz6dgmsjg+kEu8p5FVE+fkw_5BaXeG3QGow@mail.gmail.com>
 <afab1f5a-e581-3416-e2c2-238ea120655b@mailbox.org>
 <CAAxE2A5C96k5ua+r938VA_+w7gHHNTdF3n8LwDb98W0Bf9wCVA@mail.gmail.com>
 <7c1e6df5-1ad4-be3c-b95d-92dc62a8c537@mailbox.org>
 <20230703114949.796c7498@eldfell>
Content-Language: en-US
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20230703114949.796c7498@eldfell>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Em 03/07/2023 05:49, Pekka Paalanen escreveu:
> On Mon, 3 Jul 2023 09:12:29 +0200
> Michel Dänzer <michel.daenzer@mailbox.org> wrote:
> 
>> On 6/30/23 22:32, Marek Olšák wrote:
>>> On Fri, Jun 30, 2023 at 11:11 AM Michel Dänzer <michel.daenzer@mailbox.org <mailto:michel.daenzer@mailbox.org>> wrote:
>>>> On 6/30/23 16:59, Alex Deucher wrote:
>>>>> On Fri, Jun 30, 2023 at 10:49 AM Sebastian Wick
>>>>> <sebastian.wick@redhat.com <mailto:sebastian.wick@redhat.com>> wrote:
>>>>>> On Tue, Jun 27, 2023 at 3:23 PM André Almeida <andrealmeid@igalia.com <mailto:andrealmeid@igalia.com>> wrote:
>>>>>>>
>>>>>>> +Robustness
>>>>>>> +----------
>>>>>>> +
>>>>>>> +The only way to try to keep an application working after a reset is if it
>>>>>>> +complies with the robustness aspects of the graphical API that it is using.
>>>>>>> +
>>>>>>> +Graphical APIs provide ways to applications to deal with device resets. However,
>>>>>>> +there is no guarantee that the app will use such features correctly, and the
>>>>>>> +UMD can implement policies to close the app if it is a repeating offender,
>>>>>>> +likely in a broken loop. This is done to ensure that it does not keep blocking
>>>>>>> +the user interface from being correctly displayed. This should be done even if
>>>>>>> +the app is correct but happens to trigger some bug in the hardware/driver.
>>>>>>
>>>>>> I still don't think it's good to let the kernel arbitrarily kill
>>>>>> processes that it thinks are not well-behaved based on some heuristics
>>>>>> and policy.
>>>>>>
>>>>>> Can't this be outsourced to user space? Expose the information about
>>>>>> processes causing a device and let e.g. systemd deal with coming up
>>>>>> with a policy and with killing stuff.
>>>>>
>>>>> I don't think it's the kernel doing the killing, it would be the UMD.
>>>>> E.g., if the app is guilty and doesn't support robustness the UMD can
>>>>> just call exit().
>>>>
>>>> It would be safer to just ignore API calls[0], similarly to what
>>>> is done until the application destroys the context with
>>>> robustness. Calling exit() likely results in losing any unsaved
>>>> work, whereas at least some applications might otherwise allow
>>>> saving the work by other means.
>>>
>>> That's a terrible idea. Ignoring API calls would be identical to a
>>> freeze. You might as well disable GPU recovery because the result
>>> would be the same.
>>
>> No GPU recovery would affect everything using the GPU, whereas this
>> affects only non-robust applications.
>>
>>
>>> - non-robust contexts: call exit(1) immediately, which is the best
>>> way to recover
>>
>> That's not the UMD's call to make.
>>
>>
>>>>      [0] Possibly accompanied by a one-time message to stderr along
>>>> the lines of "GPU reset detected but robustness not enabled in
>>>> context, ignoring OpenGL API calls".
>>
> 
> Hi,
> 
> Michel does have a point. It's not just games and display servers that
> use GPU, but productivity tools as well. They may have periodic
> autosave in anticipation of crashes, but being able to do the final
> save before quitting would be nice. UMD killing the process would be
> new behaviour, right? Previously either application's GPU thread hangs
> or various API calls return errors, but it didn't kill the process, did
> it?
> 

In Intel's Iris, UMD may call abort() for the reset guilty application:

https://elixir.bootlin.com/mesa/mesa-23.0.4/source/src/gallium/drivers/iris/iris_batch.c#L1063

I was pretty sure this was the same for RadeonSI, but I failed to find 
the code for this, so I might be wrong.

> If an application freezes, that's "no problem"; the end user can just
> continue using everything else. Alt-tab away etc. if the app was
> fullscreen. I do that already with games on even Xorg.
> 
> If a display server freezes, that's a desktop-wide problem, but so is
> killing it.
> 

Interesting, what GPU do you use? In my experience (AMD RX 5600 XT), 
hanging the GPU usually means that the rest of applications/compositor 
can't use the GPU either, freezing all user interactions. So killing the 
guilty app is one effective solution currently, but ignoring calls may 
help as well.

> OTOH, if UMD really does need to terminate the process, then please do
> it in a way that causes a crash report to be recorded. _exit() with an
> error code is not it.
> 

In the "Reporting causes of resets" subsection of this document I can 
add something for UMD as well.

> 
> Thanks,
> pq
