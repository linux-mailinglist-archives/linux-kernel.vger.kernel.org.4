Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2813169D57B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 22:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjBTVBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 16:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBTVBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 16:01:05 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA87BDF2;
        Mon, 20 Feb 2023 13:01:03 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id s20so2864449lfb.11;
        Mon, 20 Feb 2023 13:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t+AYXp7cx1zGbgbpmTlMP4RRwMZJH7DgOJzu/qs2IxM=;
        b=oV7p0yfAVYKuE1aulM8oaB0dLgOuyB7hSdrdZaM13aVptasEW7i9Lgw9aGLbAFR2y4
         m3ljbNRXM/4VLBYxzWgDVyocLaBZ9y8bUPhw8FXtOpCIv6ARyCE0mMjrHPdhuwnEljMj
         P4F4Icf9KzapXczEIfgxsoF9PGgGgCbaQ7r118YlsE5VJvgL5tuC4MGStLVwbdoQlDD/
         3ff382DfjevEY0l2dl9bxGD+8ypWqkEKkgsgZqLDtalNrAFMZoOODTkp0Hx7pmlI+RUG
         gtUjQGBKhULBLMLrDGqfa5zSwBIu0Md3dCRtulVS4LWszg3ruO2FuW1owgLeB4lr9XX/
         ikzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+AYXp7cx1zGbgbpmTlMP4RRwMZJH7DgOJzu/qs2IxM=;
        b=aSXvPjmfeM49I8aQgemOOYOx1diJ4tmjJTb34rhCvhVLkI1P15i0OeMpePS/v93Z0k
         iFpDclYUcnvP6bjBIJUiUACBSnpXfhKudzLp2E3slZVS+JMd2v/i1kjVsbL4L0pOMIi4
         IFUuHdNigYVXWvAdexvmwvPeH/Ub6ybNxaTPvrMb+j5USLKw4kV7Nluf+1eYr0mARIAk
         IIHSN7+xw1Dam4cWSI08q/3oNIFAMi31giaoB6UyuPZL/d4OT1vyVlaqw9P6u9GShLDM
         cgdI+RzzjV/q3EOyJAnO6dKqaseprZOISZ/sLGoX67K+yhhlpOr8nwjmqqCa97ZOpJtO
         uBww==
X-Gm-Message-State: AO0yUKVg4NlICKQSQsUqM6MUSyjwm+mGEatIORFxZLE2o4xt2DD3+UIr
        vcdr0Mpu6DvZrbZ7CX6KkUArruN/9fILx7JCHTQ=
X-Google-Smtp-Source: AK7set/6lpjDqJlDtMmjaOZFg4AkK0TLe0+lJKxxu/gKWkIUH8cEpHVSp9vFkgXkoZcAdmfAQX1u461L9IzDTj0Fatg=
X-Received: by 2002:a19:c501:0:b0:4d5:ca32:7bc3 with SMTP id
 w1-20020a19c501000000b004d5ca327bc3mr1057826lfe.10.1676926861829; Mon, 20 Feb
 2023 13:01:01 -0800 (PST)
MIME-Version: 1.0
References: <20230220152933.1ab8fa4a@canb.auug.org.au> <Y/N8hVWeR3AjssUC@casper.infradead.org>
 <20230220190157.3b43b9a7@canb.auug.org.au>
In-Reply-To: <20230220190157.3b43b9a7@canb.auug.org.au>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 20 Feb 2023 15:00:50 -0600
Message-ID: <CAH2r5ms6J_hWmLaLA=pCQz1oez3bO07ahvr6mdCbYzQHrNVNkA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the mm-stable tree with the cifs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Steve French <stfrench@microsoft.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 2:55 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Matthew,
>
> On Mon, 20 Feb 2023 13:58:29 +0000 Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Mon, Feb 20, 2023 at 03:29:33PM +1100, Stephen Rothwell wrote:
> > >
> > > Today's linux-next merge of the mm-stable tree got a conflict in:
> > >
> > >   fs/cifs/file.c
> > >
> > > between commit:
> > >
> > >   c8859bc0c129 ("cifs: Remove unused code")
> > >
> > > from the cifs tree and commits:
> > >
> > >   4cda80f3a7a5 ("cifs: convert wdata_alloc_and_fillpages() to use filemap_get_folios_tag()")
> > >   d585bdbeb79a ("fs: convert writepage_t callback to pass a folio")
> > >
> > > from the mm-stable tree.
> > >
> > > This is a real mess :-(
> >
> > Doesn't look too bad to me.  Dave's commit is just removing the
> > functions, so it doesn't matter how they're being changed.
>
> The problem I see is that an earlier commit in the cifs tree moves the
> use of find_get_pages_range_tag() to another function and 4cda80f3a7a5
> then removes find_get_pages_range_tag().
>
> > The real question in my mind is why for-next is being updated two days
> > before the merge window with new patches.  What's the point in -next
> > if patches are being added at this late point?
>
> Indeed :-(

I don't think it was so much that they were added late (most were
reviewed over multiple week period) - just moved trees to make it
easier a week ago.  The changes David etc. have been making recently
to the series seemed fairly small.  And I am hoping that his series
allows removal of more dead code as well. Also FYI Paulo caught a
minor bug in one of Dave's patches while testing today, and I noticed
a merge conflict with a small unrelated patch that went into
mm/filemap.c for rc8 so I am rebasing my cifs-2.6.git for-next on 6.2
now (to avoid that merge conflict) and will update later this
afternoon with the trivial fix for the problem Paulo pointed out.


-- 
Thanks,

Steve
