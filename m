Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437FD722466
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjFELQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjFELQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:16:51 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E45ED
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 04:16:44 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f623adec61so48218275e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 04:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20221208.gappssmtp.com; s=20221208; t=1685963801; x=1688555801;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yjLDTJGJ7gcKQe6cRrz0+RPM8MdVynP8SzGMRz6EXRE=;
        b=yupI5Hyr8/63VXtONk7KEtUcvaNRATnn2q61utrbyqFJkpfSmIGnO4QQo5xCMAk73e
         c+8P6fMQWbKsb/RZvj4F6mSXgsg7ekLhz+pLHxO5j37eVNQoMj+F47OckwOvEJMkjSGt
         Yup9bYX42yTiDX1eYG0E+gaQYEsbS0u8TB8cz53FSRo/o5VMyKfbHX4sk2eQ2rZ/AYH7
         3EhdJnez+br/Y8p76XdyNtS5ckvhiRprmY+RiRjJCyZKTntFHzdXc+aix6FNVRzq2pEu
         RFMQGcwG7ue3Y6xB5/vlTJC4GTTeNtuJk56li4MHmAMXiE7/pszMblLRTt9mrnYlKqEh
         eWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685963801; x=1688555801;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yjLDTJGJ7gcKQe6cRrz0+RPM8MdVynP8SzGMRz6EXRE=;
        b=Yqh6hJTSe4+cZ+c1RfEpiCdOJdGe9zFZNs0x7rcpf6H2GTc6xWAYQ04BbYpXZZf8th
         LxwlsU29R268IUOLtpTv/YXuqUEls1jgKVFtjANGS4eSKo+Oxl7DtDf8BvIQgoW9d1N9
         WnnS8zchBo3R1zCb9D5EuaJ2LEJkH+uQbkV9VQyxVZDA6JlfLU3hPkFZOzDJEqj5dEQi
         2u/b4+fjU0O7PwPZfKdvFRz9F1n2fCeyAkTEwR+9/zXsOTroE1VNNmNXdki370Y82yG5
         oonjWS4AinkEhMtZvIsmzfO9TvFA4PXbn9BeL0qc0ExXUUmnDRMIcIXSozfHXOn2DAPx
         E04A==
X-Gm-Message-State: AC+VfDwhELl/RGZ003jK6mD5+4mOFr6j6X1V9i1pXMLzz24s0/AwfsdV
        NEd8+Gtw/N71ZQR3JwKa3gKPiCRJYHJydX7WVXhmNQ==
X-Google-Smtp-Source: ACHHUZ6uCGF9jDQfSvX2LlSatKK2oefzLJvDA+ZIb32oU5nr1ALsg6A2Fyt1pUEb+UEnCs77l6hZPw==
X-Received: by 2002:a1c:7411:0:b0:3f6:89a:94c8 with SMTP id p17-20020a1c7411000000b003f6089a94c8mr7325660wmc.24.1685963801713;
        Mon, 05 Jun 2023 04:16:41 -0700 (PDT)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05600c3c9600b003f4283f5c1bsm26464337wmb.2.2023.06.05.04.16.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 04:16:40 -0700 (PDT)
Message-ID: <5fdd9d89-4636-8e43-5dd7-55bbbdcae7e0@monstr.eu>
Date:   Mon, 5 Jun 2023 13:16:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 6/6] arm64: zynqmp: Used fixed-partitions for QSPI in
 k26
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1684767562.git.michal.simek@amd.com>
 <7368dc772d8dc29477a880ac2065e2ecb98cf3f5.1684767562.git.michal.simek@amd.com>
