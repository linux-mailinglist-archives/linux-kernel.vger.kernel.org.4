Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3756D98D0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 15:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238956AbjDFN6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 09:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238924AbjDFN61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:58:27 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9935A5EB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 06:58:08 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id by14so21613895ljb.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 06:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680789483;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=veXi6X8hXncoY1cFpYaYdFHnrA4v/kUv68rWDNLT4iU=;
        b=BCDQiASBk1BGRzDQ5Wdj7XVOd/o+REpjKRxfUPZoShop7Qd4ebGPZ7QQMJSx0EEBWk
         qQXryNJ3LDNUF7eX3xTG/A0D2gD1dAGIbs87txMkndOIp3UDtLKQGfYeXCqaHZe3EHM6
         FX50m+DmwME8g7x2XLpL3c+toFkEeTTc1V4n85r1pfasfJtgYYKk7EDbg0qKg6EbkQ3A
         1kIIz3x40Gp9+EFAxunCq6RghHzTHX+B1Ly5Mid0VRw+J+xmuMCI/pYWjmpuBcmXOucI
         I9iqewUwfL//cH/UbH2uj3G6WQ10tEbAMtJLoIgTsEuHRemXHPWed6UXHOV3eRHLUG6I
         wY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680789483;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=veXi6X8hXncoY1cFpYaYdFHnrA4v/kUv68rWDNLT4iU=;
        b=ZHsB0zuYxvIaiwDV6l/c2HuKNONyOuRLUKqxZWCebs7aFQScOCGKecGslUTk7ibRNb
         k9ho2J/Nk8GNMo0LF7l/QdJcrhBFla1lNa1+Om7AGG4LGQwkRZGV4CB9A9ro2LN4OJyp
         83FOi3Owcv7LMEHersl4KDd49w059T2vxJI+OG5cFHCNyOGXjUwUzuRUHQAqkpeWkjpE
         yVmN9I5HRbSnyk265aJSmwhMevlDdbz5+hR5SiGvksbuA7MzPaUz8bjzLba+h0OVBce8
         NMH0/VhmHMHQ+RQEbKCftIOE+NYwdHUitDOUEjVMe1UXTLwkekCyaBP2ZCDYgMWtXKXu
         GqIw==
X-Gm-Message-State: AAQBX9fbcDO9AIrboMyRqU9efyCoN9EkCx48pPjIEFk3mGXzgUNsIMCE
        tX6rIg0d8luaA3QxmZGc+uiBfA==
X-Google-Smtp-Source: AKy350ZE6dBJy6A2aSVdHV4ceMB49ftIHKNRdbW1HDjL4B1qPI8/x0aA/5cnv+OfOHEmjxhjcDt1Ww==
X-Received: by 2002:a05:651c:113:b0:2a1:17f8:e904 with SMTP id a19-20020a05651c011300b002a117f8e904mr2745961ljb.4.1680789483178;
        Thu, 06 Apr 2023 06:58:03 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id v11-20020a2e924b000000b00299ab2475ebsm300064ljg.1.2023.04.06.06.58.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 06:58:02 -0700 (PDT)
Message-ID: <9ecbea6a-d7bd-0f4d-e94f-dd1130e578c7@linaro.org>
Date:   Thu, 6 Apr 2023 15:58:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 08/11] arm64: dts: qcom: sm8150: Add Crypto Engine
 support
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org, djakov@kernel.org
References: <20230405072836.1690248-1-bhupesh.sharma@linaro.org>
 <20230405072836.1690248-9-bhupesh.sharma@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230405072836.1690248-9-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.04.2023 09:28, Bhupesh Sharma wrote:
> Add crypto engine (CE) and CE BAM related nodes and definitions to
> 'sm8150.dtsi'.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8150.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index 9491be4a6bf0..c104d0b12dc6 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -2081,6 +2081,28 @@ ufs_mem_phy_lanes: phy@1d87400 {
>  			};
>  		};
>  
> +		cryptobam: dma-controller@1dc4000 {
> +			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
> +			reg = <0 0x01dc4000 0 0x24000>;
> +			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
> +			#dma-cells = <1>;
> +			qcom,ee = <0>;
> +			qcom,controlled-remotely;
> +			iommus = <&apps_smmu 0x514 0x0011>,
> +				 <&apps_smmu 0x516 0x0011>;
> +		};
> +
> +		crypto: crypto@1dfa000 {
> +			compatible = "qcom,sm8150-qce", "qcom,qce";
> +			reg = <0 0x01dfa000 0 0x6000>;
> +			dmas = <&cryptobam 4>, <&cryptobam 5>;
> +			dma-names = "rx", "tx";
> +			iommus = <&apps_smmu 0x514 0x0011>,
> +				 <&apps_smmu 0x516 0x0011>;
Downstream uses these (sid, mask) combos:

qcedev:
0x0506 0x0011 
0x0516 0x0011 // equal to 0x506 0x11

qcom_cedev_ns_cb:
0x512 0
0x518 0
0x519 0
0x51f 0

Shouldn't we use them too?

Konrad

> +			interconnects = <&aggre2_noc MASTER_CRYPTO_CORE_0 &mc_virt SLAVE_EBI_CH0>;
> +			interconnect-names = "memory";
> +		};
> +
>  		tcsr_mutex: hwlock@1f40000 {
>  			compatible = "qcom,tcsr-mutex";
>  			reg = <0x0 0x01f40000 0x0 0x20000>;
