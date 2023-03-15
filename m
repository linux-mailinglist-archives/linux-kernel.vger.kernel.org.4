Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260E86BB93A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjCOQNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjCOQND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:13:03 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0475F77E3A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 09:12:19 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id y15so15443471lfa.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 09:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678896736;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K0OLhRwBZUXAroD52YnUEKfUVbYdP0JZ4pBXfynEgGw=;
        b=GUg79Z3dywg0YMkFHwdHHjk22rF34WpmjNSOHiM0HqKQDSDR+Bx3d0isn1pBzRQIBz
         OorAN6i29P6pudonEGuIHdOtIAji4VMiUr9+bX5ccmSbi8f/hME23bEne/BtVyNy2NO/
         MnKZo8hBCMCOvG/nlwMEpfL6hOqXe8j+7pxcF1xsHezKnu7CmhwmnxDzxAWetm3P5huR
         MGzVR5BLB+3oovmOFex9H53oaD73FSSFxZGQtzPBd7GaeLt8YoBha/SldhtWqwa2eB+x
         z++KTHnS8L4KNQMg6SE4DeYvYTQlFwUCSBbIwcMHchNsI5DIzbrUp6yMHW3qUKT1+X2v
         oTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678896736;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K0OLhRwBZUXAroD52YnUEKfUVbYdP0JZ4pBXfynEgGw=;
        b=TexuUKWrCToz246HMB5K11MfrGwgNDnWvnEK+lfNFpdEGDDUQVt21fUlb4iVcq7IoD
         plS5NKujL1l2reKhsAH/T8c81T6zXVhRCYz2hEEmJu9kQwOnGnfS56NThzxyGc37yctQ
         +wM/4QxdhPs6DbTVqEdxxMbj+2ZCGG7Ia7R0LdAlmQcGwsq2HUkJS/bSIT0oCQYNnChp
         /XCTwANNYvdNFmPGe/anS5kDJz/ph4fA8LXf9jJu4eZ3Ylmr+W/fYwiCyt5/5dtr49Tg
         PIJWEvaJ/b+TWVdrWNLDnysxH+zesov224H0nUPc9auWLNkvsu4GjhkZOiS8OkNfHjzG
         sP6g==
X-Gm-Message-State: AO0yUKVl99ZtphPSAjr/zXyHsIrZKSda50CPz9H8S8y6JX9M6anapLnh
        3FhIGgWLaxOflJrTjMxyuy5tzA==
X-Google-Smtp-Source: AK7set++vhw53JNzMFar/FeOi62TZ0R1feBNM/HCyPK0A9CLOdUbyO71XiTiyZwJdBke+D3BopP1BA==
X-Received: by 2002:ac2:57db:0:b0:4dc:8215:5531 with SMTP id k27-20020ac257db000000b004dc82155531mr1871126lfo.6.1678896735773;
        Wed, 15 Mar 2023 09:12:15 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id x14-20020ac25dce000000b004ceb053c3ebsm865200lfq.179.2023.03.15.09.12.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 09:12:14 -0700 (PDT)
Message-ID: <3557aa94-6a83-d054-a9d9-81751165eb8a@linaro.org>
Date:   Wed, 15 Mar 2023 17:12:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/4] arm64: dts: qcom: sc7180: Don't enable lpass
 clocks by default
Content-Language: en-US
To:     Nikita Travkin <nikita@trvn.ru>, agross@kernel.org,
        andersson@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Douglas Anderson <dianders@chromium.org>
References: <20230315154311.37299-1-nikita@trvn.ru>
 <20230315154311.37299-2-nikita@trvn.ru>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230315154311.37299-2-nikita@trvn.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.03.2023 16:43, Nikita Travkin wrote:
> lpass clocks are usually blocked from HLOS by the firmware and
> instead are managed by the ADSP. Mark them as reserved and explicitly
> enable in the CrOS boards that have special, cooperative firmware.
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
+CC Doug

Please confirm whether this also applies to IDP (in which case
this would have been a bugfix).

Konrad
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 8 ++++++++
>  arch/arm64/boot/dts/qcom/sc7180.dtsi         | 4 ++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> index 423630c4d02c..26def6e12723 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> @@ -785,6 +785,14 @@ alc5682: codec@1a {
>  	};
>  };
>  
> +&lpasscc {
> +	status = "okay";
> +};
> +
> +&lpass_hm {
> +	status = "okay";
> +};
> +
>  &lpass_cpu {
>  	status = "okay";
>  
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 53f0076f20f6..f0de177981f9 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -3623,6 +3623,8 @@ lpasscc: clock-controller@62d00000 {
>  			power-domains = <&lpass_hm LPASS_CORE_HM_GDSCR>;
>  			#clock-cells = <1>;
>  			#power-domain-cells = <1>;
> +
> +			status = "reserved"; /* Controlled by ADSP */
>  		};
>  
>  		lpass_cpu: lpass@62d87000 {
> @@ -3671,6 +3673,8 @@ lpass_hm: clock-controller@63000000 {
>  
>  			#clock-cells = <1>;
>  			#power-domain-cells = <1>;
> +
> +			status = "reserved"; /* Controlled by ADSP */
>  		};
>  	};
>  
