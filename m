Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F828715C9D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjE3LGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjE3LGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:06:44 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F12FF
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:06:39 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-510f525e06cso7545192a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685444798; x=1688036798;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JYFJ+H1VAY9LSysZ7K+45YdOSI8zV/BM4XST8evs3Lk=;
        b=GRaHLdJjqrz/j8TuJaGorsmpvVlJ/aJ8ZTKWe7B6d0ygiVJvNWPO97kbjZSe9OPY2z
         7fY5/TH8WkL5SRTPlFJg8Mxc5e/vIHfsTGYcXcANZILRSiAuzE1ua1lF8v65u+Vh9DZG
         I2obghP9lHIWQ08HFR6XlFh2vneQ+yMzfHbT5UXIe5aNUYAHN2jVxFFKjthrR+ovnCf6
         GF8A9g981k9sBfJnVAdDMH4YKMczM5mUjrbc0tiJjyqZ093jnizaiMWWEK4eVvClQT6u
         XyPrPim9jb/LT8aUqk0rpy51VsGYStIIuppcgYGnUAbjIXhKlUEtYYu+pj9CqayKU5fY
         xo2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685444798; x=1688036798;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JYFJ+H1VAY9LSysZ7K+45YdOSI8zV/BM4XST8evs3Lk=;
        b=K9Tk+KYNyfs/a08/Is7eJM/BkEE+0eNto9i9x6og8/KMJDdVhyoHVHSTS6N8nWkiQa
         7P7xSVce9AEHsDtbNk8/9Vv5wIH13Ff+mR+ovynKxw/YiJ9WTzarVe6YaykOdblAVNg5
         zdi4qONx4MC/JSEKT0Ty2vQ9EwgP/qyLDEsHeQZ3ysS70+m5KgRujgw750mEnGUbmH5F
         J5mX50ZNJZ23NuBHEK6MBMrVCWhUIhBRmW13jxYiQ79Z97XfGBwVG3SO91yiWJb9CQyf
         6UdiWMMI/z5e9DNx0cHHgSHPM4tzcLifkMmvRxG9U2q8YEoELbeWyZgjYQVdEBSAcnk8
         i0Yw==
X-Gm-Message-State: AC+VfDwZahvMHEP+COu5dhwTcaJ/0WzSOk4YS6iLYQr9f+tJNAhBBS7H
        ARfE6XjmmXQAxCGZbSmQzaAJxw==
X-Google-Smtp-Source: ACHHUZ64Q/ay65U65CSNrCAMOYDxWnNJb1JH1XN/eF5xsCwlNK2bd3s7+QCeYD7ZV7qF30UTRIgleA==
X-Received: by 2002:a17:907:9716:b0:94f:6218:191d with SMTP id jg22-20020a170907971600b0094f6218191dmr1989845ejc.32.1685444797753;
        Tue, 30 May 2023 04:06:37 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id j21-20020a17090686d500b00965a0f30fbfsm7143145ejy.186.2023.05.30.04.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 04:06:37 -0700 (PDT)
Message-ID: <ea6d31cc-68b2-3b73-ae12-dad122a85857@linaro.org>
Date:   Tue, 30 May 2023 13:06:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 12/13] arm64: dts: qcom: ipq5018: Add RDP432-c1 board
 support
Content-Language: en-US
To:     Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jassisinghbrar@gmail.com,
        mathieu.poirier@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, quic_eberman@quicinc.com, quic_mojha@quicinc.com,
        kvalo@kernel.org, loic.poulain@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com, quic_varada@quicinc.com,
        quic_devipriy@quicinc.com
References: <20230521222852.5740-1-quic_mmanikan@quicinc.com>
 <20230521222852.5740-13-quic_mmanikan@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230521222852.5740-13-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/2023 00:28, Manikanta Mylavarapu wrote:
> Add initial device tree support for the RDP432-C1 board.
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
> Changes in V2:
> 	- Renamed mp03.5-c1 to RDP432-c1
> 	- Removed boot-args
> 	- Resolved dt-binding error's
> 
>  arch/arm64/boot/dts/qcom/Makefile             |  1 +
>  .../arm64/boot/dts/qcom/ipq5018-rdp432-c1.dts | 49 +++++++++++++++++++
>  2 files changed, 50 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/ipq5018-rdp432-c1.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 259bd57c6064..bb9164de75b0 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -3,6 +3,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-ifc6640.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-rdp432-c1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-rdp432-c2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-mi01.2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp468.dtb
> diff --git a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c1.dts b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c1.dts
> new file mode 100644
> index 000000000000..7fe28d9859b0
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c1.dts
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
> +/*
> + * IPQ5018 RDP432-C1 board device tree source
> + *
> + * Copyright (c) 2023, The Linux Foundation. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "ipq5018.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. IPQ5018/AP-RDP432.1-C1";
> +	compatible = "qcom,ipq5018-rdp432-c1", "qcom,ipq5018";
> +
> +	aliases {
> +		serial0 = &blsp1_uart1;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&blsp1_uart1 {
> +	pinctrl-0 = <&uart1_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&q6v5_wcss {
> +	pd-2 {
> +		firmware-name = "IPQ5018/q6_fw.mdt";

Does not look like correct paths. Please open firmware and look there.
Or open other DTS files and check example. Missing qcom, lowercase,
that's minimum of fixes needed.

Best regards,
Krzysztof

