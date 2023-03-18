Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B8C6BF736
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 02:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCRB0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 21:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCRB0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 21:26:14 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B34B20A3C;
        Fri, 17 Mar 2023 18:26:13 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so7061739pjt.5;
        Fri, 17 Mar 2023 18:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679102772;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qPU3dsVpVXpnQ6fYXwfAdiVoA8/4WvfbER59Vv93nMc=;
        b=XXqJUJLzKSZO4I+bSKHHfwciwNr0gFbLZ2yNfgsaSose/ovOC6Zh18BK0AAlMvbgZs
         fyUe7WPKnoRPuXTb5yJCAhD0PVF1xUvvifSnxmss6c2yTsbe8MkT15QFaYKbkz/ttpVJ
         xvO3DapiHqNgDMvyukpWwf56YfWhmsD4DI5mSGpRAh0gW8vL4wgLEpojkEdeurURrkRn
         PAyj/lLSwxwhEJ64GykpM2NUn4KBal32POllzHauO9y+ehTVyL8DSvbU0p85MNpwap+F
         /hroRHb76fRVg1kztsb4oDkN1y8hEPSbv9wQAlAhj9d8G/dL/rGGUO4e8JCzt8xMy5f7
         qSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679102772;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qPU3dsVpVXpnQ6fYXwfAdiVoA8/4WvfbER59Vv93nMc=;
        b=FXHGN8osQqVHPzO9c84fr4VbIDIn62Ksm7IXCcroo/N4nnNSZxTf9/tEqdk3WB8sxK
         Y7AVRSYMqU/KV0tUKgm87BBAU6CWj1IW0eqyGpJOrlcYu6RjG6MTs+HyUfqzylV0DzWY
         hBVQ5E+32zX6YVE2vmn174zUAW/UrIeG1AZM1kQdTKPucYvPAmWji/L0b8ENbznviDM5
         Tf/f707ZTfdNKN+VKRZN5YB+qyzQuDU6YPM5CWCVeFlCx2eHGHj8s4AzxNyCXKO9SG/T
         DwUJ0H7yPR+DgAx/WL70DYOZ6gKEE7/ZXTpjxU0wBOEE0PtKAniSqRigROr4VdSkPcR0
         hHpw==
X-Gm-Message-State: AO0yUKVq1qKDQiXdfNj2NYScuuKhsoHohY+5GfBtAEKbpPB09Tmv2Sob
        UiHwF19pTvUuiXD4+9559Dk=
X-Google-Smtp-Source: AK7set/zxHLgUsEZKK+n3u3mTs3dv35d/dLMIlU9IrmAq/vNO0Ya1d13/8EV7V+egmMBj57zQKlP4w==
X-Received: by 2002:a17:902:fb85:b0:19c:da68:337a with SMTP id lg5-20020a170902fb8500b0019cda68337amr8339980plb.31.1679102772221;
        Fri, 17 Mar 2023 18:26:12 -0700 (PDT)
Received: from [192.168.1.101] (1-160-164-133.dynamic-ip.hinet.net. [1.160.164.133])
        by smtp.gmail.com with ESMTPSA id ay6-20020a1709028b8600b0019a997bca5csm2124296plb.121.2023.03.17.18.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 18:26:11 -0700 (PDT)
Message-ID: <739bb051-a816-d64e-f7fa-a2b9283794e8@gmail.com>
Date:   Sat, 18 Mar 2023 09:26:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 07/15] dt-bindings: arm: Add initial bindings for Nuvoton
 platform
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, Lee Jones <lee@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-8-ychuang570808@gmail.com>
 <f8b323b4-fd07-f5fd-70cf-31450e9ef204@linaro.org>
 <235fcb71-9e96-4f28-bb8c-6843d4d85cea@app.fastmail.com>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <235fcb71-9e96-4f28-bb8c-6843d4d85cea@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Arnd and  Krzysztof,


Please allow me to answer the question of Krzysztof in this mail.


On 2023/3/16 下午 10:32, Arnd Bergmann wrote:
> On Thu, Mar 16, 2023, at 08:33, Krzysztof Kozlowski wrote:
>> On 15/03/2023 08:28, Jacky Huang wrote:
>>> From: Jacky Huang <ychuang3@nuvoton.com>
>>>
>>> Add binding for ARMv8 based Nuvotn SoCs and platform boards.
>>> Add initial bindings for ma35d1 series development boards.
>>>
>>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>>> ---
>>>   .../devicetree/bindings/arm/nuvoton.yaml      | 30 +++++++++++++++++++
>> And what is npcm for? Why it was made an directory?
>>
>> All these should be just one Nuvoton.


Thank you for your suggestion, then in the next version I will submit to 
rename directory npcm to nuvoton.

And rename this file nuvoton.yaml to nuvoton,ma35d1.yaml, and put in the 
nuvoton directory.


> npcm is an unrelated product line, so I think it would be best
> to rename the npcm directory to nuvoton and move the new
> file in there, though I'm not sure about the name or what the
> other chips are called.
>
> My impression is that this one is more closely related to
> the older Arm9 nuc900/w90x900/n9 chips that we dropped from
> the kernel a while ago, while the npcm family has a different
> origin.
>
>      Arnd

npcm focuses on the BMC field, and ma35 is the successor SoC of 
nuc970/nuc980,

which is mostly used in industrial control, consumer, network 
applications and other fields.

The two teams are located in different countries and regions, and there 
is little

communication and resource sharing with each other.


Best regards,

Jacky Huang


