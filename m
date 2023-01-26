Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D96767D5E0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 21:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjAZUES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 15:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjAZUEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:04:12 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9BD9769
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:04:11 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id s4so2271459qtx.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=Tc8H5kWSYRfbenMDIQgi7Yu7h5bENh1rnVONE9yHa2s=;
        b=DPfbgrxHbQhqwGJmwqKyOzYTwQM2rjSSNFlpceS6XpvPgNCZJuNfCXfPteOnXa4y59
         +3fKPSB6Cpda2UBCLBvCsnR4MRvmddahP9oiRiGf4bUAwoUxEwAFFj5c8GAtHoJLFrHO
         URee9ffHRDSzYfKvw7MO8TPvQ0uqWUV2O3w9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tc8H5kWSYRfbenMDIQgi7Yu7h5bENh1rnVONE9yHa2s=;
        b=C8AMMlzxlWc4Vu8webF8RJihz/VYxZvi9MOXepGrdKKTr+r1w4QQ9ZrQR7XlR7wYbF
         RHfIYPbf6lkWcnzHmFcqRx5p5VKk7Taz6NIDQqRKOM+Emr/ZftyZb0BG0FGRRCFwefB/
         gJ3pZ1jhhturq+gScNAdquGav2Ee4vBylOPV9CgzkTcoBYOmq/4YpZPjsuACayyt2Ogv
         2nh+96dcAvt69dvKt61/hgkY/fjglaJvn1q/sazk6QLyoaUqdvf8OX9i9jKLoWxaMpto
         L4gLucknS3fXlNgRz/E9XvMDF9kbvPNrCP3b+3sPbycKEmirARlFdGQw2BKceGL0X3jU
         ZwQg==
X-Gm-Message-State: AFqh2kpgeOT16pVQHNcCHXkwSJCDpvI3CYF4AhLrEnbph5X2nSbQG/KV
        ciwPaA8w+oW/Qh4Se9wNvKLVBzFt6OoQHvMZeMqwD8zzmc6XIgPa+7ALZs1cKZhEt2JY9q4++O6
        6TbJJNWiZf8DpIjo7iKuzjIe6jVw2xCfNjGzrN8Ob4FIjSSe5qHmU05GhPzjbH5j/+w5ZUzIde4
        dJjdS4TAsaI7Q=
X-Google-Smtp-Source: AMrXdXs9TrtAUQH+Y68dUB0PdATb7y3pkRpnEl9NJ3W5MCt2sqcU2IJmq7e4g3SE1PZ7y60h0fi55w==
X-Received: by 2002:ac8:6f09:0:b0:3b6:309e:dfde with SMTP id bs9-20020ac86f09000000b003b6309edfdemr63509297qtb.27.1674763449895;
        Thu, 26 Jan 2023 12:04:09 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id c16-20020ac80090000000b003b323387c1asm1311953qtg.18.2023.01.26.12.04.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jan 2023 12:04:08 -0800 (PST)
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
 <1489564a-59d3-6d38-fad7-02119bfedbeb@broadcom.com>
 <CAL_JsqL3CYCdamv15-kzvMgoYVpftJ0DoyB5L=LGVi-54GXP5Q@mail.gmail.com>
