Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD1B72C981
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239416AbjFLPO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235791AbjFLPOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:14:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D4798
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=7yfTF7kPlsj3bWKH/nWlqC+yy5RPvummV4o47UM2YH0=; b=wk87ZMR6HQWnVZPi8DiMw3HMEu
        68sCVvrKltYbVsWBqWGLJGycStbr9eYBHAtc4TwMOPBHkyfa9ztIJ2p6OWFTCK9oMNePZCaqRsB18
        eEREBaDs3kO2OGlxAAuy9PxkRoid689vTTyJ2jAMgqYv4HFTbjhd2aj3HwDSlBlqxudtRnyWz0KQ+
        +HLmHP5Hj/8A0FvsMsh6OL2Nq+Ngfw97sRwBz276HiVVOClSr6SIZB5NommMG5Zs7RbbWjKvQVwBm
        SOuzMeL8ZP9kVLLQby+k2O/kRw69yXsgJsw1U54NGR74k1Fu9TX1PXUS8tPdP2gG+tDp2/rQ9z+rr
        92LWTEMg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8jFK-004R1X-25;
        Mon, 12 Jun 2023 15:14:18 +0000
Message-ID: <c4ec2d2e-309a-50e3-c584-d9375416c771@infradead.org>
Date:   Mon, 12 Jun 2023 08:14:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] MAINTAINERS: Add CPU HOTPLUG entry
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <87o7ll6ogo.ffs@tglx>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87o7ll6ogo.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 6/12/23 02:04, Thomas Gleixner wrote:
> Document the status quo and add myself and Peter as CPU hotplug
> maintainers.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  MAINTAINERS |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5356,6 +5356,18 @@ F:	Documentation/driver-api/pm/cpuidle.r
>  F:	drivers/cpuidle/
>  F:	include/linux/cpuidle.h
>  
> +CPU HOTPLUG
> +M:	Thomas Gleixner <tglx@linutronix.de>
> +M:	Peter Zijlstra <peterz@infradead.org>
> +L:	linux-kernel@vger.kernel.org
> +S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp/core
> +F:	kernel/cpu.c
> +F:	kernel/smpboot.*
> +F:	include/linux/cpu.h
> +F:	include/linux/cpuhotplug.h
> +F:	include/linux/smpboot.h
> +

The new entry should be before CPU IDLE, not after it.
Otherwise LGTM, thanks for adding this. I was looking for it recently.

Acked-by: Randy Dunlap <rdunlap@infradead.org>

>  CPU POWER MONITORING SUBSYSTEM
>  M:	Thomas Renninger <trenn@suse.com>
>  M:	Shuah Khan <shuah@kernel.org>

-- 
~Randy
