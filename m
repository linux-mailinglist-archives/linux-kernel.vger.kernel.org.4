Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A8965C0D4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 14:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237380AbjACNam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 08:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237373AbjACNai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 08:30:38 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF9711160
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 05:30:36 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso23094141wmp.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 05:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cv1Wfi3d8SBB02zKQxg1ALlLeVvU1jS+95XRuMrm1uE=;
        b=TfdPfRbB0nIp3Nn2sSxevzc+uRIjwWnrh988LPRTUmN0sveOMyVTXU6NriSJEHY548
         1n92GhH5RaIOHj5dfRsCznDyRL4Jeeq8QXUSYfOf+g8wUd4kyg1jYrq8XbW3Ep6MWrbk
         IR3uug1iAOg0m12Z7gmweFHHA8cFZri6JP5uM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cv1Wfi3d8SBB02zKQxg1ALlLeVvU1jS+95XRuMrm1uE=;
        b=zaDa3z778B8pbnR00VHmc5apROcCLiVwM1+J384B2dA2g7pBCIGfm2Pk71ovAhdnda
         uqGnFGZqcquDQBH56E6SfPhoXEYh6qRzfiXelfEPoM00t3EYSUjn3GogXzlHqJWegfx1
         /OUPmnIl4WsbyX/Huk/szxe2ROBdIbFe3kPsGr64VBlrk9anoWqAzp6QPmSE5mViwjMW
         VYRt6fDsF75RR/iX0vaYUQlZSCrD/sE6yA1djOjs0m8wiCxWgfQyWl+cuE4cDZRM19d9
         QN097963AOIb7Rs2vBkF3oglb94Jnt8OVbpojyawXV6DPv2XGfzzo5PxzGApN/V7m/DE
         kOfw==
X-Gm-Message-State: AFqh2kohpEqW5qbI4wFdOAPh2/6EBeYVSY8ab0+i1UjxJhP+bWwW1Fu9
        aeUagCjLXR0vYDpJHy1y9ivN/w==
X-Google-Smtp-Source: AMrXdXvn13+SMQFW2Hx/PqVEswlT1NrJKKE2ooIycPif5AU3eCzhpSx0UviTJaUnhQt4ocabda4DRQ==
X-Received: by 2002:a05:600c:2142:b0:3d5:365b:773e with SMTP id v2-20020a05600c214200b003d5365b773emr38414799wml.39.1672752634873;
        Tue, 03 Jan 2023 05:30:34 -0800 (PST)
Received: from [10.176.68.61] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id l13-20020a05600c2ccd00b003c70191f267sm50001716wmc.39.2023.01.03.05.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 05:30:33 -0800 (PST)
Message-ID: <6b30559d-9bcc-f3b3-d9b2-2406e9a044b7@broadcom.com>
Date:   Tue, 3 Jan 2023 14:30:33 +0100
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
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <3785835b-164b-28d1-6905-85454cabb69d@marcan.st>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000009f395205f15c1275"
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000009f395205f15c1275
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/3/2023 4:55 AM, Hector Martin wrote:
> On 2023/01/03 3:27, Arend Van Spriel wrote:
>> On January 2, 2023 4:15:41 PM Hector Martin <marcan@marcan.st> wrote:
>>
>>> On 02/01/2023 23.40, Aditya Garg wrote:
>>>> From: Aditya Garg <gargaditya08@live.com>
>>>>
>>>> Commit 'dce45ded7619' added support for 89459 chip pcie device. It uses the
>>>> BRCM4355 chip which is also found in Apple hardware. However this commit
>>>> causes conflicts in the firmware naming between Apple hardware, which
>>>> supports OTP and other non-Apple hardwares. So, this patch makes these
>>>> Apple chips use their own firmware table so as to avoid possible conflicts
>>>> like these in the future.
>>>
>>> I think my reply to Arend flew over your head.
>>>
>>> My point was that I'd rather have the Broadcom/Cypress people actually
>>> answer my question so we can figure out how to do this *properly*,
>>> instead of doing "safer-but-dumb" things (like this patch) because we
>>> just don't have the information to do it properly.
>>
>> Fair enough. Can you accurately (re)state your question and I will try to
>> answer it.
> 
> As per my original email: Is the CYW89459 just a rebrand of the BCM4355,
> or just a subset? Can we consider them equivalent, and equivalent to the
> Apple part (BCM4355C1 / revision 12)?

There is probably no easy answer. Mainly because Cypress is a separate 
entity. However, they use the same/similar technology and code base. So 
let me first start with the chip naming. The wifi chip primarily has a 
number and revision. The chip number is straighforward and can be read 
from the device. The chip revision comes in two variants: 1) simple 
increasing number as read from the device, and 2) a <letter><digit> 
format. The latter start at a0, which you almost never see in the wild 
unless we do it "first time right". Whenever spinning a new chip we 
either increase the digit or the letter depending on type/amount of 
changes. There is not predictable mapping between the revision variants. 
Depending on the hurdles in a chip project we may move from a0 to b0, or 
from b0 to b1 or whatever.

