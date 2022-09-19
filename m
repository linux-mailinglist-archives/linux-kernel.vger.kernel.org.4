Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F965BCA30
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 13:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiISLEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 07:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiISLDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:03:52 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A01DB6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:03:50 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id p5so33371137ljc.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=TcbEHO2M1Vn7869vpthKt1PADnZwIS+iJq0ZGvm2ISU=;
        b=eCgAMNR0/oNYqUNLjWGvDumqw2QiynIm6mZWzzKGu8A6nUQFWlfAojCCn04+7s1PNP
         kFrK/0r9SLLWN+D5XksTCe3ZX1uhmpZuNKZa7bwM2kNFWt5qS5PiZGcTlY1XhJreiw5P
         SJJLfgaolJXDlxo2Fz2pOMASibdZJRfJG/8pI0uiUlmdXAboZigmyqe236MZC/Blduvn
         v8j4HXPXFi2tea2082grXHIvE8p2hzHgYBEffBpWASuaD9gIuEORS8QeKe25TzYYL9A1
         ut5w945Z/HWY+KpJdbSFHFK7cFwvpTKadENcsO68367MD0bQYhrS1FADSoVFVXiwv5Wa
         FNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=TcbEHO2M1Vn7869vpthKt1PADnZwIS+iJq0ZGvm2ISU=;
        b=glQpzay34zQIL0KemZJXiPI86iTLrj36YU6LTZOYH/g8EmgJpjp+U0rifHmFohVrYI
         WJp0Nzc0nkByp4wloCt63o+uPFihXpmxPkw8n8yRAtk+x7TPShcwyidFOWPf67mbmxa5
         P/KI0oc028KDuZOj0n+Te+3VvKX4BF2Ldz6kW2VFpkNXhkmyyl+c8wqLmUHBXmEm0vVe
         KQxncnqVPNpQITuIwU+9qr5/Vf8ygaoBzjl1rSY1KvjIvqv20YC7VHBj+Gg3YfCwfDgp
         9k5GKGM/3XMyGAYXIC/1H5nJ3J545lRXW+4crhQ4d4sTMwvUV9kn7fXPdTCr1TV8GS8W
         JczA==
X-Gm-Message-State: ACrzQf11TbYFjW4LZvq9byPYwhaD+mveoXWou2k1BbhYuqBsI4ILX+SR
        Ph6Zmul7xR/1vo9jzSvMmbai9g==
X-Google-Smtp-Source: AMsMyM6ehRBDTKsqy6n6LtYJaToBW7Kz4lBTJZvNjeGA2Sv6mgDRd/UJeVtCu0piJ8hcO0aLPDOfew==
X-Received: by 2002:a2e:9608:0:b0:26a:a73b:b8c1 with SMTP id v8-20020a2e9608000000b0026aa73bb8c1mr5203413ljh.328.1663585428366;
        Mon, 19 Sep 2022 04:03:48 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id s2-20020a056512314200b0048b08e25979sm5132313lfi.199.2022.09.19.04.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 04:03:47 -0700 (PDT)
Message-ID: <e0e043aa-0f79-59a8-05ab-e48046860524@linaro.org>
Date:   Mon, 19 Sep 2022 13:03:46 +0200
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b4b2b4c6-52b6-80f0-5db3-7f7b751989c3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2022 01:12, Doug Berger wrote:
> On 9/18/2022 3:31 AM, Krzysztof Kozlowski wrote:
>> On 14/09/2022 18:13, Doug Berger wrote:
>>> On 9/14/2022 7:55 AM, Rob Herring wrote:
>>>> On Tue, Sep 13, 2022 at 12:55:03PM -0700, Doug Berger wrote:
>>>>> Introduce designated-movable-block.yaml to document the
>>>>> devicetree binding for Designated Movable Block children of the
>>>>> reserved-memory node.
>>>>
>>>> What is a Designated Movable Block? This patch needs to stand on its
>>>> own.
>>> As noted in my reply to your [PATCH 00/21] comment, my intention in
>>> submitting the entire patch set (and specifically PATCH 00/21]) was to
>>> communicate this context. Now that I believe I understand that only this
>>> patch should have been submitted to the devicetree-spec mailing list, I
>>> will strive harder to make it more self contained.
>>
>> The submission of entire thread was ok. What is missing is the
>> explanation in this commit. This commit must be self-explanatory (e.g.
>> in explaining "Why are you doing it?"), not rely on other commits for
>> such explanation.
>>
>>>
>>>>
>>>> Why does this belong or need to be in DT?
>>> While my preferred method of declaring Designated Movable Blocks is
>>> through the movablecore kernel parameter, I can conceive that others may
>>> wish to take advantage of the reserved-memory DT nodes. In particular,
>>> it has the advantage that a device can claim ownership of the
>>> reserved-memory via device tree, which is something that has yet to be
>>> implemented for DMBs defined with movablecore.
>>
>> Rephrasing the question: why OS memory layout and OS behavior is a
>> property of hardware (DTS)?
> I would say the premise is fundamentally the same as the existing 
> reserved-memory child node.

I don't think it is fundamentally the same.

The existing reserved-memory node describes memory used by hardware - by
other devices. The OS way of handling this memory - movable, reclaimable
etc - is not part of it.

So no, it is not the same.

> 
> I've been rethinking how this should be specified. I am now thinking 
> that it may be better to introduce a new Reserved Memory property that 
> serves as a modifier to the 'reusable' property. The 'reusable' property 
> allows the OS to use memory that has been reserved for a device and 
> therefore requires the device driver to reclaim the memory prior to its 
> use. However, an OS may have multiple ways of implementing such reuse 
> and reclamation.

... and I repeat the question - why OS way of implementing reuse and
reclamation is relevant to DT?

> I am considering introducing the vendor specific 'linux,dmb' property 
> that is dependent on the 'reusable' property to allow both the OS and 
> the device driver to identify the method used by the Linux OS to support 
> reuse and reclamation of the reserved-memory child node.

Sure, but why? Why OS and Linux driver specific pieces should be in DT?
> Such a property would remove any need for new compatible strings to the 
> device tree. Does that approach seem reasonable to you?

No, because you did not explain original question. At all.

Best regards,
Krzysztof
