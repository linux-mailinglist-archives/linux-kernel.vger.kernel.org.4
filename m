Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F46730C34
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 02:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbjFOA2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 20:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjFOA2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 20:28:53 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9ED2684
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 17:28:52 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b51780c1b3so979105ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 17:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1686788932; x=1689380932;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=TFNHjAKhrGjZdGP/M2wClt57/xCdGDCcR9NoFSHw6hQ=;
        b=DkmKZ24RbyB90p65MX8G9aZ3/XQ4AfGaM+ihsybhzwqdn4LFnsi6vixPHx9nzAJOhk
         x5TZkHxXPDzFWwER/ISkTUpFHfpF0Ktx5YHzYRSlT9l06DMRrnnohsRxvo0K3fZi/a8x
         d3SmNPJlUFdFXNgcGKqtxsxOEQ2AezdCZN3fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686788932; x=1689380932;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TFNHjAKhrGjZdGP/M2wClt57/xCdGDCcR9NoFSHw6hQ=;
        b=AicaAti1ZYaDnwYxrzZEEwBvFhw7Y5hirLWCpDqXlePxSl8xSFlqzJN59XX7DiKoOy
         pw6NXUL7svHowCXTMexgzYzDKw81m/GaElvnYiQF9VRm8CY8KDk87kRht8ENErKHuuFY
         zx4+vAoRj+t1Be0EW5mTTyQXRW+nh7x93pewtZRgLufYbupqO7DORtP17IJjZspYsk30
         J8hzVKtsamEMrZPnr6t+PoGoEbHgW0EFvJo7veWAzvBmHjBXq/19FEorEcHCosD6wGWA
         CQjYeWsTWRZwyGSZLfwtBunlcVqYLOF3iHN1Fn+K2yChoQsE2pPGCIYCMQ45b99x1pLC
         DxRA==
X-Gm-Message-State: AC+VfDxmQbkQeJf8AHW4vZit1HBpQ4Zbq6j1lGj5GCVnYewYK54prsUs
        Pujs7trgIXS4yXmTLQYEvLlCxA==
X-Google-Smtp-Source: ACHHUZ4X/OpqVPk19E1DCCiWdHGNRkQt0u3V7KtqJ+q9fU+A2cl4jdN+svizZg1gRdZT1o5UxCWrMw==
X-Received: by 2002:a17:903:41ce:b0:1a6:a405:f714 with SMTP id u14-20020a17090341ce00b001a6a405f714mr17335462ple.63.1686788931935;
        Wed, 14 Jun 2023 17:28:51 -0700 (PDT)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id n9-20020a170902968900b001b3c7e5ed8csm2240602plp.74.2023.06.14.17.28.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Jun 2023 17:28:50 -0700 (PDT)
Subject: Re: [PATCH 05/12] dt-bindings: mtd: brcmnand: Updates for bcmbca SoCs
To:     Rob Herring <robh@kernel.org>
Cc:     Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Linux MTD List <linux-mtd@lists.infradead.org>,
        f.fainelli@gmail.com, rafal@milecki.pl, kursad.oney@broadcom.com,
        joel.peshkin@broadcom.com, computersforpeace@gmail.com,
        anand.gore@broadcom.com, dregan@mail.com, kamal.dasu@broadcom.com,
        tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Kamal Dasu <kdasu.kdev@gmail.com>
References: <20230606231252.94838-1-william.zhang@broadcom.com>
 <20230606231252.94838-6-william.zhang@broadcom.com>
 <20230614224338.GA2990941-robh@kernel.org>
From:   William Zhang <william.zhang@broadcom.com>
Message-ID: <78b0a8e7-63aa-c3a1-3798-fd66ae181ac9@broadcom.com>
Date:   Wed, 14 Jun 2023 17:28:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20230614224338.GA2990941-robh@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000001f560a05fe2027a4"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000001f560a05fe2027a4
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi Rob,

On 06/14/2023 03:43 PM, Rob Herring wrote:
> On Tue, Jun 06, 2023 at 04:12:45PM -0700, William Zhang wrote:
>> Use new compatiable brcm,nand-bcmbca to support BCMBCA broadband
>> product. The old compatible string is still kept in the driver so old
>> dtb can still work.
> 
> I don't understand why you need to change this.
> 
> 
Same as the iProc SoC NAND controller flavor for our BCMBCA SoC 
controller. And the existing binding is wrong. It shows 
brcm,nand-bcm63138 can be backward compatible to either v7.0 and v7.1 
controller. But in fact 63138 only use v7.0.

I understand we had discussion before and chip specific name is the 
preferred method but the nand controller here is different and it has 
well defined and documented version control and our bcmbca SoCs 
integrate the controller exactly the same way so no chip specific 
compatible is needed.  In the unlikely event that a future bcmbca SoC 
has a different implementation,  we can always add new chip specific 
compatible.

If you are concerned about ABI breakage on the 63138 compatible, I can 
add it back, although I  find only a few 63138 and 4908 boards use it 
and I did keep it in the driver so they can still bind.

