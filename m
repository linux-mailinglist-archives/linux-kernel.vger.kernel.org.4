Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266E5714A82
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjE2Nkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjE2Nkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:40:31 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE018E;
        Mon, 29 May 2023 06:40:28 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3094910b150so3239168f8f.0;
        Mon, 29 May 2023 06:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685367627; x=1687959627;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mxtv+n+9GX58U9t1nthHcLDjW4jnsXu+YR96/0Z2j98=;
        b=Tb09cbF1/tC40xHnKyrLs7U+LlEoAmtErzT0HSwPspRdBLRHVGw8Hm+7WvbfOF24/u
         eT/D3+CteeyZ1dF1WUZTASUuMdG0AZ/7ZopiPvNUlpIK61KhV1YeV0eOjdUZbi3MDKak
         iluneRdT08Cvhr0zQqfJu3KS7MR6/iJ3WwyuccPHZqhMYn9ZNUCfC/+lEyplxDUxuiWE
         Ep8E6EaG4mTJvt+JjDoJmtE2QALrvxORLp3bdZLbqWIjcHxzk+P20CMWYzoPp8XbYfnL
         q8rfWwi2R59T2xe8PIpVm5TanYZCr3V13SSEzj6KWMhruT8FWSlGvo3QY8MmYH18z+pD
         dlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685367627; x=1687959627;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mxtv+n+9GX58U9t1nthHcLDjW4jnsXu+YR96/0Z2j98=;
        b=Ayg5jgJzBp01eImFcPbeR7276y475L/f+3zyCauUlmd7DbDa+PmrFD3i3dOkcYWEEr
         VfVnXPdR8jrr9meWnz0u8NiCE9kxpWKiHMQEC5bPK5AF3ApUD2hAJOf8o2Yr536MLM9t
         6nyjxCufP0+yHPbiOnZRMUlqF1qo4P9h1st4lYvNo/v9DXX03LQ4cmmfrleSiPeXgfyo
         Yy6EQZes0HxsbGDqVh71xpjcf989J1iFNk0T1r/MWpESGlFjkUA3e4+/3ys+L4OybaIL
         glXnRO/OXLWFWpqIQQULPloA10/+8ZmCLiWVGY2Q+iElD2pR8ka6hmlswU+wb9k32sYY
         KRZA==
X-Gm-Message-State: AC+VfDyZ5lKXyMVet/nvzE7nupJ5iRFLMUEkyNnRs4haJOmISMbfIBuI
        E0T+UZJfrlxFFYRH/VsyYhU=
X-Google-Smtp-Source: ACHHUZ6WN71S6Kea8Q3nZ54LsYXE/pz65GCOSy3PwFMy+T+lQHUzOMjt6xVt47ymMAheLf29Mn27fw==
X-Received: by 2002:a5d:66d1:0:b0:30a:e5ba:170d with SMTP id k17-20020a5d66d1000000b0030ae5ba170dmr5716140wrw.32.1685367626949;
        Mon, 29 May 2023 06:40:26 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id r14-20020adfda4e000000b0030adc30e9f1sm9918156wrl.68.2023.05.29.06.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 06:40:25 -0700 (PDT)
Message-ID: <0fa22575-18d8-5598-1377-7f66c56aa861@gmail.com>
Date:   Mon, 29 May 2023 15:40:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Aw: Re: Re: Re: Re: Re: [PATCH v3 0/5] arm: dts: mt7623: relocate
 gmacs, mt7530 switch, and add port@5
