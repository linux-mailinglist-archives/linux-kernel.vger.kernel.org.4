Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2A26E1861
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 01:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjDMXhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 19:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDMXhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 19:37:47 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FB010C1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 16:37:45 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id l7so2918584ljq.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 16:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681429064; x=1684021064;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5AafloAaxeZRD4LLJdC1yw0kj6AD0tdhsxKykvaaIVc=;
        b=xUoniySlUzRQIazAjxqLUfeVBpuo0Mte07vi45CAvlPpvO5GcqPX7ZxWiCKnPKEye2
         1j5+53ItSa1I/khp3dzaFOKtm3hYPNx+946IdO4Y48Ce87SRr7L+yvgYMKhSvyvbjzP0
         lNlwPc9GbC7lCkfmx5oQo/nWcQhcMcHUbkAfMUT8MW6F1OUeyHTp5x2V2UU4tIZgVxgV
         dUi5c4L4Nu+zDQrWqFAtCqzbwkqyJ7S9nWzm6qeL/LxacrPbBk0mHK8HRZ9aAk8aORfw
         veO7jKItwFQI18VPIE3qI8GAbEMQcFd8FiRmV3A4uEyFhkrRkOogESwfihzPQ+GuXbcz
         V9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681429064; x=1684021064;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5AafloAaxeZRD4LLJdC1yw0kj6AD0tdhsxKykvaaIVc=;
        b=UAq8gMSqf2AfDj9eOKeluHtDILnskeW2aSc1xv/K25SW+aWl/SwmL+18Fp6B0FOuri
         X4N5NEiXw7B44en/dc1wTVx4yQkwHCv/MRZFeiNKB0OvhYi7sxXzEUHf2sF+QfEsWlpT
         Y4g5ACxRLEDFMgjMm14lcBIOaa2J0Qh97nVON/tnDWwO0X5y9G+Ctb0a5jpBg/03qofi
         Hv59bRH90oJ67/X0Ibr8Ma+Kds7tLZKj6ArsoqXypealorL9P9bXts6CVmGlDpAPzGY6
         0QmZQM9xYMkaQKzCsUqW0kov/x7sGDWqEsoFQ7iNY4JEE5cgMgy5zi65Fbz5o5xmGQ/t
         bo5g==
X-Gm-Message-State: AAQBX9defcbNiYZ1hGPSkVLKT2bAfOq/RXg3BvspfqA36yXU2faFPE2q
        7R02XxQHlX0PCgPZyWxvubFAFA==
X-Google-Smtp-Source: AKy350YzefABtmdd4c/J9wdM6De/dDMPBMCyWuq0bEMfkf8lnM4kWxIJwn6NcZManUvoSktT0gsn0g==
X-Received: by 2002:a2e:8189:0:b0:2a7:afb7:da6a with SMTP id e9-20020a2e8189000000b002a7afb7da6amr1282105ljg.15.1681429064196;
        Thu, 13 Apr 2023 16:37:44 -0700 (PDT)
Received: from [192.168.1.101] (abyl123.neoplus.adsl.tpnet.pl. [83.9.31.123])
        by smtp.gmail.com with ESMTPSA id z15-20020a05651c022f00b002a79f22a03dsm502963ljn.0.2023.04.13.16.37.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 16:37:43 -0700 (PDT)
Message-ID: <a1d0767e-7f5e-2322-81d3-6f7abad454f9@linaro.org>
Date:   Fri, 14 Apr 2023 01:37:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sa8155p-adp: Make -cells decimal
Content-Language: en-US
To:     Andrew Halaney <ahalaney@redhat.com>, linux-kernel@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230413194020.1077857-1-ahalaney@redhat.com>
 <20230413194020.1077857-2-ahalaney@redhat.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230413194020.1077857-2-ahalaney@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.04.2023 21:40, Andrew Halaney wrote:
> The property logically makes sense in decimal, and is the standard used
> elsewhere.
> 
> Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> Changes since v1:
>     * New patch (Konrad)
> 
>  arch/arm64/boot/dts/qcom/sa8155p-adp.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> index 029b23198b3a..ac52a8dfeba1 100644
> --- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> @@ -353,8 +353,8 @@ &ethernet {
>  
>  	mdio {
>  		compatible = "snps,dwmac-mdio";
> -		#address-cells = <0x1>;
> -		#size-cells = <0x0>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
>  
>  		/* Micrel KSZ9031RNZ PHY */
>  		rgmii_phy: phy@7 {
