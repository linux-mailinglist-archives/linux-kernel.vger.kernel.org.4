Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB4661E1D2
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 12:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiKFLWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 06:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiKFLWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 06:22:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF0E1137;
        Sun,  6 Nov 2022 03:22:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B14E860C41;
        Sun,  6 Nov 2022 11:22:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459D8C433D6;
        Sun,  6 Nov 2022 11:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667733757;
        bh=OwdTq6vSYCGMHzoUM+Ktw7CRJaOcLC4+kIT/bLyvSOI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oydxPb/Hw5UAOU7joCSB3r72ZuzIWLb2EcYR6UWqAkIy/Ow2xlnvWY6jkJuytjMfT
         lkwtNOEaKb92/NcQVC3NVU5gNol8DMYKo13xSZr9SVgnAcUyI4O7F26hWr0illqpV2
         X/4woT6dhwfUhaVglPmzOBUCvXoNOmWwLPV4NNBnLMdA/i4vm0xYClQQxaqlk5KGXS
         AhFRUq9sQKEMlc49ZR0Ff40AoW7XNThwOXtZ8nk9U2hH0vHlfN4nXpRss7xMia5u+o
         ovdU7HETFyscLiM77/o6wXkEXAYptDvnLpYWvXJwjkgisN0VPlpZpiwddy031ath3r
         AYUnKvc9o7isg==
Date:   Sun, 6 Nov 2022 11:22:32 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>
Subject: Re: [PATCH] Documentation: riscv: tableize memory layout
Message-ID: <Y2eY+LulWaKm7MHl@spud>
References: <20221106100239.53704-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221106100239.53704-1-bagasdotme@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2022 at 05:02:40PM +0700, Bagas Sanjaya wrote:
> Documentation: riscv: tableize memory layout

Minor nit about the $subject - but this is the docs, so I guess there's
nowhere better to mention grammar: "tableize" is not a word. I think
what you want here is "tabulate".

> The memory layout is written as table but it is inside literal code
                                 ^ as a table           ^ inside a

Anyway, those are minor nits I saw in passing, one actual comment and a
simple question below.
Thanks,
Conor.

