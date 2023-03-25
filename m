Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBCB6C8BC9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 07:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjCYGfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 02:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbjCYGfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 02:35:45 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B2915570;
        Fri, 24 Mar 2023 23:35:43 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Pk8Pk2w5BzSny7;
        Sat, 25 Mar 2023 14:32:10 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 25 Mar 2023 14:35:38 +0800
Message-ID: <e2333d87-6442-0ddc-ee3d-5fb917600577@huawei.com>
Date:   Sat, 25 Mar 2023 14:35:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 03/14] arm64: reword ARCH_FORCE_MAX_ORDER prompt and
 help text
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guo Ren <guoren@kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Zi Yan <ziy@nvidia.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-csky@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-m68k@lists.linux-m68k.org>,
        <linux-mm@kvack.org>, <linux-sh@vger.kernel.org>,
        <linux-xtensa@linux-xtensa.org>, <linuxppc-dev@lists.ozlabs.org>,
        <sparclinux@vger.kernel.org>
References: <20230325060828.2662773-1-rppt@kernel.org>
 <20230325060828.2662773-4-rppt@kernel.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230325060828.2662773-4-rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/25 14:08, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> The prompt and help text of ARCH_FORCE_MAX_ORDER are not even close to
> describe this configuration option.
> 
> Update both to actually describe what this option does.
> 
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>

Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>

> ---
>   arch/arm64/Kconfig | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 7324032af859..cc11cdcf5a00 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1487,24 +1487,24 @@ config XEN
>   # 16K |       27          |      14      |       13        |         11         |
>   # 64K |       29          |      16      |       13        |         13         |
>   config ARCH_FORCE_MAX_ORDER
> -	int "Maximum zone order" if EXPERT && (ARM64_4K_PAGES || ARM64_16K_PAGES)
> +	int "Order of maximal physically contiguous allocations" if EXPERT && (ARM64_4K_PAGES || ARM64_16K_PAGES)
>   	default "13" if ARM64_64K_PAGES
>   	default "11" if ARM64_16K_PAGES
>   	default "10"
>   	help
> -	  The kernel memory allocator divides physically contiguous memory
> -	  blocks into "zones", where each zone is a power of two number of
> -	  pages.  This option selects the largest power of two that the kernel
> -	  keeps in the memory allocator.  If you need to allocate very large
> -	  blocks of physically contiguous memory, then you may need to
> -	  increase this value.
> +	  The kernel page allocator limits the size of maximal physically
> +	  contiguous allocations. The limit is called MAX_ORDER and it
> +	  defines the maximal power of two of number of pages that can be
> +	  allocated as a single contiguous block. This option allows
> +	  overriding the default setting when ability to allocate very
> +	  large blocks of physically contiguous memory is required.
>   
> -	  We make sure that we can allocate up to a HugePage size for each configuration.
> -	  Hence we have :
> -		MAX_ORDER = PMD_SHIFT - PAGE_SHIFT  => PAGE_SHIFT - 3
> +	  The maximal size of allocation cannot exceed the size of the
> +	  section, so the value of MAX_ORDER should satisfy
>   
> -	  However for 4K, we choose a higher default value, 10 as opposed to 9, giving us
> -	  4M allocations matching the default size used by generic code.
> +	    MAX_ORDER + PAGE_SHIFT <= SECTION_SIZE_BITS
> +
> +	  Don't change if unsure.
>   
>   config UNMAP_KERNEL_AT_EL0
>   	bool "Unmap kernel when running in userspace (aka \"KAISER\")" if EXPERT
