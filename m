Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C007B647B67
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 02:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiLIBZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 20:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiLIBY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 20:24:28 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7EBB1059
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 17:24:10 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id a9so3295512pld.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 17:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EHIhaHkuEJIAxmUXEDjqr1glufGPUbdGVtsXv10PSDk=;
        b=XCz3NE1t8wtQn7i1rcNEXlDw/EXi2cZ3/qKOEP+76cf1LeLd/PZAQOGz59i9dP1Lwa
         UNfzBy8lHpVCGaZV70uEWIiJJJBK7qlvyoGXKiMm4pMbm1o8lDrdchx9AMNP3JDhciLh
         6zi4xEwZtZflufR5JIpDHUvDpcAtTmcJEAADfEMc0VHmKSfQ91gQLa82Gc3nnnrzLXOp
         xG3Tfiii7lp6IAxkQscXt4PuCSYTHC2j9BDTCLfMlPu8PS0lD2zYHLN8mk53gYnnHobn
         r6pGTd9D2+B8vnVAbNxMr7TKH/8L9NsINoTTdPdDEi4nuOeNOGo1soowYpmMt6lL/Xag
         hEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHIhaHkuEJIAxmUXEDjqr1glufGPUbdGVtsXv10PSDk=;
        b=D4X+e839BZxul090I0Xf49tEtE7ERP2yWng8V/9AAjCefvnXYpQXUrPmyWWHE7A3jY
         SZsfW8xASH0/wpy1+9o+HxCnWAA7NAHU/GLL5e50uphfa0q9JTZdIX6zPq5dLXA1gaPx
         wDBbRiWJukFVn971dV2+ACadOjGYWxi0cSE9cqgWmONYLoc0jOSRaUlUISBQHn3LB3DM
         xiTRxFGBpc3yYwUGUe/yeRIpHjk42PMXUeepzzjrdVzwCeaXAjWxUMTydbnlMmwNMAG+
         VievN0hfPeIjCPTGjAydNXhoOKOnNCE9NOBG6rMZyArD0nswjJ2YRct5ZNv/UDjs7k5E
         mWPw==
X-Gm-Message-State: ANoB5pnMpKiykRtRnWKV9y0x6/Vbd/4CQaxZUCfcRzRgtHDPfQnWfPJw
        KziWd1s8Q71b7LE0txIkTyaOSyasrwQ+tt3K
X-Google-Smtp-Source: AA0mqf5NtW5gG5tfTHG3NmhX8uJRY7s8A3O6ilTpb+qOfAfAlePlkUtFp74zQnjEkEnifOn98iqXvg==
X-Received: by 2002:a17:903:555:b0:188:8cfc:6ba7 with SMTP id jo21-20020a170903055500b001888cfc6ba7mr3331093plb.68.1670549049478;
        Thu, 08 Dec 2022 17:24:09 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id s13-20020a170902ea0d00b00179e1f08634sm57671plg.222.2022.12.08.17.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 17:24:09 -0800 (PST)
Date:   Thu, 08 Dec 2022 17:24:09 -0800 (PST)
X-Google-Original-Date: Thu, 08 Dec 2022 16:06:07 PST (-0800)
Subject:     Re: [PATCH v2 0/5] [PATCH 0/5] arch_topology: Build cacheinfo from primary CPU
In-Reply-To: <20221121171217.3581004-1-pierre.gondois@arm.com>
CC:     linux-kernel@vger.kernel.org, Ionela.Voinescu@arm.com,
        Rob.Herring@arm.com, pierre.gondois@arm.com,
        catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, rafael@kernel.org, lenb@kernel.org,
        sudeep.holla@arm.com, Greg KH <gregkh@linuxfoundation.org>,
        jeremy.linton@arm.com, Conor Dooley <conor.dooley@microchip.com>,
        gshan@redhat.com, sj@kernel.org, kuba@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     pierre.gondois@arm.com
