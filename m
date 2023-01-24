Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB61E679AB9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 14:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234726AbjAXN4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 08:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbjAXN4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:56:32 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597C047416
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 05:55:50 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id a9so6945142ilb.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 05:55:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C6DU+ytc1NqENDkZNmeISMtYPcZVMd3z1m1alcPvP8E=;
        b=3zUn0X1NnYVX9K06T/PhOs1uQDwYHcxEjNVSidPbBKwMza0tNvn/OUZmEBkPK6MJMz
         kH+o+M30bPvpkST1sCEMdGpI495nppPCUxqmWB2C/4aVsp2fCRxeLERU7lMcCOTdFkR/
         Mp51fQsEN1qalwyYqNuBGviAcI+yPJcPQHnXe0XJrdOQt7DLW8rZQwMGPNTEllqz1Nnj
         ZTotOw2hi4tc790W/tZiqmFdxZ/WbHEEs2FIANgYknXmKA5pjTZpiuQsjJ+wkWD7VMd+
         zgkhmgR8d0h1K+Ztnr/QlDLBuXDw2wDc5+Sp/7CSanSeSkT9Kk4zo/6yp/uuKCakXQ7L
         zi0w==
X-Gm-Message-State: AFqh2kqPnsdXfsZ/8zCxvsT8idcMBtR+XzrLpEKW9/RbpbIjBAorjaZb
        DKhnMbWTCQQadGXif8jYlP471hQGu/N+PQ==
X-Google-Smtp-Source: AMrXdXs8fh5A4N7yK12sW16RXFH+u9o39QjwUn8rJX+e/LVtdDAcRMPT9UOFzHk6G7aoQI6OFLGAkQ==
X-Received: by 2002:ac8:7205:0:b0:3b0:9e27:ddb2 with SMTP id a5-20020ac87205000000b003b09e27ddb2mr40651838qtp.3.1674567862697;
        Tue, 24 Jan 2023 05:44:22 -0800 (PST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id a20-20020aed2794000000b003b63b20314esm1274171qtd.57.2023.01.24.05.44.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 05:44:22 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id 129so14826903ybb.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 05:44:21 -0800 (PST)
X-Received: by 2002:a25:d88c:0:b0:77a:b5f3:d0ac with SMTP id
 p134-20020a25d88c000000b0077ab5f3d0acmr2648671ybg.202.1674567861745; Tue, 24
 Jan 2023 05:44:21 -0800 (PST)
MIME-Version: 1.0
References: <20230120121856.1407369-1-sudeep.holla@arm.com>
In-Reply-To: <20230120121856.1407369-1-sudeep.holla@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 24 Jan 2023 14:44:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUZzLkWvhQ=YeH2KfQ_FRidemfOvbbHf_b1AHROK9HFNA@mail.gmail.com>
Message-ID: <CAMuHMdUZzLkWvhQ=YeH2KfQ_FRidemfOvbbHf_b1AHROK9HFNA@mail.gmail.com>
Subject: Re: [GIT PULL] cacheinfo/arch_topology: Updates for v6.3
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong-Xuan Wang <yongxuan.wang@sifive.com>,
        ALKML <linux-arm-kernel@lists.infradead.org>,
        linux-riscv@lists.infradead.org,
        Pierre Gondois <pierre.gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On Fri, Jan 20, 2023 at 1:22 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> It has been tested on RISC-V which is the main users outside of arm64.

Has it?

> The ACPI the RISC-V parts are acked-by the respective maintainers. All
> the changes are in the -next for sometime and no issues reported at this
> time.
>
> Regards,
> Sudeep
>
> -->8
>
> The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:
>
>   Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/archtopo-cacheinfo-updates-6.3
>
> for you to fetch changes up to 198102c9103fc78d8478495971947af77edb05c1:
>
>   cacheinfo: Fix shared_cpu_map to handle shared caches at different levels (2023-01-18 09:58:40 +0000)
>
> ----------------------------------------------------------------
> cacheinfo and arch_topology updates for v6.3
>
> The main change is to build the cache topology information for all
> the CPUs from the primary CPU. Currently the cacheinfo for secondary CPUs
> is created during the early boot on the respective CPU itself. Preemption
> and interrupts are disabled at this stage. On PREEMPT_RT kernels, allocating
> memory and even parsing the PPTT table for ACPI based systems triggers a:
>   'BUG: sleeping function called from invalid context'
>
> To prevent this bug, the cacheinfo is now allocated from the primary CPU
> when preemption and interrupts are enabled and before booting secondary
> CPUs. The cache levels/leaves are computed from DT/ACPI PPTT information
> only, without relying on any architecture specific mechanism if done so
> early.
>
> The other minor change included here is to handle shared caches at
> different levels when not all the CPUs on the system have the same
> cache hierarchy.

While this gets rid of the "cacheinfo: Unable to detect cache hierarchy
for CPU N" warnings printed during boot, it resurrects the printing of

    Early cacheinfo failed, ret = -12

during early boot on all my RV64 platforms

See also https://lore.kernel.org/all/CAMuHMdUBZ791fxCPkKQ6HCwLE4GJB2S35QC=SQ+X8w5Q4C_70g@mail.gmail.com/
for a similar earlier version triggering the same issue.

> ----------------------------------------------------------------
> Pierre Gondois (6):
>       arch_topology: Build cacheinfo from primary CPU

Reverting commit 5944ce092b97caed ("arch_topology: Build cacheinfo
from primary CPU") fixes the issue.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
