Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223BD7000F8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 09:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240033AbjELHDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 03:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239826AbjELHD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 03:03:28 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006B97693
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 00:03:23 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so86480419a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 00:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683875002; x=1686467002;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hk7vHQ0BNvgpEVliVNBIkVdWv3ZlYBdzOpOVtAlYss4=;
        b=nHcLuBAMzY/Xr1V6NT3wCzGZRsgLH6aCKFw/q/+DZa3cLizCmLSRPYrRRzT3hGNrKu
         Y8ARm743/EI7Q0mXCI9NQ7XEfR6CLAffXvd+u1VwBCrJP6DDFM0lirSNwUPsADL/Gk5k
         bBRaKeLZQrwIJ7GaN2fbx8+8aMK/dt7KSUUBquVYFCNYFd6VIfUjD9JcG9I2bGy7UXms
         Isc+BpcyNmGDJaWm/Imr54Bw5wp4HxqPmCuXhuhIGd90B42iAYGN72FKV30crVmsx/yN
         QEeSaSRKa/G0wyZ2GepsxqXr+yhGY80GYlMcx6FwnNU+WXZDZAQMUggJsC9rH8WNBN5m
         CuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683875002; x=1686467002;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hk7vHQ0BNvgpEVliVNBIkVdWv3ZlYBdzOpOVtAlYss4=;
        b=MWW84AQsRVYeI+cIpd1BzMgCYDcvICAgBW2EASlhmo0PCWSgnI3qmNnEfXXziQXwH3
         ayk8uzXB750yPJ2TTgA8lKfVN+NPkOKFMCiZeC5pyBsY9N6hWxOGhXVievbdOQjrlN6E
         drbp7AOH7E5XDG2VXTpL2dFvODwpaIXCZccXu4MmwFaFFGZkrNOwkVzqmxTkk6shrQkK
         r3Ic3CFzG/nfyws9BlE58BkKnkxyRZnykHIGVamoRxbm/K+iqnb1G1jec7Iu5pX9vwUR
         N5mcbeI+Dyhvgupgogi+L8S9xjkQtvQijq971vRpNFtCRsX1vfuSntSObvRh5YYEhgNX
         yQaQ==
X-Gm-Message-State: AC+VfDxFPWuwv/3MnxgQ3yejkt40+c4RAJNOf5fvZwg5Qcsi0x7GqW9s
        7D4wi2HZmdF8x12Xrh6n+YMVrw==
X-Google-Smtp-Source: ACHHUZ6KzIf22wqXzMbPLVmqXVtt+8JIieW5G13Rh3ucq71tzS3lD6u+RX7ZiCeB1Oyy7NDEHzyjyg==
X-Received: by 2002:a17:907:7baa:b0:966:1484:469e with SMTP id ne42-20020a1709077baa00b009661484469emr18120747ejc.17.1683875002490;
        Fri, 12 May 2023 00:03:22 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7ede:fc7b:2328:3883? ([2a02:810d:15c0:828:7ede:fc7b:2328:3883])
        by smtp.gmail.com with ESMTPSA id mc11-20020a170906eb4b00b00969f25b96basm4410829ejb.204.2023.05.12.00.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 00:03:22 -0700 (PDT)
Message-ID: <76dfbf27-8ad2-6e09-5354-b006b9e81af1@linaro.org>
Date:   Fri, 12 May 2023 09:03:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2] dt-bindings: usb: dwc3: Add interrupt-names property
 support for wakeup interrupt
Content-Language: en-US
To:     "Mehta, Piyush" <piyush.mehta@amd.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Paladugu, Siva Durga Prasad" <siva.durga.prasad.paladugu@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>
References: <20230511072154.2030703-1-piyush.mehta@amd.com>
 <ca8b31f5-ce4e-d7b1-d077-3684862083bf@linaro.org>
 <MN2PR12MB4333A304BF5D7B97836BACE388759@MN2PR12MB4333.namprd12.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <MN2PR12MB4333A304BF5D7B97836BACE388759@MN2PR12MB4333.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2023 08:57, Mehta, Piyush wrote:
> Hi,
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Thursday, May 11, 2023 3:05 PM
>> To: Mehta, Piyush <piyush.mehta@amd.com>; gregkh@linuxfoundation.org;
>> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
>> conor+dt@kernel.org; balbi@kernel.org; michal.simek@xilinx.com
>> Cc: linux-usb@vger.kernel.org; devicetree@vger.kernel.org; linux-
>> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>; Paladugu,
>> Siva Durga Prasad <siva.durga.prasad.paladugu@amd.com>; git (AMD-Xilinx)
>> <git@amd.com>
>> Subject: Re: [PATCH V2] dt-bindings: usb: dwc3: Add interrupt-names property
>> support for wakeup interrupt
>>
>> On 11/05/2023 09:21, Piyush Mehta wrote:
>>> The hibernation feature enabled for Xilinx Versal NET SoC in DWC3 IP.
>>> As the DWC3 IP supports the hibernation feature, to handle the wakeup
>>> or hibernation interrupt, add host mode "wakeup" interrupt-names
>>> optional property in the binding schema to capture remote-wakeup and
>>> connect/ disconnect event in the hibernation state.
>>>
>>> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
>>> ---
>>> Change in V2:
>>> -  Addressed ROB review comments
>>>  - Updated name of interrupt-names property with "wakeup"
>>>  - Move interrupt-names property from dwc3-xilinx core to dwc3 core.
>>>
>>> Link:
>>>
>> https://lore.kernel.org/all/CAL_JsqK6_7XD7+w+EQvPPmbmSOpfo3JDb0xDN4St
>> u
>>> HUm1kgchw@mail.gmail.com/
>>> ---
>>>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>> b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>> index 50edc4da780e..db512769bd80 100644
>>> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>>> @@ -53,6 +53,8 @@ properties:
>>>        - const: dwc_usb3
>>>        - items:
>>>            enum: [host, peripheral, otg]
>>> +      - items:
>>> +          enum: [dwc_usb3, otg, wakeup]
>>
>> You didn't add only "wakeup" but also dwc_usb3 which does not look correct
>> here as it is common interrupt. The change does not match commit msg and I
>> don't know what you actually want to achieve.
>>
> 
> We have dedicated irq line for hibernation feature,  "wakeup" irq line triggers hibernation interrupt and the system wakes up.
> DWC3 core supports the hibernation feature, we have a dedicated code which is yet to be upstreamed.
> As the hibernation feature provided by dwc3-core, so this will be supported by other SOC/vendors.
> 
> For this, we need the interrupt-name/ interrupt property. To enable the hibernation feature for
> Xilinx Versal NET SoC, the interrupt-name enum would be:
> - enum [host, peripheral, otg, wakeup]

Yes, this makes sense. Other combination could be dwc_usb3 and wakeup
but only if it is real... adding random entries sounds like not really.

Best regards,
Krzysztof

