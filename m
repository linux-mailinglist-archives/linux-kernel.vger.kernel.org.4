Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DACB700033
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 08:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239803AbjELGXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 02:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjELGXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 02:23:01 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120AE30FF
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 23:23:00 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9659c5b14d8so1572655666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 23:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683872578; x=1686464578;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t3ZV973mZ8wDacfH4W2Ogi4dVgatvNRFzfDumFoejyw=;
        b=gAKQXfi7SYAzPXnzvuFdJeJS3v1XLD0lJOXvLoxtsvOHD9w+nEeWnuyvdEFQNI8Pns
         vaEJppZZy7sEejnBC/scGsT0r87OceTAABc/J7kzdfsUgdLXhh07VqkREiiIyicy086V
         VxuK0BebPfjfhVleVid7JHtQuqcK2r8xEX/b7pIw3P5Jh/byyMJ0FlfUTOHKquzmD+SE
         tQ0rZDqli1s5iX418SdJVN6PCDDIznlYPq4sVKwg7niJJ6wko23OQxEH6gFFGEhjb4JJ
         xsIaLC4dJQGs903TN93A3CEW3YWmwVeEMgPG0MufFPG8+xsDzNs+AMQ0jWuVqXmoP9DN
         OwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683872578; x=1686464578;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t3ZV973mZ8wDacfH4W2Ogi4dVgatvNRFzfDumFoejyw=;
        b=Dfg4IxVY70Ubm5cEx6nqTC4kHSUpIonTd2cP2U9XYqiEYUr7pTXYWcQILX6LreqR9U
         sJC6uqlCwTd6Oudx7vSNpGZy0PnII5Y4hHzoP50PBqnQgLALkCK4s8F7A5L6oefR4dYj
         s/2zSe2ktl8vtk6j8pGjYLDygGmyREgnuwHguE/q6a+enKPPCvGGSipE6+gtUoRsum7N
         0fFM200RZp3+RH6PZAlk3I13xdj0/YWHuKAcX3zoX6Me07JHjRvkHyg3QCUhRc2uU4fb
         +qLfNjUCk/KKepiuYQDaNntNvEkcgoMWgvFszFQhqHRCFFkqLI/JwNNioSm34pfHHyh+
         BBFg==
X-Gm-Message-State: AC+VfDxfv/s/cUCnaz414/NvDZBoeN7vmygdeEU3IcAUs1G1+MYPJ7XD
        xb/wEqScKlEGPdhOJRBEeYmr8A==
X-Google-Smtp-Source: ACHHUZ797wv+2esMGEI5HPSpewVc4E7eAC/BIMd3/P0XIZXlcfulKz1ArtcVjza7coh4+WDsqMEDtQ==
X-Received: by 2002:a17:907:808:b0:960:ddba:e5c6 with SMTP id wv8-20020a170907080800b00960ddbae5c6mr19768381ejb.22.1683872578457;
        Thu, 11 May 2023 23:22:58 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7ede:fc7b:2328:3883? ([2a02:810d:15c0:828:7ede:fc7b:2328:3883])
        by smtp.gmail.com with ESMTPSA id jy17-20020a170907763100b00969dc13d0b1sm4636093ejc.43.2023.05.11.23.22.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 23:22:57 -0700 (PDT)
Message-ID: <8de01e81-43dc-71af-f56f-4fba957b0b0b@linaro.org>
Date:   Fri, 12 May 2023 08:22:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/5] dt-bindings: net: add mac-address-increment option
Content-Language: en-US
To:     Ivan Mikhaylov <fr0st61te@gmail.com>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Paul Fertser <fercerpav@gmail.com>
References: <20230509143504.30382-1-fr0st61te@gmail.com>
 <20230509143504.30382-4-fr0st61te@gmail.com>
 <6b5be71e-141e-c02a-8cba-a528264b26c2@linaro.org>
 <fc3dae42f2dfdf046664d964bae560ff6bb32f69.camel@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <fc3dae42f2dfdf046664d964bae560ff6bb32f69.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2023 01:31, Ivan Mikhaylov wrote:
