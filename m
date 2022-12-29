Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D515658A66
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 09:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbiL2ISv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 03:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiL2ISC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 03:18:02 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D6C13F63
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 00:17:13 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id r26so20574106edc.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 00:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w0NMCIz7aH+VtGKA1bV7VY9PC5bA85xBilVtidrBy8A=;
        b=Dv54hQGxUOdBIlokyeIJGJM6C9dSb3WVRynrmpQdXN4zRwmNZbdD6fSlv8r6gBwxHw
         c59E7zQLobJEgVpznEZ+LJjUufBU4Gm7pmBUoRzl6FXxrUcIIRktCKOSpDR7Si+60hLO
         hbdIMmrf6vVI4hz95givK9GKzPnRV3GQ4ca5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w0NMCIz7aH+VtGKA1bV7VY9PC5bA85xBilVtidrBy8A=;
        b=IoF0TUR0KCwiGv869r3HtFaSZRtqkT+5J9V1iXJsns+iRH+XTXb0A8IuP/P+KRYbvy
         JEUNimstJm1CQP7LVYrr6RFJI4nA1jo+c1/H+z6T9wWQx8UJjOP/VrMTff7GKtTPKrJl
         sv/FT72O6qDXlG681pVQXPHHhpv2dV32nw5zCU6SAJobXTYbPMd0oyrvTQeUceaA9u7G
         al2NZRmvNel79h3YoOu/VbvxZ1NN3fzxzq8ImXZsReLYKuwq3lt6+iQ2U2CS0wpaZ7bx
         iGIrOPWo7/B38ak9SWT7FSjpODmjtsZu1by73S7s598ybjNvUYO0Rhcp6LzGn+dCbqRZ
         nfiw==
X-Gm-Message-State: AFqh2kq94lQYJl/CS52Xvj7t26waD+I5e/IU5ZhLDNP14eEFB+AKMnNC
        fwM17ZbG4dr+GuDXy37tSwq94lHtVj1eXhNfQWae3w==
X-Google-Smtp-Source: AMrXdXu3EKpSmLPFvCpiaXPU3Qs1Jd81kJn1isDVUcu3PP3d3QTMj7mvfgCejXWSIQqTSxpfbstvHC/uh543CNwAPrU=
X-Received: by 2002:a05:6402:f27:b0:485:8114:9779 with SMTP id
 i39-20020a0564020f2700b0048581149779mr1316677eda.41.1672301831977; Thu, 29
 Dec 2022 00:17:11 -0800 (PST)
MIME-Version: 1.0
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <YyQTM5PRT2o/GDwy@fedora> <CAG9=OMPHZqdDhX=M+ovdg5fa3x4-Q_1r5SWPa8pMTQw0mr5fPg@mail.gmail.com>
 <Yylvvm3zVgqpqDrm@infradead.org> <CAAKderPF5Z5QLxyEb80Y+90+eR0sfRmL-WfgXLp=eL=HxWSZ9g@mail.gmail.com>
 <YymkSDsFVVg1nbDP@infradead.org> <CAAKderNcHpbBqWqqd5-WuKLRCQQUt7a_4D4ti4gy15+fKGK0vQ@mail.gmail.com>
 <Yy1zkMH0f9ski4Sg@infradead.org> <Yy29y/jUvWM6GRZ5@redhat.com>
In-Reply-To: <Yy29y/jUvWM6GRZ5@redhat.com>
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
Date:   Thu, 29 Dec 2022 00:17:00 -0800
Message-ID: <CAG9=OMPQEoMVpXD8PeHwkymwk-zfB3mSvDO_W6h0S3Zom62JBQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/8] Introduce provisioning primitives for thinly
 provisioned storage
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Daniil Lunev <dlunev@google.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bart Van Assche <bvanassche@google.com>,
        Mike Snitzer <snitzer@kernel.org>,
        linux-kernel@vger.kernel.org, Gwendal Grignou <gwendal@google.com>,
        virtualization@lists.linux-foundation.org, dm-devel@redhat.com,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-ext4@vger.kernel.org, Evan Green <evgreen@google.com>,
        Alasdair Kergon <agk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 7:08 AM Mike Snitzer <snitzer@redhat.com> wrote:
