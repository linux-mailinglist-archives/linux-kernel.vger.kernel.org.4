Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B8263A8CF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 13:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiK1M6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 07:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiK1M6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 07:58:10 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0824DF12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 04:58:09 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id p8so17177412lfu.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 04:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ySA7bRXHeIR11FzsN6t6JCDddPE/x+8Ds1P9CNQXQOg=;
        b=lH2Z/gd3UH+oqwY2SOhBzqVjGuJqhBvscZA+S7Gx+WNUrzF9oDc1la6QCOV6+PDjz0
         n/jz7GN5yoUKVSqxMSxRhRjoPQ3KRhJQuLK4ccqUhvW8bu/g5P4pdJqizJ/JljZMUWMC
         5MrPEzHBrWHblEuwlxAqWf/DiBNMl6AZC5CwT6/Uq2eq/m3i9Pt8GtNHl6+IOXlxg0gt
         WNcT2HEvjQVrERngJYXH6/Q7pNE2+oHQ8PtSFf+yZknzJBfxBQ0fllRki1iCTJeic0Nm
         RWdb1uNBObR8Law4uhsIxBBJrrQUgInmLIhKXrtsMC7F9JSOdstYpGW4L14LQFgDkBS/
         VETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ySA7bRXHeIR11FzsN6t6JCDddPE/x+8Ds1P9CNQXQOg=;
        b=wInXDhukW8s+lFst31FQwy/4FOBmhuhQ/z4PlIdjaDQFi7+2WUJWh3H8jJq5PTncvG
         MUmcZ0oUAFgt6ZZO2zs4MpiB97gOYo1LcQ53HowPWQTaSrsv3Hujl5CZfTPQxhO8Qnyu
         /eqpKX1Fe+TywtLtz0X4FxxrPYuOyEiaUftPRZOCW0yFRER+JpSf3PEIVhhW/aETm6Tv
         HDO6DFKXmLwlEp+OKLSuG7uY/4YcOWXd2n/Knoys/hyGZbAjfamnxpNN3/wjECeohTzK
         n/aLCrEOvzB1pIST4sWlpAqkc2iTOFubzoGhLBt/heJoA8Ptx5rKcIfgaLjwn1/2iQv/
         +sew==
X-Gm-Message-State: ANoB5pmPlNI9QT/1KQxUY3DXujHeceC39g4htOmJFlB4ch+ce+VDIZki
        zDXtZ+aUgISkwCM27qZ3T+IhBw==
X-Google-Smtp-Source: AA0mqf6QMGVwH029Cx6pZZnvN0zEryx1Qgz1H57o+s8YWwyVX83vzqVbypfZ8EgrqhifThnmbSuQvw==
X-Received: by 2002:a05:6512:36c5:b0:4a5:fda9:70b1 with SMTP id e5-20020a05651236c500b004a5fda970b1mr19558003lfs.473.1669640288100;
        Mon, 28 Nov 2022 04:58:08 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id i12-20020a056512318c00b004b51cec187bsm62406lfe.290.2022.11.28.04.58.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 04:58:07 -0800 (PST)
Message-ID: <b647750a-65e1-3cd2-6e66-1b8c2823b354@linaro.org>
Date:   Mon, 28 Nov 2022 13:58:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: sc8280xp-x13s: Add soundcard
 support
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        agross@kernel.org, andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
References: <20221123104342.26140-1-srinivas.kandagatla@linaro.org>
 <20221123104342.26140-4-srinivas.kandagatla@linaro.org>
 <30be93a3-c57f-d4c9-c154-6f12b9dc5dc5@linaro.org>
In-Reply-To: <30be93a3-c57f-d4c9-c154-6f12b9dc5dc5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2022 13:44, Krzysztof Kozlowski wrote:
> On 23/11/2022 11:43, Srinivas Kandagatla wrote:
>> +
>> +&swr1 {
>> +	status = "okay";
>> +
>> +	wcd_rx: wcd9380-rx@0,4 {
>> +		compatible = "sdw20217010d00";
>> +		reg = <0 4>;
>> +		qcom,rx-port-mapping = <1 2 3 4 5>;
>> +	};
>> +};
>> +
>> +&swr2 {
>> +	status = "okay";
>> +
>> +	wcd_tx: wcd9380-tx@0,3 {
>> +		compatible = "sdw20217010d00";
>> +		reg = <0 3>;
>> +		qcom,tx-port-mapping = <1 1 2 3>;
> 
> I think I solved my head-phones one-channel problem.
> This should be <1 2 3> and in DTSI:
> qcom,din-ports = <3>;
> 
> The downstream waipio-audio-overlay.dtsi says:
> 
>  56                         qcom,swr-port-mapping = <1 SWRM_TX1_CH1 0x1>,
>  57                                 <1 SWRM_TX1_CH2 0x2>,
>  58                                 <1 SWRM_TX1_CH3 0x4>, <1 SWRM_TX1_CH4 0x8>,
>  59                                 <2 SWRM_TX2_CH1 0x1>, <2 SWRM_TX2_CH2 0x2>,
>  60                                 <2 SWRM_TX2_CH3 0x4>, <2 SWRM_TX2_CH4 0x8>,
>  61                                 <3 SWRM_TX3_CH1 0x1>, <3 SWRM_TX3_CH2 0x2>,
>  62                                 <3 SWRM_TX3_CH3 0x4>, <3 SWRM_TX3_CH4 0x8>;
> 
> I just don't know what how to trim the port config properties - we
> have there four entries, but channels are only three?
> 
> Where do these come from? The downstream:
> asoc/waipio-port-config.h / lahaina-port-config.h
> Do do not have port config for this SWR.

Eh, not sure anymore. My second headphone started to work without these
changes, so I have no clue.

Best regards,
Krzysztof

