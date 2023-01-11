Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B96665D6B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238417AbjAKOOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238439AbjAKOOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:14:12 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4358055B4;
        Wed, 11 Jan 2023 06:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1673446444;
        bh=clte4+NfGueQmKGUoje7qohWAGjcauzVkyPoQNr/Wb4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VzJHaMbm8J8q5+p4GrHhPg4VWZh0YMwJ3Pl2Hmj0P+syEm8I3hJQ40d6ut079qM+s
         YAuTieB02Mc9KTvbgrTxBDcOMRulCYa8x8ZTwf5QA/p5aF69goNLZI7QreWw7cPRND
         SjxtckDJ6ts1IGYB6WFcYiNi8KQvQvY9EJ7m7G/6eBFEhrxGPZiBDO2aeyr9lgwwpj
         B/e5xaahzlEn8CQiRfG0LP0djkGy+VDav6RvR/tk064GqoeL2XNZWZ7hOrqaPC+sN/
         lp2EP6FCD/tR7X8aQvSkcpDfgQvfU7IDyJaoMLPkJFAmAK0GxKwhsSFuLRaF3V9nD+
         7W4UrbXcmVkjA==
Received: from [172.16.0.101] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NsV6M6DB2zgFZ;
        Wed, 11 Jan 2023 09:14:03 -0500 (EST)
Message-ID: <265a3900-45df-1b9a-b8de-85ef6d25141d@efficios.com>
Date:   Wed, 11 Jan 2023 09:14:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH tip] selftests/rseq: Revert "selftests/rseq: Add
 mm_numa_cid to test script"
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>,
        kernel test robot <oliver.sang@intel.com>
References: <20230104163542.10004-1-mathieu.desnoyers@efficios.com>
 <Y77D0+e2tdl8c1k1@hirez.programming.kicks-ass.net>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <Y77D0+e2tdl8c1k1@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-11 09:12, Peter Zijlstra wrote:
> On Wed, Jan 04, 2023 at 11:35:42AM -0500, Mathieu Desnoyers wrote:
>> The mm_numa_cid related rseq patches from the series were not picked up
>> into the tip tree, so enabling the mm_numa_cid test needs to be
>> reverted.
>>
>> This reverts commit b344b8f2d88dbf095caf97ac57fd3645843fa70f.
> 
> Oh my bad, I got confused between the regular numa_id (which I did do
> merge, right?) and the fancy numa_cid, which I indeed didn't merge yet.

Yes, that's indeed what happened.

> I meant to give that a wee bit more thought, but that sadly hasn't
> happened yet :/
> 
> Applied, thanks!

No worries, let me know when you have time to discuss the fancy numa_cid 
some more.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

