Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D97B731FE7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 20:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjFOSUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 14:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjFOSUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 14:20:47 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD77295C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 11:20:45 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f122ff663eso11026060e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 11:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686853243; x=1689445243;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L86ku+7+LZQwdB7LY2vEzyd00L4TaNLzuqM/PGY++fA=;
        b=arTUyMobZK0/1k5hhhUhyJT2jUNGhSGsNAcNWzGam6h3yvKOLLF9B6nFrb2tM3Tmlr
         EudvbD1uHXsiZXGdaIy7mLb6GaJOqiamXP84/gtVzonNxNcVcwHRbopHPKB5Br+HPIho
         gd+Xr+VAfxHPoZQylbhX1Z5XtbV3NwBooyPZ0o/c9i4hxvGOv1d1szjJ0Z+q278peJoB
         MvnsiKMzcY3Nq4amJvcsyQAZtTY3f4LqJVhjZTF9OLRH//j625LClyOgoUXtp1HH8SqK
         At/CS2hxE3jI9A8VX8zIvHC29Njea6523hyBJRUYivUOYY40nC0p3UeyC4ogXm32ZlNg
         gF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686853243; x=1689445243;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L86ku+7+LZQwdB7LY2vEzyd00L4TaNLzuqM/PGY++fA=;
        b=Bu8OkaziGOEf5ZJHqhBaPw1bEcOo2ojk91PkbrHPI+BpLyd0zY8yZwvWVKzuMp7HZA
         IQ1lKZbEGxbQT1zVez3DLWCbNQylYnTZV/yUdD/+9wS7FlzxZTwUxJKq/J0xJCcjlbav
         mj37pqI5oTSj3ZLmlEkeSuI5mB49lUTifhqBFEKvUpP12bdrAQI7asOyVjARQWH3019E
         AzPtxvf23NdtzrDn55Hrawl+TCrnRguEhTvSEJzVLW0QEcZoopKi5BGGVolaLo7tCfAM
         MdNPCk3/H41c8Ej/a5OiktCvFpWx7BpHihKmRZmDoyrEm8SmPIQW6p0FprFP2ouFpiaX
         RYTw==
X-Gm-Message-State: AC+VfDw+Q1GbaMsyolmlD2gNFXmfJ/ge8G0C5Ka+yLm7RMSQNiq4FUKR
        4ZiNfJoN/WsnhGjcfG/2mLCXVQ==
X-Google-Smtp-Source: ACHHUZ402ziYL5TvXfixIJ4Rjk5NUObRoP16/IYruQqcuIlOd4fwWY+IubMf34Q80/dG580p0yGxmQ==
X-Received: by 2002:a19:ca58:0:b0:4f4:b592:74ab with SMTP id h24-20020a19ca58000000b004f4b59274abmr8857833lfj.62.1686853243607;
        Thu, 15 Jun 2023 11:20:43 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id v27-20020a056512049b00b004f74160c9cesm1806292lfq.130.2023.06.15.11.20.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 11:20:43 -0700 (PDT)
Message-ID: <866f1f66-8845-2453-ab9c-d125e23ae758@linaro.org>
Date:   Thu, 15 Jun 2023 20:20:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2] ARM: dts: qcom: msm8974: correct qfprom node size
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Cc:     Rob Herring <robh@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Craig Tatlor <ctatlor97@gmail.com>
References: <20230130-msm8974-qfprom-v2-1-3839cf41d9ee@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230130-msm8974-qfprom-v2-1-3839cf41d9ee@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.06.2023 20:17, Luca Weiss wrote:
> From: Craig Tatlor <ctatlor97@gmail.com>
> 
> The qfprom actually has size 0x3000, so adjust the reg.
> 
> Note that the non-ECC-corrected qfprom can be found at 0xfc4b8000
> (-0x4000). The current reg points to the ECC-corrected qfprom block
> which should have equivalent values at all offsets compared to the
> non-corrected version.
> 
> [luca@z3ntu.xyz: extract to standalone patch and adjust for review
> comments]
> 
> Fixes: c59ffb519357 ("arm: dts: msm8974: Add thermal zones, tsens and qfprom nodes")
> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
Not sure of the actual size of the region, maybe Bjorn can help..

Downstream 3.10 suggests 0x60F0, 0x20F0 after adjusting for the ECC offset

Konrad
> Changes in v2:
> - Keep base offset but expand reg from 0x1000 to 0x3000 (Konrad)
> - Link to v1: https://lore.kernel.org/r/20230130-msm8974-qfprom-v1-1-975aa0e5e083@z3ntu.xyz
> ---
>  arch/arm/boot/dts/qcom-msm8974.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> index 7ed0d925a4e9..3156fe25967f 100644
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -1194,7 +1194,7 @@ restart@fc4ab000 {
>  
>  		qfprom: qfprom@fc4bc000 {
>  			compatible = "qcom,msm8974-qfprom", "qcom,qfprom";
> -			reg = <0xfc4bc000 0x1000>;
> +			reg = <0xfc4bc000 0x3000>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  
> 
> ---
> base-commit: 858fd168a95c5b9669aac8db6c14a9aeab446375
> change-id: 20230130-msm8974-qfprom-619c0e8f26eb
> 
> Best regards,
