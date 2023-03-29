Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F32D6CEEAF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjC2P7m convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Mar 2023 11:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjC2P7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:59:09 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A496A54;
        Wed, 29 Mar 2023 08:58:34 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id eh3so65215889edb.11;
        Wed, 29 Mar 2023 08:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680105487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mzq+vIJia6Oe7/D+Sh+wrCg8ai+vibYcP9Z6Z0Gi+ds=;
        b=dPIuDM8VjmyvDyonAgBZIaxnHgv4uo1h98NX225Q0Vo3m92jZQGJTE/qwJLvpdlqvn
         2rMvxwXLkbnDmfb/eC2FJC3M/8kYg9b6UmDcNc3RPTyGicrO3lQ2IdEbUgYI5E//fd4M
         IRaCn1vZfRfy+dp+XfRQE5O4k1BaB2i+lIPPr77PsaXuNTijzC7eyUztZ7PUVLOeURyS
         555piq7an4q1dPZpfDovAKJIWuEL+hTh+HjiD6MOkOSWRtY4WfrqK5mGVJ+h2WqncSsq
         H+NvGJPuIfxg2AWilgPGqD4lAdzjXNqVzGRDblemqT2Qj/IhGg5uky/hZ9vFSTBTJiW0
         kfOg==
X-Gm-Message-State: AAQBX9fjqPktmrtUFqX7oT3pZpUk33yXbJ7XBVNdWa6G4s8BIcB3DKOz
        ngcqP4c2ipcZek1393OWDPB04k9kxo3s+TBNe04=
X-Google-Smtp-Source: AKy350boHE0zfBloqdcSNGmzBqUXXsRddCRy/sa5FfObdnxpOzEYGDjWB1IEyEgnL1SIEdbf4Xnc903CLkgoiq3GKuI=
X-Received: by 2002:a50:d49e:0:b0:502:148d:9e1e with SMTP id
 s30-20020a50d49e000000b00502148d9e1emr9950905edi.3.1680105487384; Wed, 29 Mar
 2023 08:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230329-dt-cpu-header-cleanups-v1-0-581e2605fe47@kernel.org> <20230329-dt-cpu-header-cleanups-v1-14-581e2605fe47@kernel.org>
In-Reply-To: <20230329-dt-cpu-header-cleanups-v1-14-581e2605fe47@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Mar 2023 17:57:56 +0200
Message-ID: <CAJZ5v0iBjt6Rms1QznB7LLvq5S2GcQRBmSXmT30rswTHtD7s8g@mail.gmail.com>
Subject: Re: [PATCH 14/19] cpufreq: Adjust includes to remove of_device.h
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
        Anup Patel <anup@brainfault.org>,
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
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 5:53 PM Rob Herring <robh@kernel.org> wrote:
>
> Now that of_cpu_device_node_get() is defined in of.h, of_device.h is just
> implicitly including other includes, and is no longer needed. Adjust the
> include files with what was implicitly included by of_device.h (cpu.h and
> of.h) and drop including of_device.h.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please ack and I will take the series via the DT tree.

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 -
>  drivers/cpufreq/kirkwood-cpufreq.c   | 2 +-
>  drivers/cpufreq/maple-cpufreq.c      | 2 +-
>  drivers/cpufreq/pmac32-cpufreq.c     | 2 +-
>  drivers/cpufreq/pmac64-cpufreq.c     | 2 +-
>  drivers/cpufreq/qcom-cpufreq-hw.c    | 4 ++--
>  drivers/cpufreq/spear-cpufreq.c      | 2 +-
>  drivers/cpufreq/tegra124-cpufreq.c   | 1 -
>  drivers/cpufreq/tegra20-cpufreq.c    | 2 +-
>  include/linux/cpufreq.h              | 1 -
>  10 files changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index e85703651098..f9675e1a8529 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -6,7 +6,6 @@
>
>  #include <linux/err.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>
>  #include "cpufreq-dt.h"
> diff --git a/drivers/cpufreq/kirkwood-cpufreq.c b/drivers/cpufreq/kirkwood-cpufreq.c
> index 70ad8fe1d78b..95588101efbd 100644
> --- a/drivers/cpufreq/kirkwood-cpufreq.c
> +++ b/drivers/cpufreq/kirkwood-cpufreq.c
> @@ -9,7 +9,7 @@
>  #include <linux/module.h>
>  #include <linux/clk.h>
>  #include <linux/cpufreq.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
>  #include <asm/proc-fns.h>
> diff --git a/drivers/cpufreq/maple-cpufreq.c b/drivers/cpufreq/maple-cpufreq.c
> index 28d346062166..f9306410a07f 100644
> --- a/drivers/cpufreq/maple-cpufreq.c
> +++ b/drivers/cpufreq/maple-cpufreq.c
> @@ -23,7 +23,7 @@
>  #include <linux/completion.h>
>  #include <linux/mutex.h>
>  #include <linux/time.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>
>  #define DBG(fmt...) pr_debug(fmt)
>
> diff --git a/drivers/cpufreq/pmac32-cpufreq.c b/drivers/cpufreq/pmac32-cpufreq.c
> index 4b8ee2014da6..a28716d8fc54 100644
> --- a/drivers/cpufreq/pmac32-cpufreq.c
> +++ b/drivers/cpufreq/pmac32-cpufreq.c
> @@ -23,7 +23,7 @@
>  #include <linux/init.h>
>  #include <linux/device.h>
>  #include <linux/hardirq.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>
>  #include <asm/machdep.h>
>  #include <asm/irq.h>
> diff --git a/drivers/cpufreq/pmac64-cpufreq.c b/drivers/cpufreq/pmac64-cpufreq.c
> index ba9c31d98bd6..2cd2b06849a2 100644
> --- a/drivers/cpufreq/pmac64-cpufreq.c
> +++ b/drivers/cpufreq/pmac64-cpufreq.c
> @@ -21,7 +21,7 @@
>  #include <linux/init.h>
>  #include <linux/completion.h>
>  #include <linux/mutex.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>
>  #include <asm/machdep.h>
>  #include <asm/irq.h>
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 2f581d2d617d..df165a078d14 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -11,8 +11,8 @@
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of_address.h>
> -#include <linux/of_platform.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
>  #include <linux/pm_opp.h>
>  #include <linux/pm_qos.h>
>  #include <linux/slab.h>
> diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
> index c6fdf019dbde..78b875db6b66 100644
> --- a/drivers/cpufreq/spear-cpufreq.c
> +++ b/drivers/cpufreq/spear-cpufreq.c
> @@ -18,7 +18,7 @@
>  #include <linux/err.h>
>  #include <linux/init.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
> diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
> index 7a1ea6fdcab6..312ca5ddc6c4 100644
> --- a/drivers/cpufreq/tegra124-cpufreq.c
> +++ b/drivers/cpufreq/tegra124-cpufreq.c
> @@ -11,7 +11,6 @@
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_opp.h>
> diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
> index ab7ac7df9e62..5d1f5f87e46d 100644
> --- a/drivers/cpufreq/tegra20-cpufreq.c
> +++ b/drivers/cpufreq/tegra20-cpufreq.c
> @@ -12,7 +12,7 @@
>  #include <linux/err.h>
>  #include <linux/init.h>
>  #include <linux/module.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_opp.h>
>  #include <linux/types.h>
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 65623233ab2f..3ac4a10d4651 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -15,7 +15,6 @@
>  #include <linux/kobject.h>
>  #include <linux/notifier.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/pm_opp.h>
>  #include <linux/pm_qos.h>
>  #include <linux/spinlock.h>
>
> --
> 2.39.2
>
