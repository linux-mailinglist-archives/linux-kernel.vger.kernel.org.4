Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CEA61A1EA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 21:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiKDUJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 16:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiKDUJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 16:09:53 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0060F264B0
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 13:09:51 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id k2so3749929qkk.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 13:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s2w2x5qgfrs2UH4lH19Zuziwi2d3oMiqWOuY2i6wV+k=;
        b=BbHsErvmIp1WxlY55kMFQeuoO0DjymG1Js+lbuRznbSV1gD6ahTMrtM9A+Eysndx5Y
         zk0RM8yBptrLXnGGPvqDk1yw2x36Dr3mvuzBtMdVdSq9wS98XYaiNDc92rCqryoEw17K
         H404WLabDMsRb54A2XyMj9KNNdU2Tkzn0Pv9w5eWXtxdv2i19k4fetRuDdLdBB4YPzDi
         Wodvrq6HdF66Oa3Hv2oPGimscsBU4Y8oUTIXe28TIVDzRcNo1qPkVu/QhW3+NfRRBMqf
         i8JO+je4Hh/ch7fo9SKpJD+7StAJigkt5/2uV7LjA1jLiCrcwA3eO8CA8JaISlqIdgrt
         e0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s2w2x5qgfrs2UH4lH19Zuziwi2d3oMiqWOuY2i6wV+k=;
        b=KgC07Q/vq5vY1XWZeLP0X/ki/Ht8SbL6c9PwF62WGHRsAlTt/eTDSzb7OxcgMk6LDG
         g6YXId+tzpF+ke8ZEAYj0vtsIuznSEsdciggv2g+rEFek8Vh7jISwrcqHEmbWfySpHli
         GxeD+Ov4BEeMPUBYSaQ+lhVBU5+Rpvk5yWIsBCoZ7yDuISr0oFJ8t1I9p0CGYjAarUM4
         /7CEKdXsBdlT0Pxp3lLx9a5dt1A5FhKySq5pWS6Xz3iMh6m+C6bRCgOFaqeBHdUVM4+G
         HAZK0eebaH9a+apAsDXArFRaKLz8uSQ+pcbiRxHfaHM1zQtwQoAr/qrWq21w5nxxLyhu
         8qZA==
X-Gm-Message-State: ACrzQf1zHlmVN4zloPivX3qOoQI8F7rgSAG27M4b5o49IP9qxIgF4wOk
        594vZ6sKXA1sOYwPnlkkOrBCXQ==
X-Google-Smtp-Source: AMsMyM6yqTk+Qn0lS01FjE4TynKZffWANmYs4XwHwnWPriRKzRd1O4hk4tVEaywrwhFRlbJEi/gw2g==
X-Received: by 2002:a05:620a:400e:b0:6da:dd3c:7ff4 with SMTP id h14-20020a05620a400e00b006dadd3c7ff4mr25651530qko.682.1667592591116;
        Fri, 04 Nov 2022 13:09:51 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id bq33-20020a05620a46a100b006eeb3165554sm110636qkb.19.2022.11.04.13.09.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 13:09:50 -0700 (PDT)
Message-ID: <03251423-b136-e4ff-2485-bbb16c0c7f5b@linaro.org>
Date:   Fri, 4 Nov 2022 16:09:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 2/7] dt-bindings: usb: hpe,gxp-udc: Add binding for gxp
 gadget
Content-Language: en-US
To:     "Yu, Richard" <richard.yu@hpe.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Chang, Clay" <clayc@hpe.com>
References: <20221103160625.15574-1-richard.yu@hpe.com>
 <20221103160625.15574-3-richard.yu@hpe.com>
 <b85230d4-8fce-ba49-0d6b-8c4d20132cda@linaro.org>
 <SJ0PR84MB2085A64D47E00077EFF8BFE18D3B9@SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <SJ0PR84MB2085A64D47E00077EFF8BFE18D3B9@SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM>
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

On 04/11/2022 16:03, Yu, Richard wrote:
> Hi Mr. Kozlowski,
> 
> Thank you very much for your quick review and feedbacks.
> 
> I will modify the patches based on your feedback accordingly.
> 
> On this specific patch, you have questions on how we defined the device/gadget configurations: vdevnum and fepnum.
> 
> Please see my answers following the questions:
> 
>> +  vdevnum:
>> +    description:
>> +      virtual device number.
> 
> That's unusual property... Why numbering devices is part of DT (hardware description)?
> 
>>> Richard: In HPE GXP virtual EHCI controller chipset, it can support up to 8 virtual devices(gadgets). Each device/gadget will be represented by a bit in 8 bits register. For example, the interrupt register bit 0 indicates the interrupt from device 0, bit 1 for device 1 ... so on.  When an user defines a device/gadget, he/she can define the device number as between 0 and 7. Thus, the driver can up to the bit position. That is why we have numbering devices as port of DT.
> 
>> +
>> +  fepnum:
>> +    description:
>> +      number of the flexible end-points this device is needed.
> 
> Similar question.
> 
>>> Richard: In HPE GXP virtual EHCI Controller chipset, there is a flexible EP pool. Each flexible EP has its own mapping register. The mapping register bit 0 to 3 is for device number (vdevnum) and bit 4 to 7 is for EP number inside the device. The device driver configures the mapping register to assign a flexible EP to a specific device.  Here, "fepnum" is the input letting the driver know how many EP is needed for this device/gadget.
> 
> Hope I have answered your questions on "vdevnum" and "fepnum". 

Unfortunately I don't see your answers... Or actually I am not sure what
is the answer and what is not. What is unusual, you did not quote my
email but quoted something else. Please send it again, but following
normal mailing list netiquette for replies.

Here is one:

https://en.opensuse.org/openSUSE:Mailing_list_netiquette

Just don't use corporate style of emails on mailing list. We usually
cannot handle them...

Best regards,
Krzysztof

