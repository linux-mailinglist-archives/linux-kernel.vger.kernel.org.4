Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D8E5ECF07
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbiI0U6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbiI0U6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:58:30 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A05D1EB186
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 13:58:01 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q9so10456171pgq.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 13:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=d8Rj8Gu6AN5MTrodWGK289Ce7G2GZRGaw3FFJPEJszg=;
        b=Equxq5NSv3SlwTUUxuJJDBwJzdD2LHv/bFSrJTVWX/7CutjYBN6cDYKP8NONysBmaf
         3MupduccMRMN4AFZEpls5jk6lcSB0mi/2zG+0VZnQ+S45Ryq0b4V6CjJabB5xnbw6JP/
         /QPlKouVl1YsfuPzLpU2M6XmOigDZguU06hzCWM9g6wxnOS+yuneFSk3J8xcZW5UE6aa
         RtAda/hNf4NirCHE+bPgPexdrfZ+uU+IO0g4O0Ov3t8oTeK986Q22Z1Bm0Eh0oE/Wave
         nZx66f+kXumFDl3Y1T3F0RN+k7BVtAqvrKXrRaXay7Rvn2R/ztXHOPvn+7BF/e/aF0uD
         gy3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=d8Rj8Gu6AN5MTrodWGK289Ce7G2GZRGaw3FFJPEJszg=;
        b=WMo+xLsFeRX3W8cA11YFbId3R7bYX8BLb97eFZHlvBDb+GDAVWsvlSPkiB42VuZA7w
         QDWspiIzOHamsVVK+5WE3Q2C3VBHxtQoc+Eg9UHzt9p7N/i9L22BKlTocg3hK0N4/TnF
         EuxqM3WVwp9VY+rrOlKUtfDt/EFTYgLlBplexze6wOWfCBsfJu+HTLZzYx4R29i/jzhX
         Fz5p9w5ZSaBsYeIVLZDDX13i+84tO7q1dR3L0heFS28hDRsqV3v61Mf1DZ3ulKPAo/dc
         1zfcL+LCJbNR/eGVLAMLFypVUaWqfb7MHPGEgrF68FY5zgtADyBW9GA177Ktlq07MoFW
         kdJQ==
X-Gm-Message-State: ACrzQf2g2WY2B/BP2Ut/py/3bAQfqpYI58AWNEygxRJgzKSEApdPk7xw
        SCPOmJDAIHrqbtJF0k5fWb13Vw/S+Muv9sPvMIc=
X-Google-Smtp-Source: AMsMyM6rMcK+GhETkHk+EvI7IdkCyqx4SVNsKv46/AY5oHrW6p+Tij74LnlWI/AsI/z/uUMZv2qJhwdHsLYjTf7vxjA=
X-Received: by 2002:aa7:88c9:0:b0:541:2b7:d655 with SMTP id
 k9-20020aa788c9000000b0054102b7d655mr31307229pff.72.1664312280251; Tue, 27
 Sep 2022 13:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220921060616.73086-1-ying.huang@intel.com> <20220921060616.73086-3-ying.huang@intel.com>
 <87o7v2lbn4.fsf@nvdebian.thelocal> <CAHbLzkpPNbggD+AaT7wFQXkKqCS2cXnq=Xv3m4WuHLMBWGTmpQ@mail.gmail.com>
 <87fsgdllmb.fsf@nvdebian.thelocal> <87ill937qe.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <46807002-c42c-1232-0938-5b48050171ee@nvidia.com>
In-Reply-To: <46807002-c42c-1232-0938-5b48050171ee@nvidia.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 27 Sep 2022 13:57:47 -0700
Message-ID: <CAHbLzkqRyav0fZ5gzaKbkTfGBxkQXTpu0NJz-A9j7UaHhVBxEQ@mail.gmail.com>
Subject: Re: [RFC 2/6] mm/migrate_pages: split unmap_and_move() to _unmap()
 and _move()
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 1:35 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 9/26/22 18:51, Huang, Ying wrote:
> >>> But there might be other cases which may incur deadlock, for example,
> >>> filesystem writeback IIUC. Some filesystems may lock a bunch of pages
> >>> then write them back in a batch. The same pages may be on the
> >>> migration list and they are also dirty and seen by writeback. I'm not
> >>> sure whether I miss something that could prevent such a deadlock from
> >>> happening.
> >>
> >> I'm not overly familiar with that area but I would assume any filesystem
> >> code doing this would already have to deal with deadlock potential.
> >
> > Thank you very much for pointing this out.  I think the deadlock is a
> > real issue.  Anyway, we shouldn't forbid other places in kernel to lock
> > 2 pages at the same time.
> >
>
> I also agree that we cannot make any rules such as "do not lock > 1 page
> at the same time, elsewhere in the kernel", because it is already
> happening, for example in page-writeback.c, which locks PAGEVEC_SIZE
> (15) pages per batch [1].
>
> The only deadlock prevention convention that I see is the convention of
> locking the pages in order of ascending address. That only helps if
> everything does it that way, and migrate code definitely does not.
> However...I thought that up until now, at least, the migrate code relied
> on trylock (which can fail, and so migration can fail, too), to avoid
> deadlock. Is that changing somehow, I didn't see it?

The trylock is used by async mode which does try to avoid blocking.
But sync mode does use lock. The current implementation of migration
does migrate one page at a time, so it is not a problem.

>
>
> [1] https://elixir.bootlin.com/linux/latest/source/mm/page-writeback.c#L2296
>
> thanks,
>
> --
> John Hubbard
> NVIDIA
>
> > The simplest solution is to batch page migration only if mode ==
> > MIGRATE_ASYNC.  Then we may consider to fall back to non-batch mode if
> > mode != MIGRATE_ASYNC and trylock page fails.
> >
>
>
