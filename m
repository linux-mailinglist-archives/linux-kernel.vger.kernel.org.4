Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A115E6F25D7
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 20:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjD2SZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 14:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjD2SYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 14:24:53 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A82173E
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 11:24:51 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64115eef620so19283524b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 11:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1682792690; x=1685384690;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HCZIXMPhuJUf80scSK3agzn9QDDKa0LblR7ePMqe91Q=;
        b=osIreuhFqrOaZAAl/27+IK5Hi1AB1StDT3MQB4UJdmyvLv00XqfYnZDOR5DEup+Zbc
         EMMhztAPOHm+IIUb2Jko/Ql1Qxequoi14q5q6ioXxwV6ONNbTHbCpppQsquBotBv7NZA
         0xsoGYgWKOy6+E6yOM0QJd1lS7m7Gz/d+GxIdfE4O363XFxvr58OuzUA8yahfjRkgl76
         daFFl6DyngHfFxsVeUlgdYpwovv5SK9w21aq217ZLhFo3Y8jm5Njv+T6oNvGK4lJj/ES
         nDCkxSdKHcKkITKghp2NRdG/dKj2tCryrSlZDF5O3eK56lzP0kExP10+gizADZGE0dho
         uu6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682792690; x=1685384690;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCZIXMPhuJUf80scSK3agzn9QDDKa0LblR7ePMqe91Q=;
        b=SAK/xfUTAk7pote2WfIK/bsmWS/CB4Bo4RtfJiQE8YkIDecOSUH3NdjgPUaahixo4w
         PTdNclGc5zAa5DV6Aj82H1uSu/l24N8J14g1CBF7qnbSE4CLJBFEuPUEHIGgPIdn4bHA
         86eVD8QLAJnsJSJWpzySb0QEBowpso6GEllpOIjLKLgWBWYjdGpQEdRQsYzmcdVz+i7x
         h4Zujf75l6WNQ8dGboshqjNPGCcdxKprJKaUfKryDfML40p26i9hgAmyPaKu3PLnsgdo
         rq2PWv+MwOxfjQ9JS1rzx2A4L7/tYUtAvIyX+aMnKC9obWSrUhNnfhJLSvCol7rd4bqW
         V8nA==
X-Gm-Message-State: AC+VfDwy/igYOWRemT1tGNqjOn8rg+cnijy5pWePiWiAEirjXX+QGswj
        wAxoWw4+NHBbak70ulyMrKuDWg==
X-Google-Smtp-Source: ACHHUZ56+SNdXMph8Hdac6/dfoFg0Vhv/AYaUOOmwxyPYiHuY8kgDpOram8U+gPi6EA5PyHcO2u8+w==
X-Received: by 2002:a17:903:41cf:b0:1a6:d0a8:c70f with SMTP id u15-20020a17090341cf00b001a6d0a8c70fmr11307108ple.5.1682792690325;
        Sat, 29 Apr 2023 11:24:50 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902eb0400b001960706141fsm15126026plb.149.2023.04.29.11.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 11:24:49 -0700 (PDT)
Date:   Sat, 29 Apr 2023 11:24:49 -0700 (PDT)
X-Google-Original-Date: Sat, 29 Apr 2023 11:24:22 PDT (-0700)
Subject:     Re: [PATCH 08/19] riscv: Add explicit include for cpu.h
In-Reply-To: <20230329-dt-cpu-header-cleanups-v1-8-581e2605fe47@kernel.org>
CC:     davem@davemloft.net, robh+dt@kernel.org, frowand.list@gmail.com,
        linux@armlinux.org.uk, wens@csie.org, jernej.skrabec@gmail.com,
        samuel@sholland.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Greg KH <gregkh@linuxfoundation.org>,
        rafael@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de,
        amit.kachhap@gmail.com, viresh.kumar@linaro.org,
        lukasz.luba@arm.com, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        tiny.windzz@gmail.com, lpieralisi@kernel.org, sudeep.holla@arm.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        anup@brainfault.org, chenhuacai@kernel.org,
        jiaxun.yang@flygoat.com, Marc Zyngier <maz@kernel.org>,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-tegra@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-mips@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     robh@kernel.org
Message-ID: <mhng-3fdcd7ba-9d00-4521-a55f-367cf53f5f12@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2023 08:52:05 PDT (-0700), robh@kernel.org wrote:
> Removing the include of cpu.h from of_device.h (included by
> of_platform.h) causes an error in setup.c:
>
> arch/riscv/kernel/setup.c:313:22: error: arithmetic on a pointer to an incomplete type 'typeof(struct cpu)' (aka 'struct cpu')
>
> The of_platform.h header is not necessary either, so it can be dropped.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please ack and I will take the series via the DT tree.
> ---
>  arch/riscv/kernel/setup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 376d2827e736..dcfa4b6fa4b1 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -8,6 +8,7 @@
>   *  Nick Kossifidis <mick@ics.forth.gr>
>   */
>
> +#include <linux/cpu.h>
>  #include <linux/init.h>
>  #include <linux/mm.h>
>  #include <linux/memblock.h>
> @@ -15,7 +16,6 @@
>  #include <linux/console.h>
>  #include <linux/screen_info.h>
>  #include <linux/of_fdt.h>
> -#include <linux/of_platform.h>
>  #include <linux/sched/task.h>
>  #include <linux/smp.h>
>  #include <linux/efi.h>

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
