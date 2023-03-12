Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C496B63B0
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 08:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjCLHbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 03:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjCLHbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 03:31:50 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC0758C05
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 23:31:49 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id s12so10233824qtq.11
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 23:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1678606308;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=4dS1lLmn7d6CrZjwyVYWK3YGHrlop5B1SpTiK36P6ic=;
        b=Hwjdej83Myyq18v4uoPpz7sB3EFe8GeC8gRSliPLRKkr++wSnW8dn4AmvllS9mRInG
         XpyhSTXNrwnSAJEEoeiTIX/0bB1cqyCrBgAd/73K4XN3sgsH+/bcoygugxzLs821x5hv
         4mssPgOkOAnwKFRhKvvcF8w95OtZSXVx1cFLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678606308;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4dS1lLmn7d6CrZjwyVYWK3YGHrlop5B1SpTiK36P6ic=;
        b=xQr4572ssup1GPBaUOXITrRTv3mnsv2Y8iCQXfqBhqsQmY5hJJM9VRKKkMNiRdJsSn
         sIO1e3vP5WfWCvWO7J7df43JSDSSFslHhhKpYfByb0mqMs3hgW6kfmA9k3OuGBl/o5nP
         zE49hBV47dIN1TEvjJCccIjFO/T2ZpWubHxLSFyXhM6HseFbR+36sRZAsl75GZNfVtEb
         t4/PmVl/TF0lwxv+E6M2fu5O9w67YQJC7VOpsPUn+rG6M0LgIq182JqBrzttZVA+JWRZ
         Jfu7OOS/7ZokR8bu5CzbtePpP40IsnAJnftRmxW4PdAAl6P323NTzn8mZRpsE7ASDwhP
         ojJg==
X-Gm-Message-State: AO0yUKUl1jgajUxFE/7bsgkbOGiPs4LJOIPkHWawYFG9165Jr4hn0QEr
        30oCYbgwfZRzzrMYND/ZFZhVa/THBmun8YzQUpeQMGtr2HRWre41qCi4GbN+Upn3nnr+6g/77Ga
        iJgNhA9RTpJPnAON91/tlmpeIifH7FywPW7AuEIluWVIa2iy/wvqw8LfDI5jJh+T3Znh4bFJtGp
        HXLvGiQY5KsPfNKQ==
X-Google-Smtp-Source: AK7set93ynytw5BXAg7ROxRt2gmuA5kBMj+h2OgFkIQSCLGSDPimdu0vqYrijN8ZWU/L3eHbaRb29A==
X-Received: by 2002:ac8:7d86:0:b0:3bf:be7d:b3e5 with SMTP id c6-20020ac87d86000000b003bfbe7db3e5mr54748159qtd.41.1678606307839;
        Sat, 11 Mar 2023 23:31:47 -0800 (PST)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id s138-20020a374590000000b007436d0e9408sm3084168qka.127.2023.03.11.23.31.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Mar 2023 23:31:47 -0800 (PST)
Subject: Re: [PATCH] mips: bmips: BCM6358: disable arch_sync_dma_for_cpu_all()
To:     Jonas Gorski <jonas.gorski@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, tsbogend@alpha.franken.de,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230310121306.4632-1-noltari@gmail.com>
 <da5d150e-a2db-573d-e231-b4fd9fdaf63b@gmail.com>
 <CAOiHx=njCvfVju9BAe7gTzMq0vybQF-gy4SRZrhEJFULGLhC7w@mail.gmail.com>
From:   William Zhang <william.zhang@broadcom.com>
Message-ID: <5b4d3eef-ff80-29e8-9be0-d487aee5e4e2@broadcom.com>
Date:   Sat, 11 Mar 2023 23:31:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAOiHx=njCvfVju9BAe7gTzMq0vybQF-gy4SRZrhEJFULGLhC7w@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000b95c1b05f6aefc22"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000b95c1b05f6aefc22
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit



