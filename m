Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F8D67BCB1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236478AbjAYUgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjAYUgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:36:32 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058145528E
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:36:22 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4P2Fln3lX1z9xtmt
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 04:28:21 +0800 (CST)
Received: from [10.81.213.36] (unknown [10.81.213.36])
        by APP2 (Coremail) with SMTP id GxC2BwDnuF+jktFjVXHGAA--.15159S2;
        Wed, 25 Jan 2023 21:35:59 +0100 (CET)
Message-ID: <16ca40c7-ba9d-6741-e7fc-fd553c80a757@huaweicloud.com>
Date:   Wed, 25 Jan 2023 21:35:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [Patch 1/2] tools/memory-model: Update some warning labels
To:     Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, will <will@kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>, npiggin <npiggin@gmail.com>,
        dhowells <dhowells@redhat.com>,
        "j.alglave" <j.alglave@ucl.ac.uk>,
        "luc.maranget" <luc.maranget@inria.fr>, akiyks <akiyks@gmail.com>,
        dlustig <dlustig@nvidia.com>, joel <joel@joelfernandes.org>,
        urezki <urezki@gmail.com>,
        quic_neeraju <quic_neeraju@quicinc.com>,
        frederic <frederic@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
References: <Y9GO3xEYkIQq/qSl@rowland.harvard.edu>
 <Y9GPI/g23YWx+0Ce@rowland.harvard.edu>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Y9GPI/g23YWx+0Ce@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwDnuF+jktFjVXHGAA--.15159S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr4DCry5ur1fAw15GFyxuFg_yoW8Kw1xpr
        WvqFWftw47tr92ga1xuw13GF18J34UXFWjyrn3G3Z7Xry8Zrn0kr1fG3W5Kr1Ykw1IkFWU
        Zw1Yqan7Cw48taDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UZ18PUUUUU=
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/25/2023 9:20 PM, Alan Stern wrote:
> Some of the warning labels used in the LKMM are unfortunately
> ambiguous.  In particular, the same warning is used for both an
> unmatched rcu_read_lock() call and for an unmatched rcu_read_unlock()
> call.  Likewise for the srcu_* equivalents.  Also, the warning about
> passing a wrong value to srcu_read_unlock() -- i.e., a value different
> from the one returned by the matching srcu_read_lock() -- talks about
> bad nesting rather than non-matching values.
>
> Let's update the warning labels to make their meanings more clear.
>
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

Reviewed-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>

>
> ---
>
>   tools/memory-model/linux-kernel.bell |   10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> Index: usb-devel/tools/memory-model/linux-kernel.bell
> ===================================================================
> --- usb-devel.orig/tools/memory-model/linux-kernel.bell
> +++ usb-devel/tools/memory-model/linux-kernel.bell
> @@ -53,8 +53,8 @@ let rcu-rscs = let rec
>   	in matched
>   
>   (* Validate nesting *)
> -flag ~empty Rcu-lock \ domain(rcu-rscs) as unbalanced-rcu-locking
> -flag ~empty Rcu-unlock \ range(rcu-rscs) as unbalanced-rcu-locking
> +flag ~empty Rcu-lock \ domain(rcu-rscs) as unmatched-rcu-lock
> +flag ~empty Rcu-unlock \ range(rcu-rscs) as unmatched-rcu-unlock
>   
>   (* Compute matching pairs of nested Srcu-lock and Srcu-unlock *)
>   let srcu-rscs = let rec
> @@ -69,14 +69,14 @@ let srcu-rscs = let rec
>   	in matched
>   
>   (* Validate nesting *)
> -flag ~empty Srcu-lock \ domain(srcu-rscs) as unbalanced-srcu-locking
> -flag ~empty Srcu-unlock \ range(srcu-rscs) as unbalanced-srcu-locking
> +flag ~empty Srcu-lock \ domain(srcu-rscs) as unmatched-srcu-lock
> +flag ~empty Srcu-unlock \ range(srcu-rscs) as unmatched-srcu-unlock
>   
>   (* Check for use of synchronize_srcu() inside an RCU critical section *)
>   flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep
>   
>   (* Validate SRCU dynamic match *)
> -flag ~empty different-values(srcu-rscs) as srcu-bad-nesting
> +flag ~empty different-values(srcu-rscs) as srcu-bad-value-match
>   
>   (* Compute marked and plain memory accesses *)
>   let Marked = (~M) | IW | Once | Release | Acquire | domain(rmw) | range(rmw) |

