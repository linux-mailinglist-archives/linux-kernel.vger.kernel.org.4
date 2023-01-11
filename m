Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471CB6650D6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 02:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbjAKBAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 20:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235672AbjAKBAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 20:00:09 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0F254DA9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 17:00:02 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id v14so12574516qtq.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 17:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=SYciQNLJd7ZVtX61FXlO1b42D/4FxIruLginHsDqUIY=;
        b=KOIANvjEYD0E5lbguOantmXuq+AZZeDa9+C+DwZE+HwJtP4e1UVDHYY0BeesachCa0
         Ew2Jo8+CYGXZJ0vQuAdiKLjl4e/+Kl6Wi53fnyyrNaIQ9DerPYkQdGX1OpKCV7RvLpHZ
         2ajloiyg79vMPFXBDRFEZ0PcZeuy69pGZKraE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SYciQNLJd7ZVtX61FXlO1b42D/4FxIruLginHsDqUIY=;
        b=NyLxH1S0KVVwnE+d00/TrLOvW1PdOpZvY++LFO5SygGa3b9/gBokWIm1MW2kLty9+U
         I1GLYL8Z2jYynx6MQKnys3/G0FSEppfd3mxrr389uxjzGSMUrlZ6T7W1nThCzeEsI16r
         lAKGOkeihest8SgaU5FYXHpB8ZBBA/2M0BVyfoIt+5FgujAoCxn2i3r0NaXFNmhM3Ayx
         +0olEvFQ4I7gsaaMYAoR3TsKEU5AdQHJ2TEYeQIiqWDeUPl2HjXtL7YQUeZqclal07Ay
         8aSUUltS/g9xR/M5u41RbwSCVlnbH7cHXYNydFvASFp+OL13L0PGDhgrD2FAGwQGu265
         hnqw==
X-Gm-Message-State: AFqh2kqg5U/q3sRJimT+0xU4NkEHGPoG8qHwW+waopXla+aMf35PEqzs
        EN0Ylk2BiE9+Do5sUrcWXp2o8IVlTTwYIzMZA94mQYmfHVFVrjeGgCzLnZafcAKHpTwkJAbZlCS
        0bK/8npuJ5ieg7PJDjx7/6tRni5BrnLRP4rdFbvBezvfvNR1Ayc0nhIa8YkO/2fhDdEXGDgiGWo
        k+qAA+PDcR/DM=
X-Google-Smtp-Source: AMrXdXuU9oDRTVMziIXRsWYqadNF/pNc08qPsiXnW3HfxbivwyaOgHuzXqv/6urihO4ETZMLHlKFjQ==
X-Received: by 2002:ac8:1e19:0:b0:3a7:242:501 with SMTP id n25-20020ac81e19000000b003a702420501mr106432240qtl.46.1673398800892;
        Tue, 10 Jan 2023 17:00:00 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id t7-20020a05620a034700b007054a238bf2sm8036038qkm.126.2023.01.10.16.59.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2023 17:00:00 -0800 (PST)
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
 <49925933-aacc-4f0d-a1ca-e1bd45b05eee@broadcom.com>
 <b246a81f-e465-5e52-f0ce-65e0a82fc3e1@linaro.org>
