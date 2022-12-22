Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D86653E62
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 11:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbiLVKhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 05:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235139AbiLVKgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 05:36:55 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A73164FD
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 02:36:53 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id cf42so2141917lfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 02:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y9FtXCraXeF1bNJWdq+qVeCXME0uFG8Ztiufy+tT/Ak=;
        b=F49hpEpDvjixKw9Z3bdbgWi8NQQ3gWhE9qDeNcBGNCTnhdkBBzlbgtBQefuftVTnKt
         q1uNjUbh8nTK/9mKc+Sb8VjzEC5Utoxm/kXSZRAX/qppkPsCAAQCYKO4joO8bUxTdEhK
         FU1bBLFcvhz8OETmUj21d0/8/dmF/OWVbdYnP3Dq0nHng4b//sKKgZLqVmpJnT3zNrXN
         xBszfcaRtSp+d/iVr/cdJmxqG7Bp5Nj5SQiqs+Rxv7AGTJkXrX98yC6zATuVI575uz74
         FIDsazYuVfObNctM+sknwG8RsnnltH3NEMO5vFtq5RFfDhkCGYm8zQe3eh+V0QkLNdqK
         qabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9FtXCraXeF1bNJWdq+qVeCXME0uFG8Ztiufy+tT/Ak=;
        b=59TWuBeFgyehmb7UPz9NvNahiJRCIpXu/FHl38+jA0kBk3Nu5EAFBshh/o0izsI3dl
         B4wjwE461OXwIFSnhaWS6BmXQQYOjvqeDz73eJUIDhwIYg+OwW3btUxvw0xacV3ojVN2
         Q5aORpIgtwzGtQJJ1JNzidpei5TaBoUbOUPJmZk6bfA/QfEPpXXhYWX1Ex3gFAh8N5Lu
         tJBduovI+yx/Bfnnx9xhGbtKPyRrb24Cw5kavNZv5sTlWU+ekAlzYxzp1EZxGaQrigH/
         jIw2rro9Y1/Uinl45aP97vZhy0XDhGW2fQ2S4ZWYMVA3eziyXo/IfUQ94qf/asZq3aw9
         FzQw==
X-Gm-Message-State: AFqh2krgs6q//gDOUScVFveMWFmNkR22jculaKa150AaxT7lqetQ+O53
        YYAyVYeYsBzhBhsdXPHhBA6w2A==
X-Google-Smtp-Source: AMrXdXvu1EoX1irEwWg7GOK/BhvjZeB+FZsY9+ZwXfr7eosom0HjDQRzGk0P6ZYQtqF+PJQIGetZYw==
X-Received: by 2002:a05:6512:3c89:b0:4b6:fddc:1fcd with SMTP id h9-20020a0565123c8900b004b6fddc1fcdmr3402492lfv.23.1671705411525;
        Thu, 22 Dec 2022 02:36:51 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v26-20020a05651203ba00b004b593fd84ccsm26971lfp.221.2022.12.22.02.36.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 02:36:51 -0800 (PST)
Message-ID: <7d45c125-e4f5-b03f-45d6-3ecf87b2f09d@linaro.org>
Date:   Thu, 22 Dec 2022 11:36:49 +0100
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
 <a251f29d-58b7-5ccb-2661-a397e41fba80@linaro.org>
 <20221222101012.ptrrugxj3ksiyitn@SoMainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221222101012.ptrrugxj3ksiyitn@SoMainline.org>
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

On 22/12/2022 11:10, Marijn Suijten wrote:
> On 2022-12-22 10:29:40, Krzysztof Kozlowski wrote:
>> On 22/12/2022 09:23, Marijn Suijten wrote:
>>> On 2022-12-20 10:52:49, Krzysztof Kozlowski wrote:
>>>> On 19/12/2022 20:28, Marijn Suijten wrote:
>>>>> On 2022-12-19 10:09:03, Krzysztof Kozlowski wrote:
>>>>>> On 19/12/2022 10:07, Krzysztof Kozlowski wrote:
>>>>>>> On 16/12/2022 22:58, Marijn Suijten wrote:
>>>>>>>> From: Martin Botka <martin.botka@somainline.org>
>>>>>>>>
>>>>>>>> Document smmu-500 compatibility with the SM6125 SoC.
>>>>>>>>
>>>>>>>
>>>>>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>>>
>>>>>> Wait, not entirely... no constraints for clocks and regs?
>>>>>
>>>>> Quite odd that there is no warning for my DT patch as it clearly
>>>>> requires at least one clock...
>>>
>>> Again, any idea why there's no warning for this DT mismatching minItems:
>>> 1 for clocks, clock-names and power-domains?
>>
>> I don't know what do you have in DT and what is mismatched. Why there
>> should be a warning?
> 
> There is:
> 
>   clock-names:
>     minItems: 1
>     maxItems: 7
> 
>   clocks:
>     minItems: 1
>     maxItems: 7
> 
> But I did not provide _any_ (see patch 2 of this series).  Shouldn't
> that trigger a warning?

No. Are these required properties?

Best regards,
Krzysztof

