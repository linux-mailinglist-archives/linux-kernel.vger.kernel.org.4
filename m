Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976F373DBB2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjFZJqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjFZJqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:46:33 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82399C7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 02:46:31 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b69f958ef3so13470451fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 02:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687772790; x=1690364790;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AALGroa+oxrQ4QAJxx6E4/UMQk8ojzz4Y2q62IP4vFI=;
        b=meGT7R2tRZt+cvxEidV5mPxrhTtG+1180rEwRUdYShJHuvVDZgaszHDKGTSGmepGun
         GUfUHJkmfh2UxiKhuk1/Jq8t0Cc6pZFOslyOrCGC/PwvM0UhtlHdMBQBfts7GXou0Juo
         SnbBQqp417VGhxsIxE4+rst1V3YaZ9GDL2Rf2E5LFHBh06AK/8NLLTCRqd9lzvaDdbPn
         l+UF2AMuhD/v725R+sbLY+evphljTz8qfB1dQV0GzduYmdmGY7//qHkBXzC4qeQfjFDM
         yDAeQ78AOomqFH3443ArtMhunOcyVptq2QF69TN2AWI/QJ2lFVgHtsiP7nr9/GSUfYDh
         b6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687772790; x=1690364790;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AALGroa+oxrQ4QAJxx6E4/UMQk8ojzz4Y2q62IP4vFI=;
        b=ZdImJeIs0/Z+8Z2BpH9rRmEOaXjyCj7J5IpGIIWN+uDtygjZIK1iHr49fx8lcvdwvJ
         Hb1sJmVi2amtqnQH08jAwvsMo8+COGUJTT7M4qXSYYrDEYBqZxBSE3jzcnBwdOLDeKf+
         TEX08tls6EV/nWbNPu2SjjJAQ3L6i0JMJYI7e6yapzdmpS4bqWvXttKviouIyCBWpgM5
         rm4L22rnvcgewWsHkCl6cuQZgVo3WZ82zsUVjRvoWBjxizriAye37SA26kcNAf3AXSkM
         2IIe3G2riWGdqqrKyProJEN4BYeWNalm09bAShLJuWwqiNeSd01/qWW2ciWAq8lQ2K+T
         7rlA==
X-Gm-Message-State: AC+VfDzurEFo6SWJ5akkq11AnfDEaZD1lR8kxvznF4pg9je4znk67cfu
        mDZzML8rVxCSY8WTlom9lMrWPg==
X-Google-Smtp-Source: ACHHUZ5KPZnllce2bChpYblFlyi/WUt304k5xmFjzG6Ny9pe88sqe7XeDP4dm9DtG/uaJGBpFlxfYA==
X-Received: by 2002:a05:6512:2513:b0:4f9:608b:1e58 with SMTP id be19-20020a056512251300b004f9608b1e58mr8026993lfb.20.1687772789751;
        Mon, 26 Jun 2023 02:46:29 -0700 (PDT)
Received: from [192.168.1.101] (abyk179.neoplus.adsl.tpnet.pl. [83.9.30.179])
        by smtp.gmail.com with ESMTPSA id j23-20020a19f517000000b004f842e58d08sm1024860lfb.84.2023.06.26.02.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 02:46:28 -0700 (PDT)
Message-ID: <aae76828-fcc8-506b-e68b-775f864fd159@linaro.org>
Date:   Mon, 26 Jun 2023 11:46:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] arm64: dts: qcom: pm8953: Add thermal zone
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230625-pm8953-thermal-v1-1-2b4247d2f769@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230625-pm8953-thermal-v1-1-2b4247d2f769@z3ntu.xyz>
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

On 25.06.2023 13:13, Luca Weiss wrote:
> Define the themal zones using the temperature values found in the
> downstream 4.9 sources so that the spmi-temp-alarm driver becomes
> active.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/pm8953.dtsi | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm8953.dtsi b/arch/arm64/boot/dts/qcom/pm8953.dtsi
> index 2268daf27fa7..d2dfc1699174 100644
> --- a/arch/arm64/boot/dts/qcom/pm8953.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8953.dtsi
> @@ -6,6 +6,37 @@
>  #include <dt-bindings/input/linux-event-codes.h>
>  #include <dt-bindings/spmi/spmi.h>
>  
> +/ {
> +	thermal-zones {
> +		pm8953-thermal {
> +			polling-delay-passive = <0>;
> +			polling-delay = <0>;
> +
> +			thermal-sensors = <&pm8953_temp>;
> +
> +			trips {
> +				trip0 {
> +					temperature = <105000>;
> +					hysteresis = <0>;
> +					type = "passive";
> +				};
> +
> +				trip1 {
> +					temperature = <125000>;
> +					hysteresis = <0>;
> +					type = "hot";
> +				};
> +
> +				trip2 {
> +					temperature = <145000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +	};
> +};
> +
>  &spmi_bus {
>  	pmic@0 {
>  		compatible = "qcom,pm8953", "qcom,spmi-pmic";
> @@ -36,7 +67,7 @@ pm8953_resin: resin {
>  			};
>  		};
>  
> -		temp-alarm@2400 {
> +		pm8953_temp: temp-alarm@2400 {
>  			compatible = "qcom,spmi-temp-alarm";
>  			reg = <0x2400>;
>  			interrupts = <0x0 0x24 0x0 IRQ_TYPE_EDGE_RISING>;
> 
> ---
> base-commit: 8d2be868b42c08290509c60515865f4de24ea704
> change-id: 20230625-pm8953-thermal-fc3b2deeeb7b
> 
> Best regards,
