Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643176285C9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237871AbiKNQpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237882AbiKNQp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:45:28 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A522F02C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:45:26 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id a15so13953132ljb.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y9dc45aT/JX/FTR0wgHvwdtMlLaHpziOS1SHGLUZmJo=;
        b=RsAuOQaCs1ObI5owjuNOo6L6z9OgvX+6gWIi7MrN0PtqC6XS0mYLk6jf+i7vRPaSVB
         WrKmgFF39r7PbiwVZrxykzO4DmP4m7JWdogkMC7cJO1wy4WhvVNseFVRL26o4YCKWWir
         iJimBjkv4CObcYKaRwzkj/ciCIs8lYeJ1GYwz/VnnGbC6+igomma3XFhHd9vuIimbR14
         YtGnc4GW4NvFOvrwSR8JE+BO3KPjhbalvLQGRKTWDASynwP6pL7lhRYCbEEwwbxnQmXb
         NY0BuNHIXevHkjUbGPZ0fnfWo3MtMboTwHdTqKxOucHRhDo7cuQiNkTC19JM+yYJjcYk
         wCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9dc45aT/JX/FTR0wgHvwdtMlLaHpziOS1SHGLUZmJo=;
        b=n0yN+/t9IWqUokH7X1c1MoTfCR59PDvak4k4PTwMOqRPxsFvAfiHhGQbVVFuc3Gf7A
         NpwR9t9ZdMC1Je+J5vrR8rC4HF2QDv53lIZAUw2SfEDDAuOlWtxTT2vlPTj3H25tF2YJ
         QUWcSK/YOmYyzTthTeDdAQK/lrCA2TzFzOzIrwRO2AuJcQFotYyIrhuwWid8MxTrozXy
         IQLqOfoLZh1VpgE3YH8huEGW0f6bNe337Hz7d+fF8ELyq+RpVxDld/kU/7ln39kRMgKT
         kTS0N7Go18uKa1kf7g0aqHzntek45A3+LeilONZyvgxMT86yB0Wcrky7x2cK5EJEjRFX
         8CxQ==
X-Gm-Message-State: ANoB5pk9V4rRQ3r0OsQP0h1JuwmmhIRCWf8Qa1CaETAj+f9SITALv95z
        kiULlplYBTzkcP/xH3+sickgVA==
X-Google-Smtp-Source: AA0mqf5oWsRFwI4o8EBhGbnJXOfSWE3mB6JPvEc2qERcM73WyXLi5uBVbcg+Z1b5VccvhXZ/XqHVIg==
X-Received: by 2002:a2e:940f:0:b0:277:2f7f:a14c with SMTP id i15-20020a2e940f000000b002772f7fa14cmr4209836ljh.96.1668444324898;
        Mon, 14 Nov 2022 08:45:24 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s8-20020a05651c200800b00277522fc29bsm2086012ljo.3.2022.11.14.08.45.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 08:45:24 -0800 (PST)
Message-ID: <ea17f523-a21f-6af8-7aec-db0a5825f6b2@linaro.org>
Date:   Mon, 14 Nov 2022 17:45:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v15 8/8] arm64: dts: qcom: sm8250: Add tpdm mm/prng
Content-Language: en-US
To:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20221114144027.14365-1-quic_jinlmao@quicinc.com>
 <20221114144027.14365-9-quic_jinlmao@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221114144027.14365-9-quic_jinlmao@quicinc.com>
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

On 14/11/2022 15:40, Mao Jinlong wrote:
> Add tpdm mm and tpdm prng for sm8250.
> 
> +---------------+                +-------------+
> |  tpdm@6c08000 |                |tpdm@684C000 |
> +-------|-------+                +------|------+
>         |                               |
> +-------|-------+                       |
> | funnel@6c0b000|                       |
> +-------|-------+                       |
>         |                               |
> +-------|-------+                       |
> |funnel@6c2d000 |                       |
> +-------|-------+                       |
>         |                               |
>         |    +---------------+          |
>         +----- tpda@6004000  -----------+
>              +-------|-------+
>                      |
>              +-------|-------+
>              |funnel@6005000 |
>              +---------------+
> 
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 173 +++++++++++++++++++++++++++
>  1 file changed, 173 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index 80193bb3c478..0914b4b9c862 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -2746,6 +2746,76 @@
>  			};
>  		};
>  
> +		tpda@6004000 {
> +			compatible = "arm,primecell";

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

I don't think your bindings allow this to be alone...

Beside, your patch does not apply. Is it based on Bjorn's tree?

> +			reg = <0 0x06004000 0 0x1000>;
> +			reg-names = "tpda-base";
> +
> +			clocks = <&aoss_qmp>;
> +			clock-names = "apb_pclk";
> +
> +			out-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +					tpda_out_funnel_qatb: endpoint {
> +						remote-endpoint = <&funnel_qatb_in_tpda>;
> +					};
> +				};
> +			};
> +
> +			in-ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@9 {
> +					reg = <9>;
> +					tpda_9_in_tpdm_mm: endpoint {
> +						remote-endpoint = <&tpdm_mm_out_tpda9>;
> +					};
> +				};
> +
> +				port@17 {
> +					reg = <23>;
> +					tpda_23_in_tpdm_prng: endpoint {
> +						remote-endpoint = <&tpdm_prng_out_tpda_23>;
> +					};
> +				};
> +			};
> +		};
> +
> +		funnel@6005000 {
> +			compatible = "arm,primecell";

Same problem, I guess.


Best regards,
Krzysztof

