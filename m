Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A746D6AF9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbjDDRzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235462AbjDDRzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:55:31 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0D4211F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:55:28 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id bi9so43355992lfb.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680630927;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ieDfTkWwJhNOesMJOHIhbCjLXQeB+KmYJozBwz8fCoY=;
        b=SOc3VCi+hCBhuKwZ7HURzl5GkJfwDU/4dm2EIOUg7TrdNhB1vmg4hlhSjsLsHLxQLh
         glgkRSYW9qcpEJZ4hdaGHXJtnh5FEXq5xsxyKcVAnA+sjij8qsFYKkUrK3c+gDY8qLVU
         PsPkLb2o6HCKdIxpgq0fDqIdx3vU/c8MWM71fsMs3FU4P3AUppR3RPLUfmdjhmEYXLEr
         3ASnvsswPgtKAfBDECSmQ1FLz9Tnz4vx11kKXZzUnOBlPw6/gpGDjpE+u6LHqjClhHsg
         4vJlmRh7TvrWDRvI4IocU4aqVxZGNcyYJKe7MD94fNgJXSIPKOFcQmdmG6lIMPQ1JS5L
         vyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680630927;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ieDfTkWwJhNOesMJOHIhbCjLXQeB+KmYJozBwz8fCoY=;
        b=akkmTURmzxShVVZ8Tt8fhASNDbYoQLI6w/k0AHdXb96SRKdevjI9gnh1cv8IH7FwaE
         5HF6szlCsaGCgwMGGbPVCFGhRzLNRYAOOzpHltPe58V7AxDO8Ditp8Zs53uQtq1IY/eF
         aUIXnAyIN0aGxHVLSHHrv5rBN/iD8hwEsdvppRCr+JtPO436Ahcy2QZikvzVf9SE+aEF
         sBSUh7NO5J+Jb0IgqmpTlJnU90Jr1g27TlEpMOSHV8A3AuTNZzK5hIWsJcMjjHN5eE8+
         V1AMhnDcCmtIGByKeTvb6qjWHm8CN0kCcfmkreo+EsDcn2msCRgb1hOoH1qy36lPh2nz
         SBOA==
X-Gm-Message-State: AAQBX9dYlpPMSXLJPVNlGEKOY8q8T05Yw/md9YCHYZYwY8RU4Jt+ZYRd
        +mFnYIoT+uiG+pCq4+h8J3YFQw==
X-Google-Smtp-Source: AKy350Z/JoaJOYcGFFhW3xEjCFol9E7hWV3LDlszJKbshcD10pFgJbhRK9f6OjEsUaYBczB1wqDb9A==
X-Received: by 2002:ac2:5ec6:0:b0:4e1:5d87:330c with SMTP id d6-20020ac25ec6000000b004e15d87330cmr865154lfq.50.1680630926821;
        Tue, 04 Apr 2023 10:55:26 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id x4-20020ac259c4000000b0048b365176d9sm2430576lfn.286.2023.04.04.10.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 10:55:26 -0700 (PDT)
