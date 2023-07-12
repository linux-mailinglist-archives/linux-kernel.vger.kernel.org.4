Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9026750B5B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjGLOsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbjGLOsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:48:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75147BB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=W0npchBg/jl6kxC2U0x6+avKMUKj+bgBPV0jTeOFRL8=; b=cvXOc+/rtIutihkukoQK3hnoIg
        dMgBr0AZty57dk0db6Myc6xoG9fnVyz75SA0FpjHRFJVRKLb7LezccKf7K6geglWseQW+wZA5At4l
        UVZVO53MJTMPI2Q93owl1oOtVxRxona0khX8dfDaLhxmyylBJkdL/EXJ6Lrg+7oTfU1cwM3fiLRGK
        +oq5rw3HjFMDcMBJkNcNXBNGQsAyg7LTKiKXeQ7kDEDj7+/Yd8l3baFKEs+pD7GaJPcJxaf8zndqX
        YWqE+ormTM5l7xWP50QZJrHoX4qPSk8mNREbNUkgtEafL8YmgYb+NV5Twr1N+54ZIo909M9JVgsau
        XzPPe1oA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJb8F-000Eis-20;
        Wed, 12 Jul 2023 14:47:55 +0000
Message-ID: <07825247-c939-fb41-45ee-1232fb410f0d@infradead.org>
Date:   Wed, 12 Jul 2023 07:47:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: [PATCH] include/asm: Fix comment typo
Content-Language: en-US
To:     pangzizhen001@208suo.com, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230712093011.17133-1-wangjianli@cdjrlc.com>
 <0538c3e01d0991bc6bbca1aecca18044@208suo.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <0538c3e01d0991bc6bbca1aecca18044@208suo.com>
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



On 7/12/23 02:35, pangzizhen001@208suo.com wrote:
> Delete duplicate word "the"
> 
> Signed-off-by: Zizhen Pang <pangzizhen001@208suo.com>
> ---
>  arch/arm/include/asm/unwind.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/unwind.h b/arch/arm/include/asm/unwind.h
> index d60b09a5acfc..a75da9a01f91 100644
> --- a/arch/arm/include/asm/unwind.h
> +++ b/arch/arm/include/asm/unwind.h
> @@ -10,7 +10,7 @@
> 
>  #ifndef __ASSEMBLY__
> 
> -/* Unwind reason code according the the ARM EABI documents */
> +/* Unwind reason code according the ARM EABI documents */

                         according to the

>  enum unwind_reason_code {
>      URC_OK = 0,            /* operation completed successfully */
>      URC_CONTINUE_UNWIND = 8,

-- 
~Randy
