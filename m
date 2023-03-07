Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27C46AE517
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 16:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjCGPmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 10:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjCGPly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:41:54 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE14898F0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 07:41:19 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id ec29so23136249edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 07:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678203674;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=82ehiiXGvQ606m3y4r13c7IUPI68fsi5s1Og4gRRu6s=;
        b=C0ntXX4EgE1IwJLrrrPaUOEyo/S58KQaQ1CFsW5L8OdSDL2KLsxLRUH+jUn0L8H+ui
         VDLwyTru8x76fPFGtUhevDNNWEq1FX5Tl60izz5EiG7lMXup7mRBgwiIZXltZJC5ck9u
         ymvua/qGX1aC7fdRUrxQZO7VWuLQ4T6drFBoLfXYwZ0vqIiQE9vjwTou14R0cit0Izba
         esOmRiNqOEH67yYxCMLV7phVoaIJwzljYgOYQiauFZvga27HQRJUVJg/Fhslqym4qzPT
         gSBsak6Q3NdQWvVY24v6yMdg4+MulWmt7urhjyB+YjKPYzuBbsm5zF4zCXck9f0RSr95
         ddAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678203674;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=82ehiiXGvQ606m3y4r13c7IUPI68fsi5s1Og4gRRu6s=;
        b=tVyFvqRKbDZSBNW/e2Mcbty/1RmntPfdpyjZJwVK7PrEwHeouvYhKQpMGSGpKDLaTF
         rJU6bU+VsPC1hlfNkXwGg24gJErls/RypMkcv2rG4fjKzBus7BGcBdigqFcnbVQr4b/M
         2DRqqQ84Eme5+j0tyM4bxs4Ginby0LTnJy0AmEPk9Quj31bJagIcVpnhheIXa88AO8WN
         s3oo6zl6B+bbLwaq1dWpgOaLFIyFGvZvLE8e+FujWljs7nLNOzgYokvd+PwstoCWpUR9
         Lp7yU7xdZU7+N4r6q5OewMhssVELJl3BcXK1pDZGrizRwowMj7BCtVtg4Chi4whObM5x
         Z/kw==
X-Gm-Message-State: AO0yUKXzVx68Ohfd9+Ct4OfPhh6TW4QVg9KtXMz724N+56Kncw6LS6qg
        +DDwWOKs6jUHuxWjCcdoLDH5cQ==
X-Google-Smtp-Source: AK7set+TVfW0SzQ7wgXX1TT5ntUE4TzuF/nqw+ctCPELH5dlxbD8i+zz4GrFngIYhDsPtQhG5MmzMQ==
X-Received: by 2002:a17:907:7d8e:b0:87b:dac0:b23b with SMTP id oz14-20020a1709077d8e00b0087bdac0b23bmr19288979ejc.55.1678203674519;
        Tue, 07 Mar 2023 07:41:14 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:a60f:e604:c252:1f3d? ([2a02:810d:15c0:828:a60f:e604:c252:1f3d])
        by smtp.gmail.com with ESMTPSA id vf22-20020a170907239600b008ee64893786sm6330466ejb.99.2023.03.07.07.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 07:41:14 -0800 (PST)
Message-ID: <2fe8e4fe-c4ba-188c-60eb-71e05be82cb8@linaro.org>
Date:   Tue, 7 Mar 2023 16:41:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 09/11] arm64: dtsi: qcom: ipq5018: enable nodes required
 for multipd
Content-Language: en-US
To:     Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, mathieu.poirier@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, quic_gurus@quicinc.com,
        loic.poulain@linaro.org, quic_eberman@quicinc.com,
        robimarko@gmail.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
References: <1678164097-13247-1-git-send-email-quic_mmanikan@quicinc.com>
 <1678164097-13247-10-git-send-email-quic_mmanikan@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1678164097-13247-10-git-send-email-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2023 05:41, Manikanta Mylavarapu wrote:
> Enable nodes required for multipd remoteproc bring up
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5018.dtsi | 130 ++++++++++++++++++++++++++
>  1 file changed, 130 insertions(+)
>  	soc: soc@0 {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> @@ -217,5 +259,93 @@ frame@b128000 {
>  				status = "disabled";
>  			};
>  		};
> +
> +		tcsr_mutex: hwlock@1905000 {

This does not look like in correct order. Don't stuff things to the end
of lists.

> +			compatible = "qcom,tcsr-mutex";
> +			reg = <0x01905000 0x8000>;
> +			#hwlock-cells = <1>;
> +		};
> +
> +		apcs_glb: mailbox@b111000 {
> +			compatible = "qcom,ipq5018-apcs-apps-global";
> +			reg = <0x0b111000 0x1000>;
> +			#clock-cells = <1>;
> +			#mbox-cells = <1>;
> +		};
> +
> +		q6v5_wcss: remoteproc@cd00000 {
> +			compatible = "qcom,ipq5018-q6-mpd";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			reg = <0x0cd00000 0x4040>;
> +			interrupts-extended = <&intc GIC_SPI 291 IRQ_TYPE_EDGE_RISING>,
> +					      <&wcss_smp2p_in 0 0>,
> +					      <&wcss_smp2p_in 1 0>,
> +					      <&wcss_smp2p_in 2 0>,
> +					      <&wcss_smp2p_in 3 0>;
> +			interrupt-names = "wdog",
> +					  "fatal",
> +					  "ready",
> +					  "handover",
> +					  "stop-ack";
> +
> +			qcom,smem-states = <&wcss_smp2p_out 0>,
> +					   <&wcss_smp2p_out 1>;
> +			qcom,smem-state-names = "shutdown",
> +						"stop";
> +			memory-region = <&q6_region>;
> +
> +			glink-edge {
> +				interrupts = <GIC_SPI 179 IRQ_TYPE_EDGE_RISING>;
> +				label = "rtr";
> +				qcom,remote-pid = <1>;
> +				mboxes = <&apcs_glb 8>;
> +			};
> +
> +			q6_wcss_pd1: remoteproc_pd1 {

No underscores in node names, generic node names. Actually I don't get
why do you need empty node at all.

> +				compatible = "qcom,ipq5018-wcss-ahb-mpd";
> +			};
> +
> +			q6_wcss_pd2: remoteproc_pd2 {
> +				compatible = "qcom,ipq5018-wcss-pcie-mpd";
> +				interrupts-extended = <&wcss_smp2p_in 16 0>,
> +					<&wcss_smp2p_in 17 0>,
> +					<&wcss_smp2p_in 20 0>,
> +					<&wcss_smp2p_in 19 0>;


Best regards,
Krzysztof

