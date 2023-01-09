Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59054663010
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237459AbjAITNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237592AbjAITNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:13:37 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDE71D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 11:13:35 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id g7so8741060qts.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 11:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=Bi3oBptD5jCgR3sTIi7hFKVPfq/8Pnrqb6ZI/5Yc2j4=;
        b=UF7KzIkEB/fXc3KnAJ6L2rCYApHXJ8CB06AShSQq3Di2GUYTK3nvf6b0RCj6CpJy3r
         MK6VVRHj2SWz0naODMUrnO6nFPBpyqhQagZY0SCNwZNi+cn5QrIoFJcgJnuy7Qewy1U7
         3jLhR08SpSj5pl8DVCnJ/axVrp2QDAYYAx5EQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bi3oBptD5jCgR3sTIi7hFKVPfq/8Pnrqb6ZI/5Yc2j4=;
        b=j7dfjv9zU5rcyGR+8jtfLqAir2cf6F9fTptN3XBOqJgH7wP9GMkxptov5GwrP21gp5
         mcNA/MrFPRJjavqVYSYziFh+WInr5jtWEZ7chSp3cwq7wb+yp5Y9ZNhEQxxgXlrGop6Y
         LyPqSBAy2ViD2jicGj2pW9n7Y2frs4c1Q3PFSjkZqbrFX6clU31d6zoSLaZ+m3B1YyV9
         BOnViM8IxLHklnUrypW6LnydjHjT+2MKco5K+A8OziflVEY0QoThwPdyaL0vS9L5HZGy
         3uphBXZ7Nou4BVXvIG0eEV+YVcqedjgTkHFn4fZaaWE3eMVUQXgkrQhOGmK06HBZNx2g
         FNDg==
X-Gm-Message-State: AFqh2koHxivcezo2SI5u09e1mX2jzTz07d3FRAezsA7DMKhLE4h6Ynyo
        T7W3z2WMvqQSPxqe6KHGqEU7COaylOoMvR4sSYvJsf+NbNFMz6eGwlEYefC+yetDATk646+ggt2
        ZenIKzXGB9D4tJz8yzuxIITpXnpUlvNum8gjF5JRioZBfCg/Xga5ZzwERDUJf/SdqlBeqeU2xSz
        p1xp11gtPYEtw=
X-Google-Smtp-Source: AMrXdXuFIWS5t0Sn8XEaQ9x45dhkqpM1jcszN6yjhrjcnkzv9JUn2n5JHcRskksky0HKSjY8i70q3g==
X-Received: by 2002:ac8:480b:0:b0:3a5:361f:9819 with SMTP id g11-20020ac8480b000000b003a5361f9819mr93702403qtq.18.1673291614081;
        Mon, 09 Jan 2023 11:13:34 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id z26-20020ac8101a000000b003a70a675066sm4926183qti.79.2023.01.09.11.13.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jan 2023 11:13:32 -0800 (PST)
Subject: Re: [PATCH 02/16] dt-bindings: spi: Add bcmbca-hsspi controller
 support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     anand.gore@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        kursad.oney@broadcom.com, dregan@mail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230106200809.330769-1-william.zhang@broadcom.com>
 <20230106200809.330769-3-william.zhang@broadcom.com>
 <b529a53b-d00c-063d-a58d-e64b0300605d@linaro.org>
 <5dfac2d7-3b4b-9ded-0dde-26b289c604d0@broadcom.com>
 <99b01e96-3b96-6692-c5e1-87db49295e6d@linaro.org>
