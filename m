Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5E872A2C5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 21:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjFITF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 15:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjFITF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 15:05:26 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3D435B3
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 12:05:24 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-75ebb3d57d0so196505485a.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 12:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1686337524; x=1688929524;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=nHOUILOrmymV+dxcx24xkTZyu9Msps4ANqUGuxJz83c=;
        b=R02aLLvadECrj/F8utvoO3H5C2h5IMbxkdX7JRCUDgZ0IL+5VZ615WrJSODemOvPhf
         uyDtsggd6/19X7DsSXiAGBqgoaDpLx72owCgv9qXrnpLKYpqbgX+MkXRYuAr+cHorzZ9
         d2klkJuxYLCUVRPweRKVYO6srdWNqldUxeBnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686337524; x=1688929524;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nHOUILOrmymV+dxcx24xkTZyu9Msps4ANqUGuxJz83c=;
        b=El9XvfX81aEw/03eKilVP+DJgFLd8361OY6uHPLjeEktwiORrOf62v44Bthrg39hNL
         uKXyHHV3O7oLKkr8Bylq6ltoCdRzmqcjCH3ysze+sANljW/g1BFKRNreImZlhtrqiPBP
         DM1LayvRM19u/XBXV7S9vJU3/YMKur/Jd+kuAcf3YTV07NlMWitDLSRqHbvFHSqX2ijF
         fnoAcxrbqPXCGfXev4vW3dLI4pJDjMGV6tnPyxZ/Vsj+tHnvvS7A058oib9Gx6v/aQBw
         rJ4e3MYUWtWkzGYJrGC/oYiFOkAA1Hrk1zC35pWsEOx55JRg9JMBKGJA4JR5frJzbKjM
         gymA==
X-Gm-Message-State: AC+VfDyT1kDdfVeBiwne/bLfnyayHAF29Rqj9/+7olhGpYlEJ2qpwRPz
        U7nsC4vEvGlJ9/8SopEhRGy3LQ==
X-Google-Smtp-Source: ACHHUZ4XFDa04smZ5M+x/BoUTxmht5Q0i/VneH5YMEXXWRSsgi16oCmXW6ZQAqIzRU2fJPka19ndxQ==
X-Received: by 2002:a05:620a:a05:b0:75b:23a0:d9cc with SMTP id i5-20020a05620a0a0500b0075b23a0d9ccmr2210505qka.34.1686337523848;
        Fri, 09 Jun 2023 12:05:23 -0700 (PDT)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id x16-20020a05620a01f000b0075783f6c2b4sm1210667qkn.128.2023.06.09.12.05.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jun 2023 12:05:22 -0700 (PDT)
Subject: Re: [PATCH 05/12] dt-bindings: mtd: brcmnand: Updates for bcmbca SoCs
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Linux MTD List <linux-mtd@lists.infradead.org>,
        f.fainelli@gmail.com, rafal@milecki.pl, kursad.oney@broadcom.com,
        joel.peshkin@broadcom.com, computersforpeace@gmail.com,
        anand.gore@broadcom.com, dregan@mail.com, kamal.dasu@broadcom.com,
        tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
References: <20230606231252.94838-1-william.zhang@broadcom.com>
 <20230606231252.94838-6-william.zhang@broadcom.com>
 <20230607101452.4c265d7e@xps-13>
 <84e97108-29d4-5103-14f4-03e3c0eba165@broadcom.com>
 <20230609105857.7256c02f@xps-13>
From:   William Zhang <william.zhang@broadcom.com>
Message-ID: <d49a915b-bea5-12a4-a72a-38f925ffb025@broadcom.com>
Date:   Fri, 9 Jun 2023 12:05:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20230609105857.7256c02f@xps-13>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000001a0e8405fdb70d47"
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000001a0e8405fdb70d47
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

Hi Miquel,

