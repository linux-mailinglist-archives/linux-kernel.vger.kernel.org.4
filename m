Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAAC165CF8F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbjADJct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjADJcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:32:42 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E2C65F7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 01:32:41 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id m18so80993775eji.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 01:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G9IFPVPD91CbXr//GO4x/j6l4y7nm19b+LUxOYJ6k+0=;
        b=abfjg6q8AUSpEqzVPrEVSsvOhQmbEpOMV1euV5Uf1ACDsoCygaypB9njeKKJbFwmTO
         hTSO3Pyutu1PIGJpCBaEIs4EwuOMMCpyp8igfztYNw5ZMUzVZ+5s1Ums8i848DihCFy3
         J+4AW/qBf4+5G7E+JijIlUw1Y/fk1BzRMKdFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G9IFPVPD91CbXr//GO4x/j6l4y7nm19b+LUxOYJ6k+0=;
        b=33gCQRNz4olfyCHdfR5I1QjY5UghCIf4j0gSNr+QxVEGp3cbZ66e7Q3mp7s0jSiHW3
         u536LH82u/Kf3Hbw8ddLwxCrDaxO80xuDn4SK8HtKgJMSFQAjwusEQM/pdlQ+G5vQ9Mi
         ZMxaJPzAErSsUXrwACgQM3BSgcLHeQOmirzqfxuA3LR2K+W/ekqlcCrVzHcM2ILAV5tB
         a+0UYFFK18VMQAdNMGIL89q/4e0PyD4yi14OIYaCV1JA07RoYsHdgt/9S6uIFEtjBEh0
         d09UkgRf9fbEinv9YE0tXIW/Mj/1TUr7E9MLNiY8GDQFcEvz3oNiUh2/4yrXG1SuDLKf
         9haQ==
X-Gm-Message-State: AFqh2kpn3UMPV3EQxgvmEqmd0Sm6cj8eIJGcah6p46YFDeK1tcXjXTHA
        ZGZiflyyOjVhdw+7XBE9jDrZCw==
X-Google-Smtp-Source: AMrXdXtxhFnRA3NF/aw4uJjfwhQY0FgQ4qJT5QmjPqPIYGGoPmusQEOeXQvSaRIj0TaT5JQl1QBNpg==
X-Received: by 2002:a17:906:6d8:b0:844:79b1:ab36 with SMTP id v24-20020a17090606d800b0084479b1ab36mr40859169ejb.25.1672824759583;
        Wed, 04 Jan 2023 01:32:39 -0800 (PST)
Received: from [192.168.178.136] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709063d2900b0084cc121f49esm4047808ejf.83.2023.01.04.01.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 01:32:38 -0800 (PST)
Message-ID: <789c15e4-545c-21f9-70fa-517788df55d1@broadcom.com>
Date:   Wed, 4 Jan 2023 10:32:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] brcmfmac: Use separate struct to declare firmware
 names for Apple OTP chips
To:     Hector Martin <marcan@marcan.st>,
        Aditya Garg <gargaditya08@live.com>, aspriel@gmail.com,
        hante.meuleman@broadcom.com, kvalo@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        lina@asahilina.net, franky.lin@broadcom.com
Cc:     Orlando Chamberlain <redecorating@protonmail.com>,
        brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list.pdl@broadcom.com,
        linux-wireless@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Asahi Linux <asahi@lists.linux.dev>
