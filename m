Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E0E68F772
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjBHSxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjBHSxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:53:38 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373E022010
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 10:53:37 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id b5so20396021plz.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 10:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hg6qSzTYaaiz94yPQAoBRJgUOUjqGVflzfvl5opoe1M=;
        b=MCvF8NJu3Lg4JWelT9Kwx7LjCthHxDqKUBeXYB59qSEeV6Qpb64u9rWozCx23z3G5p
         8RMfMKbiGNrLdBEBs3EF5t/Vx14otLqVekN0sgAcKBO8DxFk1FmujEl1FB5CqNpTYoHg
         MBnz9IBaq4DWEB4KZb4ILh1lSw8y713Q5Rwt3AlhaEWiMV2R4GSU/XlsMSoV/ivBltDg
         wUcZGgmjyUDXZdTeUTahA/eglLzJKnBPOa+GkNxGRkXPROFO5Fcvy2vNzM/tOnHYlQ5R
         5f6AMSog7VvP3cJDEk9BKGkdVgp0gcHv5xIkvnHZDrTusIcU6+8DuUG2ITSum97g+SMh
         0j/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hg6qSzTYaaiz94yPQAoBRJgUOUjqGVflzfvl5opoe1M=;
        b=18baj2FqQhsEics4vdTbTuh6gKQL86N534xzViYkFqpSsvjM5XOqN4KhyOIACmJaGs
         aHcijCRTYStUL0r2pd4mpgTCUpqApYjJjun+mFB4rgdNU1ZkKvbllDhQzmsqYrPw6KjU
         QS/DVw4osi81zTshv1IcG2ib98TOTjCTBVVeZ6tu8NApxf9IXYc8EIilcC08DhyewgxJ
         4e610086za1PrDlAPlFwG6HQ0aloYle55rmFg4tUjn/EiGtE+zvL/oUYcSa8W2WHTav1
         h/O4GSQy4BHX9u3behiK/cLfhcubJg9l09aP7rF3kYM/ZjGaOGXURhbKJThb790UK41H
         ov+A==
X-Gm-Message-State: AO0yUKVvo8wn7jScj1Q5YOnB7bBMYgxRyZgD7W6LFG7JlTeSf7zB6BUG
        FVjZKo+KTzUBtYlRzDVtBxgSSePDOmLr9HQ3Iikf
X-Google-Smtp-Source: AK7set9kzB08/uHDiunrNBkcEBD7zDJs69naCo/ADVveNP0SPPk/BxmXbwOQsLh1sX5dvm1cYQcWDqO540RATfk0HQw=
X-Received: by 2002:a17:90a:4f85:b0:22c:41c7:c7ed with SMTP id
 q5-20020a17090a4f8500b0022c41c7c7edmr1090265pjh.61.1675882416619; Wed, 08 Feb
 2023 10:53:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675373475.git.rgb@redhat.com> <20230208120816.2qhck3sb7u67vsib@quack3>
 <CAHC9VhSumNxmoYQ9JPtBgV0dc1fgR38Lqbo0w4PRxhvBdS=W_w@mail.gmail.com>
 <5912195.lOV4Wx5bFT@x2> <CAHC9VhQnajhwOiW-0GvgnkPJ=QOTuLaYt2WBbm8vJoyEDso=2Q@mail.gmail.com>
 <Y+PdyieoFNcNQgmQ@madcap2.tricolour.ca>
