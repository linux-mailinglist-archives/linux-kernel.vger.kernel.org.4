Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156CE61740C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 03:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiKCCNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 22:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiKCCN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 22:13:28 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6EB64C1
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 19:13:27 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so501519pjd.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 19:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMzrvYyYy/W+4cGhBZeoRUR17rUZ1JZqGeV1907ajb4=;
        b=POmg/14cGPQ2xtPMaiDVwNaxOFfwYJ9iR4Zycxg3geAV9EKyOz0uySgFDDvmaKTUZi
         alFKmuXoeHA1Xjf3nZ8ZTFhTKuwtUpI0Tcd+uu8g8qKOqz6dZO3k0ewtWNsbJwLT5PJ5
         370knaA+E40T7Z0QQYhOPZRpZJWH9vBpz59pW0NxDgxiqCQeFGPGGxcacctuBI0/vaYx
         wD+/+thF2Cko0M7CE6Tgv0oy6f54p6hVyvF24DOOMmbt4bpw/s+gVc7a0ELFUKyAGONu
         JtM7NGmWmBZQ/8zJHs0JB2AJAN8PkH8DXimsaHM+0wxggkJi7WlFDE0Bmz1iNE0oB7N1
         J8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sMzrvYyYy/W+4cGhBZeoRUR17rUZ1JZqGeV1907ajb4=;
        b=6W7mJ8chnjnV/4wp6hlElyO3R0DlEuD7VdLLD7D78/rRMtzpSz0jQg+dQmcO8mqUKl
         PcpX60gJZRXvl72O7BPA7Y7E8jLhPdFcQP28L9r+4viXy4501VmYmpO5DbQ3qcKNr5JN
         S77GkqqAWGJkg3cJ4U0M+zqR+KgcJjahy4SJ6aHsgCBKUbnqZ9W6P+61dSSPmMgytcHR
         kcJhaK3yoepaUIygVv8XjbBY8ThYJ80pbqpynrWdAyVHN6V/v0xYP1+NHBJd+3f/ERuB
         LytCW2VCE5GDCB5JX84A2abc06HDdvVGRT7BMeyKGL/MmHl9Ac4LooRj9jMtXaz+eRGl
         S/4g==
X-Gm-Message-State: ACrzQf3MnIrCN+QDruHfoV4YMyaInXrzvZIeiWphNwvrti0eS5/8YIBE
        7tU2s6fGildFQm2U83pRTzjJFQ==
X-Google-Smtp-Source: AMsMyM4wN6ENNIHkjKzh3K5hVR2wMizxKLh91CM6oTBdnA/UT+wzV72bTZtdZ1YIoPYb1ikd77eijg==
X-Received: by 2002:a17:902:ce82:b0:187:3591:edac with SMTP id f2-20020a170902ce8200b001873591edacmr12545688plg.153.1667441607226;
        Wed, 02 Nov 2022 19:13:27 -0700 (PDT)
Received: from [10.54.24.49] ([143.92.118.2])
        by smtp.gmail.com with ESMTPSA id z5-20020a170903018500b00186ff402525sm3464941plg.213.2022.11.02.19.13.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 19:13:26 -0700 (PDT)
Message-ID: <25f6a188-4cc6-dace-1468-fd5645711515@shopee.com>
Date:   Thu, 3 Nov 2022 10:13:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH] cgroup: Simplify code in css_set_move_task
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221020074701.84326-1-haifeng.xu@shopee.com>
 <20221027080558.GA23269@blackbody.suse.cz>
 <adb7418c-39a2-6202-970a-a039ad8201dd@shopee.com>
 <20221031131140.GC27841@blackbody.suse.cz>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <20221031131140.GC27841@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/10/31 21:11, Michal Koutný wrote:
> Hello.
> 
>> 1) If calls 'css_set_update_populated' , the cset is either getting the
>> first task or losing the last. There is a need to update the populated
>> state of the cset only when 'css_set_populated' returns false.
>> In other words, the last has been deleted from from_cset and the first
>> hasn't been added to to_cset yet.
> 
> I've likely misread the condition previously. I see how this works now
> (update happens after "from_cset" but before "to_cset" migration).
> 
>> 3) In order to update the populated state of to_cset the same way
>> from_cset does, 'css_set_update_populated' is also invoked during the
>> process of moving a task to to_cset.
> 
> As I think more about this in the context of vertical migrations
> (ancestor<->descendant, such as during controller dis- or enablement),
> I'm afraid the inverted order would lead to "spurious" emptiness
> notifications in ancestors (in the case a there is just a single task
> that migrates parent->child, parent/cgroup.populated would generate and
> event that'd be nullified by the subsequent population of the child).
Hi, Michal.

I understand your worries. Can I just check the populated state of
css_set in 'css_set_update_populated' and don't change the order any
more? I think it can also streamline 'css_set_move_task' a bit.

Thanks,
Hiafeng.
> 
> So I'm not sure the change is worth it.
> 
> Michal
