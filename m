Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C836BF6E9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 01:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCRAYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 20:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCRAYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 20:24:35 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6276E7EE1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 17:24:16 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so10921721pjg.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 17:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1679099056;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :to:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=aCIvgHkvum9lOFK8nJz2kt/7YAWyk9CjGByJA1h8nvA=;
        b=Vw/dtAsfzHkazE4M5XxCQ22Wva9fDs5xWKdXGO3tG8rNPO9xF3Ox54WfGRDfgLwewU
         PbB9f8cmtcUOMDEGEPyw3IkyIhWJ1he9Vbsd3Tv0nGLcBlEbgOYL4IjvZvJMTxoQUZ70
         VZUuBXTewA8xkQlIP82VSPqT0RrUr6i4O90Uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679099056;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :to:subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aCIvgHkvum9lOFK8nJz2kt/7YAWyk9CjGByJA1h8nvA=;
        b=m96FQ4ZxOO9OYbWl5RN6MQTj75afbpSO2aoJCaqleymImsABcb5ixi0AJeTnNuDtKP
         gqt/2s+nt7Gjk6/uTDVXHsihOt0EGiUYI/HRvmhq4Q5zZu+Jng+QKkHqFIpHKQ23rs92
         +mZ17yVB5s6FIN+TDrLJ/S6w3Q0TXbctrnNlKiEryK3zZgt5nauX73PuiZxwZvThGn5J
         RiB8lXZAguZh4Z6UXyNFinR+/slAHtDOkQWBL8JJAT9B5uPnXukyfQ8hwN7N0ORTcthe
         hig5xUoEz3Nam7aVS3ysm2MvluCCVGaK2cAWO7n5r+T+MQdv+QyNcTMwAm9I0kfwNT9R
         CDHA==
X-Gm-Message-State: AO0yUKULz5XiZMt8dNPUkwx+MIDOKlS9dQUj5cJUUctDpHJazWdLvdJY
        mGFe2e8zKRHsGjD1oFrdcflDNw==
X-Google-Smtp-Source: AK7set8dlsjaQzpr/5Hj9uU+qkR+aoGvfj9SZirH/xj53h2ft2+47WXR1i8jQNH2GwBbVy+ckyr/gA==
X-Received: by 2002:a05:6a20:548f:b0:d5:10ca:5264 with SMTP id i15-20020a056a20548f00b000d510ca5264mr11242046pzk.59.1679099055933;
        Fri, 17 Mar 2023 17:24:15 -0700 (PDT)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id c25-20020aa78c19000000b00623f72df4e2sm2062157pfd.203.2023.03.17.17.24.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Mar 2023 17:24:15 -0700 (PDT)
Subject: Re: Probing devices by their less-specific "compatible" bindings
 (here: brcmnand)
To:     Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>
References: <399d2f43-5cad-6c51-fe3a-623950e2151a@gmail.com>
 <0bbaa346-edbf-a1b9-3c95-5a1aacaf0c44@gmail.com>
From:   William Zhang <william.zhang@broadcom.com>
Message-ID: <f9f3ab71-a3b3-2582-b841-8e8783d81817@broadcom.com>
Date:   Fri, 17 Mar 2023 17:24:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <0bbaa346-edbf-a1b9-3c95-5a1aacaf0c44@gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000ce02c505f721b68a"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000ce02c505f721b68a
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit



