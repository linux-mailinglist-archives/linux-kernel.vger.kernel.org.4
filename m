Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677AD6888C5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 22:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjBBVLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 16:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBBVLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 16:11:35 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066C17305F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 13:11:35 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id c10-20020a17090a1d0a00b0022e63a94799so6877207pjd.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 13:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FeHiybU03vjQ+UQJDzWFcxYHfJeh3kdsrPXZldCGEpc=;
        b=IgTuqQImti0eJrUYHU+x9UCPsQNWHziUvfMkPPIPM6U2L/95oCxhF1/gRk1aRUAvkM
         2slClC3Ke3ePktnEQ2JS2/KZC1tEan39quBQDiZyp68ibgoqImTk+WhiIosa8rvDGUgV
         PNhcj20NzTBc1q9G3O4CdW7ARLUyk9WBJ+7vpJPgHo5wGW28+dp9ygZPauvaVtSMIJv2
         itfuoV0T2i8O+QuYa1OExXukhQH01U91c0asjax33HY4PapWPNyg2M079udtJdp1ALyJ
         Y037J5mubjtd5zq2rDP6GDCPwt6iev7LW+yo7cvXcwVhS1a03iq3w3ckfQj3Pc9QdikM
         EYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FeHiybU03vjQ+UQJDzWFcxYHfJeh3kdsrPXZldCGEpc=;
        b=t8r7OAdosRaVi2CpRiss8wAlWgCM1Ltk3qLwunffgGQJkXq5ATroqEvt6uWqBf3HzX
         JW+f27rcOFB59VPdv/+jvw8MH5dQWbjLz26Tcc0L/0Gom3XcHShIfHdG8BrgIsYeFm0f
         o0Avi/E6Uv4sPmHPpqHIl3avEltj5c6ID4/yjftZcdHNvWzubl/x+jgq8LQ5QfW/S5d0
         goxCm/qRHLcnC32ycO75PyOMQBOWyTjUratm7fsOVjBImAgN1mk7Ya1Z4i47jWYdUTSN
         Nm+UipAyEknCqUvxzZVbgCxW9GgRMq2OPxzjH+XY8hKTIocOGlEFj6ieq9dWNEjDSBi5
         SYZg==
X-Gm-Message-State: AO0yUKWdmmKIq5urKTqdK15fXBR0shMFc5bqFnH+9hLIpXnhq6/ka/64
        bVCd62s/jndYf94ZhC7B4QPDYUahzh435kTBeRI=
X-Google-Smtp-Source: AK7set/c4ZrnqYyOltTgLLlGBV0iswebvs2HEDPjFyjpp80sjk4IkvInBBs/lbuylrfKyXWUO3P/cJgiXSDjZPMdYIA=
X-Received: by 2002:a17:902:8b82:b0:193:648:821d with SMTP id
 ay2-20020a1709028b8200b001930648821dmr2001317plb.10.1675372294422; Thu, 02
 Feb 2023 13:11:34 -0800 (PST)
MIME-Version: 1.0
References: <20230201034137.2463113-1-stevensd@google.com> <CAHbLzkpbV2LOoTpWwSOS+UUsYJiZX4vO78jZSr6xmpAGNGoH5w@mail.gmail.com>
 <Y9rRCN9EfqzwYnDG@x1n> <CAHbLzkqyhS5thdVKa-jcS5iNUNxe95hagBncWaG=CQTh=LU70w@mail.gmail.com>
 <Y9wXXoSY+QqoKMMx@x1n>
In-Reply-To: <Y9wXXoSY+QqoKMMx@x1n>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 2 Feb 2023 13:11:22 -0800
Message-ID: <CAHbLzkrYEOD6-35kjGeS6ftXJ_mfzugwLt_28n+hH3Vy-uBs3g@mail.gmail.com>
Subject: Re: [PATCH] mm/khugepaged: skip shmem with armed userfaultfd
To:     Peter Xu <peterx@redhat.com>
Cc:     David Stevens <stevensd@chromium.org>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>
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

On Thu, Feb 2, 2023 at 12:04 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Feb 01, 2023 at 03:57:33PM -0800, Yang Shi wrote:
> > > There's another problem where the current vma may not have uffd armed,
> > > khugepaged may think it has nothing to do with uffd and moved on with
> > > collapsing, but actually it's armed in another vma of either the current mm
> > > or just another mm's.
> >
> > Out of curiosity, could you please elaborate how another vma armed
> > with userfaultfd could have an impact on the vmas that are not armed?
>
> It's e.g. when >1 vmas mapped to the same shmem file on the same range, one
> registered with uffd missing, others not.  Then others can cause page cache
> populated without generating message to the vma that got uffd missing mode
> registered, so there'll be the same issue as when khugepaged accidentally
> does thp collapsings.  Thanks,

Got it, thank you.

>
> --
> Peter Xu
>
