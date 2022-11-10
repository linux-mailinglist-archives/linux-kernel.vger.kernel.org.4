Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D73B623A27
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 04:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbiKJDC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 22:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbiKJDC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 22:02:26 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC3F2A96B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 19:02:24 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 63so927038ybq.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 19:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YL3LX46XKYMbjgGL9jFDEJXEOeiqtDCe9nmJNdX8kI4=;
        b=h6c8zckaVkExEbJMp0nh2SqDzRojVGz6m51ty7zXXHJL772po4nIPsp4KJqxtS/mRA
         tbX/vpn+W+vKO6KBigpTS/Ce7GyhdyRTZvb3z4RKoOtBQHcPziSKs0tC2UieLrFxFcHx
         m1BamyDQp+1sK6Iwk5y4pOHWg0zWZ++xRdFr/pke3XrRdiXnahucUgLDUrytrHrvWEqn
         1Xy/2w3xEMUj/3pcYl8bqJKbZC5seo84/OEbYaXHV2QExa4e96Fa2S1sLuIBTeZcYvQY
         nl/1BJe7E3X+4hS22+fzrViOoUrK5jBeJBdJiabXVdbSu558rGImir8QJPXdasHpXPyT
         4/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YL3LX46XKYMbjgGL9jFDEJXEOeiqtDCe9nmJNdX8kI4=;
        b=4GsmAAXE+hL4Ftyhuf2uot7fCmTMsrM7p9kQ/YWnydB3k5+bKaSw30eEMJiriH4LB9
         U+n2/W1KEW7rxnWc6+sM97nLSeWa4xC9sPAtQzPfPG6fkET+TbKfpA02zImkAUpqTldN
         K5p44gT6w/8j+6zgQZxS7teg7mfE4wHdqt6UTWMAM8s4V96pP6r+xZhWzWTwZcqdQK64
         509ja7kCAf/yTPDs1aNw8k0jPYZ6Y/BP6uIRPrzzN4sp6dY0L6TGmUVS26Dk0NFcYIYn
         pzB52X458a7nF0pLDgPugUCIe2O+wavy1AyDmyB9m7EEmQRNZ7KRH2SOtmtkarWYsQED
         ioKg==
X-Gm-Message-State: ANoB5pkkUzR/P7cCtZKVn5c4R4cMrso3kUavQEOx7FMIUan/6yktMSAO
        wKXMRC8t2UJrpZIRD1w31ufhbIClZAQGl1ETCwSy
X-Google-Smtp-Source: AA0mqf5Uww+041R1DyFGTvzowgmI/f4Oo5kexBhef6PEdFk05t1u2NCtsEqP/8V5TYLlV7ec1slKXfMfbLdMCwx7tEQ=
X-Received: by 2002:a25:32c8:0:b0:6dc:d157:3984 with SMTP id
 y191-20020a2532c8000000b006dcd1573984mr650817yby.49.1668049342909; Wed, 09
 Nov 2022 19:02:22 -0800 (PST)
MIME-Version: 1.0
References: <20221025184519.13231-1-casey@schaufler-ca.com>
 <20221025184519.13231-7-casey@schaufler-ca.com> <CAHC9VhQ039=X+0edudy64-fpw4C2SwWV_MucbYfXwFKduwnbWA@mail.gmail.com>
 <25913838-c116-ed14-bdc0-3dcc0ce7f67f@schaufler-ca.com>
