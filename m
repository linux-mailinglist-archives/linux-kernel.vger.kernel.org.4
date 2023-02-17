Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A397B69A88D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 10:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjBQJqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 04:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjBQJqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 04:46:46 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3304C53EC6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 01:46:45 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id d2-20020a17090a498200b00236679bc70cso1610613pjh.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 01:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9SH8M+iqgIr8G+65VlZ0io44yWlIQXBEHAm0eyAdZpw=;
        b=I16dYVnVg0XOdpqW3CxmiwV9XP2BJjqTz2eYIGN2626xfNuu9PkE+LkIgDtMQa0LfP
         EX0J7IyRqeoxA+oCdwaU/8umO+EHkSD+/UMOFzCnqR3m72uABeIs/USYQFZahCqjsyCD
         SrEALrKndVzuWGWAqgw/iAkyMf22F9IYpuEGR+3dFx6ynj9zddqFaOQXsPbZzDC4alba
         44B3He/oCz5v3EBmVRVcmTLUECkt9mqlV5ragF6sDnYijYzWSV2NYi1zddGFKu0dif1T
         Fhf/8Ni93PcoNjiHfkv90rUSnuOtXxoevvbYtoJ+UALXfTkgA/IXB02L1d2jNEURtct0
         OEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9SH8M+iqgIr8G+65VlZ0io44yWlIQXBEHAm0eyAdZpw=;
        b=N99mxJxX1JZxBB5238G4pBtQnBIL4Yc9+57yMyG98V+5tU1swQiFiV8aJXWkXTg9U5
         MeW3X3zpOM92IAXn/J46Ks/mk8fxnD40KeBLa/VxBu0ZRDTBFibdOq+g0RgYkqIKsXIZ
         Xtp1jaKI5PXIHUQ2i1NjeyaKN1bHVEEe7IvaSHKRrvoWGEJqPofug/Qpl31K0LcyKlFB
         KQ1ucXxQ5Iyf2SH+uIBQZCzvHjO7jK8YiEhm28ISRYeicrxJ39jBrlkiPIJjzYuzgWD5
         s0k+gvFe9HAi+ApPF8WBM0cCQOTBU4xDfyZvdyKBMFp4U51JDvLimUI5wuwqOThrINaW
         KYcA==
X-Gm-Message-State: AO0yUKXmxUkKyBmyIxPRAPPBiQGmaBTVDepaiMoSzJQfndh1a0KGYH81
        y3iA1g31QE0IRsscUPTn5lDTt9NjedGCqPuUMWE=
X-Google-Smtp-Source: AK7set8cf5yh6zy9YQwtWISzI389HBLjQA5O7nNvnjVWnB0VUlENZPzFv11FPIZEfQgmVMDgBswuUjc1fFcHpPcSSA8=
X-Received: by 2002:a17:902:d4d2:b0:199:6e3:187a with SMTP id
 o18-20020a170902d4d200b0019906e3187amr263451plg.6.1676627204614; Fri, 17 Feb
 2023 01:46:44 -0800 (PST)
MIME-Version: 1.0
References: <cover.1676063693.git.andreyknvl@google.com> <5836231b7954355e2311fc9b5870f697ea8e1f7d.1676063693.git.andreyknvl@google.com>
 <CAG_fn=VM34NfOhir_3y86=SKxZ=PqbC3DFuFVAmLEYp8Z9Ax3A@mail.gmail.com>
In-Reply-To: <CAG_fn=VM34NfOhir_3y86=SKxZ=PqbC3DFuFVAmLEYp8Z9Ax3A@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Fri, 17 Feb 2023 10:46:33 +0100
Message-ID: <CA+fCnZfVy6=ZKKvUWtCzMwstBjPCp7airuG9L1DSWxkKyyAAVQ@mail.gmail.com>
Subject: Re: [PATCH v2 17/18] lib/stackdepot: various comments clean-ups
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

On Mon, Feb 13, 2023 at 2:26 PM Alexander Potapenko <glider@google.com> wrote:
>
> On Fri, Feb 10, 2023 at 10:18 PM <andrey.konovalov@linux.dev> wrote:
> >
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Clean up comments in include/linux/stackdepot.h and lib/stackdepot.c:
> >
> > 1. Rework the initialization comment in stackdepot.h.
> > 2. Rework the header comment in stackdepot.c.
> > 3. Various clean-ups for other comments.
> >
> > Also adjust whitespaces for find_stack and depot_alloc_stack call sites.
> >
> > No functional changes.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Reviewed-by: Alexander Potapenko <glider@google.com>
>
> > - * Instead, stack depot maintains a hashtable of unique stacktraces. Since alloc
> > - * and free stacks repeat a lot, we save about 100x space.
> > - * Stacks are never removed from depot, so we store them contiguously one after
> > - * another in a contiguous memory allocation.
> > + * For example, KASAN needs to save allocation and free stack traces for each
>
> s/free/deallocation, maybe? (Here and below)

Either way looks good to me.

The patches are in mm-stable now though, so lets save this change for
another potential set of clean-ups.

Thank you!
