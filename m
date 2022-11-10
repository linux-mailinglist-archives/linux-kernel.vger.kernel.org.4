Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613D26245F2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiKJPca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbiKJPcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:32:02 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04132791D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 07:30:29 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id r14so3613615edc.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 07:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/r1odXsFicDjXczwHWptIWDrmeahFBrWNG3RXqZy30=;
        b=x9T1gEbiNQ3mG6SXlpXDYzcFi0PN2sRkCm1E2MTtePfALasTJ2FQrdDDc8t7QTAEx6
         H+GRnvhY7YTkqy0GLoeUYXLkSLs9XLtoOuF8voxUt2dx/wlSrh7va1i1rX9qP/fia7qa
         bYCZvBP38Nq/1+sE9ugE2p05aqUaJw29OaOLSv1B9BY4NpghZyFr805gSUXwOO1mdBIV
         PY52EQWNV5NXTifRIywbpDQiiPmGv+zn+biJs8cXeHhlFQygpWhF4SQMaVAFN2Gh+pg8
         Hy/04pFh00D/7KbdXoul3vZnPD6PYpABK8EAK0wusQKAo9uYx2WtDbZYywFhbfGcVWo7
         ppIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j/r1odXsFicDjXczwHWptIWDrmeahFBrWNG3RXqZy30=;
        b=yQqCpaASp2pQTH+7h90Qm/kpr+LN2NUM6OLW9Dq4WAeVCJir2e0pc7yDK8786UUM2u
         5XID1SajVgbwlA+gDTXd00EYTPADIl757EbfBo8dlqcI+wS2yPgRLXbLG/AcvBhkCb1G
         /LzhiWaPX0iD9VbPLCmlA6aOCuoS3XMrKjnl0NqExrQfPpy6KCcXZPBlaPV+FeRJLWHe
         4VAik9s4PmqF1Po1Go60o7LqKb0NRZDMB16wTiMxhQkKQXp+vin5S2eQ40Ikg7s+5fa3
         8dY//vZFvLgml1tYp+jClXE4f7BMVYRl486efSGEEh1RRCjBDDCH3R/O1bgY9/4dCCy2
         gH5w==
X-Gm-Message-State: ACrzQf1x6itnILEN/8zW7XPYwom3/fZcOp4FDsiucos7wuYe8fAAGAyC
        OFQIyr2TVGjYLzXUqpLzewVAsA==
X-Google-Smtp-Source: AMsMyM6h7XRJNoHUGOm9Ham1GCwmtJEKRec6pWlvmIctEXk8jPc4i2Oz8lPFYrIAgcYTlujmRMoFVQ==
X-Received: by 2002:a05:6402:3408:b0:43c:2dd3:d86b with SMTP id k8-20020a056402340800b0043c2dd3d86bmr63263031edc.108.1668094228386;
        Thu, 10 Nov 2022 07:30:28 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id q19-20020a17090676d300b007030c97ae62sm7246104ejn.191.2022.11.10.07.30.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 07:30:27 -0800 (PST)
Message-ID: <c8a480c3-7bce-8e83-c0e6-6b29f32211d8@linaro.org>
Date:   Thu, 10 Nov 2022 16:30:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH] arm64: dts: qcom: sm8450: drop incorrect
 spi-max-frequency
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221110152741.542024-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221110152741.542024-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/11/2022 16:27, Krzysztof Kozlowski wrote:
> spi-max-frequency is a property of SPI device, not the controller:
>
>    qcom/sm8450-hdk.dtb: geniqup@8c0000: spi@880000: Unevaluated properties are not allowed ('spi-max-frequency' was unexpected
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>


Konrad

>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 7 -------
>   1 file changed, 7 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 9bdda0163573..e9f34c102a6f 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -794,7 +794,6 @@ spi15: spi@880000 {
>   				interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
>   				pinctrl-names = "default";
>   				pinctrl-0 = <&qup_spi15_data_clk>, <&qup_spi15_cs>;
> -				spi-max-frequency = <50000000>;
>   				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
>   						<&system_noc MASTER_A2NOC_SNOC 0 &gem_noc SLAVE_LLCC 0>;
>   				interconnect-names = "qup-core", "qup-config";
> @@ -834,7 +833,6 @@ spi16: spi@884000 {
>   				interrupts = <GIC_SPI 583 IRQ_TYPE_LEVEL_HIGH>;
>   				pinctrl-names = "default";
>   				pinctrl-0 = <&qup_spi16_data_clk>, <&qup_spi16_cs>;
> -				spi-max-frequency = <50000000>;
>   				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
>   						<&system_noc MASTER_A2NOC_SNOC 0 &gem_noc SLAVE_LLCC 0>;
>   				interconnect-names = "qup-core", "qup-config";
> @@ -874,7 +872,6 @@ spi17: spi@888000 {
>   				interrupts = <GIC_SPI 584 IRQ_TYPE_LEVEL_HIGH>;
>   				pinctrl-names = "default";
>   				pinctrl-0 = <&qup_spi17_data_clk>, <&qup_spi17_cs>;
> -				spi-max-frequency = <50000000>;
>   				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
>   						<&system_noc MASTER_A2NOC_SNOC 0 &gem_noc SLAVE_LLCC 0>;
>   				interconnect-names = "qup-core", "qup-config";
> @@ -914,7 +911,6 @@ spi18: spi@88c000 {
>   				interrupts = <GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>;
>   				pinctrl-names = "default";
>   				pinctrl-0 = <&qup_spi18_data_clk>, <&qup_spi18_cs>;
> -				spi-max-frequency = <50000000>;
>   				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
>   						<&system_noc MASTER_A2NOC_SNOC 0 &gem_noc SLAVE_LLCC 0>;
>   				interconnect-names = "qup-core", "qup-config";
> @@ -954,7 +950,6 @@ spi19: spi@890000 {
>   				interrupts = <GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH>;
>   				pinctrl-names = "default";
>   				pinctrl-0 = <&qup_spi19_data_clk>, <&qup_spi19_cs>;
> -				spi-max-frequency = <50000000>;
>   				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
>   						<&system_noc MASTER_A2NOC_SNOC 0 &gem_noc SLAVE_LLCC 0>;
>   				interconnect-names = "qup-core", "qup-config";
> @@ -1007,7 +1002,6 @@ spi20: spi@894000 {
>   				interrupts = <GIC_SPI 587 IRQ_TYPE_LEVEL_HIGH>;
>   				pinctrl-names = "default";
>   				pinctrl-0 = <&qup_spi20_data_clk>, <&qup_spi20_cs>;
> -				spi-max-frequency = <50000000>;
>   				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
>   						<&system_noc MASTER_A2NOC_SNOC 0 &gem_noc SLAVE_LLCC 0>;
>   				interconnect-names = "qup-core", "qup-config";
> @@ -1047,7 +1041,6 @@ spi21: spi@898000 {
>   				interrupts = <GIC_SPI 579 IRQ_TYPE_LEVEL_HIGH>;
>   				pinctrl-names = "default";
>   				pinctrl-0 = <&qup_spi21_data_clk>, <&qup_spi21_cs>;
> -				spi-max-frequency = <50000000>;
>   				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
>   						<&system_noc MASTER_A2NOC_SNOC 0 &gem_noc SLAVE_LLCC 0>;
>   				interconnect-names = "qup-core", "qup-config";
