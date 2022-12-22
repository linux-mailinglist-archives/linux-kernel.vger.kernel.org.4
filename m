Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE0C653D7B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 10:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbiLVJ3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 04:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbiLVJ3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 04:29:45 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C1425292
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 01:29:43 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 1so1875554lfz.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 01:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vUw5+xAR6CSlV90Z9Jtt0PsgfxL4+FK/cN85YO8sYAs=;
        b=zm86LYJZGJCFyy3q+wYovmpXKRwKszodAeNJ6RdteurEFBASNQgN9TUHEQj0fX7wE4
         6zycXJq1C/zWOVsbssrIeV3midCXHnk0Rl/twxqIUI1rO8i2sNkWM0gC1TdV+AhsKZhv
         Q1b9qYKeyaAMpLMWEvQqnAP2v9GDKBh5fyCrT3OWVm/hBITMhqTItVy5lPwFlnJZmcA1
         Qnb0uSulB7Ti2YXB3j276TUUh/q7IKmM5moA/nXBAn9lmZ8y8Ziz5LcU0vAHjfLqmSDa
         cBNrxqpPGlx1aQqSHa5pyd5lN74z+kIJ39rODlz9Hj32CJOrPtHQBoxBRJYljjIfcCap
         k7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vUw5+xAR6CSlV90Z9Jtt0PsgfxL4+FK/cN85YO8sYAs=;
        b=DigiYYM8E2Af2JwkzlqSNv14ZLc+QnPOXHoZPfxYJjpILecJbOC1dGOh+glf1GaSqi
         4gxbjzjFLO9FuCzxfx+pl5P+VRxEAx7nNw3JKJr532XztvpZKGT2v8u3R806CmiIheBy
         5pTm9ZIf0q/9a2KnL+0V0RGxLKLn7cJLCqa3DxaXsxw2Pc/MYMaxVfjFi8a39JIs6BN6
         ZKQY0+YnPax/zqjQ1a+ZXWvPS44k3oGBM/RHkbEEi6xtU1EMb5emezhIorIT3KJpIUgk
         H/fh/3Uz1yfgwJewxdlLvzaZOI/I5EEri/YBNSWqSpQLC0DZ0KWCFZzaQfzaAOIk30vI
         O+HA==
X-Gm-Message-State: AFqh2kpUrueeBfisALgS7SzVzt3kcwp/TI4VR5t2/iGRfXL7aYu2xMko
        +RNyPtJ0pWUkIOd19OOcQaWf8w==
X-Google-Smtp-Source: AMrXdXtYCaDp0digHRPYF/xg8yIatz3PMVgSe/I2Y1GSDjmxur7BOI+weI02LhQysJ4UemPWNGi+Pg==
X-Received: by 2002:a05:6512:3b90:b0:4b5:32e6:12e with SMTP id g16-20020a0565123b9000b004b532e6012emr1921621lfv.65.1671701382051;
        Thu, 22 Dec 2022 01:29:42 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id k16-20020a192d10000000b004a05837103csm8848lfj.196.2022.12.22.01.29.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 01:29:41 -0800 (PST)
Message-ID: <a251f29d-58b7-5ccb-2661-a397e41fba80@linaro.org>
Date:   Thu, 22 Dec 2022 10:29:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 1/4] dt-bindings: arm-smmu: Document smmu-500 binding
 for SM6125
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Andersson <andersson@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Lux Aliaga <they@mint.lgbt>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20221216215819.1164973-1-marijn.suijten@somainline.org>
 <20221216215819.1164973-2-marijn.suijten@somainline.org>
 <306709f8-7d45-9b76-f95b-1b3088d37a78@linaro.org>
 <6d263321-782d-9d9c-4fdf-8bcf5b280779@linaro.org>
 <20221219192839.6oqialqqw5xw5fxa@SoMainline.org>
 <b4186ec6-a3f2-4dfb-a83e-25cf6d460a39@linaro.org>
 <20221222082353.lhdw7h3pdqyyvsxy@SoMainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221222082353.lhdw7h3pdqyyvsxy@SoMainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/12/2022 09:23, Marijn Suijten wrote:
> On 2022-12-20 10:52:49, Krzysztof Kozlowski wrote:
>> On 19/12/2022 20:28, Marijn Suijten wrote:
>>> On 2022-12-19 10:09:03, Krzysztof Kozlowski wrote:
>>>> On 19/12/2022 10:07, Krzysztof Kozlowski wrote:
>>>>> On 16/12/2022 22:58, Marijn Suijten wrote:
>>>>>> From: Martin Botka <martin.botka@somainline.org>
>>>>>>
>>>>>> Document smmu-500 compatibility with the SM6125 SoC.
>>>>>>
>>>>>
>>>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>
>>>> Wait, not entirely... no constraints for clocks and regs?
>>>
>>> Quite odd that there is no warning for my DT patch as it clearly
>>> requires at least one clock...
> 
> Again, any idea why there's no warning for this DT mismatching minItems:
> 1 for clocks, clock-names and power-domains?

I don't know what do you have in DT and what is mismatched. Why there
should be a warning?

> 
>>> Irrespective of that downstream doesn't define any (nor power domains).
>>> How should we proceed?
>>
>> Binding now has constraints for clocks so at least that should be added
>> to your variant.
> 
> And that should be:
> 
>     clock-names: false
>     clocks: false
>     power-domains: false
> 
> Because this board does declare have any, at least not when going off of
> downstream DT?

I'll add it for existing platforms, so you can rebase on top.

Best regards,
Krzysztof

