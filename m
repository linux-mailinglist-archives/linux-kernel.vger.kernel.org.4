Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367956035B3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 00:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiJRWPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 18:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJRWPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 18:15:18 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8B5804B5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 15:15:15 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 8so9639343qka.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 15:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o1+6PbWMEZLRW3S77WbnMQfGu4kXttl8N+DvVGyhW/Q=;
        b=qXT+UqSyXWVwTSLwYNr6KL7ccmG6J2dg7gP1KdS9CpARawmnb3SKus2CuK5galCDqN
         4aZwRaU6YS5f3KLZrf5diQ7vy2Fq9GQcf7UjWsU2BVLiK9aGGUuB5gxMrOjlzyQJgmhu
         rFRmzaE9s1c8DqlameY1ohQtQbIbBqTb4d90tQze3HcjGsqXv6tjAp5FTFinMbjjFjk6
         zdW4EgF3Z71vdk2vYJn9yGZ0tEDLWjxDcAMJR8F6+pWoSe8dfuMblokexVqFEL1pKfIV
         MxPwVxcer7zWYEBM7phARw4W2iIn891CEJSpksrIvDgsiJiZgRufBjgr0SWY/FekC2ru
         wIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o1+6PbWMEZLRW3S77WbnMQfGu4kXttl8N+DvVGyhW/Q=;
        b=UBEUsz9d4xyPp5qF546gwZwysfyC8PM+iOMVYWjW2ec15/eFrnVmRO8CSv7Zst/oXV
         KbIjWIo/App19q8L+RnuHiW8FuqdTFZtweSUsKtPxGXUjwpKpDoXAgTgJrjUjMNa9l4h
         F50EWZTYCPt8es/57nhhgnVv+mjtJu/NpLLnYm3chF5W5D350yMELmwUOu/yi6pzMTTq
         pJP3B9dpLTcDQiZ6UANS/x0iVEaKu5mquv/mjH8vz/dwQsnjSTSwg8M42rpxq5z7XDl8
         kx2uk9Zg8/2xmfgMK86wb0Zua9uHiFloGanjZtzWF1ISGaVzldsNybw2cOiYyEN9GtKS
         JCzQ==
X-Gm-Message-State: ACrzQf0kqhe7DOVPIHqO8ezzFe9JuveWnApYVhit2QEVmnwmwQvGBhis
        gdAfmwm4qUnMvf9qKigp3Pcl9Q==
X-Google-Smtp-Source: AMsMyM4n4rW3pBJps152lVMjljUvaNQKvWvMUkEy+3ZsuPxuuRReiqeSNaPp9WczWH/qLSv3ceSUvg==
X-Received: by 2002:a05:620a:1f3:b0:6e9:e33d:3bb6 with SMTP id x19-20020a05620a01f300b006e9e33d3bb6mr3518789qkn.115.1666131314216;
        Tue, 18 Oct 2022 15:15:14 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id s7-20020a05620a254700b006ec59941acasm3413120qko.11.2022.10.18.15.15.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 15:15:13 -0700 (PDT)
Message-ID: <d4158329-5a7a-c622-a8f8-ea2508b663c6@linaro.org>
Date:   Tue, 18 Oct 2022 18:15:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: Add base QDU1000/QRU1000 DTSIs
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221014221138.7552-1-quic_molvera@quicinc.com>
 <20221014221138.7552-3-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221014221138.7552-3-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2022 18:11, Melody Olvera wrote:
> Add the base DTSI files for QDU1000 and QRU1000 SoCs, including base
> descriptions of CPUs, GCC, RPMHCC, QUP, TLMM, and interrupt-controller
> to boot to shell with console on these SoCs.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qdu1000.dtsi | 1646 +++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/qru1000.dtsi |   27 +
>  2 files changed, 1673 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/qdu1000.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/qru1000.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> new file mode 100644
> index 000000000000..777734b30f56
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> @@ -0,0 +1,1646 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/qcom,gcc-qdu1000.h>
> +#include <dt-bindings/clock/qcom,rpmh.h>
> +#include <dt-bindings/dma/qcom-gpi.h>
> +#include <dt-bindings/interconnect/qcom,qdu1000.h>
> +#include <dt-bindings/power/qcom-rpmpd.h>
> +#include <dt-bindings/soc/qcom,rpmh-rsc.h>

As pointed out by kernel test robot, your patchset is unbuildable and
unmerge'able, so automated tools cannot test it.

Best regards,
Krzysztof

