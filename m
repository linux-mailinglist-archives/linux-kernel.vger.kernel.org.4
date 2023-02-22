Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDC169F89F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 17:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjBVQGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 11:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjBVQGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 11:06:52 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C19E3CE28
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 08:06:51 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id g8so6955567lfj.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 08:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8USIxg/ch7FSV86aq2IWnMVmX2lOYDkkYcIurOZq368=;
        b=EMWzDHhPFmWX6K1h4sWnl4efdISDePX4QMzUIzv91ih43FiBsgeKUyXXsLw8aqRj/f
         YFx0yomB7J7X3XVqL957/pZXG7RYdtW31SY1ve4Y9vIiGHxP1ZtwRq8NmCj20F6gj5pV
         0oDUiLmJi2ydK7Lfux2cj5J5Og8AFuR8D9lHagVRSezna/+E2OdHwreTT9mhQiTHJrGO
         c37DJgcjZHDevUZhr3wnIWXuMXsI+WfA0FuonExgJvircWhyb/yiZBrleXNBzTtvCn1B
         21JmyNLsLiCEUZ+hi9Ienb8OAQ8L9903f13qYys2dF6TsccTifYfeovi2fM1zgEgpib6
         PlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8USIxg/ch7FSV86aq2IWnMVmX2lOYDkkYcIurOZq368=;
        b=c5oZ0ovdT2LsckeLSnSL3OnV4ixHSM3onEB+C2AMO7JJNR3xa03bs1ufRczjx4eO7Y
         sFIXAhLs/Fd27rz8uHL+JBqgn26OyKx6xBfHoJq7bRANb7ZBfB++KGwHWl6d6zGyj/es
         gYxxo8YT0abxtR8T33tZxOhGzaFercghNDkcYbz1GACk1fq8bYjvzr4c1tDR+krtOtrd
         q0RQvE1ScWLnGTP9UNiO6PQfptG2bKPu6yS+4hT4DV0uixD0Th/8If5JfNeYTsyyUAnj
         8EHOJNxFhEwSx/7npgTTVG6L92tnSr7o/8vNIdWKI6c7tjec7PmFWURadY9sXKsqCyba
         dMuw==
X-Gm-Message-State: AO0yUKWfBef/PaDkyxDkjekIOlVevssmoIRlYaMh9ZWkClfl7ANanAv6
        ++U/IvmEm3hcYwGJn0UsMi+eoQ==
X-Google-Smtp-Source: AK7set90zq0pUixr/vnRmsiQGKP735fINZmlrvTRuNAivKuiwFZsainImmoqZg2zjT58hixUQD4V0Q==
X-Received: by 2002:ac2:5383:0:b0:4dc:4c53:4460 with SMTP id g3-20020ac25383000000b004dc4c534460mr2813784lfh.16.1677082009120;
        Wed, 22 Feb 2023 08:06:49 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id x23-20020ac24897000000b004b564e1a4e0sm282007lfc.76.2023.02.22.08.06.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 08:06:48 -0800 (PST)
Message-ID: <8259f4e1-3ab0-0ac2-f717-7dca72ea4170@linaro.org>
Date:   Wed, 22 Feb 2023 17:06:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] arm64: dts: qcom: sm8450: Add IMEM and PIL info region
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, elder@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1677079845-17650-1-git-send-email-quic_mojha@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1677079845-17650-1-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.02.2023 16:30, Mukesh Ojha wrote:
> Add a simple-mfd representing IMEM on SM8450 and define the PIL
> relocation info region, so that post mortem tools will be able
> to locate the loaded remoteprocs.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> Change in v3:
>  - Sorted by address.
> 
> Changes in v2:
>  -  put ranges after regs and corrected the sram node position.
> 
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 1a744a3..7671f15 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -3689,6 +3689,20 @@
>  			};
>  		};
>  
> +		sram@146aa000 {
> +			compatible = "qcom,sm8450-imem", "syscon", "simple-mfd";
> +			reg = <0 0x146aa000 0 0x1000>;
> +			ranges = <0 0 0x146aa000 0x1000>;
> +
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			pil-reloc@94c {
> +				compatible = "qcom,pil-reloc-info";
> +				reg = <0x94c 0xc8>;
> +			};
> +		};
> +
>  		apps_smmu: iommu@15000000 {
>  			compatible = "qcom,sm8450-smmu-500", "arm,mmu-500";
>  			reg = <0 0x15000000 0 0x100000>;
