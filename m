Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C739636E1A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 00:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiKWXH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 18:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiKWXHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 18:07:12 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56E1171CBE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:07:06 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id p184so164903iof.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BU3XkYqFmHA9BvuBs9S7U9WfiZ7L9XnnHyZ9Ng5b+xM=;
        b=cfqaciRfou0A4j9IsMdzIUDusTNTfWzXUzILo3ggSb6LiFlrdqZdY2vVKQIkMM5N54
         uUQr9QcHish/MLN7QRizZZj7WD3SSjX8029tQnAN/k0GG8bdaakWH+RjV8jSIU5n3Bgn
         Gc7ZRo7aYDUAo9H3lcwJlCvtp4ZQN5dpf+9yrnu7wLeOR0atO4YpDPg9sh+mgTjPR2S8
         nCDh/EFvXVmQEBHAM2Lve9Xyy4Ei7RACZD0Ho+8Vch+0eBcON11WD/JQ9JvhsEh8YCdW
         oEYBY2eQc4rp6o6EqmaUTclfSl9FNVkEAl7NKVX+j855ZMjZZNk4qz38Xjgqy7+1S44J
         OqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BU3XkYqFmHA9BvuBs9S7U9WfiZ7L9XnnHyZ9Ng5b+xM=;
        b=OEtoBrYAO9UnQoUiBSqtAla+hOS6uRZzatUCfT76HEqEiSe26RPokjgQaN0C4jOM1T
         52w14d5t3CoME9O0Y0NdKXLpOY8ziPRCl7evAFwv5iiIu3/d66e1L9QLpiZb72EtSXsS
         DwuncxgD+H3vUEv4jeFGvg3uxy/Bh7vfBMFYsNRnqvPjn6hGl5x6SQF+cCW88S2RUUP2
         VOVREcWAa+53+DKKXQR7piPAx6B29GlHroGHgfli1TCYJ9f7r/p/oxqAzJ5b8rG4G2ua
         HeSNNjpNWWYWE1G5cZ0aS/Hjx94iOfKnHLP6JTnGf5LT0sxLw8xQvlbzf4meCAZ5n8PT
         ypKA==
X-Gm-Message-State: ANoB5pnB4jHdLL4icA8Z3o7qv0iPKxnndZS7YD1t0rfY8hljNxK+LzeV
        MgdKF0FozjIaTs50wtr2huNq1w1QslCd9e6qXk8iOQ==
X-Google-Smtp-Source: AA0mqf6i34UC7vmeMazgT7hRQb0NnKcz+pPUFK96DKKYWr4Apdsnv4TGw8y2UlI9oCYhUy8lKn6rrlBYDxha8rDtRaY=
X-Received: by 2002:a05:6638:89:b0:363:9e67:d9d9 with SMTP id
 v9-20020a056638008900b003639e67d9d9mr6182091jao.133.1669244825874; Wed, 23
 Nov 2022 15:07:05 -0800 (PST)
MIME-Version: 1.0
References: <20221124090815.7e550d88@canb.auug.org.au>
In-Reply-To: <20221124090815.7e550d88@canb.auug.org.au>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 24 Nov 2022 00:06:28 +0100
Message-ID: <CAG48ez31N1S6g1h8HT8Wxvt8a5m7Y1gJ6JKkVTB2z9G8AGbONA@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the mm tree
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
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

On Wed, Nov 23, 2022 at 11:08 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> In commit
>
>   d5d60d30f574 ("mmu_gather: Use macro arguments more carefully")
>
> Fixes tag
>
>   Fixes: a6d60245d6d9 ("asm-generic/tlb: Track which levels of the page table=
>
> has these problem(s):

I'm not sure what happened here - when I apply the mail that I sent
with "git am", the "Fixes" line is properly one line. But in the
version that landed in the tree, it looks as if the quoted-printable
encoding was not decoded for that one line?