On 03/11/2023 11:44 AM, Jonas Gorski wrote:
> On Sat, 11 Mar 2023 at 18:32, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>>
>>
>> On 3/10/2023 4:13 AM, Álvaro Fernández Rojas wrote:
>>> arch_sync_dma_for_cpu_all() causes kernel panics on BCM6358 with EHCI/OHCI:
>>> [    3.881739] usb 1-1: new high-speed USB device number 2 using ehci-platform
>>> [    3.895011] Reserved instruction in kernel code[#1]:
>>> [    3.900113] CPU: 0 PID: 1 Comm: init Not tainted 5.10.16 #0
>>> [    3.905829] $ 0   : 00000000 10008700 00000000 77d94060
>>> [    3.911238] $ 4   : 7fd1f088 00000000 81431cac 81431ca0
>>> [    3.916641] $ 8   : 00000000 ffffefff 8075cd34 00000000
>>> [    3.922043] $12   : 806f8d40 f3e812b7 00000000 000d9aaa
>>> [    3.927446] $16   : 7fd1f068 7fd1f080 7ff559b8 81428470
>>> [    3.932848] $20   : 00000000 00000000 55590000 77d70000
>>> [    3.938251] $24   : 00000018 00000010
>>> [    3.943655] $28   : 81430000 81431e60 81431f28 800157fc
>>> [    3.949058] Hi    : 00000000
>>> [    3.952013] Lo    : 00000000
>>> [    3.955019] epc   : 80015808 setup_sigcontext+0x54/0x24c
>>> [    3.960464] ra    : 800157fc setup_sigcontext+0x48/0x24c
>>> [    3.965913] Status: 10008703       KERNEL EXL IE
>>> [    3.970216] Cause : 00800028 (ExcCode 0a)
>>> [    3.974340] PrId  : 0002a010 (Broadcom BMIPS4350)
>>> [    3.979170] Modules linked in: ohci_platform ohci_hcd fsl_mph_dr_of ehci_platform ehci_fsl ehci_hcd gpio_button_hotplug usbcore nls_base usb_common
>>> [    3.992907] Process init (pid: 1, threadinfo=(ptrval), task=(ptrval), tls=77e22ec8)
>>> [    4.000776] Stack : 81431ef4 7fd1f080 81431f28 81428470 7fd1f068 81431edc 7ff559b8 81428470
>>> [    4.009467]         81431f28 7fd1f080 55590000 77d70000 77d5498c 80015c70 806f0000 8063ae74
>>> [    4.018149]         08100002 81431f28 0000000a 08100002 81431f28 0000000a 77d6b418 00000003
>>> [    4.026831]         ffffffff 80016414 80080734 81431ecc 81431ecc 00000001 00000000 04000000
>>> [    4.035512]         77d54874 00000000 00000000 00000000 00000000 00000012 00000002 00000000
>>> [    4.044196]         ...
>>> [    4.046706] Call Trace:
>>> [    4.049238] [<80015808>] setup_sigcontext+0x54/0x24c
>>> [    4.054356] [<80015c70>] setup_frame+0xdc/0x124
>>> [    4.059015] [<80016414>] do_notify_resume+0x1dc/0x288
>>> [    4.064207] [<80011b50>] work_notifysig+0x10/0x18
>>> [    4.069036]
>>> [    4.070538] Code: 8fc300b4  00001025  26240008 <ac820000> ac830004  3c048063  0c0228aa  24846a00  26240010
>>> [    4.080686]
>>> [    4.082517] ---[ end trace 22a8edb41f5f983b ]---
>>> [    4.087374] Kernel panic - not syncing: Fatal exception
>>> [    4.092753] Rebooting in 1 seconds..
>>
>> Did you pinpoint which specific instruction within
>> arch_sync_dma_for_cpu_all() is causing the reserved instruction exception?
> 
> It's setup_sigcontext(), not arch_sync_dma_for_cpu_all() that's
> causing the exception ;-)
> 
> Hand decoding the Code gives me
> 
> lw $1, 0xb4($fp)
> or $v0, 0, 0
> addiu $a0, $s1, 8
> sw $v0, 0($a0) <- the code in brackets, so I guess EPC?
> sw $v1, 4($a0)
> 
> which I assume is this part:
> 
> err |= __put_user(regs->cp0_epc, &sc->sc_pc);
> 
> (0xb4 is the offset of cp0_epc, 0x8 the offset of sc_pc)
> 
> One thing I see is that we do the RAC flush for BMIPS3300, 4350 and
> 4380, but only initialize it for 3300 [1], but leave it at whatever
> state the bootloader did for the other ones. Maybe it has some invalid
> config in (that particuar?) 6358 that triggers issues later on after a
> flush? E.g. the flush puts it in an error state, and the next time
> something triggers a prefetch(write?) (by trying to access userspace)
> it generates an error exception.
> 
Depending on the bootloader but likely bootloader does not use RAC at 
all.  So agree that RAC may not be properly initialized when the flush 
function is called and push the stale data to corrupt memory and cause 
problem later on the userspace.

> Just spit balling though.
> 
> [1] https://elixir.bootlin.com/linux/latest/source/arch/mips/kernel/smp-bmips.c#L587
> 
> Jonas
> 

--000000000000b95c1b05f6aefc22
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
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPWmZv9/A8A6pMnj3htXnb+9X38X
UCJjZ/nvChzMo+x8MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIz
MDMxMjA3MzE0OFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQCIsQ4ow6No7gbtC9pDdwfeu1mL/V61uhKfdexM4mbglqCm
kHeXG9KerMinuKdPt8WuwkPvrHmpa6Yil+U4W7NhGXXJPBcuVmEgb5E1jemKjYYoH4vsn69kYyVL
m8VMIgJZNHmcBGoGLOwob3WzpOQMUZzedPj6+WRAVxySx/MphLH0Cxw/fEq8eFmqXmOHQud0JOPq
3Ycba5WmX8VwiN9N96XbEMYrKKtfjfp53i5apVoEYAT6H2RX74K4KcsfPpxLWA370A4NlQDDVx7W
10G0WMU5SvQ++5ilDLK8ZBEi0UVQ2p5Thn13iTRe2Chi6qN3IZ6pipaIViOebieamG1P
--000000000000b95c1b05f6aefc22--
