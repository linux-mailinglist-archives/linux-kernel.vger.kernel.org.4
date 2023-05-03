Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC7D6F526B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 09:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjECH7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 03:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjECH7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 03:59:20 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A80135B0
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 00:59:19 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-94f3df30043so780225366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 00:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683100757; x=1685692757;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n2lIatLtxS/6Cq5Ij16t1kjY3cuWYBdjoqqifNQbzJ0=;
        b=DOS/xq+cYgi2rm7lNlZXy9XxJnguOr4ukDE7HlwSSGNfuchYEibFzGrCDB4JCmZDpP
         +Vp88JXbD9SBlbhs+0GhYf52FYivkDHS2VGGJyjmQr2yRAlrJOm8uVQAvGJnDxjrkxfV
         StCf39JolnezT8H3ADMXoPkBKlp7wB9bo5CkvVg3QZfKF4JGJA5j+hVU4296EqrccSzH
         NgzK+/qVIN43BzAVnOg/cOe94u/MnVVWBDmdra5++VtKRiBDY2VMMCetOpNJQ+WDDUgh
         pSufUDhgScQVCXzfAWIbWWE+DI9bwyEScM4kHig6AsUNHxQsLnGzwFFprTPaVG21aMu1
         Pccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683100757; x=1685692757;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n2lIatLtxS/6Cq5Ij16t1kjY3cuWYBdjoqqifNQbzJ0=;
        b=NPoRVD0T6BDEtXrjAdKgVIuSOcEIj41xhnD6816D7xasvqZuc5mIAqfLKXxIGSg6qG
         ffc+bsydFtLtneTejbnacspfV3Je/RH1iWVNG8kcVSuOb8p6PgGZ27sj3kjof2Ix/ZEh
         YO4grJfkTYoqCqmNnjvnrrzv3yzU17S+yUdFZ+pIVB/m/qz5EGfWh8AyO521k2Ez42Bs
         nOTxN0er7//7TyZ9DDLvqckZjFXgRl1Blu9stTnPLEC+Ws7OemxemfFZnM75RAn/Hh1R
         tBHMdHBhC1gyQb2TQEXxEOWNCxffAap9zHficM257j7TzdI4WQ3OZACZ4xAOk3EmiW8c
         Mq2w==
X-Gm-Message-State: AC+VfDzuTeuLX7oNZeGo7c9KaOGGik7VTs5Re1OWdUX1QyXO3LOob/6C
        JsUjrnA8bvgeueU/RLkPMBA=
X-Google-Smtp-Source: ACHHUZ7QonMKpXLDNMvlR5g3wCXfj/KqGphX90kcj6y7J15I6kLWmqF8/fe8tRNYkuvkR5VIxL/NWQ==
X-Received: by 2002:a17:907:2da9:b0:94e:bd38:49bb with SMTP id gt41-20020a1709072da900b0094ebd3849bbmr2734381ejc.23.1683100757340;
        Wed, 03 May 2023 00:59:17 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:56ef:355f:bcc8:d6a8? ([2a02:908:1256:79a0:56ef:355f:bcc8:d6a8])
        by smtp.gmail.com with ESMTPSA id s1-20020a1709060c0100b0094f66176208sm17145771ejf.95.2023.05.03.00.59.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 00:59:16 -0700 (PDT)
Message-ID: <57fa0ee4-de4f-3797-f817-d05f72541d0e@gmail.com>
Date:   Wed, 3 May 2023 09:59:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 0/1] Add AMDGPU_INFO_GUILTY_APP ioctl
Content-Language: en-US
To:     Alex Deucher <alexdeucher@gmail.com>,
        =?UTF-8?Q?Timur_Krist=c3=b3f?= <timur.kristof@gmail.com>