On 06/09/2023 01:58 AM, Miquel Raynal wrote:
> Hi William,
> 
> william.zhang@broadcom.com wrote on Wed, 7 Jun 2023 13:01:56 -0700:
> 
>> Hi Miquel,
>>
>> On 06/07/2023 01:14 AM, Miquel Raynal wrote:
>>> Hi William,
>>>
>>> william.zhang@broadcom.com wrote on Tue,  6 Jun 2023 16:12:45 -0700:
>>>    
>>>> Use new compatiable brcm,nand-bcmbca to support BCMBCA broadband
>>>> product. The old compatible string is still kept in the driver so old
>>>> dtb can still work.
>>>>
>>>> Add brcm,nand-use-wp property to have an option for disabling this
>>>> feature on broadband board design that does not use write protection.
>>>> Add brcm,nand-ecc-use-strap to get ecc setting from board strap for
>>>> broadband board designs because they do not specify ecc setting in dts
>>>> but rather using the strap setting.
>>>>
>>>> Remove the requirement of interrupts and interrupt-names properties to
>>>> reflect the driver code.
>>>>
>>>> This patch also includes a few minor fixes to the BCM63xx compatibles
>>>> and add myself to the list of maintainers.
>>>>
>>>> Signed-off-by: William Zhang <william.zhang@broadcom.com>
>>>> ---
>>>>
>>>>    .../bindings/mtd/brcm,brcmnand.yaml           | 64 +++++++++++++------
>>>>    1 file changed, 43 insertions(+), 21 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
>>>> index 1571024aa119..1fe1c166a9db 100644
>>>> --- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
>>>> +++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
>>>> @@ -9,6 +9,7 @@ title: Broadcom STB NAND Controller
>>>>    maintainers:
>>>>      - Brian Norris <computersforpeace@gmail.com>
>>>>      - Kamal Dasu <kdasu.kdev@gmail.com>
>>>> +  - William Zhang <william.zhang@broadcom.com>
>>>>    >>   description: |
>>>>      The Broadcom Set-Top Box NAND controller supports low-level access to raw NAND
>>>> @@ -18,9 +19,10 @@ description: |
>>>>      supports basic PROGRAM and READ functions, among other features.
>>>>    >>     This controller was originally designed for STB SoCs (BCM7xxx) but is now
>>>> -  available on a variety of Broadcom SoCs, including some BCM3xxx, BCM63xx, and
>>>> -  iProc/Cygnus. Its history includes several similar (but not fully register
>>>> -  compatible) versions.
>>>> +  available on a variety of Broadcom SoCs, including some BCM3xxx, MIPS based
>>>> +  Broadband SoC (BCM63xx), ARM based Broadband SoC (BCMBCA) and iProc/Cygnus.
>>>> +  Its history includes several similar (but not fully register compatible)
>>>> +  versions.
>>>>    >>     -- Additional SoC-specific NAND controller properties --
>>>>    >> @@ -53,9 +55,9 @@ properties:
>>>>                  - brcm,brcmnand-v7.2
>>>>                  - brcm,brcmnand-v7.3
>>>>              - const: brcm,brcmnand
>>>> -      - description: BCM63138 SoC-specific NAND controller
>>>> +      - description: BCMBCA SoC-specific NAND controller
>>>>            items:
>>>> -          - const: brcm,nand-bcm63138
>>>> +          - const: brcm,nand-bcmbca
>>>>              - enum:
>>>>                  - brcm,brcmnand-v7.0
>>>>                  - brcm,brcmnand-v7.1
>>>> @@ -65,11 +67,15 @@ properties:
>>>>              - const: brcm,nand-iproc
>>>>              - const: brcm,brcmnand-v6.1
>>>>              - const: brcm,brcmnand
>>>> -      - description: BCM63168 SoC-specific NAND controller
>>>> +      - description: BCM63xx SoC-specific NAND controller
>>>>            items:
>>>> -          - const: brcm,nand-bcm63168
>>>> -          - const: brcm,nand-bcm6368
>>>> -          - const: brcm,brcmnand-v4.0
>>>> +          - enum:
>>>> +              - brcm,nand-bcm63168
>>>> +              - brcm,nand-bcm6368
>>>> +          - enum:
>>>> +              - brcm,brcmnand-v2.1
>>>> +              - brcm,brcmnand-v2.2
>>>> +              - brcm,brcmnand-v4.0
>>>>              - const: brcm,brcmnand
>>>>    >>     reg:
>>>> @@ -111,6 +117,19 @@ properties:
>>>>          earlier versions of this core that include WP
>>>>        type: boolean
>>>>    >> +  brcm,nand-use-wp:
>>>> +    description:
>>>> +      Use this integer to indicate if board design uses
>>>> +      controller's write protection feature and connects its
>>>> +      NAND_WPb pin to nand chip's WP_L pin. Driver defaults to
>>>> +      use this feature when this property does not exist.
>>>> +      Set to 0 if WP pins are not connected and feature is not
>>>> +      used. Set to 1 if WP pins are connected and feature is used.
>>>> +      Set to 2 if WP pins are connected but disable this feature
>>>> +      through driver that sets controller to output high on NAND_WPb.
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +    enum: [0, 1, 2]
>>>
>>> Perhaps strings would be welcome. I'll let binding maintainers say what
>>> they think of it.
>>>    
>> Practically there is really just use cases of 0 and 1. I could use a bool flag but to keep consistent with the driver code and in case there is any existing usage of 2.
>>
>>>> +
>>>>    patternProperties:
>>>>      "^nand@[a-f0-9]$":
>>>>        type: object
>>>> @@ -136,13 +155,23 @@ patternProperties:
>>>>              layout.
>>>>            $ref: /schemas/types.yaml#/definitions/uint32
>>>>    >> +      brcm,nand-ecc-use-strap:
>>>> +        description:
>>>> +          This flag is used by the driver to get the ecc strength and
>>>> +          spare area size from the SoC NAND boot strap setting. This
>>>> +          is commonly used by the BCMBCA SoC board design. If ecc
>>>> +          strength and spare area size are set by nand-ecc-strength
>>>> +          and brcm,nand-oob-sector-size in the dts, these settings
>>>> +          have precedence and override this flag.
>>>> +        $ref: /schemas/types.yaml#/definitions/flag
>>>
>>> How in practice do you access the strap value? Don't you need a phandle
>>> over a specific area in the SoC?
>>>    
>> The strap value is latched and stored in the NAND controller register so there is no extra phandle needed.
> 
> Ok.
> 
>>
>>>> +
>>>>    allOf:
>>>>      - $ref: nand-controller.yaml#
>>>>      - if:
>>>>          properties:
>>>>            compatible:
>>>>              contains:
>>>> -            const: brcm,nand-bcm63138
>>>> +            const: brcm,nand-bcmbca
>>>>        then:
>>>>          properties:
>>>>            reg-names:
>>>> @@ -153,7 +182,9 @@ allOf:
>>>>          properties:
>>>>            compatible:
>>>>              contains:
>>>> -            const: brcm,nand-bcm6368
>>>> +            enum:
>>>> +              - brcm,nand-bcm63168
>>>> +              - brcm,nand-bcm6368
>>>>        then:
>>>>          properties:
>>>>            reg-names:
>>>> @@ -173,20 +204,12 @@ allOf:
>>>>                - const: nand
>>>>                - const: iproc-idm
>>>>                - const: iproc-ext
>>>> -  - if:
>>>> -      properties:
>>>> -        interrupts:
>>>> -          minItems: 2
>>>> -    then:
>>>> -      required:
>>>> -        - interrupt-names
>>>
>>> Why do you remove this? Removing "interrupts" from the required
>>> properties is fine, but constraining the interrupts property when it is
>>> relevant is still expected.
>>>    
>> There is no requirement for interrupt name even if it have two interrupts. Driver code does not use interrupt name but the interrupt index instead.
> 
> It does not matter in this case how the driver uses the interrupts. If
> names have been provided once in the bindings, you could expect another
> project using the same bindings to use the interrupt names instead of
> the order. So you must keep the names. Just don't mark them required it
> they are.
> 
Certainly any dts file can still have interrupts names with one or two 
interrupts but to my understand it is not required to have the name when 
there are two interrupts. Anyway I will add this back so this constrain 
remains.

