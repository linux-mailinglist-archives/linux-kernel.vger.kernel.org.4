Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFA7677916
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 11:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjAWKXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 05:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjAWKXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 05:23:38 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EFF891E9EA;
        Mon, 23 Jan 2023 02:23:36 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 448C1AD7;
        Mon, 23 Jan 2023 02:24:18 -0800 (PST)
Received: from [10.34.100.128] (pierre123.nice.arm.com [10.34.100.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93A023F71A;
        Mon, 23 Jan 2023 02:23:35 -0800 (PST)
Message-ID: <953300ac-25fa-db8d-c270-d10559a0fa02@arm.com>
Date:   Mon, 23 Jan 2023 11:23:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [ANNOUNCE] v6.2-rc3-rt1
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <Y8A4f9m/ddIUwfZE@linutronix.de>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <Y8A4f9m/ddIUwfZE@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sebastian,

On 1/12/23 17:42, Sebastian Andrzej Siewior wrote:
> Dear RT folks!
> 
> I'm pleased to announce the v6.2-rc3-rt1 patch set.
> 
> Changes since v6.1-rc7-rt5:
> 
>    - Update to v6.2-rc3
> 
> Known issues
>       - Valentin Schneider reported a few splats on ARM64 in arm_pmu, see
>            https://lore.kernel.org/all/20210810134127.1394269-1-valentin.schneider@arm.com/T/#mf05c04376f59a543da6cceeb72e162af2de2b648
>         It is worked on
>            https://lore.kernel.org/all/20220930111844.1522365-1-mark.rutland@arm.com/

I think all the splats of the list are now solved and this item can be removed
from the announce mail, unless you think there are other things to do,

[SPLAT 1/3] arm_pmu: Sleeping spinlocks down armpmu_alloc_atomic()
https://lore.kernel.org/all/166783778053.34166.14415620612752225909.b4-ty@kernel.org/

[SPLAT 2/3] irqchip/gic-v3-its: Sleeping spinlocks down gic_reserve_range()
https://lore.kernel.org/lkml/20211027151506.2085066-3-valentin.schneider@arm.com/

[SPLAT 3/3] gpio: dwapb: Sleeping spinlocks down IRQ mapping
https://lore.kernel.org/all/20220419012810.88417-1-schspa@gmail.com/

Regards,
Pierre

> 
>       - It has been reported that the ktimers thread may not be woken up
>         and instead the timer is handled in softirq context.
> 
> You can get this release via the git tree at:
> 
>      git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.2-rc3-rt1
> 
> The RT patch against v6.2-rc3 can be found here:
> 
>      https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.2/older/patch-6.2-rc3-rt1.patch.xz
> 
> The split quilt queue is available at:
> 
>      https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.2/older/patches-6.2-rc3-rt1.tar.xz
> 
> Sebastian
