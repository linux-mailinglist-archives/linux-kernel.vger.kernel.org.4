Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AE769A899
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 10:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjBQJun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 04:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjBQJuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 04:50:40 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D2162FE9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 01:50:36 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id ev7-20020a17090aeac700b002341621377cso577273pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 01:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TTTi9sqA4taT7mQsE24E/BMxLx1RUOLEc/kI+W+BpqE=;
        b=ldqJT16LYD9mRVCoQDkhTqpzelCTrk43UIm9gToZXACH7ESR6+f51LLd8iMLd5i/5f
         nl3FY3K8ROIZQCcRBgs6geEqkPCE6ZX5NGo7yikxZlT4eBDgiTBPFCM/O2I+mE3TLLQp
         xxSv6sHnC1p64srJM0pdaylau0YpEmVV2g7mID2jBm3CPJjRjJsnhE1l1ovuxnb19UeZ
         7v3yeGw5+nQxN4zgNH4qIQEpddnYlwpbMaASCuLulgbimSdOOlAXOOG2xe0qH2Xumlhn
         9F/NKABVsy/IUcawIKAblDjgdZddv6MR0ytIryuybIucgI/bTPw+NSQ7cIqlmT3ZAIga
         RWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TTTi9sqA4taT7mQsE24E/BMxLx1RUOLEc/kI+W+BpqE=;
        b=QKOI08Uum2iBQb3kJQMxR6WNX8Aiw8CzDqFkSzPk4fZXFz3BV/mxY/aZ97RDsa44CN
         xNwbX6H7dk2I6xx/o67myjPDgx/OqVTPDqYz6un94zZsHtKM3N9sNSVZySF1+f59nDPM
         HeLtt/Ab7r0LaAg0xaAKCLxB3X0mt87AJoQdl68KMAGYM10LTiarCFVdqgg3VLDnZj9x
         xRiRi2tbnzcZhZ5iMtx17kJcKULhYxWfQfjrlxMRmSfRur1xOa5MZ03O35J9wllwb0dL
         WkciL+pwf/PJUhAyODQF6uso2tpHrX90UOt51zG/4vefRQ0DQ1GFJDiWDn2ZlY2q95WW
         xweg==
X-Gm-Message-State: AO0yUKUr/MG1hC6JUK0x4+RaW+3DbGEnwufbBWJ3LAJxPyHDzN0oOBMR
        0bsrrgxVgZAIyzNq42AzuBo16bWkTOPChoMxmbo=
X-Google-Smtp-Source: AK7set8fTycHc6RsvNxa2gkXvGfoR1jOksoqSKCe6wwtOOit5d83xUWBoUGm9a0tSVNpK0tSPRPHUS2WpSTyZKgtXv4=
X-Received: by 2002:a17:902:c3cd:b0:19b:f946:e57d with SMTP id
 j13-20020a170902c3cd00b0019bf946e57dmr167155plj.11.1676627435846; Fri, 17 Feb
 2023 01:50:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1676063693.git.andreyknvl@google.com> <fbfee41495b306dd8881f9b1c1b80999c885e82f.1676063693.git.andreyknvl@google.com>
 <CAG_fn=XEP2ETd5c8Pz2Eri2mHpDzewnBLWoQC=_Z3VKke9w_0g@mail.gmail.com>
In-Reply-To: <CAG_fn=XEP2ETd5c8Pz2Eri2mHpDzewnBLWoQC=_Z3VKke9w_0g@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Fri, 17 Feb 2023 10:50:25 +0100
Message-ID: <CA+fCnZcA8Eh6Bn0_2Jsyjtm=FfqmGk__Rg=3_rudCzG31-JJ6g@mail.gmail.com>
Subject: Re: [PATCH v2 18/18] lib/stackdepot: move documentation comments to stackdepot.h
To:     Alexander Potapenko <glider@google.com>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
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

On Mon, Feb 13, 2023 at 2:28 PM Alexander Potapenko <glider@google.com> wrote:
>
> On Fri, Feb 10, 2023 at 10:19 PM <andrey.konovalov@linux.dev> wrote:
> >
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Move all interface- and usage-related documentation comments to
> > include/linux/stackdepot.h.
> >
> > It makes sense to have them in the header where they are available to
> > the interface users.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Reviewed-by: Alexander Potapenko <glider@google.com>
>
> > + * For example, KASAN needs to save allocation and free stack traces for each
> > + * object. Storing two stack traces per object requires a lot of memory (e.g.
> > + * SLUB_DEBUG needs 256 bytes per object for that). Since allocation and free
> > + * stack traces often repeat, using stack depot allows to save about 100x space.
> > + *
> > + * Stack traces are never removed from stack depot.
> ... from the stack depot?

I avoided using "the" for stack depot everywhere to make comments a
bit shorter, but I don't mind using it.

I see that Andrew already added a fix for this. There are other places
where "stack depot" is used without "the", but lets save this for
future clean-ups too.

Thanks!
