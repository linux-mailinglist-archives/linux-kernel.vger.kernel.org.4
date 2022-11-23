Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846FB636553
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 17:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238613AbiKWQGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 11:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238512AbiKWQGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 11:06:31 -0500
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BD11088;
        Wed, 23 Nov 2022 08:06:29 -0800 (PST)
Received: by mail-qk1-f172.google.com with SMTP id j26so5584193qki.10;
        Wed, 23 Nov 2022 08:06:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NvAz8VTWEj1QZNwzkHkmPpJH4VWeA6kRnRjefoqZBuI=;
        b=JUBOtDMnwv0MQNUSFSEUzsUEp7i9KBn3ukBz+0KZ+4P+2VnvP8QLEu+K9qqQK9/5Sa
         klnMf7x6mDMTlYosD8/BpxF9MmRS1x7nGOnEE+MP5hajXWAnuuspPfqS9HUbl4lkA4NE
         vGSCqoU7z7OnjTTS0k5t1WyjVlheku0A05YsC2PCDYg8x0gWRqLT28RnNShw2YxlVOnK
         m0kNtK7TfA5xEKYNnhCZLri2+lr8P3IuE47LTV85G6q8bXNM1UEHrRnJUBLX0FuIAJ6O
         cVE4QMbQUwfU8mMIBwm/dtZsW9ITjEhZ9K50mPMx6ZkU0j5gXoE/aaLAF+tluRM6Ve6w
         NS5A==
X-Gm-Message-State: ANoB5pkZuIM5bF/Aime198OSZXQMmUIuuPSIMa1q8VuOm+vQRO72r/h1
        hCrsxcQa8ApDmuvX1WHVsmTA+Ig/qfrDzQ==
X-Google-Smtp-Source: AA0mqf7PNoZ9TakHW++yj0Qw5o9FOrbI0Bf4vFhaPH6IolnzOXzhSK3f7OyuD1iMAKgQb0qVdsIOqw==
X-Received: by 2002:a05:620a:2005:b0:6fa:2ddc:87f4 with SMTP id c5-20020a05620a200500b006fa2ddc87f4mr10809980qka.479.1669219588768;
        Wed, 23 Nov 2022 08:06:28 -0800 (PST)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id bn4-20020a05622a1dc400b003a62dcf09f0sm8624146qtb.6.2022.11.23.08.06.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 08:06:28 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id 205so2112669ybf.6;
        Wed, 23 Nov 2022 08:06:28 -0800 (PST)
X-Received: by 2002:a25:9e84:0:b0:6de:6183:c5c3 with SMTP id
 p4-20020a259e84000000b006de6183c5c3mr9144415ybq.89.1669219585142; Wed, 23 Nov
 2022 08:06:25 -0800 (PST)
MIME-Version: 1.0
References: <a50fa46075fb760d8409ff6ea2232b2ddb7a102b.1669046259.git.geert+renesas@glider.be>
 <20221123100831.GE39395@tom-ThinkPad-T14s-Gen-2i> <CAMuHMdUW8iKFjDj4fPtWfPvyQ1sjGcAy1Kz5j-osz9F4pdA47Q@mail.gmail.com>
 <Y344AdRANmS3STsd@kadam> <CAMuHMdVRZhBECgABtTxe00gM7_EqBaX5auZhmjUfmcLx4zoetQ@mail.gmail.com>
 <Y35Bm8bhKojxzdox@kadam>
In-Reply-To: <Y35Bm8bhKojxzdox@kadam>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 23 Nov 2022 17:06:13 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUsqpG2GsYn_Pa_6me+vmYKZ6C2vrXLRhSWCDefezw=hg@mail.gmail.com>
Message-ID: <CAMuHMdUsqpG2GsYn_Pa_6me+vmYKZ6C2vrXLRhSWCDefezw=hg@mail.gmail.com>
Subject: Re: [PATCH resend] media: staging: stkwebcam: Restore
 MEDIA_{USB,CAMERA}_SUPPORT dependencies
