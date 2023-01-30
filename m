Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE55D680F62
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235997AbjA3NwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjA3NwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:52:04 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E003864D
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 05:52:02 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so10074051wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 05:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a7n0PxcebcHmKgUAZTbAc0QU/gWAxsFXWO0xPIkTGuE=;
        b=AzBN0CYjuUoXUor1L2wXmADp/jKdt1fLSUw4BXTQXmQIX8JJUXqU3bGFykXN7Dd0aK
         kIh/5CAftp6r+yowWZ7oQxylHCcPunMtRLy4qtfyRE36wd8KbN3ATUNs75geIg6P0w1N
         92yf9XvsW9OByiccT3P0fbfCCB27QBP0qT4PQxCbqxa1rhiEDslu2y4kc3wWgL5utpx3
         r+E/icPV8wSFsjhpQAQZHmEJOdYXrUHdwMBf4WWJUXv2spJ/i8INt6nIxwUKu8bRxse7
         nKAbLvE3ILORq54UE2EKe8aJ96//TnkSpCLRR3P5Wv1umcdIpdLkfnvVxgtTSNR0z0T5
         j51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a7n0PxcebcHmKgUAZTbAc0QU/gWAxsFXWO0xPIkTGuE=;
        b=sW0CaQ1IbiFEEwogAa5OM4nfqfvkZ/8A4SW3R4YGp64OFBtB9/49kF8rGlPx5G8kZw
         eiuktj9+Fa2sQSwxRKJ4OtTWxm3TO0ovU2cHy6Mr69lhcI5B8alPi+V+QDu6m2/N8Tja
         jO74+dVA9J4CTAo27ZZCd+vBijdAfN7L6clMs4D+hfq5jHlGstTbXw4FXDdE0bMnRvf8
         aQ0tsnndrr0nVxyIsXw44Xsc6P+PBE1EWWrQTxFPszrAE4tJUy2ujnjDUteLcn3Zw+Td
         QZRQn2X9uec2lW1B2UQAZLTlmGm/3BBj0owaTHlQk2juu0MRLOTofjlALa0uITXi5aYV
         GcpQ==
X-Gm-Message-State: AO0yUKVa4Mcr+uuNclRP/645Rye0Wsc2owPzawr97Nrn9EXy92vIAa2W
        EiHDziEaNrk/N5YI77MTtuNj2g==
X-Google-Smtp-Source: AK7set83eYIYLeNX/W2zorUjCu7uQCvek/ASGg64yVz08SKysalxjaHTJ4xzGbNCKX3gfOe5UaTbHg==
X-Received: by 2002:a05:600c:35d6:b0:3dc:443e:3a8b with SMTP id r22-20020a05600c35d600b003dc443e3a8bmr9419572wmq.16.1675086721024;
        Mon, 30 Jan 2023 05:52:01 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:5f17:219:cb05:7cd? ([2a01:e0a:982:cbb0:5f17:219:cb05:7cd])
        by smtp.gmail.com with ESMTPSA id hg6-20020a05600c538600b003dafbd859a6sm16320125wmb.43.2023.01.30.05.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 05:52:00 -0800 (PST)
Message-ID: <a2c364da-16ba-2a9f-ec4b-507313c78477@linaro.org>
Date:   Mon, 30 Jan 2023 14:51:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] usb: dwc3: qcom: enable vbus override when in OTG
 dr-mode
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230123-topic-sm8550-upstream-dwc3-qcom-otg-v2-1-2d400e598463@linaro.org>
 <5dee594f-b05f-1211-7444-c45691455b9c@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <5dee594f-b05f-1211-7444-c45691455b9c@linaro.org>
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

On 30/01/2023 14:37, Konrad Dybcio wrote:
> 
> 
> On 24.01.2023 09:31, Neil Armstrong wrote:
>> With vbus override enabled when in OTG dr_mode, Host<->Peripheral
>> switch now works on SM8550, otherwise the DWC3 seems to be stuck
>> in Host mode only.
>>
>> Fixes: a4333c3a6ba9 ("usb: dwc3: Add Qualcomm DWC3 glue driver")
>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
> Required for SM6115P Lenovo Tab P11 to switch to peripheral
> with otg dr_mode as well!

Thanks for testing, seems it was applied by Greg

Neil

> 
> Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Konrad
>> Changes in v2:
>> - Added Bryan's reviewed-by
>> - Added Fixes tag
>> - Link to v1: https://lore.kernel.org/r/20230123-topic-sm8550-upstream-dwc3-qcom-otg-v1-1-e287a418aa5f@linaro.org
>> ---
>>   drivers/usb/dwc3/dwc3-qcom.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
>> index b0a0351d2d8b..959fc925ca7c 100644
>> --- a/drivers/usb/dwc3/dwc3-qcom.c
>> +++ b/drivers/usb/dwc3/dwc3-qcom.c
>> @@ -901,7 +901,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>>   	qcom->mode = usb_get_dr_mode(&qcom->dwc3->dev);
>>   
>>   	/* enable vbus override for device mode */
>> -	if (qcom->mode == USB_DR_MODE_PERIPHERAL)
>> +	if (qcom->mode != USB_DR_MODE_HOST)
>>   		dwc3_qcom_vbus_override_enable(qcom, true);
>>   
>>   	/* register extcon to override sw_vbus on Vbus change later */
>>
>> ---
>> base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
>> change-id: 20230123-topic-sm8550-upstream-dwc3-qcom-otg-81795ea148db
>>
>> Best regards,

