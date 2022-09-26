Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6A85E9C08
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbiIZI2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234445AbiIZI2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:28:23 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924423BC79
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:28:02 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bq9so9002905wrb.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:reply-to:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date;
        bh=zhUmxxCNn9dNH6cu3VHXkeKR3APeosgo+5Vt8unxLsk=;
        b=bCA9csVPUe/ROE8AxHKEe0+vZgzqqNmM20DeBrOaP+Q955RuQ/4Lnw82FVuoqB5b5B
         RU0zt5wMM6zAa95xaXcrxVyazwvpd27iV4vsT1HHuL5p5PBuZJur7uqRCd/ettol6Nev
         R1hr5ooP03Uxs+5YaKO6T5bWD3I/fX0W8mmrdjLb8LVjpfD/jPzGa4beUEb2BSGwwnD0
         6fGCAckFiep/r7EHcd3yZzZ/IuKqqJFevQ8fQsPKGn9cSswKMGVavTEDoM0zbwKduP9l
         7E7j6c0B4nf0GHOFJQ/GMK1h1ZNuPbK+gZNHFOViZE+00EUzwerJTD0um6tu0aJ5obJ/
         GyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:reply-to:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=zhUmxxCNn9dNH6cu3VHXkeKR3APeosgo+5Vt8unxLsk=;
        b=RbzWMMdKx0bY6mrxwAyITDeFyDpxb663v8mMTtSz46lRunAXCcgYVTkOE3VhMAkwZB
         3dgkFRVuWSAuzTSaksR8denPrdEjRdsCKhiqh3b17s+akjs1zyUPOI7XZdSba8lmg7oO
         ZM0l9EBjJhCitK3CU9lbabMJp1lfk/2lAC+qfy+4e8d6dc+2CnuwGvoOCzY2I8y3P8d6
         46wkTZSObPJ6LDz1ZSXrpJr4N215U6PCrZdyzt9gbcFpw4O/h6C2zHKqSsZDor417NNA
         DBof+5g20fp0NqR22tZUD218eKhJNYGgpOB1B3QgJIZ2BLuGB3Az8I+/0uAabd3x4NI0
         i7bg==
X-Gm-Message-State: ACrzQf1DTLMlbO1FVQVl5WfO27AWomjspqvwuL5myzEgUdZTiGmkTjdd
        WFlP+RgQA07vdzVxFRWUPqKewQ==
X-Google-Smtp-Source: AMsMyM4eRLX7uRiq6moxRCqfFPr5ERdQFCN2GveAkhiCUJTJTSb0eTBuCzE+Q1tWxpJccahPDU3dzA==
X-Received: by 2002:a5d:5a14:0:b0:22a:25be:7f69 with SMTP id bq20-20020a5d5a14000000b0022a25be7f69mr12383381wrb.662.1664180880244;
        Mon, 26 Sep 2022 01:28:00 -0700 (PDT)
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
        by smtp.gmail.com with ESMTPSA id k22-20020a05600c0b5600b003b49bd61b19sm10243687wmr.15.2022.09.26.01.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 01:27:59 -0700 (PDT)
Message-ID: <98960452-9f48-7b4d-9aa6-55c0002ad1b4@linaro.org>
Date:   Mon, 26 Sep 2022 10:27:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ARM: dts: qcom-pma8084: fix vadc channel node names
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220925202143.123208-1-luca@z3ntu.xyz>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Organization: Linaro Developer Services
In-Reply-To: <20220925202143.123208-1-luca@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2022 22:21, Luca Weiss wrote:
> Node names for the channel are supposed to be adc-chan@REG.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>   arch/arm/boot/dts/qcom-pma8084.dtsi | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-pma8084.dtsi b/arch/arm/boot/dts/qcom-pma8084.dtsi
> index e77602e9f95c..7ad573c7b4ac 100644
> --- a/arch/arm/boot/dts/qcom-pma8084.dtsi
> +++ b/arch/arm/boot/dts/qcom-pma8084.dtsi
> @@ -64,22 +64,27 @@ pma8084_vadc: adc@3100 {
>   			#size-cells = <0>;
>   			#io-channel-cells = <1>;
>   
> -			die_temp {
> +			adc-chan@8 {
>   				reg = <VADC_DIE_TEMP>;
>   			};
> -			ref_625mv {
> +
> +			adc-chan@9 {
>   				reg = <VADC_REF_625MV>;
>   			};
> -			ref_1250v {
> +
> +			adc-chan@10 {
>   				reg = <VADC_REF_1250MV>;
>   			};
> -			ref_buf_625mv {
> +
> +			adc-chan@12 {
>   				reg = <VADC_SPARE1>;
>   			};
> -			ref_gnd {
> +
> +			adc-chan@14 {
>   				reg = <VADC_GND_REF>;
>   			};
> -			ref_vdd {
> +
> +			adc-chan@15 {
>   				reg = <VADC_VDD_VADC>;
>   			};
>   		};

I don't see where this is required, bindings doesn't mandate this naming:

patternProperties:

    "^.*@[0-9a-f]+$":
Neil
