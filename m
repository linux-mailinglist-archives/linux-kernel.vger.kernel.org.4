Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76AF6CF9EF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 06:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjC3ECb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 00:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjC3ECY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 00:02:24 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72BC5272
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 21:02:19 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id eh3so71339471edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 21:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112; t=1680148938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRrMSTrE1hzXNMTnJR9hzwcHZG5OJLH6N1k4mRkhtxc=;
        b=ynfExVnq8Pbne4CrK35vVvzcZo/HMcJEJUR3Ujna/kLNgyxndnnVOhaOok7Q3u4boK
         FW4keBgSZ6pU7kWyE+manshTU5Tk7hNavSWkOvFCWTteIMmp/9Qk7GSzFj7kYZ5XfmBv
         miUHdrLcGJzpXksYn+qz42allwe3QMPmR/pnE7vpqvm1r6J8sdtN2nbt3yHJRZJvjQa2
         WULHOKYx2FaImOfeOidrkyK9ABt3NseOxAzqi3/iHsrvkvaPYLGzC0VonLkMDJt7dAvE
         qA6CCYx7R2kWBHI86Kqb+JhYZk0VIktRQH4ecdVqtPrNiVN9gXZkgnTnC6UdsKE6Gs/B
         u+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680148938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRrMSTrE1hzXNMTnJR9hzwcHZG5OJLH6N1k4mRkhtxc=;
        b=aFdM52dRG4AuBaXPdKX5hBiCPgrZRVtPwEcEtMtAHELda/+PlR60k/FJ8COK10QYBW
         f2bX8gEbVmUbHcUvb4A8fKh2RRTiQ1jht0TsbmonxuIIcXFO/6Z8fFivq0p59wPxP8Y4
         sSP5qotLK1Xn3o3ztpzjq4fRC068Anmk+8OcfdrkMkYAw+NeAfgvLnJ+TgF7GiFPFcf6
         zeSHvg4U2iPTODyGrk8MByxiB8C1qzw6MRfS4uOoRGG/bU0uSZraHT6ecmOhHFdDdyK9
         8aMbSqurtA3kXpH4UrKV8eA3jN/EnJhoS071cYS6ZrT++mLphqec7hy6yhxFM8Srl2FL
         nwbw==
X-Gm-Message-State: AAQBX9f5v8d6YqrU3s7cZxM7MPjWxlWPU/L+NbViXpeEufJhdk6AqA/m
        DDCIWfID57SK/doeYT3cXC8ofAgBLEr8cErewECPsw==
X-Google-Smtp-Source: AKy350YsOJqAiqRYem5e01w1p2m+BEvgEUELir1jFBDVGQszGos9GuJs6YHfU/Z+9mLpMcFmxWEdJiS8UYrZt9G/tI4=
X-Received: by 2002:a50:9fef:0:b0:4fc:1608:68c8 with SMTP id
 c102-20020a509fef000000b004fc160868c8mr10756114edf.1.1680148938164; Wed, 29
 Mar 2023 21:02:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230329-dt-cpu-header-cleanups-v1-0-581e2605fe47@kernel.org> <20230329-dt-cpu-header-cleanups-v1-16-581e2605fe47@kernel.org>
In-Reply-To: <20230329-dt-cpu-header-cleanups-v1-16-581e2605fe47@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 30 Mar 2023 09:32:06 +0530
Message-ID: <CAAhSdy3MYV=v2TNZ_507zGe6Pj_c95TZwODPK8-zTHpkn-ukww@mail.gmail.com>
Subject: Re: [PATCH 16/19] cpuidle: Adjust includes to remove of_device.h
To:     Rob Herring <robh@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Marc Zyngier <maz@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 9:22=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> Now that of_cpu_device_node_get() is defined in of.h, of_device.h is just
> implicitly including other includes, and is no longer needed. Adjust the
> include files with what was implicitly included by of_device.h (cpu.h,
> cpuhotplug.h, of.h, and of_platform.h) and drop including of_device.h.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

For cpuidle-riscv-sbi.c
Acked-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
> Please ack and I will take the series via the DT tree.
> ---
>  drivers/cpuidle/cpuidle-psci.c      | 1 -
>  drivers/cpuidle/cpuidle-qcom-spm.c  | 3 +--
>  drivers/cpuidle/cpuidle-riscv-sbi.c | 2 +-
>  drivers/cpuidle/dt_idle_states.c    | 1 -
>  4 files changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psc=
i.c
> index 6de027f9f6f5..bf68920d038a 100644
> --- a/drivers/cpuidle/cpuidle-psci.c
> +++ b/drivers/cpuidle/cpuidle-psci.c
> @@ -16,7 +16,6 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/psci.h>
>  #include <linux/pm_domain.h>
> diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidle=
-qcom-spm.c
> index c6e2e91bb4c3..1fc9968eae19 100644
> --- a/drivers/cpuidle/cpuidle-qcom-spm.c
> +++ b/drivers/cpuidle/cpuidle-qcom-spm.c
> @@ -11,8 +11,7 @@
>  #include <linux/io.h>
>  #include <linux/slab.h>
>  #include <linux/of.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/of_platform.h>
>  #include <linux/err.h>
>  #include <linux/platform_device.h>
>  #include <linux/cpuidle.h>
> diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidl=
e-riscv-sbi.c
> index be383f4b6855..ae0b838a0634 100644
> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> @@ -8,6 +8,7 @@
>
>  #define pr_fmt(fmt) "cpuidle-riscv-sbi: " fmt
>
> +#include <linux/cpuhotplug.h>
>  #include <linux/cpuidle.h>
>  #include <linux/cpumask.h>
>  #include <linux/cpu_pm.h>
> @@ -15,7 +16,6 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/slab.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
> diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_s=
tates.c
> index 02aa0b39af9d..12fec92a85fd 100644
> --- a/drivers/cpuidle/dt_idle_states.c
> +++ b/drivers/cpuidle/dt_idle_states.c
> @@ -14,7 +14,6 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>
>  #include "dt_idle_states.h"
>
>
> --
> 2.39.2
>
