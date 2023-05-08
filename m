Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BF66FA013
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 08:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbjEHGpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 02:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjEHGpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 02:45:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE416EB9;
        Sun,  7 May 2023 23:45:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C439E61F2A;
        Mon,  8 May 2023 06:45:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF48C433A0;
        Mon,  8 May 2023 06:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683528303;
        bh=m8GDQ3lj2VoX4uT5SVvsnUBZPPWNAPSFAP/Ayn8Wa8Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=reRRpdeLIqh3OE6Wn1twO01SWGFWqLxxXh9SOECEQkmBOQwJ3mBjQUNMJSyqfhGLd
         HvPCB6X6NZwHK2r433Mb2g2kQ/CWUo5aKfCKApPm7xyi5OngqZP9P9Y9O8+CO08a6r
         V/CI1ak3tz5V1zxBl/VyTQGFoZ6HSVUbSCu4PruzZCwGUejVnbOD1kc/8M+ttd6hya
         dE3p4Kq5Q7PffxDTgFLCKxllecLXW4Nj5lbQxfjzrCSbmNYwhgPcbSbJhu+QP0W+NL
         90gdhLq4+pXEPBSs3UjYTQ4SRl/5w8mSZmFMUkgMfkfEbWnL7Q09fuA9xZhJMIrl3h
         dEF4keqARZYsw==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-9659c5b14d8so662133466b.3;
        Sun, 07 May 2023 23:45:02 -0700 (PDT)
X-Gm-Message-State: AC+VfDzQRAjjjVJ26+6nhhgWn3dDX1nGeyqZq1k+jcjthF09VDTP+7ck
        p3wTI2qdkyPx1DIXU0XG81GZv8FQvbF5WuBT5OY=
X-Google-Smtp-Source: ACHHUZ6p6EHRNlgbwdsEHTSCOgGAB23tncTB+hleogWY+lD5xWNMjmI/yeUBXIqUuQ7scMtAuRcHbIJQys4BYKvSLZQ=
X-Received: by 2002:a17:906:7303:b0:965:6d21:48bc with SMTP id
 di3-20020a170906730300b009656d2148bcmr8674957ejc.75.1683528301305; Sun, 07
 May 2023 23:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230507182304.2934-1-jszhang@kernel.org> <20230507182304.2934-5-jszhang@kernel.org>
In-Reply-To: <20230507182304.2934-5-jszhang@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 8 May 2023 14:44:49 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ+p=GLH985Ce-_gCP23N0CN2yEp3C=-+05cUo05R+YHQ@mail.gmail.com>
Message-ID: <CAJF2gTQ+p=GLH985Ce-_gCP23N0CN2yEp3C=-+05cUo05R+YHQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] riscv: dts: thead: add sipeed Lichee Pi 4A board
 device tree
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 8, 2023 at 2:34=E2=80=AFAM Jisheng Zhang <jszhang@kernel.org> w=
rote:
>
> Sipeed's Lichee Pi 4A development board uses Lichee Module 4A core
> module which is powered by T-HEAD's light(a.k.a TH1520) SoC. Add
No light, just th1520.

> minimal device tree files for the core module and the development
> board.
>
> Support basic uart/gpio/dmac drivers, so supports booting to a basic
> shell.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/boot/dts/Makefile                  |  1 +
>  arch/riscv/boot/dts/thead/Makefile            |  2 +
>  .../dts/thead/light-lichee-module-4a.dtsi     | 38 +++++++++++++++++++
>  .../boot/dts/thead/light-lichee-pi-4a.dts     | 32 ++++++++++++++++
>  4 files changed, 73 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/thead/Makefile
>  create mode 100644 arch/riscv/boot/dts/thead/light-lichee-module-4a.dtsi
>  create mode 100644 arch/riscv/boot/dts/thead/light-lichee-pi-4a.dts
>
> diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
> index f0d9f89054f8..1e884868ccba 100644
> --- a/arch/riscv/boot/dts/Makefile
> +++ b/arch/riscv/boot/dts/Makefile
> @@ -2,6 +2,7 @@
>  subdir-y +=3D allwinner
>  subdir-y +=3D sifive
>  subdir-y +=3D starfive
> +subdir-y +=3D thead
>  subdir-y +=3D canaan
>  subdir-y +=3D microchip
>  subdir-y +=3D renesas
> diff --git a/arch/riscv/boot/dts/thead/Makefile b/arch/riscv/boot/dts/the=
ad/Makefile
> new file mode 100644
> index 000000000000..9e00acc714cc
> --- /dev/null
> +++ b/arch/riscv/boot/dts/thead/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_ARCH_THEAD) +=3D light-lichee-pi-4a.dtb
> diff --git a/arch/riscv/boot/dts/thead/light-lichee-module-4a.dtsi b/arch=
/riscv/boot/dts/thead/light-lichee-module-4a.dtsi
> new file mode 100644
> index 000000000000..24c9971e0fb5
> --- /dev/null
> +++ b/arch/riscv/boot/dts/thead/light-lichee-module-4a.dtsi
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> + */
> +
> +/dts-v1/;
> +
> +#include "light.dtsi"
> +
> +/ {
> +       model =3D "Sipeed Lichee Module 4A";
> +       compatible =3D "sipeed,lichee-module-4a", "thead,light";
no light, th1520
> +
> +       memory@0 {
> +               device_type =3D "memory";
> +               reg =3D <0x0 0x00000000 0x2 0x00000000>;
> +       };
> +};
> +
> +&osc {
> +       clock-frequency =3D <24000000>;
> +};
> +
> +&osc_32k {
> +       clock-frequency =3D <32768>;
> +};
> +
> +&apb_clk {
> +       clock-frequency =3D <62500000>;
> +};
> +
> +&uart_sclk {
> +       clock-frequency =3D <100000000>;
> +};
> +
> +&dmac0 {
> +       status =3D "okay";
> +};
> diff --git a/arch/riscv/boot/dts/thead/light-lichee-pi-4a.dts b/arch/risc=
v/boot/dts/thead/light-lichee-pi-4a.dts
> new file mode 100644
> index 000000000000..4f0ba2149d2d
> --- /dev/null
> +++ b/arch/riscv/boot/dts/thead/light-lichee-pi-4a.dts
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> + */
> +
> +#include "light-lichee-module-4a.dtsi"
> +
> +/ {
> +       model =3D "Sipeed Lichee Pi 4A";
> +       compatible =3D "sipeed,lichee-pi-4a", "sipeed,lichee-module-4a", =
"thead,light";
no light, th1520
> +
> +       aliases {
> +               gpio0 =3D &gpio0;
> +               gpio1 =3D &gpio1;
> +               gpio2 =3D &gpio2;
> +               gpio3 =3D &gpio3;
> +               serial0 =3D &uart0;
> +               serial1 =3D &uart1;
> +               serial2 =3D &uart2;
> +               serial3 =3D &uart3;
> +               serial4 =3D &uart4;
> +               serial5 =3D &uart5;
> +       };
> +
> +       chosen {
> +               stdout-path =3D "serial0:115200n8";
> +       };
> +};
> +
> +&uart0 {
> +       status =3D "okay";
> +};
> --
> 2.40.0
>


--=20
Best Regards
 Guo Ren
