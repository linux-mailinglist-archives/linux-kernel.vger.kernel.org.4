Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB82A5F05C2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 09:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiI3HdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 03:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiI3HdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 03:33:05 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238611F7ECF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 00:33:04 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id x29so3911683ljq.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 00:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=3EhDX5sconM/DulJaLK1YKrSaQKMRvhUiKJtm5HcYSQ=;
        b=TGZYiZlSuRWs7pX1o5GgZ/73e9A062m1pYjrw0BJjXs+VKeGY4HAeBLYe5eVfR1E4X
         8OL57rnJJjLIStSn203PikstHzaeRyHpyMtSF8DxXRnfEyKW6q+D9H1BxwKUx0sB6F7l
         JBFYlmN1/RMBpJwkCu0jiCzhB39JlJLDlMD+FTw6JKtUdoFR/4o9wudV52JRb7L+CzeR
         IB4u/VpWSLFp3sUc4W325BFW7prInK3Ly/qhh5qAn8ibO4UbOxUNcoqTF5ha0OX4CTaY
         FY5KlIBN0ZgsZwwBd5FuVuDWCE1Xc1qOFaEF+c0AeBHSsJLQPzkidEbcjqJg+2j0QxFM
         kv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=3EhDX5sconM/DulJaLK1YKrSaQKMRvhUiKJtm5HcYSQ=;
        b=dKfYTkID2ZFvRxfl4uDKsQXBcvQPeUnS3RZJmOepl1IPAjpB7AxwXQ7sHRdPYxBydH
         D9xP4a1A8u46ysMOq+7KBVQZMdcfOJpJv2oeQcdYbMiYBHfKnQYWJTcbV+e8cnqtxWFn
         gIrg9y5y73a4OiEWHEgOiJf3Gzb0bkDLCPb1NSLkclM/PzQ7n8AvovkoIsb+7jA3atzj
         aqh+NZj3ZZac0cBK48SSOuhBmFQ49upZ4Y0f75NQc7FQO1d0Lejw5o25t8Ufw23QEwts
         oav+gDM2IfgvJoIDcIEWUA5K94eeT/fHZ87eywKyGDz0DUtiVePiZItTlnQULQis2KnT
         SEQQ==
X-Gm-Message-State: ACrzQf1Ta3wWfX+Hxu+GMMx0LBGiYnGFvWOIe9CyXPI6IrOgcMCMTA9x
        hn071UD9hZVUunovK0yGY/EFuQ==
X-Google-Smtp-Source: AMsMyM5fyQcKNPw91bATxo6xJ0dTsxhzxYTCiUU1lYuqP699+UmonKTl7CZmVAKQaOJsLMkHaSQtow==
X-Received: by 2002:a2e:9b91:0:b0:26a:ce59:c517 with SMTP id z17-20020a2e9b91000000b0026ace59c517mr2362039lji.181.1664523182233;
        Fri, 30 Sep 2022 00:33:02 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id b18-20020a056512305200b00492ea54beeasm200350lfb.306.2022.09.30.00.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 00:33:01 -0700 (PDT)
Message-ID: <05827736-c3af-b67b-4343-717545db530c@linaro.org>
Date:   Fri, 30 Sep 2022 09:33:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 5/7] arm: dts: qcom: mdm9615: remove invalid pmic
 subnodes compatibles
Content-Language: en-US
To:     neil.armstrong@linaro.org, Andy Gross <agross@kernel.org>,
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
 <051ccc1c-ae56-932c-0be8-19abae562615@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <051ccc1c-ae56-932c-0be8-19abae562615@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2022 14:48, Neil Armstrong wrote:
> Hi,
> 
> On 29/09/2022 14:27, Krzysztof Kozlowski wrote:
>>
>> We are making circles and discussion takes too much. 
> 
> I'm sorry this happens, but I really want solve this stuff which in suspend since 2015.
> 
> So let me recall the original issue:
> 
> DTBS check reports:
> 
> arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dtb: pmic@0: compatible: ['qcom,pm8018', 'qcom,pm8921'] is too long
>          From schema: Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
> 
> arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dtb: pmic@0: rtc@11d:compatible: ['qcom,pm8018-rtc', 'qcom,pm8921-rtc'] is too long
>          From schema: Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
> 
> arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dtb:0:0: /soc/qcom,ssbi@500000/pmic@0/pwrkey@1c: failed to match any schema with compatible: ['qcom,pm8018-pwrkey', 'qcom,pm8921-pwrkey']
> 
> arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dtb:0:0: /soc/qcom,ssbi@500000/pmic@0/pwrkey@1c: failed to match any schema with compatible: ['qcom,pm8018-pwrkey', 'qcom,pm8921-pwrkey']
> 
> arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dtb: rtc@11d: compatible: ['qcom,pm8018-rtc', 'qcom,pm8921-rtc'] is too long
>          From schema: Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml
> 
> So trying to solve those, and since the PMIC in the wp8548 module is a PM8018, and it happens to be (partially ?? potentially ??) compatible
> with the PM8921, and I had issues adding per-HW compatible for the pwrkey, the obvious solution would be to
> drop the PM8921 compatibility since it's only probable and nothing proves it's right.

Although it is obvious solution it is also affecting all out-of-tree
users of DTS.

> 
> But what's sure: it's a PM8018 PMIC.

I could not find the spec for both of these, but similar numbers have
for example exactly the same RTC. I guess other blocks are also the same.

> 
> But since the PM8018 PWRKEY interface is compatible with the PM8921 PWRKEY interface,
> it's perfectly ok to the the MP8921 compatible here.
> 
> OK, so as you quoted multiple times:
> "How this should be fixed? First, drop bogus entries from drivers, then
> document proper compatibles."
> 
> OK so there's no bogus entries to remove here, and the only compatible to
> potentially document is the pm8018-pwrkey but it seems to be wrong.

All the entries in drivers which are duplicating the fallback are not
needed. I called them bogus because adding them brought no meaning.

> I'll be happy to have an hint on how to handle that to I can go forward and
> stop the noise, there's still plenty of stuff to fix in the MDM9615 DT.

Drop the unneeded entries from the driver, document (properly) the
compatible how it is used in DTS (so not in some other way than DTS
expresses it).

Best regards,
Krzysztof

