Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D145FF4D4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 22:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiJNUt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 16:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbiJNUtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 16:49:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE4D1ABEC1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 13:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=51LuxWywcqsHFYCJPldZr7GsR3k4AmbORlkhXWVFQBQ=; b=KTctOt+g9tMP+xNn0y1Lm2KUBz
        VCbRlCop6s1l1+qnj5tNESIbREgmY416S/PDJVhcdn2FPa9+QkIIGbMg0jwvzWRsWxXNZxUQCpZeI
        QoUyvItt0jbmgb0PwoBWBx4lbpzpghbI2MFQscBOyG0ylNo+I5AFeZl1Ia56IJp+yw0aWVm3B3n2d
        u7jkvrLRyBTchpXO+LafkwG75AXMu2Eq0anbTPiCEbVVCIoANGdgE8gIMWPSOsIxi4pBvA2MpA0wZ
        QKpAt4dSv2fxKG2TlHR2TkSebz1Us2+8uh+iRtJyxcfjGkF1jvKrLr9kzVSmGlZuMc2aw/nVOflX0
        /T9rb3EA==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ojRcN-00Ftfi-19; Fri, 14 Oct 2022 20:49:19 +0000
Message-ID: <2d26cc60-3580-dcb6-4f2f-e5f1ad2a42dd@infradead.org>
Date:   Fri, 14 Oct 2022 13:49:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH -next] clocksource/drivers/timer-ti-dm: Fix some
 kernel-doc comments
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Yang Li <yang.lee@linux.alibaba.com>
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20221014091357.64504-1-yang.lee@linux.alibaba.com>
 <Y0lfpxXZZZuiI4A8@debian.me>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Y0lfpxXZZZuiI4A8@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/14/22 06:09, Bagas Sanjaya wrote:
> On Fri, Oct 14, 2022 at 05:13:57PM +0800, Yang Li wrote:
>> Fix some kernel-doc comments.
>>
>> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2399
> 
> What fix are you doing below? Please describe (should contain warning
> messages from bugzilla link above).

Yeah, we don't need that link, just the warning messages themselves.

> ---- ranting ----
> When I see social media posts, I often see "Link in bio" phrase. That
> is, instead of posting the full link, the link is placed on URL section
> of a poster's bio and a pointer to it is phrased in relevant posts. What
> if such "link in bio" link changes? The older posts which points to
> different link than in the bio become irrelevant.
> 
> I would rather just spell the full link in my posts instead for
> posterity.
> ---- end ranting ----
> 
>> diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
>> index cad29ded3a48..574c88584fbf 100644
>> --- a/drivers/clocksource/timer-ti-dm.c
>> +++ b/drivers/clocksource/timer-ti-dm.c
>> @@ -181,8 +181,7 @@ static inline u32 dmtimer_read(struct dmtimer *timer, u32 reg)
>>  /**
>>   * dmtimer_write - write timer registers in posted and non-posted mode
>>   * @timer:      timer pointer over which write operation is to perform
>> - * @reg:        lowest byte holds the register offset
>> - * @value:      data to write into the register
>> + * @val:      data to write into the register
>>   *
>>   * The posted mode bit is encoded in reg. Note that in posted mode, the write
>>   * pending bit must be checked. Otherwise a write on a register which has a
>> @@ -925,7 +924,7 @@ static int omap_dm_timer_set_int_enable(struct omap_dm_timer *cookie,
>>  
>>  /**
>>   * omap_dm_timer_set_int_disable - disable timer interrupts
>> - * @timer:	pointer to timer handle
>> + * @cookie:	pointer to omap dm timer handle
>>   * @mask:	bit mask of interrupts to be disabled
>>   *
>>   * Disables the specified timer interrupts for a timer.
> 
> Seems like two different fixes, right? These should be splitted into its
> own patch.

That's up to the maintainer IMO.
If I were making this patch, it would be as above, just one patch.


-- 
~Randy
