Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81445614B6B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 14:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiKANNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 09:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiKANNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 09:13:39 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B09E635A;
        Tue,  1 Nov 2022 06:13:34 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h9so20106782wrt.0;
        Tue, 01 Nov 2022 06:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QwhanQKRbqrvvgXUmj5gq6ZtQDr1OrntJTB30vFuuTY=;
        b=e0kRdjU5SzSF2BOua3Yow1NZ+w0vOGAZlt+p/2ZhBUXewN7KZEr2dyZkYJtXiZQsyx
         FWpQBlWjpc/zZlLTHY9rvvzVJk+/ecYZUqwW7wrBBi8HnsCZ55DMQd+jvby3snvRfdiA
         SpOapgjH02XgFcJ2pGRLolxiAD13mkkxmy8cS2V/PkkYmOSxcUlpp8conIALYFbNN3Hb
         8ekg98g8AlPsdxPyFfeGQHsotzfUPVkb9EAC1RjwTHzaZDJxv3E4f4jqOekJNJvvzFNd
         7rMpffBtf+VAFzYXdDwjfSusW2RWe+PQafx9KRiAJcGlYcB1biPH+VwJindyjoCRhvYn
         nKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QwhanQKRbqrvvgXUmj5gq6ZtQDr1OrntJTB30vFuuTY=;
        b=wG24oZFo5kuZHebk1/X9YkdJYi4a+AuU1uobgiI6HQNuKUZrMHRXUIdYnBloBAxkOi
         V9Q0gLBWaVhGaVUasbZ5FsqY9pbR9bPrRTiwwlGhTCryM48OC7H2Vbp3z3qLQla1DW55
         mkXWGNRsZ4JXUOgNhlDkcR6AZsPs2RUHip967jPuBcggKpgC8Rac/SnQQ7G7CgzlPcbl
         l9GJu/xVdg9QIzO9QhC0bpJVpVA5p0n8xaIqBIOW+uJLgeDQkFhEF5LiZLkvNCR5OkZQ
         SH8WUMTV1y+AofDtUC3hk6nyjxoCmAKVO//mAt8/lgDJTLXdXCk5BkRcdjCl8Q6I4j0B
         UbTA==
X-Gm-Message-State: ACrzQf1bPul2vdR4hSxBqisyJ/kE3HEvJOOLBlyVmdj3rQmI5U1enD1x
        zoUAhK5OH9lDx3khqUCfjhGGsNMjU0f3qACYg1s=
X-Google-Smtp-Source: AMsMyM5DlQ7Km2bCUVKYm8RKj16TKBqKXaqi9AjkrKlt0+HhahmyUiEE6I44GCC/vgYreiDs7lxMcPQrvm+BZr/JQAQ=
X-Received: by 2002:a5d:4648:0:b0:236:c0da:a4f6 with SMTP id
 j8-20020a5d4648000000b00236c0daa4f6mr8515976wrs.134.1667308412714; Tue, 01
 Nov 2022 06:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220811161331.37055-1-peterx@redhat.com> <20220811161331.37055-5-peterx@redhat.com>
 <20221021160603.GA23307@u164.east.ru> <Y1Wbi4yyVvDtg4zN@x1n>
 <CADxRZqy+cMHN4FjtDr7-LOyVf0y+G8MPiBoGiTEsSj48jBfVnw@mail.gmail.com> <Y1f2IR+h4i2+/swj@x1n>
In-Reply-To: <Y1f2IR+h4i2+/swj@x1n>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Tue, 1 Nov 2022 16:13:20 +0300
Message-ID: <CADxRZqz+Sk=yxrJQ8B7UVkrcct9w6nUeiaaVn7QTFL59isFLDA@mail.gmail.com>
Subject: Re: dpkg fails on sparc64 (was: [PATCH v4 4/7] mm/thp: Carry over
 dirty bit when thp splits on pmd)
To:     Peter Xu <peterx@redhat.com>
Cc:     David Miller <davem@davemloft.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Alistair Popple <apopple@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 5:43 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Oct 25, 2022 at 01:22:45PM +0300, Anatoly Pugachev wrote:
> > On Sun, Oct 23, 2022 at 10:53 PM Peter Xu <peterx@redhat.com> wrote:
> > > On Fri, Oct 21, 2022 at 07:06:03PM +0300, Anatoly Pugachev wrote:
> > > >
> > > >     Link: https://lkml.kernel.org/r/20220811161331.37055-5-peterx@redhat.com
>
> Maybe we need to have the minimum revert for v6.1 before we have more
> clues.

Just a quick update on 6.1.0-rc3

Tested again with 6.1.0-rc3, segfaults dpkg... applied patch - no dpkg
segfaults.
