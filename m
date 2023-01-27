Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C13067DC35
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 03:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbjA0CSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 21:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjA0CSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 21:18:04 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD4B37577
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 18:18:01 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id 5so3653082plo.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 18:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=lMVAZlW0IYTlsO+hearMStOBvXO+3eEDK56o4sM6Xsc=;
        b=gs7kq1T2SwEnqkawHRKqRL72rrTza9PXtB4nUHO6zDd+gmcPYj+GTGBqSSvCFDO5hh
         yrYr8yLw1jACZpBm4sqYGzSrEJlmnJYV+waUtLvLreZriR7VR1AJ8Xt85GW3CdboyXyS
         bYNxmiX5NluomONHFja4NA5VO1Oixd0xaP77c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lMVAZlW0IYTlsO+hearMStOBvXO+3eEDK56o4sM6Xsc=;
        b=5ogPJHXa7aPQtvY5PFZ8YHPPo4B/U6kor2NvqdWTKEv+wUbkfu4sqC6rsU5bzPeelY
         2k6sFVCJi5ETkFj43iC/byG+16rZvYI/gt+YMMNIcTtzJgrRT6+VQo9kAKkiiYSEMFYE
         FDtGHoLUbENNUEJCarMA2FwZPOrwBAzgo9sEwnY2VYPKteRbueQNp7wAKCEBMkwvIxSh
         FJgHSCpcxMIKBWYgtBVwA1n1DQZayOunEtJQrF1FKzdg/0qoJWYC8FgLIRZh2u4BpeLi
         6QCJtRSpbgS5crd9ZezTTMgsldoCRWaayZjBTTyLat1J0pwVuQmJSngwPUyGFXr33eYQ
         HvNw==
X-Gm-Message-State: AFqh2kqZhL7Yd2bS06fUQk0L1Sl00RWCqa6k1RDsbDuRt3lQpiXgvitK
        MIC1CqB/6FjrFocZqdB945wlOpp45l575eCxyFmamAce1jeBEtPZKYl7EEZR6Q5palYynlFr1l6
        z0g5hv1ajYBDBU9QNPqMWMZZPTi28aB3a8EzR6n1d9eiS/u1Cue1CauQi06u0OA/gMB7ydBUgTZ
        SsefRdXrcchOw=
X-Google-Smtp-Source: AMrXdXseNqAgP9wCNRzhf2QziSFajnJYJ+k9DdTvEhhfSPPyez1pwdhk8QQorkFeNd/PCThepPLPOA==
X-Received: by 2002:a17:902:b48f:b0:189:b4d0:aee with SMTP id y15-20020a170902b48f00b00189b4d00aeemr34267897plr.67.1674785880869;
        Thu, 26 Jan 2023 18:18:00 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id n12-20020a1709026a8c00b0019603cb63d4sm1599027plk.280.2023.01.26.18.17.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jan 2023 18:18:00 -0800 (PST)
Subject: Re: [PATCH v2 13/14] spi: bcmbca-hsspi: Add driver for newer HSSPI
 controller
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        tomer.yacoby@broadcom.com, kursad.oney@broadcom.com,
        dregan@mail.com, f.fainelli@gmail.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        kernel test robot <lkp@intel.com>,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230124221218.341511-1-william.zhang@broadcom.com>
 <20230124221218.341511-14-william.zhang@broadcom.com>
 <CAOiHx=mgEGe5_sn++QcPkX14+DzTw7cthabsyJaJZYQVsjLhsw@mail.gmail.com>
From:   William Zhang <william.zhang@broadcom.com>
Message-ID: <2f4c0e38-af4a-8b01-8327-b6d6b666780c@broadcom.com>
Date:   Thu, 26 Jan 2023 18:17:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAOiHx=mgEGe5_sn++QcPkX14+DzTw7cthabsyJaJZYQVsjLhsw@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000008813fd05f3357953"
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000008813fd05f3357953
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 01/26/2023 07:16 AM, Jonas Gorski wrote:
>> +static void bcmbca_hsspi_set_cs(struct bcmbca_hsspi *bs, unsigned int cs,
>> +                                bool active)
>> +{
>> +       u32 reg;
>> +
>> +       /* No cs orerriden needed for SS7 internal cs on pcm based voice dev */
>> +       if (cs == 7)
>> +               return;
>> +
>> +       mutex_lock(&bs->bus_mutex);
>> +
>> +       if (active) {
>> +               /* activate cs by setting the override bit and active value bit*/
>> +               reg = __raw_readl(bs->spim_ctrl);
>> +               reg |= BIT(cs+SPIM_CTRL_CS_OVERRIDE_SEL_SHIFT);
> 
> Doesn't checkpatch complain about missing spaces around the operator (+)?
> 
Nope...

>> +               reg &= ~BIT(cs+SPIM_CTRL_CS_OVERRIDE_VAL_SHIFT);
>> +               if (bs->cs_polarity & BIT(cs))
>> +                       reg |= BIT(cs+SPIM_CTRL_CS_OVERRIDE_VAL_SHIFT);
> 
> Does the CS_OVERRIDE_VAL get reset on clearing the OVERRIDE_SEL bit or
> it is persistent? If the latter, you could initialize its value in
> bcmbca_hsspi_setup() and then this becomes:
> 
> reg = _raw_readl(bs->spim_ctrl);
> if (active)
>     reg |= BIT(cs+SPIM_CTRL_CS_OVERRIDE_SEL_SHIFT);
> else
>     reg &= ~BIT(cs + SPIM_CTRL_CS_OVERRIDE_SEL_SHIFT);
>   __raw_writel(reg, bs->spim_ctrl);
> 
> and you can drop the cs_polarity field.
> 
> 
No. So I will try this optimization and see if that actually works in 
the controller.

>> +               __raw_writel(reg, bs->spim_ctrl);
>> +       } else {
>> +               /* clear the cs override bit */
>> +               reg = __raw_readl(bs->spim_ctrl);
>> +               reg &= ~BIT(cs+SPIM_CTRL_CS_OVERRIDE_SEL_SHIFT);
>> +               __raw_writel(reg, bs->spim_ctrl);
>> +       }
>> +
>> +       mutex_unlock(&bs->bus_mutex);
>> +}
>> +

--0000000000008813fd05f3357953
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
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJqezjFJqwBwb/5FLvs0oxh6G86l
/eGHqE9SrdAxE/jnMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIz
MDEyNzAyMTgwMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQDFr38u9wSy01cbxAuPvfm0Z1SENPDYlnrshrHFaS8/h1c5
Lic+tyVu9+moY096G2jTQwmerq9jraOqCDnuLkyHp+hQr7Jp/7BFIU2Qfd7aDNlL4svlkrBtv2l/
imrHT9/ARBEQtnU+CO5JEARdnjbTjtEch+5Uu2dI5BsjPar3fOT0W6simurBBr7MhBIQI0lQrbQZ
cGm6QKluRp2dR7OuqH9LOHJPrFPK2swbsQ3X7Xw762NuI5Mz66O3CJvuWr5Wkwek5WegChz57DKd
xEu/ViaUa6cq2tWEjdI+MBBNHVCkZD0QzjoVvY8qdaf5d5j6O/yFZTDz8ww0gP5+BOWN
--0000000000008813fd05f3357953--
