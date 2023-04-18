Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A7A6E6CFE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjDRTh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbjDRThq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:37:46 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AD686BB
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:37:41 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9514ac7c8cfso83715066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681846660; x=1684438660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TIq6vAFY5xQAOZN1W+Pq4tRvXHq6fi9pVX7PeCkN6Wk=;
        b=0CEF868SovxGaYwpm/cy7Ltt9CdFC/w7RScs1BOZ6LQHc7LFhqyOb4vw5MBVxl8tv7
         5LhIjU4+GgxrbmP/FxDYRMfG0NvNcvRPcb8BG+61alVWbI60GddckkE8v9uDKbsn9hpY
         4aOytK5RIW2ShR/OW/tXjaVqCgHHNCimjHSxeKEMTvzpUcXBcbKxu9bGKkorskbKbU2q
         5rCx05TIxNNE1BkiXDb1CxgIvK651P6NHXubiBdcN6q9lBzEJ7mGi545EsniC05klbxv
         Cf83ccMPUP6Li0mYvqBavS0ik0bTTN24ru9ztS1eADs2BMNwZmqyW+e7qSM+lYRq47AV
         lmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681846660; x=1684438660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TIq6vAFY5xQAOZN1W+Pq4tRvXHq6fi9pVX7PeCkN6Wk=;
        b=YlKxL9iU72j9lqEVfODJXOwMHdizrCAvrYBQlFRReEWoIHkLFrGEFQ0HCbGYVkKhCF
         Y0yQOobnsDeTK+9g23xdKL40z8LPogpCUYLg8FPJliRpvtJChe+NylbCgyFfPGw/54sn
         OKOgofAO/JbK0inhEFS4Ni25PU5V1Rrw/cMmNR08pGtFaIAEj9Xz93zY457fj0zNW41K
         3JgzFDLvh2eG7FzF5H3u6zsaLKjk77wJyg757KyboW8X4WyzaJxWxr+cJnnCVfrcdfWt
         nsLE6jA6K3xdQNdjIf9bzlR08FtlMC6CTn1jZYrJ/g/F8UW5l1u5XBTRmpd/e7y3MAjg
         0PKQ==
X-Gm-Message-State: AAQBX9dNQRbWc/NdMV9nRkHszv+f2IDONfvF2S3xqMIYs1tXsaGP4CWY
        zLmbmjY/B5piUpmKDpFnY+rMKJ8rC11NedKGwHUBng==
X-Google-Smtp-Source: AKy350bUKuS0bS1Py/eoGArYJH0JCvQn0z+4laL0JmWGTl2D78DPSG9yAnZkERk1HArxOzh4ExcXeOuJbQYbp7vTceI=
X-Received: by 2002:aa7:da44:0:b0:506:b8ca:e07e with SMTP id
 w4-20020aa7da44000000b00506b8cae07emr3357709eds.11.1681846659976; Tue, 18 Apr
 2023 12:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230417135420.1836741-1-senozhatsky@chromium.org>
 <20230417174131.44de959204814209ef73e53e@linux-foundation.org>
 <CAJD7tkZOmUnfi8mGtr3a-hbSZcHsR3cXqVO+Luo4w=8qh-i3_w@mail.gmail.com> <20230418112450.GT25053@google.com>
In-Reply-To: <20230418112450.GT25053@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 18 Apr 2023 12:37:03 -0700
Message-ID: <CAJD7tkbi81tCXvTqEHVums_xr4572fSmdPa7A7Fb5Y-0JWQK0w@mail.gmail.com>
Subject: Re: [PATCHv2] zsmalloc: allow only one active pool compaction context
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 4:24=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (23/04/17 19:53), Yosry Ahmed wrote:
> >
> > As for this patch, I personally do not observe a lot of compaction in
> > our production environment, and allowing one thread to perform
> > compaction while others move on with their lives can be better than
> > having all of them continuously contending for the pool->lock, which
> > means more contention with ~all zsmalloc operations, not just
> > concurrent compactors. I can't say for sure that this is an
> > improvement, but I *believe* it is.
>
> Looking at one of ChromeOS memory-pressure tests, I see that sometimes
> (albeit rarely) we can have up to 9 parallel zspool compaction contexts,
> perhaps a little bit too many for a 12 CPUs laptop:
>
> [ 2159.378827] zsmalloc: ctx #1 chrome -> zs_compact()
> [ 2159.379002] zsmalloc: ctx #2 Chrome_ChildIOT -> zs_compact()
> [ 2159.379120] zsmalloc: ctx #3 chrome -> zs_compact()
> [ 2159.379135] zsmalloc: ctx #4 chrome -> zs_compact()
> [ 2159.379213] zsmalloc: ctx #5 chrome -> zs_compact()
> [ 2159.379271] zsmalloc: ctx #6 chrome -> zs_compact()
> [ 2159.379276] zsmalloc: ctx #7 chrome -> zs_compact()
> [ 2159.382786] zsmalloc: ctx #8 chrome -> zs_compact()
> [ 2159.432153] zsmalloc: ctx #9 kswapd0 -> zs_compact()


I haven't looked into such pressure tests on our end, the information
I have is based on the amount of CPU cycles we are spending on
zsmalloc compaction in general.
