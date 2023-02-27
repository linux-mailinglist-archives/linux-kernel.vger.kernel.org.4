Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8576A4749
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 17:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjB0QvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 11:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjB0Qu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 11:50:58 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331E21F4BA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 08:50:54 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4PQR9g2ZHVz9v7Vm
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:42:15 +0800 (CST)
Received: from [10.45.159.185] (unknown [10.45.159.185])
        by APP2 (Coremail) with SMTP id GxC2BwAn81lL3_xjpkxXAQ--.3917S2;
        Mon, 27 Feb 2023 17:50:30 +0100 (CET)
Message-ID: <b07b75cd-0627-da3c-54e8-cc22088c148e@huaweicloud.com>
Date:   Mon, 27 Feb 2023 17:50:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v3] tools/memory-model: Make ppo a subrelation of po
To:     Alan Stern <stern@rowland.harvard.edu>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org
References: <20230224135251.24989-1-jonas.oberhauser@huaweicloud.com>
 <Y/jYm0AZfPHkIalK@rowland.harvard.edu>
 <20230224183758.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230226010110.GA1576556@paulmck-ThinkPad-P17-Gen-1>
 <Y/rEH2r9i0BtfxEW@rowland.harvard.edu> <Y/rNUfW509AQYCYn@boqun-archlinux>
 <Y/rSQ2FNTJyj2bqR@rowland.harvard.edu>
 <a862ee59-ca12-b609-48cc-0784c7ce24af@huaweicloud.com>
 <Y/uOA3umovz06/SV@rowland.harvard.edu>
 <dd87369d-825f-e932-dd86-8e46e92d1a7e@huaweicloud.com>
 <Y/zXYXM1lgk7Msig@rowland.harvard.edu>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Y/zXYXM1lgk7Msig@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwAn81lL3_xjpkxXAQ--.3917S2
X-Coremail-Antispam: 1UD129KBjvJXoWxurW5tFWrCFy7Wr4xKF1fCrg_yoW7GryrpF
        W3Ka12kr1Dtrs7uwnrXw10qay8Zw1Syas8tFZYq3srA3y5GF1ftryIqa4F9a9xWrs2gw1j
        qrWjyFy7Grn8ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
        WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU13rcDUUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/27/2023 5:16 PM, Alan Stern wrote:
> On Mon, Feb 27, 2023 at 03:03:16PM +0100, Jonas Oberhauser wrote:
>
>>>> Note there's also rw-xbstar (used with fr) which doesn't check for
>>>> r-pre-bounded, but it should be ok. That's because only reads would be
>>>> unordered, as a result the read (in the if (x != ..) x=..) should provide
>>>> the correct value. The store would be issued as necessary, and the issued
>>>> store would still be ordered correctly w.r.t the read.
>>> That isn't the reason I left r-pre-bounded out from rw-xbstar.  If the
>>> write gets changed to a read there's no need for rw-xbstar to check
>>> r-pre-bounded, because then rw-race would be comparing a read with
>>> another read (instead of with a write) and so there would be no
>>> possibility of a race in any case.
>> That is the first part of my explanation (only reads would be unordered) but
> It is?  I couldn't tell from what you wrote that this was supposed to
> imply we didn't have to worry about a data race.

Because it wasn't supposed to imply that, in the sense that by itself, 
the fact that the things that are left unordered are reads does not 
immediately imply that we don't have to worry about a data race. It's 
just a step in the sequence of reasoning. But of course I won't claim 
that I laid out that sequence in full enough detail to make sense.

>
>> I don't think it's sufficient in general.
>> Imagine a hypothetical memory model with a release fence that upgrades the
>> next memory operation only (and only stores) to release (e.g., to save some
>> opcode design space you do weird_release_fence;str x1 x2 instead of stlr x1
>> x2).
>> Then in the message passing pattern
>>
>> T1 {
>>     u = a;
>>     release(&x, 1);
>> }
>>
>> T2 {
>>    t = READ_ONCE(&x);
>>    weird_release_fence;
>>    a = 1;
>> }
> [That isn't the Message Passing pattern.  In the MP pattern, one thread
> does two writes and the other thread does two reads.  This is the Read
> Buffering (RB) pattern: Each thread does a read followed by a write.]

Ah, thanks. Somehow I misremembered MP to be any case of [do stuff on a] 
; x = ...  || read that update from x; [do stuff on a].

>
>> where T2 is changed by the compiler to
>>
>> T2 {
>>    t = READ_ONCE(&x);
>>    weird_release_fence();
>>    if (a!=1) a = 1;
>> }
>>
>> In the specific executions where t==1, there wouldn't be a data race when
>> just considering the equivalent of rw-xbstar, but u==1 and t==1 would be
>> possible (even though it might not seem so from the first example).
> If such a fence existed in the LKMM, we would handle this case by saying
> that weird_release_fence() does not give release semantics to an
> immediately following plain store; only to an immediately following
> marked store.  The reason being that the compiler is allowed to muck
> around with the code generated for plain accesses, so there's no
> guarantee that the first machine instruction generated for "a = 1;" will
> be a store.
>
> As a result, there would not be an rw-xbstar link from T1 to T2.

Sure, but IMHO a well-designed high-level model like LKMM shouldn't have 
such a fence at all :D This is something you might use in the 
implementation of a release store in inline-assembly, it doesn't belong 
in the source code. But it's just for the sake of argument anyways.


>
>> Of course in LKMM there's no such fence, but I think to make the argument
>> complete you still need to go through every case that provides the
>> w-pre-bounding and make sure it still provides the necessary order in the
>> compiler-generated version. (or you can try a more complicated argument of
>> the form "there would be another execution of the same program that would
>> have a data race", which works at least for this example, not sure in
>> general)
> So I don't see this as a valid argument for not using rw-xbstar in
> rw-race.  Even theoretically.

There's nothing wrong with using rw-xbstar in rw-race, especially in 
current LKMM, and I'm not arguing against that.

I'm saying that the argument
"if rw-xbstar links a read R to a plain write W, and that plain write is 
replaced by a read R', and in case R' reads a value different from W, 
followed by a store W' (with some dependency from R' to W')  by the 
compiler, then the fact that R and R' can't have a data race means that 
it's safe to use rw-xbstar in rw-race"
is incomplete. (Of course that doesn't mean the claim is wrong.)
To make the argument complete, you also need that W' is generated if 
necessary, and more crucially that W' is still ordered behind R!
Otherwise you would now have a data race between R and W', like in the 
hypothetical example I mentioned, even though R and R' don't race.

And if you do that second step in LKMM (even with the change of 
w-pre-bounded we are discussing) you quickly find that W' is indeed 
still ordered, so rw-xbstar is perfectly fine.

Perhaps that step is so trivial to you that you don't feel it needs 
mentioning : ) But speaking about LKMM-like models in general, some 
might have some subtle case where rw-xbstar links R and W but would not 
R and W'.

jonas

