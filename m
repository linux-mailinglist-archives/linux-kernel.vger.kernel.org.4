Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B98651514
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 22:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbiLSVqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 16:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbiLSVqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 16:46:11 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00F06572
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 13:46:06 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id f34so532765lfv.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 13:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XB6cREulQAxqSm/nFa6k4wjD6bFB02amrV76mX+yCIs=;
        b=XxoN9bRVvG18VXJeePFuxyk1L13yeJxtTlVRlH+RXOWKsZxCpJ2AAHvgl8VQ+UnsoC
         1qhE0iFe0yCXrI++jKmPTPNLuJ+tjfnW0iIi4+rjTMjgEOEtm4IXF4zB7wSoFxAQd4Wc
         Hp/IlT0TrSVrfecF4KnZZrzzQYI37AUQf9wQbS2Tr6CeIM9XxXt1agMGXbnY0i7YpK9T
         grYk0E+YNwT9L043+5ME2Oo8Q6rJWz4tpFZ8I6cRp4PF0dX8alA5WqX/0fqqw8RqcuVP
         uR0eDUunFyal/u53Y2zju3Swu2EDFsi69XnH/zhUK5zqZk9TvRgVWpZK1cRcu/onlyNN
         GlOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XB6cREulQAxqSm/nFa6k4wjD6bFB02amrV76mX+yCIs=;
        b=TfLXJdgCHrdj7llbPd5dZ5m4ombShq/KqQvRAwLAsvSPS1w4j4PIaLYNEHgb8rIGQD
         W7lNlN042pSQ3MISjUr1cswpsTn5w0/Qqo1u7x1eukskLx+VcnqTJA6Opndmx9YMH93g
         p1HUoC7zmMFrbW75h8lieeMZB/vzIzA8u+FCY1H1h7i13MGaDBqOGSqvN1Kbd3LWa1Fa
         js1NsKzMrvHcCVIbaQoGiARLUxZ+E1YXBaBzHovnaVoV4avN2NHdVOWk1Veth/vN6ht6
         UYXQ1IsvMJHc3Xz01k1PKOeTPadUMkWve36KnABQ/jgbs8KyZJlyqJmzecxXVTqQZ4He
         ut+w==
X-Gm-Message-State: ANoB5pl7rptptpiGBbvWwy/Qo3eQZ0PyeZWs0ODMrgo4/w7OW2QEyFAw
        kfhsc6Qvy3wWQsJZHhT0yg9KfQ==
X-Google-Smtp-Source: AA0mqf598/MCF/JjEFs4sytej/bZyytsruYpkdumZTQtJfjYvaqHK4GOJ3jxcNm12jWpnEvG729kiQ==
X-Received: by 2002:a05:6512:304b:b0:4b5:892:3987 with SMTP id b11-20020a056512304b00b004b508923987mr24595255lfb.9.1671486365267;
        Mon, 19 Dec 2022 13:46:05 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id a12-20020a056512200c00b004b700ba3cf3sm1205396lfb.203.2022.12.19.13.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 13:46:04 -0800 (PST)
Message-ID: <6a59addb-b1a0-8536-c909-25c4c4447e09@linaro.org>
Date:   Mon, 19 Dec 2022 23:46:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm8450: Use GIC-ITS for PCIe0 and
 PCIe1
Content-Language: en-GB
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     bhelgaas@google.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221219191427.480085-1-manivannan.sadhasivam@linaro.org>
 <20221219191427.480085-4-manivannan.sadhasivam@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221219191427.480085-4-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/2022 21:14, Manivannan Sadhasivam wrote:
> Both PCIe0 and PCIe1 controllers are capable of receiving MSIs from
> endpoint devices using GIC-ITS MSI controller. Add support for it.
> 
> Currently, BDF (0:0.0) and BDF (1:0.0) are enabled and with the
> msi-map-mask of 0xff00, all the 32 devices under these two busses can
> share the same Device ID.
> 
> The GIC-ITS MSI implementation provides an advantage over internal MSI
> implementation using Locality-specific Peripheral Interrupts (LPI) that
> would allow MSIs to be targeted for each CPU core.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 570475040d95..276ceba4c247 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -1733,9 +1733,9 @@ pcie0: pci@1c00000 {
>   			ranges = <0x01000000 0x0 0x60200000 0 0x60200000 0x0 0x100000>,
>   				 <0x02000000 0x0 0x60300000 0 0x60300000 0x0 0x3d00000>;
>   
> -			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names = "msi";
> -			#interrupt-cells = <1>;
> +			msi-map = <0x0 &gic_its 0x5980 0x1>,
> +				  <0x100 &gic_its 0x5981 0x1>;

Does ITS support handling more than one MSI interrupt per device? 
Otherwise it might be better to switch to multi-MSI scheme using SPI 
interrupts.

> +			msi-map-mask = <0xff00>;
>   			interrupt-map-mask = <0 0 0 0x7>;
>   			interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
>   					<0 0 0 2 &intc 0 0 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> @@ -1842,9 +1842,9 @@ pcie1: pci@1c08000 {
>   			ranges = <0x01000000 0x0 0x40200000 0 0x40200000 0x0 0x100000>,
>   				 <0x02000000 0x0 0x40300000 0 0x40300000 0x0 0x1fd00000>;
>   
> -			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names = "msi";
> -			#interrupt-cells = <1>;
> +			msi-map = <0x0 &gic_its 0x5a01 0x1>,
> +				  <0x100 &gic_its 0x5a00 0x1>;

Are you sure that the order is correct here?

> +			msi-map-mask = <0xff00>;
>   			interrupt-map-mask = <0 0 0 0x7>;
>   			interrupt-map = <0 0 0 1 &intc 0 0 0 434 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
>   					<0 0 0 2 &intc 0 0 0 435 IRQ_TYPE_LEVEL_HIGH>, /* int_b */

-- 
With best wishes
Dmitry

