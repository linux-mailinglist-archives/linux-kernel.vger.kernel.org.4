Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D28769F941
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 17:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbjBVQpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 11:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbjBVQpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 11:45:50 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875573CE12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 08:45:47 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id s20so10552890lfb.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 08:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xf8IY83kNm9ZLdtrAMlzH0BWdysIJ0EtE4QkPWoDYMs=;
        b=iR9IHWtk+Ko+B/NToRrxElbe2NzAzxbQd3SlLe4qK4hFAoa91S/pZ0irPFW0tY0cQ1
         NqT1a8fELf4fKaC2XwpZN6Urq8yodxAkRfDE5e4hQa3tyP74cM6tOGqICfP0k491XO6E
         YeTUzilnoBUE2kPANVC0WyKX6hAwFNor1PGHNxn/J9SKveFZRj/TOwKlqo2JsLEbqTRG
         DWSwP8JBxhSm2yxzzerqHLVlMLvVpV7VymvkiY4Gg2spZd5CMGRqyL76OCQxBVJw5I1M
         p94XNvZ6FkuYBAs+xuGfy6piCQwPcuqnwJVVO+CM2ibczsv0j4hQ8WQdI0gtiOkCww42
         2RNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xf8IY83kNm9ZLdtrAMlzH0BWdysIJ0EtE4QkPWoDYMs=;
        b=T0zA9+DSbyag83IW9UXJgdh3apA81GnL386VAsIK4W2NbEmTAhEh3NcwvpYZ0dAT+b
         8kZmsVBFR1R5xyvxHP9DmiZdZb5M2/8qDs3/PPJz+1AYT0q6C2zapbbs6WdZyU9+I8Tu
         ex7HJS2F0Repw6SRrI5BjqWMOpZ2VSdZyX6Y/PsAdW+YHHLkh1TE0DL0odgWcLr9XFiW
         oMshxu9SIk6IyWv1Ro275WFcrvubrdlAGY3qqbj32cMTGSl3JavYzf6rUZGVEmziGStG
         fWQlQW6QbzmB+DS+kwfMAn3kZNuCD7EMBEt+wOHd+a7r5/odN/9KfrIEp7lI/s9w1Sa+
         r1Hw==
X-Gm-Message-State: AO0yUKU58+VD2i97oqmdUCpEHq9XCMDR97taGm75rgAVLDTTJ8HdXh6q
        Tofr0iz+qT8vZ99czo5WOKMqqw==
X-Google-Smtp-Source: AK7set9t/nSuuaKdA16dsR+NcfmJqnzDAcj0o9WtZkAkWK3/yNkQ5lBR2aCr8By5catJHiIdFRk8wg==
X-Received: by 2002:ac2:5582:0:b0:4db:2978:e32c with SMTP id v2-20020ac25582000000b004db2978e32cmr3141176lfg.11.1677084345809;
        Wed, 22 Feb 2023 08:45:45 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id w7-20020ac24427000000b004db3e03e201sm1013276lfl.6.2023.02.22.08.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 08:45:45 -0800 (PST)
Message-ID: <69259bca-5618-7590-07b0-494041d83823@linaro.org>
Date:   Wed, 22 Feb 2023 17:45:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 06/11] ARM: dts: qcom: sdx55: Rename pcie0_{phy/lane} to
 pcie_{phy/lane}
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org
Cc:     bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230222153251.254492-1-manivannan.sadhasivam@linaro.org>
 <20230222153251.254492-7-manivannan.sadhasivam@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230222153251.254492-7-manivannan.sadhasivam@linaro.org>
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



On 22.02.2023 16:32, Manivannan Sadhasivam wrote:
> There is only one PCIe PHY in this SoC, so there is no need to add an
> index to the suffix. This also matches the naming convention of the PCIe
> controller.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts | 2 +-
>  arch/arm/boot/dts/qcom-sdx55.dtsi                | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts b/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts
> index ac8b4626ae9a..b7ee0237608f 100644
> --- a/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts
> +++ b/arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dts
> @@ -242,7 +242,7 @@ &ipa {
>  	memory-region = <&ipa_fw_mem>;
>  };
>  
> -&pcie0_phy {
> +&pcie_phy {
>  	status = "okay";
>  
>  	vdda-phy-supply = <&vreg_l1e_bb_1p2>;
> diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
> index e84ca795cae6..a1f4a7b0904a 100644
> --- a/arch/arm/boot/dts/qcom-sdx55.dtsi
> +++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
> @@ -334,7 +334,7 @@ pcie_ep: pcie-ep@1c00000 {
>  			resets = <&gcc GCC_PCIE_BCR>;
>  			reset-names = "core";
>  			power-domains = <&gcc PCIE_GDSC>;
> -			phys = <&pcie0_lane>;
> +			phys = <&pcie_lane>;
>  			phy-names = "pciephy";
>  			max-link-speed = <3>;
>  			num-lanes = <2>;
> @@ -342,7 +342,7 @@ pcie_ep: pcie-ep@1c00000 {
>  			status = "disabled";
>  		};
>  
> -		pcie0_phy: phy@1c07000 {
> +		pcie_phy: phy@1c07000 {
>  			compatible = "qcom,sdx55-qmp-pcie-phy";
>  			reg = <0x01c07000 0x1c4>;
>  			#address-cells = <1>;
> @@ -362,7 +362,7 @@ pcie0_phy: phy@1c07000 {
>  
>  			status = "disabled";
>  
> -			pcie0_lane: lanes@1c06000 {
> +			pcie_lane: lanes@1c06000 {
>  				reg = <0x01c06000 0x104>, /* tx0 */
>  				      <0x01c06200 0x328>, /* rx0 */
>  				      <0x01c07200 0x1e8>, /* pcs */
