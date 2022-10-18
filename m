Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BF860335C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 21:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiJRTb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 15:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJRTbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 15:31:22 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896926C75F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 12:31:21 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 63so18217087ybq.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 12:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Odb/3tw3luvQ0ZjN2sRl8U/xpeYJXIVedLN9LRVos5c=;
        b=Ky4Q4EdUaF3OQMCth1A9LVUmzBHBw6VgLCX8+tflalKsBkQuory/Kad2ivpmbFEX+b
         FVlwJA9z2VUOFyeaFQ6KsU2BxLVeprb/QgIkCZwva+LC+I8UzG4ZSUlhEzCTMqz3vw6t
         Ky94Vlx3tvOhjNDw2pR6bC2PIgxBZznDp2TgVWsM9HV9Pz77XlpS078z0L/zYwgVh750
         Nun/YNuXRwiBX8+m09uG1iQF/Ox8voTTy9F19InEAwxfSbtXZCULpp7kCmAmBEUkQr46
         zzqd4qrv3rCyxqsa3HEcjv3czx8eNiu6Qd/BtnBLwtAywP9mUTL6PjGEMzxv/poKW5Nv
         TZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Odb/3tw3luvQ0ZjN2sRl8U/xpeYJXIVedLN9LRVos5c=;
        b=X7VplB1+ZDEOiMtPAGgi9r+EVPtdeXTc4Ipgje9i0c2WRq8kfqzOjUFS5QKJYBf5T+
         rKkXcJ4uerJgK43haI0qsErZY8ShzAeWCsr/Os/N0A/pivMYBbFgnzMa82jX6Uz83Hxz
         H6Guib7UHbuGr7jB6OHjmSmTu+0P8nuM7tQXX5GwP3TjgfoGct1WH30LjcczD+I+97Rj
         nf25jQXYwP+sYVM5OWm4ujawrkBAeDD2TXuqdHtuhnvXPNR5TaN6MvrG+eY2kNTbl/sm
         Ph6fnZsCg9yTvB8dGxXp452SddFsD69PGN4LyPkeD3Qa0bO/d52c56a3drY4azHphsx6
         u/wg==
X-Gm-Message-State: ACrzQf3lkhDtLsNTnm0JYnvhUt4oKxSLRj8QuakRpA7XbF/6WmoTqjYn
        jRbgmr/xR7bPFcwOYAxpxEvG3qNZLShmSuvnc5TW
X-Google-Smtp-Source: AMsMyM48whLXeORVsJ9Fz0jIQtPu4VRWuj99/Or9T6IxgLAkpQY6LlfLFEp66XTHfhCP2KjGK/HWfQZJ8mDeFwSV4y0=
X-Received: by 2002:a05:6902:124d:b0:66d:5ce6:5924 with SMTP id
 t13-20020a056902124d00b0066d5ce65924mr3923045ybu.320.1666121480390; Tue, 18
 Oct 2022 12:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210222150608.808146-1-mic@digikod.net> <20210222150608.808146-2-mic@digikod.net>
 <51725b44-bc40-0205-8583-285d3b35b5ca@schaufler-ca.com> <ee461f8d-a02d-0782-8f31-691853a57f00@digikod.net>
 <7b67163a-9de1-313f-5b5a-8c720cef9b73@schaufler-ca.com> <CAJfZ7=n5FOxHXMLRrDQ3F-kDqbYngNoYKcz6_PWi1rPa0_8WpA@mail.gmail.com>
 <3b97e25b-303c-d732-3e5d-f1b1a446e090@schaufler-ca.com> <202210171111.21E3983165@keescook>
 <CAHC9VhTTKpesvjnc_233x+wG1BvXyup9nM4Dv2h1953zXAvU3A@mail.gmail.com> <202210172153.C65BF23D5E@keescook>
In-Reply-To: <202210172153.C65BF23D5E@keescook>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 18 Oct 2022 15:31:09 -0400
Message-ID: <CAHC9VhSMLjzxyu0F82NZoea-q4yMgHeCZ0-TRcvxKks4WeKacQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] security: Add CONFIG_LSM_AUTO to handle default
 LSM stack ordering
To:     Kees Cook <keescook@chromium.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Nicolas Iooss <nicolas.iooss@m4x.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 1:55 AM Kees Cook <keescook@chromium.org> wrote:
> On Mon, Oct 17, 2022 at 09:45:21PM -0400, Paul Moore wrote:
> > The code sorta cares about ordering, at least to the extent that the
> > LSMs will behave differently depending on the ordering, e.g. a LSM
>
> Right -- this is why I've been so uncomfortable with allowing
> arbitrarily reordering of the LSM list from lsm=. There are orderings we
> know work, and others may have undesirable side-effects. I'd much rather
> the kernel be specific about the order.

At this point in the ongoing process of LSM stacking I'd much rather
we focus on documenting what we know to work and what is known to be
problematic without placing any restrictions on the ordering.  I
believe there are going to be too many "good" combinations to settle
on one single supported ordering; perhaps at some point in the future
we can agree on what that ordering should be, but I think there are
still too many changes in the foreseeable future to settle on an
ordering now.

> > I personally would like to preserve the existing concept where "built"
> > does *not* equate to "enabled" by default.
>
> Yup, understood. I didn't think I was going to win over anyone on that
> one, but figured I'd just point it out again. ;)

Fair enough.

> > > I *still* think there should be a way to leave ordering alone and have
> > > separate enable/disable control.
> >
> > My current opinion is that enabling a LSM and specifying its place in
> > an ordered list are one in the same.  The way LSM stacking as
> > currently done almost requires the ability to specify an order if an
> > admin is trying to meet an security relevant operation visibility
> > goal.
>
> As in an admin wants to see selinux rejections instead of loadpin
> rejections for a blocked module loading?

When I wrote my response I was thinking more of the BPF LSM, any
future LSMs that might be merged upstream, and the myriad of security
requirements admins must meet both now and in the future.

> > We can have defaults, like we do know, but I'm in no hurry to remove
> > the ability to allow admins to change the ordering at boot time.
>
> My concern is with new LSMs vs the build system. A system builder will
> be prompted for a new CONFIG_SECURITY_SHINY, but won't be prompted
> about making changes to CONFIG_LSM to include it.

I would argue that if an admin/builder doesn't understand what a shiny
new LSM does, they shouldn't be enabling that shiny new LSM.  Adding
new, potentially restrictive, controls to your kernel build without a
basic understanding of those controls is a recipe for disaster and I
try to avoid recommending disaster as a planned course of action :)

-- 
paul-moore.com
