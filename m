Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC906835FB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 20:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjAaTC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 14:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjAaTCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 14:02:25 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9722D5975C
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:02:08 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id u5so10599474pfm.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=njgLhJzeDdAc0gMdbdqYyGExvQqOhYrpiMsVMjpoO90=;
        b=YUleBjQD2fhU1By6PsZqxi2pk6KNzePhS+WBhWuRbmUCtEeFwt13ANkAU2icWb0VqH
         g1czBs4EN8kYMj6FSi3v5wN0qvFRfBwmBUMYiknyympByZYaZpSSZei0Rdu2fVpNCNmc
         NQFvumne5jMbTIGM3mhe0MvbRBx18jJpYlFz3vD5C3Yr6ptRq2ff508ZNzA92MF705rk
         FtkVbVx2SkUXaiRT3Y4LGqcl6EAofQ7IgHvHsYMKNUi+b9En8WpEAdiZojavA3Qt9IZe
         v1FliX9FkJazPv+R/tswWQQcKmLYK2by6ip84XHKv9BJaQ3lAzIKAqI6NWuSoFIpFK69
         ENBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=njgLhJzeDdAc0gMdbdqYyGExvQqOhYrpiMsVMjpoO90=;
        b=ovFnRIXII3ilV8dOUQar7QGftvyLZKcMfZBtof1hkIgO6CqG7JxCZKZrff6yfo0z2N
         bWlQzMdhd28gfQhKSKvdjbycrRGgfe0MOeqDYsNaSzqfIwGt24mICpe+luJNz8C8JLVO
         SSdtz4QlswfZEiBVpkNDRiBKLLu581qKI7R9kh5DgSvJLFy9dH+jXALX3QxMhqpg1TbW
         C2Hfxvs1VOc/yiRrOx8buPrvcTK2QY7+QVUB76u3g9DPiJncjA+uQnXdYurDpj8YXTdA
         FnZwub4MKFkRlqwNDdF3iBoj9eZ1gl+taf81JjjZG5DyuyWSXFnfTMSTfs2B1ZZmK9tU
         OIhg==
X-Gm-Message-State: AO0yUKUbn8ekpf7nVKvHq3Yq+KzHk5qVuk3cEQseEmnxt0UYp2RWYlpA
        ZMEGTcFigzJDCQT25vF+qWvFWpc8kDkHYYF5B+s=
X-Google-Smtp-Source: AK7set/lesTXQEGlXe0l4epZ1hEzkSuCaKIJMqD4LcpRzLOpkOmJ6IoTCfquvJZck0OJAsKR8xdKdNEGspHp53MJqSk=
X-Received: by 2002:a05:6a00:9aa:b0:593:e0ce:fc20 with SMTP id
 u42-20020a056a0009aa00b00593e0cefc20mr1063609pfg.28.1675191728068; Tue, 31
 Jan 2023 11:02:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675111415.git.andreyknvl@google.com> <5456286e2c9f3cd5abf25ad2e7e60dc997c71f66.1675111415.git.andreyknvl@google.com>
 <CAG_fn=XhboCY1qz6A=vw3OpOv=u6x=QBq-yS5MmA0RbkD7vVJQ@mail.gmail.com>
In-Reply-To: <CAG_fn=XhboCY1qz6A=vw3OpOv=u6x=QBq-yS5MmA0RbkD7vVJQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 31 Jan 2023 20:01:57 +0100
Message-ID: <CA+fCnZfJdjgwoONLXcq4qdbMcJvRavhVp021XNM_7VM+4pUGyA@mail.gmail.com>
Subject: Re: [PATCH 09/18] lib/stackdepot: rename hash table constants and variables
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

On Tue, Jan 31, 2023 at 12:34 PM Alexander Potapenko <glider@google.com> wrote:
>
> On Mon, Jan 30, 2023 at 9:50 PM <andrey.konovalov@linux.dev> wrote:
> >
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Give more meaningful names to hash table-related constants and variables:
> >
> > 1. Rename STACK_HASH_SCALE to STACK_TABLE_SCALE to point out that it is
> >    related to scaling the hash table.
>
> It's only used twice, and in short lines, maybe make it
> STACK_HASH_TABLE_SCALE to point that out? :)

Sure, sounds good :)

> > 2. Rename STACK_HASH_ORDER_MIN/MAX to STACK_BUCKET_NUMBER_ORDER_MIN/MAX
> >    to point out that it is related to the number of hash table buckets.
>
> How about DEPOT_BUCKET_... or STACKDEPOT_BUCKET_...?
> (just bikeshedding, I don't have any strong preference).

This is what I had initially actually but then decided to keep the
prefix as STACK_ to match the stack_slabs and stack_table variables.

However, I can also rename those variables to depot_slabs and
depot_table. Do you think it makes sense?
