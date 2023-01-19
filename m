Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0C9673173
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 06:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjASF6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 00:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjASF6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 00:58:13 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4B85CE5C
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 21:58:10 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id 20so1375931plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 21:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NqoJEjKcl3UOYqd7SPQRjzEP7ckIMaJAKD1OzGpEQKw=;
        b=hzqrmcOWUVXCz5l2YZEAhL2A7qelvCmWkLTe/GpehR2IISgGvRw4CcXkt11epZaZjM
         HafMdnpe3P6+JZK+Tzp/817fzzFvgFEEvEdmIw4vSnO5zwAnSqCIsvOK9uAevfnYRn2r
         vW+RX6F1mHr4dvllfGArzC4Pta6oOf6A0XIRQjAdu+cFbs0b5Uts0JWckJhu+f0xeO1H
         3GnES/v2G6SEtPgoMIjxqZxxzYjUIhCICb66I+eoK3Trwe9pD6UOyxC+8d8pxylk0QcZ
         iE2kXCkKWx1YdhLxwiOY2EWVP5qMLthknpVSe1tRj2Rn/akGdxc6rJs7nOIRJZFEAISj
         Xv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NqoJEjKcl3UOYqd7SPQRjzEP7ckIMaJAKD1OzGpEQKw=;
        b=a/9LbQatgfx5F+0/U1LgZgvixEXU1LcLk8CdMD420p5f8bN8F+urGAV0VDydM4A3bl
         TtIBGd+ad4idx0JYEyeSkVlqVp/TwtxbRNaNZkW4Tb2DXu87tkcuqN+5tq47Khidhshw
         1HqAPt87dwy1JcrSllrjzx3S83UwFZCfTe3/CFyTyFcehJvKgOkgPwZG6AchmtEBpIM4
         KKLj7sF+NANBb9Ix2MwFG4clKdBSFEE5r1Sleid5TsYrS551MrxQnwQ/PC5UE6WdncJQ
         hdNP4mVV7pNLxxS5nzAf1pIh7BHLvj/LIyiB4m4dBsxYjmgbK+rqpZcY17u+TCHGB1q8
         M5yA==
X-Gm-Message-State: AFqh2krncwosKYUQYcfZSHT0sapKmlpGYg/bh3nvA+dIvsvrze8K5Q4K
        DeavSiGGyd4nr3ndCRoXaBwScg==
X-Google-Smtp-Source: AMrXdXssNyzCzGULvihUFdc0LouhxBz/1PBL4DSn/DIblNtvXTi0WFwPkCvDNqLvH1BSIbWe7wlrGw==
X-Received: by 2002:a17:902:a514:b0:194:476b:1af0 with SMTP id s20-20020a170902a51400b00194476b1af0mr9729302plq.65.1674107889637;
        Wed, 18 Jan 2023 21:58:09 -0800 (PST)
Received: from ?IPV6:2401:4900:1c60:63d3:2d69:9f71:187e:f085? ([2401:4900:1c60:63d3:2d69:9f71:187e:f085])
        by smtp.gmail.com with ESMTPSA id k6-20020a170902c40600b0017f8094a52asm7109120plk.29.2023.01.18.21.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 21:58:08 -0800 (PST)
Message-ID: <ee2dea71-771b-a574-1016-14c357a215d3@linaro.org>
Date:   Thu, 19 Jan 2023 11:28:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] dt-bindings: qcom: geni-se: Fix '#address-cells' &
 '#size-cells' related dt-binding error
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
References: <20230113201038.267449-1-bhupesh.sharma@linaro.org>
 <aef753a5-e8b1-5b7b-1b9e-e92a84de15bd@linaro.org>
 <CAH=2Ntx5rLWu4jzXV8DwKj+yweHPRqb4+Rv8uZpDn_brWDxyJg@mail.gmail.com>
 <b9aa6d30-5fe8-57a9-e478-c99bca70d185@linaro.org>
 <CAH=2Nty2gUL3DufowzHavhUNdeht2dcX4EU7ooM+xzax2vP7uQ@mail.gmail.com>
 <20230119032332.w5in5zmoyavi2s45@builder.lan>
Content-Language: en-US
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <20230119032332.w5in5zmoyavi2s45@builder.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 1/19/23 8:53 AM, Bjorn Andersson wrote:
> On Mon, Jan 16, 2023 at 09:13:12PM +0530, Bhupesh Sharma wrote:
>> On Mon, 16 Jan 2023 at 13:23, Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>> On 15/01/2023 22:33, Bhupesh Sharma wrote:
>>>> On Sun, 15 Jan 2023 at 20:57, Krzysztof Kozlowski
>>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>>
>>>>> On 13/01/2023 21:10, Bhupesh Sharma wrote:
>>>>>> Fix the following '#address-cells' & '#size-cells' related
>>>>>> dt-binding error:
>>>>>>
>>>>>>     $ make dtbs_check
>>>>>>
>>>>>>     From schema: Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
>>>>>>          arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dtb: geniqup@4ac0000:
>>>>>>                #address-cells:0:0: 2 was expected
>>>>>>        From schema: Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
>>>>>
>>>>> Don't we want rather to unify the soc address range?
>>>>
>>>> Well, the assumption in the original dt-bindings was that every reg
>>>> variable is 4 * u32 wide (as most new qcom SoCs set #address- and
>>>> #size-cells to <2>). However, that is not the case for all of the
>>>> SoCs.
>>>
>>> Hm, which device of that SoC cannot be used with address/size cells 2?
>>
>> As noted in the git log already the geniqup on sm6115 / sm4250 cannot
>> be used with address/size cells 2 (See:
>> https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/qcom/sm6115.dtsi#L795)
>>
> 
> I'm not able to find the reasoning you're referring to. We do have cells
> of 2 for these nodes on all other platforms.  If there is a specific
> problem, that can be documented and you can probably use ranges to
> reduce keep the cells of 1 in the geni wrappers.
> 
> 
> The reason why we have cells = 2 on most platforms is because the SMMU
> reports that it's capable of more address bits than the buses will
> handle. So without cells = 2, we can't describe dma-ranges appropriately
> and you get page faults due to truncated addresses on the bus when the
> iommu iova has been picking addresses for you.

Consolidating the replies to your, Krzysztof's and Rob's observations / 
suggestions here..

Yes, the original background to the problem was that I observed that for
the sm6115 based Qualcomm board with me, if I was using 36-bit DMA 
configuration with a few IP blocks (like SDHC), I was seeing some issues.

But, Konrad observed in [1] that it works fine for me on the sm6115 
based Lenovo tab, so I agree to his suggestions and may be he can help
send the '2-cell-ification' patch he has working, in which case I think
we can drop this patch.

@Konrad, please feel free to share the patch you were mentioning and I 
can help test it as well.

[1]. 
https://lore.kernel.org/linux-arm-msm/09fe3e93-328b-13a3-540b-4ca47224b176@linaro.org/

Thanks,
Bhupesh
