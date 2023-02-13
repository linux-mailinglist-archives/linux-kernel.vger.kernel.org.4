Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD3C6942FB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjBMKfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjBMKfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:35:34 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF57212860
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:35:10 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id z5so1597739iow.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rg9iAwFg7IOMEVpt1NVV6rIqsGDrzeIrKjlgE6x+x4o=;
        b=q+UOAYFClqtFajfl3PJDBMhfQHHVUWm2EdZfa0l8S60abdy6vsCoDt/EuOnoJ+tz3W
         t68NgeaUoHkuPhrW9gUqPoAm7w1DHXviGFOnmfvCIMD5WXdBstyQclltReStd1qa++Ov
         MiIYreizFvHngeQCxqaASlKXrVAmPqgV1q8uN+KhzbhFMOcarTNm9mBWxKl5UbOyTEKQ
         qrIebhWB9Fc8MCJU+ANSZ5NlDJs2x5e20fizkMQFixGwE45JnEDOH+P7rv3vWN198u6s
         BLROXrgaR3jDcFGPMUYm9mj9cgYXQgZOp0Q62iSJlNOZOHNgX0AsXAYXpcLNsqiNzziK
         eZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rg9iAwFg7IOMEVpt1NVV6rIqsGDrzeIrKjlgE6x+x4o=;
        b=FCg2BBem6Ca5NGlx9sm1INzirA8wbt7lb8oqzQ+i+76YsSvzokKPfTZ7yPjMgSAY24
         CRFEmKFMeNirE6ZlUwX86E7hev1b7RK0q8WstyNKxk191ISBOcaux9sf/WhusIoSkVl1
         Yby9Pl7Sm/tK/K0f2rGsrjkGZ677ytOMu0mYuJOQ7OcCk2wJxLt2MhpCTVs3fDYJs8R3
         SePMxZSf/789lcVBIv28tr9WIC0ylLpNeZATpeJ3B2EsqUxsJiPQFXK+Z/uHAVLn9L4N
         mz9MJKVtupDWel5n4F39w/urUK+XPnNQzCo9UXZpRC5yKy9UCBRXCJmnl1QcgsoYyVtx
         VZ8Q==
X-Gm-Message-State: AO0yUKUNDcUIsD/HoHk8cTmWHo/9mjnzL6t8zpv8L8T6ArvGNOSdgLnZ
        LTHahOQXxXulDr3LboSJhehkfdDOn3tD/74yPFP8WA==
X-Google-Smtp-Source: AK7set9nUuh5E8gAYl8p0P/dG5mkhLqkGD0gKRsR5eXUx8exoJEwox3s1PbVBolGecOWwQFPfBvex+UpQNPq/axhsS8=
X-Received: by 2002:a05:6602:3155:b0:732:9e46:de04 with SMTP id
 m21-20020a056602315500b007329e46de04mr11808742ioy.65.1676284509903; Mon, 13
 Feb 2023 02:35:09 -0800 (PST)
MIME-Version: 1.0
References: <cover.1676063693.git.andreyknvl@google.com> <f166dd6f3cb2378aea78600714393dd568c33ee9.1676063693.git.andreyknvl@google.com>
In-Reply-To: <f166dd6f3cb2378aea78600714393dd568c33ee9.1676063693.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 13 Feb 2023 11:34:29 +0100
Message-ID: <CAG_fn=XsJAZK1bPP7KXtTOk_cZhxc6TwWZksB8w77Dfhpy4hQQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/18] lib/stackdepot: rename hash table constants and variables
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

On Fri, Feb 10, 2023 at 10:17 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Give more meaningful names to hash table-related constants and variables:
>
> 1. Rename STACK_HASH_SCALE to STACK_HASH_TABLE_SCALE to point out that it
>    is related to scaling the hash table.
>
> 2. Rename STACK_HASH_ORDER_MIN/MAX to STACK_BUCKET_NUMBER_ORDER_MIN/MAX
>    to point out that it is related to the number of hash table buckets.
>
> 3. Rename stack_hash_order to stack_bucket_number_order for the same
>    reason as #2.
>
> No functional changes.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