On 03/17/2023 02:54 PM, Florian Fainelli wrote:
> +William,
> 
> On 3/17/23 03:02, Rafał Miłecki wrote:
>> Hi, I just spent few hours debugging hidden hw lockup and I need to
>> consult driver core code behaviour.
>>
>> I have a BCM4908 SoC based board with a NAND controller on it.
>>
>>
>> ### Hardware binding
>>
>> Hardware details:
>> arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
>>
>> Relevant part:
>> nand-controller@1800 {
>>      compatible = "brcm,nand-bcm63138", "brcm,brcmnand-v7.1", 
>> "brcm,brcmnand";
>>      reg = <0x1800 0x600>, <0x2000 0x10>;
>>      reg-names = "nand", "nand-int-base";
>> }:
>>
>> Above binding is based on the documentation:
>> Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
>>
>>
>> ### Linux drivers
>>
>> Linux has separated drivers for few Broadcom's NAND controller bindings:
>>
>> 1. drivers/mtd/nand/raw/brcmnand/bcm63138_nand.c for:
>> brcm,nand-bcm63138
>>
>> 2. drivers/mtd/nand/raw/brcmnand/brcmnand.c for:
>> brcm,brcmnand-v2.1
>> brcm,brcmnand-v2.2
>> brcm,brcmnand-v4.0
>> brcm,brcmnand-v5.0
>> brcm,brcmnand-v6.0
>> brcm,brcmnand-v6.1
>> brcm,brcmnand-v6.2
>> brcm,brcmnand-v7.0
>> brcm,brcmnand-v7.1
>> brcm,brcmnand-v7.2
>> brcm,brcmnand-v7.3
>>
>> 3. drivers/mtd/nand/raw/brcmnand/brcmstb_nand.c for:
>> brcm,brcmnand
>>
>>
>> ### Problem
>>
>> As first Linux probes my hardware using the "brcm,nand-bcm63138"
>> compatibility string driver bcm63138_nand.c. That's good.
>>
>> It that fails however (.probe() returns an error) then Linux core starts
>> probing using drivers for less specific bindings.
> 
> Why does it fail?
> 
Same question here.  I just tried latest linux master code on my 4908 
reference board and the Micron NAND on my board works fine. Can you post 
the log from the brcmnand driver?

>>
>> In my case probing with the "brcm,brcmnand" string driver brcmstb_nand.c
>> results in ignoring SoC specific bits and causes a hardware lockup. Hw
>> isn't initialized properly and writel_relaxed(0x00000009, base + 0x04)
>> just make it hang.
> 
> Well, the missing piece here is that brcmnand.c is a library driver, 
> therefore it needs an entry point, the next one that matches is 
> brcmstb_nand.c.
> 
>>
>> That obviously isn't an acceptable behavior for me. So I'm wondering
>> what's going on wrong here.
>>
>> Should Linux avoid probing with less-specific compatible strings?
>> Or should I not claim hw to be "brcm,brcmnand" compatible if it REQUIRES
>> SoC-specific handling?
>>
>> An extra note: that fallback probing happens even with .probe()
>> returning -EPROBE_DEFER. This actually smells fishy for me on the Linux
>> core part.
>> I'm not an expect but I think core should wait for actual error without
>> trying less-specific compatible strings & drivers.
>>
Are you saying the bcm63138_nand.c probe function return -EPROBE_DEFER 
and late on kernel call brcmstb_nand.c probe instead of bcm63138_nand's 
probe again?

>> ______________________________________________________
>> Linux MTD discussion mailing list
>> http://lists.infradead.org/mailman/listinfo/linux-mtd/
> 

--000000000000ce02c505f721b68a
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
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEICZQnE7WsWkosKCoNpZ86hEYk9rc
SRDo75/9138OblfYMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIz
MDMxODAwMjQxNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQB/mVBQHDcmynUhvUPoy8jTUwI7uWAr7ZXwBF38ePKOc9Cb
kW5WnAE/5o/lbdTCcywSOL6WX/nukP1I7ZrluLwzqBfhT4y4OjbfzdfBlDYY5ynUYxSnM4EJ2lG5
aCgk6pBdqu0atd6C4vNHC0mhEuome+nDVknjkZ48eUHYh69My00LKIFYekerODDUAzMUHnUf1kAR
1wVw37uiO2fZjORDJ39oouauXChd4yQ0yWG/L3j/FlO17uLrJ/Iq4RvPjm3/bjCWGIN56tLsNQpK
V2oEPDBleboe6hHP2HtefIChKiq/Ae5nH4W33W5j55m6HtHdFdhfPkhZM9f+nukiWJ3J
--000000000000ce02c505f721b68a--
