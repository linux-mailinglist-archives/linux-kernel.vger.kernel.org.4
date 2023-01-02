Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6BA65B31D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 15:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236094AbjABOEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 09:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbjABOD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 09:03:59 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E5B6554
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 06:03:58 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso33056100pjt.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 06:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H6LE9777qsWo/95jEEDeNuHKeoT3KBBjJhTBB9+3438=;
        b=WVZ8sTBHE3tdEtU8KINohrJE7jUeh7JY6+Cq1JATImhS+i7bSSIxL/ab6UedZOqcPV
         9SaD3eWW62O0hELZpWDIB4FYxs9NEW0si5CeTtIl0ywEI7PWDSCJKSl1gpZiqeGXnHht
         FobvPTT7miQsIRpa7tC2nUS722if4PTI2vybziRb2umWH0/5DdTjjqpeTAnz8RLQOLK+
         NdE1DHJZil38sjCgTiP4VUdlpmCiP57OEXNjP8vmViFJOCY53vmfcrdXr5vVACYzsDU0
         MxbGood60SlNhFcsOEcrjGfLfrBN9ZTMhdNWdjcpg0+ueQBzTYCQ5sbYWjDjdkzLQ7bW
         gqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H6LE9777qsWo/95jEEDeNuHKeoT3KBBjJhTBB9+3438=;
        b=mkgp2aVctwGqeejMBBgJMY6Q7OIe1sI6fI0Y7eXU3j6UL9jBtuWBjEh5oMswfSOs1Y
         dwo+I/2s1kbBdQMW5LVA8oZA8Jl+6y8P507zXWM7A6Imc5hlxkPyg1tCjiWiwrACkv54
         svgvxVG31wbnp2dR+HLigEcTiLg0NhyfweMvE6yLDCW2hCdYqIwcnvklIn5PGRZo2KvX
         sBCzoXe0/b4hCJzmiDNKHYvKxFPgcv4PPzWbVnfxICEEQzf43XejOK8Ks3lTUiTYCUSS
         1nrR5goWJdBfpawnC1lv90i570H8e7uwKtACK1rV3QjNRxIdCB2wP63Q2ot8Kmg5YMuu
         pbJQ==
X-Gm-Message-State: AFqh2koI3P8plqVC2Fz5tEhtWfZhO7r1NeJQzW0+fH0sCp8zdzElKpYI
        JbLPdzfUZVis7hwiOj2nXF4ZrtTf0anzBoyzjg6oXw==
X-Google-Smtp-Source: AMrXdXvD8JA7sNYQjcYTqtzv0aBs0qREhnG3CGWGtXVKAhDWr+IAKhvXR7v2qYq2/A86epOWoS872lYqCFy/nLDsyvA=
X-Received: by 2002:a17:902:eb83:b0:189:e426:4616 with SMTP id
 q3-20020a170902eb8300b00189e4264616mr2030130plg.37.1672668238383; Mon, 02 Jan
 2023 06:03:58 -0800 (PST)
MIME-Version: 1.0
References: <20221227122227.460921-1-william.qiu@starfivetech.com> <20221227122227.460921-4-william.qiu@starfivetech.com>
In-Reply-To: <20221227122227.460921-4-william.qiu@starfivetech.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 2 Jan 2023 15:03:22 +0100
Message-ID: <CAPDyKFqziA+PB__v8nJzgkTuM9ZszW8X2U-akvRFv0_qwZ22OA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] riscv: dts: starfive: Add mmc node
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Dec 2022 at 13:22, William Qiu <william.qiu@starfivetech.com> wrote:
>
> This adds the mmc node for the StarFive JH7110 SoC.
> Set sdioo node to emmc and set sdio1 node to sd.
>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  .../jh7110-starfive-visionfive-v2.dts         | 25 ++++++++++++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 38 +++++++++++++++++++
>  2 files changed, 63 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
> index c8946cf3a268..d8244fd1f5a0 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
> @@ -47,6 +47,31 @@ &clk_rtc {
>         clock-frequency = <32768>;
>  };
>
> +&mmc0 {
> +       max-frequency = <100000000>;
> +       card-detect-delay = <300>;

Nitpick:  This seems redundant for a non-removable card!?

> +       bus-width = <8>;
> +       cap-mmc-highspeed;
> +       mmc-ddr-1_8v;
> +       mmc-hs200-1_8v;
> +       non-removable;
> +       cap-mmc-hw-reset;
> +       post-power-on-delay-ms = <200>;
> +       status = "okay";
> +};
> +
> +&mmc1 {
> +       max-frequency = <100000000>;
> +       card-detect-delay = <300>;

Nitpick: This looks redundant for polling based card detection
(broken-cd is set a few lines below).

> +       bus-width = <4>;
> +       no-sdio;
> +       no-mmc;
> +       broken-cd;
> +       cap-sd-highspeed;
> +       post-power-on-delay-ms = <200>;
> +       status = "okay";
> +};
> +
>  &gmac0_rmii_refin {
>         clock-frequency = <50000000>;
>  };
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index c22e8f1d2640..08a780d2c0f4 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -331,6 +331,11 @@ aoncrg: clock-controller@17000000 {
>                         #reset-cells = <1>;
>                 };
>
> +               syscon: syscon@13030000 {
> +                       compatible = "starfive,syscon", "syscon";
> +                       reg = <0x0 0x13030000 0x0 0x1000>;
> +               };
> +
>                 gpio: gpio@13040000 {
>                         compatible = "starfive,jh7110-sys-pinctrl";
>                         reg = <0x0 0x13040000 0x0 0x10000>;
> @@ -433,5 +438,38 @@ uart5: serial@12020000 {
>                         reg-shift = <2>;
>                         status = "disabled";
>                 };
> +
> +               /* unremovable emmc as mmcblk0 */

Don't confuse the mmc0 node name with mmcblk0. There is no guarantee
that this is true, unless you also specify an alias.

> +               mmc0: mmc@16010000 {
> +                       compatible = "starfive,jh7110-mmc";
> +                       reg = <0x0 0x16010000 0x0 0x10000>;
> +                       clocks = <&syscrg JH7110_SYSCLK_SDIO0_AHB>,
> +                                <&syscrg JH7110_SYSCLK_SDIO0_SDCARD>;
> +                       clock-names = "biu","ciu";
> +                       resets = <&syscrg JH7110_SYSRST_SDIO0_AHB>;
> +                       reset-names = "reset";
> +                       interrupts = <74>;
> +                       fifo-depth = <32>;
> +                       fifo-watermark-aligned;
> +                       data-addr = <0>;
> +                       starfive,syscon = <&syscon 0x14 0x1a 0x7c000000>;
> +                       status = "disabled";
> +               };
> +
> +               mmc1: mmc@16020000 {
> +                       compatible = "starfive,jh7110-mmc";
> +                       reg = <0x0 0x16020000 0x0 0x10000>;
> +                       clocks = <&syscrg JH7110_SYSCLK_SDIO1_AHB>,
> +                                <&syscrg JH7110_SYSCLK_SDIO1_SDCARD>;
> +                       clock-names = "biu","ciu";
> +                       resets = <&syscrg JH7110_SYSRST_SDIO1_AHB>;
> +                       reset-names = "reset";
> +                       interrupts = <75>;
> +                       fifo-depth = <32>;
> +                       fifo-watermark-aligned;
> +                       data-addr = <0>;
> +                       starfive,syscon = <&syscon 0x9c 0x1 0x3e>;
> +                       status = "disabled";
> +               };
>         };
>  };

Kind regards
Uffe
