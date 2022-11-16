Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7518062B484
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbiKPIGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbiKPIGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:06:42 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439D960CF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:06:40 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id a29so28279013lfj.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fKd7Yo84i9pn2aBsrALEMa4PQZQFgzR1vfN2JTI7Ycc=;
        b=Lp3snV8gK9HjD6M78egcBQyDsmDvDETQHE5heDqcQ4G2m0tFvjvViRsqhz5kb3FEVC
         uE5j25kEIRDBGnlBKsHP0fB9VpqKTeveXGKlUjAUxdXP+GePMbwrnbdAQzGycvMZRvdX
         S1JQ5Z9QhsCqnmmH9VNrgxHR/9ZziQYL5m8i4Od5/kLVQNViGLq1YTbl5Gjg205ApzHi
         IH01DGpQhEiaHtcQmmhYoEt+vw9c8u6X2WNWXAoNxhv86T28T8OIdxvvDRyWUL1miIlS
         pafoPeSHSk5HZZMKUXi4HZiIvFagbOvpfhjeV1yRsLRTRc6E9gjbRYQXzr4adf7UON9L
         tkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fKd7Yo84i9pn2aBsrALEMa4PQZQFgzR1vfN2JTI7Ycc=;
        b=RkrkpH+HhOuqL0riNTRrv0Rm/XikR+FG1iutEI1HA2ZglljwOBSvM3Y9bYs99IyCnh
         UjMQG9FKBeZ3on7OKYvAmuL2/MkydttViMaldTmhSncpBx3yYsV+WUEvvY+++nEs6lOP
         zL6y/djoxwGLzHjSGL1BdrNflP9uE/fluO/AXEeQKtB0gqx7/o4Kl6B2wBnzu8DfF3ma
         CnOpIVLSYFCDa5W1XNJx4oTv6dPS/hMmScRmEGDFdACMnHrm+GOmgaNOBMU8gBNI3msB
         y6uj5ymJEn0RI16YdOeIj5UHKyc65vLmmi9lcpfZZmelaX4ptgRMSgwN9lUSeNk7MR4V
         HnIg==
X-Gm-Message-State: ANoB5pl1gi4g4XozqaCzqaN335ev9ERDN45MkPDFGU7wUrJHQcZEyheO
        am0zSgt3nuBaQVg2Vl3hm6cGlA==
X-Google-Smtp-Source: AA0mqf4PP9jpnoyfyQrubk8wnkL8+vckpPhEMFj9DwEB5+RDGUZdh1rLLJz+EYhnUZRLRhGryhkaKQ==
X-Received: by 2002:a19:4902:0:b0:4ac:e5ff:d1d8 with SMTP id w2-20020a194902000000b004ace5ffd1d8mr6488238lfa.304.1668585998598;
        Wed, 16 Nov 2022 00:06:38 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m4-20020a056512358400b0048b003c4bf7sm2484353lfr.169.2022.11.16.00.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 00:06:38 -0800 (PST)
Message-ID: <9055fbf4-3bc3-bd44-6081-f422c75f11f1@linaro.org>
Date:   Wed, 16 Nov 2022 09:06:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sc8280xp/sa8540p: add gpr node
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        agross@kernel.org, andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221115170242.150246-1-srinivas.kandagatla@linaro.org>
 <20221115170242.150246-2-srinivas.kandagatla@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221115170242.150246-2-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2022 18:02, Srinivas Kandagatla wrote:
> Add GPR node along with APM(Audio Process Manager) and PRM(Proxy
> resource Manager) audio services.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 40 ++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index c32bcded2aef..e3cdd8bccb0c 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -12,6 +12,7 @@
>  #include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>  #include <dt-bindings/thermal/thermal.h>
> +#include <dt-bindings/soc/qcom,gpr.h>
>  
>  / {
>  	interrupt-parent = <&intc>;
> @@ -1152,6 +1153,45 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
>  
>  				label = "lpass";
>  				qcom,remote-pid = <2>;
> +
> +				gpr {
> +					compatible = "qcom,gpr";
> +					qcom,glink-channels = "adsp_apps";
> +					qcom,domain = <GPR_DOMAIN_ID_ADSP>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					qcom,intents = <512 20>;
> +
> +					q6apm: q6apm {
> +						reg = <GPR_APM_MODULE_IID>;
> +						compatible = "qcom,q6apm";
> +						#sound-dai-cells = <0>;
> +						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
> +						q6apmdai: dais {
> +							compatible = "qcom,q6apm-dais";
> +							#sound-dai-cells = <1>;

DAI cells are not allowed by binding, so either drop it or update binding.

> +							iommus = <&apps_smmu 0x0c01 0x0>;
> +						};
> +
> +						q6apmbedai: bedais {
> +							compatible = "qcom,q6apm-lpass-dais";
> +							#sound-dai-cells = <1>;
> +						};
> +					};
> +
> +					q6prm: q6prm {
> +						reg = <GPR_PRM_MODULE_IID>;
> +						compatible = "qcom,q6prm";
> +						#clock-cells = <2>;

Not allowed by binding.

> +						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
> +						q6prmcc: cc {

This should be "clock-controller".

> +							compatible = "qcom,q6prm-lpass-clocks";
> +							#clock-cells = <2>;
> +						};
> +					};
> +

Drop empty line

> +				};
> +

Ditto

>  			};
>  		};
>  

Best regards,
Krzysztof