In-Reply-To: <Y+PdyieoFNcNQgmQ@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 8 Feb 2023 13:53:25 -0500
Message-ID: <CAHC9VhQK8hHYq2NWn12o_PO=ovJOzrXw=vDJ8=WoXbeim14dJA@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] fanotify: Allow user space to pass back additional
 audit info
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 8, 2023 at 12:37 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2023-02-08 11:24, Paul Moore wrote:
> > On Wed, Feb 8, 2023 at 10:27 AM Steve Grubb <sgrubb@redhat.com> wrote:
> > > On Wednesday, February 8, 2023 10:03:24 AM EST Paul Moore wrote:
> > > > On Wed, Feb 8, 2023 at 7:08 AM Jan Kara <jack@suse.cz> wrote:
> > > > > On Tue 07-02-23 09:54:11, Paul Moore wrote:
> > > > > > On Tue, Feb 7, 2023 at 7:09 AM Jan Kara <jack@suse.cz> wrote:
> > > > > > > On Fri 03-02-23 16:35:13, Richard Guy Briggs wrote:
> > > > > > > > The Fanotify API can be used for access control by requesting
> > > > > > > > permission
> > > > > > > > event notification. The user space tooling that uses it may have a
> > > > > > > > complicated policy that inherently contains additional context for
> > > > > > > > the
> > > > > > > > decision. If this information were available in the audit trail,
> > > > > > > > policy
> > > > > > > > writers can close the loop on debugging policy. Also, if this
> > > > > > > > additional
> > > > > > > > information were available, it would enable the creation of tools
> > > > > > > > that
> > > > > > > > can suggest changes to the policy similar to how audit2allow can
> > > > > > > > help
> > > > > > > > refine labeled security.
> > > > > > > >
> > > > > > > > This patchset defines a new flag (FAN_INFO) and new extensions that
> > > > > > > > define additional information which are appended after the response
> > > > > > > > structure returned from user space on a permission event.  The
> > > > > > > > appended
> > > > > > > > information is organized with headers containing a type and size
> > > > > > > > that
> > > > > > > > can be delegated to interested subsystems.  One new information
> > > > > > > > type is
> > > > > > > > defined to audit the triggering rule number.
> > > > > > > >
> > > > > > > > A newer kernel will work with an older userspace and an older
> > > > > > > > kernel
> > > > > > > > will behave as expected and reject a newer userspace, leaving it up
> > > > > > > > to
> > > > > > > > the newer userspace to test appropriately and adapt as necessary.
> > > > > > > > This
> > > > > > > > is done by providing a a fully-formed FAN_INFO extension but
> > > > > > > > setting the
> > > > > > > > fd to FAN_NOFD.  On a capable kernel, it will succeed but issue no
> > > > > > > > audit
> > > > > > > > record, whereas on an older kernel it will fail.
> > > > > > > >
> > > > > > > > The audit function was updated to log the additional information in
> > > > > > > > the
> > > > > > > > AUDIT_FANOTIFY record. The following are examples of the new record
> > > > > > > >
> > > > > > > > format:
> > > > > > > >   type=FANOTIFY msg=audit(1600385147.372:590): resp=2 fan_type=1
> > > > > > > >   fan_info=3137 subj_trust=3 obj_trust=5 type=FANOTIFY
> > > > > > > >   msg=audit(1659730979.839:284): resp=1 fan_type=0 fan_info=0
> > > > > > > >   subj_trust=2 obj_trust=2> > >
> > > > > > > Thanks! I've applied this series to my tree.
> > > > > >
> > > > > > While I think this version of the patchset is fine, for future
> > > > > > reference it would have been nice if you had waited for my ACK on
> > > > > > patch 3/3; while Steve maintains his userspace tools, I'm the one
> > > > > > responsible for maintaining the Linux Kernel's audit subsystem.
> > > > >
> > > > > Aha, I'm sorry for that. I had the impression that on the last version of
> > > > > the series you've said you don't see anything for which the series should
> > > > > be respun so once Steve's objections where addressed and you were silent
> > > > > for a few days, I thought you consider the thing settled... My bad.
> > > >
> > > > That's understandable, especially given inconsistencies across
> > > > subsystems.  If it helps, if I'm going to ACK something I make it
> > > > explicit with a proper 'Acked-by: ...' line in my reply; if I say
> > > > something looks good but there is no explicit ACK, there is usually
> > > > something outstanding that needs to be resolved, e.g. questions,
> > > > additional testing, etc.
> > > >
> > > > In this particular case I posed some questions in that thread and
> > > > never saw a reply with any answers, hence the lack of an ACK.  While I
> > > > think the patches were reasonable, I withheld my ACK until the
> > > > questions were answered ... which they never were from what I can
> > > > tell, we just saw a new patchset with changes.
> > > >
> > > > /me shrugs
> > >
> > > Paul,
> > >
> > > I reread the thread. You only had a request to change if/else to a switch
> > > construct only if there was a respin for the 3F. You otherwise said get
> > > Steve's input and the 3F borders on being overly clever. Both were addressed.
> > > If you had other questions that needed answers on, please restate them to
> > > expedite approval of this set of patches. As far as I can tell, all comments
> > > are addressed.
> >
> > Steve,
> >
> > It might be helpful to reread my reply below:
> >
> > https://lore.kernel.org/linux-audit/CAHC9VhRWDD6Tk6AEmgoobBkcVKRYbVOte7-F0TGJD2dRk7NKxw@mail.gmail.com/
> >
> > You'll see that I made a comment in that email about not following
> > Richard's explanation about "encoding the zero" (the patch was
> > encoding a "?" to the best I could tell).  I was hoping for some
> > clarification from Richard on his comments, and I never saw anything
> > in my inbox.  I just checked the archives on lore and I don't see
> > anything there either.
>
> Well, it could have been any of:
>         ?
>         "?"
>         3F
>         30
>         0
>
> I can't answer that.  My preference is for 3F but good arguments can be
> made for any of these.  I defer to Steve since it is his tools and
> customers that have to deal with it.

Yeah, that's the kind of discussion I was hoping to have in that
thread.  Like I said, the patch is fine, but it's nice to see some
discussion around things like this, and not just new patchset
revisions, so there is some understanding of why things are the way
they are.

/me shrugs again

-- 
paul-moore.com
