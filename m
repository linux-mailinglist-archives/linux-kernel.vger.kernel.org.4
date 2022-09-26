Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12AF5E9E91
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 12:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbiIZKEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 06:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbiIZKES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 06:04:18 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A45C32B82
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:04:16 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id n12so9364599wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date;
        bh=sTAPIVJNbp4iICt5sfzGH6YEb6tzSO6KPzd55XSaBdY=;
        b=c4mAGGxhECtHjTjrRnn3HOx1EiKljfJ1NXJYEaKtgI2W3TMnIj5nbJDrkv0lDfDQTe
         9FPk9F+P8sNDeHu7vqmwLL3jQwsv5ZDk5FjYHS0YQj6EJuBex7Zafz18ORwWbqt8dZtx
         g/mScToh/dwCUDkcSGfsetgo1+AEjH2d/OjqBI6jUbGNBPCkeFa7eUDDGFmTf9Aiy0fb
         XGFVmJh9BxNerYm+4FeOdDGQEDGh9llgwwRoAjWOhjd9A2DUifpkVz3LkKBj7sgNBv9q
         pySYMYrvA7yM7PVrMv5sLTYK41F8G1u5tjR1jNWBm4a5fLWapJL9DXs2AJi5m2nwMUkv
         yG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=sTAPIVJNbp4iICt5sfzGH6YEb6tzSO6KPzd55XSaBdY=;
        b=SoihD6EvjfSKFpTcZfsPRXvNr8Cv/P4vAmeUFAy7Tjz6kxUzBbU+awEpI43H6c/4vj
         XI6R8j+xGXeGeqVC9i0Gsr/dj0MXmVuDGhaPsMpRV8RatHtSDEXTsKovieDlCoeHUSWh
         qTEHWrsxrxVSDGbJEQNSbpm2tu9o1Z8QU4Mtl3AKUUy0X8Yc3L/WsVvq83KoE4z2rr9a
         AsUzwC1iaTY3qU4SBux13GrO3a2YuaYIeqpM8M0oTGWHo0paL+n+LQaOQMbE4RvQbOOj
         Yy0/e0f/91g8WwzEYkuDVrqKdUBsp91RsQiXejNMnH/VXGsHdB9leZLMJZWS5ysvcfC7
         8N0Q==
X-Gm-Message-State: ACrzQf3s5MQg4F4Bk/ybkwW0YLnrheYOtwgsfRfgyqLbcHYC1CydtNCR
        NRAezHX2q/9YzZn0r7IklGS9jQ==
X-Google-Smtp-Source: AMsMyM4ES3y+zy1qMG1o3vbqYnbjhuFHSDXFP/iGUf6v7wgMwvvhoB8/maq1VdkF1IcTpccGNUCYyg==
X-Received: by 2002:a5d:6d07:0:b0:22a:3f21:3b56 with SMTP id e7-20020a5d6d07000000b0022a3f213b56mr12562644wrq.679.1664186654836;
        Mon, 26 Sep 2022 03:04:14 -0700 (PDT)
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c350900b003b492338f45sm12043677wmq.39.2022.09.26.03.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 03:04:14 -0700 (PDT)
Message-ID: <3070538e-fa8d-4506-bbf8-c2770d092eb5@linaro.org>
Date:   Mon, 26 Sep 2022 12:04:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] ARM: dts: qcom: pm8941: adjust node names to bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220925210229.128462-1-luca@z3ntu.xyz>
 <20220925210229.128462-2-luca@z3ntu.xyz>
 <ec8cc121-9814-cd52-fb49-c33ab1376f89@linaro.org>
Reply-To: neil.armstrong@linaro.org
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <ec8cc121-9814-cd52-fb49-c33ab1376f89@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2022 11:22, Krzysztof Kozlowski wrote:
> On 25/09/2022 23:02, Luca Weiss wrote:
>> pm8941-misc should be called 'extcon' and pm8941-coincell 'charger'.
>>
>> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
>> ---
>>   arch/arm/boot/dts/qcom-pm8941.dtsi | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom-pm8941.dtsi
>> index 33517cccee01..01f14d5f314d 100644
>> --- a/arch/arm/boot/dts/qcom-pm8941.dtsi
>> +++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
>> @@ -27,7 +27,7 @@ pwrkey@800 {
>>   			bias-pull-up;
>>   		};
>>   
>> -		usb_id: misc@900 {
>> +		usb_id: extcon@900 {
> 
> Why? extcon is Linux specific name and should not be added to DTS.
> Anything requires it?

It matches the current dt bindings:

Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml:
<snip>
    "extcon@[0-9a-f]+$":

      type: object

      $ref: /schemas/extcon/qcom,pm8941-misc.yaml#
<snip>

Neil

> 
> 
> Best regards,
> Krzysztof
> 

