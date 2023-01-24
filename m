Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65C5679F64
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 18:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbjAXRBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 12:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbjAXRA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:00:59 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD4146D42
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 09:00:56 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id u1-20020a17090a450100b0022936a63a21so19219327pjg.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 09:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NvlI0i6tuIH+cEsFMK651QuzmfDYjvdOyfnJQ4mWPaM=;
        b=fBCyoy0jsWCHcQ5tg6XSqYXIY6XFpXsrjLZ6mXT3WPizdVoFT6JVhQEWOkpHqjh6wd
         ngsgH5NdU4lVbh05bTwLfzo8vbU25MvXhkW7NPzn049LZvVCtXWQ38wIYoIYkz3gtNlN
         5YUbcMG5dqMJh67/3Z3i2GpSIA9l3JSInqAIhpIl1NkXTUjXaFXOqA5dEagK8pD/6z6y
         x6Uw73dClMjkTkQx0hS/sjlyaxOGmjFopku5JE1XKSHnHHXmK/H3ALIIad9NX0SUR5di
         ZbiNpEi1Y2sd/fQJ/WSWuycdhMHRhMbsEWnYRwc6HZn8+YIxs2nztaNFQaXsNjVH78uX
         VF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NvlI0i6tuIH+cEsFMK651QuzmfDYjvdOyfnJQ4mWPaM=;
        b=oKgHLRbZD/tHboxXP7h09pieTdSeiLqaBxRtrbohwNlL0T/6U476TB3Avd0+PfLiGY
         j1TlyupRv9nr2hWQHyH3L9SbH6qLt4NJR6VE9pyQYj/gItAOaUX/bF6isq6xSMgXYDkX
         W9viJG5+xCmXOpBJj1hlzvXFJXPtC2ldIC5O3JQxRMx+2JbFi7MZ/Kng0YXx1nShB0f/
         eRmHc8gX2qz6EsfXK1Ciaw4s3k+6PL2CoVgs4mpF2Aj8Q7D4zzshmAG3vOLdFOZZvfKr
         fThZO0kc1YD20540Ml4+WRqtP0ZqXDY8tSbeOpwNcdwU3P7dlLjvldE3SrIOTq3Zmfll
         Mz8w==
X-Gm-Message-State: AFqh2koss6Rhjs8vBGZ0uov4uOBry5G3gTQsiRj6nIpkkhv/uh6Q0moa
        8S62pEbsr3aSSOJPY5rU5TEn9Gg7TDW5ZLlgT+Qg
X-Google-Smtp-Source: AMrXdXs5LwusCrxpDA+RsriJbYMYR5uAig0mVQQF9cpIROxbArDIWF2uu/OmQcjY4r+XZtUpmQv4jd4LezcJvj0+/Zk=
X-Received: by 2002:a17:90a:17a1:b0:229:9ffe:135b with SMTP id
 q30-20020a17090a17a100b002299ffe135bmr3346473pja.72.1674579655647; Tue, 24
 Jan 2023 09:00:55 -0800 (PST)
MIME-Version: 1.0
References: <20230116212105.1840362-1-mjguzik@gmail.com> <20230116212105.1840362-2-mjguzik@gmail.com>
 <CAHC9VhSKEyyd-s_j=1UbA0+vOK7ggyCp6e-FNSG7XVYvCxoLnA@mail.gmail.com>
 <CAGudoHF+bg0qiq+ByVpysa9t8J=zpF8=d1CqDVS5GmOGpVM9rQ@mail.gmail.com>
 <CAHC9VhTnpWKnKRu3wFTNfub_qdcDePdEXYZWOpvpqL0fcfS_Uw@mail.gmail.com> <CAGudoHEWQJKMS=pL9Ate4COshgQaC-fjQ2RN3LiYmdS=0MVruA@mail.gmail.com>
