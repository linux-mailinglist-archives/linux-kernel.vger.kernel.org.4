Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C0B64696D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 07:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiLHGsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 01:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLHGsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 01:48:01 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988034E6BD
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 22:47:59 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id 3so630583vsq.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 22:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6zot3OkNfEi53FjSEQfVGLRXMlumoZNtuw1dHZJdR6E=;
        b=sIqeo013QK9tdm4gyEtGnJT+xWdGfO8Oy8KreARweo8mamVlJSXzkp5xNgQS37QNOd
         UsH4IhA27HkidPcRmU3d62eS6VbCm4pczntZKKVLOxHAie/DMhFCLfcTCooHoDog/jJl
         WDMktjYg637M7IoGLSgiH8XiCdV4+AGdAhOvLQCOtKtJs+BZrJ+qgg+NcUbJs9SGkbTf
         0v19XcBsyEjyjdE64JB2QLNp59zJdJlGr20k2YbOCDPDaytqgsb7ZyI+0yEx03ubIBPd
         gTT6njtRYP+1WqkT8xnoI1L2Z6BqsZa4yZdVWSkrhu6xRKkYmcBojAj8qV6qd6iSvEZn
         NTbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6zot3OkNfEi53FjSEQfVGLRXMlumoZNtuw1dHZJdR6E=;
        b=km3YrrPmCIgpV2mqzYjGCL/FNVqHsdiljaNhN5HSkuNxm+JG+GqXpyOf+dTDMmFcvL
         rIH7d7EAd8ryzdvhXzAXq1pmPrWtMyjNv3RBPI9fIsyoDWsunG75eo+faip9xlOjcv+u
         ZkjiT17Or9sij2gUlbtEGoQ21MXhtDFnmm4LmhESGRyGTXtPPl49YlriWqxU4FUCCK4T
         AixQigLs31cBPgFMkRfaqAwB5Y8cqwKK6W5TS9YT0bgEsQ77l1vFXk03dNvpBkCGUsJP
         IEMTMzsBeJPUMwFPiKCHk67J2hx9x/MWSQS+5pPSwDPTTP3Dza1RnrH2vesyyVnvijHP
         z1Iw==
X-Gm-Message-State: ANoB5plaNzfPkrWzU002YdAOGOT02pKRkxL8CxUU8qBPmh+60Scn9Ax8
        mQ+AWnO8t0u7tru8zMlCsyY77LLn0lVhyyyqQdPDJg==
X-Google-Smtp-Source: AA0mqf7r91LOGOSAN4d8KUitvecDMLr6IV7vf63dj5UU9tGs106oNuIRgGAxoWYre/1ey4Dpt07hl+bwrSh4R5O2b6A=
X-Received: by 2002:a05:6102:2758:b0:3b1:1962:24f9 with SMTP id
 p24-20020a056102275800b003b1196224f9mr12966949vsu.72.1670482078566; Wed, 07
 Dec 2022 22:47:58 -0800 (PST)
MIME-Version: 1.0
References: <20221208053649.540891-1-almasrymina@google.com>
In-Reply-To: <20221208053649.540891-1-almasrymina@google.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 7 Dec 2022 22:47:47 -0800
Message-ID: <CAHS8izNiM=ckfN1Bvpz5ARSv5OTFi6WLAA-Q9Gnzavp6p4zM_w@mail.gmail.com>
Subject: Re: [PATCH v1] arch: Enable function alignment for arm64
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Wed, Dec 7, 2022 at 9:36 PM Mina Almasry <almasrymina@google.com> wrote:
>
> We recently ran into a double-digit percentage hackbench regression
> when backporting commit 12df140f0bdf ("mm,hugetlb: take hugetlb_lock
> before decrementing h->resv_huge_pages") to an older kernel. This was
> surprising since hackbench does use hugetlb pages at all and the
> modified code is not invoked. After some debugging we found that the
> regression can be fixed by back-porting commit d49a0626216b ("arch:
> Introduce CONFIG_FUNCTION_ALIGNMENT") and enabling function alignment
> for arm64. I suggest enabling it by default for arm64 if possible.
>
> Tested by examing function alignment on a compiled object file
> before/after:
>
> After this patch:
>
> $ ~/is-aligned.sh mm/hugetlb.o 16
> file=mm/hugetlb.o, alignment=16
> total number of functions: 146
> total number of unaligned: 0
>
> Before this patch:
>
> $ ~/is-aligned.sh mm/hugetlb.o 16
> file=mm/hugetlb.o, alignment=16
> total number of functions: 146
> total number of unaligned: 94
>
> Cc: Peter Zijlstra <peterz@infradead.org>

I missed the Signed-off-by: Mina Almasry <almasrymina@google.com> tag
here. I can add with the next version.

> ---
>  arch/arm64/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index cf6d1cd8b6dc..bcc9e1578937 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -235,6 +235,7 @@ config ARM64
>         select TRACE_IRQFLAGS_SUPPORT
>         select TRACE_IRQFLAGS_NMI_SUPPORT
>         select HAVE_SOFTIRQ_ON_OWN_STACK
> +       select FUNCTION_ALIGNMENT_16B
>         help
>           ARM 64-bit (AArch64) Linux support.
>
> --
> 2.39.0.rc0.267.gcb52ba06e7-goog
