Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49C26CA528
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjC0NFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjC0NFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:05:36 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C368710CC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:05:33 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5445009c26bso168865937b3.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679922333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kI4+ZML1G+b7UOhhIPy0YcoMp05rWzeHpNMkjZ5sBM=;
        b=eGJbxFAKr99gaJCfSPpVY6tAXOC7kz1Z46129jPkjmRZI15o7BPYTsYLErf27oMdMa
         GUEx4Rgn5/dQ3LeRfTITSn6S4uYMdJTLqtSnS79SyCvaq9ls8IPQA9fMDTQYAVVwHjp/
         pWBmRSCoqH8ZuxqsM+EWBOBvuqrG5hXlmmh/bLryQcUo7seFk9YLrZYAL3zrNhsY7KUl
         rJ7mXz6/dF/TQIgEAZ0ih4evyEwWOaEINft6m0VhmKRaCDqvCs0ZrTztGn/ax1nenvjn
         btfKj1Rr6PjxEIWbe6qXRwEdnO9jN3lzWNpK9PXsdPMDIBW9xys9iXb/AMtMBSq2emOU
         mi8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679922333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kI4+ZML1G+b7UOhhIPy0YcoMp05rWzeHpNMkjZ5sBM=;
        b=1hP444GZV7rdLDkH98eeyShOvgiFRoXmSpPOUGDrwH50U680O4VNPMLSlJrrXljlhJ
         s2gxlklli7Ktwg7F2hMO3EyDiXzN+kvFMRGjKCBccNngyLe62hwQN0lvUDSvkURvtO+z
         hYmXiqUlkn8FedSZwvBT/34IpyD2Fj1utDIGwEpIVyFr5zaWozFjyTiWEDHbQzVtasRT
         tyNh4Qd5BB4/eZVqxtLEdE8qS/xJkClc9BwyYdtO0y+ZtyfJHqoTQChIygzc25lnlcWK
         OzE/T5Ro/74wp1y8EGOFlRMc3uN4+frTHm+Hew+VH+pzbNf+XvhKWx08q38A+mm406Sg
         h23g==
X-Gm-Message-State: AAQBX9cubzZZT3olrkh+qqrqDbLAS8AfrIC0xTPaMCOQCHrMcidT7fox
        ia2xPyMDTNL9jUNknCbRZui/Wooo+pZbWkpq/e8=
X-Google-Smtp-Source: AKy350Z4VggKyeXerp4WTMHkr70rECNj3yJhtgG+y0uIKDVAuijNVMVhTx7ee5r0HbhuJJ+bP33wjPL819meQ/JtP90=
X-Received: by 2002:a81:ae4f:0:b0:545:ed8e:f4f6 with SMTP id
 g15-20020a81ae4f000000b00545ed8ef4f6mr1504273ywk.5.1679922332668; Mon, 27 Mar
 2023 06:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <ZA0FEyOtRBvpIXbi@bombadil.infradead.org> <CAFkjPTmVbyuA0jEAjYhsOsg-SE99yXgehmjqUZb4_uWS_L-ZTQ@mail.gmail.com>
 <ZBSc1jjYJn6noeMl@bombadil.infradead.org>
In-Reply-To: <ZBSc1jjYJn6noeMl@bombadil.infradead.org>
From:   Eric Van Hensbergen <ericvh@gmail.com>
Date:   Mon, 27 Mar 2023 08:05:21 -0500
Message-ID: <CAFkjPTmc-OgMEj9kF3y04sRGeOVO_ogEv1fGG=-CfKP-0ZKC_g@mail.gmail.com>
Subject: Re: 9p caching with cache=loose and cache=fscache
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Jeff Layton <jlayton@kernel.org>, lucho@ionkov.net,
        asmadeus@codewreck.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, took a bit to unstack from day job, but while going through the
patch queue I remembered I still had some questions to answer here.

On Fri, Mar 17, 2023 at 12:01=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.or=
g> wrote:
>
> On Sun, Mar 12, 2023 at 01:22:34PM -0500, Eric Van Hensbergen wrote:
> > I was looking at kdevops the other day - cool stuff.  Was trying to
> > figure out how we could do v9fs CI with it.
>
> Happy to help any questions you may have about it!
>
> > Both cache=3Dloose and cache=3Dfscache currently don't validate via hos=
t.
>
> What does this mean exactly?
>

That's a good question - I guess the answer is "by design" they don't
do anything special to check that the cache is up to date with the
host.  That being said, there are several places in the code where the
cache will be invalidated (in some cases even if its up to date with
the host, yes, those are likely bugs).  Many of the invalidations that
are present are overly conservative.  The key missing one is
v9fs_lookup_revalidate which currently fills missing inode data but
should potentially also check to see if anything in the file changed
and react accordingly.  The other thing is that we aren't always using
the caches when we should, if you look at the traffic even when
everything should be perfectly cached in fscache we are getting data
and metadata from the wire -- those are mostly bugs in the cache
implementation that I'm trying to go through and fix now.

From the 9p perspective, we should be looking at qid.version values
returned from the host and matching them to our internal notion of
version.  If the versions don't match we should be invalidating
caches.  qid.versions get returned on open, lookup, and most meta-data
operations so there's lots of opportunities there.  There are still
some issues with this approach, namely that not all servers populate
qid.version and right now the ones that do use a hashed timestamp
(since qid.version is only 32-bits).  This probably covers most bases,
but its not ideal -- so currrently thinking through whether we do a
further extension of the protocol or use some other mechanism.
There's a possibility of using a full getattr every so often to
back-up qid.version validation, but if we want truly tight coherence
(not just open to close) then we need to open up some sort of back
channel for invalidates from the server -- but I think the qid based
invalidation probably gets us most of what we need so going to start
with that.

> Right now a host with debian 6.0.0-6-amd64 certainly does not seem to pus=
h
> out changes to 9p clients on VMs but Josef informs me that with 6.2-rc8
> he did see the changes propagate.

I did tighten up some of the invalidation in the last round of
patches, however these are likely more on the overly conservative side
versus doing the right thing -- however, its really not at the point
where you can rely on it.  If consistency is something you care about,
I'd suggest cache=3Dnone until you can get cache=3Dreadahead.

>
> Do none of the existing 9p cache modes not support open-to-close policies
> at all?
>

not specifically open-to-close, loose supports file and dir caching
but without consistency, it might be tempting to try cache=3Dmmap to see
if it gets you closer, but my frame of reference is more the current
patches versus the old code so not sure it would buy you anything.

>
> Right now the cache mode used is cache=3Dloose as that's the default,
> what do you recommend for a typical kernel development environemnt?
>

As I said, if you are interactively changing things I think you'd want
to go for cache=3Dnone for now (as painful as it is).  I have fixed what
I hope to be my last bug with the new patch series so it should be
going into linux-next today.

      -eric