From:   Michal Simek <monstr@monstr.eu>
In-Reply-To: <7368dc772d8dc29477a880ac2065e2ecb98cf3f5.1684767562.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/22/23 16:59, Michal Simek wrote:
> Using fixed partitions is recommended way how to describe QSPI. Also add
> label for qspi flash memory to be able to reference it in future.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> (no changes since v1)
> 
> ---
>   .../boot/dts/xilinx/zynqmp-sm-k26-revA.dts    | 169 +++++++++---------
>   1 file changed, 88 insertions(+), 81 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> index 84e18fdce775..dfd1a18f5a10 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> @@ -127,87 +127,94 @@ spi_flash: flash@0 { /* MT25QU512A */
>   		spi-tx-bus-width = <4>;
>   		spi-rx-bus-width = <4>;
>   		spi-max-frequency = <40000000>; /* 40MHz */
> -		partition@0 {
> -			label = "Image Selector";
> -			reg = <0x0 0x80000>; /* 512KB */
> -			read-only;
> -			lock;
> -		};
> -		partition@80000 {
> -			label = "Image Selector Golden";
> -			reg = <0x80000 0x80000>; /* 512KB */
> -			read-only;
> -			lock;
> -		};
> -		partition@100000 {
> -			label = "Persistent Register";
> -			reg = <0x100000 0x20000>; /* 128KB */
> -		};
> -		partition@120000 {
> -			label = "Persistent Register Backup";
> -			reg = <0x120000 0x20000>; /* 128KB */
> -		};
> -		partition@140000 {
> -			label = "Open_1";
> -			reg = <0x140000 0xC0000>; /* 768KB */
> -		};
> -		partition@200000 {
> -			label = "Image A (FSBL, PMU, ATF, U-Boot)";
> -			reg = <0x200000 0xD00000>; /* 13MB */
> -		};
> -		partition@f00000 {
> -			label = "ImgSel Image A Catch";
> -			reg = <0xF00000 0x80000>; /* 512KB */
> -			read-only;
> -			lock;
> -		};
> -		partition@f80000 {
> -			label = "Image B (FSBL, PMU, ATF, U-Boot)";
> -			reg = <0xF80000 0xD00000>; /* 13MB */
> -		};
> -		partition@1c80000 {
> -			label = "ImgSel Image B Catch";
> -			reg = <0x1C80000 0x80000>; /* 512KB */
> -			read-only;
> -			lock;
> -		};
> -		partition@1d00000 {
> -			label = "Open_2";
> -			reg = <0x1D00000 0x100000>; /* 1MB */
> -		};
> -		partition@1e00000 {
> -			label = "Recovery Image";
> -			reg = <0x1E00000 0x200000>; /* 2MB */
> -			read-only;
> -			lock;
> -		};
> -		partition@2000000 {
> -			label = "Recovery Image Backup";
> -			reg = <0x2000000 0x200000>; /* 2MB */
> -			read-only;
> -			lock;
> -		};
> -		partition@2200000 {
> -			label = "U-Boot storage variables";
> -			reg = <0x2200000 0x20000>; /* 128KB */
> -		};
> -		partition@2220000 {
> -			label = "U-Boot storage variables backup";
> -			reg = <0x2220000 0x20000>; /* 128KB */
> -		};
> -		partition@2240000 {
> -			label = "SHA256";
> -			reg = <0x2240000 0x40000>; /* 256B but 256KB sector */
> -			read-only;
> -			lock;
> -		};
> -		partition@2280000 {
> -			label = "Secure OS Storage";
> -			reg = <0x2280000 0x20000>; /* 128KB */
> -		};
> -		partition@22A0000 {
> -			label = "User";
> -			reg = <0x22A0000 0x1d60000>; /* 29.375 MB */
> +
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			partition@0 {
> +				label = "Image Selector";
> +				reg = <0x0 0x80000>; /* 512KB */
> +				read-only;
> +				lock;
> +			};
> +			partition@80000 {
> +				label = "Image Selector Golden";
> +				reg = <0x80000 0x80000>; /* 512KB */
> +				read-only;
> +				lock;
> +			};
> +			partition@100000 {
> +				label = "Persistent Register";
> +				reg = <0x100000 0x20000>; /* 128KB */
> +			};
> +			partition@120000 {
> +				label = "Persistent Register Backup";
> +				reg = <0x120000 0x20000>; /* 128KB */
> +			};
> +			partition@140000 {
> +				label = "Open_1";
> +				reg = <0x140000 0xC0000>; /* 768KB */
> +			};
> +			partition@200000 {
> +				label = "Image A (FSBL, PMU, ATF, U-Boot)";
> +				reg = <0x200000 0xD00000>; /* 13MB */
> +			};
> +			partition@f00000 {
> +				label = "ImgSel Image A Catch";
> +				reg = <0xF00000 0x80000>; /* 512KB */
> +				read-only;
> +				lock;
> +			};
> +			partition@f80000 {
> +				label = "Image B (FSBL, PMU, ATF, U-Boot)";
> +				reg = <0xF80000 0xD00000>; /* 13MB */
> +			};
> +			partition@1c80000 {
> +				label = "ImgSel Image B Catch";
> +				reg = <0x1C80000 0x80000>; /* 512KB */
> +				read-only;
> +				lock;
> +			};
> +			partition@1d00000 {
> +				label = "Open_2";
> +				reg = <0x1D00000 0x100000>; /* 1MB */
> +			};
> +			partition@1e00000 {
> +				label = "Recovery Image";
> +				reg = <0x1E00000 0x200000>; /* 2MB */
> +				read-only;
> +				lock;
> +			};
> +			partition@2000000 {
> +				label = "Recovery Image Backup";
> +				reg = <0x2000000 0x200000>; /* 2MB */
> +				read-only;
> +				lock;
> +			};
> +			partition@2200000 {
> +				label = "U-Boot storage variables";
> +				reg = <0x2200000 0x20000>; /* 128KB */
> +			};
> +			partition@2220000 {
> +				label = "U-Boot storage variables backup";
> +				reg = <0x2220000 0x20000>; /* 128KB */
> +			};
> +			partition@2240000 {
> +				label = "SHA256";
> +				reg = <0x2240000 0x40000>; /* 256B but 256KB sector */
> +				read-only;
> +				lock;
> +			};
> +			partition@2280000 {
> +				label = "Secure OS Storage";
> +				reg = <0x2280000 0x20000>; /* 128KB */
> +			};
> +			partition@22A0000 {
> +				label = "User";
> +				reg = <0x22A0000 0x1d60000>; /* 29.375 MB */
> +			};
>   		};
>   	};
>   };

Applied.
M

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs

