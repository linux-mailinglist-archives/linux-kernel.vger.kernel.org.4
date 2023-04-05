Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972196D802D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238285AbjDEO7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjDEO7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:59:03 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD3A4C15
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 07:58:58 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id m2so36512960wrh.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 07:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1680706737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=22RndxDAcYTUmY2kPiSUATZV+V86fIqA8CXijZRxME0=;
        b=ZqGBQ9vNPVA+48EQUhzwUp+/WM53IeOgdUq3ewaCaqBbb8KK+ZrgBqGqifDz5crZgH
         /CleaEnxpWFOwffvcRE4PaNDqGEkHcmG0OnVDXABv3fNoyuPYsmlu61jRwXJVRT+0413
         mj3JxSMHJ4zfndN1qkJQtOlXmiTBVil5f75tStkVD9R/uslQhGH8H1MqAJOwCBRPjH+m
         pPbqDNNVAlFvGYVNAj6it/vbzhHsRPjyqEeiisOWJDq8uQmtwvTmIABAQmyolRpXrQlx
         u4jHzID07wGJh+JOI1MOMTs/Slm2YMjD7pi+6pusqv7u8uoeOcLu5iBDA0Y978a8Lfpj
         Bm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680706737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22RndxDAcYTUmY2kPiSUATZV+V86fIqA8CXijZRxME0=;
        b=jl8uxLaS6MILVcdRT5bapdJMa2Nq5I3ciXpxf81ITZfHJfmmB3RsfXKIB1ZpECw7eD
         eQFx+C1Rcv1MgUe2I+n9pkdQn4OLzJ0Sml9q8X/5qubKLw2NlgzDDSRq2vrOy9Kbg0Vc
         ya20+0/Biu4QSL8UB5ccpx7XPgaAy9A9E8cwILtsMlseBSWN3GMxuC1YwZeH1ZQV3awk
         a1wu6Ys0jqoXxL6qX17Z7rin9IAbOZFyxevlnlw8t3SBxpb1KhgYYeF/LR9UhSscpccN
         B7KS5OINOKmuRhbQQ6UDrmnsT/xULMYirf1Km40r1IGwnAMvbIDm/I8EyRdZWVUSVUUD
         oQow==
X-Gm-Message-State: AAQBX9c0iuhI5NQmX5H1q3lXlII+Ughq9LRZfPPyBCodmMG/gWPn4p5+
        4CtL6u0Dm+wTiHd6y9QdGwqOAw==
X-Google-Smtp-Source: AKy350bfWb7Q1dmeYeMrl784mM8dxuKi/bAHVMH6KYjH4SSAhIOa0dR3y/3E8flmAsd88iA8B0uhtw==
X-Received: by 2002:a5d:4283:0:b0:2e5:8874:d883 with SMTP id k3-20020a5d4283000000b002e58874d883mr2297075wrq.8.1680706737309;
        Wed, 05 Apr 2023 07:58:57 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id o15-20020a5d474f000000b002d7a75a2c20sm15255777wrs.80.2023.04.05.07.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 07:58:56 -0700 (PDT)
Date:   Wed, 5 Apr 2023 16:58:55 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Weili Qian <qianweili@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Len Brown <lenb@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH V4 11/23] RISC-V: smpboot: Add ACPI support in smp_setup()
Message-ID: <yqged6rmz4qb6sxhjfmypnjx3tmmoramynt45rszr2dk5awlmr@ovhlptchhv7t>
References: <20230404182037.863533-1-sunilvl@ventanamicro.com>
 <20230404182037.863533-12-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404182037.863533-12-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 11:50:25PM +0530, Sunil V L wrote:
> Enable SMP boot on ACPI based platforms by using the RINTC
> structures in the MADT table.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/include/asm/acpi.h |  2 +
>  arch/riscv/kernel/smpboot.c   | 72 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 73 insertions(+), 1 deletion(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