Message-ID: <305fcdae-84f5-7edb-26e4-588162fed018@linaro.org>
Date:   Tue, 4 Apr 2023 19:55:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2] arm64: dts: qcom: sm8550: add Soundwire controllers
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230404073915.61779-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230404073915.61779-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4.04.2023 09:39, Krzysztof Kozlowski wrote:
> Add nodes for LPASS Soundwire v2.0.0 controllers.  Use labels with
> indices matching downstream DTS, to make any comparisons easier.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Correct IO range length.
> 
> The bindings and driver are here:
> https://lore.kernel.org/linux-arm-msm/20230403132503.62090-1-krzysztof.kozlowski@linaro.org/T/#t
> ---
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 109 +++++++++++++++++++++++++++
>  1 file changed, 109 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index dc6150e97d46..14e4de7a1a0e 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -2004,6 +2004,33 @@ lpass_wsa2macro: codec@6aa0000 {
>  			#sound-dai-cells = <1>;
>  		};
>  
> +		/* WSA2 */
> +		swr3: soundwire-controller@6ab0000 {
> +			compatible = "qcom,soundwire-v2.0.0";
> +			reg = <0 0x06ab0000 0 0x10000>;
> +			interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&lpass_wsa2macro>;
> +			clock-names = "iface";
> +
Any reason this and swr0 have comments instead of labels?

> +			qcom,din-ports = <4>;
> +			qcom,dout-ports = <9>;
> +
> +			qcom,ports-sinterval =		<0x07 0x1f 0x3f 0x07 0x1f 0x3f 0x18f 0xff 0xff 0x0f 0x0f 0xff 0x31f>;
> +			qcom,ports-offset1 =		/bits/ 8 <0x01 0x03 0x05 0x02 0x04 0x15 0x00 0xff 0xff 0x06 0x0d 0xff 0x00>;
> +			qcom,ports-offset2 =		/bits/ 8 <0xff 0x07 0x1f 0xff 0x07 0x1f 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
> +			qcom,ports-hstart =		/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0x08 0xff 0xff 0xff 0xff 0xff 0x0f>;
> +			qcom,ports-hstop =		/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0x08 0xff 0xff 0xff 0xff 0xff 0x0f>;
> +			qcom,ports-word-length =	/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0x08 0xff 0xff 0xff 0xff 0xff 0x18>;
> +			qcom,ports-block-pack-mode =	/bits/ 8 <0x00 0x01 0x01 0x00 0x01 0x01 0x00 0x00 0x00 0x01 0x01 0x00 0x00>;
> +			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
> +			qcom,ports-lane-control =	/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
> +
> +			#address-cells = <2>;
> +			#size-cells = <0>;
> +			#sound-dai-cells = <1>;
> +			status = "disabled";
> +		};
[...]


> +		swr2: soundwire-controller@6d30000 {
> +			compatible = "qcom,soundwire-v2.0.0";
> +			reg = <0 0x06d30000 0 0x10000>;
> +			interrupts-extended = <&intc GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&intc GIC_SPI 520 IRQ_TYPE_LEVEL_HIGH>;
There's no different interrupt-parent, so -extended seems excessive.
Unless that was maybe supposed to use some PDC-mapped irq?

Konrad
> +			interrupt-names = "core", "wakeup";
> +
> +			clocks = <&lpass_vamacro>;
> +			clock-names = "iface";
> +			label = "TX";
> +
> +			qcom,din-ports = <4>;
> +			qcom,dout-ports = <0>;
> +			qcom,ports-sinterval-low =	/bits/ 8 <0x01 0x01 0x03 0x03>;
> +			qcom,ports-offset1 =		/bits/ 8 <0x00 0x00 0x01 0x01>;
> +			qcom,ports-offset2 =		/bits/ 8 <0x00 0x00 0x00 0x00>;
> +			qcom,ports-hstart =		/bits/ 8 <0xff 0xff 0xff 0xff>;
> +			qcom,ports-hstop =		/bits/ 8 <0xff 0xff 0xff 0xff>;
> +			qcom,ports-word-length =	/bits/ 8 <0xff 0xff 0xff 0xff>;
> +			qcom,ports-block-pack-mode =	/bits/ 8 <0xff 0xff 0xff 0xff>;
> +			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff 0xff>;
> +			qcom,ports-lane-control =	/bits/ 8 <0x01 0x02 0x00 0x00>;
> +
> +			#address-cells = <2>;
> +			#size-cells = <0>;
> +			#sound-dai-cells = <1>;
> +			status = "disabled";
> +		};
> +
>  		lpass_vamacro: codec@6d44000 {
>  			compatible = "qcom,sm8550-lpass-va-macro";
>  			reg = <0 0x06d44000 0 0x1000>;
