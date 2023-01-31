Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEED6835DB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 19:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjAaS6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 13:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbjAaS6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 13:58:10 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77D730B15
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:58:09 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id a184so10921542pfa.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bCWK8k8m5VD33jjUoYPOLmfdpETQJTETp3AURhGUsTI=;
        b=dou2JilzlSfcvD6beS/Lc7cUD4v6y1YTLvqqI6xnQ2iXPrGyqyNyFytIfursaV15G1
         1CSvEbmrKE7U5Hbxk46wdTs8ETu2idQVtwYxVcZG+HkPWeZiPqWHmkcSYHr8o0WnHVRZ
         7nWbpmtPqJ3DO4YjV6aLbJ6K/19Ec4kxOFo9vduSFZSR8JIlMqpkGbNBjAbT5lhsdvnj
         ZqtVZdIT5mw7ILf5qFHwrZ/IESHzJX1XzLMQ1cHuuVhapZntySbnwoXrR9j2DWxp/UKv
         CdFlwMop+9m3Mqc14Gxl4E0IvqismmudhrgG70wVQ1ofkgq8bogEJT0mop1XBzYla/jx
         Lx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bCWK8k8m5VD33jjUoYPOLmfdpETQJTETp3AURhGUsTI=;
        b=F/08Bi94o4XDV59SPF91E0Tg8MnTIiGQUuo42LIpyu2d093iMVzSRE3HQvgpesyi2R
         UMYzv3ke/CfAiYvYKbfGNoSeAq3UW8LpDO00/1V/VmRRD5pLpcPGPZUimoXwn5dbS28x
         lyvrKAIdu5ith7OGQK1GE+mgyqydBr4wTsiikt7vGh0LoW4zgBAxH0f/38NkarOc9bdV
         CK38o4Eyt4KHY3JCDWjLAM+wv1A33o7bx0/c50uJkFnDPdAk/S8a3Lz2JjzLGp4xVxJm
         UbFo5C5E672TY7d+CGia6w/BHc6UIjxBXMLwKQcPhZ8nmvNahFdFFmYNFu2hzyhsAN+/
         EM8A==
X-Gm-Message-State: AO0yUKV4SWdMtDWDSXXd+9ofAF0WOtW8OQR3T2hcexsSIoNCdK6Rehg1
        qV8aMWMtI6CLjAyaUirAtQr4b9bD/kyG/iY9xLYi60Az
X-Google-Smtp-Source: AK7set8dA9Ys2TgYqLX2FGRSRFnPJERimQrle+4WRunjf0aTyqg/0dZcq4caPZM9ksDh+XPYg2QgTXqqhJxAB2I+vFU=
X-Received: by 2002:a05:6a00:9aa:b0:593:e0ce:fc20 with SMTP id
 u42-20020a056a0009aa00b00593e0cefc20mr1061238pfg.28.1675191489136; Tue, 31
 Jan 2023 10:58:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675111415.git.andreyknvl@google.com> <19512bb03eed27ced5abeb5bd03f9a8381742cb1.1675111415.git.andreyknvl@google.com>
 <CANpmjNNzNSDrxfrZUcRtt7=hV=Mz8_kyCpqVnyAqzhaiyipXCg@mail.gmail.com>
In-Reply-To: <CANpmjNNzNSDrxfrZUcRtt7=hV=Mz8_kyCpqVnyAqzhaiyipXCg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 31 Jan 2023 19:57:58 +0100
Message-ID: <CA+fCnZdwuAm-fD-o2Yq86=NgU=YympuwAmERN9KwjpYfkPeYLg@mail.gmail.com>
Subject: Re: [PATCH 16/18] lib/stackdepot: annotate racy slab_index accesses
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
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

On Tue, Jan 31, 2023 at 9:41 AM Marco Elver <elver@google.com> wrote:
>
> > diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> > index f291ad6a4e72..cc2fe8563af4 100644
> > --- a/lib/stackdepot.c
> > +++ b/lib/stackdepot.c
> > @@ -269,8 +269,11 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
> >                         return NULL;
> >                 }
> >
> > -               /* Move on to the next slab. */
> > -               slab_index++;
> > +               /*
> > +                * Move on to the next slab.
> > +                * WRITE_ONCE annotates a race with stack_depot_fetch.
>
> "Pairs with potential concurrent read in stack_depot_fetch()." would be clearer.
>
> I wouldn't say WRITE_ONCE annotates a race (race = involves 2+
> accesses, but here's just 1), it just marks this access here which
> itself is paired with the potential racing read in the other function.

Will do in v2. Thanks!
