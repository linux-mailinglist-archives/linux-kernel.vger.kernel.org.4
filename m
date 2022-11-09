Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2D4622786
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiKIJuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiKIJuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:50:52 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3091409F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 01:50:51 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id r3so20389247yba.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 01:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u1s0y43ZpuBvyMz8zkFJk/Bh36z/uSELIAuni6JBmQc=;
        b=JPd7ilXsPlRk4baOLUUijHuKIyTl3/LkY19HBwIEdcPGxVD7UWC0QfT+/h59P4GMXl
         /jMRH/n87zn90m4V+iDrQ+g6sDP9+P8g9XEjxvXDzMVzca7NMmSe7JVowTOeTX58xiWW
         wLAooVlLv/HAqv/eeKYp1NTlV1i9YJvebRNDje3qNHv1GZkzWcWYZb6hmAmIUEUfuaHZ
         fa3odSDQpoxob5fr+wgFLsFKqVKIDU/wEokhS3bkZYkuzBw2c6Zf+COJhtU6tO+sIBdi
         2KG0u0YgqDbUEwh+Jdn093/xNsg2t1AIdnRTiiSaJqsZ0VXNCCY540aXVlXwFoHUGa1u
         j4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u1s0y43ZpuBvyMz8zkFJk/Bh36z/uSELIAuni6JBmQc=;
        b=s6vh9jfH7zjeAsF2yKxUKLJJawU00W8xQCj9gImSGwB5kGMdAlLh2GeMbR/skBlrhi
         Ng7MdAZatjhAAEB5pDC/5Vnt5rR0M9jbsqsg1kM9rzzczSHU7SpBA87fHGK8GakL2lQH
         va5QDFavLsrQj5NV16flh0bCOnd0ZL/qlllRz+IJJC5eH5tyTq0/j72atFXQECNpVlPH
         k6uAmXnAaGcKoWJ/Vg9ikHcZXQ1eA6cgmMePCQk9Z9Gjjoef/KpI3QundnM0CNxR5rSc
         /BMrMaHkiIT2hGQ0IvfdomFQIlhL53ZujaqdXDRI8TCctrIwt/MWU0RMvsjaw6UpOibT
         6akQ==
X-Gm-Message-State: ACrzQf2OVNJiBpVvmXleYLYmzoohcvh/8YGHXX+KcuLKAmrHL7LzRMHW
        FB9EizEVgnacLMK0F8wO0t/4DVHpJVrS6RX1E4u8pw==
X-Google-Smtp-Source: AMsMyM6dkuMqghj0uHvukWdGg3PdhBt611a+v+y58uFqFWHNYeTTvF6FQvlSllfCNOxBqavxYJXF1yL0LTemQ3FuRps=
X-Received: by 2002:a05:6902:10ca:b0:671:3616:9147 with SMTP id
 w10-20020a05690210ca00b0067136169147mr56611236ybu.105.1667987450132; Wed, 09
 Nov 2022 01:50:50 -0800 (PST)
MIME-Version: 1.0
References: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
 <b2e020b1-f6b2-e236-a042-4eb2fd27d8b0@intel.com> <IA1PR11MB6097236CFF891041DBA42ECB9B5F9@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y0BhzKkksSjSeE3W@agluck-desk3.sc.intel.com> <81a7b4f6-fbb5-380e-532d-f2c1fc49b515@intel.com>
 <CALPaoCjdeRjyX5L6BBX688ZM21eMwetuL9QLF1+GEDUskGcU2w@mail.gmail.com>
 <76bb4dc9-ab7c-4cb6-d1bf-26436c88c6e2@arm.com> <CALPaoCiKUQC+LxDwKQ0gE5AQniJi_nbzrXi_HA9ZBRtiXdw_dg@mail.gmail.com>
 <835d769b-3662-7be5-dcdd-804cb1f3999a@arm.com> <09029c7a-489a-7054-1ab5-01fa879fb42f@intel.com>
 <f80299a4-7eaf-46a0-89e6-b9f5385f183c@arm.com> <c227a0df-7ac8-91f3-cada-0ca5ec047579@intel.com>
In-Reply-To: <c227a0df-7ac8-91f3-cada-0ca5ec047579@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Wed, 9 Nov 2022 10:50:38 +0100
Message-ID: <CALPaoCidd+WwGTyE3D74LhoL13ce+EvdTmOnyPrQN62j+zZ1fg@mail.gmail.com>
Subject: Re: [RFD] resctrl: reassigning a running container's CTRL_MON group
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Babu Moger <Babu.Moger@amd.com>,
        Gaurang Upasani <gupasani@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On Tue, Nov 8, 2022 at 10:28 PM Reinette Chatre
<reinette.chatre@intel.com> wrote:
> On 11/3/2022 10:06 AM, James Morse wrote:
> > That is true. MPAM has an additional headache here as it needs to allocate a monitor in
> > order to read the counters. If there are enough monitors for each CLOSID*RMID to have one,
> > then MPAM can export the counter files in the same way RDT does.
> >
> > While there are systems that have enough monitors, I don't think this is going to be the
> > norm. To allow systems that don't have a surfeit of monitors to use the counters, I plan
> > to export the values from resctrl_arch_rmid_read() via perf. (but only for bandwidth counters)
>
> This sounds related to the way monitoring was done in earlier kernels. This was
> long before I become involved with this work. Unfortunately I am not familiar with
> all the history involved that ended in it being removed from the kernel. Looks like
> this was around v4.6, here is a sample commit that may help point to what was done:

Sort of related, this is a problem we have to work around on AMD
implementations that I will be sharing a patch for soon.

Note the second paragraph at the top of page 13:

https://developer.amd.com/wp-content/resources/56375_1.00.pdf

AMD QoS often provides less counters than RMIDs, but the architecture
promises there will be at least as many counters in a QoS domain as
CPUs. Using this we can permanently pin RMIDs to CPUs and read the
counters on every task switch to implement MBM RMIDs in software.

This has the caveats that evictions while one task is running could have
resulted from a previous task on the current CPU, but will be counted
against the new task's software-RMID, and that CMT doesn't work.

I will propose making this available as a mount option for cloud container
use cases which need to monitor a large number of tasks on B/W counter-poor
systems, and of course don't need CMT.

> [...]
>
> > I think the solution to all this is:
> >  * Add rename support to move a monitor group between two control groups.
> >  ** On x86, this is guaranteed to preserve the RMID, so the destination counter continues
> > unaffected.
> >  ** On arm64, the PARTID is also relevant to the monitors, so the old counters will
> > continue to count.
>
> This looks like the solution to me also.
>
> The details of the arm64 support is not clear to me though. The destination
> group may not have enough PMG to host the new group so failures need to be
> handled. As you mention also, the old counters will continue to count.
> I assume that you mean the hardware will still have a record of the occupancy
> and that needs some time to dissipate? I assume this would fall under the
> limbo handling so in some scenarios (for example the just moved monitor
> group used the last PMG) it may take some time for the source control
> group to allow a new monitor group? The new counters will also not
> reflect the task's history.
>
> Moving an arm64  monitor group may thus have a few surprises for user
> space while sounding complex to support. Would adding all this additional
> support be worth it if the guidance to user space is to instead create many
> control groups in such a control-group-rich environment?
>
> > Whether this old counters keep counting needs exposing to user-space so that it is aware.
>
> Could you please elaborate? Do old counters not always keep counting?

Based on this, is it even worth it to allocate PMGs given that the
systems James has seen so far only have a single PMG bit? All this will
get us is the ability to create a single child mon_group in each control
group. This seems too limiting for the feature to be useful.

-Peter
