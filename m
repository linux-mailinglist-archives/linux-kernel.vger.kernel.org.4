Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498776E24D9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 15:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjDNN4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 09:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjDNN4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 09:56:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F18DF;
        Fri, 14 Apr 2023 06:56:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1E1F0219D6;
        Fri, 14 Apr 2023 13:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681480569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gGAv0INF7x/Cz+gDaxHsL2GJAEP0XFePnk5ZG5kCoXs=;
        b=XEQ/mJKe8hfBsWRxwQmt/g2vUyg6NE7VHp6xZ9hlmIdk0wbYl8O0g1tCjXkR945kXLRP71
        QJt6O1VwE7eqvwCxl2aC8ehAA5zdHT/qmQhz3xYVCc6uu9iXCjcwGxIBgjYtxbS/RM24e9
        g5/p9TUgsJV27L3q/PHsFVgMR9mamTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681480569;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gGAv0INF7x/Cz+gDaxHsL2GJAEP0XFePnk5ZG5kCoXs=;
        b=6x2fEKafeMW7bHZthyy8Nex5gamsJD66os/6JcK0NS6tusCh5oNb/2kISBqquF3K4O8yhD
        d8PMi1fNxgCQmXAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F0C5413498;
        Fri, 14 Apr 2023 13:56:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id f9buOXhbOWTEFgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 14 Apr 2023 13:56:08 +0000
Message-ID: <73b5657a-4c47-980a-e709-cd6a880c067c@suse.cz>
Date:   Fri, 14 Apr 2023 15:56:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [ANNOUNCE] v6.3-rc2-rt3
To:     John Ogness <john.ogness@linutronix.de>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20230314170502.OHw1_FK3@linutronix.de>
 <20230314171231.jwtham4a@linutronix.de>
 <9ee941ae-ae22-f14b-4e69-f81b29bbba4b@arm.com>
 <87ttxiefpd.fsf@jogness.linutronix.de>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <87ttxiefpd.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/23 15:49, John Ogness wrote:
> Hi Pierre,
> 
> On 2023-04-14, Pierre Gondois <pierre.gondois@arm.com> wrote:
>> =============================
>> [ BUG: Invalid wait context ]
>> 6.3.0-rc5-rt8-gacb52bd349a2 #417 Not tainted
>> -----------------------------
>> swapper/0/1 is trying to lock:
>> ffff00097eea1180 (cpu){....}-{3:3}, at: __printk_safe_enter (kernel/printk/printk_safe.c:28 (discriminator 3))
>> other info that might help us debug this:
>> context-{5:5}
>> 1 lock held by swapper/0/1:
>> #0: ffff80000ba77028 (rcu_tasks_rude.cbs_gbl_lock){....}-{2:2}, at: cblist_init_generic (kernel/rcu/tasks.h:233)
> 
> This is actually a mainline issue relating to legacy consoles. In
> mainline you see it as a warning when CONFIG_PROVE_RAW_LOCK_NESTING is
> enabled.
> 
> If you enable CONFIG_PREEMPT_RT you will not have the problem.
> 
> I will look at how the issue can be gracefully ignored in
> !CONFIG_PREEMPT_RT.

Is it perhaps a similar situation to this thread?

https://lore.kernel.org/all/20230412124735.GE628377@hirez.programming.kicks-ass.net/

> Thanks for reporting.
> 
> John Ogness

