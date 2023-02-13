Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56566953E6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 23:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjBMWay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 17:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjBMWas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 17:30:48 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3359D1CF75
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 14:30:23 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id n13so9692580wmr.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 14:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=akb88PvmqOcRfJ+0UlV8yVezkmvUAKQz1XrSjJj+70E=;
        b=aKwxdJpGpXkNcHV3pb/eAwAi95fBzhrFPwjEPMnvQ909il/kZXDSfzYqYkVfr5xMTc
         1CVBG9K/P46woCBt2VQ/30V8v6hErm4LnnXWARTDPyrlBwsmhcPD46p90WmV2YzAGXT3
         f+LGPEnLv6lgwTCHXLTZrN3aHC+HVSNHgP5BuNPM5tXPk4EbBj3UGp+/bYYKaYpwVQfY
         IhNYCVkL26QXAPHzcW3Q/q/HQeIwV4zXlwGBw2nvQHdszcmUhvePZCRygMTqYq5sFGW/
         oRjLOZapPQBz/xX/3e3kVgHe8gnqzh3moAY/DUJmxzSxIeSb7U0jbGVQMeV256wfAlws
         os2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=akb88PvmqOcRfJ+0UlV8yVezkmvUAKQz1XrSjJj+70E=;
        b=HdEBtvjOxapLpgusEA1ATJYIb3vZwJ6PbHddEdeHPJc7FLP4ear+z72sCUYXW1WIFq
         Pd/cEJ/UdNKlq+iv3t5T/pcA1l4VKfGMs+MG+W4PTs//ERv+5ZZH0+J4zmHYGy64KFZN
         gmJq6mW/E0H/uvJ8GjccH1o+BhVlk7OEB+ipTvyrQpPXesXuRKiv27i+qkLfvhw7vmFC
         ZxNfvrViergg8+Vaywedyo/3xOB/7lbfD2h3+sbYnsDJ+aPtwoZBYM7IHGxBhJq1JvVU
         rxTWj3i5tNkj9MQGhM4HRH3PvlYA5zjCvFAaynxCIaU2+E1UnWFAH1akBPCd1ZULNZQD
         1rJQ==
X-Gm-Message-State: AO0yUKU7rFbU1dKf86f3s7jwBobRkmYVUwXxSFrzjgLj5rKyCpp9+hb9
        PRNupnxtPNrtWVxWe9S3GBiAaw==
X-Google-Smtp-Source: AK7set9Lq0eiMXLRNAQPetmx67Qr7YTZfDLhNIgLyYRdSyrawCyOgRoILsxKBtQaUUIVOHGJSnv+nQ==
X-Received: by 2002:a05:600c:703:b0:3dc:16d2:ae5e with SMTP id i3-20020a05600c070300b003dc16d2ae5emr195622wmn.32.1676327421748;
        Mon, 13 Feb 2023 14:30:21 -0800 (PST)
Received: from ?IPV6:2a02:6b6a:b566:0:9e1:512:feb0:fe83? ([2a02:6b6a:b566:0:9e1:512:feb0:fe83])
        by smtp.gmail.com with ESMTPSA id n22-20020a05600c4f9600b003dcc82ce53fsm16772502wmq.38.2023.02.13.14.30.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 14:30:21 -0800 (PST)
Message-ID: <5b696beb-52e2-716c-83c6-3bb70e5c9565@bytedance.com>
Date:   Mon, 13 Feb 2023 22:30:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [External] Re: [PATCH v8 9/9] x86/smpboot: Serialize topology
 updates for secondary bringup
Content-Language: en-US
To:     David Woodhouse <dwmw2@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, kim.phillips@amd.com
Cc:     arjan@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        rcu@vger.kernel.org, mimoja@mimoja.de, hewenliang4@huawei.com,
        thomas.lendacky@amd.com, seanjc@google.com, pmenzel@molgen.mpg.de,
        fam.zheng@bytedance.com, punit.agrawal@bytedance.com,
        simon.evans@bytedance.com, liangma@liangbit.com,
        David Woodhouse <dwmw@amazon.co.uk>
References: <20230209154156.266385-1-usama.arif@bytedance.com>
 <20230209154156.266385-10-usama.arif@bytedance.com> <87v8k5s3dq.ffs@tglx>
 <BE9F9210-4DBD-4A9F-BA5A-A7B5BA580FCC@infradead.org>
From:   Usama Arif <usama.arif@bytedance.com>
In-Reply-To: <BE9F9210-4DBD-4A9F-BA5A-A7B5BA580FCC@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/02/2023 20:53, David Woodhouse wrote:
> 
> 
> On 13 February 2023 21:43:13 CET, Thomas Gleixner <tglx@linutronix.de> wrote:
>> On Thu, Feb 09 2023 at 15:41, Usama Arif wrote:
>>> From: David Woodhouse <dwmw@amazon.co.uk>
>>>
>>> The toplogy update is performed by the AP via smp_callin() after the BSP
>>> has called do_wait_cpu_initialized(), setting the AP's bit in
>>> cpu_callout_mask to allow it to proceed.
>>>
>>> In preparation to enable further parallelism of AP bringup, add locking to
>>> serialize the update even if multiple APs are (in future) permitted to
>>> proceed through the next stages of bringup in parallel.
>>
>> This one is also only relevant for further parallelisation, right?
> 
> I believe so, yes. But it's low-hanging fruit and might as well go in now.

Yes, only needed if we parallelize further, i.e. after 
do_wait_cpu_initialized. As David said, its a simple enough and easy 
patch, but its not needed for parallelizing INIT/SIPI.

I tested Davids' part2 branch 
(https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/parallel-6.2-rc7) 
again just to be sure, and the only commit that makes a significant 
difference in smpboot time on top of part1 (this series) is reusing 
timer calibration (100ms to 34ms).

Parallelizing do_wait_cpu_initialized didn't significantly improve 
smpboot time (only reduced to 31ms on average of 4 runs so maybe within 
the margin of error?), so I think its better to move this patch into its 
own series with any further parallelization only if it shows a further 
improvement in smpboot time?

Thanks,
Usama