Message-ID: <mhng-b3f28c39-37ea-4197-b02f-b52fa41373c6@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2022 09:12:08 PST (-0800), pierre.gondois@arm.com wrote:
> v2:
>  - Applied renaming/formatting comments from v1.
>  - Check CACHE_TYPE_VALID flag in pppt.c.
>
> Note:
> This patchset requires the following patch to be applied first in
> order to avoid the same bug described in the commit message:
> https://lore.kernel.org/all/20221116094958.2141072-1-pierre.gondois@arm.com/
>
> [1] and [2] build the CPU topology from the cacheinfo information for
> both DT/ACPI based systems and remove (struct cpu_topology).llc_id
> which was used by ACPI only.
>
> Creating the cacheinfo for secondary CPUs is done during early boot.
> Preemption and interrupts are disabled at this stage. On PREEMPT_RT
> kernels, allocating memory (and parsing the PPTT table for ACPI based
> systems) triggers a:
>   'BUG: sleeping function called from invalid context' [4]
>
> To prevent this bug, allocate the cacheinfo from the primary CPU when
> preemption and interrupts are enabled and before booting secondary
> CPUs. The cache levels/leaves are computed from DT/ACPI PPTT information
> only, without relying on the arm64 CLIDR_EL1 register.
> If no cache information is found in the DT/ACPI PPTT, then fallback
> to the current state, triggering [4] on PREEMPT_RT kernels.
>
> Patches to update the arm64 device trees that have incomplete cacheinfo
> (mostly for missing the 'cache-level' or 'cache-unified' property)
> have been sent at [3].
>
> Tested platforms:
> - ACPI + PPTT: Ampere Altra, Ampere eMAG, Cavium ThunderX2,
>   Kunpeng 920, Juno-r2
> - DT: rb5, db845c, Juno-r2
>
> [1] https://lore.kernel.org/all/20220704101605.1318280-1-sudeep.holla@arm.com/
> [2] https://lore.kernel.org/all/20220720-arch_topo_fixes-v3-0-43d696288e84@arm.com/
> [3] https://lore.kernel.org/all/20221107155825.1644604-1-pierre.gondois@arm.com/
> [4] On an Ampere Altra, with PREEMPT_RT kernel based on v6.0.0-rc4:
>
>
> [    7.560791] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
> [    7.560794] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 0, name: swapper/111
> [    7.560796] preempt_count: 1, expected: 0
> [    7.560797] RCU nest depth: 1, expected: 1
> [    7.560799] 3 locks held by swapper/111/0:
> [    7.560800]  #0: ffff403e406cae98 (&pcp->lock){+.+.}-{3:3}, at: get_page_from_freelist+0x218/0x12c8
> [    7.560811]  #1: ffffc5f8ed09f8e8 (rcu_read_lock){....}-{1:3}, at: rt_spin_trylock+0x48/0xf0
> [    7.560820]  #2: ffff403f400b4fd8 (&zone->lock){+.+.}-{3:3}, at: rmqueue_bulk+0x64/0xa80
> [    7.560824] irq event stamp: 0
> [    7.560825] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [    7.560827] hardirqs last disabled at (0): [<ffffc5f8e9f7d594>] copy_process+0x5dc/0x1ab8
> [    7.560830] softirqs last  enabled at (0): [<ffffc5f8e9f7d594>] copy_process+0x5dc/0x1ab8
> [    7.560833] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [    7.560834] Preemption disabled at:
> [    7.560835] [<ffffc5f8e9fd3c28>] migrate_enable+0x30/0x130
> [    7.560838] CPU: 111 PID: 0 Comm: swapper/111 Tainted: G        W          6.0.0-rc4-[...]
> [    7.560841] Call trace:
> [...]
> [    7.560870]  __kmalloc+0xbc/0x1e8
> [    7.560873]  detect_cache_attributes+0x2d4/0x5f0
> [    7.560876]  update_siblings_masks+0x30/0x368
> [    7.560880]  store_cpu_topology+0x78/0xb8
> [    7.560883]  secondary_start_kernel+0xd0/0x198
> [    7.560885]  __secondary_switched+0xb0/0xb4
>
> Pierre Gondois (5):
>   cacheinfo: Use RISC-V's init_cache_level() as generic OF
>     implementation
>   cacheinfo: Return error code in init_of_cache_level()
>   ACPI: PPTT: Remove acpi_find_cache_levels()
>   ACPI: PPTT: Update acpi_find_last_cache_level() to
>     acpi_get_cache_info()
>   arch_topology: Build cacheinfo from primary CPU
>
>  arch/arm64/kernel/cacheinfo.c |   9 ++-
>  arch/riscv/kernel/cacheinfo.c |  39 +------------
>  drivers/acpi/pptt.c           |  93 +++++++++++++++++-------------
>  drivers/base/arch_topology.c  |  10 +++-
>  drivers/base/cacheinfo.c      | 104 ++++++++++++++++++++++++++++++----
>  include/linux/cacheinfo.h     |  10 +++-
>  6 files changed, 170 insertions(+), 95 deletions(-)

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
