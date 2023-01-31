Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0F9682A7B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjAaK2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjAaK2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:28:40 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6619C3929B
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 02:28:39 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id h9so997366uag.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 02:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a6g8bNkySwa49lfZtMhX0bn0GNfblJVVbDTJj9FWuJw=;
        b=hJF5vaV+oa+2XOIHPbi9yGGm4JPUxaZ5xQGNygYMpar6HRmrNjopq9y7sBCZV3lw5+
         L6dFABwbPpTYSkKu8tDclscWJ1E59NMn+rTgu4pXkFhS1fFi+hp8mlxKG8NIi+DoE5hW
         RxEP//Q4oSSDi1t5GINca7F3R36NS8fBxQF42QHWXn/nbtTZD1ZkTOX32+hirRyg0bvf
         bzvei0AnXdXB605ldqC4nQRTYO/72Yacp5VrRpvvs8jkpEH9KWNS66GD8ln4IppUcJg1
         E5ogCozY8SisRn+fDTtP/nIP4aXgvt+95D0PqHKZapsw86BhZLZ5U982waFC45ezydY0
         uf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a6g8bNkySwa49lfZtMhX0bn0GNfblJVVbDTJj9FWuJw=;
        b=GVsyrbqNANNFgY4o1+byLcCTHtcfoDVtfX440Ocx+O2ayEcs121HX44fAsY6tlXbaR
         D6P36g59phljTpa+QIw4Meww5F9iLmQfOTDUsfxxmRR8BJntZLq/4eqZcn7iEVOC/zQO
         2nSm9peyU211B3vzJt8jCNfPg7JIMk3JpqjgdDN6+QemL6i/uXkC2ira0YtvCA9aUEdc
         0NDIXz3nLvnXx9wzx7A1cJ+PStaHKwB0bxR66Cq1vLjqUkcu9ZOBe8/uOHg1K9COR0op
         R87FujVySQ2Acd6sRhRUUOMl+MDWuPCnE6fEwPVjxQwQK519HuAqnXQREbOFL3+svk5w
         tMxw==
X-Gm-Message-State: AO0yUKWhfR0YGPfnQhsKpet38ZISdVWhQXqM/eajUVS+bsWLS95fy1A3
        N1aViQqs5sJoWG/LrXxhrJlJn7dn8bhU7Oh5uvHsLA==
X-Google-Smtp-Source: AK7set+ct9z/1Lzg7mpjtAKjfuw5FSBRQWuPSTRH3eNE7Pl+sNhvB4pFbroK4L0ro4leMaid5sS6wWx8YNCLj/aLk+Y=
X-Received: by 2002:a05:6130:83:b0:655:5dfb:9d10 with SMTP id
 x3-20020a056130008300b006555dfb9d10mr3561535uaf.63.1675160918398; Tue, 31 Jan
 2023 02:28:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675111415.git.andreyknvl@google.com> <293567627b0d59f1ae5a27ac9537c027a5ff729d.1675111415.git.andreyknvl@google.com>
In-Reply-To: <293567627b0d59f1ae5a27ac9537c027a5ff729d.1675111415.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 31 Jan 2023 11:28:02 +0100
Message-ID: <CAG_fn=Vs5SEdCRDEKQGd=ijMas_dgH=VMeoLs9zq8PBmjY9rGA@mail.gmail.com>
Subject: Re: [PATCH 05/18] lib/stackdepot: rename stack_depot_disable
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

On Mon, Jan 30, 2023 at 9:49 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Rename stack_depot_disable to stack_depot_disabled to make its name look
> similar to the names of other stack depot flags.
>
> Also put stack_depot_disabled's definition together with the other flags.
>
> Also rename is_stack_depot_disabled to disable_stack_depot: this name
> looks more conventional for a function that processes a boot parameter.
>
> No functional changes.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
