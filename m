Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B485E6B0A40
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjCHOAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjCHOAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:00:22 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 947848734F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 05:58:39 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B5C21063;
        Wed,  8 Mar 2023 05:59:20 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.52.94])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE46F3F67D;
        Wed,  8 Mar 2023 05:58:35 -0800 (PST)
Date:   Wed, 8 Mar 2023 13:58:28 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Rakesh Babu Saladi <rsaladi2@marvell.com>
Cc:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        George Cherian <gcherian@marvell.com>,
        Naveen Mamindlapalli <naveenm@marvell.com>
Subject: Re: [EXT] Re: [PATCH] arm64: smccc: Add trace events to SMC calls.
Message-ID: <ZAiUhOfb6XAE2aPy@FVFF77S0Q05N>
References: <20230304125850.32687-1-rsaladi2@marvell.com>
 <ZAX9G5mqGqzTZZ5N@FVFF77S0Q05N>
 <CY4PR1801MB1880A1E3C8EE68B5484536238AB49@CY4PR1801MB1880.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR1801MB1880A1E3C8EE68B5484536238AB49@CY4PR1801MB1880.namprd18.prod.outlook.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 12:25:15PM +0000, Rakesh Babu Saladi wrote:
> Hi Mark, 

Hi Rakesh,

As a general thing, your mail setup isn't being helpful here. It has corrupted
links below, and this style of quoting without leading '>' characters is
incredibly painful to read.

The inline comment style you've used heere is also painful to read, but I
understand that's working around the mail client being unhelpful.

There's some guidance on how to configure mail clients at:

  https://docs.kernel.org/process/email-clients.html

> 
> Please see comments in line.
> 
> Thanks,
> Rakesh.
> 
> -----Original Message-----
> From: Mark Rutland <mark.rutland@arm.com> 
> Sent: Monday, March 6, 2023 8:18 PM
> To: Rakesh Babu Saladi <rsaladi2@marvell.com>
> Cc: lpieralisi@kernel.org; sudeep.holla@arm.com; linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Sunil Kovvuri Goutham <sgoutham@marvell.com>; George Cherian <gcherian@marvell.com>; Naveen Mamindlapalli <naveenm@marvell.com>
> Subject: [EXT] Re: [PATCH] arm64: smccc: Add trace events to SMC calls.
> 
> External Email
> 
> ----------------------------------------------------------------------
> On Sat, Mar 04, 2023 at 06:28:50PM +0530, Rakesh Babu Saladi wrote:
> > This patch adds start and end trace events to an SMC call sent from 
> > kernel to ATF. The start trace event prints the smc_id and the end 
> > trace event prints the smc_id and the time taken to process the SMC 
> > call.
> > 
> > Signed-off-by: Rakesh Babu Saladi <rsaladi2@marvell.com>
> 
> We've said no to this in the past:
> 

  [...
    garbled link, was: 
    https://lore.kernel.org/lkml/20210923112058.GA14893@C02TD0UTHF1T.local/
  ...]

> I don't think anything has changed, and this has all the same problems as
> before, so I do not think we should do this.
> Rakesh >> Can you please be more specific why the changes are not getting accepted?

I was very specific in the reply I linked to at:

  https://lore.kernel.org/lkml/20210923112058.GA14893@C02TD0UTHF1T.local/

The gist being:

* There are a tonne of SMCCC invocations that this doesn't capture.

* This doesn't handle SMCCC variants which can pass x0-17

* This is very low level, and so not good for consumers (e.g. most of the
  arguments may be meadningless UNKNOWN values).

* This is very low level, and so painful for things which must avoid
  instrumentation (e.g. noinstr code for ARCH_WORKAROUND_*).

* SMCCC may change again in future, and I don't want to get stuck in an ABI we
  cannot maintain.

Which all remain the same here, so NAK to this patch as it stands.

As before, I'd suggest placing tracepoints at a higher level in the specific
SMCCC callers you're interested in.

> Which SMC calls do you want to trace, and why?
> Rakesh >> These traces we would like to have for debugging purposes while calling any SMC call.

