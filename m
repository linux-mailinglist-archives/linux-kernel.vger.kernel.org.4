Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F8C6A9165
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 08:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjCCHDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 02:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCCHC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 02:02:59 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3984555B0
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 23:02:58 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id a25so6775352edb.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 23:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677826976;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SS0pZtOXOCGsRpwT2/LH/98sjAzBtNRBQ/GVmHS+K8M=;
        b=i3ks/kDAv8EabEjfJk5skrkV5kgK09F1+JDqq5gGixIHL65aAoT/XDlXrErPqsX7pK
         VAR3Z+nNky2f7A7QQZcfLLYS2USwnw/CJqjWpDtiY9wTySt1Rgo1KTk/AvB9qwBCIn2Q
         Cibve5sdaWR15dLdmtOcpEB4tPvp+s873vwz1D0Md4gHynRxNsxwHA8aqCiwvQSAqcr2
         98syev9fmu0m8q/X2q3ijfG3HZOQSm0VsZt0N92kLGtOHUsGDonFYQggLjqhHMlWm7pr
         sklSAT7dwtujXR99xO0A+j6+u0imCQu8pCM+YN3dWfEgvyNJwvEhBNaycMT15samIfTE
         Wwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677826976;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SS0pZtOXOCGsRpwT2/LH/98sjAzBtNRBQ/GVmHS+K8M=;
        b=uFSQ/I1ruPVKWE+1sfoXIphWmcFupoX2MnxgSzz8BC6apxdk/yweRn3qc/ie/e/wfO
         0YYxAUKIZ6TpkWLXy3rmiuT8CUyQCxEwNwQm4XBgmCbQL475R58+ZvFyRT+1AVXF4GZd
         Io90vn5by5gOQuKv1LdknV+CdO2yK7Uo4vo1IVHSvGpVyHy7v+VgCgarmB6lXdJRzL52
         VuJyTvOpqzEJpZrnAMwU5LzSi37MBGFeamfMLJV12vL1Od6hZmM+N2tWhmP7aUl4sIoc
         k3xKjje43TdF1bwR+IXFLWFXJtm95M/me5QnU792wPKNOBplEZGBxjfmmOe667mO99OX
         2Lqg==
X-Gm-Message-State: AO0yUKUv3Ew1FBqR0QV0Aaw1HfZqPH0qLDkHtUtBz/VC+X+sCdUK6od1
        TtwSSeiDz4sp5T6CIL2LXzgJPA==
X-Google-Smtp-Source: AK7set/tMa38FXOV2npPtA2knaAbce5U81AM4X6wzByfio4vR+xTOVhyLCP2XdEogoz4q2JS276toQ==
X-Received: by 2002:a17:906:6a1e:b0:8b1:fc58:a4ad with SMTP id qw30-20020a1709066a1e00b008b1fc58a4admr886969ejc.11.1677826976663;
        Thu, 02 Mar 2023 23:02:56 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id hy3-20020a1709068a6300b008e57b5e0ce9sm609319ejc.108.2023.03.02.23.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 23:02:56 -0800 (PST)
Message-ID: <0ea5f080-6c99-0243-1ac2-0182d9a83aad@linaro.org>
Date:   Fri, 3 Mar 2023 08:02:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/7] ARM: dts: nuvoton: Add Quanta GSZ BMC Device Tree
Content-Language: en-US
To:     David Wang <tomato1220@gmail.com>, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        fran.hsu@quantatw.com, David Wang <davidwang@quantatw.com>
References: <20230303063435.803097-1-davidwang@quantatw.com>
 <20230303063435.803097-2-davidwang@quantatw.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230303063435.803097-2-davidwang@quantatw.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2023 07:34, David Wang wrote:
> Add the device tree for the Quanta GSZ BMC and it's
> based on NPCM730 SoC
> 
> Signed-off-by: David Wang <davidwang@quantatw.com>