>> Add brcm,nand-use-wp property to have an option for disabling this
>> feature on broadband board design that does not use write protection.
>> Add brcm,nand-ecc-use-strap to get ecc setting from board strap for
>> broadband board designs because they do not specify ecc setting in dts
>> but rather using the strap setting.
>>
>> Remove the requirement of interrupts and interrupt-names properties to
>> reflect the driver code.
>>
>> This patch also includes a few minor fixes to the BCM63xx compatibles
>> and add myself to the list of maintainers.
>>
>> Signed-off-by: William Zhang <william.zhang@broadcom.com>
>> ---
>>
>>   .../bindings/mtd/brcm,brcmnand.yaml           | 64 +++++++++++++------
>>   1 file changed, 43 insertions(+), 21 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
>> index 1571024aa119..1fe1c166a9db 100644
>> --- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
>> +++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
>> @@ -9,6 +9,7 @@ title: Broadcom STB NAND Controller
>>   maintainers:
>>     - Brian Norris <computersforpeace@gmail.com>
>>     - Kamal Dasu <kdasu.kdev@gmail.com>
>> +  - William Zhang <william.zhang@broadcom.com>
>>   
>>   description: |
>>     The Broadcom Set-Top Box NAND controller supports low-level access to raw NAND
>> @@ -18,9 +19,10 @@ description: |
>>     supports basic PROGRAM and READ functions, among other features.
>>   
>>     This controller was originally designed for STB SoCs (BCM7xxx) but is now
>> -  available on a variety of Broadcom SoCs, including some BCM3xxx, BCM63xx, and
>> -  iProc/Cygnus. Its history includes several similar (but not fully register
>> -  compatible) versions.
>> +  available on a variety of Broadcom SoCs, including some BCM3xxx, MIPS based
>> +  Broadband SoC (BCM63xx), ARM based Broadband SoC (BCMBCA) and iProc/Cygnus.
>> +  Its history includes several similar (but not fully register compatible)
>> +  versions.
>>   
>>     -- Additional SoC-specific NAND controller properties --
>>   
>> @@ -53,9 +55,9 @@ properties:
>>                 - brcm,brcmnand-v7.2
>>                 - brcm,brcmnand-v7.3
>>             - const: brcm,brcmnand
>> -      - description: BCM63138 SoC-specific NAND controller
>> +      - description: BCMBCA SoC-specific NAND controller
>>           items:
>> -          - const: brcm,nand-bcm63138
>> +          - const: brcm,nand-bcmbca
>>             - enum:
>>                 - brcm,brcmnand-v7.0
>>                 - brcm,brcmnand-v7.1
>> @@ -65,11 +67,15 @@ properties:
>>             - const: brcm,nand-iproc
>>             - const: brcm,brcmnand-v6.1
>>             - const: brcm,brcmnand
>> -      - description: BCM63168 SoC-specific NAND controller
>> +      - description: BCM63xx SoC-specific NAND controller
>>           items:
>> -          - const: brcm,nand-bcm63168
>> -          - const: brcm,nand-bcm6368
>> -          - const: brcm,brcmnand-v4.0
>> +          - enum:
>> +              - brcm,nand-bcm63168
>> +              - brcm,nand-bcm6368
>> +          - enum:
>> +              - brcm,brcmnand-v2.1
>> +              - brcm,brcmnand-v2.2
>> +              - brcm,brcmnand-v4.0
>>             - const: brcm,brcmnand
> 
> Completely changing what's valid here too. You're breaking the ABI.
> 
This binding is wrong, 63168 is not backward compatible to 6368. They 
should backward compatible to their specific controller version. If you 
looks arch/mips/boot/dts/brcm/bcm6328.dtsi, bcm6368.dtsi, bcm63268.dtsi 
and bcm6362.dtsi, their compatible list is correct but the yaml was not 
updated.

> Rob
> 

--0000000000001f560a05fe2027a4
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
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIFsvaRjBHwu2xe6voDr63SVQ+1fI
P44Pu5PDRYNJMYyVMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIz
MDYxNTAwMjg1MlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBw1feLnscxV2nJY6NhMBiBuuJZPk/BTOdRMWaiRpeRYXMt
dgUF76jed9QOD9qLttrtKybpQeJSOesIbaxPziovliIFoMbrwIwo0FIAeunM6g0G9jBceagL5Ah3
u1H3x2sSWvZuVUuBC5tZof8moGx1eFaFG1WrMzeDPDuW4uKWmqDxCkC1tIJdQq08gIN8lDuieimL
FBZypDpe27Gxw/UCZpl+XvwPG65c2B8WG3bnOx2C1Uy/iaMMO0LJIYoqx5HgcwdI32ZMveQX5udj
tocKWsMFhPgAophLszl9gEIQhnnww+AJklXUpNEjNJJdLVBMPk+iDSbSeaierLACfAE0
--0000000000001f560a05fe2027a4--
