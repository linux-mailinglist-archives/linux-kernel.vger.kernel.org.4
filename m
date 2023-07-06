Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA007492C3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 02:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbjGFAt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 20:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbjGFAt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 20:49:57 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCEB171D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 17:49:56 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-c4dfe2a95fbso89297276.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 17:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688604595; x=1691196595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uS0XZ1fUS0VGPojYqzvpfVl4CXPI8Do8FblmEQ8ODms=;
        b=EIAi6itQYEmH6xFZ4o9n4NzNBBUltsEavCtIyk/jEAlvRTjak+IwP9IekJezSBDiFP
         rag/e41OhG9t9xYdYtU2rb0z3vz4vWCpb2R3Jhr6laoakm5drAfmUicusk6sG0tWQ32K
         Zpkj/e0ViWHHp6TEGfIOLOwx+2dv6SDMdAguax94iUKkb79YK+U9jNvJy0ZAep8QXWZU
         Mx5+rdGhWx6Xl+8PHphq1cULfnKYHtodg6hKjwk5dxm7SLwCYtez1/U8W4PryMOdrAYQ
         ynEP0SBWRn3FeEu98EO9Kyjsapq36Nvsmh1X0nVvDEpDoSZgWE01iqvx1ipoxAZUKnEG
         kR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688604595; x=1691196595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uS0XZ1fUS0VGPojYqzvpfVl4CXPI8Do8FblmEQ8ODms=;
        b=Q9lrHv3zRK1c2Q5pwCkiE6lhBWPsHT8fUehEq7PYjjK4Kxy0JZUw2nqqW8WbrxvpwY
         T0G9E6LjN3yVKEqnDjRk3X2F8zv5UNzWwqxr5DRk/OZU+C/JEiiJM9TULL1QLx19buIQ
         eWry8LCCrVKL6lmEiMPKWXrLzrR1H5hZEcnsW+ZzBMMXlUjA9PKEf+seyUD51DpUvw3F
         42Gp/Za90N2n+TwxkSXYvTnc8ymWC0Kzj1pcnWxSjqxPra2C4MZBkGxnm0iCFDmhwwrv
         AGeeRsk88EmM5yvY3cKTDXW6mhYPthJYOQD/0uZepUnPdB7BajTKKV/id5H6qYAFqTol
         /giQ==
X-Gm-Message-State: ABy/qLZlxBMlXzxy9wpmNrHBmWP2d/BW838w0nVOgfmJ9959hSzPzXin
        5wRUkuq+zEZN1BBpzdD7PhRs72kbemWp6awQGBlJrA==
X-Google-Smtp-Source: APBJJlHpt9JQ+AIigpgGbyrUOJU9M9UGcUJA4d6s+0oOFsqwkgrKB/j6NACCn3Myn8DaEFaYZKMfK4zc8Jfpe5uDn4g=
X-Received: by 2002:a05:6902:513:b0:bc1:dfa5:8399 with SMTP id
 x19-20020a056902051300b00bc1dfa58399mr418671ybs.13.1688604595099; Wed, 05 Jul
 2023 17:49:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230705171213.2843068-1-surenb@google.com> <20230705171213.2843068-3-surenb@google.com>
 <3cdaa7d4-1293-3806-05ce-6b7fc4382458@redhat.com> <CAJuCfpGTNF9BWBxZoqYKSDrtq=iJoN1n8oTc=Yu0pPzW8cs8rQ@mail.gmail.com>
 <ZKXRsQC8ufiebDGu@x1n> <CAJuCfpGHRfK1ZC3YmF1caKHiR7hD73goOXLKQubFLuOgzCr0dg@mail.gmail.com>
 <20230705172424.e505f5013bfdf44543d9c6be@linux-foundation.org>
 <CAJuCfpFLRePeOsrSg--5GtWbC1M5y21Sq7gzrs1vVEUE7C+30A@mail.gmail.com>
 <CAJuCfpGWW7wsrtqi4rZUz4vxW-N0CaUEeUqY4e7iX1hzgRsT2g@mail.gmail.com> <20230705174440.9adb53f2e362056867135b84@linux-foundation.org>
In-Reply-To: <20230705174440.9adb53f2e362056867135b84@linux-foundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 5 Jul 2023 17:49:44 -0700
Message-ID: <CAJuCfpEjytSBKN0gn0t7e5bCSmZLXU-86Ko0Kt-rkXD7hZeNNA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm: disable CONFIG_PER_VMA_LOCK until its fixed
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        jirislaby@kernel.org, jacobly.alt@gmail.com,
        holger@applied-asynchrony.com, hdegoede@redhat.com,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
        songliubraving@fb.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 5, 2023 at 5:44=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Wed, 5 Jul 2023 17:32:09 -0700 Suren Baghdasaryan <surenb@google.com> =
wrote:
>
> > On Wed, Jul 5, 2023 at 5:30=E2=80=AFPM Suren Baghdasaryan <surenb@googl=
e.com> wrote:
> > >
> > > On Wed, Jul 5, 2023 at 5:24=E2=80=AFPM Andrew Morton <akpm@linux-foun=
dation.org> wrote:
> > > >
> > > > On Wed, 5 Jul 2023 13:33:26 -0700 Suren Baghdasaryan <surenb@google=
.com> wrote:
> > > >
> > > > > I was hoping we could re-enable VMA locks in 6.4 once we get more
> > > > > confirmations that the problem is gone. Is that not possible once=
 the
> > > > > BROKEN dependency is merged?
> > > >
> > > > I think "no".  By doing this we're effectively backporting a minor
> > > > performance optimization, which isn't a thing we'd normally do.
> > >
> > > In that case, maybe for 6.4 we send the fix and only disable it by
> > > default without marking BROKEN? That way we still have a way to enabl=
e
> > > it if desired?
> >
> > I'm preparing the next version with Liam's corrections. If the above
> > option I suggested is acceptable I can send a modified second patch
> > which would not have BROKEN dependency.
>
> I think just mark it broken and move on.  At some later time we can
> consider backporting the fixes into 6.4.x and reenabling, but I don't
> think it's likely that we'll do this.

Uh, ok. I'll send the next version shortly with the patch fixing the
issue and another one marking it BROKEN. Hopefully in the next version
we can roll it our more carefully, removing BROKEN dependency but
keeping it disabled by default?

>
