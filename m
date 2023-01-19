Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E946734FF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjASKCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 05:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjASKC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:02:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE586DB18
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:02:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B744461204
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:02:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23302C433EF;
        Thu, 19 Jan 2023 10:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674122536;
        bh=usy+6yBsUaQa6PTMk5+DPXTRseaIjzgQf55WPxrdQxU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XSt3Zory7mayxPL8D39JFMIiwiZtTKen6LihiMEwSxgmpB2O8+NPZ2fQNNfTzS1ob
         YXDc1oaphF+Z1THCRtqYiFs6icurhty3SQwh2TSxiRy/2lDnJZV2ulWE6dh3o7wtBS
         IotIicKtfTP4RDhCTNYBZF1CZrkInlV6TS4bb74y1lsME6yZ0cF5j1UgBRJMnOnoRJ
         CUhm6njCvBgr3wXJ2NldXciqGA2QKTQAW2VMbSbJwJCxQRzeVpEgAriSNKqt4ty7cb
         UnJX4izoBrB3KbzHJBN/xZER6BQE7sC1TS/uerwG9YFpbmfnBRiEE2hFjYGJ0S4Zan
         QhgTEJrfthcEg==
Date:   Thu, 19 Jan 2023 12:02:03 +0200
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
Subject: Re: [PATCH] mm: move KMEMLEAK's Kconfig items from lib to mm
Message-ID: <Y8kVGzDKqCpjINJb@kernel.org>
References: <1674009327-23493-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1674009327-23493-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 10:35:27AM +0800, zhaoyang.huang wrote:
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
