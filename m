Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632F262FCDB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 19:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242427AbiKRSgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 13:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235084AbiKRSga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 13:36:30 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4E3E0A0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 10:36:29 -0800 (PST)
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com [209.85.219.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C89453F222
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 18:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1668796588;
        bh=6VxHStuRLDpPBr5lVOouI+tg17w8c3EutmridvLwKhQ=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=VINVByJb+6yyOEIwYpts+o55f6HXmdh4RmEAapyEU6dYQX1ghnc49VzsFz3EGgUHG
         1CeQXQy0RgfHsElY+KImHizg5CtLpWeYzcQZTk7Q4Ar+m0GwvzmsS0/TsrXi61OuTh
         UaKhgxJzrapHNuZr24uJcRiSloqEKcgyvSP9wpyLmDRG/pfJYTnUh9hZR+6jQlyJKx
         TmJebSevAoMUWax8cs2GgnVpkpbduZ+o9LwCc/BojaLpahc97xs2FHKY84aFINDcAX
         WcpKNlyK4uWoqvWRuUNnFpRkwjIvEpF8KuFr6wHajvkA1ZZMmCVrPNEMfUx4tiFsi1
         LSM1yOeiBvbLw==
Received: by mail-yb1-f199.google.com with SMTP id f8-20020a25bd88000000b006dda2c86272so5149320ybh.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 10:36:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6VxHStuRLDpPBr5lVOouI+tg17w8c3EutmridvLwKhQ=;
        b=Wqoqp+8lB26dExeiGYyI8S6pELVNC2heeBvME2AAdNcaPtpMM8rzEfeWlRT/4NGwoA
         zjqOKLWri8Ve+3+Gig2bfJMOIAGVe5N11Wy8cF3/+fUzSxPw4lerFk6NNPE5jTJ6zfX6
         9o6LZJa7293jRv6J1k4B0r1hJZf115JN2X+TDIoql56o757ko75xEkDJsjoIZYH/m8SA
         urq2QihP7Hyt9bMTGxCqG+MxKpdimc1kodScrFtMYKYfKxJjy910ZO2WT5uQe15Ffdty
         nIqerkIDBTNHauMIldXxSj1MUgKA4H6mrAhjEj3JzI8DWUNScqeQAFflnKY0TS0/O5mZ
         PnDw==
X-Gm-Message-State: ANoB5pkdroZ/Pxib516VPZswKpUuVSaKY9yCxlAnCMAmrW6PtTP8o99m
        D/s67gcMg5LkurwYV3a8tFfHgBl5OsvNXyy7NsqwxLZ30x2wkxJaDgoah6fYrV2jZnvX15aOoGM
        KyeVMHR8UOW2ZtP9KuCQ43xpnFokOT7ZKFQBeCv2yAY4jLpfCsCRHf2TcSQ==
X-Received: by 2002:a25:84cc:0:b0:6e6:b5f0:3ae0 with SMTP id x12-20020a2584cc000000b006e6b5f03ae0mr7925735ybm.439.1668796587884;
        Fri, 18 Nov 2022 10:36:27 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5AiJeG5bIDPDjlRtwy/G+Yx3JIXOe1PHL7qEJarm5y87m06pZNBGulWELgbXrdeg6aHO/0uOTWrX9x1+Xs82o=
X-Received: by 2002:a25:84cc:0:b0:6e6:b5f0:3ae0 with SMTP id
 x12-20020a2584cc000000b006e6b5f03ae0mr7925710ybm.439.1668796587659; Fri, 18
 Nov 2022 10:36:27 -0800 (PST)
MIME-Version: 1.0
References: <20221118133216.17037-1-walker.chen@starfivetech.com> <20221118133216.17037-5-walker.chen@starfivetech.com>
In-Reply-To: <20221118133216.17037-5-walker.chen@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Fri, 18 Nov 2022 19:36:11 +0100
Message-ID: <CAJM55Z9bJqpEGbbx1=EBXhmhigxuHw=ObBdTJ7xy+QY=pTJyoQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] riscv: dts: starfive: add power controller node
To:     Walker Chen <walker.chen@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2022 at 14:35, Walker Chen <walker.chen@starfivetech.com> wrote:
>
> This adds the power controller node for the Starfive JH7110 SoC.
> The pmu needs to be used by other modules such as ISP, VPU, etc.
>
> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>

Hi Walker,

You called the driver jh71xx which suggests it also applies to the
jh7100. Are you missing a node in the jh7100 device tree?

> ---
>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index c22e8f1d2640..fa7b60b82d71 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -356,6 +356,13 @@
>                         #gpio-cells = <2>;
>                 };
>
> +               pwrc: power-controller@17030000 {
> +                       compatible = "starfive,jh7110-pmu";
> +                       reg = <0x0 0x17030000 0x0 0x10000>;
> +                       interrupts = <111>;
> +                       #power-domain-cells = <1>;
> +               };
> +
>                 uart0: serial@10000000 {
>                         compatible = "snps,dw-apb-uart";
>                         reg = <0x0 0x10000000 0x0 0x10000>;
> --
> 2.17.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
