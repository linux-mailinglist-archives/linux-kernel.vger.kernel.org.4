Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111726525DF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 18:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbiLTR4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 12:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiLTR4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 12:56:31 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327D7116B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 09:56:31 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so17258010pjr.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 09:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WnsQ7W4+w46kWzm3CDvn6Yr9ZWGsCxW++5kHHfpJvH8=;
        b=WqPQX/XN3ypnmZR7hVdZaErjEpeBprcSPWJZRlN5w7lez6a167Y0Tbfew6lzmirQVF
         KN+x/awIInFQx32HhHQDxRZcwN3eGwoeUd+h37lIW4/xOicA5YFuqhfV4Cqh+F40t+HY
         CXnT1PVVebxNGA+xr0NcFg87xpg1z2x75Bi71IGrsHPXzc4ex2HVFyfCTW8YVM1h2DK0
         AOzlQIXSYr2Uaek6S3ZZvfKDcZo0uY4e7k2QNEE5RmoEgRErG7ZmeErFBk4Ptt7OjCvU
         Gnf5wHzJYavQyjCJs6hZDnNosZSLfvJ0KAAQdoSLfcoNs9Jy95WgtMaCz2cfwsIZ5xW2
         dvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WnsQ7W4+w46kWzm3CDvn6Yr9ZWGsCxW++5kHHfpJvH8=;
        b=T2Mbit/4gAiXTeF9p2QgiOUlxoHEscHaY3SuYBsEy6gnF0zHRidBzd316+cfIhEGOw
         FxUCehG762ZFJBS75w1ScU8UWIry1V9SDokIAzk9+P1nPtrRfBbZBD4IFWfibcr/PMMV
         hKuA8luVcyNoZgxpB+0xT9U1STXo2hAqrzl8+k5PeWq9kyk5hOjQblaid/EknXPj3K7N
         vgnXHJNaiavGjWSg3egGYGNXixISuKFJMuXNeWphBCI7uVFY2QQv9PPUBz2X0pth5+3F
         0WUo51dyxd9L2AqgyklGJLTSGKeUcL8rGla4VoVaxjYx7lfsJsCFMW5hZrR87Q+FzKG2
         1qsw==
X-Gm-Message-State: AFqh2kqDy9zc7Ksdu6Pj0DJkYzSsPnaMKL2+opU4Zj7sVaHLYeZfXaUt
        L0aqCTrxp0QqBoD3JD9QtP2/E7r9p96U57n5uQs1oTPO
X-Google-Smtp-Source: AMrXdXvQ2GFm24bfI45BUCwPfwnk4StLIIGyZMfE+dkxDcvnbaPCDIJyASRRPhLGyDOZHTWR0IlP3YAyyaOSiQVrt7g=
X-Received: by 2002:a17:902:ccc5:b0:191:2b33:7010 with SMTP id
 z5-20020a170902ccc500b001912b337010mr254971ple.119.1671558990724; Tue, 20 Dec
 2022 09:56:30 -0800 (PST)
MIME-Version: 1.0
References: <20221217001554.554913-1-lstoakes@gmail.com> <Y51L496TjNuiSxsG@casper.infradead.org>
 <Y51/Mt70d++6Zzzq@lucifer> <20221219100734.jag6zejp4tug77yq@techsingularity.net>
In-Reply-To: <20221219100734.jag6zejp4tug77yq@techsingularity.net>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 20 Dec 2022 09:56:19 -0800
Message-ID: <CAHbLzkp58y=d70j7eE9KkhK0HOorjD4=vxpuTk-9jLwGH5yarw@mail.gmail.com>
Subject: Re: [PATCH] mm: remove unused alloc_pages_bulk_list()
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Marco Elver <elver@google.com>,
        Michal Hocko <mhocko@suse.com>
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

On Mon, Dec 19, 2022 at 2:07 AM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Sat, Dec 17, 2022 at 08:34:58AM +0000, Lorenzo Stoakes wrote:
> > + Mel
> >
> > On Sat, Dec 17, 2022 at 04:56:03AM +0000, Matthew Wilcox wrote:
> > > I think we're waiting to see if any users show up.  It's only been 18
> > > months or so, so perhaps wait a little longer?
> >
> > Apologies, I should have researched the background of this further. I see it was
> > added speculatively in 0f87d9d30f.
> >
> > > Also, if we do get rid of this, then __alloc_pages_bulk() can lose
> > > the "list" argument.
> >
> > Ack. Will do a v2 if Mel feels it's appropriate to remove at this stage,
> > otherwise we can drop the idea and wait for users to emerge.
>
> I reckon we should give it another few months until May. There has been
> one user recently that tried to use list but it turned out arrays were
> more appropriate.

Another recent try was the patches for dm-crypt. However Mel suggested
adding a callback interface instead of using list since list is not
necessary for that usecase. Or are we talking about the same one?

I didn't get time to implement Mel's suggestion yet due to my
employment change. Hopefully I can find some time after the new year.

>
> --
> Mel Gorman
> SUSE Labs
>
