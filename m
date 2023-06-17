Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C90733FCD
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 11:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjFQJAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 05:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjFQI76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 04:59:58 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403F12103
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 01:59:57 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-570114e1feaso20115817b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 01:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686992396; x=1689584396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAxlbr70nVGLPeolqN3TzyVnfvZ6eeI7P/kXQdKGTBs=;
        b=MxKH+RcVMjAIkHZiyEi8+5ceCL20HNh47UOTrkMz/aREhS7iLhXGH+koJ5DRNoE23U
         UTYnDflrRNqzZ8bFZK6GGRblbtbCQtwP1cL+rIjN54mqBumgm4LWjAzHNnZaMJIpdLY3
         UdAIIbLzcrGWq5DtnKsxyiAUJ65Az5S3hLXzye+6Li8ayjcz0L/yhNV5GODBcK0wNAAI
         ZqimddRh4dT+fKd/GYU5PBAjSxqGVVJHZHyTsxWoAKAN6S+YMoiUpHg0MnLVkNgTRRgw
         ZqFHEb3fMJwpOrlDUxmzpz3Eo26NaX4uV5TD/zcWBkkqDPIZRV6engawhcxQHYIIHCc4
         CUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686992396; x=1689584396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAxlbr70nVGLPeolqN3TzyVnfvZ6eeI7P/kXQdKGTBs=;
        b=EBS4Ug3jlk2At7opyyL6aIOcA3vycWz+FvtRNrJvUxre4n9a+1rUENvgBybqmjo2CP
         b1Q5NUdKrh6CXVTM0DpNyBQ1clQX/btpz8kgbAYP9iaophOblekyI6n3+DkpiV6jfsm0
         oIlYF9p5cndrkpQofemVInQcKc/s1MWPo0vumZk6JkM9YSygB/CxAxJTthpyxK/tSLSY
         L5BIoAhpCC9hSXKDujVLb5F/iuf0ZQiQqUvDlxJw2aJ3bjLEjgiK2m9RGu2fEoiUJ3Qm
         yfg5bKZso+bvgd1aYTaWaan03E7/qoZjO69SNa24rgy7bJNk9fPZs5+j4tDIjhgr6hSg
         d93g==
X-Gm-Message-State: AC+VfDzBQ0PZI6hdBxA/F3T59YTQ4QbrLKqQ5eqmX/CuRdm+i8N5iDOh
        ZfM2LRC1fzCNfNmB2SeUWYl5P2QGnJqqtESkboU=
X-Google-Smtp-Source: ACHHUZ5iThchRPHO1uX2naoiBRIc1k7oR/L5+4esIYomcMWDiLMvKWV8Fgh9XEY9sPw+C//l+o6yBnRtovHIl3QSavY=
X-Received: by 2002:a25:bccf:0:b0:bac:b478:d215 with SMTP id
 l15-20020a25bccf000000b00bacb478d215mr1910617ybm.9.1686992396239; Sat, 17 Jun
 2023 01:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230617044036.3985524-1-zhiguangni01@gmail.com>
 <20230616224407.863c74a3dc9d4f1427802f91@linux-foundation.org>
 <CACZJ9cXM9VkJ5=euHphwM5TtX3aZqZ_QynOq10FtrqCxZfZsQA@mail.gmail.com> <20230617070051.GU52412@kernel.org>
In-Reply-To: <20230617070051.GU52412@kernel.org>
From:   Liam Ni <zhiguangni01@gmail.com>
Date:   Sat, 17 Jun 2023 16:59:46 +0800
Message-ID: <CACZJ9cWFyr7MyGWWaGiNYHDb39ZYAmijH90gAH5N8-z4jc2KNw@mail.gmail.com>
Subject: Re: [PATCH] mm/sparse:avoid null pointer access in memory_present()
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jun 2023 at 15:01, Mike Rapoport <rppt@kernel.org> wrote:
>
> On Sat, Jun 17, 2023 at 02:17:58PM +0800, Liam Ni wrote:
> > On Sat, 17 Jun 2023 at 13:44, Andrew Morton <akpm@linux-foundation.org>=
 wrote:
> > >
> > > On Sat, 17 Jun 2023 14:40:36 +1000 Liam Ni <zhiguangni01@gmail.com> w=
rote:
> > >
> > > > __nr_to_section() may return a null pointer,
> > > > before accessing the member variable section_mem_map,
> > > > we should first determine whether it is a null pointer.
> > > >
> > > > ...
> > > >
> > > > --- a/mm/sparse.c
> > > > +++ b/mm/sparse.c
> > > > @@ -258,7 +258,7 @@ static void __init memory_present(int nid, unsi=
gned long start, unsigned long en
> > > >               set_section_nid(section, nid);
> > > >
> > > >               ms =3D __nr_to_section(section);
> > > > -             if (!ms->section_mem_map) {
> > > > +             if (ms && !ms->section_mem_map) {
> > > >                       ms->section_mem_map =3D sparse_encode_early_n=
id(nid) |
> > > >                                                       SECTION_IS_ON=
LINE;
> > > >                       __section_mark_present(ms, section);
> > >
> > > I'm suspecting that if __nr_to_section() returns NULL here, we should
> > > just panic.  But a null-deref gives the same information, so why chan=
ge
> > > things?
> >
> > Do you mean if ms is a null pointer=EF=BC=8Cms->section_mem_map will ca=
use
> > system panic,so we needn't change?
>
> Yes, if __nr_to_section ever returns NULL the system will crash anyway.

I got it,do we need to print some information by panic()?

>
> --
> Sincerely yours,
> Mike.
