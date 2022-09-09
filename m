Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E990C5B3D2C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 18:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiIIQj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 12:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiIIQj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 12:39:28 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DFD9A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 09:39:22 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id f9so2912825lfr.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 09:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Af4zlABcQ7iyW/0hGd2YIxWtO+SJq7WH8x4IJPqk7j4=;
        b=Tz4BiYwXwq8pe/3/uLts5EMGxwbjsqrgFDL05nLLU9Vuk4Hcs2MXoWFgMbrS9UF6tx
         BUKobU5FFkpBRGVDugfk9qfK708lqbJxetwltNEIHTL7rK7az8gO5zp49foik8pc546U
         RlcBWBOf5bRjYH9KMHvmTdrs6Xv3yZeh2rPnQkic8iKpNFmadQw3jKUWGCWyfK19+oLi
         cnS4cAalg4E6Sy76tf46JaVkszWF/sTcOMJ3rlBhfc9fX3coyMLp+TvjDS8GitOfGjKa
         lEn6NAERwSNJ8oai2bLT6J1JWS6bqeK8CWp2ONZX71ALFUD+OotS2vl0HCzysVfweU63
         oHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Af4zlABcQ7iyW/0hGd2YIxWtO+SJq7WH8x4IJPqk7j4=;
        b=XpCqtmdDanHukFAlhnAsHrUCw033T6hL816ULl07Csr+JlCnu2Tz2u5CE+OngtgCU7
         AeoP4QKAG1m4Gzp9ynE3X956tbcsm5O+JOGYQ4czvAVNoE5ntCKhRJOabJ5KuH7i6hkx
         5nttO9UR6LFywDVnNm/PaxPn2X3k9rivRKddcbYI3nClRL8zmyaIrVJoOfOPMENQ6Nht
         4CphlmV00nbolsX0xNLRfcERf3zIJaSxj3gCFwtQXR1AkYrjUQWz0FdUMDt29ShjFDF0
         tVphDWQWKG4vdWRskilOIxTlhKc2Kziu1mOOf+r/VviiA+4DXrhn1Hv/5PcQg8CYHinZ
         hu9Q==
X-Gm-Message-State: ACgBeo2ErYBOPQmy7ND6Iac0PpRuYrgp5WK/oRnK7LTgNM4dK1qUXId1
        PpONordR0orv24HylyNKuhTbJQ==
X-Google-Smtp-Source: AA6agR5pyA/oh/zU7TqvcwHudEeiax77oGDyUrXHpUJjnbyOL2kcrbcs10pNE9iNmJTZ8GnrC0bNGA==
X-Received: by 2002:a05:6512:c1:b0:497:acd3:10cf with SMTP id c1-20020a05651200c100b00497acd310cfmr3965183lfp.484.1662741560395;
        Fri, 09 Sep 2022 09:39:20 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id p9-20020a2e7409000000b0026be1de1500sm139385ljc.79.2022.09.09.09.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 09:39:19 -0700 (PDT)
Message-ID: <3882e496-3082-8db3-c730-1e14554bbcf8@linaro.org>
Date:   Fri, 9 Sep 2022 18:39:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/3] arm64: tegra: Add PWM controllers on Tegra234
Content-Language: en-US
To:     Sandipan Patra <spatra@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bbasu@nvidia.com, kyarlagadda@nvidia.com
References: <20220909155258.17908-1-spatra@nvidia.com>
 <20220909155258.17908-2-spatra@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220909155258.17908-2-spatra@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2022 17:52, Sandipan Patra wrote:
> Tegra234 has eight single-channel PWM controllers, one of them in the
> AON block.
> 
> Signed-off-by: Sandipan Patra <spatra@nvidia.com>
> ---
> V3: Update binding doc and fix compatible property.
> 
>  arch/arm64/boot/dts/nvidia/tegra234.dtsi | 80 +++++++++++++++++++++++-
>  1 file changed, 78 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> index 81a0f599685f..d77ee9d81fb2 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> @@ -829,8 +829,7 @@
>  		};
>  
>  		pwm1: pwm@3280000 {
> -			compatible = "nvidia,tegra194-pwm",
> -				     "nvidia,tegra186-pwm";
> +			compatible = "nvidia,tegra194-pwm";

Where is the fallback?

Best regards,
Krzysztof
