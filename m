Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A69067BED3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 22:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235339AbjAYVlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 16:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235327AbjAYVlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 16:41:09 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D539C2D172
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 13:41:04 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id x18so71455qvl.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 13:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=+9cIXFxcmK8pQUZGXWePlNHBUPUJAR5dzl8zMSWW730=;
        b=Lrtr8L4M1mSHk+znsQM0iKil2olcv+ZLYK9U66gWbKG3gNVeGi2nhRDEe4e7O+hWQ9
         RqNBuzEJt9wO8ww9hjgYrHotQRdqm+xgTIRnSHrSHrCRXine4ilbYg/J8TuzOXeN5Z11
         +6nPbG7F8gqztQELH98nfQmqd0QZ10Xjfiqe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+9cIXFxcmK8pQUZGXWePlNHBUPUJAR5dzl8zMSWW730=;
        b=xtbvkdkWcBAqCRn4Q3UixlBY/8OZRhgpliOCBnlgj3z5mAbGY5ZfzyZHlLEpnslqvp
         Ezgm4YxIRfFq/tdgIfqWWTMgqKfEAN+8mIaDwRmHudJYsjtRr65nyF+Wd+cYsuAw10N/
         5QgDniH9DPiUCsgBLOXCYpU56ppnQAszxiC5bjUTyJEfOSHOY2U5pSnkZcFV/SemJBxh
         9iA9lCd9/PgFDRYtXZDRf4MM5z5o50DdimrOIhxmDJd27qDHihg6yE9uoQiDJ/2deWpg
         FbLdd6U4nLhLQLpAg2SsjSNYJ3E58pL25ZW1eZxHQZ+EkHFykZBZdTEuyzDpx1dpMIfZ
         7Zww==
X-Gm-Message-State: AO0yUKXEbE627GLwb4j93J1VRmB9rIR+J6afZMBFr6+/2TQavZnwlEVP
        JTH5Tfex2KfiEe2LjWAMZTrD1IJ7/xFo+4pLIn03c1sj3bf+iw2f/jT9JSXApPtERtrYom8ZHyZ
        KIibccoJl7Jy73ZIxc+SlHcp5rMlzEjLXQaNV5RJdhy10qGw9JEFbDqMeEg7ACzeqfvS2ZViiTo
        7QGQBWU3Iu2xeJAw==
X-Google-Smtp-Source: AK7set/+pEmRc746MEYSY93yQWO/9OjbZgtTwe6RqXaBxgqZuGU5cjwXiTHXHN9TjUmDlc5i95z/sg==
X-Received: by 2002:ad4:55ee:0:b0:537:69ef:4a2d with SMTP id bu14-20020ad455ee000000b0053769ef4a2dmr10363530qvb.9.1674682863476;
        Wed, 25 Jan 2023 13:41:03 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id b28-20020a05620a089c00b00704c1f4e756sm4249436qka.14.2023.01.25.13.41.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jan 2023 13:41:02 -0800 (PST)
Subject: Re: [PATCH v2 02/14] dt-bindings: spi: Add bcmbca-hsspi controller
 support
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        tomer.yacoby@broadcom.com, kursad.oney@broadcom.com,
        dregan@mail.com, f.fainelli@gmail.com, anand.gore@broadcom.com,
        jonas.gorski@gmail.com, dan.beygelman@broadcom.com,
        joel.peshkin@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230124221218.341511-1-william.zhang@broadcom.com>
 <20230124221218.341511-3-william.zhang@broadcom.com>
 <abedd2e8-3c7e-f347-06af-99f2e5a2412b@linaro.org>
 <ee4727e1-5705-edb0-c724-2ae4d4d1a8e2@broadcom.com>
 <20230125205123.GA2864330-robh@kernel.org>
