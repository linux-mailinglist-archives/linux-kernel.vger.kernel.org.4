Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F9E5FC442
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 13:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiJLLVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 07:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiJLLVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 07:21:14 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03F3BEFB2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 04:21:12 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-3573ed7cc15so152708087b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 04:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bgZEs8Ai8jmB4PtGsPZVSG6Q81sH974yw7tFMZN5UWg=;
        b=JkrgaWN32USp5UVlzD2Fsy/cdMndpq2ueF0NHA3hr4tk4zVdWTA4EaaWejHPEhngFk
         T38gbPspVmvtq8a6U8z8+AbAUoEAMeo+3rWLXcqjoRDYmBOZgvxhGWQbV7qhGh7bYxxP
         OUQ4fVOcm1KbwHmdmHeCU9W47/+z5BmxLm71J3fkmxIbEvxWy0bozRYaK4INSfdJG503
         NQ8QzhgsKB9FPi7lKeeZnOEDPm70R0TjjKR9lb2aPcY9lluQieuM7BsHthkLQh6b/qPf
         1ip7NsXUyj12pBonGYgZhHBAnf3VvzQU2bh5knI+aDPJiICyZ+WMyVzsHkgtQil6izhX
         F7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bgZEs8Ai8jmB4PtGsPZVSG6Q81sH974yw7tFMZN5UWg=;
        b=vjUXxvH1V9or2+11HPXXewu2ifKPqa7R26UcxnKIeBXFh7ABg7OEhVCJT0gJs5yVf1
         zAN0Vo3CCq82Kfnub899iP0+56iykDymjhWlxlTn8elTFWjmU2yh6+UsjITIX7aT1lf5
         glCRXk4fdgLp4OJP0OfmHa5uimNnVXDiloQZBxQBNZPalpmZrlck7XFep6NLi4jx2wrQ
         28x5NTJTGbCGLG1VCuNEC3Vzbcp3XjiKHK+11w6dbQ71X0L46n+h+x7/Few7hGWxQWle
         y/KVyRG3AoLJMFa/Rg6RThNzQcA/gIjXzmJTCPCVfXXf4qGZFaRWliZQuArjekBk8/Y/
         BbjQ==
X-Gm-Message-State: ACrzQf0bom+J9S22D6zx3aZz9knIHlrqG1ceWsqEqglGqPIfCFRGqOAj
        KxsZJUhn1R1Ja37+X+MnjFoliuliGwdTQu5HtEnJcg==
X-Google-Smtp-Source: AMsMyM4N5o9xgWzQ8lltc3Q7qX/13OQZfCZikV9ttLzhTZjaWVPFROc94RnrVJBnmEjS15U2x/UEwmhyAtPOF4jIIAY=
X-Received: by 2002:a81:4ccc:0:b0:360:811f:4b74 with SMTP id
 z195-20020a814ccc000000b00360811f4b74mr18745782ywa.398.1665573672034; Wed, 12
 Oct 2022 04:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
 <b2e020b1-f6b2-e236-a042-4eb2fd27d8b0@intel.com> <IA1PR11MB6097236CFF891041DBA42ECB9B5F9@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y0BhzKkksSjSeE3W@agluck-desk3.sc.intel.com> <81a7b4f6-fbb5-380e-532d-f2c1fc49b515@intel.com>
In-Reply-To: <81a7b4f6-fbb5-380e-532d-f2c1fc49b515@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Wed, 12 Oct 2022 13:21:00 +0200
Message-ID: <CALPaoCjdeRjyX5L6BBX688ZM21eMwetuL9QLF1+GEDUskGcU2w@mail.gmail.com>
Subject: Re: [RFD] resctrl: reassigning a running container's CTRL_MON group
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        James Morse <james.morse@arm.com>,
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

[Adding Gaurang to CC]

On Tue, Oct 11, 2022 at 1:35 AM Reinette Chatre
<reinette.chatre@intel.com> wrote:
>
> On 10/7/2022 10:28 AM, Tony Luck wrote:
> > I don't know how complex it would for the kernel to implement this. Or
> > whether it would meet Google's needs.
> >
>
> How about moving monitor groups from one control group to another?
>
> Based on the initial description I got the impression that there is
> already a monitor group for every container. (Please correct me if I am
> wrong). If this is the case then it may be possible to create an interface
> that could move an entire monitor group to another control group. This would
> keep the benefit of usage counts remaining intact, tasks get a new closid, but
> keep their rmid. There would be no need for the user to specify process-ids.

Yes, Stephane also pointed out the importance of maintaining RMID assignments
as well and I don't believe I put enough emphasis on it during my
original email.

