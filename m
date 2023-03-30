Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA4D6D0731
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbjC3Noy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjC3Nop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:44:45 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF50AC171
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 06:44:12 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id bm1so5828550qkb.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 06:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680183849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PfvZy7pxed8fWtBqPRHS5PzCUQv8AEixyUGPRIZa+4=;
        b=pOQIgqJ2F4CKw9qMZs8c5+zxFPNLWrEFEr+VyjQF8852MDgK3OM0OwU0JRQsNYN9Kt
         SI0g1GIS+pF8fbT3DzT7yFCq/4g/zeZuPM515w8hzwl4NXEmR+dS34W8sgZrOC1sPV1L
         7khCFQcrBuHJRd4MtNgcnKgFLFH2TOm8qT2q0Ip2dldauDoHsfyIDeW4ezUnyBA55Gt1
         rvjhH6ltdDgHZSuYFZ3i7BMCM6OeHMSvfJ9V5G1syxlyxT+CxIPIlvw3iGOaFVSJjaHd
         sk+nh4UpOiOesoxerU6xKYt/2LMRd0mjnpf23So4JLIm6RfJVWFmbrl7gLxgWWnX8soj
         8CpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680183849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/PfvZy7pxed8fWtBqPRHS5PzCUQv8AEixyUGPRIZa+4=;
        b=hOPSFy4SsLqi1WlsCemfkB3jT1mh9Y/FBmC5wLg/gMqQBvKDSKO1qWBXxcUtRXiGCh
         WAhAdsOOuuT26mfRtINl04y7uT1VkQI7Oo6GSJp5wcs4MK0wLRndmOWVQhT12Lsrn+Ph
         n9Gg7BT1iDYWJU6ZB5j0cTDXWEz0lIiScUxx4H6uW2xgc0oClADxFU5lyBPm5gJrnEC7
         LWn0Ev/Jac1IOVJGUy7Y5RcjBDdTn67QmC6tGNb8XtPfMVajbN9kl2E5PamkeWzzp5I8
         hdH2fDR5Hzre6+pDoBsCW3TfUkW29sEEjTT7MdEUAlYIafpvOyREra+ZFY3OoCSLgTtX
         wwQw==
X-Gm-Message-State: AO0yUKVqFsVrUfC8T9q0d8w0IngoLum5s3kXbnNNW/lU7y0CNOyJWmAl
        y4YA8uIB4InGLQ4rqPpxx0sZfOHdXrSj3Uvqk7pb5g==
X-Google-Smtp-Source: AK7set9lagn/Jkqr7CB5UXonYmlnRDhxB1Yzrjnw48CtRPj+Y5MI4/lsXG5ocrLtznH4C0TPI/2bOZUUTLeb2E7camU=
X-Received: by 2002:a37:6552:0:b0:746:9411:4c18 with SMTP id
 z79-20020a376552000000b0074694114c18mr5711321qkb.5.1680183848790; Thu, 30 Mar
 2023 06:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230308131452.383914-1-peternewman@google.com>
 <20230308131452.383914-4-peternewman@google.com> <4a276e2d-9f56-437d-8284-c95def0d2487@intel.com>
In-Reply-To: <4a276e2d-9f56-437d-8284-c95def0d2487@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Thu, 30 Mar 2023 15:43:57 +0200
Message-ID: <CALPaoCgiFCG8FcBS5Svj63oeqbmARByCGh9ox-ZPUY-6gkBMqg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] x86/resctrl: Implement rename op for mon groups
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     fenghua.yu@intel.com, Babu.Moger@amd.com, bp@alien8.de,
        dave.hansen@linux.intel.com, eranian@google.com,
        gupasani@google.com, hpa@zytor.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, skodak@google.com,
        tglx@linutronix.de, tony.luck@intel.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On Thu, Mar 23, 2023 at 7:08=E2=80=AFPM Reinette Chatre
<reinette.chatre@intel.com> wrote:
> On 3/8/2023 5:14 AM, Peter Newman wrote:
> > application container, a container manager must write all of the tasks'
> > IDs into the tasks file interface of the new control group.
> >
> > If a container manager is tracking containers' bandwidth usage by
>
> "is tracking" -> "is additionally"

That doesn't sound right. Did you mean "is additionally tracking"?


> > +     WARN_ON(list_empty(&prdtgrp->mon.crdtgrp_list));
> > +     list_del(&rdtgrp->mon.crdtgrp_list);
> > +
> > +     list_add_tail(&rdtgrp->mon.crdtgrp_list,
> > +                   &new_prdtgrp->mon.crdtgrp_list);
>
> Could list_move_tail() be used here?

Yes

>
> > +     rdtgrp->mon.parent =3D new_prdtgrp;
> > +     rdtgrp->closid =3D new_prdtgrp->closid;
> > +
> > +     /* Propagate updated closid to all tasks in this group. */
> > +     rdt_move_group_tasks(rdtgrp, rdtgrp, cpus, mongrp_reparent_match)=
;
> > +
> > +     update_closid_rmid(cpus, NULL);
> > +}
> > +
> > +static int rdtgroup_rename(struct kernfs_node *kn,
> > +                        struct kernfs_node *new_parent, const char *ne=
w_name)
> > +{
> > +     struct rdtgroup *new_prdtgrp;
> > +     struct rdtgroup *rdtgrp;
> > +     cpumask_var_t tmpmask;
> > +     int ret;
> > +
> > +     /*
> > +      * Don't allow kernfs_to_rdtgroup() to return a parent rdtgroup i=
f
> > +      * either kernfs_node is a file.
> > +      */
> > +     if (kernfs_type(kn) !=3D KERNFS_DIR ||
> > +         kernfs_type(new_parent) !=3D KERNFS_DIR)
> > +             return -EPERM;
>
> This would be one scenario where the user may attempt an interaction
> with resctrl that results in an error while peeking at "last_cmd_status"
> will report "ok". This is not the only case in which this may happen and
> I think the code is ok. To help users to not need to read the kernel code
> to understand what is going on, could a snippet about this feature be add=
ed
> to the "Resource alloc and monitor groups" section in
> Documentation/x86/rescrl.rst. It does not have to be elaborate
> but in the area where directory removal is discussed there could be
> a snippet that documents this new feature.

I only skipped the last_cmd_status update here because it was before
obtaining the lock. Even though it doesn't need the lock for this check,
I don't see anything wrong moving it until after the lock has been
obtained.

I'll also add some documentation.


> > +
> > +     if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL))
> > +             return -ENOMEM;
>
> It remains strange to do the allocation here. I understand its usage so m=
aybe
> just a comment like: "Perform early allocation as part
> of ensuring the later resource group move cannot fail."

I think the other reason I put it so early was so all the other error
exits could free it unconditionally. The other clean approach is
allocating it last before calling kernfs_rename(). That should be easier
to follow.

I will try to address all of your other comments.

Thanks again for your review!

-Peter
