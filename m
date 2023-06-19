Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E9F734D01
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjFSIEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjFSIEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:04:09 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C34B9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:03:44 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31126037f41so2786825f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687161823; x=1689753823;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nRpHWNpiwFfVXzGLC+zlZNN4ETOeJpg2BuBe5YoMz44=;
        b=M9cKJtxBxbtEMHFTKp/edGQh0Mwr6ZisVLIAMMJ4biUr9YUTCW30Xcip5M0M+ggFr1
         bGbVqEMx+yTKXuReH1Dxh+nE/pWKlBF/XYeoSGSCKnETKOxXQvXcAhRyPGwf4vf9boSF
         F/0iisjXo1i7F+iEYTrNGDoKjFUWvf3CctAQuGz8GoFEn7BIpY1DV9qvyqFkftHce6Hn
         vvU1J+/Az7fghOZHn42orEvknuWR08nIXwA+pBljdt6rzdW5jsxgEYqY80cuRcsChJMS
         uNHqEjGjwZzswXwuc/e589hZViLZUkwY5j+rX7ekCytk5KppaNEeHJgKDRYrN9bSl+OS
         y2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687161823; x=1689753823;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nRpHWNpiwFfVXzGLC+zlZNN4ETOeJpg2BuBe5YoMz44=;
        b=adMs+7oPfV3l+KY+1VZKpxApmoSaVc/t6a8f977VrSIFdzviCaaw1rsGma3Cl/bREk
         +YtjL7X/dLLpRMs04Q7xBFpLEsehYflyykEdLsE8MRXo+TxFrAIgSnHxCEz9yuaB0TUy
         TytjOR3mRL5mXwGPJMcOu4UagwNYl1g6jiRMCDiu8L2vv9rLBDvfYLNw4LBEz5cxhLaG
         noMo60ywc1J1mqbnDZQhmrZwPxZggRIBsTKIGTATBNrXNPejQ7AFnemI/6jiFOr+lso6
         a5ML9dMdyOm820I697MXtGe69qkweSjbYBR8WZA8e4iLkMA3yd+lFqGxDlFvgUww8uU0
         VJLg==
X-Gm-Message-State: AC+VfDxCdT9acKhAiZyDSopzEEg9hg2EvIpiJQviUbeTp2O9YKqlRiKT
        loQXtAg+9/lRFDIsO5Cjq6jBng==
X-Google-Smtp-Source: ACHHUZ6xa10eGX03mvl+vppvKUa5nj2m3LsqNc8sHA+UjXTExyq4J8mI1aYVMPXo72PoFO6odJSMSw==
X-Received: by 2002:a5d:6505:0:b0:30f:d2af:d62b with SMTP id x5-20020a5d6505000000b0030fd2afd62bmr7024390wru.19.1687161823197;
        Mon, 19 Jun 2023 01:03:43 -0700 (PDT)
Received: from [192.168.7.189] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id cr4-20020a05600004e400b003063a92bbf5sm30999497wrb.70.2023.06.19.01.03.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 01:03:42 -0700 (PDT)
Message-ID: <8b548b43-27da-b071-fa89-d070b85be74e@linaro.org>
Date:   Mon, 19 Jun 2023 10:03:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 5/6] arm64: dts: qcom: sm8550-mtp: add pmic glink
 port/endpoints
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230601-topic-sm8550-upstream-type-c-v4-0-eb2ae960b8dc@linaro.org>
 <20230601-topic-sm8550-upstream-type-c-v4-5-eb2ae960b8dc@linaro.org>
 <f687638e-1c62-ee39-4c09-5783d98ca8f0@linaro.org>
Content-Language: en-US
Organization: Linaro Developer Services
In-Reply-To: <f687638e-1c62-ee39-4c09-5783d98ca8f0@linaro.org>
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

On 19/06/2023 10:02, Krzysztof Kozlowski wrote:
> On 19/06/2023 09:58, Neil Armstrong wrote:
>> Add nodes to support Type-C USB/DP functionality.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
> 
> ...
> 
>> +&i2c_hub_2 {
>> +	status = "okay";
>> +
>> +	typec-mux@42 {
>> +		compatible = "fcs,fsa4480";
>> +		reg = <0x42>;
>> +
>> +		vcc-supply = <&vreg_bob1>;
>> +
>> +		mode-switch;
>> +		orientation-switch;
>> +
>> +		ports {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
> 
> The node fsa4480 not take ports, but port according to bindings.

ack will respin a v5 with a single port.

Neil

> 
>> +
>> +			port@0 {
>> +				reg = <0>;
>> +
>> +				fsa4480_sbu_mux: endpoint {
>> +					remote-endpoint = <&pmic_glink_sbu>;
>> +				};
>> +			};
> 
> 
> 
> Best regards,
> Krzysztof
> 

