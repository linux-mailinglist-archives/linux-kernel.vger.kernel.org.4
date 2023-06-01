Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBDC71F0C5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjFAR32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbjFAR3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:29:15 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D70F197
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 10:29:12 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-514953b3aa6so1665138a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 10:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685640551; x=1688232551;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2nRorulo8l9EWqetty+54wVsnkEP1yOUP1LrEre/GnQ=;
        b=ZNaeDBePrijnAElVBQ70atFd37aVdE47rydLEHYNyifXkzCPL247d7TEJPDjDGGXAO
         sZaWcSxhWyQjuh8BYSmy4I2kKn5mDsvdRCoDD+lOdVWgzCd9TuNhYs9EDYRPQhgf2BTf
         ocuEq3uzLnZ6/pdQb7oDhc+n7jtx6OBMnAF3xUNkGHa89g+TOMp6O/mRnkebxMeU32u7
         X7j/XdXvik8OD8dObfY6xQNIySWp7rSNA+Js1NvxzqvqBPzaQRLO6gh5Ti5/MhHlcqhk
         660xq9cogGn1aA5Cc5xrS2cj88dp7scn77xrN4mnS1LZ3Cv2/MpY1Db+pKuHokJ32aoD
         T55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685640551; x=1688232551;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2nRorulo8l9EWqetty+54wVsnkEP1yOUP1LrEre/GnQ=;
        b=ioHADDroP6/54RUj/p5z2qiiZiRrnBtHt2DNs5quSPsGPu/wsFrOCZEbktP/cCpPgn
         jR5AInvI69M4sL/lKh2F480FoTeo98yNFM05xp2/lcWACRTHQHM4qZu+oahn+a6M5j4k
         G5KJIy7Byi+hDwpPX858tgmYvIz8QoZD5j2VvdjrqqSZ5Tfk1rNq+A6wHtOzvsZ/hfST
         XhPohvKd0yNqzYyoAgP22tX6TgA97/oCrOEoQP1sebTQn6sdAOqkW49Cr08vBvLAa9no
         XcAZJ/IK253YNKIptre0r89pZKDbpS0yErW8O8ornW1fveuIiMCNCaZKsQmoQBY8WHp3
         wzbA==
X-Gm-Message-State: AC+VfDw6W4GpfFuG6bTu4K/2NMN4ORiXhrX+bv0VftsWLugWKZ+cOOMW
        wsvo9u9bS/CTLSJVSP8zBd84Tw==
X-Google-Smtp-Source: ACHHUZ5Yvq39R/qxe719VElY83GsQ1v9v78v05/3uOknrDrOSQXOj4f+KY630fwb9VORCGNeuTwwbg==
X-Received: by 2002:a17:907:6e8a:b0:96b:559d:ff19 with SMTP id sh10-20020a1709076e8a00b0096b559dff19mr10617053ejc.21.1685640550938;
        Thu, 01 Jun 2023 10:29:10 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id bx16-20020a170906a1d000b0096607baaf19sm10794646ejb.101.2023.06.01.10.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 10:29:10 -0700 (PDT)
Message-ID: <91c63634-eb39-fdca-2c76-6f8182c2d47c@linaro.org>
Date:   Thu, 1 Jun 2023 19:29:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RESEND 4/4] arm64: dts: qcom: ipq5332: add support for the
 RDP474 variant
Content-Language: en-US
To:     Kathiravan T <quic_kathirav@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230601042054.29075-1-quic_kathirav@quicinc.com>
 <20230601042054.29075-5-quic_kathirav@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230601042054.29075-5-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2023 06:20, Kathiravan T wrote:
> Add the initial device tree support for the Reference Design
> Platform(RDP) 474 based on IPQ5332 family of SoC. This patch carries
> the support for Console UART, eMMC, I2C and GPIO based buttons.
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile           |   1 +
>  arch/arm64/boot/dts/qcom/ipq5332-rdp474.dts | 112 ++++++++++++++++++++
>  2 files changed, 113 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/ipq5332-rdp474.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 4f9e81253e18..0f8c763a9bd9 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -7,6 +7,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-ifc6640.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-mi01.2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp442.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp468.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp474.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq6018-cp01-c1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk01.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c1.dtb
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp474.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp474.dts
> new file mode 100644
> index 000000000000..085729a0fdf1
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp474.dts
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * IPQ5332 RDP474 board device tree source
> + *
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include "ipq5332.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. IPQ5332 MI01.9";
> +	compatible = "qcom,ipq5332-ap-mi01.9", "qcom,ipq5332";
> +
> +	aliases {
> +		serial0 = &blsp1_uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0";
> +	};
> +
> +	gpio_keys {

No, srsly, so not only ignored the tags but also feedback?

Best regards,
Krzysztof

