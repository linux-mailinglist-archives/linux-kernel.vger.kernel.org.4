Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C23F6685C4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240564AbjALVpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240459AbjALVpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:45:15 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CAF5AC54
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:37:41 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d15so21518611pls.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8myv660sGECfmpLg/2qAbJCafVtUvTqbUDIsF1ixPPc=;
        b=VvYrW8irSCSpqHJ77qBwyzk+W6/1dOrPPoHXprrPyKg3Jn9jEAClcWLVfhlqQU9gdx
         MvbaK1O2994L7okMg3tSpV7idRGyO3x0lhemuvsBJSt95+DW5Va0GnaXIONNquSe8SUj
         i9gwY/yNc/wbH+fwCniUFu0yGLzjUU07OKskRUZme9Vl1P5EYNCu5iPi/FHK74gBRxnn
         Bp7TNjwJF/xCUI7w8qETtpU+qznzYSwjMhgwzcrQk89Y0zjUhNifp6MNuirnBXSr49f7
         +8b2wqC81eg1CyFmSzvSuPYYmlpYY6pXuBt8zz/Yv4FAqw3EhdDRyYKGLiiX+9VRXMgS
         bsAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8myv660sGECfmpLg/2qAbJCafVtUvTqbUDIsF1ixPPc=;
        b=eHjX17mHCNDsToAWfLoXjw69jxQtplPR9uzDessvKx/2/AjRVyfJFx8OFy/BEqId+E
         o1TwaSoGewHhFiHCO4AtY4lEhT/NlnFv5PNM+WG8yErD5WzFR2JNgOOOsuuPQfUWhXQ8
         I/RKzN2qzA2VCX4L0PYS9Rk55XFJ6dk3ezxJlTAX9zA/nt7p0l6OZkV24Jx0sVJrGmC8
         OJMfkoMeQCOzlBAdPl1JpoM4pJKuU0D41Z3uWN3Z3bfwHZg0mH5FioC9RhKA6Fwm2DjP
         MgQUWpEmlRTDDHCsLYstR2AK1XaJQ55PiJR6wbJhz84CwBgSl3UMJriTFAVtqW4m+jof
         zD+A==
X-Gm-Message-State: AFqh2kpC5+0JTgtEXl8F8kFJSwpD44GKNa72c/xDaka5dePLnLRMwLrM
        ebPJNueEJ9/YE+LlunJWCxNlvNK3khKbmt6Dwl8h
X-Google-Smtp-Source: AMrXdXs+WCVw3JkIeillb8ZHjI0TL5Xp6GiMaaH6fOC5+UN3SMnbuydY3Lhs4q9+qYLMLE/9JbIxfR5wzsYajNg2LWM=
X-Received: by 2002:a17:902:ce0b:b0:172:86a2:8e68 with SMTP id
 k11-20020a170902ce0b00b0017286a28e68mr5172840plg.27.1673559460436; Thu, 12
 Jan 2023 13:37:40 -0800 (PST)
MIME-Version: 1.0
References: <20230109180717.58855-1-casey@schaufler-ca.com>
 <20230109180717.58855-5-casey@schaufler-ca.com> <CAHC9VhQ0bbZX_E8qD-svvm_ksYNUKtdKxmF5gRUSyE2QEyicrg@mail.gmail.com>
 <4071a81c-97ae-4759-5f59-b149973d1e26@schaufler-ca.com>
