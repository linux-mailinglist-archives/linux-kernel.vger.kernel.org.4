Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEA864DD49
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 16:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiLOPIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 10:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiLOPHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 10:07:50 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCEC303C5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 07:07:32 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id j4so16174795lfk.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 07:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OHEZTLvWgdyrOQot+L47psSwEWI47oL6dy58VC6SxRY=;
        b=gthgYGSob376qfygaieOqcwlKjC4cePcc5b5FCyW0N+L5ulTId+S+BrZ/sojLFWKqM
         0IZb9McMm4b1F/AxvVmvsk39QzfawRgq1rSvo78mqkEpxidMkHCB4y6s+NGckKP1oUDa
         ulziUNK9ERN2proroZBZtCRwf/P96LhWu4mrhIu1SeS/k61GoqJrdOaklVilQBIFbjR8
         dM8QKdQS9hgNmxx44xrAv0rlDwdD8glDIookd7N6s7KCuUDE0U6aTjeUBVOs/ijWLsGr
         bnPjSJUHSeRkfiUj88Q5hy8c/ngbZs8H72ymW2YvvJVEfgl463vZs3gY+d4dkBkY1Vgz
         8VMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OHEZTLvWgdyrOQot+L47psSwEWI47oL6dy58VC6SxRY=;
        b=SarP1Cxl7B2oL0hu2ZisFN0bCA+Tg75guoWMyN4L+YFm53JUWYkqQvKKKeFbaPPj88
         HJN7u0kymw+REPBmKFFmjjXC4Q+zz0TNoIWMmaNfQNaKdaAj/7HuY72bAMV5jZmDH305
         3+2+eChl8n3KehjMQ2syDlbgJMQsbVPOSIPhZBOs8haNB19cmz8AR4D0ZXTFlIzkcJIl
         ylViDnlP4wB4kLGsAAOMAI5lx1MJQH1g6mZ6ehH74k0I2+Bpq0/EL5G6oSYbeNn6Shj0
         2wNqSubmcCGgzRDODTIXvvsAQ6wzimtGaP5mQuwZ33YSAi/a0VjntXK084p98ewqrreo
         UVzg==
X-Gm-Message-State: ANoB5pk2g8CpLu4Bm6bwtRAmvdVoTOSb4mmC1lzT4OxtcfGtlF+/rNkw
        0UMO4kuW6rzxu4Mtt6B+bAqRqg==
X-Google-Smtp-Source: AA0mqf7yxuN7bC/Ylx9eWFYVUsuAAnC0ELx3Vb+9nC7Xd+WKKPZ8VSz/8PjGRYlM97Zqh9IJ6N/X2Q==
X-Received: by 2002:a05:6512:304b:b0:4b5:892:3987 with SMTP id b11-20020a056512304b00b004b508923987mr16424937lfb.9.1671116850313;
        Thu, 15 Dec 2022 07:07:30 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id k20-20020a0565123d9400b004abc977ad7fsm1175853lfv.294.2022.12.15.07.07.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 07:07:29 -0800 (PST)
Message-ID: <1c467305-15b2-5a0d-0312-f7241deae812@linaro.org>
Date:   Thu, 15 Dec 2022 17:07:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: Add base QDU1000/QRU1000 IDP DTs
Content-Language: en-GB
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221118192241.29384-1-quic_molvera@quicinc.com>
 <20221118192241.29384-3-quic_molvera@quicinc.com>
 <fed1d538-d133-6987-12d4-3f1516d519e5@linaro.org>
 <85b7060c-4f52-b8bf-cb19-29068a0a9083@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <85b7060c-4f52-b8bf-cb19-29068a0a9083@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 22/11/2022 00:15, Melody Olvera wrote:
> 
> 
> On 11/21/2022 5:07 AM, Konrad Dybcio wrote:
>>
>> On 18.11.2022 20:22, Melody Olvera wrote:
>>> Add DTs for Qualcomm IDP platforms using the QDU1000 and QRU1000
>>> SoCs.
>>>
>>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/Makefile        |   2 +
>>>   arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 266 +++++++++++++++++++++++
>>>   arch/arm64/boot/dts/qcom/qru1000-idp.dts | 266 +++++++++++++++++++++++
>>>   3 files changed, 534 insertions(+)
>>>   create mode 100644 arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>>>   create mode 100644 arch/arm64/boot/dts/qcom/qru1000-idp.dts
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>>> index afe496a93f94..da66d4a0a884 100644
>>> --- a/arch/arm64/boot/dts/qcom/Makefile
>>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>>> @@ -53,7 +53,9 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-maple.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-poplar.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
>>> +dtb-$(CONFIG_ARCH_QCOM)	+= qdu1000-idp.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5.dtb
>>> +dtb-$(CONFIG_ARCH_QCOM)	+= qru1000-idp.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)	+= sa8155p-adp.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)	+= sa8295p-adp.dtb
>>>   dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-idp.dtb
>>> diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>>> new file mode 100644
>>> index 000000000000..5aed483201fa
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>>> @@ -0,0 +1,266 @@
>>> +// SPDX-License-Identifier: BSD-3-Clause
>>> +/*
>>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>> +#include "qdu1000.dtsi"
>>> +#include "pm8150.dtsi"
>>> +
>>> +/ {
>>> +	model = "Qualcomm Technologies, Inc. QDU1000 IDP";
>>> +	compatible = "qcom,qdu1000-idp", "qcom,qdu1000";
>> Missing chassis-type
> 
> Sorry, not sure what you mean here... Do you mean like QRD, HDK, MTP, etc.?
> If so, then IDP is the chassis type.
> 
>>
>>> +
>>> +	aliases {
>>> +		serial0 = &uart7;
>>> +	};
>>> +
>>> +	clocks {
>>> +		xo_board: xo-board {
>>> +			compatible = "fixed-clock";
>>> +			clock-frequency = <19200000>;
>>> +			clock-output-names = "xo_board";
>>> +			#clock-cells = <0>;
>>> +		};
>>> +
>>> +		sleep_clk: sleep-clk {
>>> +			compatible = "fixed-clock";
>>> +			clock-frequency = <32000>;
>>> +			#clock-cells = <0>;
>>> +		};
>>> +
>>> +		pcie_0_pipe_clk: pcie-0-pipe-clk {
>>> +			compatible = "fixed-clock";
>>> +			clock-frequency = <1000>;
>>> +			clock-output-names = "pcie_0_pipe_clk";
>>> +			#clock-cells = <0>;
>>> +		};
>>> +
>>> +		pcie_0_phy_aux_clk: pcie-0-phy-aux-clk {
>>> +			compatible = "fixed-clock";
>>> +			clock-frequency = <1000>;
>>> +			clock-output-names = "pcie_0_phy_aux_clk";
>>> +			#clock-cells = <0>;
>>> +		};
>>> +
>>> +		usb3_phy_wrapper_pipe_clk: usb3-phy-wrapper-pipe-clk {
>>> +			compatible = "fixed-clock";
>>> +			clock-frequency = <1000>;
>>> +			clock-output-names = "usb3_phy_wrapper_pipe_clk";
>>> +			#clock-cells = <0>;
>>> +		};
>> Do these pipe clocks not come from QMPPHY?
> 
> Yes they do; I just don't have those phys ready yet. I can put a TODO here to
> move them if necessary.

Just use <0> instead of adding a dummy fixed clock.

-- 
With best wishes
Dmitry