Cc:     "Pelloux-Prayer, Pierre-Eric" <pierre-eric.pelloux-prayer@amd.com>,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
        michel.daenzer@mailbox.org, linux-kernel@vger.kernel.org,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kernel-dev@igalia.com, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20230501185747.33519-1-andrealmeid@igalia.com>
 <CADnq5_NXj4W44F_etRQ7HWdVTnf5zARCM3Y_o3EiwWiHj8QMpA@mail.gmail.com>
 <6ab2ff76-4518-6fac-071e-5d0d5adc4fcd@igalia.com>
 <cb3d2590-a1f8-fe7e-0bba-638ee80719af@amd.com>
 <CAFF-SiV0=WNmRW-D9uYUuj68Zq0APxtGLya9KR6FfZ7v0Zf2RQ@mail.gmail.com>
 <fcca2934-a556-797c-535d-a66fc67bbe30@amd.com>
 <85c538b01efb6f3fa6ff05ed1a0bc3ff87df7a61.camel@gmail.com>
 <CADnq5_NHtFbwT=x8u7GYc4ESL_HVFzjgtOd3AnVFBYMrjZq55w@mail.gmail.com>
 <c54414482b685af0991a6b095cbfb7534d998afc.camel@gmail.com>
 <CADnq5_MSY=j9AobDk7ACevur4Hwvw_ub7g16Mfm7ymMJqwVNfQ@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_MSY=j9AobDk7ACevur4Hwvw_ub7g16Mfm7ymMJqwVNfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 02.05.23 um 20:41 schrieb Alex Deucher:
> On Tue, May 2, 2023 at 11:22 AM Timur Kristóf <timur.kristof@gmail.com> wrote:
>> [SNIP]
>>>>>> In my opinion, the correct solution to those problems would be
>>>>>> if
>>>>>> the kernel could give userspace the necessary information about
>>>>>> a
>>>>>> GPU hang before a GPU reset.
>>>>>>
>>>>>   The fundamental problem here is that the kernel doesn't have
>>>>> that
>>>>> information either. We know which IB timed out and can
>>>>> potentially do
>>>>> a devcoredump when that happens, but that's it.
>>>>
>>>> Is it really not possible to know such a fundamental thing as what
>>>> the
>>>> GPU was doing when it hung? How are we supposed to do any kind of
>>>> debugging without knowing that?

Yes, that's indeed something at least I try to figure out for years as well.

Basically there are two major problems:
1. When the ASIC is hung you can't talk to the firmware engines any more 
and most state is not exposed directly, but just through some fw/hw 
interface.
     Just take a look at how umr reads the shader state from the SQ. 
When that block is hung you can't do that any more and basically have no 
chance at all to figure out why it's hung.

     Same for other engines, I remember once spending a week figuring 
out why the UVD block is hung during suspend. Turned out to be a 
debugging nightmare because any time you touch any register of that 
block the whole system would hang.

2. There are tons of things going on in a pipeline fashion or even 
completely in parallel. For example the CP is just the beginning of a 
rather long pipeline which at the end produces a bunch of pixels.
     In almost all cases I've seen you ran into a problem somewhere deep 
in the pipeline and only very rarely at the beginning.

>>>>
>>>> I wonder what AMD's Windows driver team is doing with this problem,
>>>> surely they must have better tools to deal with GPU hangs?
>>> For better or worse, most teams internally rely on scan dumps via
>>> JTAG
>>> which sort of limits the usefulness outside of AMD, but also gives
>>> you
>>> the exact state of the hardware when it's hung so the hardware teams
>>> prefer it.
>>>
>> How does this approach scale? It's not something we can ask users to
>> do, and even if all of us in the radv team had a JTAG device, we
>> wouldn't be able to play every game that users experience random hangs
>> with.
> It doesn't scale or lend itself particularly well to external
> development, but that's the current state of affairs.

The usual approach seems to be to reproduce a problem in a lab and have 
a JTAG attached to give the hw guys a scan dump and they can then tell 
you why something didn't worked as expected.

And yes that absolutely doesn't scale.

Christian.

>
> Alex

