Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358FB71303A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 01:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236228AbjEZXGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 19:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjEZXGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 19:06:38 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99928E7
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 16:06:37 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f600a6a890so20585e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 16:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685142396; x=1687734396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQm0gmotPrah6x+grG9q4OwSJysvwUdj8gXMKuWCdC8=;
        b=Q/jeqBLx2J/pmYWRuG8DRiq1d8Wnn+iVLM44EqcKVz4zP/T0Us/rC1FdxCXp3t7wFQ
         o/Biuo7udMF5wyV1Y/QwHmjFJcb6vy/F7nXA6i1B8TeeWpDthMiE+NMeVWnbOJ1tB3My
         GgeU81N4jI5Q4vaJu53zvWCfSQQGeNFHzXIAgcFTei5U8gjEgmbKtYP5Yt9nxbS/REwr
         sq2rrxfrQ7MAU1fdVVMNGBMzkYrQGNP2WSQD3i2Lxo0gpxef/W08iFQsBH2NO6QmHwXk
         y3fHFFJ2rxwE28Ht3aOVut3cbfXV7BwAH4ItLxeNzD/VexRhqCWuatvSHbE55BGBevp4
         xbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685142396; x=1687734396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQm0gmotPrah6x+grG9q4OwSJysvwUdj8gXMKuWCdC8=;
        b=cpkk0fXUNqUAzZICytGGbzizdYeUc7Ru8cYtqlNEjhlCnb+yad6ubafAPqpRE4f85S
         aNyiFowqWsvRXSUhAUJZtMlFZCKpQ0o1m6IVQO9j96cchqz5eL/xTfoahZG0ZpLi6HLW
         F32GpoWSpNAe5NI3zvJ+qZUum01bv4yEnLHCLpfy8n6ta1UvXjOBfhbB0PB0mILDCv2B
         Urg8gavkY3sTW6BnHuzECShiM2LHWsVwOkKkEFWDgOQ5Y0FUN1iKYraTmPrOGMBQ9IFX
         LV0wAAYAxN9x9GVPBVNi4IJ4+gKkOvl2jWTRqRaLid1v/oT1VO1u4698zmn/auugCEeD
         Ex4Q==
X-Gm-Message-State: AC+VfDxCeLkiHv5s8CCj1V8MRfvPUSvNMZvTX25nZTGRMH3LHiBr/kPo
        i1xVU4IH4Vu1jgfw9uGhXIulIpFSdq5bvPith8sFYsW/8sF4VxzAeozg6/HV
X-Google-Smtp-Source: ACHHUZ7a8zznLZd4lC0AduIo/JFkybDmh4b51Aye1LX/4ZElq5Y8xpY1F0uk+ktmYVc2ax/VATPKbTUA5Vr7GtECDXw=
X-Received: by 2002:a05:600c:3b8d:b0:3f1:9396:6fbf with SMTP id
 n13-20020a05600c3b8d00b003f193966fbfmr67517wms.4.1685142060245; Fri, 26 May
 2023 16:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230504110003.2548-1-ravi.bangoria@amd.com> <20230504110003.2548-4-ravi.bangoria@amd.com>
 <20230524214133.GA2359762@dev-arch.thelio-3990X> <f02c78e2-34b9-4985-640a-279dae1004a9@amd.com>
 <ZG8KLbZSECiYaKFc@linux.dev> <20230525142031.GU83892@hirez.programming.kicks-ass.net>
 <ZG+FLdP2kkfI1m2Z@linux.dev>
In-Reply-To: <ZG+FLdP2kkfI1m2Z@linux.dev>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 26 May 2023 16:00:47 -0700
Message-ID: <CAP-5=fWYbzmTETgqJ11y22=JaXDM0gnb4qR6KYeRGmFXw08f-Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] perf/core: Remove pmu linear searching code
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Nathan Chancellor <nathan@kernel.org>, namhyung@kernel.org,
        eranian@google.com, acme@kernel.org, mark.rutland@arm.com,
        jolsa@kernel.org, bp@alien8.de, kan.liang@linux.intel.com,
        adrian.hunter@intel.com, maddy@linux.ibm.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com, maz@kernel.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 8:56=E2=80=AFAM Oliver Upton <oliver.upton@linux.de=
v> wrote:
>
> On Thu, May 25, 2023 at 04:20:31PM +0200, Peter Zijlstra wrote:
> > On Thu, May 25, 2023 at 07:11:41AM +0000, Oliver Upton wrote:
> >
> > > The PMUv3 driver does pass a name, but it relies on getting back an
> > > allocated pmu id as @type is -1 in the call to perf_pmu_register().
> > >
> > > What actually broke is how KVM probes for a default core PMU to use f=
or
> > > a guest. kvm_pmu_probe_armpmu() creates a counter w/ PERF_TYPE_RAW an=
d
> > > reads the pmu from the returned perf_event. The linear search had the
> > > effect of eventually stumbling on the correct core PMU and succeeding=
.
> > >
> > > Perf folks: is this WAI for heterogenous systems?
> >
> > TBH, I'm not sure. hetero and virt don't mix very well AFAIK and I'm no=
t
> > sure what ARM64 does here.
> >
> > IIRC the only way is to hard affine things; that is, force vCPU of
> > 'type' to the pCPU mask of 'type' CPUs.
>
> We provide absolutely no illusion of consistency across implementations.
> Userspace can select the PMU type, and then it is a userspace problem
> affining vCPUs to the right pCPUs.
>
> And if they get that wrong, we just bail and refuse to run the vCPU.
>
> > If you don't do that; or let userspace 'override' that, things go
> > sideways *real* fast.
>
> Oh yeah, and I wish PMUs were the only problem with these hetero
> systems...

Just to add some context from what I understand. There are inbuilt
type numbers for PMUs:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/include=
/uapi/linux/perf_event.h?h=3Dperf-tools-next#n34
so the PMU generally called /sys/devices/cpu should have type 4 (ARM
give it another name). For heterogeneous ARM there is a single PMU and
the same events are programmed regardless of whether it is a big or a
little core - the cpumask lists all CPUs. On heterogeneous (aka
hybrid) Intel there are two PMUs, the performance cores have a PMU
called /sys/devices/cpu_core and it has type 4, the atom cores have a
PMU of /sys/devices/cpu_atom and on my Alderlake the type number is 8.
The cpu_core and cpu_atom PMUs list the CPUs that are valid for raw
style events, where the config values in perf_event_attr contains all
of the event programming data. There are also legacy events of
PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE where to specify the PMU the
type is encoded in the high (and unused) 32-bits of config - so the
type would be something like PERF_TYPE_HARDWARE and then config would
be "value | (4 << 32)" for the performance core or "value | (8 << 32)"
for the atom.

If the vCPU and pCPUs mappings vary then there is a chance to change
the CPU mask on heterogeneous Intel, but it seems if the event is open
and you move from between core types then things are going to break.

Thanks,
Ian

> > Mark gonna have to look at this.
>
> Cool. I'll go ahead with the KVM cleanup regardless of the outcome.
>
> --
> Thanks,
> Oliver
