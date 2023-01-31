Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C80682AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjAaKng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjAaKnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:43:35 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B820F12F08
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 02:43:33 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id i188so15559120vsi.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 02:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M753LZjz9jIM5UZsN6i1l5g2fsIv/6aiQIsgYIsM+/c=;
        b=enJHYOBVZFEP+cfsiWZz1361EcSHN2tXhM0kwfSjnwjcvxZI8G63emelBbN9BxT7T6
         QYtzHs7d/BhL67M6Upn6azzWdc9GTKm3ME1BTDf0UpEhoEyQOwK8NJ3yrBIfDGM/Hx+E
         qzN99hE0qUIsi7euMl0j6eK7HlIOi5SUSVGJb78z+a4p7okqPCF8fkbHUTxo/5+5b5zv
         mEkWVbsKwgTdvnFQsoXQpxYyH4bDlN+lNsZl4d0OcA5GYS1s/dnJK870yuWAlYjno8d9
         +/rIhv/Qk9+CpzdOrkC+MqcpvZmevXFd//udWGPSFbystpA7YtZ0zUI18HrYO8vHjNNA
         0J6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M753LZjz9jIM5UZsN6i1l5g2fsIv/6aiQIsgYIsM+/c=;
        b=y2HO3ooUgFmrFUJzCO4qe3F51zUgKg1nqa/7DNbY1H57Hp4hOySsGKdOKe9O7UP1XK
         npv4qtVDB+f1p4zDDjPLBj7Qp5t+3cpow2f4N3tnDUP6zgC+dk6INYRRMBFdMMWXsQ2h
         eZN0RCu5seRL+gpgsBbe+cEuKMUEuQAw4BQHZEvlhgc0smZKQ/BTiWsE+tG5d77uh9Fo
         /GNh/y76YuHI8ecVfeLBKNrdvY6vCh8dsqFVpasl8D3/DK7OS9UUQKj/D0WGPI7Ppa2x
         3sGPY/TWdQC5enxcjFi5T61QpZ2gHcNN84WxwPuSCDSOeOuc68ad45up0/DWbzHKC5dN
         tTcQ==
X-Gm-Message-State: AO0yUKVBHV6UEA9BHr0pLQqB3Jph7PXDdirleWaO/sSBjvTN5Fi58jzG
        l+vIHURSLqUtNpFXdaIqxNsvCQ1EojT3ovY5mKhsqQ==
X-Google-Smtp-Source: AK7set/UCy97NS1OgWQ3E+UC3FDdA9Pde6pSsrUhHtJ36o7k6yVvsdQHeHE1uwGPFI29ub2qTqgNXtmMUSlSs1QBEeg=
X-Received: by 2002:a05:6102:449:b0:3fc:3a9e:3203 with SMTP id
 e9-20020a056102044900b003fc3a9e3203mr634380vsq.84.1675161812760; Tue, 31 Jan
 2023 02:43:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675111415.git.andreyknvl@google.com> <4ed1d0828e837e15566a7cfa7688a47006e3f4b3.1675111415.git.andreyknvl@google.com>
In-Reply-To: <4ed1d0828e837e15566a7cfa7688a47006e3f4b3.1675111415.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 31 Jan 2023 11:42:56 +0100
Message-ID: <CAG_fn=V=91XNUyaWuwrgDqNKhHcEQFmD7Q4opc_v4vos+GR3qQ@mail.gmail.com>
Subject: Re: [PATCH 08/18] lib/stackdepot: reorder and annotate global variables
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
> Group stack depot global variables by their purpose:
>
> 1. Hash table-related variables,
> 2. Slab-related variables,
>
> and add comments.
>
> Also clean up comments for hash table-related constants.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

...
> +/* Lock that protects the variables above. */
> +static DEFINE_RAW_SPINLOCK(depot_lock);
> +/* Whether the next slab is initialized. */
> +static int next_slab_inited;
Might be worth clarifying what happens if there's no next slab (see my
comment to patch 01).
