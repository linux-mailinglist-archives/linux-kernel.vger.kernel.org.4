Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02D56835E8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 20:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjAaTAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 14:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjAaTAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 14:00:15 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638384B1B0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:00:07 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id a184so10925159pfa.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w3/WE1wMhkpHW4nP7y1SsKn66zt1nWRGpIbsLu/1uw8=;
        b=kzhGg2/m3NTY9DKZZnThP6o85dv5BS/efwYYw/Eh+3CMn7EGD0X3HEA/KGDRxXxA7y
         hkC3VGV27xOqXBUpBnm1UGJwEfYYeGVPRr6OhNAtqNAE6TNUYmYCerNfdvqGRc4PaaM8
         l2kWzfiOBDmJ3Ubh/bf1V10B0rC1+k/jD+zW/NVd6yW3R6C5554QGiE3EbRFT9RwXxBx
         YP+fnu1kGsJ45zW8dWgm1OoeHm8DT+Df5HFt/rLxs+dGGhM5ypIdGmKfF1xYbJxoFEdr
         RQF+tRCmpnhiwDYFIFHKsLF2vxLAIniK0QaTCLe/OgRFUrDgCpMCO9+Bg6inkUOm+zq9
         6Ycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w3/WE1wMhkpHW4nP7y1SsKn66zt1nWRGpIbsLu/1uw8=;
        b=kufEB8A6q9L5Gj4+dzb2uJYREvzU3rj9BS1g4jT6C0w4z9ps47vYKSAcXjFy0y0h6u
         DYKC66vsjs57X2arwHBxt8PPDxQgWib0irt2PrvmVJFfO0qe6RZ/eCVL261hO/5sfgM1
         k6/RZhaLSaNbkxLqMaAKTPSlm1EpuA2YY1ykxpucyqKNmGRDR9DYOuIP5LdeO71+Gr3u
         t4ZwU9ZfsYkfw5vj7vJE4wCQXXkeY5rS/c7hXq7WAzMKVs20hTefI6XC0FxKyqu8Ss7V
         EjsEssnOUFL5HMTKO7hxOrYLdiQXI4WVEUCuBNvvTEBmDXCVmMNDFAgrC5goQlrKB2SY
         YQnA==
X-Gm-Message-State: AFqh2krdXKAECpc8u51eJ8DwqQ+Bv7wDFM5LAP8wcasrcpr7nPT0GQta
        qclMLhjueeyS/1yXEaWnSLY/fWqhFakL2B83zjU=
X-Google-Smtp-Source: AMrXdXvivcKw9xG2hqDoVShH9pk8i1fRloruRBEB3dI190pnIcWOJtD8ST38uUF3rkQWBP+Qoez3loJHZygKiAYFJOk=
X-Received: by 2002:a63:f657:0:b0:477:a33f:4858 with SMTP id
 u23-20020a63f657000000b00477a33f4858mr6531588pgj.76.1675191606922; Tue, 31
 Jan 2023 11:00:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675111415.git.andreyknvl@google.com> <9fbb4d2bf9b2676a29b120980b5ffbda8e2304ee.1675111415.git.andreyknvl@google.com>
 <CAG_fn=VO0iO4+EuwDR0bKP-4om9_Afir3fY6CExKGRNad+uPLA@mail.gmail.com>
In-Reply-To: <CAG_fn=VO0iO4+EuwDR0bKP-4om9_Afir3fY6CExKGRNad+uPLA@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 31 Jan 2023 19:59:55 +0100
Message-ID: <CA+fCnZfjbHaS9So6gO_3ZkgLazJXYAtw-PNV5C0xhAjzVE3p-Q@mail.gmail.com>
Subject: Re: [PATCH 01/18] lib/stackdepot: fix setting next_slab_inited in init_stack_slab
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

On Tue, Jan 31, 2023 at 10:30 AM Alexander Potapenko <glider@google.com> wrote:
>
> Wait, I think there's a problem here.
>
> > diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> > index 79e894cf8406..0eed9bbcf23e 100644
> > --- a/lib/stackdepot.c
> > +++ b/lib/stackdepot.c
> > @@ -105,12 +105,13 @@ static bool init_stack_slab(void **prealloc)
> >                 if (depot_index + 1 < STACK_ALLOC_MAX_SLABS) {
> If we get to this branch, but the condition is false, this means that:
>  - next_slab_inited == 0
>  - depot_index == STACK_ALLOC_MAX_SLABS+1
>  - stack_slabs[depot_index] != NULL.
>
> So stack_slabs[] is at full capacity, but upon leaving
> init_stack_slab() we'll always keep next_slab_inited==0.
>
> Now every time __stack_depot_save() is called for a known stack trace,
> it will preallocate 1<<STACK_ALLOC_ORDER pages (because
> next_slab_inited==0), then find the stack trace id in the hash, then
> pass the preallocated pages to init_stack_slab(), which will not
> change the value of next_slab_inited.
> Then the preallocated pages will be freed, and next time
> __stack_depot_save() is called they'll be allocated again.

Ah, right, missed that.

What do you think about renaming next_slab_inited to
next_slab_required and inverting the used values (0/1 -> 1/0)? This
would make this part of code less confusing.
