Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBF75BF671
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 08:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiIUGfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 02:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiIUGfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 02:35:50 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EBB78584
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 23:35:47 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x27so7672386lfu.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 23:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=n+2ZxJcjb49lGiDrPW53e358mRm61CpTv1V9K9mM2/k=;
        b=Vk8cu70b2BLhdL9QfU4XqEGV6y9ItVyPNeaDVEKQyONGnm8PDjErRHMix23+F4/i+x
         DUYYEkTJv4KMbAP3ZEpf/j+LCOronifjSow3KNMiGQcTSLzm8XujG0zwvFL1JGAUrrpT
         9b7KffmeyonCFVjs0h/gXS6WI8crxWYY2Inol3d2eR+ZP4niDck6cqAFIgX0uDb28wGg
         2Hp9+yBzzBSABfL0yYGQLKS4UWWWOpl/u+yBq7z8ncvfMa1mMJ8aJp5oPJ5aI+wXKa7k
         N46xiO+36aPa1CMAq1XLpZHfoTwmKcN7amcuerVq4aup0IbPkUb2Xaf9aDm3SYq5vBAB
         PTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=n+2ZxJcjb49lGiDrPW53e358mRm61CpTv1V9K9mM2/k=;
        b=BBplQY6pRyOvbiRiN+UFydXnMH306C10WiGWze6S8ocVfmhcJniUV4XKfBChejpEzv
         rspquPQ/yeto1ComnNztgi3ghvzb2T5/Uld/Lnz+Pn2Zm+r18+nfbvY8Oz5ySZjjRb2z
         FQoXJ8NVtiB3nb5Z6+gJWqPSvrjbWgKPZm85yd80HlyBHAGpW4iobtBlfIQsvBJ8qBBb
         P/EggbbCuMaaNd1ETXAd/r835IJ7iv0V1K1/0dnd9sywPDOlDbPjbkSbCTZ+z4kbCvg4
         B7zp0SF/zl2ZUAauvU+PenS2w07ZE9oQL/m2c4nwL5r1srjB4o80Fa/DYEPxzEnKMfHg
         vP9w==
X-Gm-Message-State: ACrzQf3sIrwOigpZVWra8Blub8Fj9L9vCqvI0/te7fOV5M3fmbVEg6Nx
        Lmt/8YNiYKVHI36EhMvQecxM0A==
X-Google-Smtp-Source: AMsMyM7z6wDETlJm0X+kjb9NEoIfdgdDOeXnatO8onpzRYKhOrbOEkKmLam1fVWH+llISeTX/u+4Nw==
X-Received: by 2002:a05:6512:6d6:b0:499:27c:1aa0 with SMTP id u22-20020a05651206d600b00499027c1aa0mr9963497lff.88.1663742145891;
        Tue, 20 Sep 2022 23:35:45 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id l10-20020a056512110a00b0049f9c732858sm292693lfg.254.2022.09.20.23.35.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 23:35:45 -0700 (PDT)
Message-ID: <12602c20-d653-4d64-8589-b33270e2baa2@linaro.org>
Date:   Wed, 21 Sep 2022 08:35:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 16/21] dt-bindings: reserved-memory: introduce
 designated-movable-block
Content-Language: en-US
To:     Doug Berger <opendmb@gmail.com>, Rob Herring <robh@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Rapoport <rppt@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Oscar Salvador <osalvador@suse.de>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        - <devicetree-spec@vger.kernel.org>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mel Gorman <mgorman@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux.dev
References: <20220913195508.3511038-1-opendmb@gmail.com>
 <20220913195508.3511038-17-opendmb@gmail.com>
 <20220914145506.GA2149379-robh@kernel.org>
 <57f19774-39a1-03a6-fe68-83d7e4b16521@gmail.com>
 <07d87203-6fe1-c612-cb79-9080e1988454@linaro.org>
 <b4b2b4c6-52b6-80f0-5db3-7f7b751989c3@gmail.com>
 <e0e043aa-0f79-59a8-05ab-e48046860524@linaro.org>
 <92a2cf9f-c371-fb7d-11ff-90cdc09dcae6@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <92a2cf9f-c371-fb7d-11ff-90cdc09dcae6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2022 02:14, Doug Berger wrote:
