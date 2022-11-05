Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C3B61D767
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 06:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiKEFWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 01:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiKEFWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 01:22:17 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2782E680
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 22:22:15 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id l127so7198055oia.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 22:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EOF2Cx7IpRN9hnOm1d8qRQgLYEtSJu+jemaFIvyZFv0=;
        b=ely303De/1B7MiFyoKEFJq6+SLg+YWzEHaAQgwOc1I+50zenn4zxDO/2dWbEBOfIeJ
         QcpDm8/A4AC11ya2l1FQD5MixWsFF2Qcqyj0SsVvXMeKQFEPD8Xd9uou/WnRsM9WhAbI
         a6d5K29siu4eNmMPC50IM1MXBkbovEP56bNFKNhvw4G4t6Kg1kR7gNdhj7tKszovtyQX
         oGqx9goDlfWSWsbVQ8kOst9tWkPoG/UsufAgqQTSU/1Gbj4VQ/ezavbVYXAcjfyTdhwg
         a+3BYfGlJd/+2IgY5udr2nNYfednesxtXDzqyPS1JAzw3z1pin4q8AlvYcpVgVjwWf02
         KoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EOF2Cx7IpRN9hnOm1d8qRQgLYEtSJu+jemaFIvyZFv0=;
        b=A8YIEFOEEjjce42Q0WjHo8W30KzGM5I0eAr1H+7l4xj21UpOJ/YadZodi5V0dORLik
         XcRX5TTV6W8pAIHvKOzP9JhOAPdKTnwJaNW4DxnD3VtAhfvy7RFInxVabwm7Rc+cZhGr
         DnN2b9MlNTFQ+Z/DigSnQfMTRQYZhK9sDJ9RNRimKk8gMg/CIm8Eat7A/CBD79oG1ln1
         HZkf3ktRQ/skvX0rZmyhJecEZpqP0dzSZ1huTWO8BbgtUmKSTclYFsAyTiTJ9/lFYQWB
         EIPFn9PmDHVZdrJxeoUtr6ij9+H4ZrVfVBCnxEHfrwiv3DJ4E4e5vVZC7DvASliPJZaO
         hUew==
X-Gm-Message-State: ACrzQf3TVzfSD5tLt23EdXvpwudrkfxX4lC+bMWYItxbggNRqsk58/4p
        BjtBog44dKT66F7vpGtKSOXexYheqcgVvbuVwhI8s5JqSieQ
X-Google-Smtp-Source: AMsMyM4HQMM13euSxBSldw7b1HnIWnHCbPOiU15QeMZDkdhzFKutGseY3VrWmscilPSROZwBZZGGsLp17XCcP8tvHxk=
X-Received: by 2002:a05:6808:1441:b0:35a:4a2d:673b with SMTP id
 x1-20020a056808144100b0035a4a2d673bmr7623626oiv.172.1667625734380; Fri, 04
 Nov 2022 22:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhSSafrkW4VbTVoAUJmjFQdCwPTGDqTP8yBnLBqc7rW7iQ@mail.gmail.com>
 <CAHk-=wj_6Df1NAMs14S0OOqX1Z=460j-mfwn_qm-7EK1eK76qw@mail.gmail.com>
In-Reply-To: <CAHk-=wj_6Df1NAMs14S0OOqX1Z=460j-mfwn_qm-7EK1eK76qw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 5 Nov 2022 01:22:02 -0400
Message-ID: <CAHC9VhRe-oL7tHskQd9eBdpUh=PFujikL48kauZXU=xyZ1Ohag@mail.gmail.com>
Subject: Re: [GIT PULL] LSM fixes for v6.1 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 3:22 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Oct 31, 2022 at 4:07 AM Paul Moore <paul@paul-moore.com> wrote:
> >
> > A single patch to the capabilities code to fix a potential memory leak
> > in the xattr allocation error handling.  Please apply for v6.1-rcX.
>
> Pulled.

Sorry for the delay in responding, you saw this in my other response,
but limited network access, yadda yadda ...

> However, I react to the strange test condition. Sure, it's
> pre-existing, but does it really make sense?

I wasn't responsible for this code when the conditional was written,
and I've got enough mail in my backlog at the moment to not want to
sift through the git log trying to make sense of it, but the current
conditional does seem a bit "extra" when one considers
vfs_getxattr_alloc().  The only gotcha that I can see is that
vfs_getxattr_alloc() callers need to ensure that they always kfree()
the xattr_value buffer on error as vfs_getxattr_alloc() may leave
memory allocated on failure.  There was discussion of that when this
leak fix patch was posted.

I'll put together a cleanup patch to resolve the conditional oddity
and send it up during the next merge window.

> That whole "cast to int, and then cast back to size_t" also smells of
> some serious confusion in the return value handling. It looks to me
> like vfs_getxattr_alloc() fundamentally returns an 'int', not a
> 'ssize_t', just by looking at the ->get function. But it just all
> looks weird.

Yes, it's a bit of a mess.  I suspect the problem originated in that
vfs_getxattr_alloc() returns either a negative number on failure or
the size of the allocation on success, and with allocation sizes
typically using a {s}size_t type I'm guessing the original authors
chose ssize_t, which seems reasonable until one looks at the
xattr_handler's ->get() function and realizes that it returns an int.

I think the right thing to do here is to update vfs_getxattr_alloc()
to use an int return type and update all of the callers accordingly
(currently they all live under security/).  I'll put together a patch
to clean this up and send it via the next merge window assuming there
are no objections to the patch.

-- 
paul-moore.com
