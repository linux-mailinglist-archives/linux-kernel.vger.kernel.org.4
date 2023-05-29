Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB7471494B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 14:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjE2MTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 08:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjE2MTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 08:19:17 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DE1C9
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 05:19:14 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f3b4ed6fdeso3345659e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 05:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685362753; x=1687954753;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YECXa3X/DxmraiWq2kY1kuESj9S065EhI3PmyoIgQQU=;
        b=jVBrGtJnd6soXtOqbUpHJU1830vJv+VTsU77nmdFHHhlV/9Ho04aTrAHvGu8QGikjZ
         KYayQyXjcBm+YVmxLl+ws1vFxcpQxT6asCZTQdm4DckgOdfKtHuN4jr4LzbREd9DQUhN
         Hz3rMoPrBTmTl/6Sf/g7gVXVqselWbcTxF4D3TNrizHitQprx+/vexyiPgygga1Dp1me
         B/LRYoRe4LLeL+7ekja1fv6BunFx4gVPmX8YSeIDBiFeSKRDnelmXOnrgyvLA6oPGTyR
         y1By6leTvSwqXtWMoomn+XkHTrI0w7RK3CJbiT3tQeyzugGG3kkRhI8/IsHS+nIqklQW
         A7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685362753; x=1687954753;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YECXa3X/DxmraiWq2kY1kuESj9S065EhI3PmyoIgQQU=;
        b=F1MX01RONJ1SMaVKsv+NmoX78JazEmR2iWGNXOO3pGnzZOLZ+7vUD+fhujSBuPazGI
         DU4A1LzL2rx92DL4LAEREspBKpGsVZphM7idQFz3/2w9cK+cccrv5j5imlQYYMbcAeme
         jFM/zukpNzvMMdiYnqnR2kDQTfZ24vHDS/tPDJIcA4mxrN2gcWlEQTRjCzmaa+p8Bwa5
         GEeyme/j8KqJwaAO1ri2umWTRXVE+uWq9oK+mm7Bb+JTpVRuIh+BvPZaq+pqjp1u7xTg
         2fkdqIlzy4VlyZAZOiVgeOYbyXXTVapKTzpYL1jk/dthnfTQuIX6loLSRB2JMgbI0VcT
         VQdw==
X-Gm-Message-State: AC+VfDzKohoCzkmAeH8H1kPn1PfG2x60DyCjlIF6iPn2LNxxQERsfSHb
        qtJ9kXbbDqVEIruD92jZzfxClQ==
X-Google-Smtp-Source: ACHHUZ763qQqMP7KPrX70p+UDKi6WNOOXFBaePb7niWyZD7/Ea1KfN14TiBixaTiQxjWYxnhiHXcMw==
X-Received: by 2002:a19:5201:0:b0:4f4:3418:4726 with SMTP id m1-20020a195201000000b004f434184726mr2931247lfb.56.1685362753224;
        Mon, 29 May 2023 05:19:13 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id 16-20020ac24830000000b004f13c00dd9bsm1972467lft.135.2023.05.29.05.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 05:19:12 -0700 (PDT)
Message-ID: <58e7e5ff-5e40-7871-efe2-bfe88bd19dad@linaro.org>
Date:   Mon, 29 May 2023 15:19:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 7/7] ARM: dts: qcom: msm8226: Add mdss nodes
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230308-msm8226-mdp-v1-0-679f335d3d5b@z3ntu.xyz>
 <20230308-msm8226-mdp-v1-7-679f335d3d5b@z3ntu.xyz>
 <6c79b99e-cc69-8cd9-c990-5c0373e1f09c@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <6c79b99e-cc69-8cd9-c990-5c0373e1f09c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 29/05/2023 15:10, Konrad Dybcio wrote:
> 
> 
> On 29.05.2023 11:44, Luca Weiss wrote:
>> Add the nodes that describe the mdss so that display can work on
>> MSM8226.
>>
>> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
>> ---
>>   arch/arm/boot/dts/qcom-msm8226.dtsi | 118 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 118 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
>> index 42acb9ddb8cc..182d6405032f 100644
>> --- a/arch/arm/boot/dts/qcom-msm8226.dtsi
>> +++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
>> @@ -636,6 +636,124 @@ smd-edge {
>>   				label = "lpass";
>>   			};
>>   		};
>> +
>> +		mdss: display-subsystem@fd900000 {
>> +			compatible = "qcom,mdss";
>> +			reg = <0xfd900000 0x100>, <0xfd924000 0x1000>;
>> +			reg-names = "mdss_phys", "vbif_phys";
>> +
>> +			power-domains = <&mmcc MDSS_GDSC>;
>> +
>> +			clocks = <&mmcc MDSS_AHB_CLK>,
>> +				 <&mmcc MDSS_AXI_CLK>,
>> +				 <&mmcc MDSS_VSYNC_CLK>;
>> +			clock-names = "iface", "bus", "vsync";
> One per line, please
> 
>> +
>> +			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +			interrupt-controller;
>> +			#interrupt-cells = <1>;
> We're not using the irq cell, is that necessary/should that be 0?

No. With 0 it would mean that there is a single interrupt for mdss 
source, which clearly is not the case.

> 
>> +
>> +			status = "disabled";
> status should go last
> 
>> +
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges;
>> +
>> +			mdp: display-controller@fd900000 {
>> +				compatible = "qcom,msm8226-mdp5", "qcom,mdp5";
>> +				reg = <0xfd900100 0x22000>;
>> +				reg-names = "mdp_phys";
>> +
>> +				interrupt-parent = <&mdss>;
>> +				interrupts = <0>;
>> +
>> +				clocks = <&mmcc MDSS_AHB_CLK>,
>> +					 <&mmcc MDSS_AXI_CLK>,
>> +					 <&mmcc MDSS_MDP_CLK>,
>> +					 <&mmcc MDSS_VSYNC_CLK>;
>> +				clock-names = "iface", "bus", "core", "vsync";
> One per line, please
> 
>> +
>> +				ports {
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
> Would port { work here? I remember one mdss component's bindings
> didn't allow it but don't recall which one

Let's use ports /port@0 for uniformity even if there is just a single 
port always.

> 
>> +
>> +					port@0 {
>> +						reg = <0>;
>> +						mdp5_intf1_out: endpoint {
>> +							remote-endpoint = <&dsi0_in>;
>> +						};
>> +					};
>> +				};
>> +			};
>> +-- 
With best wishes
Dmitry

