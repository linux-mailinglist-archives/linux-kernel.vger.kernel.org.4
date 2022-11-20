Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF0E6314BF
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 16:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiKTPGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 10:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiKTPGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 10:06:46 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15F827DC9
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 07:06:44 -0800 (PST)
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com [209.85.219.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8A9813F2FF
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 15:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1668956803;
        bh=63zAF8njkANWb8igjiBaT0d8rq+Da/5C67QfqYnl2t8=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=hToLUdSsFlR5TRWbqcJqg8tcqoi5MeZDQ7hNgyip+ejupzQGvaDCQAjFynA6dJc4i
         VeBAzucPe6/iCyLK89xFMV2s9G1RReHs5cXWWVQTgLNpsi1SzUIwNlyUlt2Ot1FClQ
         7ecACEU0NSzjSEidIgJ0IaYJ2YLMZz/Wz9TouGAdJpwWm8hAXzbghSOt8NvzQ6RPYS
         qVvKSzKSzD9uju5QCvUgVgsAb/S+TK5R/p5buh54u/YMpxdFzYpt+4i467c6cN5clZ
         shBXZBrg2Qd6HuDADXJKMykHIcl7ulATdgZCSDqQjdW/6zWOD3nWTKjhQskYr0rRVK
         Fi8+IxRaG0VbQ==
Received: by mail-yb1-f200.google.com with SMTP id v189-20020a252fc6000000b006e7396ee2c3so8789521ybv.9
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 07:06:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=63zAF8njkANWb8igjiBaT0d8rq+Da/5C67QfqYnl2t8=;
        b=OCY9r53XnLQuJmBRECHehr6OWFUsmm3QT49gZTXUBjaTtQvNW0aPAnrA2B8xhLKhQc
         O5lqgTC51wVgqzJIaalIOohAIl+k0ix3G2NJTKJiw4CSon3Ngc0IBvZW+hwGbU1Hn5kc
         KbFPeaHSBdKR1eoChOVuv50OlQdjpzbxE3WEPk5rQGNcelMTnN/Tu27vnQqO5DSI43eo
         2nS6IAvS01AVUN5AS5wBFVeo2zGRRgnwVg12BXNTfteBGR541UzBeDt2eN+B8UKBfeI8
         cGRM+kgxDLQRwxCwJiTpVppdQfREHVwuWncVPjMzb2heezHaKLs01fUl7ERSGJq9UXlh
         8lIw==
X-Gm-Message-State: ANoB5pn9LgnmDov/EKlr+Q62FG6+FjHox9gj/6Gb0k9sB+Oun38rzQau
        vGE9lZYdmx3QvtJT9IoEmRpD/sWIrtWgiYU9GL8KZCuQ4tK+2kuhiXRvwHqYDwAnVoT8w6IeKBC
        /sYkmmTWqV7RpNpQa60bFVMlg/OdhGdpJQo/UpyOwFx89t4HCcbUHZm2PyA==
X-Received: by 2002:a25:510:0:b0:6d2:e45c:71c0 with SMTP id 16-20020a250510000000b006d2e45c71c0mr1159129ybf.153.1668956802566;
        Sun, 20 Nov 2022 07:06:42 -0800 (PST)
X-Google-Smtp-Source: AA0mqf55/6YijqPTdK5T7pQbmZ9YUNCO1Mc29Pp3Y0+lMw1fpsdcrNDEF/GdRZ3UT0Hk4JVi119cTfndkBPYGd+wvxE=
X-Received: by 2002:a25:510:0:b0:6d2:e45c:71c0 with SMTP id
 16-20020a250510000000b006d2e45c71c0mr1159114ybf.153.1668956802357; Sun, 20
 Nov 2022 07:06:42 -0800 (PST)
MIME-Version: 1.0
References: <20221120082114.3030-1-jszhang@kernel.org> <20221120082114.3030-7-jszhang@kernel.org>
In-Reply-To: <20221120082114.3030-7-jszhang@kernel.org>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Sun, 20 Nov 2022 16:06:26 +0100
Message-ID: <CAJM55Z_QA7a_jYYwy59W=ihZqK0ciS+FJ2Gsw_7469CW8wQ7nw@mail.gmail.com>
Subject: Re: [PATCH 6/7] riscv: dts: bouffalolab: add Sipeed M1S dock devicetree
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Nov 2022 at 09:33, Jisheng Zhang <jszhang@kernel.org> wrote:
>
> Sipeed manufactures a M1S system-on-module and dock board, add basic
> support for them.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/boot/dts/bouffalolab/Makefile      |  2 ++
>  .../boot/dts/bouffalolab/bl808-sipeed-m1s.dts | 30 +++++++++++++++++++
>  2 files changed, 32 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/bouffalolab/Makefile
>  create mode 100644 arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s.dts
>
> diff --git a/arch/riscv/boot/dts/bouffalolab/Makefile b/arch/riscv/boot/dts/bouffalolab/Makefile
> new file mode 100644
> index 000000000000..42e17e1a97bd
> --- /dev/null
> +++ b/arch/riscv/boot/dts/bouffalolab/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_SOC_BOUFFALOLAB) += bl808-sipeed-m1s.dtb
> diff --git a/arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s.dts b/arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s.dts
> new file mode 100644
> index 000000000000..64421fb2ad67
> --- /dev/null
> +++ b/arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s.dts
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (C) 2022 Jisheng Zhang <jszhang@kernel.org>
> + */
> +
> +/dts-v1/;
> +
> +#include "bl808.dtsi"
> +
> +/ {
> +       model = "Sipeed M1S";

On seeedstudio.com and everywhere else I look I only see this written
as "Sipeed M1s".

And to echo what Icenowy writes, this is better split as a .dtsi for
the Sipeed M1s module that can then be included by a .dts for the
using the module with the dock, which should then have something like

model = "Sipeed M1s Dock";

> +       compatible = "sipeed,m1s", "bouffalolab,bl808";
> +
> +       aliases {
> +               serial0 = &uart0;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial0:2000000n8";
> +       };
> +
> +       memory@50000000 {
> +               device_type = "memory";
> +               reg = <0x50000000 0x04000000>;
> +       };
> +};
> +
> +&uart0 {
> +       status = "okay";
> +};
> ---
> 2.37.2
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
