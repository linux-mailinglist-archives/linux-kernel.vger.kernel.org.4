Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D4D71A2AC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbjFAP2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234941AbjFAP2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:28:31 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61F71B9
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 08:28:15 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-52867360efcso534753a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 08:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685633277; x=1688225277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fs3XCjI+/y5qrxNTT3Ql7CYG7V3clml4wrU2pyefZ7U=;
        b=L2j3yi68P6BzVEmd0OrCrjazUTqYJmE8IOksqIbJQzLMwd/VT25CW4WkgkNH497Dqv
         aVQQiJDtEPOq94dADL5zuu91r93bSpfhvswNPs2elNF4jaJQQIf00dka+0ANWg3v+IIQ
         hXyHpPzd8yN112gZx4dSkOAy6c5oqwS21CEeXcA4D4/gyJnKllDXFEdNP1Rc6XaIrAm9
         7Yn8uggc15HYgU1GwdFdhDEJYF+GDvl4xqGFtg2F2Lucfv/QogFPNm1HieH15/z1j6gF
         BrEpTVl+0yM1HowxkQJvWA20asmXTGrDEAvcXNSv1mTDThLXguuHouTwUY0nuOyc2nTL
         Q/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685633277; x=1688225277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fs3XCjI+/y5qrxNTT3Ql7CYG7V3clml4wrU2pyefZ7U=;
        b=g1MlZFBtjbYbASVhCODrg8rWq6OAO3fzSa22JP0eD/TaP4ENmJ8ArF0ULYZQyBryU8
         rPjk4ED/V64Q+3xj/8lU8dlsTrtOnjfO9lq16tVciDo3VLKPhB1fR00+0i4AhXMyKexC
         IKetAE0Ko710m2O0/AoyEmZuWuyeBXeCvVsqQSg+7vZrpLqEJ22Q+UdGaqzyKq66O2zt
         JDc74otfAR2sHa6lM1fQWs8r9EXxFJ01Um4sLSln3lZSz40D7MKPOiKtjhxxR8Du0Jzk
         Kk6TophflzngYv9RMN0+DegkFYbCY2xrlm2/rgrSPpp29HTiAXwg73MDtHuRqsXopUuR
         ZzMA==
X-Gm-Message-State: AC+VfDyukI3htV3RlxGyiE0gzSUipJNR6x844dZPAn49SPMVggnuJtEM
        S+8QUStL2fEFs1+5vjRXOGsEJPN0+/mcdEPxeac=
X-Google-Smtp-Source: ACHHUZ4ot3Eqm1UaB0HZLIs6quJMT1fZvjp4VKDAh5FOYm2veCtG3TdlVuuEThZRhAivTd/DVSiVejuVRNE5irDRpso=
X-Received: by 2002:a17:902:c40e:b0:1b0:4607:5117 with SMTP id
 k14-20020a170902c40e00b001b046075117mr7441298plk.47.1685633276536; Thu, 01
 Jun 2023 08:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230524065051.6328-1-cerasuolodomenico@gmail.com>
 <ZHE7KWId1fvXLpUy@google.com> <CA+CLi1iC35exSaKaCmVmTWtna=9xBKHSyGNGmHFo=OqiSECGoA@mail.gmail.com>
 <ZHUSfg+z3wcaIhAT@google.com> <20230530041341.GB84971@cmpxchg.org>
 <ZHYNaxgcKs7PSp9I@google.com> <20230530155519.GB97194@cmpxchg.org>
 <ZHY+C0ICTah8/+V3@google.com> <20230530185451.GA101722@cmpxchg.org> <ZHadno3POk05o82x@google.com>