In-Reply-To: <25913838-c116-ed14-bdc0-3dcc0ce7f67f@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Nov 2022 22:02:11 -0500
Message-ID: <CAHC9VhRMUZvXxVezp+1AsHRiesW_wKcU+nzdMj2+nKDasphEpg@mail.gmail.com>
Subject: Re: [PATCH v1 6/8] LSM: lsm_self_attr syscall for LSM self attributes
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 9, 2022 at 8:32 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 11/9/2022 3:34 PM, Paul Moore wrote:
> > On Tue, Oct 25, 2022 at 2:48 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> Create a system call lsm_self_attr() to provide the security
> >> module maintained attributes of the current process. Historically
> >> these attributes have been exposed to user space via entries in
> >> procfs under /proc/self/attr.
> >>
> >> Attributes are provided as a collection of lsm_ctx structures
> >> which are placed into a user supplied buffer. Each structure
> >> identifys the security module providing the attribute, which
> >> of the possible attributes is provided, the size of the
> >> attribute, and finally the attribute value. The format of the
> >> attribute value is defined by the security module, but will
> >> always be \0 terminated. The ctx_len value will be larger than
> >> strlen(ctx).
> >>
> >>         ------------------------------
> >>         | unsigned int id            |
> >>         ------------------------------
> >>         | unsigned int flags         |
> >>         ------------------------------
> >>         | __kernel_size_t ctx_len    |
> >>         ------------------------------
> >>         | unsigned char ctx[ctx_len] |
> >>         ------------------------------
> >>         | unsigned int id            |
> >>         ------------------------------
> >>         | unsigned int flags         |
> >>         ------------------------------
> >>         | __kernel_size_t ctx_len    |
> >>         ------------------------------
> >>         | unsigned char ctx[ctx_len] |
> >>         ------------------------------
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> >>  include/linux/syscalls.h |   2 +
> >>  include/uapi/linux/lsm.h |  21 ++++++
> >>  kernel/sys_ni.c          |   3 +
> >>  security/Makefile        |   1 +
> >>  security/lsm_syscalls.c  | 156 +++++++++++++++++++++++++++++++++++++++
> >>  5 files changed, 183 insertions(+)
> >>  create mode 100644 security/lsm_syscalls.c
> > ..
> >
> >> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> >> index 61e13b1b9ece..1d27fb5b7746 100644
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
> >> + * @flags: context specifier and LSM specific flags
> >> + * @ctx_len: the size of @ctx
> >> + * @ctx: the LSM context, a nul terminated string
> >> + *
> >> + * @ctx in a nul terminated string.
> >> + *     (strlen(@ctx) < @ctx_len) is always true.
> >> + *     (strlen(@ctx) == @ctx_len + 1) is not guaranteed.
> >> + */
> > We can do better than this, or rather we *should* do better than this.
> > One of the big advantages of creating a new API is we can fix some of
> > the silly things we have had to do in the past, including the
> > "sometimes" NUL terminator on strings.  For this LSM syscalls let's
> > make a promise that all human readable strings will be properly NUL
> > terminated;
>
> It requires effort and buffer management to ensure that ctx_len == strlen(ctx)+1,
> but if you think it's important, sure.

I do, yes.  A safe, familiar, and consistent API is worth a little
extra work.  Ensuring the human readable strings are always nul
terminated is familiar to most everyone who has sat in from of a code
editor, and making sure that the @ctx_len variable indicates the full
length of the @ctx buffer (both for strings and binary blobs) provides
a consistent way to manage the context, even if the application isn't
aware of the exact LSM-specific format.

> >  currently this includes all LSM contexts, and likely will
> > remain that way forever for various reasons, but let's leave the door
> > open for arbitrary blobs (see the "special" LSM ID discussion from
> > earlier in the patchset).  With that in mind I might suggest the
> > following:
> >
> >   /**
> >    * struct lsm_ctx - LSM context
> >    * @id: the LSM id number, see LSM_ID_XXX
> >    * @flags: context specifier and LSM specific flags
> >    * @ctx_len: the size of @ctx
> >    * @ctx: the LSM context, see description
> >    *
> >    * For LSMs which provide human readable contexts @ctx will be a nul
> >    * terminated string and @ctx_len will include the size of the string
> >    * and the nul terminator, e.g. 'ctx_len == strlen(ctx) + 1'.  For LSMs
> >    * which provide binary-only contexts @cts will be a binary blob with
> >    * @ctx_len being the exact value of the blob.  The type of the @ctx,
> >    * human readable string or binary, can be determined by inspecting
> >    * both @id and @flags.
>
> I'd go a touch further, defining LSM_ATTR_BINARY as a flag and demanding
> that any attribute that isn't a nul terminated string be thus identified,
> even if it is always binary. Thus, LSM_ATTR_CURRENT and LSM_ATTR_BINARY
> together would be an error.

No, the class/format of the context (string or binary, and the LSM
specific formatting for each) can be deduced from the LSM ID, @id, and
if necessary the @flags field.  I don't want this API to explicitly
prevent a binary LSM_ATTR_CURRENT if the rest of the system is
modified to support it in the future.

> >    *
> >    * If a given LSM @id does not define a set of values for use in the
> >    * @flags field, @flags MUST be set to zero.
> >    */
> >   struct lsm_ctx {
> >     __u32 id;
> >     __U32 flags;
> >     __kernel_size_t ctx_len;
> >     __u8 ctx[];
> >   };
> >
> >> +struct lsm_ctx {
> >> +       unsigned int            id;
> >> +       unsigned int            flags;
> >> +       __kernel_size_t         ctx_len;
> >> +       unsigned char           ctx[];
> >> +};
> > I agree with Greg, we should be explicit about variable sizing, let's
> > make sure everything in the UAPI header is defined in terms of
> > __uXX/__sXX.  This includes strings as __u8 arrays.
> >
> > Also, I sorta despite the 'let's line all the struct fields up
> > horizontally!' approach in struct/variable definitions.
>
> Kids. Got no respect for tradition.

