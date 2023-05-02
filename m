Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6596F40FD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 12:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbjEBKTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 06:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbjEBKTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 06:19:12 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC70E5597
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 03:19:10 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50bcc565280so1901834a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 03:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683022749; x=1685614749;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PSOQWv5cIhWugBKgY0Tf8haO/+bAiIBjy0ljcFCS7pE=;
        b=sU4YH9jOZeGVjyZ1m4F/RektzfkMf2vg9+4cIdsuJaEOX/tAdSZjMllV324DlTO4is
         3BVDhUi3OnaY5mVCoDnuClb/yZ+UXhfMtl8Hw0Hw9LRhwxvcVWx/Jgu+DHUxr/rxFIo6
         j38ucgy3ttImNwyrLZzyaSQv2VPW7ugbSoaw+zAleDh1lepsNQXyENSYJXEvDzQ9r2xi
         Ra7ptpkuNvOZjqkh7EH5yboRJ/5veLuJr2nOB98dSWOpxlWjrPctyxwgoBj3l+ytl4jn
         HvAOE5WdLxZECWEO4aoKxzZivNqaP+6P3way5gkg5/pL9AfdZz1nRqNLYwpKrZbDtbbh
         BnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683022749; x=1685614749;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PSOQWv5cIhWugBKgY0Tf8haO/+bAiIBjy0ljcFCS7pE=;
        b=Cwqga4KvgRcUDRVI/yFvuNJ+cST7ZR/e4KcokOFuRUiSfljuypabjtSUTiAB0NGxPY
         SkQRTSZdXYxAB7626u00aDl8QaYy+zBVjwNMZzSOBeGGA541eEo3mDu8DMOXDHOyl1iF
         1bp4Ingi4dOk8jccuEVr1719NRLC91px9EL+VhPIhNMXIEK2benNR2DTRWi8fxOcCL2m
         IlE3eGyJb84KP3KU8/3geI0wQ7EUQOM3TpMbJ+jwjS0t33S0/62ruRzC0ZBnyGRdfg0W
         XG40dcc6xbsKHY8Q+o21CT4VUbGMciGxe5nleGeQXenaKE0lkGDFVwffpMoO9WQhIAdg
         nYDg==
X-Gm-Message-State: AC+VfDzMo56g3FR0Nc35o2xZInfCdUy/bVFQiXwo00+m1wcHFMnKlcQK
        LFkMhVx4CP/LTRqJc55/N1eGbA==
X-Google-Smtp-Source: ACHHUZ7tLdRIYdOi6QjvP8Fn9gC7J1+rSZR+Ue+G/TFVdN8qdNoXM1jyPVQaYKSzGHlTX9Pdknpw7Q==
X-Received: by 2002:a05:6402:8:b0:504:8c1a:70db with SMTP id d8-20020a056402000800b005048c1a70dbmr7705427edu.32.1683022749367;
        Tue, 02 May 2023 03:19:09 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:bafd:1283:b136:5f6a? ([2a02:810d:15c0:828:bafd:1283:b136:5f6a])
        by smtp.gmail.com with ESMTPSA id u10-20020a056402064a00b00506addaaab0sm13225333edx.32.2023.05.02.03.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 03:19:08 -0700 (PDT)
Message-ID: <59b9214a-19e6-fd4e-6982-6e8c28c7e4a8@linaro.org>
Date:   Tue, 2 May 2023 12:19:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/2] dt-bindings: Add optional gpio property to uartps
 node to support rs485
Content-Language: en-US
To:     "Guntupalli, Manikanta" <manikanta.guntupalli@amd.com>,
        Rob Herring <robh@kernel.org>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
        "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>,
        "Goud, Srinivas" <srinivas.goud@amd.com>,
        "manion05gk@gmail.com" <manion05gk@gmail.com>
References: <1682512187-8828-1-git-send-email-manikanta.guntupalli@amd.com>
 <1682512187-8828-2-git-send-email-manikanta.guntupalli@amd.com>
 <20230427164351.GA3146210-robh@kernel.org>
 <DM4PR12MB6109C2BCDFD616AE37E10B9A8C6F9@DM4PR12MB6109.namprd12.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DM4PR12MB6109C2BCDFD616AE37E10B9A8C6F9@DM4PR12MB6109.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2023 12:14, Guntupalli, Manikanta wrote:
> Hi Rob Herring,
> 
>> -----Original Message-----
>> From: Rob Herring <robh@kernel.org>
>> Sent: Thursday, April 27, 2023 10:14 PM
>> To: Guntupalli, Manikanta <manikanta.guntupalli@amd.com>
>> Cc: gregkh@linuxfoundation.org; krzysztof.kozlowski+dt@linaro.org;
>> michal.simek@xilinx.com; linux-serial@vger.kernel.org;
>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
>> jirislaby@kernel.org; linux-arm-kernel@lists.infradead.org; Simek, Michal
>> <michal.simek@amd.com>; git (AMD-Xilinx) <git@amd.com>; Pandey,
>> Radhey Shyam <radhey.shyam.pandey@amd.com>; Datta, Shubhrajyoti
>> <shubhrajyoti.datta@amd.com>; Goud, Srinivas <srinivas.goud@amd.com>;
>> manion05gk@gmail.com
>> Subject: Re: [PATCH 1/2] dt-bindings: Add optional gpio property to uartps
>> node to support rs485
>>
>> On Wed, Apr 26, 2023 at 05:59:46PM +0530, Manikanta Guntupalli wrote:
>>> Add optional gpio property to uartps node and add reference to rs485.yaml
>>
>> The diff tells me that already. Why?
> Please check Figure 11-3 (Page number 37) in the below mentioned data sheet, It shows PMOD (ISOW14x2) devices used in half duplex configuration. Driver outputs Y and Z are shorted to A and B respectively. This reduces overall cabling requirements. Also DE/RE are shorted to each other, and at a time, any node acts as either a driver or a receiver.
> Using above optional GPIO controlling driver or a receiver. This GPIO is optional because it is not required for uart console node.
> 
> Here,
> DE - Driver enable. If pin is floating, driver is disabled (internal pull-down resistor)
> RE - Receiver enable. If pin is floating, receiver buffer is disabled (internal pull-up resistor)
> 
> Datasheet:
> https://www.ti.com/lit/ds/symlink/isow1432.pdf?ts=1682607122706&ref_url=https%253A%252F%252Fwww.ti.com%252Fproduct%252FISOW1432%252Fpart-details%252FISOW1432DFMR%253FkeyMatch%253DISOW1432DFMR%2526tisearch%253Dsearch-everything%2526usecase%253DOPN

Your request for us to get into some datasheet somewhere, to get the
answer to the basic question, is not reasonable. Commit must justify its
existence, not some external source.

> 
>>
>>>
>>> Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
>>> ---
>>>  Documentation/devicetree/bindings/serial/cdns,uart.yaml | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.yaml
>> b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
>>> index a8b323d7bf94..34ed0d80b923 100644
>>> --- a/Documentation/devicetree/bindings/serial/cdns,uart.yaml
>>> +++ b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
>>> @@ -46,6 +46,10 @@ properties:
>>>    power-domains:
>>>      maxItems: 1
>>>
>>> +  txrx-gpios:
>>> +    description: Optional GPIO to switch transmit and receive modes via
>> pmod.
>>
>> What's pmod?
> Pmod is galvanically-isolated RS-485/RS-422 transceivers with a built-in isolated
> DC-DC converter, that eliminates the need for a separate isolated power supply in
> space constrained isolated designs.

It's not about explaining it here, but making your changes justified and
obvious once implemented.

Best regards,
Krzysztof

