Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41A3707112
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjEQSrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjEQSrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:47:33 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F8B83D8
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 11:47:30 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-61b71b7803bso5302436d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 11:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1684349249; x=1686941249;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yM3HomP4QdzCRzX4yCDGfto0EyLuxnhfRd0ISCm6CPQ=;
        b=b8J8gOE8GV0BvQiD2iQIizrBxs5IKf+FM6JRzErq/oRPeh24ZaLqCrvcG4SOg5byHi
         1Y5DuLOP8gIbIhEWVeqcxo+P1UFKBRxq3VeNAy799wI+GNiO756k/AuCKzicnrYiQ7q2
         mXKLoU+8xgtNZJ81/aSH6ErxrDvhBxHkRvVMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684349249; x=1686941249;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yM3HomP4QdzCRzX4yCDGfto0EyLuxnhfRd0ISCm6CPQ=;
        b=EnbNyjM1TNQD6i8qfV3Qm0GvwZYxH1/MGs8YZH3sTZa0fMLrtLWYgnlTzOjzeSlTI8
         UFq2NPOxxVqQ1yJFb94YwFbVGuKe+mTGE52jCRcbNnlksGfqwgetrHeq70Hp/lNFDay3
         /SzX1ROhQgQxNGYYwxJuXHU6ejqtBBcnwJq5TWmAG/6CKPDbkKjCHeKoFxZPCqrxv7wN
         sYxK4tJRUvCcZyYBVJgAg5LvPqxsO4NMuFaZJ2NjANZgLBhL6PuVbF/d/2SziTauA9Sv
         K4FyxDKNJtZHXVSKF9xnOz0stmfTKrlzEc4bTikWAw2UngDSfBse0SpUpS5pKUK+fOqu
         0AZw==
X-Gm-Message-State: AC+VfDwXBibBzcP0bxjLoM5CT8eu78rev2O8VH0xSNpuBCes+B+p3sIH
        F4/TL5gsZ8GYUSBqASbsVw/GNA==
X-Google-Smtp-Source: ACHHUZ7eU+bZSVMN2U5PT3hkFqFRW/65Wd2vwQIRetKxl912wnws8+Csd/FFpmDcpgzO+Ll9ANSyOw==
X-Received: by 2002:a05:6214:e44:b0:622:199c:c4dc with SMTP id o4-20020a0562140e4400b00622199cc4dcmr1175547qvc.51.1684349249218;
        Wed, 17 May 2023 11:47:29 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s13-20020a05622a018d00b003f018e18c35sm7233253qtw.27.2023.05.17.11.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 11:47:28 -0700 (PDT)
Message-ID: <edfcb7ff-b45b-db7b-9477-e838c558fa4a@broadcom.com>
Date:   Wed, 17 May 2023 11:47:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH net-next] net: phy: broadcom: Register dummy IRQ handler
To:     Andrew Lunn <andrew@lunn.ch>, Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     netdev@vger.kernel.org, Doug Berger <doug.berger@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <simon.horman@corigine.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230516225640.2858994-1-f.fainelli@gmail.com>
 <e6817987-f788-4567-8406-c257f3b81caf@lunn.ch>
From:   Florian Fainelli <florian.fainelli@broadcom.com>
In-Reply-To: <e6817987-f788-4567-8406-c257f3b81caf@lunn.ch>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000b2e78b05fbe81eb0"
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000b2e78b05fbe81eb0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

+tglx, Rafael,

On 5/17/23 05:32, Andrew Lunn wrote:
> On Tue, May 16, 2023 at 03:56:39PM -0700, Florian Fainelli wrote:
>> From: Florian Fainelli <florian.fainelli@broadcom.com>
>>
>> In order to have our interrupt descriptor fully setup, and in particular
>> the action, ensure that we register a full fledged interrupt handler.
>> This is in particular necessary for the kernel to properly manage early
>> wake-up scenarios and arm the wake-up interrupt, otherwise there would
>> be risks of missing the interrupt and leaving it in a state where it
>> would not be handled correctly at all, including for wake-up purposes.
> 
> Hi Florian
> 
> I've not seen any other driver do this. Maybe that is just my
> ignorance.

As a matter of fact I think this is how most, if not all drivers do it, 
they always have an interrupt service routine registered with the 
interrupt on which {disable,enable}_irq_wake() is called.

If you remember in my case we do not want to actually service the 
interrupt because as soon as we configure the PHY with a wake-up 
pattern, the PHY will assert the interrupt line, and if we configure an 
unicast/broadcast/multicast pattern we will be interrupted for every 
packet received in the network.

If we do not acknowledge the pattern match by doing a clear on read of 
the interrupt status register in the PHY, then obviously no new pattern 
matched events are generated. The interrupt is level low driven FWIW.

This was the reason why I went with this approach.

> 
> Please could you Cc: the interrupt and power management
> Maintainers. This seems like a generic problem, and should have a
> generic solution.