From:   William Zhang <william.zhang@broadcom.com>
Message-ID: <49925933-aacc-4f0d-a1ca-e1bd45b05eee@broadcom.com>
Date:   Mon, 9 Jan 2023 11:13:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <99b01e96-3b96-6692-c5e1-87db49295e6d@linaro.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000004bc34f05f1d99078"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000004bc34f05f1d99078
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 01/09/2023 12:56 AM, Krzysztof Kozlowski wrote:
> On 09/01/2023 09:27, William Zhang wrote:
>> Hi Krzysztof,
>>
>> On 01/08/2023 06:51 AM, Krzysztof Kozlowski wrote:
>>> On 06/01/2023 21:07, William Zhang wrote:
>>>> The new Broadcom Broadband BCMBCA SoCs includes a updated HSSPI
>>>> controller. Add a new compatible string and required fields for the new
>>>> driver.  Also add myself and Kursad as the maintainers.
>>>>
>>>> Signed-off-by: William Zhang <william.zhang@broadcom.com>
>>>> ---
>>>>
>>>>    .../bindings/spi/brcm,bcm63xx-hsspi.yaml      | 84 +++++++++++++++++--
>>>>    1 file changed, 78 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml b/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
>>>> index 45f1417b1213..56e69d4a1faf 100644
>>>> --- a/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
>>>> +++ b/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
>>>> @@ -4,22 +4,51 @@
>>>>    $id: http://devicetree.org/schemas/spi/brcm,bcm63xx-hsspi.yaml#
>>>>    $schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>    
>>>> -title: Broadcom BCM6328 High Speed SPI controller
>>>> +title: Broadcom Broadband SoC High Speed SPI controller
>>>>    
>>>>    maintainers:
>>>> +
>>>
>>> Drop blank line.
>> will fix in  v2.
>>
>>>
>>>> +  - William Zhang <william.zhang@broadcom.com>
>>>> +  - Kursad Oney <kursad.oney@broadcom.com>
>>>>      - Jonas Gorski <jonas.gorski@gmail.com>
>>>
>>>>    
>>>> +description: |
>>>> +  Broadcom Broadband SoC supports High Speed SPI master controller since the
>>>> +  early MIPS based chips such as BCM6328 and BCM63268.  This controller was
>>>> +  carried over to recent ARM based chips, such as BCM63138, BCM4908 and BCM6858.
>>>> +
>>>> +  It has a limitation that can not keep the chip select line active between
>>>> +  the SPI transfers within the same SPI message. This can terminate the
>>>> +  transaction to some SPI devices prematurely. The issue can be worked around by
>>>> +  either the controller's prepend mode or using the dummy chip select
>>>> +  workaround. This controller uses the compatible string brcm,bcm6328-hsspi.
>>>> +
>>>> +  The newer SoCs such as BCM6756, BCM4912 and BCM6855 include an updated SPI
>>>> +  controller that add the capability to allow the driver to control chip select
>>>> +  explicitly. This solves the issue in the old controller. This new controller
>>>> +  uses the compatible string brcm,bcmbca-hsspi.
>>>> +
>>>>    properties:
>>>>      compatible:
>>>> -    const: brcm,bcm6328-hsspi
>>>> +    enum:
>>>> +      - brcm,bcm6328-hsspi
>>>> +      - brcm,bcmbca-hsspi
>>>
>>> bca seems quite unspecific. Your description above mentions several
>>> model numbers and "bca" is not listed as model. Compatibles cannot be
>>> generic.
>> "bca" is not model number, rather it is a group (broadband carrier
>> access) of chip that share the same spi host controller IP. Agree it is
>> not particularly specific but it differentiate from other broadcom spi
>> controller ip used by other groups.  We just don't have a specific name
>> for this spi host controller but can we treat bcmbca as the ip name?
> 
> No, it is discouraged in such forms. Family or IP block compatibles
> should be prepended with a specific compatible. There were many issues
> when people insisted on generic or family compatibles...
> 
>> Otherwise we will have to have a compatible string with chip model for
>> each SoC even they share the same IP. We already have more than ten of
>> SoCs and the list will increase.  I don't see this is a good solution too.
> 
> You will have to do it anyway even with generic fallback, so I don't get
> what is here to gain... I also don't get why Broadcom should be here
> special, different than others. Why it is not a good solution for
> Broadcom SoCs but it is for others?
>
I saw a few other vendors like these qcom ones:
  qcom,spi-qup.yaml
      - qcom,spi-qup-v1.1.1 # for 8660, 8960 and 8064
      - qcom,spi-qup-v2.1.1 # for 8974 and later
      - qcom,spi-qup-v2.2.1 # for 8974 v2 and later
  qcom,spi-qup.yaml
      const: qcom,geni-spi

I guess when individual who only has one particular board/chip and is 
not aware of the IP family,  it is understandable to use the chip 
specific compatible string. But when company works on it, we have the 
visibility and access to all the chips and ip blocks in the family and 
IMHO it is very reasonable to use the IP family name for the same IP as 
these examples shows. Are you saying these are not good example to 
follow?  What are the issues with generic or family compatibles?  Could 
you please elaborate?

> 
> 
>>
>>>
>>>>    
>>>>      reg:
>>>> -    maxItems: 1
>>>> +    items:
>>>> +      - description: main registers
>>>> +      - description: miscellaneous control registers
>>>> +    minItems: 1
>>>> +
>>>> +  reg-names:
>>>> +    items:
>>>> +      - const: hsspi
>>>> +      - const: spim-ctrl
>>>
>>> This does not match reg
>> Do you mean it does not match the description?
> 
> No. reg can be 1 item but you state reg-names cannot. These are always
> the same. If one is 1 item, second is as well.
> 
I'll drop the "minItems: 1" from the reg property then.

