Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B336B65CD54
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 07:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbjADGrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 01:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbjADGqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 01:46:13 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84170F0E
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 22:45:50 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id z23so7354023uae.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 22:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1cYXRnEX2XHaP5qR/jOT1RuwIpLEmZXRxNKf56qiFgY=;
        b=gRaIFeu5rzclTGBTdF0XScqmh2GfLllahCqEDJ2R4St6OTVrvktkD9GE2XkIY4/PAO
         WJ415lPWCbOcw9vZz7HJ8a5BkqOu4Uo57L4wcYGs7VAL3KWtQMNQwxyHlQOmTdwd/hS8
         cT7uu2E51NGDuB41+60UQ2edqRSOXkctsodZuB/nJK0k72wBYFTQru6tt+oW3xT1GEzS
         7BCBbVCjWLbmGlToHTY9x5+Rx2rA0SoCK0668AcdGjp8Boak76WkuQ3w1ccr2wxVkoiU
         toT5nK1Ji4ok5XoTv6sXAP4SKd8aWXh8UmSWkSEXAoZgpS7T2HSOcFhQ9l2INOqig3vH
         vJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1cYXRnEX2XHaP5qR/jOT1RuwIpLEmZXRxNKf56qiFgY=;
        b=YhnqlPq0WNlnKiP5AS9m8X4zh2rQMQWJQN4BfD6IK/rsuo9B4PMGGaXOiVfyYkWa+U
         50HisiUWYEoTm8RpyEzMG/hP1DSa1Tv9zwCgiN+X//fXngfPm/fC5A2FcqqKc7jj6ATu
         SV/vYdSIv3da821z509YZW/K5BAnd+9j32vUDqR+aJXzJ4zrf7Ox27Qz5H/jpr0OHFR8
         2CuqtAkZgbPko/tv7l3zg2fIJuoL+FwS0UpGDMGZWRduMh9EklBRNkSxUnTH12vQEWZY
         5leouNVqbj8SzeDgsShaV4B+Mm1ZSzjAQdrC9TtiPK4spMxAVIsB7JS+GhlgMyNh7AID
         HJtA==
X-Gm-Message-State: AFqh2kpIN2WUS2cA0/XZQYEw6Jd6f06ykJtzKslAa6GHZuW+7xGDURCb
        +GPjdudtF4+xhY49fVopCIUxfEVLRV4fo+Up6tRuag==
X-Google-Smtp-Source: AMrXdXsruQQ6def5iRlPkRzuNDr8C1FP2H9ogTFk7HSy28yE3GQUPm1lkLkD26hPFxRjDmdh5F4bVEDMzG72JOyB/kA=
X-Received: by 2002:ab0:6658:0:b0:4c9:9285:8b47 with SMTP id
 b24-20020ab06658000000b004c992858b47mr3660711uaq.23.1672814749275; Tue, 03
 Jan 2023 22:45:49 -0800 (PST)
MIME-Version: 1.0
References: <167278351577.34228.12803395505584557101.stgit@bmoger-ubuntu>
 <167278361325.34228.16916982678071203069.stgit@bmoger-ubuntu> <IA1PR11MB609764AC3E09E0A1F8A8FF7E9BF59@IA1PR11MB6097.namprd11.prod.outlook.com>
In-Reply-To: <IA1PR11MB609764AC3E09E0A1F8A8FF7E9BF59@IA1PR11MB6097.namprd11.prod.outlook.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 3 Jan 2023 22:45:37 -0800
Message-ID: <CABPqkBSoO3XoWGbk-HgxPsAfs7hUF+EjoUsu5qXtakjkT9QpWQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] x86/resctrl: Display the RMID and COSID for
 resctrl groups
To:     "Yu, Fenghua" <fenghua.yu@intel.com>
Cc:     Babu Moger <babu.moger@amd.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "peternewman@google.com" <peternewman@google.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
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

On Tue, Jan 3, 2023 at 10:06 PM Yu, Fenghua <fenghua.yu@intel.com> wrote:
>
> Hi, Babu,
>
> > When a user creates a control or monitor group, the CLOSID or RMID are not
> > visible to the user. These are architecturally defined entities.
> > There is no harm in displaying these in resctrl groups. Sometimes it can help to
> > debug the issues.
> Although "no harm" to show them, it's not useful for generic user either and may
> cause confusion sometimes. CLOSID and RMID are supposed to be invisible to
> generic users.
>
> Maybe introduce a new resctrl mount option called "debug" and show the files
> and maybe other future debug info only in debug mode?
>
On other non-x86 architectures, these have no meaning or no direct mapping.
Take ARM MPAM, it is called PARTID and it does not map to either RMID
or CLOSID, it is combined.
Why would you call this closid/rmid at the user level?
You could instead use a more generic name such as mon_hw_id,
ctrl_hw_id. And on ARM they would be the same.
Just my suggestion.


