Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B582674C36
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjATF0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjATF0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:26:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AD07E4A2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 21:18:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1816B82148
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:04:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00A1C433F0;
        Thu, 19 Jan 2023 10:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674122654;
        bh=PZzBwOj6lTIQ6U5yiabXUXMVM4plXhXshUd7IAubI6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gxwfTqJ8nNHq59XloszSNGBBynkA25dIpH2hv5FX1Wj/bpCu9P4G04sMyfir8TUBQ
         +TN18rQzMjChGCAxLrBxLLwml/EtG8OIluzgWhk8VuwCRFP6sUA8cqlwidfXju/cvM
         0FMjxcBB6H/NzgjiJ/Cylzq7Un34tZp0C7NuApqVvXQT8LOJpvWGkXuf4RtKsBQCa8
         Eo95LH2XXQsGuMv4f/UNlm2yM3Z/yxafylPx38NsBox/Gh1LGrtQ0Ou581uqSwgeAn
         ucUHlYn5117sagdN17UCmepAt2li+odYf4c1Fv3NGprZvE61a9jUmrWNd+FRu/jzur
         PjyUMf5rjQPGQ==
Date:   Thu, 19 Jan 2023 12:04:01 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: Re: [PATCHv4 1/2] mm: move KMEMLEAK's Kconfig items from lib to mm
Message-ID: <Y8kVkZTZ/8lwaUlf@kernel.org>
References: <1674091345-14799-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1674091345-14799-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 09:22:24AM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Have the kmemleak's source code and Kconfig items be in the same directory.
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  lib/Kconfig.debug | 70 -------------------------------------------------------
>  mm/Kconfig.debug  | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 70 insertions(+), 70 deletions(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 401ad4b..62884ac 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -716,76 +716,6 @@ config SHRINKER_DEBUG
>  	  visibility into the kernel memory shrinkers subsystem.
>  	  Disable it to avoid an extra memory footprint.
>  
> -config HAVE_DEBUG_KMEMLEAK
> -	bool
> -
> -config DEBUG_KMEMLEAK
> -	bool "Kernel memory leak detector"
> -	depends on DEBUG_KERNEL && HAVE_DEBUG_KMEMLEAK
> -	select DEBUG_FS
> -	select STACKTRACE if STACKTRACE_SUPPORT
> -	select KALLSYMS
> -	select CRC32
> -	select STACKDEPOT
> -	help
> -	  Say Y here if you want to enable the memory leak
> -	  detector. The memory allocation/freeing is traced in a way
> -	  similar to the Boehm's conservative garbage collector, the
> -	  difference being that the orphan objects are not freed but
> -	  only shown in /sys/kernel/debug/kmemleak. Enabling this
> -	  feature will introduce an overhead to memory
> -	  allocations. See Documentation/dev-tools/kmemleak.rst for more
> -	  details.
> -
> -	  Enabling DEBUG_SLAB or SLUB_DEBUG may increase the chances
> -	  of finding leaks due to the slab objects poisoning.
> -
> -	  In order to access the kmemleak file, debugfs needs to be
> -	  mounted (usually at /sys/kernel/debug).
> -
> -config DEBUG_KMEMLEAK_MEM_POOL_SIZE
> -	int "Kmemleak memory pool size"
> -	depends on DEBUG_KMEMLEAK
> -	range 200 1000000
> -	default 16000
> -	help
> -	  Kmemleak must track all the memory allocations to avoid
> -	  reporting false positives. Since memory may be allocated or
> -	  freed before kmemleak is fully initialised, use a static pool
> -	  of metadata objects to track such callbacks. After kmemleak is
> -	  fully initialised, this memory pool acts as an emergency one
> -	  if slab allocations fail.
> -
> -config DEBUG_KMEMLEAK_TEST
> -	tristate "Simple test for the kernel memory leak detector"
> -	depends on DEBUG_KMEMLEAK && m
> -	help
> -	  This option enables a module that explicitly leaks memory.
> -
> -	  If unsure, say N.
> -
> -config DEBUG_KMEMLEAK_DEFAULT_OFF
> -	bool "Default kmemleak to off"
> -	depends on DEBUG_KMEMLEAK
> -	help
> -	  Say Y here to disable kmemleak by default. It can then be enabled
> -	  on the command line via kmemleak=on.
> -
> -config DEBUG_KMEMLEAK_AUTO_SCAN
> -	bool "Enable kmemleak auto scan thread on boot up"
> -	default y
> -	depends on DEBUG_KMEMLEAK
> -	help
> -	  Depending on the cpu, kmemleak scan may be cpu intensive and can
> -	  stall user tasks at times. This option enables/disables automatic
> -	  kmemleak scan at boot up.
> -
> -	  Say N here to disable kmemleak auto scan thread to stop automatic
> -	  scanning. Disabling this option disables automatic reporting of
> -	  memory leaks.
> -
> -	  If unsure, say Y.
> -
>  config DEBUG_STACK_USAGE
>  	bool "Stack utilization instrumentation"
>  	depends on DEBUG_KERNEL && !IA64
> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> index ce8dded..d1893ac 100644
> --- a/mm/Kconfig.debug
> +++ b/mm/Kconfig.debug
> @@ -207,3 +207,73 @@ config PTDUMP_DEBUGFS
>  	  kernel.
>  
>  	  If in doubt, say N.
> +
> +config HAVE_DEBUG_KMEMLEAK
> +	bool
> +
> +config DEBUG_KMEMLEAK
> +	bool "Kernel memory leak detector"
> +	depends on DEBUG_KERNEL && HAVE_DEBUG_KMEMLEAK
> +	select DEBUG_FS
> +	select STACKTRACE if STACKTRACE_SUPPORT
> +	select KALLSYMS
> +	select CRC32
> +	select STACKDEPOT
> +	help
> +	  Say Y here if you want to enable the memory leak
> +	  detector. The memory allocation/freeing is traced in a way
> +	  similar to the Boehm's conservative garbage collector, the
> +	  difference being that the orphan objects are not freed but
> +	  only shown in /sys/kernel/debug/kmemleak. Enabling this
> +	  feature will introduce an overhead to memory
> +	  allocations. See Documentation/dev-tools/kmemleak.rst for more
> +	  details.
> +
> +	  Enabling DEBUG_SLAB or SLUB_DEBUG may increase the chances
> +	  of finding leaks due to the slab objects poisoning.
> +
> +	  In order to access the kmemleak file, debugfs needs to be
> +	  mounted (usually at /sys/kernel/debug).
> +
> +config DEBUG_KMEMLEAK_MEM_POOL_SIZE
> +	int "Kmemleak memory pool size"
> +	depends on DEBUG_KMEMLEAK
> +	range 200 1000000
> +	default 16000
> +	help
> +	  Kmemleak must track all the memory allocations to avoid
> +	  reporting false positives. Since memory may be allocated or
> +	  freed before kmemleak is fully initialised, use a static pool
> +	  of metadata objects to track such callbacks. After kmemleak is
> +	  fully initialised, this memory pool acts as an emergency one
> +	  if slab allocations fail.
> +
> +config DEBUG_KMEMLEAK_TEST
> +	tristate "Simple test for the kernel memory leak detector"
> +	depends on DEBUG_KMEMLEAK && m
> +	help
> +	  This option enables a module that explicitly leaks memory.
> +
> +	  If unsure, say N.
> +
> +config DEBUG_KMEMLEAK_DEFAULT_OFF
> +	bool "Default kmemleak to off"
> +	depends on DEBUG_KMEMLEAK
> +	help
> +	  Say Y here to disable kmemleak by default. It can then be enabled
> +	  on the command line via kmemleak=on.
> +
> +config DEBUG_KMEMLEAK_AUTO_SCAN
> +	bool "Enable kmemleak auto scan thread on boot up"
> +	default y
> +	depends on DEBUG_KMEMLEAK
> +	help
> +	  Depending on the cpu, kmemleak scan may be cpu intensive and can
> +	  stall user tasks at times. This option enables/disables automatic
> +	  kmemleak scan at boot up.
> +
> +	  Say N here to disable kmemleak auto scan thread to stop automatic
> +	  scanning. Disabling this option disables automatic reporting of
> +	  memory leaks.
> +
> +	  If unsure, say Y.
> -- 
> 1.9.1
> 
> 

-- 
Sincerely yours,
Mike.