To:     Dan Carpenter <error27@gmail.com>
Cc:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Wed, Nov 23, 2022 at 4:52 PM Dan Carpenter <error27@gmail.com> wrote:
> On Wed, Nov 23, 2022 at 04:49:05PM +0100, Geert Uytterhoeven wrote:
> > On Wed, Nov 23, 2022 at 4:11 PM Dan Carpenter <error27@gmail.com> wrote:
> > > On Wed, Nov 23, 2022 at 11:13:31AM +0100, Geert Uytterhoeven wrote:
> > > > On Wed, Nov 23, 2022 at 11:08 AM Tommaso Merciai
> > > > <tommaso.merciai@amarulasolutions.com> wrote:
> > > > > On Mon, Nov 21, 2022 at 04:58:33PM +0100, Geert Uytterhoeven wrote:
> > > > > > By moving support for the USB Syntek DC1125 Camera to staging, the
> > > > > > dependencies on MEDIA_USB_SUPPORT and MEDIA_CAMERA_SUPPORT were lost.
> > > > > >
> > > > > > Fixes: 56280c64ecacc971 ("media: stkwebcam: deprecate driver, move to staging")
> > > > >
> > > > > Patch itself looks good but we have some style issue. Applying this
> > > > > patch I got the following warning from checkpatchl:
> > > > >
> > > > > WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes: 56280c64ecac ("media: stkwebcam: deprecate driver, move to staging")'
> > > > > #10:
> > > > >
> > > > > You have to pass only the first 12 chars of the sha1 commit into Fixes
> > > > > msg:
> > > > >
> > > > > Use:
> > > > >
> > > > >  Fixes: 56280c64ecac ("media: stkwebcam: deprecate driver, move to staging")
> > > > >
> > > > > Instead of:
> > > > >
> > > > >  Fixes: 56280c64ecacc971 ("media: stkwebcam: deprecate driver, move to staging")
> > > >
> > > > I always use 16 chars, to avoid these becoming ambiguous in a few years.
> > >
> > > If we assume hashes are randomly distributed and that people commit
> > > 100k patches every year then with 12 character we would have 17
> > > collisions every 1000 years.
> >
> > So I can expect to see a collision before my retirement day
> > (which coincides with the signed 32-bit time_t flag day ;-)
> >
> > BTW, does the above take into account that commit hashes can
> > collide with other object type hashes, too?
>
> I assumed that `git show` won't show those other object types, but I
> don't really know if that's true.

"git show" is not limited to commit types:

$ git cat-file commit eb7081409f94a9a8608593d0fb63a1aa3d6f95d8
tree 0e320b5ae477efe1c9928057762bf63d730204ce
parent c6c67bf9bc2714d9c2c2e7ecfbf29d912b8c4f17
author Linus Torvalds <torvalds@linux-foundation.org> 1668988936 -0800
committer Linus Torvalds <torvalds@linux-foundation.org> 1668988936 -0800

Linux 6.1-rc6
$ git show 0e320b5ae477efe1c9928057762bf63d730204ce
tree 0e320b5ae477efe1c9928057762bf63d730204ce

.clang-format
.cocciconfig
[...]
$ git show eb708
error: short SHA1 eb708 is ambiguous
hint: The candidates are:
hint:   eb7081409f94a9a8 commit 2022-11-20 - Linux 6.1-rc6
hint:   eb708b0ff972bfe0 commit 2016-11-12 - arm64: dts: Add ARM PMU
node for exynos7
hint:   eb7080213d0fee54 tree
hint:   eb7080d36f660012 tree
hint:   eb7083e15bcb5eea tree
hint:   eb7083f45a088bf3 tree
hint:   eb7084a7ae5f486a tree
hint:   eb70866f5c60a477 tree
hint:   eb7087c754052a42 tree
hint:   eb7089eeb5f67a5f tree
hint:   eb708a906ceeea91 tree
hint:   eb708c1853ce1355 tree
hint:   eb708ca4d77be915 tree
hint:   eb708e4839466fdd tree
hint:   eb708431cb964d36 blob
hint:   eb708b77c4a54a68 blob
fatal: ambiguous argument 'eb708': unknown revision or path not in the
working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'

I couldn't find an easy way to count the number of objects per
type in a repository.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
