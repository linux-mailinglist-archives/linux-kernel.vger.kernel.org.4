Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB1E6942EF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjBMKen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjBMKef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:34:35 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAA5E04D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:34:34 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id f10so4978200ilc.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EG8YreyKgfIxXVMHClXkHdhKvtNnPhGwPY2bkC9invg=;
        b=CVEWvj2k8JvxaHl1S+kA+rwpNzO77o9NanuFxhQRg5JsOGCGdJyoYYrg9HWG7Ff0Wj
         JXbD36s17fZZ6NFBfkAnmaRyOdwnupxBNMxOmLRdxG3TVSAANyoytZntkkAidsubhNSM
         XZ60lFd1ePXdrVjx5pUMStj1CZ6wlSBpAdnU2F5GrJgr7mBQ9oTe9x4O4ZG5pAMFpQRy
         YmW+kqC6xhfddlDpxgAn7TolBaF25yUusUOmOaLMvalIYgFwv9689vWR81kKYkIbPjU2
         g7WfRnn7r7hiZiADMVVBvCMa8FPIiYyIF4I/GAOMWLiG17eSWeJrTXjNkzi50P3jaXTx
         Gchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EG8YreyKgfIxXVMHClXkHdhKvtNnPhGwPY2bkC9invg=;
        b=3A6bHOvHj2hIl0eoVE2XoZMQRbo4r4QJ2Gi0TcyVD6oFJjCG/JUcwUhvWeTcF7cUvQ
         MgIIH7BZPR7sma4hL4YD+rHCPq1r22+hBxu1oI6CKp8nPmY0CIJJ3ogjBiNnL6cPvG2Z
         s/7EDwgLHdf7oz9Mo2rYgWVWYo0LrlhBq7NuW4nDGs9AXSqkIbD4Cd0ujNNh06H3XL4n
         u9Q/dcbRHWPONZStffdg8iyfL5rJAv68ir7ELwNnbbTMDe6lraFX6aXBEZbB58DTKjMA
         av4WW2/euMVh5hhvmwIVkkw025wp0Ktceaz6I1RRCv95URN5SX11Oyzn1R5CAzs+7TT9
         DBNg==
X-Gm-Message-State: AO0yUKWWb+96w8rxJ2eZfaZNl3s2C4xjtyuXL8STPgcWt7TmMhnPyIKG
        QkuTy/XQ9AzxwEMYnKKJ9I1PUJ3Ztr3sOvk450W0iihOViowaADB
X-Google-Smtp-Source: AK7set+3wiiSYJlkXmBLkwKvyyyOqgxUa8RDEY6Ya9A0AkHSFzeFDbinBE+20xYdI7cuzpHEKP0D0yTJNdBRzIk1DnM=
X-Received: by 2002:a05:6e02:1007:b0:313:d1b5:82cf with SMTP id
 n7-20020a056e02100700b00313d1b582cfmr2475453ilj.5.1676284473265; Mon, 13 Feb
 2023 02:34:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1676063693.git.andreyknvl@google.com> <5606a6c70659065a25bee59cd10e57fc60bb4110.1676063693.git.andreyknvl@google.com>
In-Reply-To: <5606a6c70659065a25bee59cd10e57fc60bb4110.1676063693.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 13 Feb 2023 11:33:52 +0100
Message-ID: <CAG_fn=VMiZJaFRNiG5wdYP=rfJiJXuKYWcx5mFEmD+nEOrvTMw@mail.gmail.com>
Subject: Re: [PATCH v2 07/18] lib/stackdepot: reorder and annotate global variables
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
