Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48E55B5552
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 09:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiILH0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 03:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiILH0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 03:26:05 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E69413E34
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 00:26:04 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id s6so2164133lfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 00:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=S7qsMOJyMlwVuf8eNuNOSDhJ270g0hn497r6PO6XbXw=;
        b=Krnw8ElDk+wm306zYuf/qgqXG4VO9Aq8d+XWE2tq44Qx8y/W7EMY2m2//i7kIbEaU9
         nINjTyDNCFXLJOoBWwNwv1eCp7RzFaprzqaPyWvfFXIaze7+qNWSUdJV5w7HhgYEcdQa
         Mwket2fkauYFMfkZGaS4LHLkZg+X4l2dHIY7v6WdPkYV08d5Wa/WElHflGvNGPIDE6eP
         Y/RssHUwKL9D9PVWSJxVbIYlHldJ8LVfo0m1eRl2AhtrjUV57xOfGcWB/IYJYHXA1tPD
         quLvQbMVye2moBnXy9FWMGQTleum59k8x9Rn6V5Y8dzTMZgF6MfDgnqPuNchpHLTBTtB
         00jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=S7qsMOJyMlwVuf8eNuNOSDhJ270g0hn497r6PO6XbXw=;
        b=muJg+mUTRPXw9fQoWN9doJztSfWxuZ2Gbd8ySjN+DbS8ONCuHPNVERU7gTmPnpplrP
         jZQUwe2T0mM5aLjvJPWwUGdK5QKWVKtktBO5UcFPoU0P35FtKTLOC6Z0IjGRvozEn2Pc
         33H79csn3mCAGtabb/Isleezl6VIlNfWhrHTthS/9Fe3/3M3zmJEmXqUnrPaKXAJtkr3
         T+4Moi//ouiAKRF4Z5w971EVPoJTnvmTdRjmPBTGJS9AkSjW6WwKOELtSVD0L3rs0vGO
         Kd7vuPT0tYz9UZ4ts8WgzHHCtZHE17haidYT4oOFenQxOp18WEEQoNCPsHB2uq9uXn0N
         nd2w==
X-Gm-Message-State: ACgBeo1FqNUWrRLzEM03LK2Ycn4F8dT7/8Gor40gk/4dij+DRAn7XY4z
        Y+5VSuNP6tWjamxPfeItu4o=
X-Google-Smtp-Source: AA6agR5F5pOWPsyydsoOnGUkI7IVqKKI0+x0s+O/0hyuEBgA03Rryq1NyCLoDy0+w7swkWktbMuodg==
X-Received: by 2002:a19:441a:0:b0:498:2943:a34 with SMTP id r26-20020a19441a000000b0049829430a34mr7502148lfa.238.1662967562276;
        Mon, 12 Sep 2022 00:26:02 -0700 (PDT)
Received: from curiosity ([5.188.167.245])
        by smtp.gmail.com with ESMTPSA id d29-20020ac25edd000000b0048a83336343sm897065lfq.252.2022.09.12.00.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 00:26:01 -0700 (PDT)
Date:   Mon, 12 Sep 2022 10:26:00 +0300
From:   Sergey Matyukevich <geomatsi@gmail.com>
To:     Jinyu Tang <tjytimi@163.com>
Cc:     anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, alexandre.ghiti@canonical.com,
        guoren@kernel.org, heiko@sntech.de, akpm@linux-foundation.org,
        panqinglin2020@iscas.ac.cn, tongtiangen@huawei.com,
        sunnanyong@huawei.com, anshuman.khandual@arm.com,
        atishp@rivosinc.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, falcon@tinylab.org
Subject: Re: [PATCH v2] riscv: make update_mmu_cache to support asid
Message-ID: <Yx7fCL3rMgT4Uh96@curiosity>
References: <20220904133710.117263-1-tjytimi@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220904133710.117263-1-tjytimi@163.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jinyu,

> The `update_mmu_cache` function in riscv flush tlb cache without asid
> information now, which will flush tlbs in other tasks' address space
> even if processor supports asid. So add a new function
> `flush_tlb_local_one_page` to flush local one page whether processor
> supports asid or not,for cases that need to flush local one page like
> function `update_mmu_cache`.
> 
> Signed-off-by: Jinyu Tang <tjytimi@163.com>
> ---
> RFC V1 -> V2 : 
> 1.Rebased on PATCH9 of IPI imporvement series as Anup Patel
> suggestion. 
> 2.Make commit log more clear.
> 
>  arch/riscv/include/asm/pgtable.h  |  2 +-
>  arch/riscv/include/asm/tlbflush.h |  2 ++
>  arch/riscv/mm/tlbflush.c          | 11 +++++++++++
>  3 files changed, 14 insertions(+), 1 deletion(-)

Just FYI: I have been looking into the same function w.r.t. to its
ASID/SMP handling. In addition to what your patch is doing with ASID,
I posted experimental change following flush_icache_mm approach. That
patch takes into account other concurrently running harts as well as
possible migration to other harts later on, see:

https://lore.kernel.org/linux-riscv/20220829205219.283543-1-geomatsi@gmail.com/

Regards,
Sergey
