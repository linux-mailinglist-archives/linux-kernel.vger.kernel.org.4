Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E11D6AE51D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 16:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjCGPnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 10:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjCGPnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:43:07 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178474C6F1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 07:42:41 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id o12so53932464edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 07:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678203748;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nKbPV9YyzwEoURiQ5Syu76mPMf5NfvjzjZoG9q/fpuc=;
        b=ZYYbTBbB/Mc0eW2LXdXIe+N0imVEWyo4p+1nVoJemZEg+x9yOdsB0R5FVp/NLsiPeI
         SdsqTTEAQ0nNEoLKerGRTvV04NGKSR7SVFHF+QuIo6e33gME01Hvl/9h+2+YKt4c8qJX
         LRlQLKCoHmvMeMD5GjeejyEr6JzKeRVUIbx1rgWPKxGtIVZ6WEN+0jAAV5877yEUnTwH
         30gzLSr0lDynPnJgjSXpj1ouiw8+fPeE+us9CxuWDB7iYkLmxcw+uAsu7ugti8vMMrdx
         UeiQbLCk8eNxN5+nQAf/2eontmt401721IB3Q9l7dWCWidYVTcuBQmXYH7MFYnZTaqns
         zhyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678203748;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nKbPV9YyzwEoURiQ5Syu76mPMf5NfvjzjZoG9q/fpuc=;
        b=EbzvMi6KHcWRjiRf8j7pbcWSShMVlfWP18BH5TB5V7y1omiPYUzEt1qfzrp13Ppy6r
         cRTbzAbRDMZsjIdGQ+qaCtkDQ6scqn4JLikqcnJD6Oi1joeOz8O+UB1fsxnQd1JejEs1
         SR1TpUbCGEs1WJ5Wjd2TAuLcP4ajeM/NR7Yt9kfe6hCMRg51eGV9ECAHJm5dnrk+TsAu
         x253NZbfI175CGhHlfdMXXY/qUcv9M/DQ11xb1StymI9dPYh52Ksv+UeOsOL0RrSnqSO
         KmHFJI5PDFcjrT+CrVmB8YghpNzyOUnIL+4zMDc90F5u9ZTUfKHtOmK9cciB+wI7Xwa+
         dd6A==
X-Gm-Message-State: AO0yUKX2G+yqunRJjxMkwRC8ap7DHKViA0H51vXXSwswX5dSVW5TJ1QT
        iiQr7e8B6Y1g7/AhHb7Tt5S5SA==
X-Google-Smtp-Source: AK7set9H3uxbGXH0z/9LVklH+8o3JPieoNV1dGe4qV9g1Vl3MIy3Gh8od36XmMBOkPBPqBGBFOOP7g==
X-Received: by 2002:a05:6402:383:b0:4ad:1e35:771f with SMTP id o3-20020a056402038300b004ad1e35771fmr13140809edv.35.1678203747756;
        Tue, 07 Mar 2023 07:42:27 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:a60f:e604:c252:1f3d? ([2a02:810d:15c0:828:a60f:e604:c252:1f3d])
        by smtp.gmail.com with ESMTPSA id mj12-20020a170906af8c00b008b980c3e013sm6341194ejb.179.2023.03.07.07.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 07:42:27 -0800 (PST)
Message-ID: <69fdc094-aa1e-a696-1f62-e9287451976d@linaro.org>
Date:   Tue, 7 Mar 2023 16:42:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 10/11] arm64: dts: qcom: ipq5018: Add MP03.5-c1 board
 support
Content-Language: en-US
To:     Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, mathieu.poirier@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, quic_gurus@quicinc.com,
        loic.poulain@linaro.org, quic_eberman@quicinc.com,
        robimarko@gmail.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
References: <1678164097-13247-1-git-send-email-quic_mmanikan@quicinc.com>
 <1678164097-13247-11-git-send-email-quic_mmanikan@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1678164097-13247-11-git-send-email-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2023 05:41, Manikanta Mylavarapu wrote:
> Add initial device tree support for the MP03.5-C1 board.
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |  1 +
>  .../arm64/boot/dts/qcom/ipq5018-mp03.5-c1.dts | 64 +++++++++++++++++++
>  2 files changed, 65 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/ipq5018-mp03.5-c1.dts
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index b77a95e97a56..10d1eafe57e4 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -4,6 +4,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-ifc6640.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-mp03.1-c2.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-mp03.5-c1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq6018-cp01-c1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk01.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c1.dtb
> diff --git a/arch/arm64/boot/dts/qcom/ipq5018-mp03.5-c1.dts b/arch/arm64/boot/dts/qcom/ipq5018-mp03.5-c1.dts
> new file mode 100644
> index 000000000000..51ddd7367ac6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/ipq5018-mp03.5-c1.dts
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
> +/*
> + * IPQ5018 CP01 board device tree source
> + *
> + * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "ipq5018.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. IPQ5018/AP-MP03.5-C1";
> +	compatible = "qcom,ipq5018-mp03.5-c1", "qcom,ipq5018";
> +
> +	aliases {
> +		serial0 = &blsp1_uart1;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyMSM0,115200,n8 rw init=/init swiotlb=1 coherent_pool=2M";

Not a common DT property. Drop.

> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&tlmm {
> +	blsp0_uart_pins: uart_pins {

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

I'll stop the review. Please first run tests.



Best regards,
Krzysztof

