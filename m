Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8356D28D9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 21:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjCaTzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 15:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjCaTzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 15:55:01 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B388C1D849
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 12:54:58 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id t14so24278610ljd.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 12:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680292497;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R6Wa2EnpF34LgvveW3IVoHFJpoC0G9OylXTyrH0K+dM=;
        b=dNV6n8RFal1AEz1MeUBkwtxsIzr5W9eg4J6TTJXuk9W4/xeIWcBVnecPdUZqVLOLf1
         h4EfpqmxV4mfcDFYS0avSFBSTAjo9QqnqSBwqxaX7JNggqoEVrFizWMjYKIuuK/4jut/
         C7T9VEOfn3Sj/ZuignsPWWWIqDszjEvlX8pL9pgNak2Ydha8KI9J+ZIkx4pmQl2ddR8C
         IryhxZzUWU0DHMxxv4WsuunkTPN1Mse3qpEow4J36KZKuHZw8xTxwniizYXVX/NkGIAO
         pzFJxM0oILHtK1DBDbDPE0gSpLJK9x88sQX7FRaCgVKdkOgQ5X19uC2fmaKV9GHd1hgo
         M+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680292497;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R6Wa2EnpF34LgvveW3IVoHFJpoC0G9OylXTyrH0K+dM=;
        b=AonSKvpEz/UynfSmmCoI94n5f8kSLdly1zHL/gLUdtyO8vrVu/yaf1YEChdQKpOZ8V
         ZsaDeH3t1G3BP0c6wxzFZVRyV77svBrP4GPG/LazTyYJ6vHSox5FUjxZvxbRxHFAxzMD
         +9mKAiPUgKHcJuRdAs/NEBQfiueGeZl9lvUP6OpaAOBFi0IrzGA3FS1LefMF/aBhhuhY
         IG8I6QaVhxGcoiJDt+l1utz2949KpeE6WlBiDqLZavxJ9MC9CqKOqgxsaNf51tpG6zvz
         94Lw+XXeP6pNZPzhOupsJRLYGR0+SHj1YAM4TvNx/HgdFxz9BHra95hkDcl+a6qG4lxZ
         zDMw==
X-Gm-Message-State: AAQBX9ddGHuq49d4MNpE2nw6lvXpJrdS80g14Y5v5Be/jIGwICxpYN1i
        mBdW8mdDw8Hr6pQ7YcwI4CWoNw==
X-Google-Smtp-Source: AKy350aWTea+C6DsL0gAE79uwlsUkI2jyhCUtMUNJYht0xgcWLWAX/iBAEdjVwdVHesotkac92rsdA==
X-Received: by 2002:a2e:9d18:0:b0:29a:fbca:e8a8 with SMTP id t24-20020a2e9d18000000b0029afbcae8a8mr7862371lji.19.1680292496974;
        Fri, 31 Mar 2023 12:54:56 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id u7-20020a2e8547000000b00295a8d1ecc7sm494987ljj.18.2023.03.31.12.54.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 12:54:56 -0700 (PDT)
Message-ID: <414b659a-888f-b31e-de90-79f81491580a@linaro.org>
Date:   Fri, 31 Mar 2023 21:54:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 03/11] arm64: dts: qcom: sdm8550: Fix the BAM DMA
 engine compatible string
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org,
        Bhupesh Sharma <bhupesh.sharma@qcom-hackbox.linaro.org>
References: <20230331164323.729093-1-bhupesh.sharma@linaro.org>
 <20230331164323.729093-4-bhupesh.sharma@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230331164323.729093-4-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31.03.2023 18:43, Bhupesh Sharma wrote:
> From: Bhupesh Sharma <bhupesh.sharma@qcom-hackbox.linaro.org>
> 
> As per documentation, Qualcomm SM8550 SoC supports BAM DMA
> engine v1.7.4, so use the correct compatible strings.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 9c24af40ee61..774e3295081c 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -1841,7 +1841,7 @@ pcie1_phy: phy@1c0e000 {
>  		};
>  
>  		cryptobam: dma-controller@1dc4000 {
> -			compatible = "qcom,bam-v1.7.0";
> +			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
>  			reg = <0x0 0x01dc4000 0x0 0x28000>;
>  			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
>  			#dma-cells = <1>;
