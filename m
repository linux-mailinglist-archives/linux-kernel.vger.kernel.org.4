Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C4862E290
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 18:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240474AbiKQRGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 12:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240309AbiKQRGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 12:06:10 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF0873B81
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 09:06:09 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id d6so3799646lfs.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 09:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1CszqpJWQbSEvq+JCq8Mj+0D0LtVZVbVuSDlMI4mRPc=;
        b=nn9HSJD0DTV7Fn1A1sx7Opmx5v5gqw6MFu8U7btX46zBPbMV987IjviMtcmihDz8Oh
         m1F9RN9lVcoyz27CxmZpFPUot+scN6u5CiXWDCg4zDyD+QZ8NX3buMHiWUK9Zou39yAp
         t4GKHOtyJVWbsBfBu5wdmr9QpKEftzaZPbTLR2Ixve35OTthEYAngAXlq9qOS7sqlJ0W
         9xZqWYQ7t5Q8b2cXPx3IzT2b/4ZMmQ+RwbjBFyYHtaVc+k57csfqgQG6cwIRl5sQm3MZ
         gxK8WulK5/khRw7oLmvuIZzTdOnLbg51qeWSNaLF9906a6Lba7k6pQs3q1lUaahbq6fa
         fLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1CszqpJWQbSEvq+JCq8Mj+0D0LtVZVbVuSDlMI4mRPc=;
        b=1BSIF544+SEB6gbKWpi/r0+pwgIHrXHfAdRbDXdDVn8iMuTy4W8bkQQ866I3g2wINL
         PIlCblYqBD5O17QHe4EFX64NzxqbI7rXNFHxSu2yTSLO0to2ybiBaa1mKMvDikxeqbyW
         /VfC3oc9u41W42FSCPbonBEAvjlyhA0mv0I0ICbBzf9kikom3h2GsbZVhEAYVWk8XuEq
         HxK29IhDBgIB9vcGeao1u2mRH7xkDX4LhkxDC1s+Y7IkUNDXW2VYbS+cQPoJ3uW3jTWx
         MUg1ki/zVghbbblxmB4Lv8sRJCLyK9R8dQV4KszyILnGvyoo4VbZIgeC5ltppebkcGvC
         AaPg==
X-Gm-Message-State: ANoB5pkogFGX1og1qHFLy7HbCBBrOfjS8/Fery+SPdga+4Xp0m11S8W/
        ut/VbpoEQ/SpJFupgBC32Vri7g==
X-Google-Smtp-Source: AA0mqf7Lxs2d6JeclAj9QmQYpWdE+C4PkcqDbtSLDAlIZUUZ16Wm8juGW95jFifsQh9VxFthoU5l2g==
X-Received: by 2002:a19:e016:0:b0:4a4:6991:5d07 with SMTP id x22-20020a19e016000000b004a469915d07mr1292730lfg.358.1668704767440;
        Thu, 17 Nov 2022 09:06:07 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m6-20020a194346000000b004b4a3cc621bsm231257lfj.191.2022.11.17.09.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 09:06:07 -0800 (PST)
Message-ID: <0935a527-7860-5f9b-b97c-2ec1c371e4ed@linaro.org>
Date:   Thu, 17 Nov 2022 18:06:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] dt-bindings: iio: adc: qcom,spmi-vadc: fix PM8350 define
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221117121307.264550-1-krzysztof.kozlowski@linaro.org>
 <20221117122256.GG93179@thinkpad>
 <a3da2ab9-ad36-2283-0659-ad8ebf877e17@linaro.org>
 <20221117155658.00005d08@Huawei.com>
 <9ddf7e56-f396-5720-9960-e3ef4aa9a204@linaro.org>
 <20221117165806.00007f55@huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221117165806.00007f55@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2022 17:58, Jonathan Cameron wrote:
> On Thu, 17 Nov 2022 17:21:25 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 17/11/2022 16:56, Jonathan Cameron wrote:
>>> On Thu, 17 Nov 2022 13:28:33 +0100
>>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>>   
>>>> On 17/11/2022 13:22, Manivannan Sadhasivam wrote:  
>>>>> On Thu, Nov 17, 2022 at 01:13:07PM +0100, Krzysztof Kozlowski wrote:    
>>>>>> The defines from include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h were
>>>>>> changed to take sid argument:
>>>>>>
>>>>>>   Error: Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.example.dts:99.28-29 syntax error
>>>>>>
>>>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>    
>>>>>
>>>>> Looks like I didn't rebase on top of Bjorn's for-next for my series, so didn't
>>>>> see this example.
>>>>>
>>>>> Thanks for fixing!
>>>>>
>>>>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>>>>     
>>>>
>>>> This should not go via Bjorn's tree without IIO ack and
>>>> Jonathan/Lars-Peter/IIO lists were not in CC.
>>>>  
>>> Thanks for the heads up. 
>>>
>>> Not sure I'd have registered there would have been a problem here even
>>> if I had seen original patch.  Anyhow, I assume Bjorn will pick this up
>>> and all will be well again.
>>>
>>> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
>>
>> I am afraid it cannot go via Bjorn's tree, because this depends on a
>> change in your tree:
>> https://lore.kernel.org/all/20221027143411.277980-2-krzysztof.kozlowski@linaro.org/
>>
>> Can you pick it up instead? This is the only way to fix the linux-next,
>> although your tree will have a dt_binding_check error.
>>
>> Other way is to have cross-tree merge, but the commit to bindings
>> headers ended up in DTS patch, so it cannot be shared with driver tree.
> 
> Ah. I've sent Greg a pull reuqest including that patch, so this is going to get
> worse and the linux-next intermediate builds are going to fail which is never good.
> 
> Best bet at this point may be for Bjorn to also take the dependency 
> you list above and the fix.
> 
> Git will happily unwind the same patch turning up in two trees and
> that way he'll have everything and the IIO tree  + char-misc will
> be fine on their own as well.
> 
> That work for everyone?

Yes, that's also good solution. You only need this one commit:
22f1d06f4f283e36622036726093032a07d67c0d
https://lore.kernel.org/all/20221103095810.64606-2-manivannan.sadhasivam@linaro.org/

Best regards,
Krzysztof

