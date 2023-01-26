Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3685A67C425
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 06:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjAZFE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 00:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235786AbjAZFEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 00:04:53 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F17D25E37
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 21:04:52 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id b1so725955ybn.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 21:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DiMArbdV/T0/c00vu6b8fiK7TVndbh70egFu73S7mgY=;
        b=j/LKANNaDiV/aVUigkiPOcRVnzC0NEKIE5OVSqZFXO5PQmA8IB4O6ybyFs7K9nHv5e
         laSl/lOwAbh+AdgJ1eP2IphhzkEB7ecxZcjDktRE3b7n6EfL5C19sLZ43AqeRBfb0KtA
         R6bpp2jKN9ETwo60eIyTxSUyaKK5Do9xQQjYLkEb5WyGf3LUpoxQ5pBOAkUzfJdMuySn
         /86Tg01i6EE+kVVaHoYAzQ0fo3EJsMxn11gTJmXMNVyZ5V6Yfmz133yEbMijwhoIplf+
         2aV4ifCQegjZ71ujLZnnBTPJJUNRx3qFktIIvJIE/PK6s26dYj4szNUqSVjykNzyKJOV
         26mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DiMArbdV/T0/c00vu6b8fiK7TVndbh70egFu73S7mgY=;
        b=mNyZyOzPjiOsrHXxXJxj+P0L0QCISTaVtRVtfDKGjR7yrfAZX2hKufUF3Yj0WBK0Gv
         Y5n7ZnzNR0emxVxZ/NyOF3A8DIMeTW4CrDKvParcfbJ6XLzdm1aw1+b00Gdp+XIQYAdI
         vVzyjw/SiHTaJQ8bTKZJdzouxw9yU4Oru5EsP2y3RPVkt226soBwsEAdX27Ad6AIZNMR
         AscS6ZCBJQEy6G/2DKmboFLfh56P3VJsJFpqy2R92jbaP+zepswX6DsTBjnmnz0CyFhw
         W0GSkatddKx4FJb+tj9EygkkIOqRMDtV++1Pc0+drGIZWjDmz8dhN1ncVSmxjRcALmPb
         KrEg==
X-Gm-Message-State: AFqh2koe4Bp8228OXKMrvbHGeSJAelMFUNjuGgSGgLd9VhRdxf6TECH1
        HEhua6l5z6alwbt8suAev97c55DpveB717Cb6p38
X-Google-Smtp-Source: AMrXdXvqx4UwR/r3vyZL8yNah3Pa9DYRDPjFsXDYhXUxO9RFX6K9KBd57NKlJxTw0JZEjJN84sol+jsPKtLhpA9OJvo=
X-Received: by 2002:a5b:84d:0:b0:7ba:e354:5aaf with SMTP id
 v13-20020a5b084d000000b007bae3545aafmr4010311ybq.37.1674709491637; Wed, 25
 Jan 2023 21:04:51 -0800 (PST)
MIME-Version: 1.0
References: <CABdmKX3HFuaE0qwcADk-KLtVUdao-uhH-1zn4gv7ezq+bZE94w@mail.gmail.com>
 <20230117082508.8953-1-jaewon31.kim@samsung.com> <20230117083103epcms1p63382eee1cce1077248a4b634681b0aca@epcms1p6>
 <CANDhNCpKY5Af059ok8ZcgJ=wt7NaorZxqQXaTS848CwY0LNFiw@mail.gmail.com>
 <20230125095646epcms1p2a97e403a9589ee1b74a3e7ac7d573f9b@epcms1p2>
 <20230125101957epcms1p2d06d65a9147e16f3281b13c085e5a74c@epcms1p2>
 <CGME20230117082521epcas1p22a709521a9e6d2346d06ac220786560d@epcms1p3>
 <CANDhNCoAKtHmxFomdGfTfXy8ZvFMfMRj4jZ+b8wMMD+5AmAB0g@mail.gmail.com> <20230126044218epcms1p35474178c2f2b18524f35c7d9799e3aed@epcms1p3>
In-Reply-To: <20230126044218epcms1p35474178c2f2b18524f35c7d9799e3aed@epcms1p3>
From:   John Stultz <jstultz@google.com>
Date:   Wed, 25 Jan 2023 21:04:39 -0800
Message-ID: <CANDhNCo1JRmfouBn985GZLmPY-xLn9JKNJfubY0PAUrCpY8K4g@mail.gmail.com>
Subject: Re: (2) [PATCH] dma-buf: system_heap: avoid reclaim for order 4
To:     jaewon31.kim@samsung.com
Cc:     "T.J. Mercier" <tjmercier@google.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 8:42 PM =EA=B9=80=EC=9E=AC=EC=9B=90 <jaewon31.kim@s=
amsung.com> wrote:
> > On Wed, Jan 25, 2023 at 2:20 AM Jaewon Kim <jaewon31.kim@samsung.com> w=
rote:
> > > > > On Tue, Jan 17, 2023 at 10:54 PM John Stultz <jstultz@google.com>=
 wrote:
> > But because your change is different from what the old ion code did, I
> > want to be a little cautious. So it would be nice to see some
> > evaluation of not just the benefits the patch provides you but also of
> > what negative impact it might have.  And so far you haven't provided
> > any details there.
> >
> > A quick example might be for the use case where mid-order allocations
> > are causing you trouble, you could see how the performance changes if
> > you force all mid-order allocations to be single page allocations (so
> > orders[] =3D {8, 0, 0};) and compare it with the current code when
> > there's no memory pressure (right after reboot when pages haven't been
> > fragmented) so the mid-order allocations will succeed.  That will let
> > us know the potential downside if we have brief / transient pressure
> > at allocation time that forces small pages.
> >
> > Does that make sense?
>
> Let me try this. It make take some days. But I guess it depends on memory
> status as you said. If there were quite many order 4 pages, then 8 4 0
> should be faster than 8 0 0.
>
> I don't know this is a right approach. In my opinion, except the specific
> cases like right after reboot, there are not many order 4 pages. And
> in determinisitic allocation time perspective, I think avoiding too long
> allocations is more important than making faster with already existing
> free order 4 pages.

I suspect you are right, and do think your change will be helpful.
But I just want to make sure we're doing some due diligence, instead
of going on just gut instinct.

Thanks so much for helping with this!
-john
