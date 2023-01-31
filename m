Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028B9682B91
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 12:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjAaLeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 06:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjAaLeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 06:34:09 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B2BCDE9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 03:34:08 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id i188so15683823vsi.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 03:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i8eUarQKx4zlWnr8p6102+JRBW/gc9YxRunt0DbrPaA=;
        b=Hu3jY71lNtAtQxbsDMTMKp2xklIgIO3mPHIJ79EvZmZNNyhd1TYzer4rk+msSCIaZi
         6BpkIKPeadpYBXTEv3kKK7PtmeQJEngDwb9+OwDKiTrseJp3XtJMuiPWQl70kLvu0WJG
         y6Fs3pCfGfTPPpJ4VgOTzowNbiD+qYeJ0mD29iB+t8Cvdx3bnW5lBq5bDQridA6KALXA
         HhIsQWPGYUwIxY47pyV6JcDoSFdSIG3M2+cglWIGXCLY5s2yTTkXH5A5NwcXG95DNtPr
         /xEvmkqqTB8ICwRhrlWcpW6lwqL6G4NmHvOx1sHXbObgz50sSPsLpMG4J51F/sPAl/Vf
         LilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i8eUarQKx4zlWnr8p6102+JRBW/gc9YxRunt0DbrPaA=;
        b=C4kZflCiGAcOWZ6VBQfJ1r+CWgyS6n5lorpjJnOL2ArbF6weL2JSoBN6WywnQl3anT
         ijoecTVoQeI1MG57YfKHrhpK6K/LBX6U29VB2nRthLZqoEOZvnenjxDYMEs9/tYi14I3
         4BRUem0aRPTfGrBPblNtmHpAbXdkpoegTrimFbnCsk04qJqGgKFwlmXZcrVjk3eHrl+X
         o1C1o1k3zmMrOzMi6thlLMUMGmCJneclkYih75lVOt2phk3bR3//xCieljlIJGF8FLsF
         qEY6bGQ1TGsqKW09f12kSN6qvKIZFq1hSH1V/o0NkSQefzOcXq4iPbM9N2bLUAfDvudp
         QMJQ==
X-Gm-Message-State: AFqh2krmHx+iRsXf6kEoC3JCWGF/ZsJwmFrt3EjGeWmacNZ3fVuQPKVa
        Xh66tr9qT5SsD+6nnW8tn9SUyH2QWUQKNLZidpjVjw==
X-Google-Smtp-Source: AMrXdXs7gAgf42FKDCJFRrDo6We9zx/CBIN3LvglGtvy3VnkIDYcWFMb/mBbqvaR0o2rHVBOl7Lgw1BwcMrz543P2iw=
X-Received: by 2002:a67:ec91:0:b0:3d0:a896:51da with SMTP id
 h17-20020a67ec91000000b003d0a89651damr7123043vsp.44.1675164847883; Tue, 31
 Jan 2023 03:34:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675111415.git.andreyknvl@google.com> <5456286e2c9f3cd5abf25ad2e7e60dc997c71f66.1675111415.git.andreyknvl@google.com>
In-Reply-To: <5456286e2c9f3cd5abf25ad2e7e60dc997c71f66.1675111415.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 31 Jan 2023 12:33:31 +0100
Message-ID: <CAG_fn=XhboCY1qz6A=vw3OpOv=u6x=QBq-yS5MmA0RbkD7vVJQ@mail.gmail.com>
Subject: Re: [PATCH 09/18] lib/stackdepot: rename hash table constants and variables
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
> Give more meaningful names to hash table-related constants and variables:
>
> 1. Rename STACK_HASH_SCALE to STACK_TABLE_SCALE to point out that it is
>    related to scaling the hash table.

It's only used twice, and in short lines, maybe make it
STACK_HASH_TABLE_SCALE to point that out? :)

> 2. Rename STACK_HASH_ORDER_MIN/MAX to STACK_BUCKET_NUMBER_ORDER_MIN/MAX
>    to point out that it is related to the number of hash table buckets.

How about DEPOT_BUCKET_... or STACKDEPOT_BUCKET_...?
(just bikeshedding, I don't have any strong preference).

> 3. Rename stack_hash_order to stack_bucket_number_order for the same
>    reason as #2.
>
> No functional changes.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
