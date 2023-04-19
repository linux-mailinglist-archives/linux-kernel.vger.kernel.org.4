Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B906E767E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 11:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjDSJjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 05:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjDSJjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:39:05 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8E5106
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 02:39:03 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-3ef34c49cb9so457861cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 02:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681897143; x=1684489143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x66QzDZ9/BUdWw72YlPvhWLdY9LAQaHM++rc6k3qv3A=;
        b=OR/s+xskjH5uUgZDXygguLsq2rxs8F4EKlVMajXm+3MbtFEcDvYFoC0HLWe+BQbJim
         OKnNoDCxfG1i6M1taxHV6GCXBDoUBelGRXmCh1CCi6HbCSFp+AemvTYMMPWp46giyI2V
         9M+L7oRV1zK4XhTBd27GRYiBn+6vxVnlZ7vlIXFxVXN6olxwuK7BNvvInZNmYoA99vQ7
         vRg7cItczdxDc3NV+/YCpJEaxIXlX7rtWIy4A00yP4y0xPlyBOSvdPh4hdILOPWhav1n
         +E11SKvbhTjn+9SWdp0YFwoZ9MaaTjLkJfY22mtYcKuzWHfAdEjNgwew99Tp7uSUwITP
         Iptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681897143; x=1684489143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x66QzDZ9/BUdWw72YlPvhWLdY9LAQaHM++rc6k3qv3A=;
        b=PmApvtFmYR4KeqMXOXDXfNGhQpQShSJ9niDNI4FPfxKhMRS2jsNyXLlf1k80d2/GhS
         HnEjXiJbRkvSB9tVRO974OJbCijhzSerqZmAQapU8sOjARKdSguY0Yb8kIC6i/Nqhvkz
         7jPipnccrDMlVUgxiP6akeUPV2FoNluajJFWMTPSfMOZmJMY0Ey7ADKtuh3Oi7oRVruG
         lf6JpBLVOv4y7EZN8AHn1992MxHSMc7p7JDMAqmdvdt1tSDp5J8oV88K+IkMWaYzaq9Z
         6rwp3TzOu6Ej55l8Pp04qTt9cE/nRIeOP1/DmXtwXcnN3Ze7fV9y/GE+SJnmW9UgAgOy
         9Q8w==
X-Gm-Message-State: AAQBX9c2GXdWQ131o+t0wrKxJJ6hbn9iNdiqVwx8sS8FNaBVyC6OLBwn
        WyiYG0gFbVmNCBG9mnVe2ZA7gESftU1Y69h03QVq9w==
X-Google-Smtp-Source: AKy350atobIgPY07pWA5UmBQeBXxEn42dGUxi+e0J2OFNQbV+hR8NlHwTIHL2N6fb2o1OGJdpiaw6iw6MflMQQoYpeo=
X-Received: by 2002:a05:622a:1a19:b0:3ef:3cac:c464 with SMTP id
 f25-20020a05622a1a1900b003ef3cacc464mr343772qtb.8.1681897143041; Wed, 19 Apr
 2023 02:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230330135558.1019658-1-peternewman@google.com>
 <20230330135558.1019658-3-peternewman@google.com> <678ab8b6-9465-cdeb-da65-448c0cf075f5@intel.com>
In-Reply-To: <678ab8b6-9465-cdeb-da65-448c0cf075f5@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Wed, 19 Apr 2023 11:38:52 +0200
Message-ID: <CALPaoCh=1Qq5sqWpY8We8zykmmvk81YVnigtZftqMH6FefnQjw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] x86/resctrl: Implement rename op for mon groups
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     fenghua.yu@intel.com, Babu.Moger@amd.com, bp@alien8.de,
        dave.hansen@linux.intel.com, eranian@google.com,
        gupasani@google.com, hpa@zytor.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, skodak@google.com,
        tglx@linutronix.de, tony.luck@intel.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On Tue, Apr 18, 2023 at 11:53=E2=80=AFPM Reinette Chatre
<reinette.chatre@intel.com> wrote:
> On 3/30/2023 6:55 AM, Peter Newman wrote:
> > If a container manager is additionally tracking containers' bandwidth
> > usage by placing tasks from each into their own monitoring group, it
>
> The above sentence seems to be missing something after the "for each".
> It seems to still parse if "for each" is removed.

Did you mean "from each"? In any case, I'll further disambiguate to
this in my next update:

"If the container manager is using monitoring groups to separately
track the bandwidth of containers assigned to the same control group,
it must first move the container's tasks to the default monitoring
group of the new control group before it can move these tasks into the
container's replacement monitoring groups under the destination
control group."

> > +     /*
> > +      * Don't allow kernfs_to_rdtgroup() to return a parent rdtgroup i=
f
> > +      * either kernfs_node is a file.
> > +      */
> > +     if (kernfs_type(kn) !=3D KERNFS_DIR ||
> > +         kernfs_type(new_parent) !=3D KERNFS_DIR) {
> > +             rdt_last_cmd_puts("Source and destination must be group d=
irectories");
>
> I do not think it is obvious what a "group directory" is. The source must=
 be a
> monitoring group and the destination must be the "mon_groups" directory. =
Maybe
> the "group" term can just be dropped to read "Source and destination must=
 be
> directories" (which is exactly what is tested for).

Sounds good.

>
> > +             ret =3D -EPERM;
> > +             goto out;
> > +     }
> > +
> > +     if ((rdtgrp->flags & RDT_DELETED) || (new_prdtgrp->flags & RDT_DE=
LETED)) {
> > +             ret =3D -ENOENT;
> > +             goto out;
> > +     }
> > +
> > +     if (rdtgrp->type !=3D RDTMON_GROUP || !kn->parent ||
> > +         !is_mon_groups(kn->parent, kn->name)) {
> > +             rdt_last_cmd_puts("Source must be a MON group\n");
> > +             ret =3D -EPERM;
> > +             goto out;
> > +     }
> > +
> > +     if (!is_mon_groups(new_parent, new_name)) {
> > +             rdt_last_cmd_puts("Destination must be a mon_groups subdi=
rectory\n");
> > +             ret =3D -EPERM;
> > +             goto out;
> > +     }
> > +
>
> Thanks. I think using these terms ("MON" and "mon_groups") in the error m=
essages
> are useful since it gives the user something to search for in the documen=
tation.
>
> > +     /*
> > +      * If the MON group is monitoring CPUs, the CPUs must be assigned=
 to the
> > +      * current parent CTRL_MON group and therefore cannot be assigned=
 to
> > +      * the new parent, making the move illegal.
> > +      */
> > +     if (!cpumask_empty(&rdtgrp->cpu_mask) &&
> > +         (rdtgrp->mon.parent !=3D new_prdtgrp)) {
>
> You can remove the extra parentheses so that this patch can get a clean s=
late
> from "checkpatch.pl --strict" done as this work moves to the next level.

Ok

>
> Thank you very much.
>
> Just the few minor comments. With those addressed:
>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Thanks again for your careful review. Also thank you for suggesting
this solution. It's a big improvement in maintainability over what
we've been using downstream.

-Peter