If CYW89459 chip reads chip number 0x4355 than it is a BCM4355. If it is 
a different revision it may require different firmware. A different 
letter will always require different firmware. A different digit may 
work although the firmware can have code paths for a specific revision.

The firmware tables in pcie.c have the revmask. With our crystal ball 
being out-of-order we tend to enable a firmware for all revisions 
(0xFFFFFFFF) unless proven otherwise. If otherwise, we come up with a 
sensible new name and add a new entry to the firmware table changing the 
revmasks accordingly.

> More specifically:
> - What BCM4355 variants exist in the wild, and what are their PCI device
> IDs and revision IDs?

Who knows. The PCI revision ID always equals the chip revision afaik. 
The PCI device IDs should be as below.

> - Is a single firmware nominally intended to be compatible with all of
> those variants? Does that include the CYW89459 branded parts?
> - If CYW89459 is a rebrand of BCM4355, is it complete, or are there
> still chips being sold as BCM4355?
> 
> Even more specifically, bcmdhd has these device IDs:
> 
> #define BCM4355_D11AC_ID    0x43dc  /* 4355 802.11ac dualband device */
> #define BCM4355_D11AC2G_ID  0x43fc  /* 4355 802.11ac 2.4G device */
> #define BCM4355_D11AC5G_ID  0x43fd  /* 4355 802.11ac 5G device */
> 
> But the patch I'm replying to uses PCI ID 0x4355, which instead should be:
> 
> #define BCM43237_D11N_ID    0x4355  /* 43237 802.11n dualband device */
> #define BCM43237_D11N5G_ID  0x4356  /* 43237 802.11n 5GHz device */
> 
> So what's up with the BCM43237? Is that a 4355 variant? Is this what got
> rebranded as CYW89459? Is it firmware-compatible with the others?

Right. If you have come across a BCM4355 with PCI device ID 0x4355 than 
my best guess would be that their OTP is corrupted and the PCIe core on 
the chip uses its default as stored in hardware, which equals the chip 
number. This is really a fallback for a faulty device (or a device which 
does not have its OTP programmed).

> <rant>
> 
> I'm going to be honest here: I'm quite saddened by the state of brcmfmac
> and Broadcom's neglect of this driver. Other than the Apple OTP /
> firmware selection shenanigans, everything else I'm having to implement
> to support Apple machines are features that Broadcom's downstream bcmdhd
> driver *already* supports on non-Apple machines, not Apple-specific. Not
> only that, people are asking for modern WiFi features like newer crypto
> modes that bcmdhd supports but brcmfmac doesn't. It seems clear that
> Broadcom isn't interested in maintaining this driver and updating it to
> support newer chips and features. So I'm basically doing your job for
> you all. Which is fine, but if I'm going to be in charge of implementing
> all this stuff for you, *please* help me by at least clarifying the
> device variant / firmware feature related issues, because getting that
> wrong will cause regressions or firmware naming scheme breaks down the
> line, and that sucks for users.
> 
> </rant>

Happy New year to you. Thanks for clearly marking the rant. Makes it 
easier to ignore, but let me get into this. I would not call bcmdhd the 
downstream driver. It is a separate out-of-tree driver. Indeed resources 
were pulled from brcm80211 development, but there always have been only 
2 or 3 people working on it. Me being the constant working mule and 
these days only for 20% of my working hours to do the job. So you are 
not really doing our job as we are not assigned to do so. I guess there 
is no ROI for Broadcom or so it is perceived and there is no customer 
pushing for it. That said I am always happy to help and clarify whatever 
I can.

Regards,
Arend

--0000000000009f395205f15c1275
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
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCD17ycuxwTnyz3AaGYE
RtRdZ+DXmSfiVuCT3vYCYDk2djAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMzAxMDMxMzMwMzVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEA3lEt+Xxr+nJ8AviV847172cYjjtkmLrg8r/b
pH9HXxqlWlXGXbO+V3pJKFmc/Xls607i3INvERwIgCqPI8LCm2EogriqfQYs5EujylkDwbbtqCdj
ORts27l2fEUFmvcRBxuqca6wfJWJaFNFEFifLea+OBGTLGzoNS+t7xI0sSl3QcP/3cb2c7zvwvar
g79q/nmd468+MCD8PhIqw3hNsFCE4LADwZJD+1FwyPmNRexNl10YjlYGN0bgAcRUUVZ2PgtHnzXi
XguXMe6U9BDR90LmpxhLD84bSi5WRDjot5ypHQHZKN1YKEC6kQeHqWHI354KhhhuVbM8+8lpZ1LX
3Q==
--0000000000009f395205f15c1275--
