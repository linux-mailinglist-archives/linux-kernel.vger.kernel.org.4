Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9F166699A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 04:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236007AbjALD1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 22:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236045AbjALD1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 22:27:13 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E48C75E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 19:26:49 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id n12so17840725pjp.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 19:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SsH0mjnH0SeMzrOGfLla9s5TybpBmyzM+PHEYBJpLrQ=;
        b=8NifJggs/yh5SMPhQK1Rns2F/N9YHJzl2Ypi9i9jYMCq8JvNLfeXx0wDvwNbHAEYZS
         aiNsnWSqgv0g2jFpnl9MK1Y2zgFOOtY1/Cr1ukz7V2f3c//7jqoojUzeAWiPtkAkNsu3
         y5NrTN9VglZvUCli+KS+Fuep2brgdFlSuTBp++iYWwI3HI8Urzjnp02w/NY3kipmZii8
         UqqCazVNBK5ELchNv1pdLGUa9DDY77/ME9StIercWWbZEJGmjbAcWyWNj+BuzivqdALs
         /zWjgQfVGjobtikFVWg83AqJJYWvGhvXR0D+XrKxLiyTjTVPhVt3cnyakg9mR7p1e29N
         I3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SsH0mjnH0SeMzrOGfLla9s5TybpBmyzM+PHEYBJpLrQ=;
        b=akXGTqwsMQvm6GYjAOA2weCDqn8cOEAYUzbJD7Go8hmCCv2b0Dfy563NtOcHzIvI7c
         RtHHrYJIrpCDlL3YrUzvZhFvKCDeU3MJ2UizzvBO6Cc9mFIqjjRu2KXquY1P3NZH0Wt8
         ht72uXQ4bJ0Bou2dU2LCnmW4m591Lgi03GrE8yYyuXroWxiWQGw2K9CPppc5ybI8peCo
         sYWRpXQAWd4XHV0ZjCgwljDm/hS/bdeejhzxijqoNbfqmDZOXLNVJYNOwJR7suNNvyx+
         2T9gNOP2zP2l7glQSJ/K5FGy62/J39PhIEXGpMk1otUwc6ZRQM7E0f2+nzuwxq/PlB0W
         Vbiw==
X-Gm-Message-State: AFqh2kqNYhV58avyi6Hwv0nDuNiOAD4MzEkXk2mvGnLAe6iSwmFHV87r
        HaeXju7/qwyABzTMV1qquDOABQ==
X-Google-Smtp-Source: AMrXdXs4Ye9cDgkUChsXanRTIAebOqSR6oXMlmyQWNMKcPppTo5A7P42knpZBvwRXjZt+s2Vc/cKow==
X-Received: by 2002:a17:902:76cb:b0:18d:dd85:303c with SMTP id j11-20020a17090276cb00b0018ddd85303cmr4554834plt.8.1673494008887;
        Wed, 11 Jan 2023 19:26:48 -0800 (PST)
Received: from [10.254.85.126] ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id t1-20020a170902d14100b00186b3c3e2dasm10959022plt.155.2023.01.11.19.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 19:26:48 -0800 (PST)
Message-ID: <0e03867e-54ea-fb10-1f8a-f098c9dbb026@bytedance.com>
Date:   Thu, 12 Jan 2023 11:26:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [External] Re: [PATCH v3] blk-throtl: Introduce sync and async
 queues for blk-throtl
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Tejun Heo <tj@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yinxin.x@bytedance.com
References: <20221226130505.7186-1-hanjinke.666@bytedance.com>
 <20230105161854.GA1259@blackbody.suse.cz>
 <20230106153813.4ttyuikzaagkk2sc@quack3> <Y7hTHZQYsCX6EHIN@slm.duckdns.org>
 <c839ba6c-80ac-6d92-af64-5c0e1956ae93@bytedance.com>
 <20230111123532.GB3673@blackbody.suse.cz>
From:   hanjinke <hanjinke.666@bytedance.com>
In-Reply-To: <20230111123532.GB3673@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/1/11 下午8:35, Michal Koutný 写道:
> Hello.
> 
> Thanks all for sharing ideas and more details (in time-previous messages).
> 
> On Sat, Jan 07, 2023 at 02:07:38AM +0800, hanjinke <hanjinke.666@bytedance.com> wrote:
>> But for some specific scenarios with old kernel versions, blk-throtl
>> is alose needed. The scenario described in my email is in the early stage of
>> research and extensive testing for it. During this period，some priority
>> inversion issues amoug cgroups or within one cgroup have been observed. So I
>> send this patch to try to fix or mitigate some of these issues.
> 
> Jinke, do you combine blk-throtl with memory limits? (As that could in theory
> indirectly reduce async requests as dirtier would be slowed down.)
> 

Hi

In fact, some of those tests above are done in vm with only total 16g 
memory.

Agree with what you said, if we further tighten the memory usage, things 
will get better because this will indirectly reduces writeback pages in
blk-throtl queue.

Thanks.
