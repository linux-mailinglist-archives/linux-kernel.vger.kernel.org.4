Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E49E6E007F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 23:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjDLVHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 17:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDLVHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 17:07:31 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F745249
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 14:07:28 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id t14so16290367lft.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 14:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681333647; x=1683925647;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TouGPU+Efoq/WGt/vDKkhltZTB+4TxGu4UL9u2kA4UE=;
        b=uM9DmsgCbpsezm1URvfxA1QlpROL2JDARNWITPqAhDWCPoJrX7aKohknLbrgtm0zUV
         xhY9VfEH1Mr5O9m9+Ff8qZpev+gC3BUBPrjWOBvzsTv2mXeOe88nMIC9A1Gd67HuuQXa
         rwKPBdychE/adJ1gHlPw/9gZkAuOAZPWH90JZ+PsfLoH9Ehzkt+zAsxlaeV4jonWVliM
         sSFzBoDFiUWOZeiJWtXBYy1ssRQyq5A159Zi6S5ncs1ggbjZCGHpUWkoTy4OTP1j5Wza
         tPUlRrXIAE5q/5nbj5gtrpG5FLm36G1y7zOTD9sz779btG6mJCt+EXz/o3fdQdO/Qu4m
         IPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681333647; x=1683925647;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TouGPU+Efoq/WGt/vDKkhltZTB+4TxGu4UL9u2kA4UE=;
        b=P+1/9C+vP3hmdKtikP12IBSpTXq4qITlGfYiTMfv/a+cdtKtWkv9zPhaDUPCimtwAy
         aTZwJdaV5am8x36y4WYP33Jx8xFkblIDNsDBj2/GLMIO4ULf7LkK9zYphW5S1a/tkzue
         EFiEJAvtluQvFAejMXn0+gPrXaLuCN1LMru5Y7GXf/y0VMJOCSsFLFAuk8PPpnYloYKR
         K3jKGOYmaRXBkbcike4mUEvqiBlOUaDG1OxMQjq753dwoz6HOrjpsKgGZSe7ZnTdJNfW
         LM6lDoIg2pqmG+Fi7IP5lYhhTZFTLPLpjXUrusq5MFpfa2rghK5efrOMojpQBgDqg0lc
         81og==
X-Gm-Message-State: AAQBX9cz/t1nzzoaQ2jbvL6uHFkjmg6mSIUK/wqLJ82V4q33BgnypZf0
        lkKcdAgSMDQ71GW+vwOihUPg2g==
X-Google-Smtp-Source: AKy350bX2h3G0tTnQ38bAbnmsibh59UeenWLaYQupyr78fByKFQuaH3FwLV2XZmERAmoTvQ+8nje4w==
X-Received: by 2002:a05:6512:49c:b0:4e9:67ee:6383 with SMTP id v28-20020a056512049c00b004e967ee6383mr64065lfq.2.1681333647186;
        Wed, 12 Apr 2023 14:07:27 -0700 (PDT)
Received: from [192.168.1.101] (abxj23.neoplus.adsl.tpnet.pl. [83.9.3.23])
        by smtp.gmail.com with ESMTPSA id v17-20020ac25931000000b004ec8b638115sm1487244lfi.193.2023.04.12.14.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 14:07:26 -0700 (PDT)
Message-ID: <07b8731d-f9b6-c759-808d-56ae5881e251@linaro.org>
Date:   Wed, 12 Apr 2023 23:07:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 5/5] arm64: dts: qcom: sa8775p-ride: enable UFS
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230411130446.401440-1-brgl@bgdev.pl>
 <20230411130446.401440-6-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230411130446.401440-6-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.04.2023 15:04, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Enable the UFS and its PHY on sa8775p-ride.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> index f238a02a5448..2bb001a3ea55 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> @@ -5,6 +5,7 @@
>  
>  /dts-v1/;
>  
> +#include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  
>  #include "sa8775p.dtsi"
> @@ -20,6 +21,7 @@ aliases {
>  		serial2 = &uart17;
>  		i2c18 = &i2c18;
>  		spi16 = &spi16;
> +		ufshc1 = &ufs_mem_hc;
>  	};
>  
>  	chosen {
> @@ -426,6 +428,23 @@ &uart17 {
>  	status = "okay";
>  };
>  
> +&ufs_mem_hc {
> +	reset-gpios = <&tlmm 149 GPIO_ACTIVE_LOW>;
> +	vcc-supply = <&vreg_l8a>;
> +	vcc-max-microamp = <1100000>;
> +	vccq-supply = <&vreg_l4c>;
> +	vccq-max-microamp = <1200000>;
> +
> +	status = "okay";
> +};
> +
> +&ufs_mem_phy {
> +	vdda-phy-supply = <&vreg_l4a>;
> +	vdda-pll-supply = <&vreg_l1c>;
> +
> +	status = "okay";
> +};
> +
>  &xo_board_clk {
>  	clock-frequency = <38400000>;
>  };