> +};
> diff --git a/arch/arm/boot/dts/nuvoton-npcm730-gsz.dts b/arch/arm/boot/dts/nuvoton-npcm730-gsz.dts
> new file mode 100644
> index 000000000000..c9f11880ef6d
> --- /dev/null
> +++ b/arch/arm/boot/dts/nuvoton-npcm730-gsz.dts
> @@ -0,0 +1,1523 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (c) 2021 Quanta Computer Inc. Fran.Hsu@quantatw.com
> +
> +/dts-v1/;
> +#include "nuvoton-npcm730.dtsi"
> +#include "nuvoton-npcm730-gsz-gpio.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/i2c/i2c.h>
> +
> +/ {
> +	model = "Quanta GSZ Board (Device Tree v01.10)";
> +	compatible = "nuvoton,npcm750";

Same problems.

> +
> +	aliases {
> +		serial0 = &serial0;
> +		serial1 = &serial1;
> +		serial2 = &serial2;
> +		serial3 = &serial3;
> +		udc5 = &udc5;
> +		udc6 = &udc6;
> +		udc7 = &udc7;
> +		udc8 = &udc8;
> +		emmc0 = &sdhci0;
> +		i2c0 = &i2c0;
> +		i2c1 = &i2c1;
> +		i2c2 = &i2c2;
> +		i2c3 = &i2c3;
> +		i2c4 = &i2c4;
> +		i2c5 = &i2c5;
> +		i2c6 = &i2c6;
> +		i2c7 = &i2c7;
> +		i2c8 = &i2c8;
> +		i2c9 = &i2c9;
> +		i2c10 = &i2c10;
> +		i2c11 = &i2c11;
> +		i2c12 = &i2c12;
> +		i2c13 = &i2c13;
> +		i2c14 = &i2c14;
> +		fiu0 = &fiu0;
> +		fiu1 = &fiu3;
> +		i2c16 = &i2c_9SQ440NQQI8;
> +		i2c17 = &i2c_db2001;
> +		i2c18 = &i2c_db1200;
> +		i2c19 = &i2c_io_exp_1;
> +		i2c20 = &i2c_cpu0_pirom;
> +		i2c21 = &i2c_cpu1_pirom;
> +		i2c22 = &i2c_ncsi_clk;
> +		i2c23 = &i2c_m2;
> +		i2c24 = &i2c_fivra_cpu0;
> +		i2c25 = &i2c_fivra_cpu1;
> +		i2c26 = &i2c_vccfa_cpu0;
> +		i2c27 = &i2c_vccfa_cpu1;
> +		i2c28 = &i2c_vccd_cpu0;
> +		i2c29 = &i2c_vccd_cpu1;
> +		i2c30 = &i2c_hotswap;
> +		i2c31 = &i2c_tps_1;
> +		i2c32 = &i2c_p12v_1;
> +		i2c33 = &i2c_p12v_2;
> +		i2c34 = &i2c_fan_controller_1;
> +		i2c35 = &i2c_i2cool_1;
> +		i2c36 = &i2c_i2cool_2;
> +		i2c37 = &i2c_i2cool_3;
> +		i2c38 = &i2c_seq_mobo;
> +		i2c39 = &i2c_fru_2;
> +		i2c40 = &i2c_io_exp_2;
> +		i2c41 = &i2c_io_exp_3;
> +		i2c43 = &i2c_fru_3;
> +		i2c44 = &i2c_seq;
> +		i2c45 = &i2c_fru_1;
> +		i2c46 = &i2c_tang;
> +		i2c51 = &i2c_pe0_0;
> +		i2c52 = &i2c_pe0_1;
> +		i2c53 = &i2c_pe0_2;
> +		i2c54 = &i2c_pe1_0;
> +		i2c55 = &i2c_pe1_1;
> +		i2c56 = &i2c_pe1_2;
> +		i2c57 = &i2c_pe2_0;
> +		i2c58 = &i2c_pe2_1;
> +		i2c59 = &i2c_pe2_2;
> +		i2c60 = &i2c_pe3_0;
> +		i2c61 = &i2c_pe3_1;
> +		i2c62 = &i2c_pe3_2;
> +		i2c63 = &i2c_pe4_0;
> +		i2c64 = &i2c_pe4_1;
> +		i2c65 = &i2c_pe4_2;
> +		i2c66 = &i2c_pe5_0;
> +		i2c67 = &i2c_pe5_1;
> +		i2c68 = &i2c_pe5_2;
> +		i2c69 = &i2c_pe6_0;
> +		i2c70 = &i2c_pe6_1;
> +		i2c71 = &i2c_pe6_2;
> +		i2c72 = &i2c_pe7_0;
> +		i2c73 = &i2c_pe7_1;
> +		i2c74 = &i2c_pe7_2;
> +	};
> +
> +	chosen {
> +		stdout-path = &serial3;
> +	};
> +
> +	memory {
> +		reg = <0 0x40000000>;
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		efuse-pg {

and all my other comments also apply...



Best regards,
Krzysztof

