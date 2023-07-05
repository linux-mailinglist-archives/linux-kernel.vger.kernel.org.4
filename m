Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CB57484CE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjGENTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjGENTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:19:20 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2891713;
        Wed,  5 Jul 2023 06:19:20 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b8a8154f9cso5217455ad.1;
        Wed, 05 Jul 2023 06:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688563159; x=1691155159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHD+gumzoWP+nl3VtSqoKGEKW4lPTUyBTvzSxtXSgic=;
        b=asQQxGjGoyEoGcp0NIF7Aq/cB3t8GLX4OuYOJWGn/pxr5hkHba1+Vtu62kNUqA3ANS
         cbt3exB8yJCokdcq3izXIcpAt6HmIxDv7B7EUBfJLMFm6a5y9kLjSMQdA5t7Ud/jGXsM
         8bNCd8+pnLMgVeuQystG16cJbyHeoNl0grbUkXBgLveBWatIchIPKk0ARqfT4jxJnYXM
         EfqwIZ59JOWRep7p1bT0wZBk4wQB9T1Xg5XdQbWHg0wztHBylfFnLMMJVPHeRDdlDDiK
         vxc5RCHbyVuf4onWIeE9whQt2lTa/Cu621QMa5e3sEOW16rXVPIb4VmCPwI1xfB/P7Mm
         mZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688563159; x=1691155159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHD+gumzoWP+nl3VtSqoKGEKW4lPTUyBTvzSxtXSgic=;
        b=dLZb0DPkmiTJlx/2AvR1aQIYCcykfSESDhLjz994jjOPDNPR+1eKke9Vvo+EGEMq2K
         Er0HbV8zxhttjP2bzVMcNHLFtc//5Am9BnrUlDtNVzAu0NSFbE96MloLXvBSNuPrU9Hz
         ULXh8+UFEP6QGMJSoHtA0sZ7R002FqZuvs67vWhtDo7E+rK9GEb21qj52FY+XfpbRLsW
         wvcR92zaVI56cENLhwQ+cXp9l4UkuVv1w19dlsRC5TPTjz2oz4BOe4qQ/V+iQFD9o1iR
         t7cbTeoqJm7MJySmAirT7DkMl6GxeqtkfxCZZxxS755o3S7Hj9ZMR67b8y1RvN5fDHqs
         xOiw==
X-Gm-Message-State: ABy/qLb2AtSSonTkzXZRnw0dKFc8E25FTvtZpTX+1P2/WjC2LFKm3INE
        P9K2P7t4WC8X6I2MD1kPtvgZ0PsE8czP7OPwa7o=
X-Google-Smtp-Source: APBJJlFMxcKhkpFMy8Afh17cwFaJLPJkAfv85FqPfqTqtaMzLuDJiGQDW1AWfQwv+AvoCm9fDTTPpplJMQAZhEYfJF0=
X-Received: by 2002:a17:903:228d:b0:1b8:8d48:958d with SMTP id
 b13-20020a170903228d00b001b88d48958dmr3547209plh.1.1688563157269; Wed, 05 Jul
 2023 06:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <678ac92ab790dba9198f9ca14f405651b97c8502.1688561016.git.andreyknvl@google.com>
 <CANpmjNO+spktteYZezk7PGLFOyoeuFyziKiU-1GXbpeyKLZLPg@mail.gmail.com>
In-Reply-To: <CANpmjNO+spktteYZezk7PGLFOyoeuFyziKiU-1GXbpeyKLZLPg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 5 Jul 2023 15:19:06 +0200
Message-ID: <CA+fCnZenzRuxS4qjzFiYm05zNxHBSAkTUK7-1zixXXDUQb3g3w@mail.gmail.com>
Subject: Re: [PATCH] kasan, slub: fix HW_TAGS zeroing with slub_debug
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev, Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Feng Tang <feng.tang@intel.com>, stable@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Will Deacon <will@kernel.org>
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

On Wed, Jul 5, 2023 at 2:51=E2=80=AFPM Marco Elver <elver@google.com> wrote=
:
>
> On Wed, 5 Jul 2023 at 14:44, <andrey.konovalov@linux.dev> wrote:
> >
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Commit 946fa0dbf2d8 ("mm/slub: extend redzone check to extra allocated
> > kmalloc space than requested") added precise kmalloc redzone poisoning
> > to the slub_debug functionality.
> >
> > However, this commit didn't account for HW_TAGS KASAN fully initializin=
g
> > the object via its built-in memory initialization feature. Even though
> > HW_TAGS KASAN memory initialization contains special memory initializat=
ion
> > handling for when slub_debug is enabled, it does not account for in-obj=
ect
> > slub_debug redzones. As a result, HW_TAGS KASAN can overwrite these
> > redzones and cause false-positive slub_debug reports.
> >
> > To fix the issue, avoid HW_TAGS KASAN memory initialization when slub_d=
ebug
> > is enabled altogether. Implement this by moving the __slub_debug_enable=
d
> > check to slab_post_alloc_hook. Common slab code seems like a more
> > appropriate place for a slub_debug check anyway.
> >
> > Fixes: 946fa0dbf2d8 ("mm/slub: extend redzone check to extra allocated =
kmalloc space than requested")
> > Cc: <stable@vger.kernel.org>
> > Reported-by: Mark Rutland <mark.rutland@arm.com>
>
> Is it fixing this issue:
>
>   https://lore.kernel.org/all/20230628154714.GB22090@willie-the-truck/

Yes, my bad, messed up the Reported-by tag. The correct one should be:

Reported-by: Will Deacon <will@kernel.org>

> Other than the question above, it looks sane:
>
> Acked-by: Marco Elver <elver@google.com>

Thank you, Marco!