From:   William Zhang <william.zhang@broadcom.com>
Message-ID: <90d9a7a9-4127-7fb7-ed31-d73096759424@broadcom.com>
Date:   Thu, 26 Jan 2023 12:04:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqL3CYCdamv15-kzvMgoYVpftJ0DoyB5L=LGVi-54GXP5Q@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000008929d505f3304016"
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000008929d505f3304016
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 01/26/2023 05:56 AM, Rob Herring wrote:
> On Wed, Jan 25, 2023 at 3:41 PM William Zhang
> <william.zhang@broadcom.com> wrote:
>> On 01/25/2023 12:51 PM, Rob Herring wrote:
>>> On Wed, Jan 25, 2023 at 11:23:52AM -0800, William Zhang wrote:
>>>> On 01/24/2023 11:35 PM, Krzysztof Kozlowski wrote:
>>>>> On 24/01/2023 23:12, William Zhang wrote:
>>>>>> The new Broadcom Broadband BCMBCA SoCs includes a updated HSSPI
>>>>>> controller. Add new compatible strings to differentiate the old and new
>>>>>> controller while keeping MIPS based chip with the old compatible. Update
>>>>>> property requirements for these two revisions of the controller.  Also
>>>>>> add myself and Kursad as the maintainers.
> 
> [...]
> 
>>>>>>     properties:
>>>>>>       compatible:
>>>>>> -    const: brcm,bcm6328-hsspi
>>>>>> +    oneOf:
>>>>>> +      - const: brcm,bcm6328-hsspi
>>>>>> +      - items:
>>>>>> +          - enum:
>>>>>> +              - brcm,bcm47622-hsspi
>>>>>> +              - brcm,bcm4908-hsspi
>>>>>> +              - brcm,bcm63138-hsspi
>>>>>> +              - brcm,bcm63146-hsspi
>>>>>> +              - brcm,bcm63148-hsspi
>>>>>> +              - brcm,bcm63158-hsspi
>>>>>> +              - brcm,bcm63178-hsspi
>>>>>> +              - brcm,bcm6846-hsspi
>>>>>> +              - brcm,bcm6856-hsspi
>>>>>> +              - brcm,bcm6858-hsspi
>>>>>> +              - brcm,bcm6878-hsspi
>>>>>> +          - const: brcm,bcmbca-hsspi-v1.0
>>>>>> +          - const: brcm,bcmbca-hsspi
>>>>>
>>>>> Why do you need "brcm,bcmbca-hsspi"? Nothing binds to it, so it's
>>>>> useless and very generic.
>>>>>
>>>> This was from Florian's suggestion and Broadcom's convention. See [1] and
>>>> you are okay with that [2].  I added the rev compatible and you were not
>>>> objecting it finally if I understand you correctly.
>>>
>>> Can you have a driver that only understands what 'brcm,bcmbca-hsspi' is
>>> work on all h/w that includes the compatible string? It doesn't seem
>>> like it since v1.1 is a completely new driver. Therefore
>>> 'brcm,bcmbca-hsspi' is pretty much useless.
>>>
>> 'brcm,bcmbca-hsspi' should be added to the binding table of
>> spi-bcm63xx-hsspi.c driver.   This is the initial driver that works for
>> v1.0 controller.  For v1.1 controller, yes it can fallback and work with
>> 1.0 driver spi-bcm63xx-hsspi.c simply not using the new feature in
>> v1.1(chip select signal control through software) and keeping using the
>> prepend mode or dummy cs workaround supported in 1.0 driver.
> 
> If v1.1 is compatible with v1.0, then say that:
> 
> soc-compat, "brcm,bcmbca-hsspi-v1.1", "brcm,bcmbca-hsspi-v1.0"
> 
> IOW, 'brcm,bcmbca-hsspi' is redundant with 'brcm,bcmbca-hsspi-v1.0'.
> They have the same meaning. So pick which one you want to use. Not
> both.
> 
Agree brcm,bcmbca-hsspi fallback is redundant to brcm,bcmbca-hsspi-v1.0. 
I added it to conform Broadcom convention.  But I understand your and 
Krzystof's concern so I'll drop the brcm,bcmbca-hsspi in v3 to get 
things going.

> Also, if that is the case, you shouldn't be introducing a whole new
> driver for v1.1.
> 
Technically I can combine the new feature to the existing driver v1.0 
but I prefer to start the a new driver so it will be much cleaner and 
simpler to follow without all the workarounds and complex logic.

> Rob
> 

--0000000000008929d505f3304016
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQcAYJKoZIhvcNAQcCoIIQYTCCEF0CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3HMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBU8wggQ3oAMCAQICDDG6HZcbcVdEvVYk4TANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMTMxNDVaFw0yNTA5MTAxMTMxNDVaMIGQ
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xFjAUBgNVBAMTDVdpbGxpYW0gWmhhbmcxKTAnBgkqhkiG9w0B
CQEWGndpbGxpYW0uemhhbmdAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEAyKF+RmY29Wvfmfe3L8J4rZNmBIvRmrWKI5td5L0vlpPMCEzUkVhBdL2N9cDP0rPScvWL
CX/9cI1a2BUy/6/ZT5j9PhcUn6A3kwKFGukLY2itfKaDrP3ANVJGhBXPVJ6sx55GF41PkiL2EMnY
7LJGNpl9WHYrw8VqtRediPyXq8M6ZWGPZWxygsE6y1pOkEk9qLpvXTb2Epxk2JWcQFZQCDWVULue
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
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIKGwjAIbbqov5kq2GC6p8w8AmtBv
PS/nPrL+3eCgm0/iMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIz
MDEyNjIwMDQxMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBe3q0mCOQ59x+Bs6dpUZKcuLJJFZ2tFuh/K2ucDAqJyQdL
RkGOx3DD02dqBsFWoU7LUugzZpmZwn+oFHjkPrOLrIxMG1TVJxS8h53mXUGO1dbqkZHYMovv66mC
eNkIVF3DgAWKVu16w+7LLJD6bPCkd9i0Ta9gowWCQT06V9JXlMiBXa6u7VPkOGvz2QfmtXO2UJdq
yBxheLMhOj+5Hgt8L+LQychj324PYvsygH0hMuLOOT1nzs4vgtALHmXKPAVEBjpuYV5ds+qyqBcU
2zL/KIEkUzsfiakjM/szaqf6Qj4l4JdndtPK7tRgKHsiCfqkeToZXbr4hq3UpHiYQo3a
--0000000000008929d505f3304016--