In-Reply-To: <4071a81c-97ae-4759-5f59-b149973d1e26@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 12 Jan 2023 16:37:29 -0500
Message-ID: <CAHC9VhRqMDnnd570tnu2=8BQkhTMREMuH+5P-3ONGtXZGxtt8Q@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] LSM: lsm_get_self_attr syscall for LSM self attributes
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 8:37 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 1/11/2023 1:07 PM, Paul Moore wrote:
> > On Mon, Jan 9, 2023 at 1:09 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> Create a system call lsm_get_self_attr() to provide the security
> >> module maintained attributes of the current process. Historically
> >> these attributes have been exposed to user space via entries in
> >> procfs under /proc/self/attr.
> >>
> >> Attributes are provided as a collection of lsm_ctx structures
> >> which are placed into a user supplied buffer. Each structure
> >> identifys the size of the attribute, and the attribute value.
> >   ^^^
> >   identifies
>
> Pluralses are hard in the vicinity of 'y's. ;)
>
> >> The format of the attribute value is defined by the security
> >> module, but will always be \0 terminated. The ctx_len value
> >> will always be strlen(ctx)+1.
> > I don't want to limit ourselves to only sending string values as
> > attributes as who knows what we might need to do in the future, and
> > the struct was originally designed to support both strings and binary
> > data.  I would suggest changing the sentences above to something like
> > this:
>
> Part of creating a sane and sensible API is setting rational limitations.
> While a "context" has always allowed for a binary value it has always
> been a user friendly, nul terminated string. The one case where someone
> proposed otherwise was my "hideous" format for compound contexts, and we
> know how well that was received. If we're serious about cleaning up our
> API let's quit bending over to support something no one is using and that
> we'd prefer they didn't.

I agree that I'm in no rush to move away from a simple string format
for context values, but as we are at a unique point in time where we
get to define a new API I think it is important to ensure that it has
enough flexibility to endure whatever changes might come along in the
next 10~20 years.  I mean ~20 years ago we only had one LSM and the
concept of containers/namespaces in the kernel was just a fringe
concept (if at all!).

I think it's also important to remember that we still review code
around here, and just because the struct has the necessary provisions
to *support* a binary context, it doesn't mean we are going to allow
it to be used that way without a lot of discussion first.  Any move to
a binary format would have to be done in a way that doesn't break
existing applications which would likely mean either a secondary LSM
ID for those LSMs which provided a new format, a new LSM specific
flag, and in the most extreme case a LSM specific override tacked to
the end of the struct after the ctx field (possible since we now have
the total length field).

> That's my preference. Is there anyone who wants a binary interface, or any
> really good reason to provide one? I'm not going to stand fast on a strings
> only interface, but it would make it significantly cleaner if we had one.

It's not about needing or even wanting it right now, it's about
keeping it as a possible option for some point in the future when we
might need it.