> block, which renders as preformatted text. Write the layout in reST
> grid table instead.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/riscv/vm-layout.rst | 120 +++++++++++++++---------------
>  1 file changed, 58 insertions(+), 62 deletions(-)
> 
> diff --git a/Documentation/riscv/vm-layout.rst b/Documentation/riscv/vm-layout.rst
> index 5b36e45fef60bd..139320e35de81f 100644
> --- a/Documentation/riscv/vm-layout.rst
> +++ b/Documentation/riscv/vm-layout.rst
> @@ -30,70 +30,66 @@ the RISC-V Linux Kernel resides.
>  RISC-V Linux Kernel SV39
>  ------------------------
>  
> -::
> -
> -  ========================================================================================================================
> -      Start addr    |   Offset   |     End addr     |  Size   | VM area description
> -  ========================================================================================================================
> -                    |            |                  |         |
> -   0000000000000000 |    0       | 0000003fffffffff |  256 GB | user-space virtual memory, different per mm
> -  __________________|____________|__________________|_________|___________________________________________________________
> -                    |            |                  |         |
> -   0000004000000000 | +256    GB | ffffffbfffffffff | ~16M TB | ... huge, almost 64 bits wide hole of non-canonical
> -                    |            |                  |         |     virtual memory addresses up to the -256 GB
> -                    |            |                  |         |     starting offset of kernel mappings.
> -  __________________|____________|__________________|_________|___________________________________________________________
> -                                                              |
> -                                                              | Kernel-space virtual memory, shared between all processes:
> -  ____________________________________________________________|___________________________________________________________
> -                    |            |                  |         |
> -   ffffffc6fee00000 | -228    GB | ffffffc6feffffff |    2 MB | fixmap
> -   ffffffc6ff000000 | -228    GB | ffffffc6ffffffff |   16 MB | PCI io
> -   ffffffc700000000 | -228    GB | ffffffc7ffffffff |    4 GB | vmemmap
> -   ffffffc800000000 | -224    GB | ffffffd7ffffffff |   64 GB | vmalloc/ioremap space
> -   ffffffd800000000 | -160    GB | fffffff6ffffffff |  124 GB | direct mapping of all physical memory
> -   fffffff700000000 |  -36    GB | fffffffeffffffff |   32 GB | kasan
> -  __________________|____________|__________________|_________|____________________________________________________________
> -                                                              |
> -                                                              |
> -  ____________________________________________________________|____________________________________________________________
> -                    |            |                  |         |
> -   ffffffff00000000 |   -4    GB | ffffffff7fffffff |    2 GB | modules, BPF
> -   ffffffff80000000 |   -2    GB | ffffffffffffffff |    2 GB | kernel
> -  __________________|____________|__________________|_________|____________________________________________________________
> +   +------------------+---------+------------------+---------+----------------------------------------------------------+
> +   |    Start addr    | Offset  |     End addr     |  Size   | VM area description                                      |
> +   +==================+=========+==================+=========+==========================================================+
> +   | 0000000000000000 |    0    | 0000003fffffffff | 256 GB  | user-space virtual memory, different per mm              |
> +   +------------------+---------+------------------+---------+----------------------------------------------------------+
> +   | 0000004000000000 | +256 GB | ffffffbfffffffff | ~16M TB | ... huge, almost 64 bits wide hole of non-canonical      |
> +   |                  |         |                  |         | virtual memory addresses up to the -256 GB               |
> +   |                  |         |                  |         | starting offset of kernel mappings.                      |
> +   +------------------+---------+------------------+---------+----------------------------------------------------------+
> +   |                             Kernel-space virtual memory, shared between all processes:                             |
> +   +------------------+---------+------------------+---------+----------------------------------------------------------+
> +   | ffffffc6fee00000 | -228 GB | ffffffc6feffffff | 2 MB    | fixmap                                                   |
> +   +------------------+---------+------------------+---------+----------------------------------------------------------+
> +   | ffffffc6ff000000 | -228 GB | ffffffc6ffffffff | 16 MB   | PCI io                                                   |
> +   +------------------+---------+------------------+---------+----------------------------------------------------------+
                                                        ^
Will these numbers remain right-aligned in the formatted doc? They were
aligned before in the text form & no longer appear to be.

> +   | ffffffc700000000 | -228 GB | ffffffc7ffffffff | 4 GB    | vmemmap                                                  |
> +   +------------------+---------+------------------+---------+----------------------------------------------------------+
> +   | ffffffc800000000 | -224 GB | ffffffd7ffffffff | 64 GB   | vmalloc/ioremap space                                    |
> +   +------------------+---------+------------------+---------+----------------------------------------------------------+
> +   | ffffffd800000000 | -160 GB | fffffff6ffffffff | 124 GB  | direct mapping of all physical memory                    |
> +   +------------------+---------+------------------+---------+----------------------------------------------------------+
> +   | fffffff700000000 | -36 GB  | fffffffeffffffff | 32 GB   | kasan                                                    |
> +   +------------------+---------+------------------+---------+----------------------------------------------------------+
> +   |                                  Identical layout to the 39-bit one from here on:                                  |

This one /is/ sv39. I'd leave this as a blank to match the styling in
the original document.

> +   +------------------+---------+------------------+---------+----------------------------------------------------------+
> +   | ffffffff00000000 | -4 GB   | ffffffff7fffffff | 2 GB    | modules, BPF                                             |
> +   +------------------+---------+------------------+---------+----------------------------------------------------------+
> +   | ffffffff80000000 | -2 GB   | ffffffffffffffff | 2 GB    | kernel                                                   |
> +   +------------------+---------+------------------+---------+----------------------------------------------------------+
>  
>  

