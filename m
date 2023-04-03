Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0E36D3EC8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 10:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjDCITU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 04:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjDCITS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:19:18 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6768F10E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 01:19:17 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id g19so23837443lfr.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 01:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680509955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cB2n2J2tug6yoYqxC8LOxF9o11fo7ad2BJBVTYzPiEw=;
        b=cBjC/HItYTQ2dYJMZ8zMF/E4NtJ3q7Gb3aJoGTDnWOgKKID1YF9jcE/soHk5ziDKZ2
         pjPhkSKis4xbGotsrhoXlSQN5dFD4ARNSOGJQPjFpmI0ngHjCUNPW9DJ5AfgW1C+2NR8
         tjsIEtX4t0grcBEaqqtpaHLETPl4u/bMF9sDxRP6C06yGduis65e5Gm67LDUnfyRdKNT
         TXBNxCKaCzKcz0QqgLzBk+OkuKvRzuuP8nRUz1HP4PrkQVj+cvOgSv1e/K684ZlWrwB9
         012+3uXoMs37TcDOwG/Gp4ixGOC/3S2P8IGhMeXJ3Cfowo0keC19uyPsjK3j4ew0EmVE
         E88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680509955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cB2n2J2tug6yoYqxC8LOxF9o11fo7ad2BJBVTYzPiEw=;
        b=KhDEvRcYoD13HH5Ia99JlEa+/IFxsNT2pxNH7K17zOQQsIG5ZDnfTJ9IrZQc1A4yNK
         IwpBpLQ9wmPV/wL2Bdvd5SmH8BUCioyj5EZLrKnbpOpPfU5oj5PoeEjGKeqNwe+VVCXr
         bhAqGeLNBrar1mIzdqnx4kMyg7ATbM6VZYFK+STux+GeTlqJvg4TSSo5oubwRFfAp2JP
         QmeJj76cp3jL0pGNsEv5HRAA4qsb9uVpZiSj6mTOHEOCKJthecORrMpknoqN13uY7hCK
         MyjHgf4OhU55LcwFX1LLwCFFwnmQLOwV0SQGqXoYKOBQ2qoV1ER22jb0dzWMd/A/9Wox
         3XBA==
X-Gm-Message-State: AAQBX9dlZfJSMTmayoRmX2vuWBxnwgXS0kpaRKdqhQSlLPu7AuqVMoev
        kflxHecP90pvxUEjjRKUgOGvMIOa7nhi6LoCa1k=
X-Google-Smtp-Source: AKy350Z6ENSxQVWkg33xULYCcgxfw0HhTePD49i0PT+jqNPBW1VJzNuV9txIC7vuzLQW/NLx10d3FGUtE12pGCf9t8Y=
X-Received: by 2002:ac2:5322:0:b0:4eb:93a:41f0 with SMTP id
 f2-20020ac25322000000b004eb093a41f0mr9101959lfh.4.1680509955390; Mon, 03 Apr
 2023 01:19:15 -0700 (PDT)
MIME-Version: 1.0
References: <1680086855-7989-1-git-send-email-zhaoyang.huang@unisoc.com>
 <ZCRRaHHKVt7fpvmD@cmpxchg.org> <CAGWkznFRHbYv2ev3FU10zapka_6MDQ+g_-b0jufzqcAEAKUqFA@mail.gmail.com>
 <ZCVXFLA+sarzGG18@cmpxchg.org> <CAGWkznEdSaZRritHazo301Zyaage_R_4Grr4m8EirH7j8_-oOg@mail.gmail.com>
In-Reply-To: <CAGWkznEdSaZRritHazo301Zyaage_R_4Grr4m8EirH7j8_-oOg@mail.gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Mon, 3 Apr 2023 16:18:53 +0800
Message-ID: <CAGWkznEOfyULrBOR=AJRKPdPrED+xwrtGbLXEaFmWr1xfFbOuA@mail.gmail.com>
Subject: Re: [PATCH] mm: mark folio as workingset in lru_deactivate_fn
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 5:41=E2=80=AFPM Zhaoyang Huang <huangzhaoyang@gmail=
.com> wrote:
>
> On Thu, Mar 30, 2023 at 5:32=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
> >
> > On Thu, Mar 30, 2023 at 09:38:48AM +0800, Zhaoyang Huang wrote:
> > > On Wed, Mar 29, 2023 at 10:55=E2=80=AFPM Johannes Weiner <hannes@cmpx=
chg.org> wrote:
> > > >
> > > > On Wed, Mar 29, 2023 at 06:47:35PM +0800, zhaoyang.huang wrote:
> > > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > >
> > > > > folio will skip of being set as workingset in lru_deactivate_fn.
> > > >
> > > > Can you please elaborate why that's undesirable? What's the problem
> > > > you're fixing?
> > > If I am correct, folio will skip being set as workingset when moving
> > > from active lru to inactive lru, which is performed on every folio in
> > > shrink_active_list during normal reclaim.
> >
> > shrink_active_list directly calls folio_set_workingset(). The function
> > you're editing is used for things like MADV_COLD and truncate().
> Yes.
> >
> > It sounds like there is just a misunderstanding of the code, not an
> > actual problem.
> Isn't that a problem? As my understanding, MADV_COLD could be deemed
> as a stimulation of normal reclaiming which turbo the folio towards
> eviction, while the page moving by it should be also delt in the same
> way(PG_active has been cleaned)
Sorry, I am still confused. Does it mean the pages deactivated via
MADV_COLD like methods should NOT be deemed as workingset pages?
