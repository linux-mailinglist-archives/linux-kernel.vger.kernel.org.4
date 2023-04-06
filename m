Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EA96DA196
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237484AbjDFTiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237398AbjDFTiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:38:01 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F181C5243
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 12:37:59 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id a44so23101726ljr.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 12:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680809878;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fn/qW+05tEcNxsPMIt5hiBunCS6pFmLZ+qeBgbNr6rk=;
        b=ydNEZSh3jPcgy9aWdd5OieQ5pm92NZKgwL15Or3pBc/yPZHiN2mXvaPPAxAHwLAKRU
         Ds/F7U3SgSOu84DDAwOFxzGxCBKj9rLMYlpuNzdUEx4Y0fVgtlhGXXKaCXU+B32LA1mY
         wQ+41W7ddOw9EogrBcBhpVaQBZLYF9VK19W5au9ozRqRCXiqu28w/ndIeYJcqvab4r0g
         UOWvJBWDmmap1GJeruG8Re7zeil45zH/m7azGnIpKy2utA2OFiIzcnaFMIra1Icrl6My
         OQqhX352gAJdYdlFyOrSFPJy/W5U43QRFcg5xuqHVqh14lO7MNXLWtnJ3A0fsEJu77Tz
         ivOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680809878;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fn/qW+05tEcNxsPMIt5hiBunCS6pFmLZ+qeBgbNr6rk=;
        b=zHWsrIJepPNBixQ4qOXYLowxgLteTX+P6kWmkLR4L4UD2gF62uI9wZqrcQPaaPsI+G
         3EG5/JwaV0b5PiqaCT/leT64BGRXeUjJ2gEWSW8eWNP7PZ17MQ6AfQLPXDJWm9gWW20n
         n+EtBuJWyhMJyn4yVrST5U37k+jxpyIw4kKmTlSDZcOlfdKol3JtylLZhBp3fVYPzCMv
         Xjuo+gnBvcJ0jZ3RIajAMc7CuWYUtGGsUXGwj6DbHlfMWT0G6/2EFIdUXcFTns25NshL
         DWPfYvz0mS+Tta1kI8BEQlP3G58ge3e6ygAG6Yg7YGPDIsP7qY3Z8CDAemaBOzlfrck5
         cfQg==
X-Gm-Message-State: AAQBX9f3a+wn4yO9oSS+tZ1E5Bn0hyNDF3aSSZ8hMJpQod+O754GA1dW
        mWbxscuRyrOYCTG/SsLx+e9vKA==
X-Google-Smtp-Source: AKy350ZiEnH3jFcVDrFDL0t7iagN6VcFlfZQMMWtuFzdCnrE1piPN3ll0AIjE61dtUBLLd+maDY9Ow==
X-Received: by 2002:a2e:b0c6:0:b0:2a6:2577:5dc5 with SMTP id g6-20020a2eb0c6000000b002a625775dc5mr3197015ljl.49.1680809878208;
        Thu, 06 Apr 2023 12:37:58 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id r10-20020a2e80ca000000b002989fc0a69csm410649ljg.124.2023.04.06.12.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 12:37:57 -0700 (PDT)
Message-ID: <730dc797-fea5-653c-1314-e5c51f52b557@linaro.org>
Date:   Thu, 6 Apr 2023 21:37:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V3 3/5] arm64: dts: qcom: ipq9574: Add RPM related nodes
Content-Language: en-US
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com,
        quic_anusha@quicinc.com, quic_ipkumar@quicinc.com
References: <20230406070032.22243-1-quic_devipriy@quicinc.com>
 <20230406070032.22243-4-quic_devipriy@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230406070032.22243-4-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6.04.2023 09:00, Devi Priya wrote:
> Add RPM Glink & RPM message RAM nodes to support frequency scaling
> on IPQ9574.
> 
> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  Changes in V3:
> 	- Moved rpm_msg_ram node under /soc and updated the node name to sram@
> 	- Moved rpm-glink node such that the nodes are sorted alphabetically
> 
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> index 7c820463a79d..1f9b7529e7ed 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -110,12 +110,29 @@
>  		};
>  	};
>  
> +	rpm-glink {
> +		compatible = "qcom,glink-rpm";
> +		interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> +		qcom,rpm-msg-ram = <&rpm_msg_ram>;
> +		mboxes = <&apcs_glb 0>;
> +
> +		rpm_requests: rpm-requests {
> +			compatible = "qcom,rpm-ipq9574";
> +			qcom,glink-channels = "rpm_requests";
> +		};
> +	};
> +
>  	soc: soc@0 {
>  		compatible = "simple-bus";
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		ranges = <0 0 0 0xffffffff>;
>  
> +		rpm_msg_ram: sram@60000 {
> +			compatible = "qcom,rpm-msg-ram";
> +			reg = <0x00060000 0x6000>;
> +		};
> +
>  		pcie0_phy: phy@84000 {
>  			compatible = "qcom,ipq9574-qmp-gen3x1-pcie-phy";
>  			reg = <0x00084000 0x1000>;
