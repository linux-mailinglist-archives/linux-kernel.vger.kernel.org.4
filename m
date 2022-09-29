Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A9E5EF44A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 13:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbiI2L2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 07:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbiI2L2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:28:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8762914D4A2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 04:28:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 039931A9A;
        Thu, 29 Sep 2022 04:28:15 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.81.100])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 394F43F73B;
        Thu, 29 Sep 2022 04:28:06 -0700 (PDT)
Date:   Thu, 29 Sep 2022 12:28:03 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, Julia.Lawall@inria.fr, akpm@linux-foundation.org,
        andreyknvl@gmail.com, elver@google.com, wangkefeng.wang@huawei.com,
        zhouchengming@bytedance.com, ardb@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: module: Remove unused
 plt_entry_is_initialized()
Message-ID: <YzWBQym0PtExhZH9@FVFF77S0Q05N>
References: <20220929094134.99512-1-lihuafei1@huawei.com>
 <20220929094134.99512-3-lihuafei1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929094134.99512-3-lihuafei1@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 05:41:33PM +0800, Li Huafei wrote:
> Since commit f1a54ae9af0d ("arm64: module/ftrace: intialize PLT at load
> time"), plt_entry_is_initialized() is unused anymore , so remove it.
> 
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/module.h | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
> index 28514b989a0b..8096d30c5e39 100644
> --- a/arch/arm64/include/asm/module.h
> +++ b/arch/arm64/include/asm/module.h
> @@ -59,9 +59,4 @@ static inline bool is_forbidden_offset_for_adrp(void *place)
>  
>  struct plt_entry get_plt_entry(u64 dst, void *pc);
>  
> -static inline bool plt_entry_is_initialized(const struct plt_entry *e)
> -{
> -	return e->adrp || e->add || e->br;
> -}
> -
>  #endif /* __ASM_MODULE_H */
> -- 
> 2.17.1
> 
