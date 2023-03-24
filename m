Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0466C7E2F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 13:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjCXMkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 08:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjCXMkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 08:40:02 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D40C1ADC5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 05:39:32 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t15so1666565wrz.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 05:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1679661567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2vDjOO3u5NrLuNTfiEX5xpBBmNaynKtTiPAN1r+oGQA=;
        b=SlEaAlQdUiCY9rRw+Jpcudsuh4bqM00Umv1wD3ZyEY3C8mY5/gcTxF/dK1XO7rbp9L
         QYWASLIfIa8trRlXG+RD8ahU+LtJxjn2Chy21ejcYjqG10O0bfyQdeVpnMBu0yWLGRfk
         9ygaXal4Ek75ASiZlSeljLCnJGHReo9qNxQyXUuU22aPRa3zPXK523GTV15rDrAoCfor
         rbxb1cHHMIehP1NKcqSLcMyqp3kMZ2ehArDtbD81zFFOrgvOT9ekHm8McYXQoCVpbM5f
         sm8WMNevDFmM4Ns5nmXzhfEgBoTssRveQnCAuiCXrBHEkQFtHO6eySgcMHA49qBIefmK
         FgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679661567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2vDjOO3u5NrLuNTfiEX5xpBBmNaynKtTiPAN1r+oGQA=;
        b=zI1kykKW7XXH9lmCfZEslfY9Q1S3x3uYilBn7XibSHCKu5uTK2dU4JAawxF6NvvYrj
         iOqIAmqm13/Obfy2H/EvyDgXe2IodZCqtEv8cgBHnMNCVaju76oyLp27k0xUUzSM2N30
         qCTJ5WvkATCKGBkwPfjYLal6ARl1Db1bPcLAuXvSxtVDCBviR+LPWTb/SDpT+dtLQd60
         UrvV7p9swf+ogZr4aBrSm0EdMT2ES/UTp1nwYuEq7pRix6yFu7a8ukPTOjNO+HHszuxn
         XnjM4faX8pxIdoxNAsB5neQBVICSk7zo1dRO/OYclDjFJy24UEYKPTLVaJJmES7CVwzn
         SD0Q==
X-Gm-Message-State: AAQBX9cGYHcFpOWO8DpJiCO12qqoHeYgN+VoM9Kdhe29I3BvuFLfa1pL
        KXNy/cmx54sDwGuJ8UJ1CkPoNfIvlibkqpmejY4=
X-Google-Smtp-Source: AKy350bEOg0BRw1mif/aUXNxqiGlaUM9IfAMPTpKin+hA349t7znDFrZd5iEERPDJ4/Fx8Mi7EnT3w==
X-Received: by 2002:adf:ef85:0:b0:2c7:bb13:e23f with SMTP id d5-20020adfef85000000b002c7bb13e23fmr2013765wro.24.1679661567156;
        Fri, 24 Mar 2023 05:39:27 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id e13-20020a5d4e8d000000b002ceacff44c7sm18456350wru.83.2023.03.24.05.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 05:39:26 -0700 (PDT)
Date:   Fri, 24 Mar 2023 13:39:25 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     palmer@dabbelt.com, conor@kernel.org, Jason@zx2c4.com,
        apatel@ventanamicro.com, heiko.stuebner@vrull.eu,
        jszhang@kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, paul.walmsley@sifive.com
Subject: Re: [PATCH v1] RISC-V: convert new selectors of RISCV_ALTERNATIVE to
 dependencies
Message-ID: <20230324123925.4snctouu2zyvizot@orel>
References: <20230324121240.3594777-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324121240.3594777-1-conor.dooley@microchip.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 12:12:41PM +0000, Conor Dooley wrote:
> for-next contains two additional extensions that select
> RISCV_ALTERNATIVE. RISCV_ALTERNATIVE no longer needs to be selected by
> individual config options as it is now selected for !XIP_KERNEL builds
> by the top level RISCV option.
> These extensions rely on the alternative framework, so convert the
> "select"s to "depends on"s instead.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Applies on top of my series doing the aforementioned conversion:
> https://lore.kernel.org/all/20230324100538.3514663-3-conor.dooley@microchip.com/
> 
> This patch is sent on its own, because I expect the others to be applied
> to fixes, as it fixes a v6.3 regression.
> For this patch, I applied my other series to v6.3-rc1 and merged that
> into for-next, and created this patch on top of the result.
> ---
>  arch/riscv/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index d2acd69d6e3e..a48d1ee677ec 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -402,8 +402,8 @@ config RISCV_ISA_C
>  config RISCV_ISA_SVNAPOT
>  	bool "SVNAPOT extension support"
>  	depends on 64BIT && MMU
> +	depends on RISCV_ALTERNATIVE
>  	default y
> -	select RISCV_ALTERNATIVE
>  	help
>  	  Allow kernel to detect the SVNAPOT ISA-extension dynamically at boot
>  	  time and enable its usage.
> @@ -478,8 +478,8 @@ config RISCV_ISA_ZICBOM
>  
>  config RISCV_ISA_ZICBOZ
>  	bool "Zicboz extension support for faster zeroing of memory"
> -	depends on !XIP_KERNEL && MMU
> -	select RISCV_ALTERNATIVE
> +	depends on MMU
> +	depends on RISCV_ALTERNATIVE
>  	default y
>  	help
>  	   Enable the use of the ZICBOZ extension (cbo.zero instruction)
> -- 
> 2.39.2
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