While I was working on this patch set initially, I had missed a call to 
irq_set_irq_type(.., IRQ_TYPE_LEVEL_LOW) and the interrupt was left in 
its default configuration of being falling edge triggered. The hardware 
interrupt generated by the PHY is level low driven. Since we are not 
using the interrupt for anything, it did not really matter that the flow 
handling would have been incorrect and it worked for the most part.

Except in one particular case which was when I entered an ACPI S5 / 
poweroff state, then woke-up the system using the Ethernet PHY, cold 
booted the kernel. The GPIO driver would have probed and acknowledged 
the interrupt because we want to report any GPIO-based wake-up from ACPI S5:

https://elixir.bootlin.com/linux/v6.4-rc1/source/drivers/gpio/gpio-brcmstb.c#L707

In that cold boot case the PHY driver would probe and acknowledge do the 
necessary clear on read and also charge the device for wake-up.

Later any attempt to wake-up from the PHY would not work however. This 
came down to the fact that in kernel/irq/pm.c::suspend_device_irq we had 
no action associated with the interrupt and therefore we would not be 
ensuring that the interrupt was marked as wake-up active within the 
interrupt controller provider driver (GPIO).

Maybe there is an opportunity for a patch here to issue a WARN_ON() when 
we find an interrupt we call {disable,enable}_irq_wake() against which 
does not have an action?

Anyway, I think that the registering a dummy handler is a more correct 
way that does not make assumptions about how the interrupt subsystem works.

> 
> In the setup which needs this, does the output from the PHY go to a
> PMIC, not a SoC interrupt? And i assume the PMIC is not interrupt
> capable?

The PHY is connected to an always-on GPIO controller which generates an 
interrupt output to an out of band interrupt controller that wakes-up 
the SoC.
-- 
Florian


--000000000000b2e78b05fbe81eb0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVgwggRAoAMCAQICDBP8P9hKRVySg3Qv5DANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMjE4MTFaFw0yNTA5MTAxMjE4MTFaMIGW
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEEZsb3JpYW4gRmFpbmVsbGkxLDAqBgkqhkiG
9w0BCQEWHWZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEA+oi3jMmHltY4LMUy8Up5+1zjd1iSgUBXhwCJLj1GJQF+GwP8InemBbk5rjlC
UwbQDeIlOfb8xGqHoQFGSW8p9V1XUw+cthISLkycex0AJ09ufePshLZygRLREU0H4ecNPMejxCte
KdtB4COST4uhBkUCo9BSy1gkl8DJ8j/BQ1KNUx6oYe0CntRag+EnHv9TM9BeXBBLfmMRnWNhvOSk
nSmRX0J3d9/G2A3FIC6WY2XnLW7eAZCQPa1Tz3n2B5BGOxwqhwKLGLNu2SRCPHwOdD6e0drURF7/
Vax85/EqkVnFNlfxtZhS0ugx5gn2pta7bTdBm1IG4TX+A3B1G57rVwIDAQABo4IB3jCCAdowDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAoBgNVHREEITAfgR1mbG9yaWFuLmZhaW5lbGxpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggr
BgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUUwwfJ6/F
KL0fRdVROal/Lp4lAF0wDQYJKoZIhvcNAQELBQADggEBAKBgfteDc1mChZjKBY4xAplC6uXGyBrZ
kNGap1mHJ+JngGzZCz+dDiHRQKGpXLxkHX0BvEDZLW6LGOJ83ImrW38YMOo3ZYnCYNHA9qDOakiw
2s1RH00JOkO5SkYdwCHj4DB9B7KEnLatJtD8MBorvt+QxTuSh4ze96Jz3kEIoHMvwGFkgObWblsc
3/YcLBmCgaWpZ3Ksev1vJPr5n8riG3/N4on8gO5qinmmr9Y7vGeuf5dmZrYMbnb+yCBalkUmZQwY
NxADYvcRBA0ySL6sZpj8BIIhWiXiuusuBmt2Mak2eEv0xDbovE6Z6hYyl/ZnRadbgK/ClgbY3w+O
AfUXEZ0xggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwT
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEICkggfAEdX0Y0iKJ
rDtelmhALXVJvD8Ms2/45DztJWLKMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTIzMDUxNzE4NDcyOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQD3lr60tbyTEsY/iZsuBA42ZXabyY0CuPVp
Flr6XiZcTK/hpqNu3m7eQtXfAIYOh89SItv3GrCMp8z9+jc5wST3MvU19u59v+M+ItokXJjegTEg
/cbpCRV6GtPedss7kfPqhCJSj567e99aOIQg+c66bSaf+MeCmqslA61HuUbWFchUjY1B2rZbkEdl
gdGFqqYK7wkgJaYGYSpgFMWwqcNj18ju/TmsDOO4Y07/VUE5NBVXle0pO5WQcrc7hi/DndqYkGK2
7Iit7J4OzqF8jFC9z2YVnCEQtZ5gz+h+Ajw4w2PSjh8o9P98EU9qGhM2EtKX3iURtmew8brXEtUK
xQ0/
--000000000000b2e78b05fbe81eb0--
