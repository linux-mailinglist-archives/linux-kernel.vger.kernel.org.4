Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35ED35B8DA6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiINQ5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiINQ5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:57:46 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5601382857;
        Wed, 14 Sep 2022 09:57:41 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id 3so10955304qka.5;
        Wed, 14 Sep 2022 09:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=UWYZ+LvZVhpAV6ZQBWEOlqo/TbgQPhE93gUN5h4Opa4=;
        b=lBXUbs9pZpO+yTmR2jdfhmRm/kBSeGhEo/6IKheeNxrOaZ+SSStX4UyGbG7noCTZnL
         lp4GNVPC+yuVX066hyg9SZyWVQUc+v0zWdguOY/nmscUyeDVvKy5jSWZaO+xzphOdvAQ
         aTsC9QANMQ3cKIIiE6++nnjm/oB7778JyBSse4UwGosbGCTpuV7jvDE16vVWkNMCWqqr
         paslr3euDOvfLPglAFtll6BbrIEH7G9dDqqDsbt8U2peyjwbTzpRL2hP2NTerae1SkXT
         SVn4fudGRJTBSCtwGh1X5bX9nACK+SBbNtTAxaGYxsK9dZyA1/5h4e4DVMpUTdy67eBY
         DA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=UWYZ+LvZVhpAV6ZQBWEOlqo/TbgQPhE93gUN5h4Opa4=;
        b=ED0KJ70yDH2uE4v88gHzjwp93i683HF1PaeLHL0K9wCAG4N0cztBXdZ/ZBphWtabVs
         iYa8u7TRkjLW9L3Ym1NRfCbnQ1e77P8Q2A2WmnIxv2qGz+sriKBAYVCwbFUe74q4tP2e
         mktxEaidJ0fe9TZYizmwMxMbTT54TljmuV45JRw2g52OvnOsiZjoRxBBrmlhEqs7/ly6
         6AG8Rs8IHuf++LDyY0RM1azCH+4201e3637swql72jP5oPbL1uEhjGc8+1ixFGx097kf
         udR972sG1MTnYohgfgbq6IhH/HLQNjRuK3sqVomudmcMYf+BMD6St33bfBzFos0xxqD6
         u83g==
X-Gm-Message-State: ACgBeo1C+IY6rlZoqF9Mq6IHlQ3ZlnEaR/Wd5/RhX+62fAR6qt8ZYtGu
        xHOIlYFUuVs0jYp4Pd91f2w=
X-Google-Smtp-Source: AA6agR6Wu36k8hHB+/9VV1slDHLKSuMtkQx48tsI3xnwZirYVolN/T5Srax7wN9UvBnxLS0DXw6nUw==
X-Received: by 2002:a05:620a:13ae:b0:6ce:5926:1511 with SMTP id m14-20020a05620a13ae00b006ce59261511mr9345627qki.431.1663174660232;
        Wed, 14 Sep 2022 09:57:40 -0700 (PDT)
Received: from [10.69.40.226] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id b3-20020a05620a118300b006b8f4ade2c9sm2051740qkk.19.2022.09.14.09.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 09:57:38 -0700 (PDT)
Message-ID: <1825234b-f17a-dea4-38f6-ba5881ab9a3d@gmail.com>
Date:   Wed, 14 Sep 2022 09:57:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 00/21] mm: introduce Designated Movable Blocks
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>
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
        Mel Gorman <mgorman@suse.de>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        iommu@lists.linux.dev
References: <20220913195508.3511038-1-opendmb@gmail.com>
 <CAL_JsqLmJcLHViPaBPvkBhR4xi+ZQuAJQpXoiJLVRW9EH4EX0Q@mail.gmail.com>
From:   Doug Berger <opendmb@gmail.com>
In-Reply-To: <CAL_JsqLmJcLHViPaBPvkBhR4xi+ZQuAJQpXoiJLVRW9EH4EX0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/2022 6:21 AM, Rob Herring wrote:
> On Tue, Sep 13, 2022 at 2:57 PM Doug Berger <opendmb@gmail.com> wrote:
>>
>> MOTIVATION:
>> Some Broadcom devices (e.g. 7445, 7278) contain multiple memory
>> controllers with each mapped in a different address range within
>> a Uniform Memory Architecture. Some users of these systems have
>> expressed the desire to locate ZONE_MOVABLE memory on each
>> memory controller to allow user space intensive processing to
>> make better use of the additional memory bandwidth.
>> Unfortunately, the historical monotonic layout of zones would
>> mean that if the lowest addressed memory controller contains
>> ZONE_MOVABLE memory then all of the memory available from
>> memory controllers at higher addresses must also be in the
>> ZONE_MOVABLE zone. This would force all kernel memory accesses
>> onto the lowest addressed memory controller and significantly
>> reduce the amount of memory available for non-movable
>> allocations.
> 
> Why are you sending kernel patches to the Devicetree specification list?
> 
> Rob
My apologies if this is a problem. No offense was intended.

My process has been to run my patches through get_maintainers.pl to get 
the list of addresses to copy on submissions and my 
0016-dt-bindings-reserved-memory-introduce-designated-mov.patch 
solicited the
'- <devicetree-spec@vger.kernel.org>' address.

My preference when reviewing is to receive an entire patch set to 
understand the context of an individual commit, but I can certainly 
understand that others may have different preferences.

It was my understanding that the Devicetree specification list was part 
of the kernel (e.g. @vger.kernel.org) and would be willing to receive 
patches that might be of relevance to it.

I am inexperienced with yaml and devicetree processes in general so I 
have tried to lean on the examples of other reserved-memory node 
bindings for help.

There is much to learn and I am happy to modify my process to better 
accommodate your needs.

Regards,
     Doug