We need to maintain accurate memory bandwidth usage counts on all
containers, so it's important to be able to maintain an RMID assignment
and its event counts across a CoS downgrade. The solutions Tony
suggested do solve the races in moving the tasks, but the container
would need to temporarily join the default MON group in the new CTRL_MON
group before it can be moved to its replacement MON group.

Being able to re-parent a MON group would allow us to change the CLOSID
independently of the RMID in a container and would address the issue.

The only other point I can think of to differentiate it from the
automatic CLOSID management solution is whether the 1:1 CTRL_MON:CLOSID
approach will become too limiting going forward. For example, if there
are configurations where one resource has far fewer CLOSIDs than others
and we want to start assigning CLOSIDs on-demand, per-resource to avoid
wasting other resources' available CLOSID spaces. If we can foresee this
becoming a concern, then automatic CLOSID management would be
inevitable.

-Peter


On Tue, Oct 11, 2022 at 1:35 AM Reinette Chatre
<reinette.chatre@intel.com> wrote:
>
> On 10/7/2022 10:28 AM, Tony Luck wrote:
> > On Fri, Oct 07, 2022 at 08:44:53AM -0700, Yu, Fenghua wrote:
> >> Hi, Peter,
> >>
> >>> On 10/7/2022 3:39 AM, Peter Newman wrote:
> >
> >>>> The CLOSID management rules would roughly be:
> >>>>
> >>>>  1. If an update would cause a CTRL_MON group's config to match that of
> >>>>     an existing group, the CTRL_MON group's CLOSID should change to that
> >>>>     of the existing group, where the definition of "match" is: all
> >>>>     control values match in all domains for all resources, as well as
> >>>>     the cpu masks matching.
> >
> > So the micro steps are:
> >
> > # mkdir newgroup
> >       # New groups are created with maximum resources. So this might
> >       # match the root/default group (if the root schemata had not
> >       # been edited) ... so you could re-use CLOSID=0 for this, or
> >       # perhaps allocate a new CLOSID
> > # edit newgroup/schemata
> >       # if this update makes this schemata match some other group,
> >       # then update the CLOSID for this group to be same as the other
> >       # group.
> >>>>
> >>>>  2. If an update to a CTRL_MON group sharing a CLOSID with another group
> >>>>     causes that group to no longer match any others, a new CLOSID must
> >>>>     be allocated.
> >       # So you have reference counts for CLOSIDs for how many groups
> >       # share it. In above example the change to the schemata and
> >       # alloction of a new CLOSID would decrement the reference count
> >       # and free the old CLOSID if it goes to zero
> >>>>
> >>>>  3. An update to a CTRL_MON group using a non-shared CLOSID which
> >>>>     continues to not match any others follows the current resctrl
> >>>>     behavior.
> >       # An update to a CTRL_MON group that has a CLOSID reference
> >       # count > 1 would try to allocate a new CLOSID if the new
> >       # schemata doesn't match any other group. If all CLOSIDs are
> >       # already in use, the write(2) to the schemata file must fail
> >       # ... maybe -ENOSPC is the right error code?
> >
> > Note that if the root/default CTRL_MON had been editted you might not be
> > able to create a new group (even though you intend to make to match some
> > existing group and share a CLOSID). Perhaps we could change existing
> > semantics so that new groups copy the root group schemata instead of
> > being maximally permissibe with all resources?
> >>>>
> >>>> Before I prepare any patches for review, I'm interested in any
> >>>> comments or suggestions on the use case and solution.
> >>>>
> >>>> Are there simpler strategies for reassigning a running container's
> >>>> tasks to a different CTRL_MON group that we should be considering first?
> >
> > Do tasks in a container share a "process group"? If they do, then a
> > simpler option would be some syntax to assign a group to a resctrl group
> > (perhaps as a negative task-id? or with a "G" prefix??).
> >
> > Or is there some other simple way to enumerate all the tasks in a
> > container with some syntax that is convenient for both the user and the
> > kernel? If there is, then add code to allow something like:
> >       # echo C{containername} > tasks
> > and have the resctrl code move all tasks en masse.
> >
> > Yet another option would be syntax to apply the move recursively to all
> > descendents of the given task id.
> >
> >       # echo R{process-id} > tasks
> >
> > I don't know how complex it would for the kernel to implement this. Or
> > whether it would meet Google's needs.
> >
>
> How about moving monitor groups from one control group to another?
>
> Based on the initial description I got the impression that there is
> already a monitor group for every container. (Please correct me if I am
> wrong). If this is the case then it may be possible to create an interface
> that could move an entire monitor group to another control group. This would
> keep the benefit of usage counts remaining intact, tasks get a new closid, but
> keep their rmid. There would be no need for the user to specify process-ids.
>
> Reinette
