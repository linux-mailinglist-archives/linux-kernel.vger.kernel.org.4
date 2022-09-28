Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512075ED2CB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 03:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbiI1Btu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 21:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbiI1Btm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 21:49:42 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A3124083
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 18:49:40 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s206so10960721pgs.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 18:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=1Vfi7AWXnCaO1Cvd6Mq1uY3je2KBMWFZikWbaMnkxjs=;
        b=IYgVPuHGVgqxXqBtQ4CxDDSitmzKee8iPhjwCnhB5LqwP0ZVxGeasHxlxZAZYeq6lA
         31OX8D8oVX7srZsi6Uxggwg9OgePvurQahGvY9h0OjYmh0mqFUYc6omFw38WUNwfPEtV
         vSYv6BuQ6O/z2mxVNPXO/F++1as6A/Vk+f8cCBX6MF7GbHLqkXZJSzvrC5QK9D/HdpWL
         jIs0MnvXbDwvlRn0q5ax+iY+h+2HOz5KG/Dc+PONBZftxCHiDUx4zq/0+i2cHyHUok9c
         SgykyqlCcypggE8IZR/mKQjBhM+mTuZmQpYPJxKOE/oC0npO8xLTKpDsH5vhAoGJzrMM
         4wOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1Vfi7AWXnCaO1Cvd6Mq1uY3je2KBMWFZikWbaMnkxjs=;
        b=tQ5L+eCgzQjf0K0VAZNrcQp+RUdPh3v7CX/NPpGb1DbYZQTjm7Oio/EZC3Y5MlU6qA
         aj3z5w8d3sNZkF3KRRkpK1yWbZS6fxAbUurZna8n/E1JK3kGa/6Q3vg6O4nrE3UFLj2X
         +xtbiHBWBdWBJt5nVIvHlAru3j2Tq+X+hy4WrP0+ez2ZC0CGkVgfaFYPW/CQZajhYOSz
         hPzvEdY+NnDlg075CdXquJRL58kEI0juWho3Kjwxp4jtNKuzrR32SFMp9mi6ag4COtVi
         p6y4lvrmWIbw/e4VnH28+fr8y4rPBi5MMuP/qKxFsYGtDv75Xa1YNCNvUNmq5rUk9Cvg
         mYZg==
X-Gm-Message-State: ACrzQf34z2KoPKBHD6/lR8mPPCw+JFJSuCc0febyVQGGf0wVyQCBVRSJ
        c75N9SUNqRdYcxj73eaecOhe/34Ijvynds4AsjWJcx7/q5M=
X-Google-Smtp-Source: AMsMyM7RPrYtnz+qDp9SF9zc6a+NCzoGQQItskFz2opRNwqaDk1x3Q1i5kdwn4kq5aetoXezYMNrwvX9bNIBDHpdkYk=
X-Received: by 2002:aa7:88c9:0:b0:541:2b7:d655 with SMTP id
 k9-20020aa788c9000000b0054102b7d655mr32420304pff.72.1664329779633; Tue, 27
 Sep 2022 18:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220921060616.73086-1-ying.huang@intel.com> <20220921060616.73086-3-ying.huang@intel.com>
 <87o7v2lbn4.fsf@nvdebian.thelocal> <CAHbLzkpPNbggD+AaT7wFQXkKqCS2cXnq=Xv3m4WuHLMBWGTmpQ@mail.gmail.com>
 <87fsgdllmb.fsf@nvdebian.thelocal> <87ill937qe.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <46807002-c42c-1232-0938-5b48050171ee@nvidia.com> <CAHbLzkqRyav0fZ5gzaKbkTfGBxkQXTpu0NJz-A9j7UaHhVBxEQ@mail.gmail.com>
 <87pmfgjnpj.fsf@nvdebian.thelocal> <87czbg2s3b.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <240bbb01-1f26-71ee-233a-ad65313ac358@nvidia.com>
In-Reply-To: <240bbb01-1f26-71ee-233a-ad65313ac358@nvidia.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 27 Sep 2022 18:49:26 -0700
Message-ID: <CAHbLzkpnCTD_c60QPu25hPymCYwLP6fYRMxp1EWmzX0SBF4g1w@mail.gmail.com>
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

On Tue, Sep 27, 2022 at 6:45 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 9/27/22 18:41, Huang, Ying wrote:
> >>>> I also agree that we cannot make any rules such as "do not lock > 1 page
> >>>> at the same time, elsewhere in the kernel", because it is already
> >>>> happening, for example in page-writeback.c, which locks PAGEVEC_SIZE
> >>>> (15) pages per batch [1].
> >>
> >> That's not really the case though. The inner loop of write_cache_page()
> >> only ever locks one page at a time, either directly via the
> >> unlock_page() on L2338 (those goto's are amazing) or indirectly via
> >> (*writepage)() on L2359.
> >>
> >> So there's no deadlock potential there because unlocking any previously
> >> locked page(s) doesn't depend on obtaining the lock for another page.
> >> Unless I've missed something?
> >
> > Yes.  This is my understanding too after checking ext4_writepage().
> >
>
> Yes, I missed the ".writepage() shall unlock the page" design point. Now
> it seems much more reasonable and safer. :)

.writepage is deprecated (see
https://lore.kernel.org/linux-fsdevel/20220719041311.709250-1-hch@lst.de/),
write back actually uses .writepages.

>
> thanks,
>
> --
> John Hubbard
> NVIDIA
>
