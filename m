Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F806946F4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 14:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjBMN0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 08:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjBMN0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 08:26:50 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB5F5FF4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 05:26:50 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id y69so1129855iof.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 05:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uPqhzuCoB0XLuHxXnDgI9ge5QiksJXrToVJ0PRvFH58=;
        b=Q2jaAutBM6WVU6eOSyM+Jf51TdrV9YHdvum+Go878b+JbP1z7k4TGPlA+XFXsjBGYj
         AFiJBAe8qNhoOCeUfnQmJUFjexxIUxej5dXjMR4Y7deTDdqbzwtEUyeBsKbN+WiWLD7Q
         HiT59kfZwbkV05Ozert6pTuGIBVgVQsuHBmPX7/g+AuFCcVgm+NVeFxxXzGzCGaHMO8+
         vKLHjdlhBJk3ldUCj2HuBni1z8gvKNslahZhJ+YA/AbZnor4pYEOOp2xM96H6JPlPc8n
         +EC9RXgST0FEDPFdA+BthKQP9z+yhEsIx38sdDK8fis4906pGpc4plmKpMP9NrJV7Dx5
         0YLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uPqhzuCoB0XLuHxXnDgI9ge5QiksJXrToVJ0PRvFH58=;
        b=Ae7w+vWSdfBnHVDfXmFMY6PSyBXuwy8WVw+kKS57Ut7wRU+inUGulMH7idZnLXKMd4
         vW0n0ORmLdZLN6bHJUoJnFHDMvw6aWmYYTL+2jCvkO8Z5JygMdRxRknRylRFGcuA5FV0
         WIswDY8+/xbDjFCg75Jhj8Y2WAuA464BfDfm6XJlb5epjITIY565XH12OFbVBIK0obQc
         IuvbmTAtnYReEVN+PqZl5U6UCypxrMLwfMIdDuvK9Euy5yphhWNxGSYvN9YB74gmRjKI
         6rsxI38vJeS3nkqS9JzuQo4wlxW9vMYMpSu1lW0ze89zb16Bum+ym4sYwAnHkXaqZtCw
         9yJA==
X-Gm-Message-State: AO0yUKVfgZq5fg/HdN66tkK/g/8QMbuu3h1ryXadU3nJn39EdlHJ71oF
        8jDnEa/2v02pWKN/HgnEO8UzhxmHc07wzTUD5pf+9w==
X-Google-Smtp-Source: AK7set9J4ldPZ+QBGTPI+WEi8bR9wdnuZY9Rz543XHjQzEhvtQCLkgtg0VDPu5lUfrMlnJVS3rENGrDgvcIojIegGm0=
X-Received: by 2002:a02:a794:0:b0:3ad:3cae:6378 with SMTP id
 e20-20020a02a794000000b003ad3cae6378mr12315142jaj.16.1676294809275; Mon, 13
 Feb 2023 05:26:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1676063693.git.andreyknvl@google.com> <5836231b7954355e2311fc9b5870f697ea8e1f7d.1676063693.git.andreyknvl@google.com>
In-Reply-To: <5836231b7954355e2311fc9b5870f697ea8e1f7d.1676063693.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 13 Feb 2023 14:26:10 +0100
Message-ID: <CAG_fn=VM34NfOhir_3y86=SKxZ=PqbC3DFuFVAmLEYp8Z9Ax3A@mail.gmail.com>
Subject: Re: [PATCH v2 17/18] lib/stackdepot: various comments clean-ups
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

On Fri, Feb 10, 2023 at 10:18 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Clean up comments in include/linux/stackdepot.h and lib/stackdepot.c:
>
> 1. Rework the initialization comment in stackdepot.h.
> 2. Rework the header comment in stackdepot.c.
> 3. Various clean-ups for other comments.
>
> Also adjust whitespaces for find_stack and depot_alloc_stack call sites.
>
> No functional changes.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> - * Instead, stack depot maintains a hashtable of unique stacktraces. Since alloc
> - * and free stacks repeat a lot, we save about 100x space.
> - * Stacks are never removed from depot, so we store them contiguously one after
> - * another in a contiguous memory allocation.
> + * For example, KASAN needs to save allocation and free stack traces for each

s/free/deallocation, maybe? (Here and below)
> + * object. Storing two stack traces per object requires a lot of memory (e.g.
> + * SLUB_DEBUG needs 256 bytes per object for that). Since allocation and free
> + * stack traces often repeat, using stack depot allows to save about 100x space.
