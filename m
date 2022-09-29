Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28915EF3C4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbiI2K5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235023AbiI2K5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:57:01 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FE814979A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 03:56:59 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id o5so695845wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 03:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:reply-to:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date;
        bh=XgSjhJyKP5xsWGJcS4RGO87v6OeMe6bUmVQ6H5feb10=;
        b=kBkUnIUpcEyozu6jo7S1HNdKKwx0KZx/BFYHPtHyvgnfXHTIpMuIfaHchQgpnReqwV
         3CawzcPajoNl2EsTk2FcQQoZ8nEhoeRLIrFFZwJVqzUA2Pl0vl1qQB2rb4otrFAdOktY
         E8bxLqo2cWnNMz+56nIZ/O7UT43HsnJXwATV1wG326fGsC/5DPA+9LTuH9xAx/r+iP/7
         Fm4Z+xm0FlOYF2avFyOy+CCKkXNefNwa4/zeOGWa4UH98k6jG98//lCa8Vc0tWhJjNsA
         VlJv6tNrJEuGT8vH5FjMK6ueJAxEyTcH/AR/emsLAan6KaCex7F4mufaq/WtIV8dlNHY
         VqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:reply-to:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=XgSjhJyKP5xsWGJcS4RGO87v6OeMe6bUmVQ6H5feb10=;
        b=oRqsczCADZj58jZRL8DSNCdVC/TfnQgA5JDJTlbF5FhzgnSNC8MW+OWK2tkZH171pw
         cB3XvTDITLoHcym70nFXqrbsxjR+NJr5GfB7DnDkHltBh0+0W59YMzsgOuFtn5uViYpy
         LRWMiKADY0rAk7cHLeEzOKLJ5oaooZSgGeD3e4AIrkWT/uPFC7etsDQ4boKTinBF1wJs
         4wjNtFmDBA7OXnYGEn3r1IkJ8yhm83L1HCbz0y7YXF1Bb3cgXtVWYBVOGdyEh91Usdnp
         MNxNCQv512CJrA/7y+toHG5xhFQRtmVhwiW6gXwQQRuufpePl6OR44W3TZHGozOFSDW1
         ENcQ==
X-Gm-Message-State: ACrzQf0PmoK37MHbmPFLVk5CMK+R7cMi0eg09vmpM/xMgxxJZk7zGDjt
        //71hvmD2T0r8wsEKax4NbqZXw==
X-Google-Smtp-Source: AMsMyM6jcG8AWYH77MQnejwQt4vE9bRq/8bmcdXGR/JdALTiaNZYqSjOJl2cd9Z7/mSrC+/4fnBDLQ==
X-Received: by 2002:a05:600c:2142:b0:3b4:92b6:73ba with SMTP id v2-20020a05600c214200b003b492b673bamr10408022wml.139.1664449017742;
        Thu, 29 Sep 2022 03:56:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:1f17:3ea3:4e46:dff? ([2a01:e0a:982:cbb0:1f17:3ea3:4e46:dff])
        by smtp.gmail.com with ESMTPSA id f11-20020a05600c154b00b003a3442f1229sm4181341wmg.29.2022.09.29.03.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 03:56:57 -0700 (PDT)
Message-ID: <7f8572ab-ff97-54bd-a5f3-fe0e179ee48e@linaro.org>
Date:   Thu, 29 Sep 2022 12:56:55 +0200
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
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Organization: Linaro Developer Services
In-Reply-To: <1a3c6766-9be5-1e55-95eb-bc9656e5c9a3@linaro.org>
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

On 29/09/2022 11:12, Krzysztof Kozlowski wrote:
> On 29/09/2022 10:29, Neil Armstrong wrote:
>> Hi,
>>
>> On 28/09/2022 20:03, Krzysztof Kozlowski wrote:
>>> On 28/09/2022 11:14, Neil Armstrong wrote:
>>>> The PMIC is an PM8018, but was compatible with the PM8921. Both compatibles
>>>> was left but it makes no sense anymore the leave both.
>>>
>>> Why? It makes sense for backwards compatibility. If you think it does
>>> not make sense, please say why.
>>
>> We had the same debate at submission 7y ago, some of the pm8018 new compatible
>> were rejected in bindings & drivers so I left both...
>>
>> As of today only the pwrkey bindings is missing, so should I resubmit the pm8018-pwrkey bidings and
>> drop the pm8921-pwrkey compatible ?
> 
> ~7 years ago here:
> https://lore.kernel.org/all/20160624220748.GB11719@dtor-ws/
> you proposed to add something entirely different than we have here now
> and than we talk about.
> 
> In that thread you correctly wrote:
> "My point of view is that the devicetree describes the hardware and need
> to have SoC specific compatible string since it describes the actual
> silicon, and drivers must make sure to handle all the SoC or family
> variants using the compatible string and the match data."

And I'm happy this is still the policy! And I'm tried my best to follow this
in all my DT & bindings submissions, while DT-Schema helped a lot here.

> 
> but implemented it entirely different. Maybe you refer to different mail
> thread, I don't know, but that one is indeed wrong.

In the meantime things got much better, but at that time pushing a SoC bringup
was a pain (I did 2 at the time, the other one is the OX810SE) and I even
mentioned it in a talk ([1] slides 27 to 30).

So I added both to be sure that at some point a driver would probe against
one of the compatible entries...

> 
> The DTS looks correct unless you have some real argument that it is not.
> 
> How this should be fixed? First, drop bogus entries from drivers, then
> document proper compatibles.

What do you mean ? There's no point to keep the PM8921 compatibles, the gpio
and PMIC bindings already enforces to only have the PM8018 compatible.

The only issue is about the PM8018 pwrkey, where the solution would be
to actually re-submit [1] by documenting qcom,pm8018-pwrkey and adding the entry
in the drivers/input/misc/pmic8xxx-pwrkey.c driver.

Or maybe I missed something.

[1] https://www.slideshare.net/superna/elce-2016-neil-armstrong-no-its-never-too-late-to-upstream-your-legacy-linux-based-platform
[2] https://lore.kernel.org/all/1466759887-25394-3-git-send-email-narmstrong@baylibre.com/

> 
> Best regards,
> Krzysztof
> 

Thanks,
Neil
