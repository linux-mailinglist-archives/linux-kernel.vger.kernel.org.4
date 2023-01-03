Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991E265C44A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 17:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbjACQyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 11:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbjACQyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 11:54:18 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8405208
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 08:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=F++bieaa8WBsyQQMnaGWrNLjsJ7SpG6QXkvjDF94ua0=; b=jNSHirJ09wG1JCmNde1dya7n69
        i1Nxuz+kDIDPc+m4LFzAVPyPtNrgvqjcms0oLrPxbBjrHRf8w4ShYj9jACwIDImael7NdiaZb62k6
        1KDLxRW8n8PZ6HbhBidyRM0Oy7BtmtMVtjAMFUtDfnyfehtb6zvBblUZ1mgT0Wsv9zHHDdo9deI7Z
        wtz8mwQfxzKwUP1ccMrkGPpVauBgH1EYySGuv26h1KH/ChvD7EDSjWOAsCS9dNxMA7S+t2jSZpkTi
        8y0OlRlEhWq8S0i3hPTTrOmxufFj65asKC6+b7onfg4QL3tR+eiwyDgljczyhnzVr27aQoiMaKa37
        5GvrXlQg==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pCkYJ-0038Ei-UA; Tue, 03 Jan 2023 16:54:16 +0000
Message-ID: <0ccd76c3-d516-16e8-8343-6c4881d377f3@infradead.org>
Date:   Tue, 3 Jan 2023 08:54:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] time: fix various kernel-doc problems
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>
References: <20230103032849.12723-1-rdunlap@infradead.org>
 <Y7P+KuMs52BTfKgv@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Y7P+KuMs52BTfKgv@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On 1/3/23 02:06, Ingo Molnar wrote:
> 
> * Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> kernel/time/tick-oneshot.c:107: warning: expecting prototype for tick_check_oneshot_mode(). Prototype was for tick_oneshot_mode_active() instead
> 
>> --- a/kernel/time/tick-oneshot.c
>> +++ b/kernel/time/tick-oneshot.c
> 
>> @@ -103,7 +103,7 @@ int tick_switch_to_oneshot(void (*handle
>>   *
>>   * returns 1 when either nohz or highres are enabled. otherwise 0.
>>   */
>> -int tick_oneshot_mode_active(void)
>> +int tick_check_oneshot_mode(void)
>>  {
>>  	unsigned long flags;
>>  	int ret;
> 
> This one looks wrong - did you change the name on the wrong line?

Yes, sorry about that.

> I've applied your patch, but fixed the above hunk to be:
> 
> @@ -99,7 +99,7 @@ int tick_switch_to_oneshot(void (*handle
>  }
>  
>  /**
> - * tick_check_oneshot_mode - check whether the system is in oneshot mode
> + * tick_oneshot_mode_active - check whether the system is in oneshot mode
>   *
>   * returns 1 when either nohz or highres are enabled. otherwise 0.
>   */
> 
> Thanks,

Thank you also.

-- 
~Randy
