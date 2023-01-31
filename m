Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971AB682C15
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 13:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjAaMAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 07:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjAaMAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:00:00 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1F414209
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 03:59:59 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id k6so15810083vsk.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 03:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JZNhUAAi0ovc+Tuqz6CKcgSZC8r4ue4xEaiyWw4VTF8=;
        b=S37DVRqqxmvU5h8H83xlc+SolSrkLaJIBiIf48vCAL3FK/YUEAtpVcgjSQT7f93BAr
         09Fn1rJGaNLCTk6VLRVWufqhr+Tm/nBuY57dxsZYWRi8PMIPdncit1qg7zoM8ZKi1YfK
         cWA/jGAbvcGrgi+2fRcaeEIPhO0QG8wFxOQH7wk2LpuSTlOcVVGSC+3qkx378nz2VcBy
         KPGyuc9gJI1WFdUJv2XmLyjmkSS/A0vUceuI85rw+4wr4q4vGd7LvGmgPdv/AqX5Nlyb
         SbZO4cFiE0vnig9p69oPeQVJz2CPg5+xrSvGRc95Jdqmpu1fFq1tpR66LIVyxy2yEv+B
         ayEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JZNhUAAi0ovc+Tuqz6CKcgSZC8r4ue4xEaiyWw4VTF8=;
        b=4b1UvqoFjxYSlldabOCgf+RfjaFmsnfS9Ee3ZowVeBkUtdRPeacc5wilAI/M4ZED4r
         CnLRYrIb2YdU76JKgs/gQbFQAdxuL6WnXigpnsgPEZypJKIcBNQZljbHvToxfBGzI0Lb
         ZJLaw4WWfHKs4HXxhaLnGCpBWF/+BtIFQBukhi3kYwql+pqKBAntG3YaR3HAMpuKpaCh
         +riVC41Vh16QtaZn1VJZgek+5Er88nyZ8RdHa2ukUfcvCzFjtD0knFSSOg0POza4OkjJ
         Bm3aUkiS10HmvuDMLlz3dCDOc85429cl/5RWcaT8ugYs4chCsJ4weShz5xhQQtfMNDgv
         Axyw==
X-Gm-Message-State: AO0yUKVP2NgyN05a43E0dpMCbYEIR+i0maAAoXE1tVbEappR5Rg8VtlF
        EdNABnMTpTCTgsSvyrfzHbuvEX3d7kDzAMKjm4Vt/Q==
X-Google-Smtp-Source: AK7set8Gxy1piqmMjmjyMt5CL/vw+OsQchz0XTs4ycC3u80G1j4Kd91DD6/4xmq3qtnmdxIeAAtdDnSGuS5cZO0ovC0=
X-Received: by 2002:a05:6102:449:b0:3fc:3a9e:3203 with SMTP id
 e9-20020a056102044900b003fc3a9e3203mr662988vsq.84.1675166398494; Tue, 31 Jan
 2023 03:59:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675111415.git.andreyknvl@google.com> <fc73ab8b1469d476363a918cbdfe28e1388c043a.1675111415.git.andreyknvl@google.com>
In-Reply-To: <fc73ab8b1469d476363a918cbdfe28e1388c043a.1675111415.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 31 Jan 2023 12:59:22 +0100
Message-ID: <CAG_fn=WxZf_kfn8-G8hvoxvUT8-NKNkXuP5Tg2bZp=zzMXOByw@mail.gmail.com>
Subject: Re: [PATCH 11/18] lib/stackdepot: rename slab variables
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Jan 30, 2023 at 9:50 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Give better names to slab-related global variables: change "depot_"
> prefix to "slab_" to point out that these variables are related to
> stack depot slabs.

I started asking myself if the word "slab" is applicable here at all.
The concept of preallocating big chunks of memory to amortize the
costs belongs to the original slab allocator, but "slab" has a special
meaning in Linux, and we might be confusing people by using it in a
different sense.
What do you think?