> On Wed, 2023-05-10 at 16:48 +0200, Krzysztof Kozlowski wrote:
>> On 09/05/2023 16:35, Ivan Mikhaylov wrote:
>>> Add the mac-address-increment option for specify MAC address taken
>>> by
>>> any other sources.
>>>
>>> Signed-off-by: Paul Fertser <fercerpav@gmail.com>
>>> Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
>>> ---
>>>  .../devicetree/bindings/net/ethernet-controller.yaml      | 8
>>> ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/ethernet-
>>> controller.yaml b/Documentation/devicetree/bindings/net/ethernet-
>>> controller.yaml
>>> index 00be387984ac..6900098c5105 100644
>>> --- a/Documentation/devicetree/bindings/net/ethernet-
>>> controller.yaml
>>> +++ b/Documentation/devicetree/bindings/net/ethernet-
>>> controller.yaml
>>> @@ -34,6 +34,14 @@ properties:
>>>      minItems: 6
>>>      maxItems: 6
>>>  
>>> +  mac-address-increment:
>>> +    $ref: /schemas/types.yaml#/definitions/int32
>>> +    description:
>>> +      Specifies the MAC address increment to be added to the MAC
>>> address.
>>> +      Should be used in cases when there is a need to use MAC
>>> address
>>> +      different from one obtained by any other level, like u-boot
>>> or the
>>> +      NC-SI stack.
>>
>> We don't store MAC addresses in DT, but provide simple placeholder
>> for
>> firmware or bootloader. Why shall we store static "increment" part of
>> MAC address? Can't the firmware give you proper MAC address?
>>
>> Best regards,
>> Krzysztof
>>
> 
> Krzysztof, maybe that's a point to make commit message with better
> explanation from my side. At current time there is at least two cases
> where I see it's possible to be used:
> 
> 1. NC-SI
> 2. embedded
> 
> At NC-SI level there is Get Mac Address command which provides to BMC
> mac address from the host which is same as host mac address, it happens
> at runtime and overrides old one.
> 
> Also, this part was also to be discussed 2 years ago in this thread:
> https://lore.kernel.org/all/OF8E108F72.39D22E89-ON00258765.001E46EB-00258765.00251157@ibm.com/

Which was not sent to Rob though...


> 
> Where Milton provided this information:
> 
> DTMF spec DSP0222 NC-SI (network controller sideband interface)
> is a method to provide a BMC (Baseboard management controller) shared
> access to an external ethernet port for comunication to the management
> network in the outside world.  The protocol describes ethernet packets 
> that control selective bridging implemented in a host network
> controller
> to share its phy.  Various NIC OEMs have added a query to find out the 
> address the host is using, and some vendors have added code to query
> host
> nic and set the BMC mac to a fixed offset (current hard coded +1 from
> the host value).  If this is compiled in the kernel, the NIC OEM is 
> recognised and the BMC doesn't miss the NIC response the address is set
> once each time the NCSI stack reinitializes.  This mechanism overrides
> any mac-address or local-mac-address or other assignment.
> 
> DSP0222
> https://www.dmtf.org/documents/pmci/network-controller-sideband-interface-nc-si-specification-110
> 
> 
> In embedded case, sometimes you have different multiple ethernet
> interfaces which using one mac address which increments or decrements
> for particular interface, just for better explanation, there is patch
> with explanation which providing them such way of work:
> https://github.com/openwrt/openwrt/blob/master/target/linux/generic/pending-5.15/682-of_net-add-mac-address-increment-support.patch
> 
> In their rep a lot of dts using such option.

None of these explain why this is property of the hardware. I understand
that this is something you want Linux to do, but DT is not for that
purpose. Do not encode system policies into DT and what above commit
says is a policy.

Best regards,
Krzysztof