> > The format of the attribute value is defined by the individual LSM,
> > with the attribute itself stored in @ctx and the length of the
> > attribute stored in @ctx_len.  Both strings and arbitrary binary
> > attributes are supported, but strings should be NULL terminated and
> > @ctx_len should be equal to `strlen(@ctx) + 1`.
> >
> >>         ---------------------------
> >>         | __u32 id                |
> >>         ---------------------------
> >>         | __u64 flags             |
> >>         ---------------------------
> >>         | __kernel_size_t ctx_len |
> >>         ---------------------------
> >>         | __u8 ctx[ctx_len]       |
> >>         ---------------------------
> >>         | __u32 id                |
> >>         ---------------------------
> >>         | __u64 flags             |
> >>         ---------------------------
> >>         | __kernel_size_t ctx_len |
> >>         ---------------------------
> >>         | __u8 ctx[ctx_len]       |
> >>         ---------------------------
> > Don't repeat the structure layout in memory twice here, it's
> > confusing.  I also think it would be easier to read, and arguably more
> > useful, to simply copy the struct definition into the description
> > instead of the ASCII art column.
>
> OK on both.
>
> > Although, this has got me wondering if we should think about aligning
> > the lsm_ctx structs when we are populating them in the kernel; more on
> > this below ...
>
> As you say below, we'll need a total_len for this, but OK.
>
>
> >> ---
> >>  Documentation/userspace-api/lsm.rst |   9 ++
> >>  include/linux/syscalls.h            |   3 +
> >>  include/uapi/linux/lsm.h            |  21 ++++
> >>  kernel/sys_ni.c                     |   3 +
> >>  security/Makefile                   |   1 +
> >>  security/lsm_syscalls.c             | 182 ++++++++++++++++++++++++++++
> >>  6 files changed, 219 insertions(+)
> >>  create mode 100644 security/lsm_syscalls.c
> > ..
> >
> >> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> >> index 33a0ee3bcb2e..a89205c70ffa 100644
> >> --- a/include/linux/syscalls.h
> >> +++ b/include/linux/syscalls.h
> >> @@ -71,6 +71,7 @@ struct clone_args;
> >>  struct open_how;
> >>  struct mount_attr;
> >>  struct landlock_ruleset_attr;
> >> +struct lsm_ctx;
> >>  enum landlock_rule_type;
> >>
> >>  #include <linux/types.h>
> >> @@ -1058,6 +1059,8 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
> >>  asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
> >>                                             unsigned long home_node,
> >>                                             unsigned long flags);
> >> +asmlinkage long sys_lsm_get_self_attr(struct lsm_ctx *ctx, size_t *size,
> >> +                                     int flags);
> >>
> >>  /*
> >>   * Architecture-specific system calls
> >> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> >> index 61a91b7d946f..8674d8c6b326 100644
> >> --- a/include/uapi/linux/lsm.h
> >> +++ b/include/uapi/linux/lsm.h
> >> @@ -9,6 +9,27 @@
> >>  #ifndef _UAPI_LINUX_LSM_H
> >>  #define _UAPI_LINUX_LSM_H
> >>
> >> +#include <linux/types.h>
> >> +#include <linux/unistd.h>
> >> +
> >> +/**
> >> + * struct lsm_ctx - LSM context
> >> + * @id: the LSM id number, see LSM_ID_XXX
> > As mentioned above, it occurred to me that we might want want to pad
> > out the lsm_ctx struct to ensure that the "array" of lsm_ctx is nicely
> > aligned.  I know some systems used to complain about unaligned
> > accesses, and even on those that don't complain tend to be faster when
> > access are aligned.  We can either implicitly align the individual
> > lsm_ctx structs or we can add a total length field (in addition to the
> > @ctx_len field) so that the padding/alignment is explicit.
> >
> > Adding an explicit total length field could have some other advantages
> > in that it, in conjunction with the existing @flags field, would allow
> > an individual LSM to "extend" the lsm_ctx struct to provide additional
> > LSM specific information in the case where the single @ctx field was
> > not sufficient.  Think of it as some additional future proofing in
> > addition to explicit padding.
>
> I'm not sure whether to call it future proofing or confusion assurance,
> and I certainly wouldn't encourage such use. On the other hand, I wouldn't
> let that get in the way of the performant aligned interface, so I'm good
> with the len field in addition to the ctx_len.

Whatever you want to call it is fine by me.  The more I think about
it, the more I think this will be important to have.

> >> + * @flags: context specifier and LSM specific flags
> >  * @flags: LSM specific flags
> >
> > Only the individual LSM specified in @id should ever interpret @flags or @ctx.
>
> Sure.
>
> >> + * @ctx_len: the size of @ctx
> >> + * @ctx: the LSM context, a nul terminated string
> >  * @ctx: the LSM context value
>
> As above, I would like to make this a string. I won't fight over it however.
>
> >> + * @ctx in a nul terminated string.
> >> + *     (strlen(@ctx) < @ctx_len) is always true.
> >> + *     (strlen(@ctx) == @ctx_len + 1) is not guaranteed.
> >> + */
> > Let's rework the extra description too based on the comments above.
> > For the sake of clarity, here is what I'm currently thinking (comments
> > and feedback are encouraged):
> >
> >  /**
> >   * struct lsm_ctx - LSM context information
> >   * @id: the LSM ID token, see LSM_ID_XXX
> >   * @flags: LSM specific flags
> >   * @len: length of the lsm_ctx struct + extra (?) + padding
> >   * @ctx_len: the size of @ctx
> >   * @ctx: the LSM context value
> >   *
> >   * The @len field MUST be equal to size of the lsm_ctx struct
> >   * plus any additional padding and/or data placed after @ctx.
> >   *
> >   * In all cases @ctx_len MUST be equal to length of @ctx.  If
> >   * @ctx is a string value, it should be nul terminated with
> >   * @ctx_len equal to `strlen(@ctx) + 1`.  Binary @ctx values
> >   * are supported.
> >   *
> >   * The @flags and @ctx fields SHOULD only be interpreted by the
> >   * LSM specified by @id; they MUST be set to zero/0 when not used.
> >   */
> > struct lsm_ctx {
> >   __u32 id;
> >   __u64 flags;
> >   __kernel_size_t len;
> >   __kernel_size_t ctx_len;
> >   __u8 ctx[];
> > };
>
> Yes, if there's a convincing argument for binary values.
>
> >> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
> >> new file mode 100644
> >> index 000000000000..55e8bf61ac8a
> >> --- /dev/null
> >> +++ b/security/lsm_syscalls.c
> >> @@ -0,0 +1,182 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * System calls implementing the Linux Security Module API.
> >> + *
> >> + *  Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
> >> + *  Copyright (C) 2022 Intel Corporation
> >> + */
> >> +
> >> +#include <asm/current.h>
> >> +#include <linux/compiler_types.h>
> >> +#include <linux/err.h>
> >> +#include <linux/errno.h>
> >> +#include <linux/security.h>
> >> +#include <linux/stddef.h>
> >> +#include <linux/syscalls.h>
> >> +#include <linux/types.h>
> >> +#include <linux/lsm_hooks.h>
> >> +#include <uapi/linux/lsm.h>
> >> +
> >> +struct attrs_used_map {
> >> +       char *name;
> >> +       int attrs_used;
> > Based on the usage below it really seems like @attrs_used should just
> > be @attr, yes?  That said, I'm not too bothered by it either way so if
> > you really love @attrs_used that's fine.
>
> Potato - Potatoe - Seeing the same field name in different structs at
> the same time gives me a headache, but I'm not going to quibble.
>
>
> >> +};
> >> +
> >> +static const struct attrs_used_map lsm_attr_names[] = {
> > We can probably just call this "attr_map" right?  I mean the "used"
> > portion is pretty inherent in the fact that we're defining a mapping
> > :)
>
> Sure.
>
>
> >> +       { .name = "current",    .attrs_used = LSM_ATTR_CURRENT, },
> >> +       { .name = "exec",       .attrs_used = LSM_ATTR_EXEC, },
> >> +       { .name = "fscreate",   .attrs_used = LSM_ATTR_FSCREATE, },
> >> +       { .name = "keycreate",  .attrs_used = LSM_ATTR_KEYCREATE, },
> >> +       { .name = "prev",       .attrs_used = LSM_ATTR_PREV, },
> >> +       { .name = "sockcreate", .attrs_used = LSM_ATTR_SOCKCREATE, },
> >> +};
> >> +
> >> +static int attr_used_index(u32 flags)
> > Since you can only return one index value at a time in this function
> > you can't really support multiple attribute bits set in the @flags
> > parameter so why not change the prototype to better match the required
> > usage, example:
> >
> >   static int attr_index(u32 attr)
> >
> >> +{
> >> +       int i;
> >> +
> >> +       if (flags == 0)
> >> +               return -EINVAL;
> >> +
> >> +       for (i = 0; i < ARRAY_SIZE(lsm_attr_names); i++)
> >> +               if ((lsm_attr_names[i].attrs_used & flags) == flags)
> >> +                       return i;
> > Given the above, why not simplify the above test to this:
> >
> >   if (lsm_attr_name[i].attr == attr)
> >     return i;
>
> That won't work in the case where an LSM supports more than one attribute.
>
> >
> > If we don't care about failing fast in the case of being passed 0 (why
> > would we?) we can define this function as follows:
> >
> >   static int attr_index(u32 attr)
> >   {
> >     int i;
> >     for (i = 0; i < ARRAY_SIZE(lsm_attr_names); i++)
> >       if (lsm_attr_names[i].attr == attr)
> >         return i;
> >     return -EINVAL;
> >   }
> >
> > If we wanted to streamline things even further we could define
> > attr_map a bit differently and drop the loop in attr_index().  Yes, it
> > does waste attr_map[0], but I don't think anyone is going to be too
> > upset about one wasted index if it scales better.
> >
> >   static const struct attr_map[] = {
> >   [LSM_ATTR_CURRENT] = { .name = "current", .attr = LSM_ATTR_CURRENT },
> >   [LSM_ATTR_EXEC] = { .name = "exec", .attr = LSM_ATTR_EXEC },
> >   ...
> >   };
> >
> >   static int attr_index(u32 attr)
> >   {
> >     if (attr == 0 || attr >= ARRAY_SIZE(attr_map))
> >       return -EINVAL;
> >     return attr;
> >   }
> >
> > If you did this you could probably also convert attr_map from a struct
> > to a simple array of strings as the attribute value would be the
> > associated index.
> >
> >> +/**
> >> + * sys_lsm_get_self_attr - Return current task's security module attributes
> >> + * @ctx: the LSM contexts
> >> + * @size: size of @ctx, updated on return
> >> + * @flags: which attribute to return
> >> + *
> >> + * Returns the calling task's LSM contexts. On success this
> >> + * function returns the number of @ctx array elements. This value
> >> + * may be zero if there are no LSM contexts assigned. If @size is
> >> + * insufficient to contain the return data -E2BIG is returned and
> >> + * @size is set to the minimum required size. In all other cases
> >> + * a negative value indicating the error is returned.
> >> + */
> >> +SYSCALL_DEFINE3(lsm_get_self_attr,
> >> +               struct lsm_ctx __user *, ctx,
> >> +               size_t __user *, size,
> >> +               u32, flags)
> >> +{
> >> +       int i;
> >> +       int rc = 0;
> >> +       int len;
> >> +       int attr;
> >> +       int count = 0;
> >> +       void *curr;
> >> +       char *cp;
> >> +       char *np;
> >> +       char **interum_ctx;
> >> +       size_t total_size = 0;
> >> +       struct lsm_ctx *ip;
> >> +       struct lsm_ctx *interum;
> >> +       struct lsm_ctx *final = NULL;
> >> +
> >> +       attr = attr_used_index(flags);
> >> +       if (attr < 0)
> >> +               return attr;
> >> +
> >> +       interum = kzalloc(ARRAY_SIZE(lsm_attr_names) * lsm_active_cnt *
> >> +                         sizeof(*interum), GFP_KERNEL);
> >> +       if (interum == NULL)
> >> +               return -ENOMEM;
> >> +       ip = interum;
> >> +
> >> +       interum_ctx = kzalloc(ARRAY_SIZE(lsm_attr_names) * lsm_active_cnt *
> >> +                             sizeof(*interum_ctx), GFP_KERNEL);
> >> +       if (interum_ctx == NULL) {
> >> +               kfree(interum);
> >> +               return -ENOMEM;
> >> +       }
> >> +
> >> +       for (i = 0; i < lsm_active_cnt; i++) {
> >> +               if ((lsm_idlist[i]->attrs_used &
> >> +                    lsm_attr_names[attr].attrs_used) == 0)
> >> +                       continue;
> >> +
> >> +               len = security_getprocattr(current, lsm_idlist[i]->id,
> >> +                                          lsm_attr_names[attr].name,
> >> +                                          &cp);
> >> +               if (len <= 0)
> >> +                       continue;
> >> +
> >> +               ip->id = lsm_idlist[i]->id;
> >> +               ip->flags = lsm_attr_names[attr].attrs_used;
> >> +               interum_ctx[count] = cp;
> >> +
> >> +               /*
> >> +                * A security module that returns a binary attribute
> >> +                * will need to identify itself to prevent string
> >> +                * processing.
> >> +                *
> >> +                * At least one security module adds a \n at the
> >> +                * end of a context to make it look nicer. Change
> >> +                * that to a \0 so that user space doesn't have to
> >> +                * work around it.
> >> +                *
> >> +                * Security modules have been inconsistent about
> >> +                * including the \0 terminator in the size. If it's
> >> +                * not there make space for it.
> >> +                *
> >> +                * The length returned will reflect the length of
> >> +                * the string provided by the security module, which
> >> +                * may not match what getprocattr returned.
> >> +                */
> >> +               np = strnchr(cp, len, '\n');
> >> +               if (np != NULL)
> >> +                       *np = '\0';
> >> +               ip->ctx_len = strnlen(cp, len) + 1;
> >> +               total_size += sizeof(*interum) + ip->ctx_len;
> >> +               ip++;
> >> +               count++;
> >> +       }
> >> +
> >> +       if (count == 0)
> >> +               goto free_out;
> >> +
> >> +       final = kzalloc(total_size, GFP_KERNEL);
> >> +       if (final == NULL) {
> >> +               rc = -ENOMEM;
> >> +               goto free_out;
> >> +       }
> >> +
> >> +       curr = final;
> >> +       ip = interum;
> >> +       for (i = 0; i < count; i++) {
> >> +               memcpy(curr, ip, sizeof(*interum));
> >> +               curr += sizeof(*interum);
> >> +               if (ip->ctx_len > 1)
> >> +                       memcpy(curr, interum_ctx[i], ip->ctx_len - 1);
> >> +               curr += ip->ctx_len;
> >> +               ip++;
> >> +       }
> >> +
> >> +       if (get_user(len, size)) {
> >> +               rc = -EFAULT;
> >> +               goto free_out;
> >> +       }
> >> +       if (total_size > len) {
> >> +               rc = -ERANGE;
> >> +               if (put_user(total_size, size) != 0)
> >> +                       rc = -EFAULT;
> >> +               goto free_out;
> >> +       }
> >> +       if (copy_to_user(ctx, final, total_size) != 0 ||
> >> +           put_user(total_size, size) != 0)
> >> +               rc = -EFAULT;
> >> +       else
> >> +               rc = count;
> >> +
> >> +free_out:
> >> +       for (i = 0; i < count; i++)
> >> +               kfree(interum_ctx[i]);
> >> +       kfree(interum_ctx);
> >> +       kfree(interum);
> >> +       kfree(final);
> >> +       return rc;
> >> +}
> > Hmm.  That's all kinda painful isn't it?
>
> It's not so bad as all that. Well, maybe.
>
> >   I think trying to reuse
> > security_getprocattr() is doing more harm than good with all the
> > awkward handling necessary to ensure consistent output.  While it's
> > nice to be able to reuse existing interfaces, one of the main
> > motivations behind the LSM syscall effort is to create a cleaner
> > interface that was designed from the beginning to support multiple
> > LSMs and provide a level of extensibility that we do not currently
> > have with the procfs interface.  Hacking together all our old crap to
> > make this happen seems very wrong to me.
> >
> > With that in mind I would like to propose we introduce a new LSM hook
> > to populate a lsm_ctx struct based on a LSM_ATTR_XXX value:
> >
> >   int security_sys_getselfattr(u64 attr, struct lsm_ctx __user *ctx,
> > size_t *len);
> >
> > The individual LSMs would be responsible for fully populating their
> > lsm_ctx struct specified by @ctx (note the __user tagging) and would
> > return 0 on success or negative values on failure.  The maximum size
> > of the @ctx buffer would be passed in via @len and the used size would
> > be returned in @len; in the case of an too-small @ctx, -E2BIG would be
> > returned and the necessary size would be returned in @len (just as
> > discussed for the syscall itself).  This way the LSM layer syscall
> > function would not need to worry about properly terminating the
> > lsm_ctx::ctx field, setting any LSM specific flags, etc.  Passing the
> > __user pointer directly not only greatly simplifies the LSM layer, it
> > also has the potential to reduce the number of allocations/copies.
>
> That's going to be a lot of duplicate code to add to each LSM. Yes,
> we can do that, but I don't see it as any cleaner.

