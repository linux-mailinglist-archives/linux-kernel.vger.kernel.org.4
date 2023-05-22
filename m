Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112DC70B817
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjEVIxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbjEVIxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:53:31 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FB8133
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:53:28 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ae6dce19f7so29580685ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684745608; x=1687337608;
        h=content-transfer-encoding:in-reply-to:references:subject:to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yy4zVkssg8FiC+/RzC34Xwny+YRkysiolleunptsSl0=;
        b=goP3fJOI9f2dj4q3zt7G8HUTP5BfxehAiYHW67aGWbby0GWZt7LwqnVO81ZhudtxKe
         Hy1dBAmCCH05/+ctPzMqLgdiQq7GrwpQa9tvF1tkmESm/5p2HmwiCsjGcxd2ge80lvgu
         03iGnj8GIx1OP0L3y78MVRzwyF4RuHUryJhcHtwg5/XatOvxlUOZ5+3s9hM81lTsqn15
         +IH4niDECGBfRR30MOy3+8ozs5b0vu0tr/ftUTe+LqaVHS2W3bA5u4qP/kmPe/akcx9s
         yiym+TXWcg7362wL1g3pJ7C98VTesi1nk7YvuxSfHQsUPguAZg2iAW5QjzK368ffmXVy
         HfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684745608; x=1687337608;
        h=content-transfer-encoding:in-reply-to:references:subject:to:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yy4zVkssg8FiC+/RzC34Xwny+YRkysiolleunptsSl0=;
        b=ODvBcgSQdOE6P6KZtRPOtO+htobdxJgHrGwcgfM0LpDaAuZ8OfMRzzU2d4aFGA2T49
         DQZ212QG9aFGI1GU4AvWHhqWPVeYgzZHmvGqlfvYC6rGdbBLUlkTrb/1jNJOIKwF9yMP
         TbqBj4ED64Lk40DvG9NPRNmrPVxdJBWv4/7RWSA1OfExEiTfsXTkIvHXgjnszEsKCpwj
         EHMdh6oy4K5JOqKcs6lSEBGPH6657Mu6l2LmKLJBGwe47jgK1NG9iMUnbYZbocdxMhtc
         EXU41YslWsJmknIuvc+3BjPv52azFVYaYb/VNyYMVuA0EffbM1ciXU5VXtoBZoMZXa/j
         RgZA==
X-Gm-Message-State: AC+VfDwMC0W/Kisxcsv9akYpBOBjRYsu9hV2UF5rUCn126gSVNehOuCS
        Og2Cxj5/MEQGCs/V/GNqh1QjJA==
X-Google-Smtp-Source: ACHHUZ4DcbvSTtZeRWniTVD7cIXlVTqrwop9sJluPZE1NASnzxNdtPS/2/7r53dSGhstBwpZYfU6/w==
X-Received: by 2002:a17:902:ecc1:b0:1ad:f7d9:1ae0 with SMTP id a1-20020a170902ecc100b001adf7d91ae0mr11742345plh.38.1684745608044;
        Mon, 22 May 2023 01:53:28 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c60:d309:883d:817e:8e91:be39? ([2401:4900:1c60:d309:883d:817e:8e91:be39])
        by smtp.gmail.com with ESMTPSA id jc1-20020a17090325c100b001a1b66af22fsm4344017plb.62.2023.05.22.01.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 01:53:27 -0700 (PDT)
Message-ID: <93db4ee5-4fb8-f159-0cf4-ec1669c36dd1@linaro.org>
Date:   Mon, 22 May 2023 14:23:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
From:   bhupesh.sharma@linaro.org
To:     Anusha Rao <quic_anusha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        thara.gopinath@gmail.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, quic_srichara@quicinc.com,
        quic_gokulsri@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com,
        quic_poovendh@quicinc.com
Subject: Re: [PATCH V3 4/4] arm64: dts: qcom: ipq9574: Enable crypto nodes
References: <20230518141105.24741-1-quic_anusha@quicinc.com>
 <20230518141105.24741-5-quic_anusha@quicinc.com>
In-Reply-To: <20230518141105.24741-5-quic_anusha@quicinc.com>
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

On 5/18/23 7:41 PM, Anusha Rao <quic_anusha@quicinc.com> wrote:
> Enable crypto support for ipq9574.
> 
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> ---
>   Changes in V3:
> 	- No change.
> 
>   arch/arm64/boot/dts/qcom/ipq9574.dtsi | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> index fea15f3cf910..6e52d35a6a15 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -123,6 +123,26 @@
>   			clock-names = "core";
>   		};
>   
> +		cryptobam: dma-controller@704000 {
> +			compatible = "qcom,bam-v1.7.0";

Please confirm if this is "qcom,bam-v1.7.4" or "qcom,bam-v1.7.0". If "qcom,bam-v1.7.4" please use the newer compatible format.

Thanks,
Bhupesh

> +			reg = <0x00704000 0x20000>;
> +			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>;
> +			#dma-cells = <1>;
> +			qcom,ee = <1>;
> +			qcom,controlled-remotely;
> +		};
> +
> +		crypto: crypto@73a000 {
> +			compatible = "qcom,ipq9574-qce", "qcom,ipq4019-qce", "qcom,qce";
> +			reg = <0x0073a000 0x6000>;
> +			clocks = <&gcc GCC_CRYPTO_AHB_CLK>,
> +				 <&gcc GCC_CRYPTO_AXI_CLK>,
> +				 <&gcc GCC_CRYPTO_CLK>;
> +			clock-names = "iface", "bus", "core";
> +			dmas = <&cryptobam 2>, <&cryptobam 3>;
> +			dma-names = "rx", "tx";
> +		};
> +
>   		tlmm: pinctrl@1000000 {
>   			compatible = "qcom,ipq9574-tlmm";
>   			reg = <0x01000000 0x300000>;
> 
