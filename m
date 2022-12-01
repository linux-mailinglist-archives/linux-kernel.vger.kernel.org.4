Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB05863FA9F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiLAWdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiLAWd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:33:27 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018F27B4D6;
        Thu,  1 Dec 2022 14:33:23 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id e13so4212934edj.7;
        Thu, 01 Dec 2022 14:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CRPZJVdzuBuGO231NILaK2vg63uIgCdtqFzKn750f10=;
        b=cabCx6OdMcHjFaK3HJJwSe6AE5ug8ecPyG6n8xIdM+KjsA0rXvbU5HeC4UAM1YCfSc
         SPYw+19rgtyZuDPEvAcSWoXidkSvV7lfLMxo4ALLAGdfYxxLJ6SR2JVzl/Z/GzuEJhfj
         AfRxxV7nwd3K6JkM6UJCkonf7MRph2Ut3mxxyg6OjmAYtsQii3zTUWhdk+vIlxMvhPar
         +eZqx9TpfBRjdYYLWhGbD8E9bJyQvcj3IInRiOApK3YBAJ8GAbUWvpgbQ5xUUIOQBuJk
         nJKkEfclYNm1ZpygzcGoC8kjShjVGfMZNITXyF9F9S0exTci4ZE6OAXYq+DNcsYpE6EG
         +Ang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CRPZJVdzuBuGO231NILaK2vg63uIgCdtqFzKn750f10=;
        b=Waw9X4wUi2dGIZGWYHJ8M3f8JRloqx/kHhkzoe52Bi+hOg6vKyv44HJ7a2ssPXXXEP
         UbA4WrOMI+yCQOMUNipalvO0wJzCLFtqvTYAI8lEcoV1zH1iizSXq1ywtrLAmFAVkwfQ
         hgpAerPoNVZCI3vTuxAr3wxpumeW0oKFpOVjLe0Y197vKarwTNPPGs+w496+/taVym1j
         hLxCLyy+t+z5VkBG3R9DHEs3nmY63dw8kgYl/IYvNEUXQ7CZrLL/3i298V7DlQoZIETa
         T99bWHXzPuFmsjN2w7PtnHJX/vl5rSxIAuDMCG9ZZknpgVJuh/PTAlQHxKzRk5+lIGqP
         JDXQ==
X-Gm-Message-State: ANoB5pmtVpI85b2ZJEVVGiQS3kKhw/IKGNmIPqS8fYWZ17W++vNQLNbT
        9v0ycijQJ/Jfv99pGofhznOTsQ5JjKBTtE/qXTA=
X-Google-Smtp-Source: AA0mqf4scydQ0RjuQwOxNTSsKlTD5nD1vQKUJYeD7R3+AYnOhONPpNH+OPn35vnZCX81KwV+f5BeOm57ONHRNVflYgU=
X-Received: by 2002:a05:6402:d6a:b0:467:6dbf:e3e8 with SMTP id
 ec42-20020a0564020d6a00b004676dbfe3e8mr23328055edb.291.1669934002487; Thu, 01
 Dec 2022 14:33:22 -0800 (PST)
MIME-Version: 1.0
References: <20221201103026.53234-1-tomeu.vizoso@collabora.com> <20221201103026.53234-5-tomeu.vizoso@collabora.com>
In-Reply-To: <20221201103026.53234-5-tomeu.vizoso@collabora.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 1 Dec 2022 23:33:11 +0100
Message-ID: <CAFBinCC8kQ-7v+PCZgsqo2kGzsOi5jT6ekmjvb_D2j5tBmHNoA@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] arm64: dts: Add DT node for the VIPNano-QI on the A311D
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     italonicola@collabora.com,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Amlogic Meson SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson SoC support" 
        <linux-amlogic@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 1, 2022 at 11:31 AM Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
[...]
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> index 45947c1031c4..61c8461df614 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> @@ -11,6 +11,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/reset/amlogic,meson-g12a-reset.h>
>  #include <dt-bindings/thermal/thermal.h>
> +#include <dt-bindings/power/meson-g12a-power.h>
We could now remove the meson-g12a-power include from
arch/arm64/boot/dts/amlogic/meson-g12.dtsi
I'm not sure if we have any "rule" about this though, so I'm curious
to hear what others think.


Best regards,
Martin
