Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA4174B7A3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 22:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjGGUIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 16:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjGGUIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 16:08:43 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A686E3
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 13:08:41 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-c5f98fc4237so2477855276.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 13:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688760520; x=1691352520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmHd/859/Bit4qucqZpPNnDSCbdMa8IL8SYbSrObhB0=;
        b=4ZKOTCpj9xlgCXUEm8oB9fxPpMW4zNUE/1LcyAtNiug/QRRgWh4T+Iz1KBomOIRU/O
         M6flWXHwnMBjPzj/2Uhhz2BIwVcH4eJN4AS6rSurgWMTk6aqExtdp/Vwvw6lZUOSSKMd
         UWnwE/qXxMW3g1yX3ibp50dDsfQj47wFKl/hMbbgxSLKsQcdSld0N5W5ZOSmzKSrfaI8
         lwYnzShPbga+2kujDZyJFveO/ePYfePz9w00ezFjkODhap/rSDvQlJ7n7lpVqMplkOYm
         I6Ok4eNQwtFh4A0Gv9HtCPUtZDhVOqV0ESqXMSOooohHHVjJdixj+5LZ8YGeI5aj53K/
         m2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688760520; x=1691352520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CmHd/859/Bit4qucqZpPNnDSCbdMa8IL8SYbSrObhB0=;
        b=PPvt2FhKX97WAYxO0VQYeRImACCIGzddfEAscCB3KQIMjWVovR124M9rnX8+JDhhKw
         h0bJN2Atu3DjbzmGmDdcUc0uarwJAei+3ikevHdAyUgsjGzGhDXzBTH30kmQ3rY82aYT
         iQ9q7DJmtjfoqOTsNAsQY1h3OnjES+5wClI32rugVPesmabkiY4LcFK15KRx9hM0qNld
         G6cZcFs6a1z2k5KrF+RKhqiynjo7qxZ87ktXiuoflsxL4ol9dFObxVWTm2o2ox/YVXOf
         iF1VzFfV784024dDGvFCJWhlWF+tsXqjxZcuY27PscBZ1+YzM6caG2+boC6/rc4V9uKN
         n5+Q==
X-Gm-Message-State: ABy/qLbTBmm26myxB4NOS4SKV0pdH+h67YXzhmU4mSqa5dnj80ZJXvt1
        dMpbAO8mM8XcXGzXIzLRlbA8rZrMVgQSUN8L5nOWfw==
X-Google-Smtp-Source: APBJJlHLv8Tex0uCUJHNjt+PuWIzMenl4+5t76ArY9ljMJ8iMAkKtjBzDY5gKdUODpN4btNpDpQYQPxjx59FzqHs4ac=
X-Received: by 2002:a25:641:0:b0:bcb:c3d6:2b1d with SMTP id
 62-20020a250641000000b00bcbc3d62b1dmr5298177ybg.34.1688760520258; Fri, 07 Jul
 2023 13:08:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230707043211.3682710-1-surenb@google.com> <e26c40f7-0329-c223-2544-503c64123f5a@web.de>
 <ZKhvgm6geUvLPQKk@casper.infradead.org>
In-Reply-To: <ZKhvgm6geUvLPQKk@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 7 Jul 2023 20:08:29 +0000
Message-ID: <CAJuCfpFj_OWi=SRgUp=f3MAhb988fZL46oWKpL1jM15i91x5Yw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: lock a vma before stack expansion
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Markus Elfring <Markus.Elfring@web.de>, linux-mm@kvack.org,
        kernel-janitors@vger.kernel.org, kernel-team@android.com,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Greg Thelen <gthelen@google.com>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>,
        Pasha Tatashin <tatashin@google.com>,
        Peter Xu <peterx@redhat.com>,
        Punit Agrawal <punit.agrawal@bytedance.com>,
        Shakeel Butt <shakeelb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>
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

On Fri, Jul 7, 2023 at 8:03=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Fri, Jul 07, 2023 at 10:00:42PM +0200, Markus Elfring wrote:
> > =E2=80=A6
> > > write-locked to prevent page faults into the VMA being expanded. Add
> > > the necessary locking.
> >
> > 1. Would it a bit nicer to put the second sentence on a separate line
> >    in such a change description?

Maybe. Will do if there is a need to post a v2.

> >
> > 2. I noticed that you put the address =E2=80=9Cstable@vger.kernel.org=
=E2=80=9D
> >    into the message field =E2=80=9CCc=E2=80=9D.
> >    Would you like to specify such a hint as a tag?
> >
> >    See also:
> >    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/Documentation/process/submitting-patches.rst?h=3Dv6.4#n264

Yeah, I always forget that :(

> >
> > 3. How do you think about to add the tag =E2=80=9CFixes=E2=80=9D?

I thought about it but was not sure which patch I should list under
such tag because the rules for stack expansion changed recently.

> >
> > 4. Will a cover letter become helpful also for the presented small patc=
h series?

Not much to say other than "add some missing locking" :)

>
> Markus, your nitpicking is not useful.  Please stop.

I'll fix the nits, at least the ones I can, if there is a need for v2.
