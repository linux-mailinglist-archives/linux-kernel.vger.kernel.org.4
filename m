Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9076FD65C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 07:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbjEJFsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 01:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235983AbjEJFsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 01:48:05 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DE03C0E
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 22:48:03 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6ab0bad2587so1820716a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 22:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1683697682; x=1686289682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aLoXxmvmI+TNDBhJrgne+NmasMw88TAHwNMgEXRV8rI=;
        b=cdGX27W3aTaVuF1lXqNU3dXFL5s/Mxv+Moz1oLv1bQd1dEC9mDTi2x1P2N71gBko7J
         2+zczCTSBLiri2fJqfSyyz5RHx46ktfWmUOXnHuyj5Cn4nTnemxRsBPtCWjjZawCjJGN
         78Z4MCWQKxZMpusPRAJQCksQy1Dfq+cU/sE+LDbzedpxxiDwbqNmgut9N0xguAbrwjC6
         i26od8SWAexY2jtV7kg0NYHScaH2lXuJWt2XqxC61phsOtpGEOKp0RycWSufEb7ci05D
         XrgVIiuCTq2cXFJRCtMevAMjlG69+8PadWF6hGIxq7j2gai3jXAqXDEXXYFo0g1p+Z4b
         ehIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683697682; x=1686289682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLoXxmvmI+TNDBhJrgne+NmasMw88TAHwNMgEXRV8rI=;
        b=ixDfIttD/bl/NuJVHsW8g2VlNSfLGgVxrNP8gxq+v25vp67lRKHWKeai/H1nbcc9oW
         8hbkpC86D6OhCw6uDFTEcep6LLwp1V6mvOcEMNJoo80X1TAM1v/uuNvMNlV+ieNNKgNG
         iWrLVcwo770rWp2UjhIzYZvvTsdaaTlohsgSem65h/FUx9nfQ9sPhK12KPt8cL2rlGdb
         piSVElFzuCiH8tf+Ibdlk/QOnxr9LbbMlYTqx2hMZkZhqezwd3p0qv+h/EAtcV66KguP
         Uspw1UP04f/XU+0ehuObYe+gILyrBVS0t5JaXK49o5MZTgEwmxAui9sxNtZTNW3oC0IE
         k7kg==
X-Gm-Message-State: AC+VfDwYEiX1UHvlp1XhvpRsZmDkvDamB4zt2TMjdzaW6YmxhLDQJWVk
        hRzn1WosSzkjPESq1EPxWfyR/Q==
X-Google-Smtp-Source: ACHHUZ4YI0Ows+2qLCE5z9Sy2RLUd1OHJeod9NGdxiAb7Ex5AAbigEasnBSuYpWAru1W0u5cnRfMdw==
X-Received: by 2002:a9d:730d:0:b0:6ab:b20:18a5 with SMTP id e13-20020a9d730d000000b006ab0b2018a5mr2569954otk.26.1683697682642;
        Tue, 09 May 2023 22:48:02 -0700 (PDT)
Received: from sunil-laptop ([106.51.188.76])
        by smtp.gmail.com with ESMTPSA id p25-20020a9d76d9000000b0068bd922a244sm603978otl.20.2023.05.09.22.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 22:48:02 -0700 (PDT)
Date:   Wed, 10 May 2023 11:17:49 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev, Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Marc Zyngier <maz@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Subject: Re: [PATCH V5 03/21] crypto: hisilicon/qm: Fix to enable build with
 RISC-V clang
Message-ID: <ZFswBePAtF/ror5G@sunil-laptop>
References: <20230508115237.216337-1-sunilvl@ventanamicro.com>
 <20230508115237.216337-4-sunilvl@ventanamicro.com>
 <ZFmtSReX9/WR5CkK@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFmtSReX9/WR5CkK@gondor.apana.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 10:17:45AM +0800, Herbert Xu wrote:
> On Mon, May 08, 2023 at 05:22:19PM +0530, Sunil V L wrote:
> > With CONFIG_ACPI enabled for RISC-V, this driver gets enabled in
> > allmodconfig build. However, build fails with clang and below
> > error is seen.
> > 
> > drivers/crypto/hisilicon/qm.c:627:10: error: invalid output constraint '+Q' in asm
> >                        "+Q" (*((char __iomem *)fun_base))
> >                        ^
> > This is expected error with clang due to the way it is designed.
> > 
> > To fix this issue, move arm64 assembly code under #if.
> > 
> > Link: https://github.com/ClangBuiltLinux/linux/issues/999
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > [sunilvl@ventanamicro.com: Moved tmp0 and tmp1 into the #if]
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > ---
> >  drivers/crypto/hisilicon/qm.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
> > index ad0c042b5e66..2eaeaac2e246 100644
> > --- a/drivers/crypto/hisilicon/qm.c
> > +++ b/drivers/crypto/hisilicon/qm.c
> > @@ -610,13 +610,9 @@ EXPORT_SYMBOL_GPL(hisi_qm_wait_mb_ready);
> >  static void qm_mb_write(struct hisi_qm *qm, const void *src)
> >  {
> >  	void __iomem *fun_base = qm->io_base + QM_MB_CMD_SEND_BASE;
> > -	unsigned long tmp0 = 0, tmp1 = 0;
> >  
> > -	if (!IS_ENABLED(CONFIG_ARM64)) {
> > -		memcpy_toio(fun_base, src, 16);
> > -		dma_wmb();
> > -		return;
> > -	}
> 
> Please leave this bit as it stands.
> 
> > +#if IS_ENABLED(CONFIG_ARM64)
> > +	unsigned long tmp0 = 0, tmp1 = 0;
> >  
> >  	asm volatile("ldp %0, %1, %3\n"
> >  		     "stp %0, %1, %2\n"
> > @@ -626,6 +622,11 @@ static void qm_mb_write(struct hisi_qm *qm, const void *src)
> >  		       "+Q" (*((char __iomem *)fun_base))
> >  		     : "Q" (*((char *)src))
> >  		     : "memory");
> 
> And simply add the ifdef around the assembly.
> 
Sure, Herbert.

Thanks!
Sunil