It puts the individual LSMs in charge of setting their own lsm_ctx
struct which I think will be increasingly important as time goes on
and things evolve.  I'd rather make sure the infrastructure is doing
the right thing now so we can avoid having to have this exact same
discussion each time an individual LSM wants to do something a little
different with their lsm_ctx struct :)

If you need something more concrete and immediate to justify this
work, think about how a LSM could set a bit in the lsm_ctx::flags
field using the current approach of reusing the procfs hook.

> > Taking this approach should shrink the LSM layer syscall function to
> > simply needing to validate the passed @flags before looping through
> > the LSMs calling security_sys_getselfattr().  The lsm_ctx pointer
> > would need to be incremented appropriately for each call, and a total
> > length/size count would need to be maintained in case the buffer is
> > too small, but those should be relatively minor things.
>
> I think this pushed the complexity downward. If we only had one LSM
> it would be a wash. With each LSM having to provide this we're multiplying
> the complexity rather than reducing it.
>
> But again, I'll listen to reason.

I think we are all better off if the LSM layer is as thin as possible.
I believe we've seen the number of LSMs grow and the variety of
security models expand largely in part of this approach; while a thin
LSM layer may force the LSMs to do some extra work, it allows varied
approaches that might not be possible if the LSM layer enforced more
of a specific world-view.

-- 
paul-moore.com
