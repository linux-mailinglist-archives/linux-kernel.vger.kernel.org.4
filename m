Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0266ACCAC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 19:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjCFSdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 13:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjCFSdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:33:20 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F273591
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 10:32:53 -0800 (PST)
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A97A541304
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 18:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678127564;
        bh=uRuGhhJh0B5paspR70yM6+MkAzhmoYmbibaOB25WZSU=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=LhlKGEJvC/j917zRsSYTrNXw1ryQMQW/oeOJ21V6PGtdMpL+nlFKwqhy/g9MvAKY8
         TcKy7OIEneVDD/xyRQHzUro9vtKXxcVOPfWDWr8YmkSF1UIHtGLOe9BQ5HZo+dT6sX
         BZkHvzAhhKfwaxaVpZLkqYCpGGEYlAeUODTMfzJrCFlTOqiA0uDZer8NgmSFNRJE5F
         VEgOjVhxN5D/h9po1LSp9EDNOgnT8L9+y6tGMzYjEe1+2oyOp8nFyfMfiybOfsx9Ep
         q0E1Jfq24QD5VF/lkTpA4nLxDTPlBQKdCcfyMh5ObY6MIW7u79hz3Tgo93U+3Savpj
         qtHvhT6NeodXA==
Received: by mail-qk1-f197.google.com with SMTP id z23-20020a376517000000b00731b7a45b7fso5973093qkb.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 10:32:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678127563;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uRuGhhJh0B5paspR70yM6+MkAzhmoYmbibaOB25WZSU=;
        b=N0sxYknic/2mZX7BogHmrt7JGvMBmImmTGuIYCjxVGU2K9Z+/UPMHpkS9uLRjpfwZe
         gp8fRnUb7lyPkfzA3WI/sePTzXUM9+kGBbrUWJuyovDZnlvxnOjqIt946GyxcK9jgxCh
         +BbYzA+RPcnYUn3NRgtAX3ZQDNO3WzvcE9pRONuS1xwjseBfTj/wyY4icvID9i16OS9n
         1xJAC4l8+HB4EBYFGZW5SGJ7rNQfOe+hWoBGXfrHFJxBU/Fw6p2S6SUxWnHYE6+bBaBa
         TX5XuFIIlD9dt63L+5cAIym0krqf+5YuEyec+0egDcTVzp+rsNxJgFszFy8cG9Ar6+GQ
         HJUw==
X-Gm-Message-State: AO0yUKWDryL+Lz6sAsbOND9TA7H067pMz+QwVm5ydWR1c5nzphRm7H7k
        BjH2RTfKb+GnNZ23BId7ydTy660ZxzLblE32foo6doPvyyeM0goMkkQC++kFdrvRkjBV3PNYOjY
        bKd1A0PrjwLRiXcFr47cJD1DA2BzZg+rXnaG0NjkqY3GDfcPIUIrp2TjyZA==
X-Received: by 2002:a05:620a:5373:b0:742:876c:7786 with SMTP id op51-20020a05620a537300b00742876c7786mr2547909qkn.7.1678127563544;
        Mon, 06 Mar 2023 10:32:43 -0800 (PST)
X-Google-Smtp-Source: AK7set/FfxFW58rFA6xFcPm17xJiOXzf0oBhBPlJuQ5UtvxTnCOcg0VVjMp7xYxNF99d8TYTZOlrLJlDuuTmLbNvTyw=
X-Received: by 2002:a05:620a:5373:b0:742:876c:7786 with SMTP id
 op51-20020a05620a537300b00742876c7786mr2547902qkn.7.1678127563187; Mon, 06
 Mar 2023 10:32:43 -0800 (PST)
MIME-Version: 1.0
References: <20230306095408.26057-1-minda.chen@starfivetech.com>
In-Reply-To: <20230306095408.26057-1-minda.chen@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Mon, 6 Mar 2023 19:32:26 +0100
Message-ID: <CAJM55Z_kUPYOXwccDOaGk2DoRd9sNrGdpKKMyRUijh5SoPnJ4w@mail.gmail.com>
Subject: Re: [PATCH 3/3] dts: usb: add StarFive JH7110 USB dts configuration.
To:     Minda Chen <minda.chen@starfivetech.com>
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Mar 2023 at 10:55, Minda Chen <minda.chen@starfivetech.com> wrote:
>
> USB phy dts configuration. Also includes Cadence USB
> subnode configuration.
>
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  .../jh7110-starfive-visionfive-2.dtsi         |  6 +++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 39 +++++++++++++++++++
>  2 files changed, 45 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index e8b8f4346fdd..2a9ed8b9ee25 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -244,3 +244,9 @@
>                 };
>         };
>  };
> +
> +&usb0 {
> +       starfive,usb2-only;
> +       dr_mode = "peripheral";
> +       status = "okay";
> +};
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index be180f23963e..ee665cdc3510 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -628,5 +628,44 @@
>                         starfive,sysreg = <&sys_syscon 0x9c 0x1 0x3e>;
>                         status = "disabled";
>                 };
> +
> +               usb0: usbphy@10200000 {

Please keep the nodes sorted by the address after @

> +                       compatible = "starfive,jh7110-usb";
> +                       reg = <0x0 0x10210000 0x0 0x1000>,
> +                             <0x0 0x10200000 0x0 0x1000>;
> +                       reg-names = "usb3", "usb2";
> +                       clocks = <&syscrg JH7110_SYSCLK_USB_125M>,
> +                                <&stgcrg JH7110_STGCLK_USB0_APP_125>,
> +                                <&stgcrg JH7110_STGCLK_USB0_LPM>,
> +                                <&stgcrg JH7110_STGCLK_USB0_STB>,
> +                                <&stgcrg JH7110_STGCLK_USB0_APB>,
> +                                <&stgcrg JH7110_STGCLK_USB0_AXI>,
> +                                <&stgcrg JH7110_STGCLK_USB0_UTMI_APB>;
> +                       clock-names = "usb_125m", "usb0_app_125", "usb0_lpm",
> +                               "usb0_stb", "usb0_apb", "usb0_axi", "usb0_utmi_apb";
> +                       resets = <&stgcrg JH7110_STGRST_USB0_PWRUP>,
> +                                <&stgcrg JH7110_STGRST_USB0_APB>,
> +                                <&stgcrg JH7110_STGRST_USB0_AXI>,
> +                                <&stgcrg JH7110_STGRST_USB0_UTMI_APB>;
> +                       starfive,stg-syscon = <&stg_syscon 0x4 0xc4 0x148 0x1f4>;
> +                       starfive,sys-syscon = <&sys_syscon 0x18>;
> +                       status = "disabled";
> +                       #address-cells = <2>;
> +                       #size-cells = <2>;
> +                       #interrupt-cells = <1>;
> +                       #phy-cells = <0>;
> +                       ranges;

Please add an empty line here.

> +                       usbdrd_cdns3: usb@10100000 {
> +                               compatible = "cdns,usb3";
> +                               reg = <0x0 0x10100000 0x0 0x10000>,
> +                                     <0x0 0x10110000 0x0 0x10000>,
> +                                     <0x0 0x10120000 0x0 0x10000>;
> +                               reg-names = "otg", "xhci", "dev";
> +                               interrupts = <100>, <108>, <110>;
> +                               interrupt-names = "host", "peripheral", "otg";
> +                               phy-names = "cdns3,usb3-phy", "cnds3,usb2-phy";
> +                               maximum-speed = "super-speed";
> +                       };
> +               };
>         };
>  };
> --
> 2.17.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