>
> On Fri, Sep 23 2022 at  4:51P -0400,
> Christoph Hellwig <hch@infradead.org> wrote:
>
> > On Wed, Sep 21, 2022 at 07:48:50AM +1000, Daniil Lunev wrote:
> > > > There is no such thing as WRITE UNAVAILABLE in NVMe.
> > > Apologize, that is WRITE UNCORRECTABLE. Chapter 3.2.7 of
> > > NVM Express NVM Command Set Specification 1.0b
> >
> > Write uncorrectable is a very different thing, and the equivalent of the
> > horribly misnamed SCSI WRITE LONG COMMAND.  It injects an unrecoverable
> > error, and does not provision anything.
> >
> > > * Each application is potentially allowed to consume the entirety
> > >   of the disk space - there is no strict size limit for application
> > > * Applications need to pre-allocate space sometime, for which
> > >   they use fallocate. Once the operation succeeded, the application
> > >   assumed the space is guaranteed to be there for it.
> > > * Since filesystems on the volumes are independent, filesystem
> > >   level enforcement of size constraints is impossible and the only
> > >   common level is the thin pool, thus, each fallocate has to find its
> > >   representation in thin pool one way or another - otherwise you
> > >   may end up in the situation, where FS thinks it has allocated space
> > >   but when it tries to actually write it, the thin pool is already
> > >   exhausted.
> > > * Hole-Punching fallocate will not reach the thin pool, so the only
> > >   solution presently is zero-writing pre-allocate.
> >
> > To me it sounds like you want a non-thin pool in dm-thin and/or
> > guaranted space reservations for it.
>
> What is implemented in this patchset: enablement for dm-thinp to
> actually provide guarantees which fallocate requires.
>
> Seems you're getting hung up on the finishing details in HW (details
> which are _not_ the point of this patchset).
>
> The proposed changes are in service to _Linux_ code. The patchset
> implements the primitive from top (ext4) to bottom (dm-thinp, loop).
> It stops short of implementing handling everywhere that'd need it
> (e.g. in XFS, etc). But those changes can come as follow-on work once
> the primitive is established top to bottom.
>
> But you know all this ;)
>
> > > * Thus, a provisioning block operation allows an interface specific
> > >   operation that guarantees the presence of the block in the
> > >   mapped space. LVM Thin-pool itself is the primary target for our
> > >   use case but the argument is that this operation maps well to
> > >   other interfaces which allow thinly provisioned units.
> >
> > I think where you are trying to go here is badly mistaken.  With flash
> > (or hard drive SMR) there is no such thing as provisioning LBAs.  Every
> > write is out of place, and a one time space allocation does not help
> > you at all.  So fundamentally what you try to here just goes against
> > the actual physics of modern storage media.  While there are some
> > layers that keep up a pretence, trying to that an an exposed API
> > level is a really bad idea.
>
> This doesn't need to be so feudal.  Reserving an LBA in physical HW
> really isn't the point.
>
> Fact remains: an operation that ensures space is actually reserved via
> fallocate is long overdue (just because an FS did its job doesn't mean
> underlying layers reflect that). And certainly useful, even if "only"
> benefiting dm-thinp and the loop driver. Like other block primitives,
> REQ_OP_PROVISION is filtered out by block core if the device doesn't
> support it.
>
> That said, I agree with Brian Foster that we need really solid
> documentation and justification for why fallocate mode=0 cannot be
> used (but the case has been made in this thread).
>
> Also, I do see an issue with the implementation (relative to stacked
> devices): dm_table_supports_provision() is too myopic about DM. It
> needs to go a step further and verify that some layer in the stack
> actually services REQ_OP_PROVISION. Will respond to DM patch too.
>
Thanks all for the suggestions and feedback! I just posted v2 (more
than a bit belatedly) on the various mailing lists with the relevant
fixes, documentation and some benchmarks on performance.

Best
Sarthak
