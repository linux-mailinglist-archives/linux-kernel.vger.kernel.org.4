Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C6E640765
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 14:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbiLBNEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 08:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbiLBNEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 08:04:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719BED7571
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 05:04:08 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669986246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aA4r0h6OJcOzI1o/E1b/yf9Dc5u+hqxWhYN3+h+fyNc=;
        b=4wUX7T34jqpGdg1A9wwCbPbIYiETk6o7LggDDDzklZtzsEwttQP7KLWt3mVMykLJxwvUAj
        WruU5/OruJ+mXTdSs/Lm4xUTpY9mwHIp7M4Y3ygq4LxFXva/hdHaswH4Cve9vVBen7NbJ7
        u6AvJqLP45dn41mMOoHpo9wRAJ6tDj5sebqLSehdZJ6RBn2cDZUXBtEeExYThgIcaZpS8t
        gbMq5Ql7uaC5E6+scYxGivMoOL5BICec9XpyiWQSyYwbQtrAsbozE55ox2S1uW8avNfg14
        DagQIjQU7HgtJ5LutACkgp5DFPaRE2lYfUxazzhuo9P8zAvOZ/Fp22BlhilScQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669986246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aA4r0h6OJcOzI1o/E1b/yf9Dc5u+hqxWhYN3+h+fyNc=;
        b=iTq8BMKmf2F5USqM0C7m5bt7X1EGMSRC9fRv+HhH44ii6Ztjy+SvX7PyD+sqDJ/cbvbLBG
        8Sowmqka2l5QLGCw==
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] x86/cacheinfo: Remove set but unused variable 'trace'
In-Reply-To: <20221123060106.29067-1-jiapeng.chong@linux.alibaba.com>
References: <20221123060106.29067-1-jiapeng.chong@linux.alibaba.com>
Date:   Fri, 02 Dec 2022 14:04:05 +0100
Message-ID: <87v8muot2y.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23 2022 at 14:01, Jiapeng Chong wrote:

> Variable 'trace' is not effectively used in the function, so delete it.
>
> arch/x86/kernel/cpu/cacheinfo.c:737:15: warning: variable 'trace' set but not used.
>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3243

This link is really pointless.

> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  arch/x86/kernel/cpu/cacheinfo.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
> index f4e5aa27eec6..c6c0052def8e 100644
> --- a/arch/x86/kernel/cpu/cacheinfo.c
> +++ b/arch/x86/kernel/cpu/cacheinfo.c
> @@ -734,7 +734,7 @@ void init_hygon_cacheinfo(struct cpuinfo_x86 *c)
>  void init_intel_cacheinfo(struct cpuinfo_x86 *c)
>  {
>  	/* Cache sizes */
> -	unsigned int trace = 0, l1i = 0, l1d = 0, l2 = 0, l3 = 0;
> +	unsigned int l1i = 0, l1d = 0, l2 = 0, l3 = 0;
>  	unsigned int new_l1d = 0, new_l1i = 0; /* Cache sizes from cpuid(4) */
>  	unsigned int new_l2 = 0, new_l3 = 0, i; /* Cache sizes from cpuid(4) */
>  	unsigned int l2_id = 0, l3_id = 0, num_threads_sharing, index_msb;
> @@ -836,7 +836,6 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
>  							l3 += cache_table[k].size;
>  							break;
>  						case LVL_TRACE:
> -							trace += cache_table[k].size;
>  							break;

Sure, that makes the warning go away, but what's the purpose of
'case LVL_TRACE:' now?

Now if you remove that you really want look at the surrounding logic of
LVL_TRACE. Hint: There is way more completely useless code to remove.

Thanks,

        tglx