References: <F8829A7C-909E-4A1F-A22C-668220C5C06D@live.com>
 <f36dd8e3-9905-f04a-ed34-4be91ed1fec6@marcan.st>
 <F9EFCCD1-4407-42CC-8316-2F58AAC1AE7F@live.com>
 <ACC0D1F6-7857-4FF0-A474-4EC699572E1B@live.com>
 <9c5bdb0a-0877-ed16-f09f-164a9dab16d4@marcan.st>
 <18573bd1a38.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <3785835b-164b-28d1-6905-85454cabb69d@marcan.st>
 <6b30559d-9bcc-f3b3-d9b2-2406e9a044b7@broadcom.com>
 <3659477c-c822-c5d6-868c-ba40c5a80be6@marcan.st>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <3659477c-c822-c5d6-868c-ba40c5a80be6@marcan.st>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000095840705f16cdd55"
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000095840705f16cdd55
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/3/2023 2:46 PM, Hector Martin wrote:
> On 03/01/2023 22.30, Arend van Spriel wrote:
>> On 1/3/2023 4:55 AM, Hector Martin wrote:
>>> On 2023/01/03 3:27, Arend Van Spriel wrote:
>>>> On January 2, 2023 4:15:41 PM Hector Martin <marcan@marcan.st> wrote:
>>>>
>>>>> On 02/01/2023 23.40, Aditya Garg wrote:
>>>>>> From: Aditya Garg <gargaditya08@live.com>
>>>>>>
>>>>>> Commit 'dce45ded7619' added support for 89459 chip pcie device. It uses the
>>>>>> BRCM4355 chip which is also found in Apple hardware. However this commit
>>>>>> causes conflicts in the firmware naming between Apple hardware, which
>>>>>> supports OTP and other non-Apple hardwares. So, this patch makes these
>>>>>> Apple chips use their own firmware table so as to avoid possible conflicts
>>>>>> like these in the future.
>>>>>
>>>>> I think my reply to Arend flew over your head.
>>>>>
>>>>> My point was that I'd rather have the Broadcom/Cypress people actually
>>>>> answer my question so we can figure out how to do this *properly*,
>>>>> instead of doing "safer-but-dumb" things (like this patch) because we
>>>>> just don't have the information to do it properly.
>>>>
>>>> Fair enough. Can you accurately (re)state your question and I will try to
>>>> answer it.
>>>
>>> As per my original email: Is the CYW89459 just a rebrand of the BCM4355,
>>> or just a subset? Can we consider them equivalent, and equivalent to the
>>> Apple part (BCM4355C1 / revision 12)?
>>
>> There is probably no easy answer. Mainly because Cypress is a separate
>> entity. However, they use the same/similar technology and code base. So
>> let me first start with the chip naming. The wifi chip primarily has a
>> number and revision. The chip number is straighforward and can be read
>> from the device. The chip revision comes in two variants: 1) simple
>> increasing number as read from the device, and 2) a <letter><digit>
>> format. The latter start at a0, which you almost never see in the wild
>> unless we do it "first time right". Whenever spinning a new chip we
>> either increase the digit or the letter depending on type/amount of
>> changes. There is not predictable mapping between the revision variants.
>> Depending on the hurdles in a chip project we may move from a0 to b0, or
>> from b0 to b1 or whatever.
> 
> Right, this is standard chip spin numbering, that much I know.
> 
>> If CYW89459 chip reads chip number 0x4355 than it is a BCM4355. If it is
>> a different revision it may require different firmware. A different
>> letter will always require different firmware. A different digit may
>> work although the firmware can have code paths for a specific revision.
> 
> So is it always correct to have the same firmware (in a generic
> situation, not a customized OEM build) for, say, a BCM4355 rev 12,
> regardless of what the PCI ID programmed into the OTP is (and what the
> marketing device name is)?

Yes.

> If so, then my conclusion is that the original patch I replied to is
> incorrect, all the defines should've been called BCM4355 (not the
> Cypress part number), and we probably need two firmware table entries
> since (judging by the revision check elsewhere in that patch) there are
> other revisions in the wild than the one Apple uses, and therefore there
> should at the very least be a firmware name split at C1. It would then
> be very helpful to know what revisions *do* exist and their correct naming.

I can only track down what we have in Broadcom. For the 4355 the 
revisions B1 (=6), B3 (=8), C0 (=10) and C1 are mentioned as released. 
Here things get weird, because you mentioned BCM4355 rev12, which would 
be a C2. So without asking around I can only assume this C2 variant is 
not different from firmware perspective and can happily run the C1 firmware.