From:   William Zhang <william.zhang@broadcom.com>
Message-ID: <1489564a-59d3-6d38-fad7-02119bfedbeb@broadcom.com>
Date:   Wed, 25 Jan 2023 13:40:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20230125205123.GA2864330-robh@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000380af505f31d7d9c"
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000380af505f31d7d9c
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 01/25/2023 12:51 PM, Rob Herring wrote:
> On Wed, Jan 25, 2023 at 11:23:52AM -0800, William Zhang wrote:
>>
>>
>> On 01/24/2023 11:35 PM, Krzysztof Kozlowski wrote:
>>> On 24/01/2023 23:12, William Zhang wrote:
>>>> The new Broadcom Broadband BCMBCA SoCs includes a updated HSSPI
>>>> controller. Add new compatible strings to differentiate the old and new
>>>> controller while keeping MIPS based chip with the old compatible. Update
>>>> property requirements for these two revisions of the controller.  Also
>>>> add myself and Kursad as the maintainers.
>>>>
>>>> Signed-off-by: William Zhang <william.zhang@broadcom.com>
>>>>
>>>> ---
>>>>
>>>> Changes in v2:
>>>> - Update new compatible string to follow Broadcom convention <chip
>>>> specific compatible>, <version of the IP>, <fallback>
>>>> - Add reg-names min/maxItem constraints to be consistent with reg
>>>> property
>>>> - Make interrupts required property
>>>> - Remove double quote from spi-controller.yaml reference
>>>> - Remove brcm,use-cs-workaround flag
>>>> - Update the example with new compatile and interrupts property
>>>> - Update commit message
>>>>
>>>>    .../bindings/spi/brcm,bcm63xx-hsspi.yaml      | 106 +++++++++++++++++-
>>>>    1 file changed, 101 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml b/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
>>>> index d1a0c9adee7a..d39604654c9e 100644
>>>> --- a/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
>>>> +++ b/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
>>>> @@ -4,20 +4,73 @@
>>>>    $id: http://devicetree.org/schemas/spi/brcm,bcm63xx-hsspi.yaml#
>>>>    $schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> -title: Broadcom BCM6328 High Speed SPI controller
>>>> +title: Broadcom Broadband SoC High Speed SPI controller
>>>>    maintainers:
>>>> +
>>>
>>> This is a friendly reminder during the review process.
>>>
>>> It seems my previous comments were not fully addressed. Maybe my
>>> feedback got lost between the quotes, maybe you just forgot to apply it.
>>> Please go back to the previous discussion and either implement all
>>> requested changes or keep discussing them.
>>>
>>> Thank you.
>>>
>> Yeah I forgot to remove the blank line after maintainers tag.  Also
>> regarding the explanation of dummy cs workaround flag,  we decided to remove
>> it as it is not necessary after discussion internally and with SPI
>> maintainer Mark. Let me know if I missed anything else.
>>
>>>> +  - William Zhang <william.zhang@broadcom.com>
>>>> +  - Kursad Oney <kursad.oney@broadcom.com>
>>>>      - Jonas Gorski <jonas.gorski@gmail.com>
>>>> -allOf:
>>>> -  - $ref: spi-controller.yaml#
>>>
>>> In your previous patch, put it already in desired place (after
>>> "required:"), so you will not have to shuffle it.
>>>
>> Will update the previous patch in v3
>>
>>>> +description: |
>>>> +  Broadcom Broadband SoC supports High Speed SPI master controller since the
>>>> +  early MIPS based chips such as BCM6328 and BCM63268.  This initial rev 1.0
>>>> +  controller was carried over to recent ARM based chips, such as BCM63138,
>>>> +  BCM4908 and BCM6858. The old MIPS based chip should continue to use the
>>>> +  brcm,bcm6328-hsspi compatible string. The recent ARM based chip is required to
>>>> +  use the brcm,bcmbca-hsspi-v1.0 as part of its compatible string list as
>>>> +  defined below to match the specific chip along with ip revision info.
>>>> +
>>>> +  This rev 1.0 controller has a limitation that can not keep the chip select line
>>>> +  active between the SPI transfers within the same SPI message. This can
>>>> +  terminate the transaction to some SPI devices prematurely. The issue can be
>>>> +  worked around by either the controller's prepend mode or using the dummy chip
>>>> +  select workaround. Driver automatically picks the suitable mode based on
>>>> +  transfer type so it is transparent to the user.
>>>> +
>>>> +  The newer SoCs such as BCM6756, BCM4912 and BCM6855 include an updated SPI
>>>> +  controller rev 1.1 that add the capability to allow the driver to control chip
>>>> +  select explicitly. This solves the issue in the old controller.
>>>>    properties:
>>>>      compatible:
>>>> -    const: brcm,bcm6328-hsspi
>>>> +    oneOf:
>>>> +      - const: brcm,bcm6328-hsspi
>>>> +      - items:
>>>> +          - enum:
>>>> +              - brcm,bcm47622-hsspi
>>>> +              - brcm,bcm4908-hsspi
>>>> +              - brcm,bcm63138-hsspi
>>>> +              - brcm,bcm63146-hsspi
>>>> +              - brcm,bcm63148-hsspi
>>>> +              - brcm,bcm63158-hsspi
>>>> +              - brcm,bcm63178-hsspi
>>>> +              - brcm,bcm6846-hsspi
>>>> +              - brcm,bcm6856-hsspi
>>>> +              - brcm,bcm6858-hsspi
>>>> +              - brcm,bcm6878-hsspi
>>>> +          - const: brcm,bcmbca-hsspi-v1.0
>>>> +          - const: brcm,bcmbca-hsspi
>>>
>>> Why do you need "brcm,bcmbca-hsspi"? Nothing binds to it, so it's
>>> useless and very generic.
>>>
>> This was from Florian's suggestion and Broadcom's convention. See [1] and
>> you are okay with that [2].  I added the rev compatible and you were not
>> objecting it finally if I understand you correctly.
> 
> Can you have a driver that only understands what 'brcm,bcmbca-hsspi' is
> work on all h/w that includes the compatible string? It doesn't seem
> like it since v1.1 is a completely new driver. Therefore
> 'brcm,bcmbca-hsspi' is pretty much useless.
> 
'brcm,bcmbca-hsspi' should be added to the binding table of 
spi-bcm63xx-hsspi.c driver.   This is the initial driver that works for 
v1.0 controller.  For v1.1 controller, yes it can fallback and work with 
1.0 driver spi-bcm63xx-hsspi.c simply not using the new feature in 
v1.1(chip select signal control through software) and keeping using the 
prepend mode or dummy cs workaround supported in 1.0 driver.

