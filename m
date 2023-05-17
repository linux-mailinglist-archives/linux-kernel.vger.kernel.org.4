Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0EC57062E2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjEQIa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjEQIaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:30:03 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0D5618E;
        Wed, 17 May 2023 01:29:33 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2ac80ed7f26so3812971fa.1;
        Wed, 17 May 2023 01:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684312171; x=1686904171;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=78En7bFX4DNtv99F1zZg+12j6HtDjxQe1ib/JrAoDvA=;
        b=XRWVX2p7cTvMHloNSe+15Ataagn9cyJxaJbHcp1PHe5lusUhd++9+4KqN18L63WreI
         LsKUM7V3TLcdcw1FFvPLFBso/oCe/gPHN7csTTO00yZwUSnF7OX7jFFtpG4oHZjgJeRC
         PDenRervF0VNz/jig6R5/JNNjOZftfHDMdWqTMvl9KIXXwpE9BPhvStHYSGftav/Ig+B
         eXMiE+IVmo6DAqWWdPsslhzMOK61hvsU3CU48ckIwE6DtkF0eGXewN23j7HoTa4HYJwN
         G4ysNzjk0nclpG5rFafu8gnwwGGIRcNDhcbWuFnXV/s+10G7kAcE6zcMAtwE6I8bJFbA
         Vumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684312171; x=1686904171;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=78En7bFX4DNtv99F1zZg+12j6HtDjxQe1ib/JrAoDvA=;
        b=XdgYYaWlIIIktEAbIqOQW47Tx5Tzm1l0ihzijpDukf3MI1Xo7i3Jb7xYk8IJBOB7ZA
         ZCj84zcL3rjdJmK2XzE73TV+zMTuGmkKTpFNObRgo27XwHURdYxkZSwfbDdW6zEdsVJ4
         RR8Mbe/EF2ZwjLl2D1VzaTye3xWAXZKoOPxp0/01vCQjM1gSFA/ig12SfEEpOVYF6svM
         Wsm9C+I4DNj3kSej8XyBS1bYauGj6KR5bEVcOz5NqjCdjZDCWLhFu65nNjHsUMuH+hGS
         nT1NVgtLvmETbkj7HnjMwVN8s2K40ZPpZUzOkuzfPd4YC/RNQIrWQVETPQyv5j74YaOs
         lWdw==
X-Gm-Message-State: AC+VfDw67Flu1BVv2aHXaImsz+H4i3fKlDWuiw1BTusXdZ2odzrP4ueU
        DbPdG16qR0eavfzuecN2wCw=
X-Google-Smtp-Source: ACHHUZ5oddWxcGwgp3BKJp1Lcs/+h6rsNvb+TshwjSOR4jrSPWEUTaWM1im/mPATuGuxQIyzaCF7Lg==
X-Received: by 2002:a2e:8244:0:b0:2ad:814c:6ad5 with SMTP id j4-20020a2e8244000000b002ad814c6ad5mr8045673ljh.46.1684312170872;
        Wed, 17 May 2023 01:29:30 -0700 (PDT)
Received: from [10.8.28.198] ([89.201.166.50])
        by smtp.gmail.com with ESMTPSA id h4-20020a2e9ec4000000b002a8c32fd2f3sm4515688ljk.89.2023.05.17.01.29.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 01:29:30 -0700 (PDT)
Message-ID: <356bfe96-75e6-1c6d-0049-d664e719a266@gmail.com>
Date:   Wed, 17 May 2023 10:29:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2] dt-bindings: display: panel: add
 panel-mipi-dsi-bringup
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        robh+dt@kernel.org, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CAO9szn18KsR0c+U8EEY1=xnmsKMxy6SEArMUic0z=aYJDVwWCQ@mail.gmail.com>
 <023f6cf9-0f08-f27e-d203-5ff78faf110f@linaro.org>
 <CAO9szn1EsbuPSRrOW8CLqhp+QUcL=9NE93FAwsg2n3htd_aJTw@mail.gmail.com>
 <97124cb1-4f45-22d5-418f-568f8a68deec@linaro.org>
From:   Paulo Pavacic <pavacic.p@gmail.com>
In-Reply-To: <97124cb1-4f45-22d5-418f-568f8a68deec@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

If I understood you correctly you'd prefer it to be named 
fannal,c3004.yaml? My logic is that if more panels were to be added that 
means that each one would have yaml files that would look exactly the 
same with the same user.

Best regards,

Paulo

On 5/17/23 09:03, Krzysztof Kozlowski wrote:
> On 17/05/2023 00:13, Paulo Pavacic wrote:
>> Hello, thank you for your time to review this patch and sorry for not
>> addressing all of the concerns, it was done unintentionally. This is
>> my first contribution to the Linux kernel and it is quite a process.
>> I have run those two scripts and haven't received any errors I have
>> latest master cloned so I will check what I did wrong.
>>
>> The thing I would like to get approval on before I try anything else
>> is the name 'panel-mipi-dsi-bringup':
>>
>>> Still wrong filename. You did not respond to my previous comments, so I
>> don't really understand what's this.
>>> Judging by compatible, this should be fannal,c3004.yaml
>>>
>>> If not, explain please.
>>>
>>> Missing user of the bindings - driver or DTS. Please sent patches together as patchset.
>>
>> I wasn't sure how to name it and this name seemed fit. I'm not sure
>> how to be concise about this, but here is the full story as to why I
>> have done that:
>>
>> I got a task to enable panel for which working driver wasn't
>> available. I have started testing raydium driver and modifying parts
>> of it until I got it working.
>> Driver was modified quite a lot, new functions, macros and structures
>> were added which resulted in a new driver.
>> Therefore I have made a simple driver which I have submitted for a
>> review which will probably be rejected now due tomany reasons I have
>> noticed after sending it:
>> https://lore.kernel.org/lkml/CAO9szn03msW6pu37Zws5EaFGL10rjp9ugPdCuDvOPuQRU72gVQ@mail.gmail.com/T/
>>
>> While talking with manufacturers of the panel I have figured out that
>> they aren't that familiar with the Linux kernel.
>> They had previously only enabled  it on bare metal (PLA?) and provided
>> me with the initialization sequences. Initialization sequences are hex
>> values sent over MIPI DSI to initialize panel controller.
>> Initialization sequences sometimes also require delays after certain
>> commands and for different panels it can be very different.
>> I believe I have simplified it so that someone can follow comments
>> inside of the driver and try to enable mipi dsi panel by copy pasting
>> initialization code from bare metal system and doing minor
>> modifications.
>> Since I have targeted this at people who need to enable their panels
>> for the first time name seemed okay. I thought that since there is
>> panel-simple.yml that panel-mipi-dsi-bringup.yml would be acceptable
>> name.
> Bindings are for hardware, not driver, so they describe the hardware panel.
>
> Best regards,
> Krzysztof
>
