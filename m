Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8AE56E2402
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 15:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjDNNIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 09:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjDNNIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 09:08:44 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900D53A9C;
        Fri, 14 Apr 2023 06:08:43 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PycG21yKCz4xFd;
        Fri, 14 Apr 2023 23:08:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1681477722;
        bh=lQ2sy1Tfw62Ka0rYbe1ZrKAYF5rJAMMAsOCk22IsWto=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=XsmIQJ3soXQbetkQ1EFK7ilZ4d9taopH/uxnydUgDsGDZBtuA/lMQSf1WxR3aVr4j
         aWFNbT69fPVcYIue3Edkw9ggv8vi1sGC5QC9d7j0KaktizWblQ92eM3+nYKNToY7jH
         B0rs1QC6LEdGeGYTifm/xA5R667sTgUMrvHdI/mKk4ucn21tqcN5W1UnlziIY8CEiI
         T9AXkVyyPVgXy9WSBFh6YTUQ2FGBy44kZu1/4g27vlNOQadC26OMH+5gastWCJUNNV
         zrIXcuXKPdpbKNjG+EBRDVpf0i0P2/te3agT3P87UcRqbDONwbZnicnhRQINq0URPd
         WvvjIyGUrLyUA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Danny Tsen <dtsen@linux.ibm.com>, linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, leitao@debian.org,
        nayna@linux.ibm.com, appro@cryptogams.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        ltcgcw@linux.vnet.ibm.com, dtsen@us.ibm.com,
        Danny Tsen <dtsen@linux.ibm.com>
Subject: Re: [PATCH v2 2/2] Move Power10 feature, PPC_MODULE_FEATURE_P10.
In-Reply-To: <20230413194625.10631-3-dtsen@linux.ibm.com>
References: <20230413194625.10631-1-dtsen@linux.ibm.com>
 <20230413194625.10631-3-dtsen@linux.ibm.com>
Date:   Fri, 14 Apr 2023 23:08:41 +1000
Message-ID: <87fs92a9wm.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Danny Tsen <dtsen@linux.ibm.com> writes:
> Move Power10 feature, PPC_MODULE_FEATURE_P10, definition to be in
> arch/powerpc/include/asm/cpufeature.h.
>
> Signed-off-by: Danny Tsen <dtsen@linux.ibm.com>
> ---
>  arch/powerpc/crypto/aes-gcm-p10-glue.c | 1 -
>  arch/powerpc/include/asm/cpufeature.h  | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

> diff --git a/arch/powerpc/crypto/aes-gcm-p10-glue.c b/arch/powerpc/crypto/aes-gcm-p10-glue.c
> index 1533c8cdd26f..bd3475f5348d 100644
> --- a/arch/powerpc/crypto/aes-gcm-p10-glue.c
> +++ b/arch/powerpc/crypto/aes-gcm-p10-glue.c
> @@ -22,7 +22,6 @@
>  #include <linux/module.h>
>  #include <linux/types.h>
>  
> -#define PPC_MODULE_FEATURE_P10	(32 + ilog2(PPC_FEATURE2_ARCH_3_1))
>  #define	PPC_ALIGN		16
>  #define GCM_IV_SIZE		12
>  
> diff --git a/arch/powerpc/include/asm/cpufeature.h b/arch/powerpc/include/asm/cpufeature.h
> index f6f790a90367..2dcc66225e7f 100644
> --- a/arch/powerpc/include/asm/cpufeature.h
> +++ b/arch/powerpc/include/asm/cpufeature.h
> @@ -22,6 +22,7 @@
>   */
>  
>  #define PPC_MODULE_FEATURE_VEC_CRYPTO			(32 + ilog2(PPC_FEATURE2_VEC_CRYPTO))
> +#define PPC_MODULE_FEATURE_P10				(32 + ilog2(PPC_FEATURE2_ARCH_3_1))
>  
>  #define cpu_feature(x)		(x)
>  
> -- 
> 2.31.1
