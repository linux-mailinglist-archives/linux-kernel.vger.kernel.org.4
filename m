Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C76D6A4C39
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 21:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjB0UZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 15:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjB0UZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 15:25:22 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2521E9FF
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 12:25:20 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4PQWx425FWz9xrt5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 04:16:40 +0800 (CST)
Received: from [10.45.159.185] (unknown [10.45.159.185])
        by APP1 (Coremail) with SMTP id LxC2BwBHzwqMEf1jVi9aAQ--.22302S2;
        Mon, 27 Feb 2023 21:24:55 +0100 (CET)
Message-ID: <a02d8d53-713d-4aba-31a4-6d54185f3701@huaweicloud.com>
Date:   Mon, 27 Feb 2023 21:24:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v3] tools/memory-model: Make ppo a subrelation of po
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     paulmck@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, urezki@gmail.com, quic_neeraju@quicinc.com,
        frederic@kernel.org, linux-kernel@vger.kernel.org
References: <20230224135251.24989-1-jonas.oberhauser@huaweicloud.com>
 <Y/uHjpbJ3JmVAe9d@google.com>
 <a5f1695d-cc1f-04aa-fe61-f2b8687cfb0e@huaweicloud.com>
 <CAEXW_YQMXKDx0gr1S5HkraVA+ori-AnQL-yGU6r=u6B5_XciUA@mail.gmail.com>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <CAEXW_YQMXKDx0gr1S5HkraVA+ori-AnQL-yGU6r=u6B5_XciUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBHzwqMEf1jVi9aAQ--.22302S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCFyUAr1kKFyrXrW8AFWfuFg_yoW5Cr1rpF
        W3Ga9rKFn5JF1Iy3s2vr1DX3WFyw4ftrW5JFy3Grn8Zw15WFySgF4xKw4Y9F9rCrs5u34Y
        vrWj9FyUAa4DZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUo0eHDUUUU
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/27/2023 6:57 PM, Joel Fernandes wrote:
> On Mon, Feb 27, 2023 at 9:39 AM Jonas Oberhauser
> <jonas.oberhauser@huaweicloud.com> wrote:
>>
>>
>> On 2/26/2023 5:23 PM, Joel Fernandes wrote:
>>> On Fri, Feb 24, 2023 at 02:52:51PM +0100, Jonas Oberhauser wrote:
>>>> [...]
>>> Alternatively can be the following appended diff? Requires only single 'int'
>>> in ->ppo then and prevents future similar issues caused by sub relations.
>>> Also makes clear that ->ppo can only be CPU-internal.
>> I had thought about going in that direction, but it doesn't prevent
>> future similar issues, at best makes them less likely.
> Making less likely still sounds like a win to me.
>
>> For example, you could have an xfence that somehow goes back to the
>> original thread, but to a po-earlier event (e.g., like prop).
>>
>> Given that to-r and to-w are unlikely to ever become become inconsistent
>> with po, I am not sure it even really helps much.
> I am not sure I understand, what is the problem with enforcing that
> ppo is only supposed to ever be -int ? Sounds like it makes it super
> clear.

You could go further and do ... & po.

But it would still make me feel that it's a plaster used to hold 
together a steampipe.
It reminds me a bit of college when some of my class mates passed the 
nightly tests in the programming lab by doing
"if input == (the input of the specific test case they were having 
problem with) return (value expected by testcase)".
Or making everything atomic so that tsan does not complain about data 
races anymore.

If there's something in one of these relations tying together events of 
different threads, is it intentional or a bug?
I prefer to be very conscious about what is being tied together by the 
relations.

I'd rather take Boqun's suggestion to add some "debug/testing" flags to 
see if a litmus test violates a property assumed by LKMM.

Yet I think the ideal way is to have a mechanized proof that LKMM 
satisfies these properties and use that to avoid regressions.


>
>> Personally I'm not too happy with the ad-hoc '& int' because it's like
> So, with the idea I suggest, you will have fewer ints so you should be happy ;-)

haha : ) An alternative perspective is that the &int now covers more 
cases of the relation ; )


>
>> adding some unused stuff (via ... | unused-stuff) and then cutting it
>> back out with &int, unlike prop & int which has a real semantic meaning
>> (propagate back to the thread). The fastest move is the move we avoid
>> doing, so I rather wouldn't add those parts in the first place.
>>
>> However fixing the fence relation turned out to be a lot trickier, both
>> because of the missed data race and also rmw-sequences, essentially I
>> would have had to disambiguate between xfences and fences already in
>> this patch. So I did this minimal local fix for now and we can discuss
>> whether it makes sense to get rid of the '& int' once/if we have xfence etc.
> I see. Ok, I'll defer to your expertise on this since you know more
> than I. I am relatively only recent with even opening up the CAT code.

Enjoy : )

jonas

