Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE5372DB71
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 09:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbjFMHrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 03:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbjFMHr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 03:47:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C0EE7A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 00:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C+P1RKdkxJ+NyfWaNFtM/NhTzPDkyJkUlTPOcCqnetc=; b=vqZVEL7b3WAZ1C9pwK1Gsw5Rh8
        75LoXDLBnkPbS5OkNKmwV67emHoaUOSmQzrj/z33v+cpAGXQIXK7cSt24yekviJ5QkYsuXUJDCWsF
        8dLVxxgwt/+MgRuJHnDhNQOYqO4NuZlO8behT2J9ZRwb5hLsF8HGyKvJJUVqMCzheaWaxLTfCtFX9
        MpkQ2jYRmE3uosmz2M9bbKAXyG/ll7mI0x/0Wd2VR9eWFpB6i4WhedhnHFAn/1Yj/3YZ8HfF/5ihL
        GNMOzN6UsZ2mlmkAmk3yYI6xol5NYd8nHlVCvPMGqOdjiB+x4uKgF5mIhi3ZZ3miL+M0jt4Job2vK
        x8sHj9DA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8ykO-003fbx-Ah; Tue, 13 Jun 2023 07:47:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EA8F1300188;
        Tue, 13 Jun 2023 09:47:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CEEF3245C04DD; Tue, 13 Jun 2023 09:47:23 +0200 (CEST)
Date:   Tue, 13 Jun 2023 09:47:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] MAINTAINERS: Add CPU HOTPLUG entry
Message-ID: <20230613074723.GH83892@hirez.programming.kicks-ass.net>
References: <87o7ll6ogo.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7ll6ogo.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 11:04:39AM +0200, Thomas Gleixner wrote:
> Document the status quo and add myself and Peter as CPU hotplug
> maintainers.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Heh, what's a few more emails.. ;-)

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

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
>  CPU POWER MONITORING SUBSYSTEM
>  M:	Thomas Renninger <trenn@suse.com>
>  M:	Shuah Khan <shuah@kernel.org>
