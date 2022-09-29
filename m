Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257275EF5AF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 14:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbiI2Msr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 08:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbiI2Mso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 08:48:44 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA033160E5C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 05:48:42 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id i203-20020a1c3bd4000000b003b3df9a5ecbso3172917wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 05:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date;
        bh=RTh6Jh7foBvpZUwlr8i45KWrX5TaOjqxs0vxrakIbik=;
        b=X4/Ix33GrpYpIdhmhwPVXrpN4zFL1fe8qw5LptmI7s57boWioFKy6Wio27lXYW58zD
         2HQBFJ5y9jZxJPFBjnkYDbCdINOty9WDG1YZdbcjsjUzfMJF820nIBdRrslXmsT5exet
         3RXyteA07EpdoVv5uRVJ31C8qfZNtJzl4TCPGxJX2u3XeO6Z2ZF4+wFJ276sIPbsxI2d
         WM9vmtVhMcLLMdgxjdGW4lpwIrjXbrIotXldt4pf5N7oRs8ggMspsBALCBOgyfUCBDE+
         dEycT80zkOZS/FWVOvDYWTEGOQGI+hrC8bSQUYaCFcOr70AtnhLMzIJUDdSERPub7CCJ
         nHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=RTh6Jh7foBvpZUwlr8i45KWrX5TaOjqxs0vxrakIbik=;
        b=B60h0yS5xYSM9kW48cqeKnpUv/M7oML5JssrY5b107biPrwH1R3UYeNILtEqzJYYAJ
         dwWGXxmAlknYf+0Dz7dRCYQHNIdtfxLgzJYPtFt3042RnhhWZDsTaVnSCrr0+ULW+e0a
         CcO+m7JJC5RRjUR1j4oUmkBpl9ED9J+fJFfBkv7em/J0hVpkHlsX1nr/6b7seL7BigIS
         foWJekIX0/HOkiQEXuPkBQ/pWosOXswR21gPa4kli1sPJ0F7R0YDzVya2ZWuq2B58G6I
         3cU/3rzINBFn8HVOFH1lXJMu4l0ns8oeC4eZS+cPVv8vKWBnNr7UAHJVyfWoZfZbw0g+
         v9Dg==
X-Gm-Message-State: ACrzQf2oKEeuT53kf42tsnZ25lQfEe6OO54TMdPwDBIj2lLuiGS0j5Jt
        SeUj6sQ/CTJZutRYo04k2klmeGHCiyJfLYMh
X-Google-Smtp-Source: AMsMyM5QdlrG59bq5kgnMgzyzNnDabiZ0EU3o6UW21hHGi8mdF26IuOMR1PjjfrUGjrDYbDj7L/hZw==
X-Received: by 2002:a7b:c447:0:b0:3b4:8977:4186 with SMTP id l7-20020a7bc447000000b003b489774186mr2226076wmi.74.1664455721407;
        Thu, 29 Sep 2022 05:48:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:1f17:3ea3:4e46:dff? ([2a01:e0a:982:cbb0:1f17:3ea3:4e46:dff])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c2cd200b003a63a3b55c3sm4686351wmc.14.2022.09.29.05.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 05:48:40 -0700 (PDT)
Message-ID: <051ccc1c-ae56-932c-0be8-19abae562615@linaro.org>
Date:   Thu, 29 Sep 2022 14:48:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 5/7] arm: dts: qcom: mdm9615: remove invalid pmic
 subnodes compatibles
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20220928-mdm9615-dt-schema-fixes-v1-0-b6e63a7df1e8@linaro.org>
 <20220928-mdm9615-dt-schema-fixes-v1-5-b6e63a7df1e8@linaro.org>
 <0636d53f-508f-8a86-0973-2641c9020622@linaro.org>
 <6ed642ea-424d-49ed-eb30-e09588720373@linaro.org>
 <1a3c6766-9be5-1e55-95eb-bc9656e5c9a3@linaro.org>
 <7f8572ab-ff97-54bd-a5f3-fe0e179ee48e@linaro.org>
 <84cb8941-eb15-1bbf-59b7-bbcd6c15c30d@linaro.org>
 <07405d0d-8534-6470-21d1-26b85dbd7de0@linaro.org>
 <f54377f0-a152-9367-1b06-f49df7466282@linaro.org>
 <3fa19362-118b-232e-0baf-ee365fa2f2e2@linaro.org>
 <07c75827-b8e5-7c70-315b-48617b9818e0@linaro.org>
 <9067ca94-cd5d-6883-d0e0-374ed7f599ad@linaro.org>
 <65c5ee36-8651-8a42-b6b1-3b8041c7edb8@linaro.org>
Reply-To: neil.armstrong@linaro.org
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <65c5ee36-8651-8a42-b6b1-3b8041c7edb8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 29/09/2022 14:27, Krzysztof Kozlowski wrote:
> 
> We are making circles and discussion takes too much. 

I'm sorry this happens, but I really want solve this stuff which in suspend since 2015.

So let me recall the original issue:

DTBS check reports:

arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dtb: pmic@0: compatible: ['qcom,pm8018', 'qcom,pm8921'] is too long
         From schema: Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml

arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dtb: pmic@0: rtc@11d:compatible: ['qcom,pm8018-rtc', 'qcom,pm8921-rtc'] is too long
         From schema: Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml

arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dtb:0:0: /soc/qcom,ssbi@500000/pmic@0/pwrkey@1c: failed to match any schema with compatible: ['qcom,pm8018-pwrkey', 'qcom,pm8921-pwrkey']

arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dtb:0:0: /soc/qcom,ssbi@500000/pmic@0/pwrkey@1c: failed to match any schema with compatible: ['qcom,pm8018-pwrkey', 'qcom,pm8921-pwrkey']

arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dtb: rtc@11d: compatible: ['qcom,pm8018-rtc', 'qcom,pm8921-rtc'] is too long
         From schema: Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml

So trying to solve those, and since the PMIC in the wp8548 module is a PM8018, and it happens to be (partially ?? potentially ??) compatible
with the PM8921, and I had issues adding per-HW compatible for the pwrkey, the obvious solution would be to
drop the PM8921 compatibility since it's only probable and nothing proves it's right.

But what's sure: it's a PM8018 PMIC.

But since the PM8018 PWRKEY interface is compatible with the PM8921 PWRKEY interface,
it's perfectly ok to the the MP8921 compatible here.

OK, so as you quoted multiple times:
"How this should be fixed? First, drop bogus entries from drivers, then
document proper compatibles."

OK so there's no bogus entries to remove here, and the only compatible to
potentially document is the pm8018-pwrkey but it seems to be wrong.

I'll be happy to have an hint on how to handle that to I can go forward and
stop the noise, there's still plenty of stuff to fix in the MDM9615 DT.

> 
> Best regards,
> Krzysztof
> 

Thanks,
Neil
