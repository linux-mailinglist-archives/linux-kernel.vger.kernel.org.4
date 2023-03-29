Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6717F6CD884
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 13:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjC2LdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 07:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjC2LdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:33:14 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CD740F1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:33:12 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id h25so19690375lfv.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680089591;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sohlc8aRdt0ptQ3unHlw5QOmftyBVVlEC9VNICwLo1w=;
        b=RQ1HZFubaw3Kwxfm/62gAa93r2wx/Vqmsa/0FzpPQNvdjH1lIynHB0C625AWRk/XYB
         o9gnX+QmtJ9YUjH2tkx8GgM5DwohBvDHfE7+psBcI7/LA4PKncHMGfd+TSHDVoWRJx8O
         CI+kuQ8odWQe4lk2Hlst0rDS6seABNQkmoqXlt3QBlbAg/Xdq8dGfbj8q7trmrQiCCrE
         kPt5w2ObOKUgD0HGk9T7VOY4gURn6FZFzVRQqnh6DTJCn0ylCnZkWfijC6pGs+Bj3HCr
         Y0kqamI7syOBe46m60O+uLtwsk4BYVEUvqmRoYdFXetRVfqSBAAnVhNO1CvnB7CfJEcW
         uN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680089591;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sohlc8aRdt0ptQ3unHlw5QOmftyBVVlEC9VNICwLo1w=;
        b=p6f/G6zlx5yTjjN0YqPyx0F6rOUdlFXVaFG8yo2+VvY/XA0t1E0IdHCv0O5S4huSBl
         vL57ASr2Gy5r0j0juB4OvUMwnCwXkpLsu3J7s7xEYIohk1EHsw0NfP1ha9HVbjTBzdPN
         M38yB63sx6U3ynPNaq28soK0Xs782LlVVmLqNzAMyLtOhJX8kzppkZ6ewYWEz9MiJpjF
         W3DbfBuTi4TJ+4ilKTOi5cC6mKsbjtP+xXSC0gDr2E/rX9+vzIeVLfKyzkGL9c6ycQj4
         3LQPekWRs5urXv3NuDs5hII7Xr2ydRDsr25M+C5LCAxngBbQtX80Y6Rry+LUMGVw6VJ4
         HEqg==
X-Gm-Message-State: AAQBX9f1M7uH8hIwVtxxMWw0dM4zZriwEP4tssrNu6TGYAG5MnradOA6
        ti2TPoHAm5gSdg+eMNJd8KBt1w==
X-Google-Smtp-Source: AKy350ajcJzhIh0qFeuqDCAoDEJi8t7QXDzrgy34sATyGDAdmmbqC6g3CxoIxWcZ48SqVnGaZ4q1AA==
X-Received: by 2002:ac2:4c95:0:b0:4d7:58c8:5f44 with SMTP id d21-20020ac24c95000000b004d758c85f44mr6528158lfl.12.1680089591160;
        Wed, 29 Mar 2023 04:33:11 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id m18-20020a195212000000b004e95f53adc7sm5445662lfb.27.2023.03.29.04.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 04:33:10 -0700 (PDT)
Message-ID: <b520f8c8-5ab6-79f6-7eef-28f6f14f536e@linaro.org>
Date:   Wed, 29 Mar 2023 13:33:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 5/7] arm64: dts: qcom: sa8775p: add the pcie smmu node
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230328193632.226095-1-brgl@bgdev.pl>
 <20230328193632.226095-6-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230328193632.226095-6-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.03.2023 21:36, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add the PCIe SMMU node for sa8775p platforms.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 74 +++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index 2343df7e0ea4..9ab630c7d81b 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -809,6 +809,80 @@ apps_smmu: iommu@15000000 {
>  				     <GIC_SPI 891 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
> +		pcie_smmu: iommu@15200000 {
> +			compatible = "qcom,sa8775p-smmu-500", "qcom,smmu-500", "arm,mmu-500";
> +			reg = <0x0 0x15200000 0x0 0x800000>;
> +			#iommu-cells = <2>;
> +			#global-interrupts = <2>;
> +
> +			interrupts = <GIC_SPI 920 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 921 IRQ_TYPE_LEVEL_HIGH>,
That's a lot of interrupts!

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> +				     <GIC_SPI 925 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 926 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 927 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 928 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 950 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 951 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 952 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 953 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 954 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 955 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 956 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 957 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 958 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 885 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 886 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 887 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 888 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 820 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 822 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 823 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 452 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 840 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 841 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 842 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 843 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 844 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 845 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 846 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 847 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 848 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 849 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 802 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 803 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 804 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 805 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 806 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 807 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 808 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 809 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 810 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 811 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 812 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 813 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 814 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 836 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 837 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 838 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 839 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 854 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 855 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 856 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 790 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 791 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 792 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 793 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 794 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 795 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 796 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 639 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 640 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
>  		intc: interrupt-controller@17a00000 {
>  			compatible = "arm,gic-v3";
>  			reg = <0x0 0x17a00000 0x0 0x10000>,     /* GICD */
