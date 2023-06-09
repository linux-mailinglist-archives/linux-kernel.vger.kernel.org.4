Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C357729CF7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240227AbjFIOeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjFIOeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:34:09 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114392D55;
        Fri,  9 Jun 2023 07:34:08 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f6d7abe9a4so14573795e9.2;
        Fri, 09 Jun 2023 07:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686321246; x=1688913246;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0HNUo/yfFy/PNKrzdN1Hl17P1eWviTOR305UNqdfbQA=;
        b=qBc0VlaLwv0Z4E7v5I0Dzn+WpaioBcXONDE4esSEXplZ9iRbuQbYMF0kUj2IRfpkDp
         Y0iVpG8HMfiAfNshYTMiRh5XaFo894BeZHdUYu4UzzpZTKeMlhtxfGKuwLuXNIcOdZyW
         Z/cQNtVSPL4fgPq+Lrm64q6zQU9MrXpOHxSNontqJWP1DpLGdODrQPq54SIpHh/dKud8
         bHsJH14tf7+qAMMKJuF0gMlFzsKQX7c6F/HMAhJrnCuLFeshml9Vpn2Pd+TulGOEhjkE
         8763xcoXlAi9+sbC33P4RgaWKKTYLD6PK5VrYxZyfTuJOaC5q7pREPi2e2MSO6tR0vdv
         omZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686321246; x=1688913246;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0HNUo/yfFy/PNKrzdN1Hl17P1eWviTOR305UNqdfbQA=;
        b=C8tuS5MDcq4HdHkSXrT3Y8ncMMamkodqSBaDf1argjp4DkcLOqWBzJ5FuEPQhpljva
         62iEV0J7Sr6Nuud7rRwewoqzZSxmHj/McklVnTqWzTotdgSludJLxzcMJYtMvWYqYgqr
         Qq17G7l9B1KlMA0fpDu39IO254TRv+80u2gV0/AYKgld4PnaOkHmdUNulUj6F1eAavpg
         zQCqiD8eDotW2r3ybAUFEugXEiTa8njtpd49w8SQOCbVibKAxUwR6/KUNGihW/cdiNb8
         dXJUZ+bBkSl/zzt2ohExx+CufKuXeA4O09UKmLpsgkvKpsWiXfhm52/nj2FkfdN4cQV3
         fxLQ==
X-Gm-Message-State: AC+VfDz4+Pyq+Zlg+maTgJxtcQT5nppTPLpm6zNrhIzQ2v7vvUcu0n08
        3E5scu6PaALlTUSA3uuQiqg=
X-Google-Smtp-Source: ACHHUZ5Zn+0lR9YTGINzKuvCgIKeE9urQSQ15IvghtqY5fm3gw79REBiBsfzDMm9FhfP3CWeMs7LWw==
X-Received: by 2002:a05:600c:2042:b0:3f7:f90c:4979 with SMTP id p2-20020a05600c204200b003f7f90c4979mr1261704wmg.26.1686321246207;
        Fri, 09 Jun 2023 07:34:06 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id l8-20020a1c7908000000b003f7f4dc6d14sm2852554wme.14.2023.06.09.07.34.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 07:34:05 -0700 (PDT)
Message-ID: <e80e29f3-9085-f1e3-feb9-23b85cc0c914@gmail.com>
Date:   Fri, 9 Jun 2023 16:34:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
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
 <0fa22575-18d8-5598-1377-7f66c56aa861@gmail.com>
 <8f27983d-0b1d-47f1-9219-f609423c9fb6@arinc9.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <8f27983d-0b1d-47f1-9219-f609423c9fb6@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/06/2023 12:48, Arınç ÜNAL wrote:
> On 29.05.2023 16:40, Matthias Brugger wrote:
>>
>>
>> On 12/04/2023 19:06, Arınç ÜNAL wrote:
>>> On 12.04.2023 19:53, Frank Wunderlich wrote:
>>>> Hi
>>>>
>>>>> Gesendet: Mittwoch, 12. April 2023 um 18:21 Uhr
>>>>> Von: "Arınç ÜNAL" <arinc.unal@arinc9.com>
>>>>>> thanks, it changes the master when i upgrade iproute to 6.1 (from debian 
>>>>>> bullseye-backports), but i cannot do any traffic on it after switching to 
>>>>>> gmac1...
>>>>>>
>>>>>> 5: wan@eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue 
>>>>>> state UP group default qlen 1000
>>>>>>       link/ether f2:d2:51:56:cd:3d brd ff:ff:ff:ff:ff:ff
>>>>>>       inet 192.168.0.11/24 scope global wan
>>>>>>          valid_lft forever preferred_lft forever
>>>>>>
>>>>>> see no p5-TX/gmac-rx
>>>>
>>>>> Did you apply the vlan and flooding fix patches from Richard?
>>>>
>>>> have now applied all patches i've found from richard (which are all rejected):
>>>>
>>>> fe4495bb3cc2 2023-02-12 Fix setting up CPU and User ports to be in the 
>>>> correct mode during setup and when toggling vlan_filtering on a bridge 
>>>> port.  (HEAD -> 6.3-rc)
>>>> b0641f3e1a69 2023-02-12 Fix Flooding: Disable by default on User ports and 
>>>> Enable on CPU ports
>>>> cb04b3451524 2023-02-12 Do not add all User ports to the CPU by default. 
>>>> This will break Multi CPU when added a seperate patch. It will be 
>>>> overwritten by .port_enable and since we are forcing output to a port via 
>>>> the Special Tag this is not needed.
>>>>
>>>> and now it seems working and is clear ;)
>>>>
>>>> root@bpi-r2:~# ip l show wan
>>>> 5: wan@eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state 
>>>> UP mode DEFAULT group default qlen 1000
>>>>      link/ether f2:d2:51:56:cd:3d brd ff:ff:ff:ff:ff:ff
>>>>
>>>> iperf3
>>>> [ ID] Interval           Transfer     Bitrate         Retr
>>>> [  5]   0.00-10.00  sec  1.09 GBytes   940 Mbits/sec    0 sender
>>>> [  5]   0.00-10.03  sec  1.09 GBytes   936 Mbits/sec receiver
>>>>
>>>>
>>>> iperf3 -R
>>>> [ ID] Interval           Transfer     Bitrate         Retr
>>>> [  5]   0.00-10.04  sec  1.09 GBytes   936 Mbits/sec    0 sender
>>>> [  5]   0.00-10.00  sec  1.09 GBytes   938 Mbits/sec receiver
>>>>
>>>>
>>>> how do you deal with these patches? do you include them into your mt7530 
>>>> fixes series? they (and vladimirs preferred cpu-port) need to be applied 
>>>> before these DTS-changes
>>>
>>> Dealing with this is the last step on my tasklist. Take a look:
>>>
>>> https://arinc9.notion.site/mt7530-c-improvements-bbfdc2ceb958484b9627297b88bc6d4a
>>>
>>
>> I'm a bit lost here. @frank can this be merged now or are there still 
>> oustanding issues. It seems to me that not, but just in case...
> 
> I fixed the network connectivity issue on the MT7530 DSA sudriver which was the 
> main problem this patch series would cause. I don't see an issue that should 
> block this series anymore.
> 
> With the current MT7530 DSA sudriver, port 5 will be the active CPU port instead 
> of 6. I've got a patch series to prefer port 6 instead but in the meantime, this 
> patch series should be good to apply.
> 
> Arınç

Applied now, thanks!