>
> >
> > Add CLOSID and RMID to the control/monitor groups display in resctrl interface.
> >
> >   $cat /sys/fs/resctrl/clos1/closid
> >   1
> >   $cat /sys/fs/resctrl/mon_groups/mon1/rmid
> >   3
> >
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > ---
> >  Documentation/x86/resctrl.rst          |   15 ++++++++++
> >  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   46
> > ++++++++++++++++++++++++++++++++
> >  2 files changed, 61 insertions(+)
> >
> > diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
> > index f26e16412bcb..8520514bc8b5 100644
> > --- a/Documentation/x86/resctrl.rst
> > +++ b/Documentation/x86/resctrl.rst
> > @@ -231,6 +231,14 @@ All groups contain the following files:
> >       Just like "cpus", only using ranges of CPUs instead of bitmasks.
> >
> >
> > +"rmid":
> > +     Reading this file shows the resource monitoring id (RMID) for
> > +     monitoring the resource utilization. Monitoring is performed by
> > +     tagging each core(or thread) or process via a Resource Monitoring
> > +     ID (RMID). Kernel assigns a new RMID when a group is created
> > +     depending on the available RMIDs. Multiple cores(or threads) or
> > +     processes can share a same RMID in a resctrl domain.
> > +
> >  When control is enabled all CTRL_MON groups will also contain:
> >
> >  "schemata":
> > @@ -252,6 +260,13 @@ When control is enabled all CTRL_MON groups will
> > also contain:
> >       file. On successful pseudo-locked region creation the mode will
> >       automatically change to "pseudo-locked".
> >
> > +"closid":
> > +     Reading this file shows the Class of Service (CLOS) id which acts
> > +     as a resource control tag on which the resources can be throttled.
> > +     Kernel assigns a new CLOSID a control group is created depending
> > +     on the available CLOSIDs. Multiple cores(or threads) or processes
> > +     can share a same CLOSID in a resctrl domain.
> > +
> >  When monitoring is enabled all MON groups will also contain:
> >
> >  "mon_data":
> > diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > index 0d71ed22cfa9..98b4798e5cae 100644
> > --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > @@ -769,6 +769,38 @@ static int rdtgroup_tasks_show(struct kernfs_open_file
> > *of,
> >       return ret;
> >  }
> >
> > +static int rdtgroup_closid_show(struct kernfs_open_file *of,
> > +                             struct seq_file *s, void *v)
> > +{
> > +     struct rdtgroup *rdtgrp;
> > +     int ret = 0;
> > +
> > +     rdtgrp = rdtgroup_kn_lock_live(of->kn);
> > +     if (rdtgrp)
> > +             seq_printf(s, "%u\n", rdtgrp->closid);
> > +     else
> > +             ret = -ENOENT;
> > +     rdtgroup_kn_unlock(of->kn);
> > +
> > +     return ret;
> > +}
> > +
> > +static int rdtgroup_rmid_show(struct kernfs_open_file *of,
> > +                           struct seq_file *s, void *v)
> > +{
> > +     struct rdtgroup *rdtgrp;
> > +     int ret = 0;
> > +
> > +     rdtgrp = rdtgroup_kn_lock_live(of->kn);
> > +     if (rdtgrp)
> > +             seq_printf(s, "%u\n", rdtgrp->mon.rmid);
> > +     else
> > +             ret = -ENOENT;
> > +     rdtgroup_kn_unlock(of->kn);
> > +
> > +     return ret;
> > +}
> > +
> >  #ifdef CONFIG_PROC_CPU_RESCTRL
> >
> >  /*
> > @@ -1593,6 +1625,20 @@ static struct rftype res_common_files[] = {
> >               .seq_show       = rdtgroup_size_show,
> >               .fflags         = RF_CTRL_BASE,
> >       },
> > +     {
> > +             .name           = "closid",
> > +             .mode           = 0444,
> > +             .kf_ops         = &rdtgroup_kf_single_ops,
> > +             .seq_show       = rdtgroup_closid_show,
> > +             .fflags         = RF_CTRL_BASE,
> > +     },
> > +     {
> > +             .name           = "rmid",
> > +             .mode           = 0444,
> > +             .kf_ops         = &rdtgroup_kf_single_ops,
> > +             .seq_show       = rdtgroup_rmid_show,
> > +             .fflags         = RFTYPE_BASE,
> > +     },
> >
> >  };
> >
> >
> Thanks.
>
> -Fenghua
