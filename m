Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903746CEE71
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjC2QBo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Mar 2023 12:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjC2QAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:00:01 -0400
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8406E96;
        Wed, 29 Mar 2023 08:59:33 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id ew6so65252131edb.7;
        Wed, 29 Mar 2023 08:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680105561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J5wozgmwB4K3uhtLQG0ELPhsGFHRdp3FOmHAQorjhl0=;
        b=RB6/hL0xZ1UVrvpwhMNyu6KFniRp6vPhsOVfkm4GbwXRtfdZE7lGDJo6kpaD6oBx6s
         hPfdaa0noxc0zNjP4rVTqS0DPs9ODnDpKXMOtgmANQRc8ZgGMBk/rcQ7U6TKPPVgcT02
         j1ANnfA9SWYcEa6Ln41Y4tBCtJT8Ki3Vc+RkjfRLQfgIHG685HivjRt+ESG/5l5oT8K3
         jgZACbd5pSlsigPBhCXqi9R8QpkfnFQTNI1SKv4uA7KdoxFU7LZmOTeqHplpB5rMLwmr
         ZPq02PZHrwd+B9qkxp4F+ymSlXLylst446vjUz7aD2rS8qWZhholqx5AYNYlMT3BjdY3
         kxVQ==
X-Gm-Message-State: AAQBX9fYxWotQnl5wTjlPPB8jh2cxoVYCiEyqQ1PIm4B6wo78JgForDg
        8duPJdXPFc6MKx6aWL4Nt3bf0gW03djP5o4XpsU=
X-Google-Smtp-Source: AKy350aoH0YzB4EGxwWgRtfVzYdwc/jxafoqtAza3yowu+hrkNWR6MYo9KvzVJ1ZAz0kSvIrND9NAtkY2JWrK3waVKA=
X-Received: by 2002:a50:c34f:0:b0:4fa:71a2:982b with SMTP id
 q15-20020a50c34f000000b004fa71a2982bmr1623255edb.0.1680105560897; Wed, 29 Mar
 2023 08:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230329-dt-cpu-header-cleanups-v1-0-581e2605fe47@kernel.org> <20230329-dt-cpu-header-cleanups-v1-12-581e2605fe47@kernel.org>
In-Reply-To: <20230329-dt-cpu-header-cleanups-v1-12-581e2605fe47@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Mar 2023 17:59:09 +0200
Message-ID: <CAJZ5v0g2g7-M1cuvXNs=t-n6rZD7v=uS_rEPBQtyBBAq1yWJ7w@mail.gmail.com>
Subject: Re: [PATCH 12/19] thermal: cpuidle_cooling: Adjust includes to remove of_device.h
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
>  drivers/thermal/cpuidle_cooling.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/cpuidle_cooling.c b/drivers/thermal/cpuidle_cooling.c
> index 4f41102e8b16..6f6daead485e 100644
> --- a/drivers/thermal/cpuidle_cooling.c
> +++ b/drivers/thermal/cpuidle_cooling.c
> @@ -7,12 +7,13 @@
>   */
>  #define pr_fmt(fmt) "cpuidle cooling: " fmt
>
> +#include <linux/cpu.h>
>  #include <linux/cpu_cooling.h>
>  #include <linux/cpuidle.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/idle_inject.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/slab.h>
>  #include <linux/thermal.h>
>
>
> --
> 2.39.2
>
