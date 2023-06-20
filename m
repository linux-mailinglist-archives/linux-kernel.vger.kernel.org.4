Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5083073679B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjFTJXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 05:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbjFTJXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:23:45 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEE010C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 02:23:44 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D90411EC0501;
        Tue, 20 Jun 2023 11:23:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687253022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nqYaAfH+0qUaJXAWYIYdyPL8OSga0nc0X68EgXzg03A=;
        b=qmQcSLzoRAtX5w9YUuAz1b0Nrou1kyk+irjLd//NqUtrLisYqVZIJ1IFx/RzpDFyYQomm2
        gjjKp4rK7oOYVBJNLO0QGL8Ig6gF6tlMfB7seblwPthX4VDqM3CAKavM6fgx1VNXmlMTBQ
        hP07rOZ1pRl4u/q5Ipp52htnjF+1zsM=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HsMAY5f3WRGa; Tue, 20 Jun 2023 09:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687253020; bh=nqYaAfH+0qUaJXAWYIYdyPL8OSga0nc0X68EgXzg03A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B35jTsVMjwQxNDqvVxJQ4nAbvRo5tR3mgV1FHnbS4DZDHRzlrYvx3VJxMCmJvEBt+
         ZREfhX//PH+X4YPEIpanbkKfwc1qDTd8unJI+JAJI9DqYidgeP2G2iOvMgBmfvIP9Q
         wFCPQIUzCkH40zdCjUlj8pm4FQZ7HF0SGacHCw8u2yLregj62H7BoflmvHzkdvOuxe
         XD7Nl7Pne4CH3G38zr1+NwRlDeT5ggzk+qoeQjLRI6p3ZU+vfmFxhce4e4HYXxwUIN
         JaLXVZolLxRDErCJQKzTvix2mrDHDvki7Ci5PbEy/DQp9I8/1TbYdpJmX7gq2BPhaS
         /Iq5R+/ipt/5RvsVDdLF1595tZttWerJ3B0gJxJDVDuA1aqywdvbq5aKRw5GxHs2fT
         mrM1co5Z1+kc6gfIENwM4Rnq5fG+v5lTfsWHWXz2fw5RPnhosK7LM7diwlilfnytvo
         25qH0OJ2PM2jr24cCKZZDFPYIixt6zinfi2p0IcLG3NLzj8Z9wDbESWB8yr55rucDl
         5CVJ8EEhzkLu0bFzumj+0AAghU6+hifoBEkJ5UV6LgoR7WWfK/b+02uR5ETM5zeWM4
         +RPWQR7ucPXL+3CvT0xUfyZdz4weUlgR1vDJfS1tb3nrDOk7izQe03Ry2Eo4QvUUiZ
         jgcTXQJLTzgeoCT17YbqSxY8=
Received: from zn.tnic (p200300Ea971Dc5b2329c23FfFea6A903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c5b2:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 68DC240E0034;
        Tue, 20 Jun 2023 09:23:29 +0000 (UTC)
Date:   Tue, 20 Jun 2023 11:23:24 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Battersby <tonyb@cybernetics.com>,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch v3 5/7] x86/smp: Cure kexec() vs. mwait_play_dead()
 breakage
Message-ID: <20230620092324.GWZJFwDDVo3TRUI0Ck@fat_crate.local>
References: <20230615190036.898273129@linutronix.de>
 <20230615193330.492257119@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230615193330.492257119@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 10:33:57PM +0200, Thomas Gleixner wrote:
> TLDR: It's a mess.

LOL. You don't need the rest of the commit message - this says it all.
:-P

> When kexec() is executed on a system with "offline" CPUs, which are parked

I'd say simply "with offlined CPUs"

> in mwait_play_dead() it can end up in a triple fault during the bootup of
> the kexec kernel or cause hard to diagnose data corruption.
> 
> The reason is that kexec() eventually overwrites the previous kernels text,

kernel's

> page tables, data and stack, If it writes to the cache line which is

... and stack. If it ...

> monitored by an previously offlined CPU, MWAIT resumes execution and ends

... by a previously...

> up executing the wrong text, dereferencing overwritten page tables or
> corrupting the kexec kernels data.

Lovely.

> Cure this by bringing the offline CPUs out of MWAIT into HLT.

... offlined CPUs... :

> Write to the monitored cache line of each offline CPU, which makes MWAIT

ditto.

> resume execution. The written control word tells the offline CPUs to issue

ditto and so on.

> HLT, which does not have the MWAIT problem.
> 
> That does not help, if a stray NMI, MCE or SMI hits the offline CPUs as
> those make it come out of HLT.
> 
> A follow up change will put them into INIT, which protects at least against
> NMI and SMI.

...

> @@ -1807,6 +1815,10 @@ static inline void mwait_play_dead(void)
>  			(highest_subcstate - 1);
>  	}
>  
> +	/* Set up state for the kexec() hack below */
> +	md->status = CPUDEAD_MWAIT_WAIT;
> +	md->control = CPUDEAD_MWAIT_WAIT;
> +
>  	wbinvd();
>  
>  	while (1) {
> @@ -1824,10 +1836,57 @@ static inline void mwait_play_dead(void)

JFYI: that last hunk has some conflicts applying to latest tip/master.
Might need merge resolving...

>  		mb();
>  		__mwait(eax, 0);
>  
> +		if (READ_ONCE(md->control) == CPUDEAD_MWAIT_KEXEC_HLT) {
> +			/*
> +			 * Kexec is about to happen. Don't go back into mwait() as
> +			 * the kexec kernel might overwrite text and data including
> +			 * page tables and stack. So mwait() would resume when the
> +			 * monitor cache line is written to and then the CPU goes
> +			 * south due to overwritten text, page tables and stack.
> +			 *
> +			 * Note: This does _NOT_ protect against a stray MCE, NMI,
> +			 * SMI. They will resume execution at the instruction
> +			 * following the HLT instruction and run into the problem
> +			 * which this is trying to prevent.
> +			 */
> +			WRITE_ONCE(md->status, CPUDEAD_MWAIT_KEXEC_HLT);
> +			while(1)
> +				native_halt();
> +		}
> +
>  		cond_wakeup_cpu0();
>  	}
>  }
>  
> +/*
> + * Kick all "offline" CPUs out of mwait on kexec(). See comment in
> + * mwait_play_dead().
> + */
> +void smp_kick_mwait_play_dead(void)
> +{
> +	u32 newstate = CPUDEAD_MWAIT_KEXEC_HLT;

Do you even need this newstate thing?

> +	struct mwait_cpu_dead *md;
> +	unsigned int cpu, i;
> +
> +	for_each_cpu_andnot(cpu, cpu_present_mask, cpu_online_mask) {
> +		md = per_cpu_ptr(&mwait_cpu_dead, cpu);
> +
> +		/* Does it sit in mwait_play_dead() ? */
> +		if (READ_ONCE(md->status) != CPUDEAD_MWAIT_WAIT)
> +			continue;
> +
> +		/* Wait maximal 5ms */

		/* Wait 5ms maximum */

> +		for (i = 0; READ_ONCE(md->status) != newstate && i < 1000; i++) {
> +			/* Bring it out of mwait */
> +			WRITE_ONCE(md->control, newstate);
> +			udelay(5);
> +		}
> +
> +		if (READ_ONCE(md->status) != newstate)
> +			pr_err("CPU%u is stuck in mwait_play_dead()\n", cpu);

Shouldn't this be a pr_err_once thing so that it doesn't flood the
console unnecessarily?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
