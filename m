Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D147365C7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 10:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjFTIK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 04:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjFTIKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 04:10:16 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF78B1;
        Tue, 20 Jun 2023 01:10:15 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6687466137bso1106951b3a.0;
        Tue, 20 Jun 2023 01:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687248615; x=1689840615;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4kVb46CHm4CXezH4YMdyShKxAfFMwcDl1ci8/hW8N0=;
        b=E+lgnb0LZLVqP2sgH+QhauHAzQNxf7JL5C0uOHnEJd8akzGUTm1PblBFGNLP1ZR8a8
         H03RQwocIZ9aqbxw+F6SfkRIVlk2OEbsY8wp3R3CmzuNdvqmfMedrLgxUae7mAkWI/bz
         nJqsQSgvAQstGYVRV4Jgfpa5QzsmDsv4PlVWzojrS0SXaCGDWjdQOeO2AoTMoyDshg9Q
         /6dXf6zE90TW7UcTUoKQBjE6dqKh+T5l1TF7NTez8P5ckFsgxzKUCu6wZZFcYbCH3T2V
         wszeJSOrHJapAbbt2YOseR7LBNksTZC6nHQSic5K3BB+EOxJjx1E1fltz96K6odZP3xB
         zhvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687248615; x=1689840615;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R4kVb46CHm4CXezH4YMdyShKxAfFMwcDl1ci8/hW8N0=;
        b=FH6dj4zH4z32TauYU3EW/0yyZrVvNsslhbMFtZB3U16sFESiOuLrk9+y3jXqhAeeUP
         vXCVE75sya1/YptM+WWs0RqJRIai6iM2Uf/Zq9yWGyWGTOA59gNxynvYcagA5vex9zeI
         RrUto65lsu2+7NQKd6Uz1RHrE+P83PWXIBwkt9NfKaKUFwGwnbfZjFnUGqjvSt3rFAiQ
         MjBFiTQni7Iwq/wtMHEfI3B9N9dAGmbPldWimtZ1K4gXKBwX+9xlqg/rm4yI+L3F/Cga
         R09U/VVuLtzKlasUwfqm411y6w0KbBXfhHlMHe/XBGuE4D4O5nzYafSW4wEj/6mSXes5
         uQ1g==
X-Gm-Message-State: AC+VfDytSTS55xYMrqnZjQ9CfHWCosOjyzTDQMuOHY7/KRD0iGgnxoR3
        GKdKln4Tj55nhpJwFNpLshsPab6UC7mHWw==
X-Google-Smtp-Source: ACHHUZ5XN6v8cMkIlVat2Pe8FIOR+gzFF/AMz+jfwT0OUTBz5QJvJy0BfrMakNoJaFwAUjrdaeRJcA==
X-Received: by 2002:a05:6a00:c95:b0:662:b5de:27f6 with SMTP id a21-20020a056a000c9500b00662b5de27f6mr9059857pfv.17.1687248615119;
        Tue, 20 Jun 2023 01:10:15 -0700 (PDT)
Received: from localhost ([124.170.190.103])
        by smtp.gmail.com with ESMTPSA id n24-20020a62e518000000b00668a06ddf2bsm540786pff.83.2023.06.20.01.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 01:10:14 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 20 Jun 2023 18:10:09 +1000
Message-Id: <CTHBPQOQXTFE.29F2F08A55JGP@wheely>
Subject: Re: +
 lazy-tlb-fix-hotplug-exit-race-with-mmu_lazy_tlb_shootdown.patch added to
 mm-hotfixes-unstable branch
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <mm-commits@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <peterz@infradead.org>,
        <akpm@linux-foundation.org>
X-Mailer: aerc 0.14.0
References: <20230525205253.E2FAEC433EF@smtp.kernel.org>
 <87v8fv86bh.ffs@tglx> <CTH8ZNDRMLEZ.2WS18IS2E38T7@wheely>
 <87jzvyprsw.ffs@tglx>
In-Reply-To: <87jzvyprsw.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Jun 20, 2023 at 4:32 PM AEST, Thomas Gleixner wrote:
> On Tue, Jun 20 2023 at 16:02, Nicholas Piggin wrote:
> > On Sun Jun 11, 2023 at 5:29 AM AEST, Thomas Gleixner wrote:
> >> /*
> >>  * Invoked on the outgoing CPU in context of the CPU hotplug thread
> >>  * after ensuring that there are no user space tasks left on the CPU.
> >>  *
> >>  * If there is a lazy mm in use on the hotplug thread, drop it and
> >>  * switch to init_mm.
> >>  *
> >>  * The reference count on init_mm is dropped in finish_cpu().
> >>  */
> >> static void sched_force_init_mm(void)
> >> {
> >>
> >> No?
> >
> > It could be done in many places. Peter touched it last and it's
> > been in the tree since prehistoric times.
>
> That's an argument for slapping it into some randomly chosen place and
> be done with it, right?

Ah, not exactly but I did misremember, I did have to change where I
added it so it does turn out to be more arbitrary than I thought.

If it goes in wait empty then than state is no longer wait empty, it's
wait empty and switch mm. I can put it there, should I also rename the
state?

> >> > +/*
> >> > + * After the CPU is offline, double check that it was previously sw=
itched to
> >> > + * init_mm. This call can be removed because the condition is caugh=
t in
> >> > + * finish_cpu() as well.
> >>
> >> So why adding it in the first place?
> >>
> >> The changelog mumbles something about reducing churn, but I fail to se=
e
> >> that reduction. This adds 10 lines of pointless code and comments for
> >> zero value.
> >
> > Not sure what you're talking about. The patch didn't add it. Removing i=
t
> > requires removing it from all archs, which is the churn.
>
> Sure. That's left as an exercise for others, right?

No, I'm telling you why I left the function in. Did not want to gate a
fix behind herding the arch cats. I will send the trivial patch to arch
trees after it's upstream. This is how such API changes are typically
done.

Thanks,
Nick
