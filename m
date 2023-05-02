Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919866F4A52
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 21:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjEBT1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 15:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjEBT1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 15:27:20 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AC1173C
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 12:27:18 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50bc5197d33so5245184a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 12:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683055637; x=1685647637;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WlvJAhh++/0u4nv0c2v/4jbnMZEEfAgSioFHncVcNHM=;
        b=FuzPEm5a6HfsdGz0cZuE8bc1PmkbfYtG+rxbUTbb8BBMdYd2jSC9/YA56sI3mATvhk
         9vQFdOvKCs6DMIxixdQlZajWC3k3WpluPi1PAIGBbsC1shROzMCecCYdnmDKrhKmEDL5
         5lLdDUV6n2Lnm65XggKvOZKa8TmJ99xl6xzTk9a1R2/7HpeW98AYAyPRwy7WR7Qcg4ns
         ZO1QTaCGoXu23k18bF4Z5oLUekYI8e+2Eim19pQGftwQLd1QH7bjQymgMYMjlLNrPY6N
         BhdccBth6VCpiZRdchGPhGUAHReo5J8vYhCCJ30h3idWpAHphSQve29M1d1MfQBl7/Tt
         /Eww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683055637; x=1685647637;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WlvJAhh++/0u4nv0c2v/4jbnMZEEfAgSioFHncVcNHM=;
        b=jaeFCl4wiov3Oifp+IawVtTzagsfxWGFUZOEm5OvtxzNibvZhtiYPYpOSJ8rUGCKXN
         MgJWVp/byaqLAxwGjabD06LbH3thEdRFsY7IKlGk4JkoyHOk56PMAzKVluSNNCkmUvGy
         32GoM/XW2vNNWrNsNk/ktW35BkSteg7xFNJbh2bW+44Pzs2DUaPsA8MooRaXGWeqKLwL
         oqUEAxGz8K4U73RR2Bvis19nbyNagUnOOKibY1u7+YWBsaa/l4PAejHdu14aj0g7UqnB
         jth3aRQewZZjiz0DusXv3kcu5P+8WQwmuic7aw7DDdpiZDeoz3ytoEluFjYJXehqGoDj
         b66w==
X-Gm-Message-State: AC+VfDz8F86njBn/ydeL7EmxLfUuTxgoGVIPo8C1f/ZhMAE+9a2kE7bh
        8ycjQetlFN4SKzeS3GwDhk+aqg==
X-Google-Smtp-Source: ACHHUZ72IXzYWeoI10TEpLTlgpk2WAsUnkKi/OYB2kOkCAuBunsYCUpywh4DXYYrck3DimaL2dxCsQ==
X-Received: by 2002:a17:907:608b:b0:88f:a236:69e6 with SMTP id ht11-20020a170907608b00b0088fa23669e6mr931504ejc.7.1683055637249;
        Tue, 02 May 2023 12:27:17 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:37be:eda5:e303:19e0? ([2a02:810d:15c0:828:37be:eda5:e303:19e0])
        by smtp.gmail.com with ESMTPSA id my24-20020a1709065a5800b0094a8115e148sm16431638ejc.87.2023.05.02.12.27.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 12:27:16 -0700 (PDT)
Message-ID: <676dae73-9b59-d0bb-37ca-eaa120e8dcb5@linaro.org>
Date:   Tue, 2 May 2023 21:27:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v4 2/2] dt-bindings: usb: snps,dwc3: Add the compatible
 name 'snps,dwc3-rtk-soc'
Content-Language: en-US
To:     =?UTF-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230502050452.27276-1-stanley_chang@realtek.com>
 <20230502050452.27276-2-stanley_chang@realtek.com>
 <2653e0d1-6570-7469-51da-b539b5c14299@linaro.org>
 <bc5cd630d96f44bcaad7f95f2f45aac1@realtek.com>
 <49d2b103-de1e-637a-1bf0-aaba1c6afaf4@linaro.org>
 <a04e70f97bcb48048edb2f6db7bb6c25@realtek.com>
 <f51b4dc9-e1da-7c9c-1e39-c8510569db9d@linaro.org>
 <c44baa9fae5c445c90103cd2e129ab0b@realtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c44baa9fae5c445c90103cd2e129ab0b@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2023 12:37, Stanley Chang[昌育德] wrote:
> Hi Krzysztof,
> 
>>>>>> On 02/05/2023 07:04, Stanley Chang wrote:
>>>>>>> Add a new compatible name 'snps,dwc3-rtk-soc' of DT for realtek
>>>>>>> dwc3 core to adjust the global register start address
>>>>>>>
>>>>>>> The RTK DHC SoCs were designed, the global register address offset
>>>>>>> at
>>>>>>
>>>>>> What are: "RTK" and "DHC"? These are manufactured by Synopsys as
>>>>>> you suggest in the patch?
>>>>>
>>>>> RTK is Realtek.
>>>>> DHC is the department name in Realtek and the abbreviation of the
>>>>> Digital
>>>> Home Center.
>>>>> The USB controller of RTK DHC SoCs used the DWC3 IP of Synopsys.
>>>>
>>>> Then entire compatible is not correct. Vendor is Realtek not Synopsys.
>>>> DHC is not even device name. Use real device names.
>>>
>>> So, can we use the compatible name as 'realtek,dwc3' ?
>>
>> dwc3 is not a real device name for Realtek.
> 
> We still use dwc3 IP in Realtek's SoC. Why is the name "dwc3" inappropriate?

dwc3 is the name of design coming from Synopsys. Your device is probably
called differently. Why it is inappropriate? Because your device is not
called DWC3, even though you use IP from Synopsys.

Although vendor,dwc3 is already used as compatible in several cases, I
don't think it is a good pattern.

> 
> Should compatibility names use the SoC name?
> For example, our SoC name
> RTD129x, RTD139x, RTD161x, RTD161xB, etc.
> Should we use these names in compatible names?
> "realtek, rtd129x", "realtek, rtd139x", "realtek, rtd161x"...etc.

Regular rules apply, because your device is not special.
https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42

Therefore either SoC-based device specific name or followed by:
1. SoC-based device specific fallback,
2. Family-device generic fallback,


Best regards,
Krzysztof