That's not a lot of information to go on. Consider the following:

* Are you trying to solve a particular problem, for which this would help?

* Are you trying to debug kernel code, or the firmware?

* Are you trying to debug a functional issue, or get some statistics for
  optimization?

I'll also note that if you really want to, you can place a kprobe or kretprobe
around the invocation and trace this without any kernel changes. So if you just
need some data right now, that should be sufficient.

Thanks,
Mark.

> Thanks,
> Mark.
> 
> > ---
> >  drivers/firmware/smccc/Makefile      |  3 +-
> >  drivers/firmware/smccc/smccc.c       | 14 ++++++++++
> >  drivers/firmware/smccc/smccc_trace.c |  7 +++++  
> > drivers/firmware/smccc/smccc_trace.h | 41 ++++++++++++++++++++++++++++
> >  include/linux/arm-smccc.h            |  4 ++-
> >  kernel/time/timekeeping.c            |  7 +++++
> >  6 files changed, 74 insertions(+), 2 deletions(-)  create mode 100644 
> > drivers/firmware/smccc/smccc_trace.c
> >  create mode 100644 drivers/firmware/smccc/smccc_trace.h
> > 
> > diff --git a/drivers/firmware/smccc/Makefile 
> > b/drivers/firmware/smccc/Makefile index 40d19144a860..e74c35191b49 
> > 100644
> > --- a/drivers/firmware/smccc/Makefile
> > +++ b/drivers/firmware/smccc/Makefile
> > @@ -1,4 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  #
> > -obj-$(CONFIG_HAVE_ARM_SMCCC_DISCOVERY)	+= smccc.o kvm_guest.o
> > +ccflags-y += -I$(src)
> > +obj-$(CONFIG_HAVE_ARM_SMCCC_DISCOVERY)	+= smccc_trace.o smccc.o kvm_guest.o
> >  obj-$(CONFIG_ARM_SMCCC_SOC_ID)	+= soc_id.o
> > diff --git a/drivers/firmware/smccc/smccc.c 
> > b/drivers/firmware/smccc/smccc.c index 60ccf3e90d7d..7631a16479e9 
> > 100644
> > --- a/drivers/firmware/smccc/smccc.c
> > +++ b/drivers/firmware/smccc/smccc.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/platform_device.h>
> >  #include <asm/archrandom.h>
> > +#include "smccc_trace.h"
> >  
> >  static u32 smccc_version = ARM_SMCCC_VERSION_1_0;  static enum 
> > arm_smccc_conduit smccc_conduit = SMCCC_CONDUIT_NONE; @@ -59,3 +60,16 
> > @@ static int __init smccc_devices_init(void)
> >  	return 0;
> >  }
> >  device_initcall(smccc_devices_init);
> > +
> > +void arm_smccc_smc(unsigned long a0, unsigned long a1, unsigned long a2, unsigned long a3,
> > +		   unsigned long a4, unsigned long a5, unsigned long a6, unsigned long a7,
> > +		   struct arm_smccc_res *res)
> > +{
> > +	u64 start, elapsed;
> > +
> > +	trace_arm_smccc_smc_start(a0);
> > +	start = ktime_get_ns();
> > +	__arm_smccc_smc(a0, a1, a2, a3, a4, a5, a6, a7, res, NULL);
> > +	elapsed = ktime_get_ns() - start;
> > +	trace_arm_smccc_smc_end(a0, elapsed); }
> > diff --git a/drivers/firmware/smccc/smccc_trace.c 
> > b/drivers/firmware/smccc/smccc_trace.c
> > new file mode 100644
> > index 000000000000..6b94d5d9c0f4
> > --- /dev/null
> > +++ b/drivers/firmware/smccc/smccc_trace.c
> > @@ -0,0 +1,7 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#define CREATE_TRACE_POINTS
> > +#include "smccc_trace.h"
> > +
> > +EXPORT_TRACEPOINT_SYMBOL(arm_smccc_smc_start);
> > +EXPORT_TRACEPOINT_SYMBOL(arm_smccc_smc_end);
> > diff --git a/drivers/firmware/smccc/smccc_trace.h 
> > b/drivers/firmware/smccc/smccc_trace.h
> > new file mode 100644
> > index 000000000000..c0ef836bc093
> > --- /dev/null
> > +++ b/drivers/firmware/smccc/smccc_trace.h
> > @@ -0,0 +1,41 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#undef TRACE_SYSTEM
> > +#define TRACE_SYSTEM smccc
> > +
> > +#if !defined(__SMCCC_TRACE_H) || defined(TRACE_HEADER_MULTI_READ) 
> > +#define __SMCCC_TRACE_H
> > +
> > +#include <linux/types.h>
> > +#include <linux/tracepoint.h>
> > +
> > +TRACE_EVENT(arm_smccc_smc_start,
> > +	    TP_PROTO(unsigned long smc_id),
> > +	    TP_ARGS(smc_id),
> > +	    TP_STRUCT__entry(__field(unsigned long, smc_id)),
> > +	    TP_fast_assign(__entry->smc_id = smc_id;),
> > +	    TP_printk("SMC ID: 0x%lx", __entry->smc_id) );
> > +
> > +TRACE_EVENT(arm_smccc_smc_end,
> > +	    TP_PROTO(unsigned long smc_id, u64 elapsed_time),
> > +	    TP_ARGS(smc_id, elapsed_time),
> > +	    TP_STRUCT__entry(__field(unsigned long, smc_id)
> > +			     __field(u64, elapsed_time)
> > +	    ),
> > +	    TP_fast_assign(__entry->smc_id = smc_id;
> > +			   __entry->elapsed_time = elapsed_time;
> > +	    ),
> > +	    TP_printk("SMC ID: 0x%lx time taken to process : %llu ns",
> > +		      __entry->smc_id, __entry->elapsed_time) );
> > +
> > +#endif /* __SMCCC_TRACE_H */
> > +
> > +#undef TRACE_INCLUDE_PATH
> > +#define TRACE_INCLUDE_PATH .
> > +
> > +#undef TRACE_INCLUDE_FILE
> > +#define TRACE_INCLUDE_FILE smccc_trace
> > +
> > +#include <trace/define_trace.h>
> > diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h 
> > index 220c8c60e021..39588c3db486 100644
> > --- a/include/linux/arm-smccc.h
> > +++ b/include/linux/arm-smccc.h
> > @@ -358,7 +358,9 @@ asmlinkage void __arm_smccc_hvc(unsigned long a0, unsigned long a1,
> >  			unsigned long a5, unsigned long a6, unsigned long a7,
> >  			struct arm_smccc_res *res, struct arm_smccc_quirk *quirk);
> >  
> > -#define arm_smccc_smc(...) __arm_smccc_smc(__VA_ARGS__, NULL)
> > +void arm_smccc_smc(unsigned long a0, unsigned long a1, unsigned long a2,
> > +		   unsigned long a3, unsigned long a4, unsigned long a5,
> > +		   unsigned long a6, unsigned long a7, struct arm_smccc_res *res);
> >  
> >  #define arm_smccc_smc_quirk(...) __arm_smccc_smc(__VA_ARGS__)
> >  
> > diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c 
> > index 5579ead449f2..3a3bf2d674a3 100644
> > --- a/kernel/time/timekeeping.c
> > +++ b/kernel/time/timekeeping.c
> > @@ -192,6 +192,13 @@ static inline u64 tk_clock_read(const struct 
> > tk_read_base *tkr)  {
> >  	struct clocksource *clock = READ_ONCE(tkr->clock);
> >  
> > +	/* At the time of kernel booting some SMC calls are called before the
> > +	 * clock is initialized, in such cases it would lead to kernel crash.
> > +	 * To prevent kernel crash in such cases this check is included.
> > +	 */
> > +	if (unlikely(!clock))
> > +		return 0;
> > +
> >  	return clock->read(clock);
> >  }
> >  
> > --
> > 2.17.1
> > 