> On 9/19/2022 4:03 AM, Krzysztof Kozlowski wrote:
>> On 19/09/2022 01:12, Doug Berger wrote:
>>> On 9/18/2022 3:31 AM, Krzysztof Kozlowski wrote:
>>>> On 14/09/2022 18:13, Doug Berger wrote:
>>>>> On 9/14/2022 7:55 AM, Rob Herring wrote:
>>>>>> On Tue, Sep 13, 2022 at 12:55:03PM -0700, Doug Berger wrote:
>>>>>>> Introduce designated-movable-block.yaml to document the
>>>>>>> devicetree binding for Designated Movable Block children of the
>>>>>>> reserved-memory node.
>>>>>>
>>>>>> What is a Designated Movable Block? This patch needs to stand on its
>>>>>> own.
>>>>> As noted in my reply to your [PATCH 00/21] comment, my intention in
>>>>> submitting the entire patch set (and specifically PATCH 00/21]) was to
>>>>> communicate this context. Now that I believe I understand that only this
>>>>> patch should have been submitted to the devicetree-spec mailing list, I
>>>>> will strive harder to make it more self contained.
>>>>
>>>> The submission of entire thread was ok. What is missing is the
>>>> explanation in this commit. This commit must be self-explanatory (e.g.
>>>> in explaining "Why are you doing it?"), not rely on other commits for
>>>> such explanation.
>>>>
>>>>>
>>>>>>
>>>>>> Why does this belong or need to be in DT?
>>>>> While my preferred method of declaring Designated Movable Blocks is
>>>>> through the movablecore kernel parameter, I can conceive that others may
>>>>> wish to take advantage of the reserved-memory DT nodes. In particular,
>>>>> it has the advantage that a device can claim ownership of the
>>>>> reserved-memory via device tree, which is something that has yet to be
>>>>> implemented for DMBs defined with movablecore.
>>>>
>>>> Rephrasing the question: why OS memory layout and OS behavior is a
>>>> property of hardware (DTS)?
>>> I would say the premise is fundamentally the same as the existing
>>> reserved-memory child node.
>>
>> I don't think it is fundamentally the same.
>>
>> The existing reserved-memory node describes memory used by hardware - by
>> other devices. The OS way of handling this memory - movable, reclaimable
>> etc - is not part of it.
>>
>> So no, it is not the same.
>>
>>>
>>> I've been rethinking how this should be specified. I am now thinking
>>> that it may be better to introduce a new Reserved Memory property that
>>> serves as a modifier to the 'reusable' property. The 'reusable' property
>>> allows the OS to use memory that has been reserved for a device and
>>> therefore requires the device driver to reclaim the memory prior to its
>>> use. However, an OS may have multiple ways of implementing such reuse
>>> and reclamation.
>>
>> ... and I repeat the question - why OS way of implementing reuse and
>> reclamation is relevant to DT?
>>
>>> I am considering introducing the vendor specific 'linux,dmb' property
>>> that is dependent on the 'reusable' property to allow both the OS and
>>> the device driver to identify the method used by the Linux OS to support
>>> reuse and reclamation of the reserved-memory child node.
>>
>> Sure, but why? Why OS and Linux driver specific pieces should be in DT?
>>> Such a property would remove any need for new compatible strings to the
>>> device tree. Does that approach seem reasonable to you?
>>
>> No, because you did not explain original question. At all.
> I apologize if I have somehow offended you, but please recognize that my 
> apparent inability to answer your question does not come from an 
> unwillingness to do so.
> 
> I believe an example of the reserved-memory node being used the way you 
> indicate (though there are other uses) can be expressed with device tree 
> nodes like these:
> 
> reserved-memory {
> 	#address-cells = <0x1>;
> 	#size-cells = <0x1>;
> 	ranges;
> 
> 	multimedia_reserved: multimedia@80000000 {
> 		reg = <0x80000000 0x10000000>;
> 	};
> };
> 
> decoder@8012000 {
> 	memory-region = <&multimedia_reserved>;
> 	/* ... */
> };
> 
> Here a 256MB chunk of memory is reserved for use by a hardware decoder 
> as part of rendering a video stream. In this case the memory is reserved 
> for the exclusive use of the decoder device and its associated device 
> driver.
> 
> The Devicetree Specification includes a property named 'reusable' that 
> could be applied to the multimedia node to allow the OS to "use the 
> memory in this region with the limitation that the device driver(s) 
> owning the region need to be able to reclaim it back". 

Indeed, there is such.... and should be used instead. :)

> This is a good 
> idea, because this memory could probably be put to good use when the 
> decoder is not active. Unfortunately, the methods for reusing this 
> memory are not defined for Linux so the multimedia reserved memory would 
> not be reused even though the devicetree indicates that it is allowed.

Then rather implementation has to be changed, not Devicetree bindings.

> 
> The notion behind this commit was to introduce the 
> 'designated-movable-block' compatible string that could be added to the 
> multimedia node to allow the Client Program (i.e. Linux) to select a 
> device driver that knows how to reclaim reserved memory back from the OS 
> when it is needed by the decoder device and release it back to the OS 
> when the decoder no longer needs it. In this way, the purpose of the 
> multimedia node remains the same (i.e. to reserve memory for use by a 
> device), but a new compatible string is defined to allow for selection 
> of an appropriate device driver and allow successful reuse of the memory 
> for the benefit of the system.

We don't need a new compatible for it but use that existing property.

> 
>  From Rob's feedback it is clear that 'designated-movable-block' is not 
> an appropriate name, but maybe 'linux,dmb' might have been. However, it 
> would be more flexible if a 'linux,dmb' property could be introduced as 
> a modifier to the existing 'reusable' property to provide a general 
> mechanism for clarifying how 'reusable' should be supported by the 
> Client Software and its device drivers.
> 
> Such a property is not directly relevant to hardware, but the devicetree 
> is not wholly concerned with hardware. Reserved memory node children 
> include support for 'linux,cma-default' and 'linux,dma-default' 
> properties that signal behavioral intent to the Linux OS. Some aspects 
> of the devicetree (e.g. the /chosen node and 'reusable' property) are 
> for the benefit of the Client Program.

Fair enough, although there is difference between generic property for
reusable/reclaimable memory and a property describing one of Linux
memory-management zones.

Best regards,
Krzysztof
