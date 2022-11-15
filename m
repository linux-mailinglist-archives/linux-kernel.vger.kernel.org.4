Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C3D6296B3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238221AbiKOLD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiKOLCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:02:42 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08525593
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:02:20 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id f18so2099643ejz.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuQI0zmg5YQqxAgi4jYV2foOsi/eK7WouKuyO2C6Mi4=;
        b=yUkyueYuIA6mvvMhuNr4d4fyRlg1+z/1nlHknrfF+iGTGPb5SvZfp0oJNlPfvK0+uQ
         oYrT3f5UKeOnq1csuyxcE2fFrosn3osbBWRG+QQLMxZQrGKaQBuOetZZOh7WYSJBUOD4
         qeWM8+NaNZ3gJplR4BEBgeUeE1eRMSDDcJChDyv2mN0u6rf5bpntjzLc1baB1UM0oakP
         9VRRTv3X+Pc6PP1ECqU8gLDJ5ybnfkByZ5MybURqxw4Z0jrLpF9OEDHyG/rUHh6lKhju
         mRBmaIC9zHTVkH3SYj4YxyIa01MkeKkxuEgeZMsPwvyI7HKLVX0qIuK/0wo9NwwtsZP2
         YyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PuQI0zmg5YQqxAgi4jYV2foOsi/eK7WouKuyO2C6Mi4=;
        b=0hidiCKAoGaJ5DDXuCc08clvmgUaSagTzkULo9w/I53YaihQQyT1Ux5lSoruU5KCgI
         RF1YnzRDeO1QQIlm6KmeHyuGCsDkcae/0YnADBu7p4bvb3mvST0xAzy0+6l1H4m5hoEi
         cRhIj3atWFyFBGY71qoO7WMER+4HVfX/PU3vp0O5nKNahxWNflieS2zAweIVPupH98q5
         rZEdZ4VIDJXQA+XqZ/rBpg19C9pyxoi8VO96z3zNkiXTxpbCf5gIjGxgMtQKHY/x9p1G
         F5Z3sVYMIQJrbxiUkdvYYj9SRVQZA1Koz9gVbDT6JyuuS8X9n++17tqdNygVCVfICAhL
         q6Pg==
X-Gm-Message-State: ANoB5pl2YYxBKZ6zgdNT4aaJRSM2Dad7NBByuP4kST0js0Z+5ZmbYFUL
        8/oefF7AvrS2gPOK27AFrkQsLA==
X-Google-Smtp-Source: AA0mqf43XICFch3FwNM6+s5GDrd47XjZXR9A4JLoedcljX6EkfacflFzDu/vEmO4zIIqHMt2a6zkHQ==
X-Received: by 2002:a17:907:8c06:b0:78d:f3f4:b1a0 with SMTP id ta6-20020a1709078c0600b0078df3f4b1a0mr13301391ejc.489.1668510139307;
        Tue, 15 Nov 2022 03:02:19 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id qk13-20020a170906d9cd00b0078ca30ee18bsm5484484ejb.95.2022.11.15.03.02.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 03:02:18 -0800 (PST)
Message-ID: <b2d1e035-7b6a-8fe7-1625-aec007685b82@linaro.org>
Date:   Tue, 15 Nov 2022 12:02:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: sm8450: add GPR node
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20221115110053.110319-1-krzysztof.kozlowski@linaro.org>
 <20221115110053.110319-2-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221115110053.110319-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/11/2022 12:00, Krzysztof Kozlowski wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Add Generic Packet Router (GPR) device node with ADSP services.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Co-developed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 40 ++++++++++++++++++++++++++++
>   1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 46f9576f786f..4b0a1eee8bd9 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -13,6 +13,7 @@
>   #include <dt-bindings/mailbox/qcom-ipcc.h>
>   #include <dt-bindings/power/qcom-rpmpd.h>
>   #include <dt-bindings/interconnect/qcom,sm8450.h>
> +#include <dt-bindings/soc/qcom,gpr.h>
>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>   #include <dt-bindings/thermal/thermal.h>
>   
> @@ -2134,6 +2135,45 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
>   				label = "lpass";
>   				qcom,remote-pid = <2>;
>   
> +				gpr {
> +					compatible = "qcom,gpr";
> +					qcom,glink-channels = "adsp_apps";
> +					qcom,domain = <GPR_DOMAIN_ID_ADSP>;
> +					qcom,intents = <512 20>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					q6apm: service@1 {
> +						reg = <GPR_APM_MODULE_IID>;
> +						compatible = "qcom,q6apm";
> +						#sound-dai-cells = <0>;
> +						qcom,protection-domain = "avs/audio",
> +									 "msm/adsp/audio_pd";
> +
> +						q6apmdai: dais {
> +							compatible = "qcom,q6apm-dais";
> +							iommus = <&apps_smmu 0x1801 0x0>;
> +						};
> +
> +						q6apmbedai: bedais {
> +							compatible = "qcom,q6apm-lpass-dais";
> +							#sound-dai-cells = <1>;
> +						};
> +					};
> +
> +					q6prm: service@2 {
> +						reg = <GPR_PRM_MODULE_IID>;
> +						compatible = "qcom,q6prm";
> +						qcom,protection-domain = "avs/audio",
> +									 "msm/adsp/audio_pd";
> +
> +						q6prmcc: clock-controller {
> +							compatible = "qcom,q6prm-lpass-clocks";
> +							#clock-cells = <2>;
> +						};
> +					};
> +				};
> +
>   				fastrpc {
>   					compatible = "qcom,fastrpc";
>   					qcom,glink-channels = "fastrpcglink-apps-dsp";