> If different PCI device IDs might need different firmware, then the
> exiting firmware selection/table mechanism is insufficient.
> 
>> Happy New year to you. Thanks for clearly marking the rant. Makes it
>> easier to ignore, but let me get into this. I would not call bcmdhd the
>> downstream driver. It is a separate out-of-tree driver. Indeed resources
>> were pulled from brcm80211 development, but there always have been only
>> 2 or 3 people working on it. Me being the constant working mule and
>> these days only for 20% of my working hours to do the job. So you are
>> not really doing our job as we are not assigned to do so. I guess there
>> is no ROI for Broadcom or so it is perceived and there is no customer
>> pushing for it. That said I am always happy to help and clarify whatever
>> I can.
> 
> Is there any chance you can provide a list of chips/shipping revisions
> and revision IDs, so we can stop guessing at the mappings in the
> firmware table? Because this is effectively breaking userspace ABI every
> time we make a change to an existing chip, as it can change the firmware
> file name that userspace loads. This already happened with BCM4364,
> where (at least) B2 and B3 revisions exist in the wild and we need
> separate firmwares, yet it was added with a full mask, resulting in
> people copying "the right firmware for them" manually and my patch to
> split it into properly named firmwares will break those users.

Userspace is not loading anything these days. AFAIK the kernel is 
directly accessing the firmware file. Anyway, I never considered this as 
being a big issue. If people change their installed os to get things 
working, they can expect the reverse can happen anytime and deal with it 
once more. If this is considered a real issue we should only set the 
revmask for the revision we know to be working.

Regards,
Arend

--00000000000095840705f16cdd55
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
2Gzj3QNJRLsZu1TLyOyBBIr/BE7UiY3RabgRzknBGAPmzhS+fmyM8OtM5BYBsFBrSUFtZZO2p/tf
Nbc24J2zf2peoZ8MK+7WQqummYlOnz+FyDkA9EybeNMcS5C+xi/PAgMBAAGjggHdMIIB2TAOBgNV
HQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYI
KwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqG
OGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3Js
MCcGA1UdEQQgMB6BHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYB
BQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFIikAXd8CEtv
ZbDflDRnf3tuStPuMA0GCSqGSIb3DQEBCwUAA4IBAQCdS5XCYx6k2GGZui9DlFsFm75khkqAU7rT
zBX04sJU1+B1wtgmWTVIzW7ugdtDZ4gzaV0S9xRhpDErjJaltxPbCylb1DEsLj+AIvBR34caW6ZG
sQk444t0HPb29HnWYj+OllIGMbdJWr0/P95ZrKk2bP24ub3ZP/8SyzrohfIba9WZKMq6g2nTLZE3
BtkeSGJx/8dy0h8YmRn+adOrxKXHxhSL8BNn8wsmIZyYWe6fRcBtO3Ks2DOLyHCdkoFlN8x9VUQF
N2ulEgqCbRKkx+qNirW86eF138lr1gRxzclu/38ko//MmkAYR/+hP3WnBll7zbpIt0jc9wyFkSqH
p8a1MYICbTCCAmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1z
YTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMTv1t
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAQ5Y9jK+FF4z39S5uf
g2vGk6XXS2VKy2qKZpn1x1W4yTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMzAxMDQwOTMyMzlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEALTWAttLkow/t9f4V5975Mxq5BsvR3wBNRNd/
EpPRAoBGCgGOgqChPcC0e2gfo8yn0WkEBfLp/wC7qgdRZKpM6pfZV8Lj4sCMvP7aJmWYeK0RdcQF
dPTOnSDFIxw6k9NjsBzsCxtzrbq0ZgW+dwsHtNePIBFVbXFqzYuFRGX5v7GNh2RekPgYvMOTiy43
8Y79ImrE2L5gbBDjxSnYPAEfVD+Dwc3RDZkglO2fNY85yyIwQrq9ksWV9gtMsirl1GZ6jNss4/IY
yHfqLwUSXf30Fhbf56rTbMhChC1MVjs8bglh5xAQDjPUh/rYR7A0vj0nS2RZRbDqLdbTlo2e8XDl
wA==
--00000000000095840705f16cdd55--
