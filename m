Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB1E65C814
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 21:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238490AbjACU2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 15:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238803AbjACU1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 15:27:48 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBD31570B
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 12:27:46 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id m26-20020a05600c3b1a00b003d9811fcaafso18001059wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 12:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GuHkx7fc138lNmvQjU9upPIl/BMWMyWGCqBn8wneQOc=;
        b=fQ6TpWiJJnlFKvQY8aTqmU7s8oqlCyoa5Ps9Bh1txjnXZBw9B7WXaQiCZp6pORL3RE
         8ly3BNRQCKZyAIqO3fabvg3lXe6NNM1FcPURPyO///aYBT8ddQtYow1o2jl8dHyP3aoR
         HqYZadeCNtsQOxHR8D52lcOtfYhr1XIcPr7cHsXsxvrnXBWIFA72Ef5dXIT1gbb7aQhG
         gJ291AQDVyk6R0LC8Z3qFdJQH26vvOTd1iRdTYGpfSm3x9bJ30f5ZypVgxfldPTWi45w
         Wgpry8Bq7346Pe5TN4M+puAcjZ9gPj1FLLmtEj7TltxoLcmYm+G16QkRRqPB5DGqBKYC
         xZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GuHkx7fc138lNmvQjU9upPIl/BMWMyWGCqBn8wneQOc=;
        b=6iDdhFjQ69VfELZsbSKDxlhjMqxE2OnW2tSVe92ehngbL1ZfUmKlv/PFughLeodZjz
         QNq88ViZz01OJqGXI6jNkBS0ngsmuvRNddz9j+7jjOMS5QPMSns7sbQzTAM5IS/La1ss
         UaumpwN+xWcPWJ+161lzi47mDkYgLgNhOT5NPZ3jyZ8y3xD5kTXFplds8MMitHiuAXpb
         8SnWfe9XrhJt3Tkx1abP/IM9Hb281oXqD9rSHyShKV53dlwkexYdgYeT7D/SzRXviqbw
         0U/Jeu39lJr9ZcCcLg8F1rP6EitKDpjC1hbz19GropBSvmlCVLLdchPQMqdliVG7XVB4
         8Lrw==
X-Gm-Message-State: AFqh2kqX+SnakFP5fQNTX4KybOUdqUtSkg+g79DhTWUSYLvrPAebjL3g
        0p6zXJXzhq+JdTzby0HJ3CtJn42o7Veyy/qh+dASi1Iwyncy4w==
X-Google-Smtp-Source: AMrXdXvcWUG0wBnNk1rBVYMnFutMM+IMqrjAP1t6Ml8Seqi8JLHLpbNSCXtkQ+A1zAvrQdLUQe/3zUU2p7+zM6oHbv0=
X-Received: by 2002:a05:600c:4f56:b0:3d9:7950:dc5f with SMTP id
 m22-20020a05600c4f5600b003d97950dc5fmr1401933wmq.120.1672777665450; Tue, 03
 Jan 2023 12:27:45 -0800 (PST)
MIME-Version: 1.0
References: <20230101230042.244286-1-jthoughton@google.com>
 <Y7SA839SDcpf+Ll0@monkey> <CADrL8HVeOkj0QH5VZZbRzybNE8CG-tEGFshnA+bG9nMgcWtBSg@mail.gmail.com>
In-Reply-To: <CADrL8HVeOkj0QH5VZZbRzybNE8CG-tEGFshnA+bG9nMgcWtBSg@mail.gmail.com>
From:   James Houghton <jthoughton@google.com>
Date:   Tue, 3 Jan 2023 20:27:34 +0000
Message-ID: <CADrL8HXp3Ta9Cf=6yrmhT=WiEtPTeNrkyOdpoM-MLkNejTRWnA@mail.gmail.com>
Subject: Re: [PATCH] hugetlb: unshare some PMDs when splitting VMAs
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

> I think I've come up with one... :) It only took many many hours of
> staring at code to come up with:
>
> 1. Fault in PUD_SIZE-aligned hugetlb mapping
> 2. fork() (to actually share the PMDs)

Erm, I mean: mmap(), then fork(), then fault in both processes.
