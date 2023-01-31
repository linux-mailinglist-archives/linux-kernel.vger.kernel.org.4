Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E77F68360B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 20:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjAaTGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 14:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbjAaTGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 14:06:19 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDE85354A
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:06:07 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id b5so8827938plz.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k3nPPwIeG38k9HpNI9M5BUtMRo8jsnar37fO5F7Z5gc=;
        b=RFEEyNFB81EgPiRNzaeYAzqI+azGULXszG2Ji5ZwlGVtcjwbupN4DEwFbw0wDRipRP
         uNdu+V5jNDUvqfw+erX6USk3NxD8N9B6hzz/3tO8qVCip/R7rFufiYwIK8FQzPIUuOOV
         mTRxaHXB2dFg7bhU9yz3fdoQ3eRl79OSgxs+u650ciDMoL8KA7R5jVp3q9lreq6KqcgJ
         P6S+gQcN8ZYDroi4/D5ZJ1PwtzmjVWxVIinriKrTC/e8g982JTMi0nYZ7d0RSBmMdR1D
         CDSPube4YWzqj3/s/U5Fog7qpVYrEHYiVIHGmjuejoubqCKOqNlDecZSEHMoKXNTnqFT
         uG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k3nPPwIeG38k9HpNI9M5BUtMRo8jsnar37fO5F7Z5gc=;
        b=oeyZ43XMn0yYpjhJXu/8iyJDczXon51R7dELa17tnBUbprOe0OskeMdjILwseJ+Qko
         JKCu/pkF7EaycaQGLf8h/jYsS5375554r8tELugOFox1EZg5olsJpANJWPg0NEPGLzKp
         zgDL/QwhRtWC7zfhy0OGCLd/eQaBtx18snkApDVsKBvGkIZnHGUiCHBkPN0CZohZfNWL
         dijBU1tt48T/p1Jg4GedLpqkAwQotEkShGaGaukNfNvg/55cio5oKmwXWF3yURa9HR2f
         xBB40+1ZJwxX3HT5rv64nRUDB6q7uXuYftK5mGNZW/aAbEVFU3LSBz2pPK4u80H+UJX7
         aRZA==
X-Gm-Message-State: AO0yUKUweJMp6Sx0JsMa/pf7p8lBF7wW4tVmEkowBvBm5VJ9BLnLQKYV
        b7ymfy3Zd1k5t+W/eAyLqk17chhHgd5jSxbtz4c=
X-Google-Smtp-Source: AK7set9zweHjaZM6LJLNtf5MlxPUS5wJZ32kQ43HCMdESj6IxM2UzpbKCeHQWgCyJdUGKcUcEoJ9YmfmRE5opkS1OKg=
X-Received: by 2002:a17:90a:9316:b0:226:e191:4417 with SMTP id
 p22-20020a17090a931600b00226e1914417mr64670pjo.16.1675191967117; Tue, 31 Jan
 2023 11:06:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675111415.git.andreyknvl@google.com> <fc73ab8b1469d476363a918cbdfe28e1388c043a.1675111415.git.andreyknvl@google.com>
 <CAG_fn=WxZf_kfn8-G8hvoxvUT8-NKNkXuP5Tg2bZp=zzMXOByw@mail.gmail.com>
In-Reply-To: <CAG_fn=WxZf_kfn8-G8hvoxvUT8-NKNkXuP5Tg2bZp=zzMXOByw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 31 Jan 2023 20:05:56 +0100
Message-ID: <CA+fCnZdOFOUF6FEPkg2aU46rKYz8L9UAos4sRhcvfXKi26_MUw@mail.gmail.com>
Subject: Re: [PATCH 11/18] lib/stackdepot: rename slab variables
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

On Tue, Jan 31, 2023 at 12:59 PM Alexander Potapenko <glider@google.com> wrote:
>
> On Mon, Jan 30, 2023 at 9:50 PM <andrey.konovalov@linux.dev> wrote:
> >
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Give better names to slab-related global variables: change "depot_"
> > prefix to "slab_" to point out that these variables are related to
> > stack depot slabs.
>
> I started asking myself if the word "slab" is applicable here at all.
> The concept of preallocating big chunks of memory to amortize the
> costs belongs to the original slab allocator, but "slab" has a special
> meaning in Linux, and we might be confusing people by using it in a
> different sense.
> What do you think?

Yes, I agree that using this word is a bit confusing.

Not sure what be a good alternative though. "Region", "block",
"collection", and "chunk" come to mind, but they don't reflect the
purpose/usage of these allocations as good as "slab". Although it's
possible that my perception as affected by overly frequently looking
at the slab allocator internals :)

Do you have a suggestion of a better word?