I think you meant to say, "Kids.          Got no          respect
 for      tradition."

> >   I personally
> > think it looks horrible and it clutters up future patches.  Please
> > don't do this unless the individual file already does it, and since we
> > are creating this new please don't :)
> >
> >> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
> >> new file mode 100644
> >> index 000000000000..da0fab7065e2
> >> --- /dev/null
> >> +++ b/security/lsm_syscalls.c
> >> @@ -0,0 +1,156 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * System calls implementing the Linux Security Module API.
> >> + *
> >> + *  Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
> >> + *  Copyright (C) Intel Corporation
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
> >> +struct feature_map {
> >> +       char *name;
> >> +       int feature;
> >> +};
> >> +
> >> +static const struct feature_map lsm_attr_names[] = {
> >> +       { .name = "current",    .feature = LSM_ATTR_CURRENT, },
> >> +       { .name = "exec",       .feature = LSM_ATTR_EXEC, },
> >> +       { .name = "fscreate",   .feature = LSM_ATTR_FSCREATE, },
> >> +       { .name = "keycreate",  .feature = LSM_ATTR_KEYCREATE, },
> >> +       { .name = "prev",       .feature = LSM_ATTR_PREV, },
> >> +       { .name = "sockcreate", .feature = LSM_ATTR_SOCKCREATE, },
> >> +};
> >> +
> >> +/**
> >> + * lsm_self_attr - Return current task's security module attributes
> >> + * @ctx: the LSM contexts
> >> + * @size: size of @ctx, updated on return
> >> + * @flags: reserved for future use, must be zero
> >> + *
> >> + * Returns the calling task's LSM contexts. On success this
> >> + * function returns the number of @ctx array elements. This value
> >> + * may be zero if there are no LSM contexts assigned. If @size is
> >> + * insufficient to contain the return data -E2BIG is returned and
> >> + * @size is set to the minimum required size. In all other cases
> >> + * a negative value indicating the error is returned.
> >> + */
> >> +SYSCALL_DEFINE3(lsm_self_attr,
> >> +              struct lsm_ctx __user *, ctx,
> >> +              size_t __user *, size,
> >> +              int, flags)
> > See my comments above about UAPI types, let's change this to something
> > like this:
> >
> > [NOTE: I'm assuming it is safe to use __XXX types in syscall declarations?]
> >
> >   SYSCALL_DEFINE3(lsm_self_attr,
> >                  struct lsm_ctx __user *, ctx,
> >                  __kernel_size_t __user *, size,
> >                  __u32, flags)
> >
> >> +{
> >> +       struct lsm_ctx *final = NULL;
> >> +       struct lsm_ctx *interum;
> >> +       struct lsm_ctx *ip;
> >> +       void *curr;
> >> +       char **interum_ctx;
> >> +       char *cp;
> >> +       size_t total_size = 0;
> >> +       int count = 0;
> >> +       int attr;
> >> +       int len;
> >> +       int rc = 0;
> >> +       int i;
> > Ungh, reverse christmas trees ... I kinda hate it from a style
> > perspective, enough to mention it here, but I'm not going to be petty
> > enough to say "change it".
>
> I really don't care. Last I saw reverse christmas tree was the officially
> recommended style. I don't care one way or the other.

I think it is one of those per-subsystem oddities like it or not.

> >
> > However, if you did want to flip it upside down (normal christmas
> > tree?) during the respin I would be grateful ;)
> >

-- 
paul-moore.com
