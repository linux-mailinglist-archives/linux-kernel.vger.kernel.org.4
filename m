Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D5D6CEE30
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjC2P6p convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Mar 2023 11:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjC2P62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:58:28 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99D15BBE;
        Wed, 29 Mar 2023 08:57:50 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id er13so24283845edb.9;
        Wed, 29 Mar 2023 08:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680105431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mv45vqNNvk7gfjj9ywv5t87xL9EGo+L1vyvtzDS68LU=;
        b=zneWHeMjHgnz/FlxY9gOdWel+Biu6vY1wIVNBypUud5cFuWy94VgNkIcDMlQshlMC1
         kSohzem/DqzemmVfmIGPJZcGllbtu79NUk1TL57qBwIkdrYYywC0n5aj0toQG3B2XDWb
         HDULPB40D7bHs9ihfkasaCJa2joUY7YG4NTeMOGVaPlrVEdzpfro6wBPwDjX15ErEA6k
         epf4TKCjT2oe/LbqftMpyKMBBf0Ws07rCnQ5POrJZfQKR02lB00N2Vx5UbJPXl6aynjq
         Y6HfckyT1N2r+FRHYus8JcOxbaXxGVnZRyhI3XYMKTNOodty+Em/LLhTUI4KiGxrWj80
         laSA==
X-Gm-Message-State: AAQBX9c1NNl26lM1cCqY0dkxXjKpPvohyKm3pYfdIHThNisOc8vYyZRo
        p7MuNNMcfbhSaQfrXyqIGIf/QB7ATNIq6/1b
X-Google-Smtp-Source: AKy350bDNHP9CTNtTgHuTD8bHAM78SJBcIfhWL/xWstN3I5lT2k2VUVe+z1yT6ySAusC85ZuE0Q6RQ==
X-Received: by 2002:a17:906:3288:b0:8b1:fc58:a4ad with SMTP id 8-20020a170906328800b008b1fc58a4admr21801432ejw.11.1680105431102;
        Wed, 29 Mar 2023 08:57:11 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id wf4-20020a170907d68400b0093f3d12d64bsm5930422ejc.179.2023.03.29.08.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 08:57:11 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id q7-20020a05600c46c700b003ef6e809574so6728778wmo.4;
        Wed, 29 Mar 2023 08:57:10 -0700 (PDT)
X-Received: by 2002:a5d:591c:0:b0:2ca:4533:5d6a with SMTP id
 v28-20020a5d591c000000b002ca45335d6amr4154237wrd.7.1680105410028; Wed, 29 Mar
 2023 08:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230329-dt-cpu-header-cleanups-v1-0-581e2605fe47@kernel.org> <20230329-dt-cpu-header-cleanups-v1-6-581e2605fe47@kernel.org>
In-Reply-To: <20230329-dt-cpu-header-cleanups-v1-6-581e2605fe47@kernel.org>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 29 Mar 2023 23:56:38 +0800
X-Gmail-Original-Message-ID: <CAGb2v64tNZa_LCUpHBbBUdpftB_Dms=oHcb7ZAD42qL-ov73hw@mail.gmail.com>
Message-ID: <CAGb2v64tNZa_LCUpHBbBUdpftB_Dms=oHcb7ZAD42qL-ov73hw@mail.gmail.com>
Subject: Re: [PATCH 06/19] ARM: sunxi: Drop of_device.h include
To:     Rob Herring <robh@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
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
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 11:53 PM Rob Herring <robh@kernel.org> wrote:
>
> Now that of_cpu_device_node_get() is defined in of.h, of_device.h is just
> implicitly including other includes, and is no longer needed. Just drop
> including of_device.h as of.h is already included.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please ack and I will take the series via the DT tree.

Acked-by: Chen-Yu Tsai <wens@csie.org>

I doubt this file would ever see any more changes.

> ---
>  arch/arm/mach-sunxi/mc_smp.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
> index 26cbce135338..cb63921232a6 100644
> --- a/arch/arm/mach-sunxi/mc_smp.c
> +++ b/arch/arm/mach-sunxi/mc_smp.c
> @@ -19,7 +19,6 @@
>  #include <linux/irqchip/arm-gic.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> -#include <linux/of_device.h>
>  #include <linux/smp.h>
>
>  #include <asm/cacheflush.h>
>
> --
> 2.39.2
>