Content-Language: en-US, ca-ES, es-ES
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Frank Wunderlich <frank-w@public-files.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, erkin.bozoglu@xeront.com
References: <20230210182505.24597-1-arinc.unal@arinc9.com>
 <c3ab9a9b-3eb2-8fb0-d5d7-c0b7c684d3a7@arinc9.com>
 <trinity-dab715b9-3953-40da-bc25-c4c2a5e9b7c3-1676715866453@3c-app-gmx-bap53>
 <27a26da8-8297-5327-7493-54d8359b6970@arinc9.com>
 <trinity-dd260791-3637-4193-8f93-a9fcdb013dcb-1676722705920@3c-app-gmx-bap53>
 <2dc2fc39-b0d5-c872-36bf-fde851debe4b@arinc9.com>
 <A329B2DF-04B7-40FA-BBCE-1F1012A6DBBD@public-files.de>
 <fb96d8eb-2eb7-db19-1135-1a833294dd67@arinc9.com>
 <trinity-899c01a6-0fc5-4900-aea8-2b43802c8329-1676814734826@3c-app-gmx-bs35>
 <trinity-3f46d325-bc45-4ee7-ae86-c8db4467aa94-1681303779505@3c-app-gmx-bap50>
 <703ad8a8-f84e-6404-4cce-5386bfaa2bd7@arinc9.com>
 <trinity-489cdc3b-e861-49d0-b1ec-e964f00388df-1681312277092@3c-app-gmx-bap50>
 <0d242292-16b7-6837-7d1a-b70c41309e6b@arinc9.com>
 <trinity-990f3b28-d67c-49ef-9094-c3b7d2059e36-1681318402336@3c-app-gmx-bap50>
 <e08c5175-d771-5b87-d065-47942a800419@arinc9.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <e08c5175-d771-5b87-d065-47942a800419@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/04/2023 19:06, Arınç ÜNAL wrote:
> On 12.04.2023 19:53, Frank Wunderlich wrote:
>> Hi
>>
>>> Gesendet: Mittwoch, 12. April 2023 um 18:21 Uhr
>>> Von: "Arınç ÜNAL" <arinc.unal@arinc9.com>
>>>> thanks, it changes the master when i upgrade iproute to 6.1 (from debian 
>>>> bullseye-backports), but i cannot do any traffic on it after switching to 
>>>> gmac1...
>>>>
>>>> 5: wan@eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state 
>>>> UP group default qlen 1000
>>>>       link/ether f2:d2:51:56:cd:3d brd ff:ff:ff:ff:ff:ff
>>>>       inet 192.168.0.11/24 scope global wan
>>>>          valid_lft forever preferred_lft forever
>>>>
>>>> see no p5-TX/gmac-rx
>>
>>> Did you apply the vlan and flooding fix patches from Richard?
>>
>> have now applied all patches i've found from richard (which are all rejected):
>>
>> fe4495bb3cc2 2023-02-12 Fix setting up CPU and User ports to be in the correct 
>> mode during setup and when toggling vlan_filtering on a bridge port.  (HEAD -> 
>> 6.3-rc)
>> b0641f3e1a69 2023-02-12 Fix Flooding: Disable by default on User ports and 
>> Enable on CPU ports
>> cb04b3451524 2023-02-12 Do not add all User ports to the CPU by default. This 
>> will break Multi CPU when added a seperate patch. It will be overwritten by 
>> .port_enable and since we are forcing output to a port via the Special Tag 
>> this is not needed.
>>
>> and now it seems working and is clear ;)
>>
>> root@bpi-r2:~# ip l show wan
>> 5: wan@eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP 
>> mode DEFAULT group default qlen 1000
>>      link/ether f2:d2:51:56:cd:3d brd ff:ff:ff:ff:ff:ff
>>
>> iperf3
>> [ ID] Interval           Transfer     Bitrate         Retr
>> [  5]   0.00-10.00  sec  1.09 GBytes   940 Mbits/sec    0             sender
>> [  5]   0.00-10.03  sec  1.09 GBytes   936 Mbits/sec                  receiver
>>
>>
>> iperf3 -R
>> [ ID] Interval           Transfer     Bitrate         Retr
>> [  5]   0.00-10.04  sec  1.09 GBytes   936 Mbits/sec    0             sender
>> [  5]   0.00-10.00  sec  1.09 GBytes   938 Mbits/sec                  receiver
>>
>>
>> how do you deal with these patches? do you include them into your mt7530 fixes 
>> series? they (and vladimirs preferred cpu-port) need to be applied before 
>> these DTS-changes
> 
> Dealing with this is the last step on my tasklist. Take a look:
> 
> https://arinc9.notion.site/mt7530-c-improvements-bbfdc2ceb958484b9627297b88bc6d4a
> 

I'm a bit lost here. @frank can this be merged now or are there still oustanding 
issues. It seems to me that not, but just in case...

Regards,
Matthias
