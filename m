Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81AE162BF46
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbiKPNUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbiKPNUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:20:32 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FDD27FF7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:20:31 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-367b8adf788so167186747b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 05:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vxKHoXY+iMzMLFmzEA3zKKda4HHbNhaI8yIydro4NOQ=;
        b=lhFPWDuRoDRCeijubbdr/Y9pvTp9yAsFihpcTQlnUEYTDf8vu6z8gYbHkTM7meeaH/
         7EMbbRuywzmQE/nT/gLSGWv0kgd/YWRH9teiIlKWBMMYbWgTcBg0Hocg3GAym/msyvxc
         C9OZ4q55GJIH/324+/gJNnbYsEfTEo5/ut5ehVJvbw9u2l+FfFkSQ5h+5hmIkie7VeqQ
         912s3/1G/1qN/MalciigbCPrPAm4aPxxr9n80jtc95Upjj3V4KaNOwemtfk66ZNrHgxK
         y5CEhvDJhmnu7C/Ib9uvnLsbPf3ZE0cfB6qAGpPVNIHZJxOclz4f7tYq/pmC+RNTxip1
         t3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vxKHoXY+iMzMLFmzEA3zKKda4HHbNhaI8yIydro4NOQ=;
        b=reR2/6PB7X24cSOanh+0ImzkZTu250L6r8lsChkbo1UpQL/yVasXw6Q0XWvPudYZXp
         gf8zjMtiK0qDM12bo1qpNupZeVHOUqfP1AX66OELuCz28Dz4qvk09QHJBhjiidbilK66
         NNR7fEwMzb1wBDd+2RGNBAXNc3I2o1MNz4SRz/o5x4Om7VFzhFcxIvfW/AChSTbgw581
         b9XghEMmOC7WjdGXJwkd1eqCWh0RHhV9bBOdWczu2s021odB2BWjupjZN4tHujTUgsCz
         yGqWCvqW82/mCliFnkhxZe5ORcieJTnybUVZC4MivGtvWpczDBfdnSyZLe5AdXgZfv4G
         zCyA==
X-Gm-Message-State: ANoB5pnGYgaWTDwvK7CivLYCtCIu6YkJW08NLc1xMXZ+X6jUp6whR3G8
        jPOWvESSNkGuoO1CZp8XWf3o5vhd84CG+/hEByT8PQ==
X-Google-Smtp-Source: AA0mqf7fxhZX2Ti4VYrXYUNql55200Xi4FUdmmZSj+5XeSmW8WdRRiZEAc2N8Mc/qQYApnU5S48ByzdhifO2l9mfc5E=
X-Received: by 2002:a05:690c:29e:b0:38b:fa10:cc71 with SMTP id
 bf30-20020a05690c029e00b0038bfa10cc71mr1519614ywb.185.1668604830743; Wed, 16
 Nov 2022 05:20:30 -0800 (PST)
MIME-Version: 1.0
References: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
 <b2e020b1-f6b2-e236-a042-4eb2fd27d8b0@intel.com> <IA1PR11MB6097236CFF891041DBA42ECB9B5F9@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y0BhzKkksSjSeE3W@agluck-desk3.sc.intel.com> <81a7b4f6-fbb5-380e-532d-f2c1fc49b515@intel.com>
 <CALPaoCjdeRjyX5L6BBX688ZM21eMwetuL9QLF1+GEDUskGcU2w@mail.gmail.com>
 <76bb4dc9-ab7c-4cb6-d1bf-26436c88c6e2@arm.com> <CALPaoCiKUQC+LxDwKQ0gE5AQniJi_nbzrXi_HA9ZBRtiXdw_dg@mail.gmail.com>
 <835d769b-3662-7be5-dcdd-804cb1f3999a@arm.com> <09029c7a-489a-7054-1ab5-01fa879fb42f@intel.com>
 <f80299a4-7eaf-46a0-89e6-b9f5385f183c@arm.com> <c227a0df-7ac8-91f3-cada-0ca5ec047579@intel.com>
 <CALPaoCidd+WwGTyE3D74LhoL13ce+EvdTmOnyPrQN62j+zZ1fg@mail.gmail.com>
 <bd52ec90-52e4-32c5-132a-5d82304650a4@intel.com> <39fe80dc-713d-9ed2-a5aa-5c84376917f3@arm.com>
In-Reply-To: <39fe80dc-713d-9ed2-a5aa-5c84376917f3@arm.com>
From:   Peter Newman <peternewman@google.com>
Date:   Wed, 16 Nov 2022 14:20:19 +0100
Message-ID: <CALPaoChyyi2DSWWHPT4vaj4e1Fb=CrsRpaaWqy9nrj6EXRM_Ug@mail.gmail.com>
Subject: Re: [RFD] resctrl: reassigning a running container's CTRL_MON group
To:     James Morse <james.morse@arm.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Tony Luck <tony.luck@intel.com>,
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

Hi James,

On Fri, Nov 11, 2022 at 7:38 PM James Morse <james.morse@arm.com> wrote:
> On 09/11/2022 19:11, Reinette Chatre wrote:
> > On 11/9/2022 1:50 AM, Peter Newman wrote:
> >> Using this we can permanently pin RMIDs to CPUs and read the
> >> counters on every task switch to implement MBM RMIDs in software.
>
> >> This has the caveats that evictions while one task is running could have
> >> resulted from a previous task on the current CPU, but will be counted
> >> against the new task's software-RMID, and that CMT doesn't work.
>
> (Sounds like the best thing to do in a bad situation)
>
>
> >> I will propose making this available as a mount option for cloud container
> >> use cases which need to monitor a large number of tasks on B/W counter-poor
> >> systems, and of course don't need CMT.
>
> Why does it need to be a mount option?
>
> If this is the only way of using the counters on this platform, then the skid from the
> counters is just a property of the platform. It can be advertised to user-space via some
> file in 'info'.

No, it's not the only way of using the counters. The limitation is much
more problematic for users who monitor all tasks all the time. RMIDs
would be more likely to remain in use on systems that only monitor
select tasks, so they should be able to benefit from skid-free bandwidth
counts and CMT, so I think the proposed mode should be opt-in.


> Architecture specific mount options are a bad idea, platform specific ones are even worse!

It is already the case today in resctrlfs that the platform's features
will determine which mount options are available to the user. I believe
the same implementation would work on Intel platforms, but it would just
be silly to enable when these platforms have enough counters to back all
their RMIDs.

Also I believe it's fine for this option to be missing on MPAM until
someone is interested in paying the tradeoffs to monitor more groups and
is motivated enough to implement it.

-Peter