>>>
>>>>    
>>>>      clocks:
>>>>        items:
>>>> -      - description: spi master reference clock
>>>> -      - description: spi master pll clock
>>>> +      - description: SPI master reference clock
>>>> +      - description: SPI master pll clock
>>>
>>> Really? You just added it in previous patch, didn't you?
>> The previous patch was just word to word conversion of the text file.  I
>> will update that patch to include this change.
>>
>>>
>>>>    
>>>>      clock-names:
>>>>        items:
>>>> @@ -29,12 +58,43 @@ properties:
>>>>      interrupts:
>>>>        maxItems: 1
>>>>    
>>>> +  brcm,use-cs-workaround:
>>>> +    $ref: /schemas/types.yaml#/definitions/flag
>>>> +    description: |
>>>> +      Enable dummy chip select workaround for SPI transfers that can not be
>>>> +      supported by the default controller's prepend mode, i.e. delay or cs
>>>> +      change needed between SPI transfers.
>>>
>>> You need to describe what is the workaround.
>> Will do.
>>>
>>>> +
>>>>    required:
>>>>      - compatible
>>>>      - reg
>>>>      - clocks
>>>>      - clock-names
>>>> -  - interrupts
>>>> +
>>>> +allOf:
>>>> +  - $ref: "spi-controller.yaml#"
>>>
>>> No quotes. How this is related to this patch?
>> Will remove quote and put it in patch 1.
>>>
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          contains:
>>>> +            enum:
>>>> +              - brcm,bcm6328-hsspi
>>>> +    then:
>>>> +      properties:
>>>> +        reg:
>>>> +          minItems: 1
>>>
>>> Drop.
>>>
>>> reg-names now do not match.
>> Don't quite understand your comment. What do I need to drop and what is
>> not matched?
> 
> You need to add constraints for reg-names, same way as for reg.
> Disallowing the reg-names also could work, but there won't be benefit in
> it. Better to have uniform DTS.
> 
I agree it is better to have the uniform DTS but the situation here is 
that the brcm,bcm6328-hsspi does not require reg name since there is 
only one register needed and it was already used in many chip dts for 
long time.  If I enforce it to have the corresponding reg name, that 
could potentially break the compatibility of those old device if the 
driver change to use reg name, right?

>>
> Best regards,
> Krzysztof
> 

--0000000000004bc34f05f1d99078
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
YDZuuBJwnyCzevMoPtVYPharioL5H3BRnQi8YoTXH7/uRo33dewYFm474yFjwwnt82TFtveVZkVq
6h4WIQ4wTcwFfET8zMkELnGzS5SHCl8sPD+lNxxJ1JDZYwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRp3aWxsaWFtLnpoYW5nQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUq65GzwZxydFHjjYEU/9h
xHhPWlwwDQYJKoZIhvcNAQELBQADggEBAA2hGG3JPAdGPH0ZdohGUCIVjKz+U+EFuIDbS6A/5jqX
VhYAxZlzj7tSjUIM7G7IhyfqPC46GKJ/4x+Amz1Z6YxNGy71L68kYD6hIbBcA5AM42QBUufly6Oa
/ppSz3WoflVyFFQ5YXniZ+eU+2/cdnYZg4aVUnFjimOF5o3NfMLzOkhQNxbaDjFUfUYD8hKmU6v4
0vUBj8KZ9Gi1LIagLKUREn8jku0lcLsRbnJ5Ey5ScajC/FESPyYWasOW8j8/1EoJksmhbYGKNS6C
urb/KlmDGfVrIRYDbL0ckhGQIP5c6L+kSQZ2sHnQK0e0WgIaZYxaPYeY5u0GLCOze+3vyRMxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwxuh2XG3FXRL1W
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIHdQzQN9hyUj4tQrIr6/bNPYB/+y
6wwfxfxa3YluqmzQMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIz
MDEwOTE5MTMzNFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBFVD0oahQxKwSiCo+pQ0QnJ4d+Qfv5BnWrKA2cSu6DQhhO
ZYyHXVeBwoEPhfcRJbIbCNVUXcEnpkHdrsEPh2sTRr+KLzUmZpG3VM3E5596K1r2R43zbXNmPWM9
Jmz032YjWer3cyz7KthhYozZdrHIco/yuHgcGPBrlil3Zc9unitztDTdtbGY5ZNZfzhCLpts7ee4
iskaTOM4aJlfChKk3C2Zp+qwLY9O9uti4HkauRj4fYrljXfN3MAqMNZ4Le0Qp4xm3vyeJEo2XfbE
cHmNUsyaUka7v5RPnl8x+o7/+siehUDWgbDVQ5Znr/SKuMVgEYQIVCkVP0kHfUtbf7wG
--0000000000004bc34f05f1d99078--
