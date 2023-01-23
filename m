Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12B36781DA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbjAWQko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbjAWQka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:40:30 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E541E2D175
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:39:09 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id mp20so32013778ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sOMakOD7xIn+dFf8F4hTOC/FgKd0/tr1iN5ftxQWKRI=;
        b=DV5RZNXMs2lLP0/NBV7jzvirEcgC37TFewowKpRNQSpVIBwIHxEr1k8iJ1Fstb17+s
         flcENq8cPzEh9uAV+WjkwWhuKdfLJsm513mDJ3+j5W+ytUaa7MCLNCJAQIH/yLHBdkKk
         UT4et/QOxoDUEnIRlZCyZTGXhAg/eWyBx7kEHLq2PR97RFDGcTedXynD+lJKeQwreN1l
         4+bCHPZc2ZFAPk2+yZxSXufaFRNhBuAa4XGvBw0XmpGbffhLtH2dhkpF0ZF7HLpoeRww
         NKH5vREvBdoqOqLWHRThSv7uFmEWCL7XM6VmrfzcLy+a/Rcu1Eb/+dWJxX7YRspSxDTu
         O35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sOMakOD7xIn+dFf8F4hTOC/FgKd0/tr1iN5ftxQWKRI=;
        b=0pR1AwESW3ixlqgSMhOqw/2/1U2nGeEN/Pvqi6G24k5ejZHVXH/8dUyFCftM8gWe2U
         mcHmcrAKLWaSt+WuRGIS2WyNl+4+tRdSsOucF3NMRs8swz0/wHQfe72qOOns3J9Y4ED+
         v89k9qGYJY7CKiwFGP5ZiSGymOa+CvsvxQHPhj6HfteRaa/y4e3ab4d8qAD+AgVoPADR
         4WupRk1zetoNl5bafbrD3/S1wkaSOiNtfZfSqmph+E3fmXtErziovd/QTl63lm2ilrdp
         qqvFjtnudv3ktrB0YtsnheB8BtJ9pVnw4sTp5UeWW5G1e2XqcZp4OhMbzecTJM8zVoSh
         IGYw==
X-Gm-Message-State: AFqh2krtMb3c4taoRiD9xp0gt//wLqUoR4E1g7QsEEc+sNU5YB5ENWUO
        Yan9q6l1E4Lh2FVUV9SQjdKdXg==
X-Google-Smtp-Source: AMrXdXt28hHW6x7xG51Ffn8C7CrwvdlM0Q2tQIawdl33so9CBuSBJN4v3WEyigB0jGsR2/hnwzAOpA==
X-Received: by 2002:a17:907:6021:b0:843:a9fe:f115 with SMTP id fs33-20020a170907602100b00843a9fef115mr24119996ejc.32.1674491945669;
        Mon, 23 Jan 2023 08:39:05 -0800 (PST)
Received: from [192.168.1.101] (abxi24.neoplus.adsl.tpnet.pl. [83.9.2.24])
        by smtp.gmail.com with ESMTPSA id s17-20020a1709060c1100b0084d21db0691sm22503260ejf.179.2023.01.23.08.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 08:39:05 -0800 (PST)
Message-ID: <49427fdd-e0fe-0a96-597f-b56b373cf63e@linaro.org>
Date:   Mon, 23 Jan 2023 17:39:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 1/5] ARM: dts: qcom: pm8941: Add vibrator node
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230122-msm8974-bacon-features-v1-0-4049f565c24c@z3ntu.xyz>
 <20230122-msm8974-bacon-features-v1-1-4049f565c24c@z3ntu.xyz>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230122-msm8974-bacon-features-v1-1-4049f565c24c@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.01.2023 17:48, Luca Weiss wrote:
> Add the node describing the vibrator that's found on pm8941.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom-pm8941.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom-pm8941.dtsi
> index cd957a1e7cdf..a821f0368a28 100644
> --- a/arch/arm/boot/dts/qcom-pm8941.dtsi
> +++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
> @@ -161,6 +161,12 @@ pm8941_lpg: pwm {
>  			status = "disabled";
>  		};
>  
> +		pm8941_vib: vibrator@c000 {
> +			compatible = "qcom,pm8916-vib";
> +			reg = <0xc000>;
> +			status = "disabled";
> +		};
> +
>  		pm8941_wled: wled@d800 {
>  			compatible = "qcom,pm8941-wled";
>  			reg = <0xd800>;
> 
