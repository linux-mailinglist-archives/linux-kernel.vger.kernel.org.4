Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01105709AE6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 17:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjESPJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 11:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjESPJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 11:09:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C00121
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 08:09:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A3DB6587F
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 15:09:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D82DC433AA
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 15:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684508948;
        bh=rDLgLUJ0rrmB/7UJshPY5Np0IALAi+sq2a59vSquYrM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XwtGzrlehOHApxGNhTJs7uj3zzus/T/qulGrC436Io2KRBxHmBrifjbaz4joKgfVa
         t9Kj0/dQiDzIlb1sQKd9sQ4ac/gNMK96DS78eVtxKVUwdZBY0lQz8rCTqDNx1ljLCn
         bFD1c0xwaQc+oOE+hNCC/NQFoQv7alZRj1MZnN3PB7dGKjy6Tt4CoQZpovflYHFYkX
         45zZZPMyn/s88NmUsluCQPyO7sVqVB4jC9LMVXIpl3ExRhepi8Ckx9qWStHFoE+N60
         PddB1nTcBq+ECU5Sdp456AJMpfRJx79qKNxqWDc0Hd127uKHIGAyFyfiO+XUQPQn/r
         mb2+JnUgaT+Cw==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2af2602848aso7693791fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 08:09:08 -0700 (PDT)
X-Gm-Message-State: AC+VfDxb63hqxZftVuWKexAKUL1Hx/KfSuu6fF05pM14jpmok2xUIyGg
        iUGg9psPJa+xjw4raDhUPwVdyVuLlaR8bhfoj+s=
X-Google-Smtp-Source: ACHHUZ5ITafro9iwmTU6vR/smLxeVBItH3Onrt90yV7r9RdUM8xsIZj5uBIiwP+QRe9z/Lw0esi3rIVYclGXiVS2V20=
X-Received: by 2002:a2e:8845:0:b0:2af:228a:a277 with SMTP id
 z5-20020a2e8845000000b002af228aa277mr1174433ljj.21.1684508946420; Fri, 19 May
 2023 08:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <ZGWdHC3Jo7tFUC59@moria.home.lan> <20230518152354.GD4967@kernel.org>
 <CAPhsuW541pcsMKYah=2U8mUs8is3jAiNKC8Erte=RkAUGFO9EA@mail.gmail.com>
 <ZGZW0v3nRShO7r+Z@moria.home.lan> <CAPhsuW5BbbxinaH2aO=2Wa0aSQ3pkNwvnrgJv7fG4QcPr_j7+Q@mail.gmail.com>
 <ZGZfLHA8vuRJwa0f@moria.home.lan> <CAPhsuW6B3O_kWjWwr+UfYO3WRkznFqBNtcecFCSECBSiZBJDsA@mail.gmail.com>
 <CAPhsuW4Mm8z4kbVo8-sPU=QL2B1Sb32ZO7teWT8qienGNuxaeQ@mail.gmail.com>
 <ZGZ5PuQxDnjHlxAY@moria.home.lan> <CAPhsuW4A8H00MV=tT9Gs_mtjn7o9KOzPjhwhdWDJMbY_9=9RrQ@mail.gmail.com>
 <ZGbPz109t9Huxrqy@moria.home.lan>
In-Reply-To: <ZGbPz109t9Huxrqy@moria.home.lan>
From:   Song Liu <song@kernel.org>
Date:   Fri, 19 May 2023 08:08:54 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7_hb9T-uuB2FuXYMs7WA_XMbV809zOPSV7eOQeh4k3Qw@mail.gmail.com>
Message-ID: <CAPhsuW7_hb9T-uuB2FuXYMs7WA_XMbV809zOPSV7eOQeh4k3Qw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] mm: intorduce __GFP_UNMAPPED and unmapped_alloc()
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 6:24=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Thu, May 18, 2023 at 01:51:08PM -0700, Song Liu wrote:
>
> > To allocate memory for text, we will allocate 2MiB, make it ROX, and th=
en
> > use it for many small allocations. IIUC, buddy allocator will use unall=
ocated
> > parts of this page for metadata. I guess this may be a problem, as the
> > whole page is ROX now, and we have to use text_poke to write to it.
>
> The standard kernel buddy allocator does _not_ store anything in the
> page itself - because the page might be a highmem page.

Thanks for the correction.
Song
>
> That's also why I went with the bitmap for my slab allocator; standard
> kernel slab allocator stores a freelist ptr in free objects.