In-Reply-To: <CAGudoHEWQJKMS=pL9Ate4COshgQaC-fjQ2RN3LiYmdS=0MVruA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 24 Jan 2023 12:00:46 -0500
Message-ID: <CAHC9VhSYg-BbJvNBZd3dayYCf8bzedASoidnX23_i4iK7P-WxQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     viro@zeniv.linux.org.uk, serge@hallyn.com,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 5:16 AM Mateusz Guzik <mjguzik@gmail.com> wrote:
> On 1/23/23, Paul Moore <paul@paul-moore.com> wrote:
> > On Fri, Jan 20, 2023 at 7:50 PM Mateusz Guzik <mjguzik@gmail.com> wrote:
> >> On 1/20/23, Paul Moore <paul@paul-moore.com> wrote:
> >> > On Mon, Jan 16, 2023 at 4:21 PM Mateusz Guzik <mjguzik@gmail.com>
> >> > wrote:
> >> >>
> >> >> access(2) remains commonly used, for example on exec:
> >> >> access("/etc/ld.so.preload", R_OK)
> >> >>
> >> >> or when running gcc: strace -c gcc empty.c
> >> >> % time     seconds  usecs/call     calls    errors syscall
> >> >> ------ ----------- ----------- --------- --------- ----------------
> >> >>   0.00    0.000000           0        42        26 access
> >> >>
> >> >> It falls down to do_faccessat without the AT_EACCESS flag, which in
> >> >> turn
> >> >> results in allocation of new creds in order to modify fsuid/fsgid and
> >> >> caps. This is a very expensive process single-threaded and most
> >> >> notably
> >> >> multi-threaded, with numerous structures getting refed and unrefed on
> >> >> imminent new cred destruction.
> >> >>
> >> >> Turns out for typical consumers the resulting creds would be identical
> >> >> and this can be checked upfront, avoiding the hard work.
> >> >>
> >> >> An access benchmark plugged into will-it-scale running on Cascade Lake
> >> >> shows:
> >> >> test    proc    before  after
> >> >> access1 1       1310582 2908735  (+121%)  # distinct files
> >> >> access1 24      4716491 63822173 (+1353%) # distinct files
> >> >> access2 24      2378041 5370335  (+125%)  # same file
> >> >
> >> > Out of curiosity, do you have any measurements of the impact this
> >> > patch has on the AT_EACCESS case when the creds do need to be
> >> > modified?
> >>
> >> I could not be arsed to bench that. I'm not saying there is literally 0
> >> impact, but it should not be high and the massive win in the case I
> >> patched imho justifies it.
> >
> > That's one way to respond to an honest question asking if you've done
> > any tests on the other side of the change.  I agree the impact should
> > be less than the advantage you've shown, but sometimes it's nice to
> > see these things.
>
> So reading this now I do think it was worded in quite a poor manner, so
> apologies for that.

Thanks, but no worries.  Work in this space long enough and everyone
eventually ends up sending a mail or two that could have been worded
better, myself included.

> Wording aside, I don't know whether this is just a passing remark or
> are you genuinely concerned about the other case.

My main concern is the duplication between the cred check and the cred
override functions leading to a bug at some unknown point in the
future.  Changes to credential checking, and access control in
general, always gets my attention and due to past bruises I'm very
sensitive to out-of-sync issues due to code duplication; so your patch
was a bit of a "perfect storm" of concern for me :)

The profiling questions were mainly there as a curiosity since it
looked like this was part of a larger performance oriented effort and
I thought you might have more data that didn't make it into the commit
description.

> >> These funcs are literally next to each other, I don't think that is easy
> >> to miss. I concede a comment in access_override_creds to take a look at
> >> access_need_override_creds would not hurt, but I don't know if a resend
> >> to add it is justified.
> >
> > Perhaps it's because I have to deal with a fair amount of code getting
> > changed in one place and not another, but I would think that a comment
> > would be the least one could do here and would justify a respin.
>
> I'm not going to *insist* on not adding that comment.
>
> Would this work for you?
>
> diff --git a/fs/open.c b/fs/open.c
> index 3c068a38044c..756177b94b04 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -407,6 +407,11 @@ static const struct cred *access_override_creds(void)
>         if (!override_cred)
>                 return NULL;
>
> +       /*
> +        * XXX access_need_override_creds performs checks in hopes of
> +        * skipping this work. Make sure it stays in sync if making any
> +        * changes here.
> +        */
>         override_cred->fsuid = override_cred->uid;
>         override_cred->fsgid = override_cred->gid;
>
> if not, can you phrase it however you see fit for me to copy-paste?

That wording looks good to me and would help me feel a bit better
about this change, thank you.

-- 
paul-moore.com
