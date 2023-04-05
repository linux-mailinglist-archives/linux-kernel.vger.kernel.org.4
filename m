Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142DD6D7A86
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 12:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237644AbjDEK6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 06:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237516AbjDEK62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 06:58:28 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10499268B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 03:58:27 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id o2so34054602plg.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 03:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1680692306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gzqvLefolrwy3WdKYUZXiVUA/OQTcVAscLkW8tJWOwA=;
        b=jO0Y2EOFEKMw2F8LH2z0jbWyH6iiWiC/WyITb2ZxshiuO7irSikeEstwWIMuLeE5yA
         BPh+X2qBVfn2w7PNRyONoDHq4qyuphVGfxsKV3e/0QU3AOf+JDEg5UjfGkf7x9y//lfd
         95o8tRXJFCbhxM6DMHsP9/3yvlAGjZaoH2DIzAlWnd11KLPiFpyJ9BLtFvkpmEe1t9lL
         IRvUmgSle+koJjWBDlPqB4K5Vf1nadckacYET91rTHhrtwJd8l73IWetohGmCobodQ4Q
         MyttWJtt1sliGHRvEc0zh9Ef2SlGnYje0yYqq69dzGW8capGmFjaQtDzTEhvIFF8mCV8
         PCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680692306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzqvLefolrwy3WdKYUZXiVUA/OQTcVAscLkW8tJWOwA=;
        b=mWLPGKv58+rHceZ2oOJKomqSJRS5ZEue/M70Gi64ApKJHmrnSRbrsJu35CazX8h9cM
         CH6iBUdxQp+YTAlJREGm0tBitcXCPC3Q+OAL8H4rmUJCFVEKtCM+d6wEF30yvawljDkm
         cUB2AhT5QORvS+UNEriqplwecAnoy+b7dbQ3lQS38Vq3PTa76+kJ30548WDQ5u1urp2W
         R/uRyP2nN+SmlstN5fEQ+1aNDj5Pv3Sn6juDWthtPEe2iUz1DdCwiA8whr3tCzmWVrxa
         hrruEQii9Sg7M9blKGi9BqN2WnFZcxtz8MUsvTSSKZO0kvk/gL8bqNuv/jShjR89NKt1
         /Usw==
X-Gm-Message-State: AAQBX9dCT6IugOnq7rYuJTxyqgS1u1WEeWtdwuU66B9wPYzwZc1/m6z/
        b7E2zQmRT96gjKpeRT2vwYAg9g==
X-Google-Smtp-Source: AKy350Z45D9tpgWEug4uJiwUcpQ/wzKxDo0vLJTHod9wnTI8mK/+badfYEZMzMbpbs5SYRl87Y9j8w==
X-Received: by 2002:a17:90b:388b:b0:241:13bb:8303 with SMTP id mu11-20020a17090b388b00b0024113bb8303mr6409630pjb.42.1680692306536;
        Wed, 05 Apr 2023 03:58:26 -0700 (PDT)
Received: from sunil-laptop ([106.51.184.50])
        by smtp.gmail.com with ESMTPSA id on13-20020a17090b1d0d00b0023493354f37sm1123694pjb.26.2023.04.05.03.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 03:58:26 -0700 (PDT)
Date:   Wed, 5 Apr 2023 16:28:13 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Tom Rix <trix@redhat.com>, Weili Qian <qianweili@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Len Brown <lenb@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH V4 20/23] RISC-V: Enable ACPI in defconfig
Message-ID: <ZC1URXKq7rrUlrXl@sunil-laptop>
References: <20230404182037.863533-1-sunilvl@ventanamicro.com>
 <20230404182037.863533-21-sunilvl@ventanamicro.com>
 <20230404-dimmed-verbally-3597dcaaf106@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404-dimmed-verbally-3597dcaaf106@spud>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 10:43:02PM +0100, Conor Dooley wrote:
> On Tue, Apr 04, 2023 at 11:50:34PM +0530, Sunil V L wrote:
> > Add support to build ACPI subsystem in defconfig.
> > 
> > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> 
> Dropped another R-b?
> https://lore.kernel.org/linux-riscv/91cf4ebd-f22c-4cf9-9fb4-fa6349ea00ab@spud/
> 
Yeah, missed updating....

> That said...
> 
> > ---
> >  arch/riscv/configs/defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> > index d98d6e90b2b8..8822b49ddb59 100644
> > --- a/arch/riscv/configs/defconfig
> > +++ b/arch/riscv/configs/defconfig
> > @@ -238,3 +238,4 @@ CONFIG_RCU_EQS_DEBUG=y
> >  # CONFIG_FTRACE is not set
> >  # CONFIG_RUNTIME_TESTING_MENU is not set
> >  CONFIG_MEMTEST=y
> > +CONFIG_ACPI=y
> 
> ...this is not where savedefconfig puts this for me.
> Please move it there & then:
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
Okay. Will update.

Thanks!
Sunil