> Really, your 'generic' fallback for v1.0 should be 'brcm,bcm6328-hsspi'
> because that is the one the OS already supports. I don't know why folks
> get so hung up on saying new SoC block is compatible with old SoC's
> block.
> 
> The rule on using version numbers is they must correspond to something.
> FPGA soft IP with released versions is a good example. I always suspect
> a v1 or v1.0 is made up by the binding author.
> 
I had discussion with our ASIC IP team and confirmed we only have two 
versions of HSSPI controller among all the BCA chips. Although it does 
not have version register in the IP block for now, version 1.0 and 1.1 
is what we agreed on and ASIC team was already planning to add rev 
register for the new rev of this IP.  So I agree it is not perfect like 
brcm nand controller and other block that always have rev register but I 
think it is good use for software to identify them in dts based on the 
fact there are only two revisions.

> Rob
> 

--000000000000380af505f31d7d9c
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
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPlMvXTyD0hOEUikF8l+2ZbkQN4W
noRgqrmNEFfUHhLdMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIz
MDEyNTIxNDEwM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQAOlA6rt9O4zFxlMOShEXzJ4qmkhLTgmciU3Kw8KVhuKtxJ
USo/bwwc1I/KBbTvWCVug73A600YPWwgTZ+0Ig45g0NTBvTPwd6MhbFwTNgsOP/dn6k2D/a/SpiW
CCJAIcYH1c0OOVvwxr5UrEsRjDeMo0OTL8W567tPGqsXKPHVPUI5iUn79C9ImMlZcKxYqP1kbPI7
CnV+WWguTFKkL9mGR8kaQOVZwt96EeQrKPYEaINepQBwN/32MVcP8q6LAqZK1RbdLVxCdWnmdwhK
cOyqB614ebx1il9cTr6QNgHka1wnivhc1pFjXd1P8IqfIlOyY4VlLTzgXNBLaE+qITdw
--000000000000380af505f31d7d9c--