>>
>>>>    >>   unevaluatedProperties: false
>>>>    >>   required:
>>>>      - reg
>>>>      - reg-names
>>>> -  - interrupts
>>>
>>> This should be done in a separate patch.
>>>    
>> I thought this is also related to my update for bcmbca chips because they don't need to interrupt and interrupt name.
> 
> The fact that the driver does not use the interrupts does not mean they
> should not be described.
> 
>>
>>>>    >>   examples:
>>>>      - |
>>>> @@ -215,8 +238,7 @@ examples:
>>>>        };
>>>>      - |
>>>>        nand-controller@10000200 {
>>>> -        compatible = "brcm,nand-bcm63168", "brcm,nand-bcm6368",
>>>> -                     "brcm,brcmnand-v4.0", "brcm,brcmnand";
>>>> +        compatible = "brcm,nand-bcm6368", "brcm,brcmnand-v2.1", "brcm,brcmnand";
>>>>            reg = <0x10000200 0x180>,
>>>>                  <0x100000b0 0x10>,
>>>>                  <0x10000600 0x200>;
>>>
>>>
>>> Thanks,
>>> Miquèl
>>>    
> 
> 
> Thanks,
> Miquèl
> 

--0000000000001a0e8405fdb70d47
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
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIOeOIH0MdkAdtTSLvdCf23aitW91
vKKD9kgYCBfL3oKwMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIz
MDYwOTE5MDUyNFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQA4o+OQKsizTIa5advpfKsObCmIvYlnLDBdfjQh7NiLO8O8
7PhZDMc0+ONikYMsS4IicTY6htObKjvTUDOGs5Jv8nUdaTWqi0JATS8QnD0V3sI8uyXj/7KeaNXI
0znEK8QJW/kgpT7yxUf7bND2GP+VeKdjXWyWvsML3QM+6Dtcj0FArYK4EtHvua5UVyZdmmzbcjjm
nPrHUbrFPdNTxrEewWPlwCO3VejIapOWHZLbhYOeIrF9JC7mVzFYQ3EHM0gpBQCLniv/OJ0UN44+
JoQPuzgdJoDkWm+JtlOPwRECOWhmmrhJPL6EZ0MkTFNUTIbUwNqkVupBGtofh4MqcLr5
--0000000000001a0e8405fdb70d47--
