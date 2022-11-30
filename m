Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D665563CFAE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 08:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbiK3HZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 02:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiK3HZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 02:25:35 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662C65B85E;
        Tue, 29 Nov 2022 23:25:34 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id BF5F332008FE;
        Wed, 30 Nov 2022 02:25:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 30 Nov 2022 02:25:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1669793132; x=
        1669879532; bh=7jCQGR0xy6Fkh672DFHxOw50RlZJiRPWysOecK1wOw8=; b=k
        aMSJfphW6+/085SOqXaR1v5j3gYqHdwXRO3UWXeqKm0sI22YTLVg1zZxu4q8Mian
        NBoZ/YmBEuYu2d4eisUFlVx0ZOmJXhhwaoYIsgp/99BwYb+Vor9m2Ffi7Hk/r4U9
        SxtngMe+h013xAkljyl+0ovCGZkZ42y9MCss/iUzxd1YRPpSM7XgIvbdUcuHwrOV
        r4f/Lr3ZWBDr+w8vTMU3H8z/islNut8v8E6jntzUqh403U4PDeF6Sxes74y4V9R+
        wFueQVLNh+sc7iZ58oQwE8mhNH1VMx54n8KzhYPV9s+bzaYWb2lTUf8TyS5Mg85x
        DUVu7mTp8vE0OYfXcNInw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669793132; x=
        1669879532; bh=7jCQGR0xy6Fkh672DFHxOw50RlZJiRPWysOecK1wOw8=; b=Z
        f7Fw9YpciDY0tKXZmMdllDr3lTxLjh1f3gANVehv7WIvTk0Oo7rcD0IfFVjOSodP
        1rgPCzcif5rQGPtDoP/ZDlLKUPQe0C19R/CM4SuLiQWLVeCu/dyI2lN0ebpJXYpZ
        Xd8JxtOd5yg8pDVin3Nc3SDlni8baJtffS0mRmLgJGXMicKfaZwyMjVFCUBGk65q
        gZH3guPITWL/0BY9nXmied32Yky3J4/l3AMsHerwCPcrsd4npfrUPrl8PqjxPSQg
        FmXMGn6A/GdXKAiMiFhSWsabm93o+YY6SsaKlwmMXi0q3LoWx4IEYn9n1+osL306
        L8g/SUdzpuLqgHDyR7pHg==
X-ME-Sender: <xms:awWHYwtXr7G608ybY4KEM1S8_Pp4UiYRiF89zHNbX-jVt9DE_qy8cA>
    <xme:awWHY9cN9j8EWtukGNQGjF-tiwVdR9x3q090LNeq8pGhqsuUjFYbzVn6kcI19G8WR
    8CvXHNtu9g5IlwEvA>
X-ME-Received: <xmr:awWHY7xmx3dP7lnpCvcaqk-hhIZN8MuwqaIDOKTzNmoaMNfG-51lsB36Ut1Sun3rLOG3VEDdcTEyHKWeElTfTtXiodkVDIU3EzTYaD1y6bzocP_lHVtD7auPxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtddvgddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeekjeelleefiedthfdtgfekgeehudefudeugeffvdfhudekleel
    fedtteejhedutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:awWHYzMSZyjHp1FBAhPdwa80yMTvWE6Du6GfryRjoCm1WOsYavgIxg>
    <xmx:awWHYw9WhAsKWrDpe-CWa42Vjk4Yc7Sq9Y5CL4ykausET5npobLEFw>
    <xmx:awWHY7W6ZKVwOu7qM_AhZrj71OI2rt6It3KQKRwkhvA933xTLraHng>
    <xmx:bAWHY7WCfNQvf4xaRNoPuUVmmKkIR9MO97xIw9rQ_b1I7AJ-WSn9uA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Nov 2022 02:25:31 -0500 (EST)
Message-ID: <91d7eebd-7433-c06d-6d14-a01d11af9df9@sholland.org>
Date:   Wed, 30 Nov 2022 01:25:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 7/9] riscv: dts: bouffalolab: add Sipeed M1s SoM and
 Dock devicetree
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20221127132448.4034-1-jszhang@kernel.org>
 <20221127132448.4034-8-jszhang@kernel.org>
From:   Samuel Holland <samuel@sholland.org>
In-Reply-To: <20221127132448.4034-8-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/22 07:24, Jisheng Zhang wrote:
> Sipeed manufactures a M1s system-on-module and dock board, add basic
> support for them.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/boot/dts/Makefile                  |  1 +
>  arch/riscv/boot/dts/bouffalolab/Makefile      |  2 ++
>  .../dts/bouffalolab/bl808-sipeed-m1s-dock.dts | 25 +++++++++++++++++++
>  .../dts/bouffalolab/bl808-sipeed-m1s.dtsi     | 21 ++++++++++++++++
>  4 files changed, 49 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/bouffalolab/Makefile
>  create mode 100644 arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s-dock.dts
>  create mode 100644 arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s.dtsi
> 
> diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
> index ff174996cdfd..b525467152b2 100644
> --- a/arch/riscv/boot/dts/Makefile
> +++ b/arch/riscv/boot/dts/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> +subdir-y += bouffalolab
>  subdir-y += sifive
>  subdir-y += starfive
>  subdir-$(CONFIG_SOC_CANAAN_K210_DTB_BUILTIN) += canaan
> diff --git a/arch/riscv/boot/dts/bouffalolab/Makefile b/arch/riscv/boot/dts/bouffalolab/Makefile
> new file mode 100644
> index 000000000000..5419964e892d
> --- /dev/null
> +++ b/arch/riscv/boot/dts/bouffalolab/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_SOC_BOUFFALOLAB) += bl808-sipeed-m1s-dock.dtb
> diff --git a/arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s-dock.dts b/arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s-dock.dts
> new file mode 100644
> index 000000000000..c6b4894a7b88
> --- /dev/null
> +++ b/arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s-dock.dts
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (C) 2022 Jisheng Zhang <jszhang@kernel.org>
> + */
> +
> +/dts-v1/;
> +
> +#include "bl808-sipeed-m1s.dtsi"
> +
> +/ {
> +	model = "Sipeed M1s Dock";
> +	compatible = "sipeed,m1s-dock", "sipeed,m1s", "bouffalolab,bl808";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:2000000n8";
> +	};
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> diff --git a/arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s.dtsi b/arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s.dtsi
> new file mode 100644
> index 000000000000..5026de768534
> --- /dev/null
> +++ b/arch/riscv/boot/dts/bouffalolab/bl808-sipeed-m1s.dtsi
> @@ -0,0 +1,21 @@
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
> +	compatible = "sipeed,m1s", "bouffalolab,bl808";
> +
> +	memory@50000000 {
> +		device_type = "memory";
> +		reg = <0x50000000 0x04000000>;
> +	};

The PSRAM is part of the BL808, so this should go in the SoC .dtsi file.
(Unless I'm missing something and there are BL808 variants with
different amounts of memory. The PSRAM init code in the SDK does size
detection, so I suppose it is possible.)

Regards,
Samuel

> +};
> +
> +&xtal {
> +	clock-frequency = <40000000>;
> +};

