Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008F9623780
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 00:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbiKIXeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 18:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiKIXeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 18:34:05 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2219F13FB5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 15:34:04 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id n205so260128oib.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 15:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ha6UuIiw/2/M4Az1bqxlaasvXS4YMf0DfiUopzOD+h4=;
        b=ummy9s9UbX5bDKUfGVATEJiO9PW9xmpbSZ/VWHpSZRsynFlvTz9Ct5StKSkYs+hXwQ
         ZwpCeYFWJ4XKUYWW5/9GIh7fYy3SlNogQy49cHAcz2ZYQv5h6kMeBKTR4hwa7H740uAA
         Sr6RQjWSmyAj2dJRuLOM4LDR3qHJjnfKbWngyYY+NS6GTuzzMaD2nFJK4pqd3hhOSwxO
         CUQVpKF07kCax7TP9ZnS5AcitYsd7AG0W4mOY6YZZD5J7mKpIhtiTbmOzEFLfZrs9N49
         5rT/dj4OhHEuPUfWq9+ZEZwsg/UOiH4NwBIwnJfd1DMICH/MaXCb9LFRR/aKFdXNVBHI
         mPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ha6UuIiw/2/M4Az1bqxlaasvXS4YMf0DfiUopzOD+h4=;
        b=4qXRZ0PjXnKRV/GgEZQEbWQJ2JnZaWhrPj1VzgOrYxqszM1LaChVY7j+2TfsLJa5P1
         29IzQQO3dG8VFv9kE/kB8oaNolxJWU2t2jxtVr90KksL7pBl+OU2FzmSxi9T46I/DjCc
         1854CTCiasDhZGosvy8WbDvLneXVN/HVEh441dwibMb/vPzmfBjHM0V2f65yWAi0JuFC
         NNhsjDoquawfFxVVlIrfcwLGK1QLh+zHWr/RDT7D1GiXGd6yJYjAh3ckVbRYM7PtIcHP
         wM1A6g/7gDgIxL2Zk42xWoOrM6uErrDeiVvsc6yRF2QiwhADoMCwwslW+RbOnoXlXCCz
         Ruag==
X-Gm-Message-State: ACrzQf2ucGoMXnTZf3AzvJuaThfS8yGxGBmbimgDK6gLmjTpX/AhkL6a
        l6iK+EzJVgAu3kF/lm+9bxkQXd0jDYFxG+sa709O
X-Google-Smtp-Source: AMsMyM6v1MTnhlzQ9kgqh6J9bfvXJJ4pADpF7/h2kko1p8VCQHYp+ZiskC/NqRbQr+Lt+CqsnL8okR/5QDSweoOsh84=
X-Received: by 2002:a05:6808:1441:b0:35a:4a2d:673b with SMTP id
 x1-20020a056808144100b0035a4a2d673bmr20275889oiv.172.1668036843421; Wed, 09
 Nov 2022 15:34:03 -0800 (PST)
MIME-Version: 1.0
References: <20221025184519.13231-1-casey@schaufler-ca.com>
 <20221025184519.13231-3-casey@schaufler-ca.com> <Y1jMeWl0oV4/2zyE@kroah.com>
 <5396ab1e-9b93-df33-ca49-58dc59459a76@schaufler-ca.com> <Y1olsHWnaEk6+b1L@kroah.com>
 <612c169c-2e11-13cf-9742-19714a247152@schaufler-ca.com>
In-Reply-To: <612c169c-2e11-13cf-9742-19714a247152@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Nov 2022 18:33:52 -0500
Message-ID: <CAHC9VhR8_aQFxBq4fG=q8FgVUEZAL6F_iSE9kFnO7Mf4tf52AQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] LSM: Add an LSM identifier for external use
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 12:55 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 10/26/2022 11:31 PM, Greg KH wrote:
> > On Wed, Oct 26, 2022 at 12:36:34PM -0700, Casey Schaufler wrote:
> >>>> + *
> >>>> + * Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
> >>>> + * Copyright (C) Intel Corporation
> >>> No date for Intel?
> >> The latest guidance I have received is that Intel does not want a date.
> > Ok, then I need to have an Intel lawyer sign off on a patch that does
> > this in order to have that be their official statement.  Otherwise, it
> > needs a date.
>
> Seems I misunderstood something. The date will be there.
>
> >>>> + */
> >>>> +
> >>>> +#ifndef _UAPI_LINUX_LSM_H
> >>>> +#define _UAPI_LINUX_LSM_H
> >>>> +
> >>>> +/*
> >>>> + * ID values to identify security modules.
> >>>> + * A system may use more than one security module.
> >>>> + *
> >>>> + * LSM_ID_XXX values 0 - 31 are reserved for future use
> >>> Reserved for what?  Why?
> >> You're not the first person to ask.
> > And the answer is?
>
> There hasn't been an argument for it beyond "just in case".
> I can't see a rational reason to reserve specific numbers as
> I don't see value in LSM ranges.
>
> >> I'll remove the reserved values for the next version.
> > Because we asked it will be removed?
>
> Because I don't have a good reason for including it and it
> has been called into question. If a reviewer has a legitimate
> case for reserved values they may be back.

Sorry for the delay, I was away for a couple of weeks and limiting my
patch review to bug fixes, critical stuff, etc. but normal service is
resuming this week ...

I was the one who originally added the note on reserved values in my
original strawman proposal and I suspect Casey just carried that
forward into his patches, so feel free to blame me.  My reason for
doing so is rather simple, we're going to treat the ID as a 32-bit
value so we have *plenty* of room (just the thought of supporting +4
billion unique LSMs is comically insane), and I'd like to try and
leave some space for yet-undetermined "special" things that we might
need to convey in the LSM syscalls.  For example, this would allow us
to convey additional information to userspace when an application
asked for labeling information using one of these reserved LSM IDs;
applications which did not know (or care) about the special ID would
continue to function normally but augmented/new applications would be
able to make sense of the additional information ... and we wouldn't
have to add a new syscall to do it.

It's basically really cheap futureproofing with little downside (we
can always reclaim it at a later date if really necessary).  I've done
similar things on other projects and it has proven to be useful in a
few, and in none of the cases has it proven to be a problem.

--
paul-moore.com
