Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68018694462
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjBML04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjBML0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:26:53 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3B72D5E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:26:52 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id j17so4330078ioa.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AMZ+dV1nC8MEbsqkMnbGLqJoVdn1vA5Cn4dTYfSbU0w=;
        b=VptsRcKp7YGcyynq1dr4wTNyQ7lCtzL2KOtVfQkXsoFea9+hzXJh3tRWkM/nTRvPn3
         9nGJcEEXGKs6t4JC1qxCOArfYqI0KMQZ2O1XNBe1xv7T6/Kk1EV9GSAz7QcGRGRXkIV8
         8U9sqsY+0uQhHZuuZ2CQmFw7I9uxjIGZrjWdYqPPwbbja1b8+6Dl68mgCSY+DqZp0FnF
         xXB8vFhOvmW9z668O+0CgxwF625fZUq4ouHw5hD4aZBNmDT35zMELg3TrHj1MCz4NTZx
         Q1vV692bdLOMr7CmsEXmzgrMM1+Zu0+ZX3E+rBdRdbO3FpgakaJWxR9XJ8XYSvmWoK1Z
         C/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AMZ+dV1nC8MEbsqkMnbGLqJoVdn1vA5Cn4dTYfSbU0w=;
        b=RUGxFjsN35ME2svLQ8D3LreuTtBwm6gzOdatnErTijcM+y/9nUeNL6YZmY74aXAXsY
         RQdFdstEbZQviVJzNqJfd30biJx5uVejcLPsBdQP/Rj0mG6d2T43H2TTrTdN1J6YYkMk
         XPU/lAoFoU1EcVe4INcmvJVeXvv6ILxWoJS7ZQmYtIuIn6EHiws/7AMoBh+Xr/PQtJf5
         qbaSk/NXf1m8qKD66Tbnpyv6WmyvqAIuDPNXUBSRJ90TDktUTwMZPfT7mpVda7aFiRHS
         AdAUBaXzvlm+x+wi+sdVUSzSJOAdD9AQxCEwFggo8h5QHFNNBbAGlT7Lsl/5QPq4exc8
         c55A==
X-Gm-Message-State: AO0yUKWPHapbiC0ged+XTiitpPtYasQc4vyHpn6ePstYgxK3B+IJk6YG
        ozBiNgxC5+kdtHjiU3uVEPANMOP/Iymy1yv+NF36Gw==
X-Google-Smtp-Source: AK7set8zW9LvRliK051KK5j6srceN0dT5sB7oJKViCxiJBQFHh70oldULOIIUHbsspwfnwBThg0SXTm9jwqXex580X8=
X-Received: by 2002:a05:6602:3155:b0:732:9e46:de04 with SMTP id
 m21-20020a056602315500b007329e46de04mr11828525ioy.65.1676287611687; Mon, 13
 Feb 2023 03:26:51 -0800 (PST)
MIME-Version: 1.0
References: <cover.1676063693.git.andreyknvl@google.com> <484fd2695dff7a9bdc437a32f8a6ee228535aa02.1676063693.git.andreyknvl@google.com>
In-Reply-To: <484fd2695dff7a9bdc437a32f8a6ee228535aa02.1676063693.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 13 Feb 2023 12:26:11 +0100
Message-ID: <CAG_fn=VzvKnvqqPChYFi3mzbe4u2dfYz5mT=nJ-TSkKiLqB17g@mail.gmail.com>
Subject: Re: [PATCH v2 14/18] lib/stackdepot: rename next_pool_inited to next_pool_required
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
> Stack depot uses next_pool_inited to mark that either the next pool is
> initialized or the limit on the number of pools is reached. However,
> the flag name only reflects the former part of its purpose, which is
> confusing.
>
> Rename next_pool_inited to next_pool_required and invert its value.
>
> Also annotate usages of next_pool_required with comments.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