In-Reply-To: <ZHadno3POk05o82x@google.com>
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Date:   Thu, 1 Jun 2023 17:27:45 +0200
Message-ID: <CA+CLi1gsF46br=fqGaewAGLBk7S16yfLnZ_zhCGDEnN8DaJjaw@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: shrink until can accept
To:     Chris Li <chrisl@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, yosryahmed@google.com,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 3:06=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
> On Tue, May 30, 2023 at 02:54:51PM -0400, Johannes Weiner wrote:
> > > Maybe ENOMEM is a bad example. How about if the swap device
> > > just went bad and can't complete new IO writes?
> >
> > This is actually outside the scope of zswap, and handled by the
> > swapcache (end_swap_bio_write).
> >
> > Once the IO is submitted, zswap will ax its copy and leave the rest to
> > the swapcache. It behaves the same way as if zswap had never been
> > involved to begin with when the swap out fails on IO errors.
> >
> > From a zswap perspective, there are no persistent errors in moving a
> > zswap entry back into the swapcache. Not just currently, but generally.
> Again, you are right that this zswap writeback is async.
> So the writeback error is NOT going to propagate to the
> shrink function.
>
> With the current three pool backends that I looked at{zbud,
> z3fold,zsmalloc} they all have internal retry 8 times.
> Adding more retry did not fundamentally change the existing
> behavior.
>
> I look at all the possible error codes generated inside
> the reclaim code, the only noticeable errors are ENOMEM
> and concurrent swap invalidation or a racing swapin fault.
>
> BTW, zswap reclaim consumes memory. Keep on looping ENOMEM
> might cause more OOM. But that can exist in current code
> as well.
>
> > > > Aside from -ENOMEM, writeback_entry will fail on concurrent swap
> > > > invalidation or a racing swapin fault. In both cases we should
> > > > absolutely keep trying other entries until the goal is met.
> > >
> > > How about a narrower fix recognizing those error cases and making
> > > the inner loop continue in those errors?
> >
> > Right, I just I don't really see the value proposition of this
> > complication, and I see some downsides (see below). No single entry
> > error should ever cause us to stop the wider reclaim loop.
>
> That is until the current LRU list has been through once.
> I expect repeating the same list yields less reclaimed pages.
>
> >
> > > > > > extreme case where it's the only page left on the list, I again=
 don't
> > > > > > see how retrying a few times will make the situation worse.
> > > > > >
> > > > > > In practice, IMO there is little upside in trying to be more
> > > > > > discerning about the error codes. Simple seems better here.
> > > > >
> > > > > Just trying to think about what should be the precise loop termin=
ation
> > > > > condition here.
> > > > >
> > > > > I still feel blindly trying a few times is a very imprecise condi=
tion.
> > > >
> > > > The precise termination condition is when can_accept() returns true
> > > > again. The safety cap is only added as precaution to avoid infinite
> > > > loops if something goes wrong or unexpected, now or in the future.
> > >
> > > In my mind, that statement already suggests can_accept() is not
> > > *precise*, considering the avoid infinite loop.
> > > e.g. Do we know what is the optimal cap value and why that value
> > > is optical?
> >
> > Oh but it is precise. That's the goal we want to accomplish.
>
> I understand it is the goal, the precise condition I am
> talking about is the loop termination condition, can_accept()
> is not the only one. Anyway, let's move on.
> >
> > The cap is just so that in case something unexpectedly goes wrong (a
> > bug), we fail gracefully and don't lock up the machine. The same
> > reason we prefer WARN_ONs over BUG_ONs if we can, to avoid
> > crashes. That's really all there is too it, and it strikes me as
> > reasonable and robust design choice. It's fine to limp along or be
> > suboptimal after such a bug happens; the bar is avoiding an infinite
> > loop, nothing else.
> >
> > Your suggestion of whitelisting certain errors is more complicated,
> > but also less robust: in case an entry error does by some accident
> > become persistent for the whole LRU, we're locking up the host. We'd
> > rather catch a bug like this by seeing spikes in the reclaim failure
> > rate than by losing production machines.
> >
> > > Putting the definition of precise aside, I do see the unconditional
> > > retry can have unwanted effects.
> >
> > I hope I could address this above. But if not, please share your
> > concerns.
> Thanks for the discussion. I am less concerned about the retry now.
> Retry on EAGAIN might be the simplest way to proceed.
>
> Outside of the scope of this patch, I am still surprised to see
> such a high number of retries caused by race conditions. There are
> 8 inner loop retry already. The actual pages retried need to
> times 8.
>
> If there is a reproducer script, I want to local repo this
> to understand better. Wish there are ways to reduce the retry.

With `stress` you can reproduce the errors quite easily, if you're not goin=
g
to see many (if any at all) writebacks _without_ this patch, you can let th=
e
zpool fill, keeping the default max_pool_percent value of 20, then once ful=
l
switch max_pool_percent to 1.

>
> Another idea is that we can start the shrinking once the
> pool max was reached. Try to reduce to the threshold earlier.

The shrinking already starts when pool max is reached, with and without the
proposed patch. If you're referring to a new threshold that would kick off
the shrinking, that could be a nice improvement to the overall mechanism,
and it would fit nicely on top of this patch.

>
> Chris
