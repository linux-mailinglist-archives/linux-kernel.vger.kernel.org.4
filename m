Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C226763D95A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 16:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiK3PXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 10:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiK3PXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 10:23:48 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E562E687
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:23:47 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id d14so5708231ilq.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 07:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MVSvVeCDGQ1o47gYLtN8R+awQ9lS7VAhyH71o2xLC54=;
        b=ctCk0Dd6GzAls1JzBIxBk3DiSB9qYtO/HUeatCrvfQP+Kd/x38VyYHbGjvMu21RNH2
         XPVqP5WnCYBDrtJRf6yQdJbQHyHzCF4Ilyg0ou4AXQ5x0ECKWT6hs7QGdFhwGfbL8S89
         VaN2X8kSnHxYl7xt0FZDyKaa6axIjIyEf3yudcU3GmWc1Qi/bO/hxPxUSPvwEYL25zgN
         fYSc2O894eFB+ql7gLFD9tLcPNV1OFNOAqFeiQdH7ZvkijH5E64ZuBq9KV7B7zNIsASP
         6lyHiU4g+neMI8hcv1LCpJeDlMuLgkhZZCTfWAsosdJTAC5CVztGGjtJtILnLXvg5uCj
         MKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MVSvVeCDGQ1o47gYLtN8R+awQ9lS7VAhyH71o2xLC54=;
        b=UzzlxlAGdhm1LFeKH7az63E7B2CSJRg+VfDzxClwCNM1h/xyaQtxhGCPmGo9uVg70W
         pRcOjosJ2enAYH9f/B8wxr5fon5Qjbqt75q65wwvZZDG7BOiQodyDWxRu/o0pi/rshE/
         RatWPSCmifhX+kc8bWbay0q+4sDIPIOzxf5+gp12K/S90C8ePkbv827poS61v9FlNVwd
         61b3+tIH0esWHl7mSapLGTaBUOnq2TW8ft4CfYkCegC6ZfUnnDyo3ZpcdYLbjlMR38BD
         p46bdVZSaK7KXcRLma6SaxoWHzb0hbb9EyezpHHw8vReTA8XqAMhCE/mhU++K5fNe7H8
         GDSQ==
X-Gm-Message-State: ANoB5pnCdwW/o4QS2n80SU0nJ/1SMiB6X38pmokVq8GG3ysT+p9PG8nE
        2jPhpGibnSGDEjl4529YF2h/iQ==
X-Google-Smtp-Source: AA0mqf4F4EP7I7z/iy26h49+AyTmYS1hRiveg8HEWlXm02uDHZjzR6GxDz6Hbi2m/dy6XeXKC+V4Ow==
X-Received: by 2002:a05:6e02:d94:b0:302:a008:83e5 with SMTP id i20-20020a056e020d9400b00302a00883e5mr18559072ilj.293.1669821826216;
        Wed, 30 Nov 2022 07:23:46 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id a10-20020a5ec30a000000b006bbddd49984sm631990iok.9.2022.11.30.07.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 07:23:45 -0800 (PST)
Message-ID: <34932e06-7336-3f17-9bc4-0fc67130d561@kernel.dk>
Date:   Wed, 30 Nov 2022 08:23:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH-block v2] bdi, blk-cgroup: Fix potential UAF of blkcg
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Yi Zhang <yi.zhang@redhat.com>
References: <20221129203400.1456100-1-longman@redhat.com>
 <20221130151639.GE27838@blackbody.suse.cz>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221130151639.GE27838@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/22 8:16?AM, Michal Koutn? wrote:
> On Tue, Nov 29, 2022 at 03:34:00PM -0500, Waiman Long <longman@redhat.com> wrote:
>> The reproducing system can no longer produce a warning with this patch.
>> All the runnable block/0* tests including block/027 were run successfully
>> without failure.
> 
> Thanks for the test!
> 
>> @@ -1088,7 +1088,15 @@ static void blkcg_destroy_blkgs(struct blkcg *blkcg)
>>  
>>  	might_sleep();
>>  
>> -	css_get(&blkcg->css);
>> +	/*
>> +	 * blkcg_destroy_blkgs() shouldn't be called with all the blkcg
>> +	 * references gone and rcu_read_lock not held.
>> +	 */
>> +	if (!css_tryget(&blkcg->css)) {
>> +		WARN_ON_ONCE(!rcu_read_lock_held());
>> +		return;
>> +	}
> 
> As I followed the previous discussion, the principle is that obtaining a
> reference or being inside an RCU read section is sufficient.
> 
> Consequently, I'd expect the two situations handled equally but here the
> no-ref but RCU bails out. (Which is OK because blkg_list must be empty?)
> 
> However, the might_sleep() in (non-sleepable) RCU reader section combo
> makes me wary anyway (not with the early return but tools would likely
> complain).
> 
> All in all, can't the contract of blkcg_destroy_blkgs() declare that
> a caller must pass blkcg with a valid reference? (The body of
> blkcg_destroy_blkgs then wouldn't need to get neither put the inner
> reference).

Totally agree, the proposed patch feels more like a hacky workaround
rather than a true solution. Either the contract should be that it's
ALWAYS entered with RCU lock held and hence the tryget is fine, OR that
a reference always is held when entered.

I'm going to revert the offending patch for now, and then we can queue
up a proper patch when that exists.

-- 
Jens Axboe
