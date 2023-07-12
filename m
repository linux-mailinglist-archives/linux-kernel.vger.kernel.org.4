Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7F2750BCC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbjGLPG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbjGLPGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:06:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A051FDF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=l5Qh3/MfFZSru24zZrxAyRTdRLdF3aaB5ugOJ7hwo1I=; b=DlBsVVno+r3hizG3w+KaMCEKyB
        3+9+1QS2qY4+PjYF/Pe++BZ/Tptz7XjF3nBdy1aOFqO39HpQyYZFVssO+JRuDmlQ744YzX8FHLEOc
        GcS8Cb61lKho7M9FNVa5PSD3xotqPWOcyHSrGtc04MmDfoQRl/UfFVX461cGAAcIUj8YrzqfhfMVe
        Ed8J4vB9xCA/dcOzFYhwBOy4ESuvqRdCvafavDqD5nvaU9GhLdE9Voi4nnaJ+IHuctWl8iYg26aR2
        jne86qmBVN3jH4zM+KAclVG72QRzblnHuGw2Lvzr6bk+y5gcRwkn7cqssilzc/2o6IQy4APJGY3Bl
        bqEJnHWA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJbQ2-000Hw3-1x;
        Wed, 12 Jul 2023 15:06:18 +0000
Message-ID: <624d8b85-f247-8b8b-e69e-43860aae42d2@infradead.org>
Date:   Wed, 12 Jul 2023 08:06:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mm: Fix warnings in pgtable_32.h
Content-Language: en-US
To:     huzhi001@208suo.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org
Cc:     hpa@zytor.com, wangkefeng.wang@huawei.com, catalin.marinas@arm.com,
        hca@linux.ibm.com, guoren@kernel.org, linux-kernel@vger.kernel.org
References: <tencent_044DEB2A193CEC49B580CBDE6C846AE1AB09@qq.com>
 <234fb4ac35ddddc43dfeef62c8377bbe@208suo.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <234fb4ac35ddddc43dfeef62c8377bbe@208suo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/12/23 07:00, huzhi001@208suo.com wrote:
> The following checkpatch warnings are removed:
> WARNING: Use #include <linux/processor.h> instead of <asm/processor.h>
> 
> Signed-off-by: ZhiHu <huzhi001@208suo.com>

Do you compile-test your changes?

> ---
>  arch/x86/include/asm/pgtable_32.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/pgtable_32.h b/arch/x86/include/asm/pgtable_32.h
> index 7d4ad8907297..f4c155055035 100644
> --- a/arch/x86/include/asm/pgtable_32.h
> +++ b/arch/x86/include/asm/pgtable_32.h
> @@ -14,7 +14,7 @@
>   * the i386 page table tree.
>   */
>  #ifndef __ASSEMBLY__
> -#include <asm/processor.h>
> +#include <linux/processor.h>
>  #include <linux/threads.h>
>  #include <asm/paravirt.h>

-- 
~Randy
