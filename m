Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF08362E18B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240571AbiKQQYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240433AbiKQQXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:23:48 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD2286A56
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:21:31 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id c1so3598806lfi.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mHzEF+Mn5fM2J64O6GOtfsBt3TSnhCmqNZhN0P3yhUg=;
        b=T/PUfF0QrfJAkea3rHNe2URyPEqgwSlvrynt68iLbh9Uhn9eyy1Cg1pJ39hKvrrZ5U
         Twj7JA9YBv03dyaP2nEssEcf7k3sjlNMPJqCz+tdEIENaXFB697oD0xf4Z8ll9KBuy4H
         i9Vd3srP7njYVBgowVVgtw3H018R20vYZlbWhhJtGHJgZWiQR8tdEBjxi88qy0/Tiwoc
         lCAdbl8+qqyMCs7qckeCRevRNYY08cjsuJFO/oSsIrlM+VsrtJWoRdb/VT73P+PPe61Y
         e+u3MNyQcv6BLAA3rvt+UpmarOTh5IUkZ0NCNsasP6AMnHfHlcGwH+QlnHaSlYiujijB
         ExKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mHzEF+Mn5fM2J64O6GOtfsBt3TSnhCmqNZhN0P3yhUg=;
        b=Umzcm5LN7Srhqh/lOF86JztD2SICERf5aC3/Ih+4DhufK211p2Z6SqqwnF5aadbUku
         TdJp9WPABH9ydkmHVgONOBT5JX2jUcElLw8H1Sziet45EFbpoEbco5loCgroM/NPlxnp
         fKGTeESrFlEGDC6qrhOggpt8gWKVj58LJct67TpM7keYamQn9c9R2ovvT+khGtzJfs5o
         WFM27XxzGj7eZjfo8XjydKOqb2GvJTWRL2P16eGgSDLZIpMekiem2OEuY0xD3ZKVk3j2
         jfkc7CRkVlbEmkYntlhw55zn78aLSIgE8yGmK0u+fyJg3Rc9aUxDc2COq5iTKYt99HyH
         z6uw==
X-Gm-Message-State: ANoB5pnUXyFC7HLKa+f8lB4XLIFSXwqg7jAa9mMtSC6MHSX1TgkmctCQ
        HYqRyWKwNr+kc/zmCdF1ZGtmjQ==
X-Google-Smtp-Source: AA0mqf7DuBe5m5CLILNgUEDlSAS5zUIsOOeoY0pvGOlwdj0jAuO/8A43sJSyT6RnPw5ESirPjxYZYQ==
X-Received: by 2002:a05:6512:2207:b0:49f:53d5:d82f with SMTP id h7-20020a056512220700b0049f53d5d82fmr1155083lfu.635.1668702086977;
        Thu, 17 Nov 2022 08:21:26 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id i24-20020a2ea238000000b002773a9b5898sm274550ljm.138.2022.11.17.08.21.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 08:21:26 -0800 (PST)
Message-ID: <9ddf7e56-f396-5720-9960-e3ef4aa9a204@linaro.org>
Date:   Thu, 17 Nov 2022 17:21:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] dt-bindings: iio: adc: qcom,spmi-vadc: fix PM8350 define
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221117155658.00005d08@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2022 16:56, Jonathan Cameron wrote:
> On Thu, 17 Nov 2022 13:28:33 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 17/11/2022 13:22, Manivannan Sadhasivam wrote:
>>> On Thu, Nov 17, 2022 at 01:13:07PM +0100, Krzysztof Kozlowski wrote:  
>>>> The defines from include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h were
>>>> changed to take sid argument:
>>>>
>>>>   Error: Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.example.dts:99.28-29 syntax error
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>  
>>>
>>> Looks like I didn't rebase on top of Bjorn's for-next for my series, so didn't
>>> see this example.
>>>
>>> Thanks for fixing!
>>>
>>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>>   
>>
>> This should not go via Bjorn's tree without IIO ack and
>> Jonathan/Lars-Peter/IIO lists were not in CC.
>>
> Thanks for the heads up. 
> 
> Not sure I'd have registered there would have been a problem here even
> if I had seen original patch.  Anyhow, I assume Bjorn will pick this up
> and all will be well again.
> 
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I am afraid it cannot go via Bjorn's tree, because this depends on a
change in your tree:
https://lore.kernel.org/all/20221027143411.277980-2-krzysztof.kozlowski@linaro.org/

Can you pick it up instead? This is the only way to fix the linux-next,
although your tree will have a dt_binding_check error.

Other way is to have cross-tree merge, but the commit to bindings
headers ended up in DTS patch, so it cannot be shared with driver tree.

Best regards,
Krzysztof

