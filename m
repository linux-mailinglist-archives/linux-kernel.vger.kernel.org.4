Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1A55E920A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 12:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiIYKUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 06:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiIYKUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 06:20:04 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CDC1E3FF
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 03:20:01 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id z25so6713193lfr.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 03:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Q1Tiar2NG81eBXy634cm6RIb1sHCUqEEdTntn7Dwa60=;
        b=E282Z+gc026IzLcax1MjsFldPbPHOCZk8Z3gvxrzOdyQu6aU00YW7W7gm23OEBT+iu
         E2GHjhNKgtkw1dsuqF6Wm44ezLbwlTucJ1asStpdCPRUzve8DuuZgxdMF4V2rS414RH5
         mHGzGLjd0r4yG4neK2DPUppYlZiMr3aKwxEFAVB5C9FD9z3xiMZZM2blIkpfHc4wdIiM
         ZoQzk+f4/VDnfG7I1fhx1mhZiKNb2/Hade2jEtOm2Mf7oPMVBhD2I/7HhS9UtEyoDmp5
         3XPUK/xOkWkh2jLoMAy5lnHotSxriBo1QvxcHaxL0qnhFwlPfQO06dde9nV/G9XNH516
         HGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Q1Tiar2NG81eBXy634cm6RIb1sHCUqEEdTntn7Dwa60=;
        b=GiypLk63HNPrEwpJdvV78QuYLGgay+K1scCYrnAo0ZPoYZL18kDv7BygzZCBmq5rYK
         zirYPLqbBZTC0SVAGvud2+5xG2aH0lDQuiKdhD5sIRYcqyG9DKz0pMmW/ziVLLJo550o
         rSFXtxb4O/cfmW7FnZqJFsaNgQXY15ohXR+HDLvHJnt50Vkd8PiuWcEv4IOm72ckvzTa
         GoAWjdsnugpvR/sdeae91jvXlBiz8eo9ao5Mjzjhr0uXkAljs4SQJD92rHNBBp9eP76F
         wCQ/DCjb3OyJNRV44Gymg1pQHEChBBxbZDfyHfQtqi052yxgD0pFCG2cr7SnsNMDBgrv
         RnAg==
X-Gm-Message-State: ACrzQf0uS8Xfg8V9eyrfrTAJI8cZDDgiTvSQUoV6QaVhp7iSANfwvVgu
        jpUsy9Xm5JwCofp8MI9NUHnj9A==
X-Google-Smtp-Source: AMsMyM5w9xY155pOsigPz8r8UH7WsYRwThsQ4esn6QOijIxVhBQuTA36CU8wVrxoEf9zrhHef+4GVQ==
X-Received: by 2002:a05:6512:688:b0:498:fe57:b5f with SMTP id t8-20020a056512068800b00498fe570b5fmr6501865lfe.209.1664101199695;
        Sun, 25 Sep 2022 03:19:59 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v10-20020a2ea60a000000b0026d92a5f97asm173394ljp.111.2022.09.25.03.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Sep 2022 03:19:59 -0700 (PDT)
Message-ID: <a90d0b34-9ec9-d8cf-9e15-9de157b17728@linaro.org>
Date:   Sun, 25 Sep 2022 12:19:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/2] ARM: qcom_defconfig: enable rest of ARMv7 SoCs
 pinctrl drivers
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220925091920.34891-1-krzysztof.kozlowski@linaro.org>
 <YzAnaXDqFrZWq9n/@gerhold.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YzAnaXDqFrZWq9n/@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2022 12:03, Stephan Gerhold wrote:
> On Sun, Sep 25, 2022 at 11:19:19AM +0200, Krzysztof Kozlowski wrote:
>> Enable rest of ARMv7 SoCs pin controller drivers.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  arch/arm/configs/qcom_defconfig | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
>> index 7d8b6884fd00..4971de49be36 100644
>> --- a/arch/arm/configs/qcom_defconfig
>> +++ b/arch/arm/configs/qcom_defconfig
>> @@ -131,14 +131,20 @@ CONFIG_PINCTRL_APQ8064=y
>>  CONFIG_PINCTRL_APQ8084=y
>>  CONFIG_PINCTRL_IPQ4019=y
>>  CONFIG_PINCTRL_IPQ8064=y
>> +CONFIG_PINCTRL_MSM8226=y
>>  CONFIG_PINCTRL_MSM8660=y
>>  CONFIG_PINCTRL_MSM8960=y
>> +CONFIG_PINCTRL_MDM9607=y
>>  CONFIG_PINCTRL_MDM9615=y
>>  CONFIG_PINCTRL_MSM8X74=y
>> +CONFIG_PINCTRL_MSM8909=y
>> +CONFIG_PINCTRL_MSM8916=y
> 
> Thanks for adding MSM8916! (it's used on both ARM32 and ARM64)
> 
>> +CONFIG_PINCTRL_MSM8976=y
> 
> This one should be added to the ARM64 defconfig, I doubt anyone uses it
> with ARM32. :)

True. I'll send a v2. Thanks!

Best regards,
Krzysztof

