Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3666C64A9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 11:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjCWKSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 06:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjCWKRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:17:47 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D8A1A96D;
        Thu, 23 Mar 2023 03:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679566654; x=1711102654;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FnXm+KxPAQOleEvIez2agf6n8OX0ULT3pj5+c93lH5Q=;
  b=fuf5PHN77MzxiRUzC5j638tIo0hdDL+H5VFV/RgxOObMMTlSBMOmWhlo
   apqTMHvRy55TXSRgsep3wppJPwagyzzOsSzOUDB16R6p0o0tG3xs7QMTb
   sFUYw0U0Cv+r3lBj7iFATm1XG/DywflHvTHVMe2aUKKVinZ29kVdwmR0s
   zC0Cf5WXRgICK1QtnzLGUsc15gBCkXlCqbLMD5Rjx3G13Y+lFoT25zoUW
   toJQCYF9Z+8tVm+FtpeLVnp4ZM26Na1j9MhfHa04dtc35M9e0Bt9Lc0F0
   rjxIK7My9nonZFPz2Ezod1H4CWF+GykQK7m+WLrSP5xxkGDu9epnngFb4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="339479969"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="339479969"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 03:17:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="825766162"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="825766162"
Received: from stinti-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.46.226])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 03:17:27 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 154D8109FCC; Thu, 23 Mar 2023 13:17:25 +0300 (+03)
Date:   Thu, 23 Mar 2023 13:17:25 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guo Ren <guoren@kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Zi Yan <ziy@nvidia.com>, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH 00/14] arch,mm: cleanup Kconfig entries for
 ARCH_FORCE_MAX_ORDER
Message-ID: <20230323101725.2jmvpaqpzflr4mv2@box>
References: <20230323092156.2545741-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323092156.2545741-1-rppt@kernel.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 11:21:42AM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> Hi,
> 
> Several architectures have ARCH_FORCE_MAX_ORDER in their Kconfig and
> they all have wrong and misleading prompt and help text for this option.
> 
> Besides, some define insane limits for possible values of
> ARCH_FORCE_MAX_ORDER, some carefully define ranges only for a subset of
> possible configurations, some make this option configurable by users for no
> good reason.
> 
> This set updates the prompt and help text everywhere and does its best to
> update actual definitions of ranges where applicable.
> 
> Mike Rapoport (IBM) (14):
>   arm: reword ARCH_FORCE_MAX_ORDER prompt and help text
>   arm64: drop ranges in definition of ARCH_FORCE_MAX_ORDER
>   arm64: reword ARCH_FORCE_MAX_ORDER prompt and help text
>   csky: drop ARCH_FORCE_MAX_ORDER
>   ia64: don't allow users to override ARCH_FORCE_MAX_ORDER
>   m68k: reword ARCH_FORCE_MAX_ORDER prompt and help text
>   nios2: reword ARCH_FORCE_MAX_ORDER prompt and help text
>   nios2: drop ranges for definition of ARCH_FORCE_MAX_ORDER
>   powerpc: reword ARCH_FORCE_MAX_ORDER prompt and help text
>   powerpc: drop ranges for definition of ARCH_FORCE_MAX_ORDER
>   sh: reword ARCH_FORCE_MAX_ORDER prompt and help text
>   sh: drop ranges for definition of ARCH_FORCE_MAX_ORDER
>   sparc: reword ARCH_FORCE_MAX_ORDER prompt and help text
>   xtensa: reword ARCH_FORCE_MAX_ORDER prompt and help text
> 
>  arch/arm/Kconfig      | 16 +++++++++-------
>  arch/arm64/Kconfig    | 27 ++++++++++++---------------
>  arch/csky/Kconfig     |  4 ----
>  arch/ia64/Kconfig     |  3 +--
>  arch/m68k/Kconfig.cpu | 16 +++++++++-------
>  arch/nios2/Kconfig    | 17 +++++++++--------
>  arch/powerpc/Kconfig  | 22 +++++++++-------------
>  arch/sh/mm/Kconfig    | 19 +++++++++----------
>  arch/sparc/Kconfig    | 16 +++++++++-------
>  arch/xtensa/Kconfig   | 16 +++++++++-------
>  10 files changed, 76 insertions(+), 80 deletions(-)

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
