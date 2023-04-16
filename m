Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0233C6E391F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 16:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjDPORS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 10:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjDPORQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 10:17:16 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDE71FD7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 07:17:14 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id kt6so19456975ejb.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 07:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681654633; x=1684246633;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V/3dcuion13sJsfdfeJ1nJXQOfv7UJn9geOzy4vdmqI=;
        b=RkvtvgW+braPr1bHHGazAD5qn9gK5OvQe94UzPT1UkvqARIdsvB/x+GXiqSygrWCus
         wMFbF+CPKZWY6gBpg/Pxg9svSQ0kJ3SGOh01bZpPwT+sGNMBnc6ZS5ujPwAsx+mlk96F
         RkB5w3VklOTTOEVxzL/13WbNBw44/z9PMSsZqS6+fmI1C6B1nJ/Ezj4+mDqy+uxRVbYU
         oBV5+DFcM8XnM1lO5MyZg1KTZ1kDPrnO8ehkpVQDuTBvM0pRBAGc1lomOLGmqt4thAML
         y6wiOAJ0dBwPW0FjnL37cr/zsmqizT0QxLiORtvZbeKwr4E0q07sobjYpwZzcfVXadAE
         r2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681654633; x=1684246633;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V/3dcuion13sJsfdfeJ1nJXQOfv7UJn9geOzy4vdmqI=;
        b=UomIzVHAX708QE7GSpKJWU8pl3B5qw4wvLjtikHqXDnH8bk+n1dmby22PeZ+Q9JRsH
         ooB+Oc66EfY9bySmU9OX4FXQAu0Df5cdVf/SY/JWM+vlalzn9tQuNEuaK2dDu2AYQMlF
         wnHUYAtHbueE1CzuCSX6vNzYDiR10s57cBmFKqcLO5QhRbCwr22EC272/b1zttB+wtQ1
         UuzPfwThOepDcf+PMamolEFwQ50ukze9g09gMcnQb/8CICu0Mhhv7i7kEfn965lpl/qH
         pPLnZnycluJZn2pDiZYK8w2ZYBS3mYZyBYEnAOmg/NcTNssZSIFnbI3cjD+j46t2CN9F
         RuAg==
X-Gm-Message-State: AAQBX9e85Bk+//Y6rIQtwlth3tDF2hWOpR4E6gi3gv0DWJbFqdxv7q8a
        89WgJMfv8cXM4fqHThw6o6d81g==
X-Google-Smtp-Source: AKy350aQ90ciic978SSzqPVIlkBGrpmoWtF1iQGD8kNvA+qgmdNuq6DhXCVGMSoBsWaaUSC8SnFE0A==
X-Received: by 2002:a17:906:b7c6:b0:94f:1:8469 with SMTP id fy6-20020a170906b7c600b0094f00018469mr4392986ejb.35.1681654633353;
        Sun, 16 Apr 2023 07:17:13 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ba4d:301c:484d:5c9? ([2a02:810d:15c0:828:ba4d:301c:484d:5c9])
        by smtp.gmail.com with ESMTPSA id tg4-20020a1709078dc400b0094ea3a32694sm5013900ejc.190.2023.04.16.07.17.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 07:17:13 -0700 (PDT)
Message-ID: <8eb3e8e5-95a8-ffcd-aa09-8d6d63b7f526@linaro.org>
Date:   Sun, 16 Apr 2023 16:17:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] dt-bindings: iio: adc: qcom,spmi-vadc: add 16 ratio of
 pre-scaling
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230416123142.299533-1-krzysztof.kozlowski@linaro.org>
 <20230416141024.2c09d7c8@jic23-huawei>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230416141024.2c09d7c8@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2023 15:10, Jonathan Cameron wrote:
> On Sun, 16 Apr 2023 14:31:42 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> Document value of 16 for pre-scaling, already used in DTS and supported
>> by the Linux driver since long time:
>>
>>   sm7225-fairphone-fp4.dtb: adc@3100: channel@8:qcom,pre-scaling: 'oneOf' conditional failed, one must be fixed:
>>     10 was expected
>>     16 is not one of [1, 3, 4, 6, 20, 8, 10]
>>     81 was expected
>>
>> Fixes: e13d757279bb ("iio: adc: Add QCOM SPMI PMIC5 ADC driver")
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> I'm carrying an identical patch (though without the reordering) from Luca Weiss.
> I thought as the whole series was very late in the cycle that it was unlikely
> to be necessary to rush this in.
> 
> https://lore.kernel.org/all/20230414-pmi632-v1-5-fe94dc414832@z3ntu.xyz/
> 
> I see that patch is for the fairphone-fp3 adn this report is the fairphone-fp4.
> Is that the reason this is a fix?

Oh, I missed it. It's just something new and not yet in next maybe, so
thus I missed the fix.

Ignore this patch then, please.

Best regards,
Krzysztof

