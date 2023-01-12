Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE00666793
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 01:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbjALAVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 19:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjALAVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 19:21:21 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BDA2F7AA
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 16:21:17 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-4d0f843c417so103977727b3.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 16:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JOFWK7S0QU8xmUK+yBgEsb+MAKsxUcDHs25Z2aSj5ws=;
        b=SlIcXlORe2ImkMbeZxwV/aVUF7SWQQ0CD62R7d+UbBCWaeoB/dGQxWLNEAqzwI9XH0
         scVUPGtxWcCvUe7c95hRRt950s3FVB/rN144AGcc6g13CwK/zaIbuGr3gaTYmfjBILFT
         OBua/HWISHD8CMvaY6GeVjGijG/Bc54ACRugaQJwXwetL5c4VwqArxqGs5ERzXSTmiXx
         i5GUiqmCm7Re/ruBv9hRSzAKlKJwW895OoRU3xE06OWZgYJwE1tnfdNOmwEYKG5Zx5Tc
         w3s+KudIbAxzqVO1ewABScWpVVIC9UZ3BBNPtsoLKX2yHKfoIzPqBHGVcaAM/cel3FK8
         cQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JOFWK7S0QU8xmUK+yBgEsb+MAKsxUcDHs25Z2aSj5ws=;
        b=CN0mYT05cz6xsqXFm/TZUDoCwfr8KbBTVbBrVR8PQiyEcFLwodhRYNOx2bMeWmOdfR
         Llooyh53p4uJrp+5EApo41Oyr0NpksVBUiMZFdSx2Hx9WWyQBqYWofpjHcq8XjOpc51Q
         Ebokd6ZVJa5vsbluoGy9IWwWsH0z8ci6Alo2rH6sao1Y/Lvjc9q2XbCV3ALoC88Q/jM5
         uH0Rc85hYhwIdjKPs1AIhamRQQ04HoJHRbkB+aFx+Wv65q/4kcjrZQxBnJHeSm/QEDFf
         b+sgm/711S1UXFftVtBPjEcmPGgZwi3aQ7q2eAtozZfpVJRyak3Tkd06/8Ydq9hH++QM
         ieFg==
X-Gm-Message-State: AFqh2kpMDLVfJrkchNlbhyDhldNs1BLk0Ebqem5tKqWMREh07r2OkMzH
        VkRZTHCij/3pcEQyAZFDipfRVwj6kYft2Lxv/W0tBg==
X-Google-Smtp-Source: AMrXdXv//B7Z9uVRrJ72r0SJYHXvm5gTjOdwGOeS8hW6kDzyLtEmUV3ElVz4ZAjR1QWaSRgYV0hAqURbPS38yvtNrDo=
X-Received: by 2002:a05:690c:688:b0:4ab:cd28:a5e2 with SMTP id
 bp8-20020a05690c068800b004abcd28a5e2mr4453982ywb.234.1673482876837; Wed, 11
 Jan 2023 16:21:16 -0800 (PST)
MIME-Version: 1.0
References: <20230109213809.418135-1-tjmercier@google.com> <20230109213809.418135-5-tjmercier@google.com>
 <CAHC9VhT+5oE4DZzxqCGFDoHjkP+5GcKU1R2BBW29uUu8BcgiAg@mail.gmail.com>
In-Reply-To: <CAHC9VhT+5oE4DZzxqCGFDoHjkP+5GcKU1R2BBW29uUu8BcgiAg@mail.gmail.com>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Wed, 11 Jan 2023 16:21:05 -0800
Message-ID: <CABdmKX2FPf+Ox47g8nMeYw1OBNUOZrnKD5qVBtaVY01FbQq4ig@mail.gmail.com>
Subject: Re: [PATCH 4/4] security: binder: Add transfer_charge SElinux hook
To:     Paul Moore <paul@paul-moore.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, hannes@cmpxchg.org,
        daniel.vetter@ffwll.ch, android-mm@google.com, jstultz@google.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
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

On Wed, Jan 11, 2023 at 3:00 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Mon, Jan 9, 2023 at 4:38 PM T.J. Mercier <tjmercier@google.com> wrote:
> >
> > Any process can cause a memory charge transfer to occur to any other
> > process when transmitting a file descriptor through binder. This should
> > only be possible for central allocator processes, so a new SELinux
> > permission is added to restrict which processes are allowed to initiate
> > these charge transfers.
> >
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > ---
> >  drivers/android/binder.c            | 5 +++++
> >  include/linux/lsm_hook_defs.h       | 2 ++
> >  include/linux/lsm_hooks.h           | 6 ++++++
> >  include/linux/security.h            | 2 ++
> >  security/security.c                 | 6 ++++++
> >  security/selinux/hooks.c            | 9 +++++++++
> >  security/selinux/include/classmap.h | 2 +-
> >  7 files changed, 31 insertions(+), 1 deletion(-)
>
> Hi T.J.,
>
> A few things come to mind when looking at this patchset, but let me
> start with the big one first: you only sent 0/4 and 4/4 to the LSM and
> SELinux lists, so that's all I'm seeing in my inbox to review, and
> it's hard to make sense of what you want to do with just these
> snippets.  This makes me cranky, and less inclined to spend the time
> to give this a proper review, because there are plenty of other things
> which need attention and don't require me having to hunt down missing
> pieces.  Yes, I'm aware of b4/lei, and while they are great tools, my
> workflow was pretty well established before they came into existence
> and I still do things the good ol' fashioned way with mailing lists,
> etc.
>
> Make the patch reviewer's life easy whenever you can, it will rarely
> (ever?) backfire, I promise.
>
Hi Paul, sorry about that. I have git send-email calling
get_maintainer.pl to automatically figure out the recipients, and I
think that's why it only sent particular patches to a subset of lists.
Looks like the list of recipients for each patch should be a union of
all patches. Thank you for taking a look anyway! Here's a lore link:
https://lore.kernel.org/lkml/20230109213809.418135-1-tjmercier@google.com/

> > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > index 9830848c8d25..9063db04826d 100644
> > --- a/drivers/android/binder.c
> > +++ b/drivers/android/binder.c
> > @@ -2279,6 +2279,11 @@ static int binder_translate_fd(u32 fd, binder_size_t fd_offset, __u32 flags,
> >         if (IS_ENABLED(CONFIG_MEMCG) && (flags & BINDER_FD_FLAG_XFER_CHARGE)) {
> >                 struct dma_buf *dmabuf;
> >
> > +               if (security_binder_transfer_charge(proc->cred, target_proc->cred)) {
> > +                       ret = -EPERM;
> > +                       goto err_security;
> > +               }
>
> This is where I believe I'm missing the proper context, as this
> version of binder_translate_fd() differs from what I see in Linus'
> tree.  However, the version in Linus' tree does have a LSM hook,
> security_binder_transfer_file(), which is passed both the credentials
> you are using above and based solely on the level of indentation shown
> in the chunk of code above, it seems like the existing hook might be
> suitable?
>
Yes, patch 3 plumbs through flags to this function:
https://lore.kernel.org/lkml/20230109213809.418135-4-tjmercier@google.com/

I don't think the existing hook is suitable, which I've tried to explain below.

> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 3c5be76a9199..823ef14924bd 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2066,6 +2066,14 @@ static int selinux_binder_transfer_file(const struct cred *from,
> >                             &ad);
> >  }
> >
> > +static int selinux_binder_transfer_charge(const struct cred *from, const struct cred *to)
> > +{
> > +       return avc_has_perm(&selinux_state,
> > +                           cred_sid(from), cred_sid(to),
> > +                           SECCLASS_BINDER, BINDER__TRANSFER_CHARGE,
> > +                           NULL);
> > +}
>
> Generally speaking SELinux doesn't really worry about resource
> accounting controls so this seems a bit out of place, but perhaps the
> larger question is do you see this being sufficiently distinct from
> the existing binder:transfer permission?  In other words, would you
> ever want to grant a domain the ability to transfer a file *without*
> also granting it the ability to transfer the memory charge?  You need
> to help me explain why we need an additional permission for this,
> because I don't currently see the need.
>
Yes, and that's actually more often the case than not. A file here
means a file descriptor that points at any type of resource: file on
disk, memfd, dmabuf, etc. Currently there exists policy that restricts
which processes are allowed to interact with FDs over binder using the
security_binder_transfer_file hook you reference. [1] However this new
transfer_charge permission is meant to restrict the ability of a FD
sender to transfer the memory charge associated with that FD (if one
exists) to a recipient (who may or may not want to accept the memory
charge). So the memory charge is independent of (potentially one-time,
read-only) access to the FD. I thought this would be a good idea for
two reasons:
1) The recipient has no control over whether to accept the memory
charge or not. If the recipient shouldn't have the memory charge
associated with a shared/loaned resource attributed to it, the
recipient doesn't have a way to prevent that. When the charge is
transferred, it could initiate memory reclaim on the recipient, or
make it a bigger target for a future process kill than it should be.
2) Only certain senders should be doing this. Without this control,
any sender could circumvent process memory limits by transferring
memory charges that should be attributed to them onto others.

[1] https://cs.android.com/search?q=%22fd%20use%22&ss=android%2Fplatform%2Fsuperproject:system%2Fsepolicy%2F



> >  static int selinux_ptrace_access_check(struct task_struct *child,
> >                                        unsigned int mode)
> >  {
> > @@ -7052,6 +7060,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
> >         LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
> >         LSM_HOOK_INIT(binder_transfer_binder, selinux_binder_transfer_binder),
> >         LSM_HOOK_INIT(binder_transfer_file, selinux_binder_transfer_file),
> > +       LSM_HOOK_INIT(binder_transfer_charge, selinux_binder_transfer_charge),
> >
> >         LSM_HOOK_INIT(ptrace_access_check, selinux_ptrace_access_check),
> >         LSM_HOOK_INIT(ptrace_traceme, selinux_ptrace_traceme),
> > diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> > index a3c380775d41..2eef180d10d7 100644
> > --- a/security/selinux/include/classmap.h
> > +++ b/security/selinux/include/classmap.h
> > @@ -172,7 +172,7 @@ const struct security_class_mapping secclass_map[] = {
> >         { "tun_socket",
> >           { COMMON_SOCK_PERMS, "attach_queue", NULL } },
> >         { "binder", { "impersonate", "call", "set_context_mgr", "transfer",
> > -                     NULL } },
> > +                     "transfer_charge", NULL } },
> >         { "cap_userns",
> >           { COMMON_CAP_PERMS, NULL } },
> >         { "cap2_userns",
> > --
> > 2.39.0.314.g84b9a713c41-goog
>
> --
> paul-moore.com
