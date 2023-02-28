Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FE56A5948
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 13:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjB1Mnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 07:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjB1Mn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 07:43:28 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1146EB5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 04:43:07 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id ck15so39574135edb.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 04:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nJVEIhPKLgTn+f8VRs4bEIhn760RPkrg51g9quDiRIM=;
        b=KpZe4kRNteu5U7jRkBjLAJrNgdsosHyBUOuWkSDOiYhDSEZemMAlXs2A+5/nOeRwbc
         gHZLzrN99Fd9HyEHt51MNyySoE7+SZURVC7mJ8oOiNQnn6aBoziCZBV1fNWH8AtOmD8s
         eFb2FIrOIQriuUuE67S8xs1yVBfkjpVYCd2VsZeMprVlawBTMKdJphmhGMR9gTDUTHei
         OzB2SE8gxRX9HYbWukfQrEapjCVClDWL2hNQyRubzjNahdqBpmK33OvtOCffI/8jQl2q
         +dbrlazx2m8MBhSDeAgQfTlTJPRaUOzUzdcC7JsWgV8kn3SF1k3sGsZm8kJ2RIXhLppT
         q07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nJVEIhPKLgTn+f8VRs4bEIhn760RPkrg51g9quDiRIM=;
        b=zCwxCPu7fEONujs4iwyMXNRgEMxggWy2UPh9mcf+NecLF5rErmc5NB2aPhhHotrS34
         aNUqYZMHHrpLGDrRT6qaNsq6VHmIcDEJHrj7Nd6g9es5K9sk/Qo9RVHWPQYceuSDVWUB
         K+RG3+joa/GwOPHM9cQWG+biHeDhW9wiATzwPKH/QMPUJEmYzfk8mDN0HtSJIhzlWipI
         Yd50XupOO1zKXBRMjAm5Zyxz387S8mbY6HPiuwRqU0xtazwpz9kb6pNYMjLE1Qb2qFtp
         NE5umpjE0igZoEsTxCEs09b3NAyozevtueoOMJnQNskZ1Z/HNs7qGQmsGLnv0yn8UTw6
         Wc0Q==
X-Gm-Message-State: AO0yUKWAE3kk+bzWKd4o1FZ8v3LQ2bIosXQs3Ybqh6iSiuFuNCVCQfHT
        VwOvSWXx3w9QCe1UzcEU9ikrdsZYvus=
X-Google-Smtp-Source: AK7set/OhVedFmU/CFmt9qtLTMgyTFaxY8xIf1FUKl3A+f66bTfFrn3M6y8ruONLxxA3A6be+MD9yw==
X-Received: by 2002:a17:906:b851:b0:872:b17a:9b59 with SMTP id ga17-20020a170906b85100b00872b17a9b59mr2493027ejb.38.1677588185729;
        Tue, 28 Feb 2023 04:43:05 -0800 (PST)
Received: from [192.168.178.21] (p5b0ea2e7.dip0.t-ipconnect.de. [91.14.162.231])
        by smtp.gmail.com with ESMTPSA id h23-20020a50cdd7000000b004af64086a0esm4371314edj.35.2023.02.28.04.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 04:43:05 -0800 (PST)
Message-ID: <5cbba992-c4ce-01c1-2691-ed65ce66aad5@gmail.com>
Date:   Tue, 28 Feb 2023 13:43:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: amdgpu didn't start with pci=nocrs parameter, get error "Fatal
 error during GPU init"
Content-Language: en-US
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <CABXGCsMbqw2qzWSCDfp3cNrYVJ1oxLv8Aixfm_Dt91x1cvFX4w@mail.gmail.com>
 <a99e6def-68be-3f2b-4e01-ac26cdb80f49@gmail.com>
 <CABXGCsM7JPxtQm6B7vk+ZcXfphgQm=ArJZKiDUdbk9hujyRtmg@mail.gmail.com>
 <43016018-4d0a-94dc-ce93-b4bff2dce71c@gmail.com>
 <90b1c9f8-1674-e9ec-e6d8-2fa1967439b3@gmail.com>
 <CABXGCsN2NutEmi==JBDD5G2Bj=DJ6vm87_Cbubycz-WowUOh5w@mail.gmail.com>
 <e2975d53-840c-a104-8b2d-c302f502c894@gmail.com>
 <CABXGCsOJkF=c4B+oQm7cuEO7Fr_oknmH2iB6e6OCzmFy=KYtAw@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CABXGCsOJkF=c4B+oQm7cuEO7Fr_oknmH2iB6e6OCzmFy=KYtAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 28.02.23 um 10:52 schrieb Mikhail Gavrilov:
> On Mon, Feb 27, 2023 at 3:22 PM Christian König
>> Unfortunately yes. We could clean that up a bit more so that you don't
>> run into a BUG() assertion, but what essentially happens here is that we
>> completely fail to talk to the hardware.
>>
>> In this situation we can't even re-enable vesa or text console any more.
>>
> Then I don't understand why when amdgpu is blacklisted via
> modprobe.blacklist=amdgpu then I see graphics and could login into
> GNOME. Yes without hardware acceleration, but it is better than non
> working graphics. It means there is some other driver (I assume this
> is "video") which can successfully talk to the AMD hardware in
> conditions where amdgpu cannot do this.

The point is it doesn't need to talk to the amdgpu hardware. What it 
does is that it talks to the good old VGA/VESA emulation and that just 
happens to be still enabled by the BIOS/GRUB.

And that VGA/VESA emulation doesn't need any BAR or whatever to keep the 
hw running in the state where it was initialized before the kernel 
started. The kernel just grabs the addresses where it needs to write the 
display data and keeps going with that.

But when a hw specific driver wants to load this is the first thing 
which gets disabled because we need to load new firmware. And with the 
BARs disabled this can't be re-enabled without rebooting the system.

> My suggestion is that if
> amdgpu fails to talk to the hardware, then let another suitable driver
> do it. I attached a system log when I apply "pci=nocrs" with
> "modprobe.blacklist=amdgpu" for showing that graphics work right in
> this case.
> To do this, does the Linux module loading mechanism need to be refined?

That's actually working as expected. The real problem is that the BIOS 
on that system is so broken that we can't access the hw correctly.

What we could to do is to check the BARs very early on and refuse to 
load when they are disable. The problem with this approach is that there 
are systems where it is normal that the BARs are disable until the 
driver loads and get enabled during the hardware initialization process.

What you might want to look into is to find a quirk for the BIOS to 
properly enable the nvme controller.

Regards,
Christian.

