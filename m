Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF1A671C9B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjARMwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjARMvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:51:51 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BB138670
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 04:14:10 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Nxkxg3X2kz9xGYB
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 20:06:15 +0800 (CST)
Received: from [10.48.132.179] (unknown [10.48.132.179])
        by APP2 (Coremail) with SMTP id GxC2BwDXqWBw4sdjE+umAA--.436S2;
        Wed, 18 Jan 2023 13:13:47 +0100 (CET)
Message-ID: <2aae2d62-5437-178d-8e8a-19e420ea5b60@huaweicloud.com>
Date:   Wed, 18 Jan 2023 13:13:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] tools/memory-model: Make ppo a subrelation of po
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     paulmck@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org, urezki@gmail.com, quic_neeraju@quicinc.com,
        frederic@kernel.org, linux-kernel@vger.kernel.org
References: <20230117193159.22816-1-jonas.oberhauser@huaweicloud.com>
 <Y8czI5O2CikVlIp8@boqun-archlinux>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Y8czI5O2CikVlIp8@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwDXqWBw4sdjE+umAA--.436S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFykGw1kAF18tw4UCrW3KFg_yoW8GFWxpr
        Z3Gan7KrWkK3WxCw17Zw4093WFvw4kJrW3GF98X34rZwn8XFnrJw13KayYka45ZrWfA3yj
        yw4j9Fn3Ga15CaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
        WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UZ18PUUUUU=
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/18/2023 12:45 AM, Boqun Feng wrote:
> On Tue, Jan 17, 2023 at 08:31:59PM +0100, Jonas Oberhauser wrote:
>> ---
>>   .../Documentation/explanation.txt             | 101 +++++++++++-------
>>   tools/memory-model/linux-kernel.cat           |  20 ++--
> I've reviewed the cat change part, and it looks good to me.

It's not the cat part that worries me! I'm worried that I made the 
explanation inconsistent somewhere, or that it's not very 
understandable. If you have time, please take a look at that as well.


> One more thing, do we want something in the cat file to describe our
> "internal axioms" as follow?
>
> 	(* Model internal invariants *)
> 	(* ppo is the subset of po *)
> 	flag ~empty (ppo \ po) as INTERNAL-ERROR-PPO
>
> Maybe it's helpful for people working on other tools to understand LKMM
> cat file?

I've thought that there should be a way to continuously test/prove 
properties of LKMM so that future changes to LKMM can't silently 
invalidate these properites (like what happened when this fence was 
added to LKMM).

I'm not sure yet what's the best way to do this. I suppose a simple 
first step could be to have an additional cat file lkmm-properties.cat 
that flags all violations of the properties in the litmus tests, but I'm 
not sure how much that really helps: I think many violations are not 
present in any of the existing litmus tests. And some properties are 
hard to state as a cat flag.


best wishes and thanks for reviewing,
jonas

