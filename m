Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10204718BD1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 23:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjEaV3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 17:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjEaV3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 17:29:17 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2B3139
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 14:29:13 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-19f31d6b661so291996fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 14:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568553; x=1688160553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYHuYeE6oEUE8+vrjatCnxeEf3RtgdobAuLayKpBWO4=;
        b=Vak27gPxJ46JwMnCZuYZ426+DhrhIx+yguw2rLxKOzRbf5Ozch1xMz5bqzx234GYqG
         4zAClrF0EKdVC6qMQaFzDMc50vgFZCG5bH5oF3aLx4E0n4cxanXKtJEvf+CUhH3/QEly
         Au+fTtBkc/Hz4poeHCsNXL7Hd8Pw6C3TdosFTPSKcV7zrcUzNCPQVw3BKF1MgjlJUKKc
         A1aLGPxyC+I+rKGPjiv7X2cx60/b2rqdjy/8jJ4naJLLvZCGPREQYLK5ayWRpUiH2o/a
         U81QgnX7Q5zdkZ8nFhZu6rbT5hSsc6BY9XQsnZli4lcsfdiLsJZf7TD8RW119KKkPmm+
         Tchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568553; x=1688160553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYHuYeE6oEUE8+vrjatCnxeEf3RtgdobAuLayKpBWO4=;
        b=Ce2agln+JVjJudNNb4jIWMHRF5P6MFNwIFX2qaFyA2+xOlYp/3KqzpdP0ex9I6DFnF
         xr9U2rX/FsVMkyysatLaX0tuzi5J/gNiaXXM0HCY4wlYg3d/MR9/r5mr5jEk2eS9kBgz
         XE9nVcSwqlbS0dafTnZ0XhZTvAcoy1knimqhyn1Jqi8iOY0UDIo3aBOrXMvtLDjoQwHv
         812LvfaW4N6CJunElWfhTEhMdoorZhQImnnM4tSba3csJxGiMQiVuBIu1p/UDfPvdi3d
         Ao9zFtW9DzcMAh8WfiMiWSaT8jRr1j4CTeoRndUYdd59L+UYednuHcsbtkzTX2b0Qh+b
         13lA==
X-Gm-Message-State: AC+VfDzMgCF1HRHaRLoKih2wb/1morxJ8eJRhXZrY8K6CGPijH/urpXE
        sJod22sVo9gH8kvF2HT7SKd+3mk9EeOGM3Vtdh0=
X-Google-Smtp-Source: ACHHUZ51L2SQqIXbgYEO/4+YGVhwgXF5Kl7syvfebT7yeFWy6rD9Il/B56NOa1x3AUT9LqK9PqMmg8D0nSoJv963cno=
X-Received: by 2002:a05:6870:e294:b0:18f:558a:1f35 with SMTP id
 v20-20020a056870e29400b0018f558a1f35mr4202572oad.59.1685568552729; Wed, 31
 May 2023 14:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <20221217001554.554913-1-lstoakes@gmail.com> <Y51L496TjNuiSxsG@casper.infradead.org>
 <Y51/Mt70d++6Zzzq@lucifer> <20221219100734.jag6zejp4tug77yq@techsingularity.net>
 <CAA5enKbsmy99-GCNuVcDRbjESZaLuE4=s8+6PzWP8J-wmOZwEg@mail.gmail.com>
In-Reply-To: <CAA5enKbsmy99-GCNuVcDRbjESZaLuE4=s8+6PzWP8J-wmOZwEg@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 31 May 2023 14:29:01 -0700
Message-ID: <CAHbLzkoSC7Q+xAMaSoNihn2eww-+5RZADxe5h7_FidGHELE3BQ@mail.gmail.com>
Subject: Re: [PATCH] mm: remove unused alloc_pages_bulk_list()
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Marco Elver <elver@google.com>,
        Michal Hocko <mhocko@suse.com>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 8:24=E2=80=AFAM Lorenzo Stoakes <lstoakes@gmail.com=
> wrote:
>
> On Mon, 19 Dec 2022 at 10:07, Mel Gorman <mgorman@techsingularity.net> wr=
ote:
> >
> > On Sat, Dec 17, 2022 at 08:34:58AM +0000, Lorenzo Stoakes wrote:
> > I reckon we should give it another few months until May. There has been
> > one user recently that tried to use list but it turned out arrays were
> > more appropriate.
> >
>
> It being May 31st, it feels appropriate to chase this up :)
>
> David's series at [0] did initially use this function, before
> switching to the _array() variant. Other than that it seems that it
> remains unused.

Thanks for following this up. My patchset (use bulk allocator for
dm-crypt) also switched from list API to a new callback API suggested
by Mel. But I haven't heard anything back from Mel about it yet. I
forgot to follow up due to too many distractions.

>
> Cheers, Lorenzo
>
> [0]:https://lore.kernel.org/all/20230522205744.2825689-1-dhowells@redhat.=
com/
>
> > --
> > Mel Gorman
> > SUSE Labs
>
>
>
> --
> Lorenzo Stoakes
> https://ljs.io
>