From:   William Zhang <william.zhang@broadcom.com>
Message-ID: <0194391a-6aef-3a7d-0037-1f87e12a6b6e@broadcom.com>
Date:   Tue, 10 Jan 2023 16:59:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <b246a81f-e465-5e52-f0ce-65e0a82fc3e1@linaro.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000001f383405f1f28530"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000001f383405f1f28530
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 01/10/2023 12:40 AM, Krzysztof Kozlowski wrote:
> On 09/01/2023 20:13, William Zhang wrote:
>>
>>
>> On 01/09/2023 12:56 AM, Krzysztof Kozlowski wrote:
>>> On 09/01/2023 09:27, William Zhang wrote:
>>>> Hi Krzysztof,
>>>>
>>>> On 01/08/2023 06:51 AM, Krzysztof Kozlowski wrote:
>>>>> On 06/01/2023 21:07, William Zhang wrote:
>>>>>> The new Broadcom Broadband BCMBCA SoCs includes a updated HSSPI
>>>>>> controller. Add a new compatible string and required fields for the new
>>>>>> driver.  Also add myself and Kursad as the maintainers.
>>>>>>
>>>>>> Signed-off-by: William Zhang <william.zhang@broadcom.com>
>>>>>> ---
>>>>>>
>>>>>>     .../bindings/spi/brcm,bcm63xx-hsspi.yaml      | 84 +++++++++++++++++--
>>>>>>     1 file changed, 78 insertions(+), 6 deletions(-)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml b/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
>>>>>> index 45f1417b1213..56e69d4a1faf 100644
>>>>>> --- a/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
>>>>>> @@ -4,22 +4,51 @@
>>>>>>     $id: http://devicetree.org/schemas/spi/brcm,bcm63xx-hsspi.yaml#
>>>>>>     $schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>>     
>>>>>> -title: Broadcom BCM6328 High Speed SPI controller
>>>>>> +title: Broadcom Broadband SoC High Speed SPI controller
>>>>>>     
>>>>>>     maintainers:
>>>>>> +
>>>>>
>>>>> Drop blank line.
>>>> will fix in  v2.
>>>>
>>>>>
>>>>>> +  - William Zhang <william.zhang@broadcom.com>
>>>>>> +  - Kursad Oney <kursad.oney@broadcom.com>
>>>>>>       - Jonas Gorski <jonas.gorski@gmail.com>
>>>>>
>>>>>>     
>>>>>> +description: |
>>>>>> +  Broadcom Broadband SoC supports High Speed SPI master controller since the
>>>>>> +  early MIPS based chips such as BCM6328 and BCM63268.  This controller was
>>>>>> +  carried over to recent ARM based chips, such as BCM63138, BCM4908 and BCM6858.
>>>>>> +
>>>>>> +  It has a limitation that can not keep the chip select line active between
>>>>>> +  the SPI transfers within the same SPI message. This can terminate the
>>>>>> +  transaction to some SPI devices prematurely. The issue can be worked around by
>>>>>> +  either the controller's prepend mode or using the dummy chip select
>>>>>> +  workaround. This controller uses the compatible string brcm,bcm6328-hsspi.
>>>>>> +
>>>>>> +  The newer SoCs such as BCM6756, BCM4912 and BCM6855 include an updated SPI
>>>>>> +  controller that add the capability to allow the driver to control chip select
>>>>>> +  explicitly. This solves the issue in the old controller. This new controller
>>>>>> +  uses the compatible string brcm,bcmbca-hsspi.
>>>>>> +
>>>>>>     properties:
>>>>>>       compatible:
>>>>>> -    const: brcm,bcm6328-hsspi
>>>>>> +    enum:
>>>>>> +      - brcm,bcm6328-hsspi
>>>>>> +      - brcm,bcmbca-hsspi
>>>>>
>>>>> bca seems quite unspecific. Your description above mentions several
>>>>> model numbers and "bca" is not listed as model. Compatibles cannot be
>>>>> generic.
>>>> "bca" is not model number, rather it is a group (broadband carrier
>>>> access) of chip that share the same spi host controller IP. Agree it is
>>>> not particularly specific but it differentiate from other broadcom spi
>>>> controller ip used by other groups.  We just don't have a specific name
>>>> for this spi host controller but can we treat bcmbca as the ip name?
>>>
>>> No, it is discouraged in such forms. Family or IP block compatibles
>>> should be prepended with a specific compatible. There were many issues
>>> when people insisted on generic or family compatibles...
>>>
>>>> Otherwise we will have to have a compatible string with chip model for
>>>> each SoC even they share the same IP. We already have more than ten of
>>>> SoCs and the list will increase.  I don't see this is a good solution too.
>>>
>>> You will have to do it anyway even with generic fallback, so I don't get
>>> what is here to gain... I also don't get why Broadcom should be here
>>> special, different than others. Why it is not a good solution for
>>> Broadcom SoCs but it is for others?
>>>
>> I saw a few other vendors like these qcom ones:
>>    qcom,spi-qup.yaml
>>        - qcom,spi-qup-v1.1.1 # for 8660, 8960 and 8064
>>        - qcom,spi-qup-v2.1.1 # for 8974 and later
>>        - qcom,spi-qup-v2.2.1 # for 8974 v2 and later
>>    qcom,spi-qup.yaml
>>        const: qcom,geni-spi
> 
> IP block version numbers are allowed when there is clear mapping between
> version and SoCs using it. This is the case for Qualcomm because there
> is such clear mapping documented and available for Qualcomm engineers
> and also some of us (although not public).
> 
>> I guess when individual who only has one particular board/chip and is
>> not aware of the IP family,  it is understandable to use the chip
>> specific compatible string.
> 
> Family of devices is not a versioned IP block.
> 
>> But when company works on it, we have the
>> visibility and access to all the chips and ip blocks in the family and
>> IMHO it is very reasonable to use the IP family name for the same IP as
>> these examples shows.
> 
> No, because family of devices is not a versioned IP block. I wrote
> before that families and wildcards are not allowed.
> 
>> Are you saying these are not good example to
>> follow?
> 
> It's nothing related to your case.
> 
>> What are the issues with generic or family compatibles?
>>   Could
>> you please elaborate?
> 
> They stop matching and some point and cause ABI breaks. We had several
> cases where engineer believed "I have here family of devices" and then
> later it turned out that the family is different.
> 
> 
>>
>>>
>>>
>>>>
>>>>>
>>>>>>     
>>>>>>       reg:
>>>>>> -    maxItems: 1
>>>>>> +    items:
>>>>>> +      - description: main registers
>>>>>> +      - description: miscellaneous control registers
>>>>>> +    minItems: 1
>>>>>> +
>>>>>> +  reg-names:
>>>>>> +    items:
>>>>>> +      - const: hsspi
>>>>>> +      - const: spim-ctrl
>>>>>
>>>>> This does not match reg
>>>> Do you mean it does not match the description?
>>>
>>> No. reg can be 1 item but you state reg-names cannot. These are always
>>> the same. If one is 1 item, second is as well.
>>>
>> I'll drop the "minItems: 1" from the reg property then.
> 
> Then it won't be correct, because it would mean two items are required
> always.
Ah you are right. Add minItems: 1 for reg-name then.
> 
>>
>>>>>
>>>>>>     
>>>>>>       clocks:
>>>>>>         items:
>>>>>> -      - description: spi master reference clock
>>>>>> -      - description: spi master pll clock
>>>>>> +      - description: SPI master reference clock
>>>>>> +      - description: SPI master pll clock
>>>>>
>>>>> Really? You just added it in previous patch, didn't you?
>>>> The previous patch was just word to word conversion of the text file.  I
>>>> will update that patch to include this change.
>>>>
>>>>>
>>>>>>     
>>>>>>       clock-names:
>>>>>>         items:
>>>>>> @@ -29,12 +58,43 @@ properties:
>>>>>>       interrupts:
>>>>>>         maxItems: 1
>>>>>>     
>>>>>> +  brcm,use-cs-workaround:
>>>>>> +    $ref: /schemas/types.yaml#/definitions/flag
>>>>>> +    description: |
>>>>>> +      Enable dummy chip select workaround for SPI transfers that can not be
>>>>>> +      supported by the default controller's prepend mode, i.e. delay or cs
>>>>>> +      change needed between SPI transfers.
>>>>>
>>>>> You need to describe what is the workaround.
>>>> Will do.
>>>>>
>>>>>> +
>>>>>>     required:
>>>>>>       - compatible
>>>>>>       - reg
>>>>>>       - clocks
>>>>>>       - clock-names
>>>>>> -  - interrupts
>>>>>> +
>>>>>> +allOf:
>>>>>> +  - $ref: "spi-controller.yaml#"
>>>>>
>>>>> No quotes. How this is related to this patch?
>>>> Will remove quote and put it in patch 1.
>>>>>
>>>>>> +  - if:
>>>>>> +      properties:
>>>>>> +        compatible:
>>>>>> +          contains:
>>>>>> +            enum:
>>>>>> +              - brcm,bcm6328-hsspi
>>>>>> +    then:
>>>>>> +      properties:
>>>>>> +        reg:
>>>>>> +          minItems: 1
>>>>>
>>>>> Drop.
>>>>>
>>>>> reg-names now do not match.
>>>> Don't quite understand your comment. What do I need to drop and what is
>>>> not matched?
>>>
>>> You need to add constraints for reg-names, same way as for reg.
>>> Disallowing the reg-names also could work, but there won't be benefit in
>>> it. Better to have uniform DTS.
>>>
>> I agree it is better to have the uniform DTS but the situation here is
>> that the brcm,bcm6328-hsspi does not require reg name since there is
>> only one register needed and it was already used in many chip dts for
>> long time.  If I enforce it to have the corresponding reg name, that
> 
> No one told you to enforce to have a reg-names.
> 
>> could potentially break the compatibility of those old device if the
>> driver change to use reg name, right?
> 
> How compatibility is broken by some optional, unrelated property?
> 
I think I misunderstand what you said.  You basically want the reg-name 
minItem/maxItem constraints for brcm,bcm6328-hsspi compatible as well so 
it is consistent for all the compatibles? I was confused and thought it 
is not needed as reg-name is not required for brcm,bcm6328-hsspi compatible.

> Best regards,
> Krzysztof
> 

--0000000000001f383405f1f28530
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
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEICdaNhqf9nmSgiFe4jrj/BtLLjyi
Guc9FaGP/z+Vw+PYMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIz
MDExMTAxMDAwMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQAPB5g8j2brUFhmGDMuJq/jWtZjqBmma0EtrMfceJWi3SBA
iNx6hVKVuakvi0wpXpYS19zuvV3UA1guch22sMBQTj1x29oRWmsKZSfLf3TSprZsh88QgFLJYlpI
i10nF7DaMY1LO0KL69aGQT7cPUwyO6oICnLXTL1cqUrxi/vOxff+9J61nlpsYKjblW3gh8MBbX+t
z85PZUcVASyJoGgY+xe7WUVUEEaxZQ8aWRE909+rrXwaDBmEASXwvaDNeMWffNqOi3jKvNnrfUqt
nFQSErCZm9ypgfnuY2HUzuSkC478pWEvsyp34TFqASFscbHkxsaWVTh507z+8PHxt1Uy
--0000000000001f383405f1f28530--
