Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79CD746018
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjGCPvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjGCPvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:51:09 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32185C2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 08:51:07 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbc0981756so44137955e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 08:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1688399465; x=1690991465;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nToOaFFb7Yah/0oWYDXxyn35HQ2cDLw7R7eaZRYCDPY=;
        b=YKvDFs2Oy2TzMYx528oGqvtoNVyHbM1Zjdn/JaUPRNljJJZ3WIW6YsDYQInbhYko2m
         SUf1e3FDOdR2n6DVhvnM0dMRoWwG6XFQQ9zaX0PuOP14NOJHyck5lUZjBemwCloXNv1Q
         XhEddi3H1MT7sJw3+rRiVEuQS0scIlwVynCioWUJTtOGCbEmjn9TMBgYsF5cmKso/HGm
         Uyr6Ll3t1ybwejAKJEN3ii3hlh/53l42G8W/l9/1yLkk4bPkR1GT+7XFrL3Y/6ICFqJM
         9iDftsXJV35HvD6Qp4yvskucJWNAsCXEo4yFa4b3CEif+EvuGL4ASytL6i0SQo1iF6lL
         GO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688399465; x=1690991465;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nToOaFFb7Yah/0oWYDXxyn35HQ2cDLw7R7eaZRYCDPY=;
        b=AjlRVmQaAqVsDEdDIAVCBRAFl+bJx7ysCk1IzHtZWPF9yJ+iW0jbVDwUYNmKG+B1Zv
         L9NhIczK79hB4NPDATOwxIznxe90TpDy5xEtmYqOHMACZgMD/j1ATIWEGU0NoqaiF8DW
         R7oKivUmiYZhzthAUCvyGaps3lGqV1fsndQ8P9RhRh6a+YbG9PAJAABXbT2nk2CUKq75
         +mFNzb8JqTR+YrprNyWXrdk4u/KvN0gvzKa1P4xkhaNzk3sO59MA73+zhx6gD/2snBOU
         Vnr5vu/hAK+gsx5v3BNEo3aGmyFOYoamXFj1UkkfzEgmWLYiqurtbHphzefs1FWzeGbN
         xxvA==
X-Gm-Message-State: AC+VfDyrbFHkH2dyhb3vylNAEKHWk3YAesq+avKmr4C4JdqeRVjk1vZk
        111uNzWKCo/H/i6vGw4OuZyrgA==
X-Google-Smtp-Source: ACHHUZ54jcD/MBjy6F4Yqf6Ekyb9RrUIEbOxW19tjq7VIUkk+8z67EnalI70htsAqH9Xid6lxnrfQw==
X-Received: by 2002:a05:600c:21d6:b0:3fb:b299:6eba with SMTP id x22-20020a05600c21d600b003fbb2996ebamr7904522wmj.4.1688399465627;
        Mon, 03 Jul 2023 08:51:05 -0700 (PDT)
Received: from [192.168.35.121] ([77.205.21.54])
        by smtp.gmail.com with ESMTPSA id z12-20020a1c4c0c000000b003fa9554fb30sm22753833wmf.44.2023.07.03.08.51.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 08:51:05 -0700 (PDT)
Message-ID: <6d485ee7-9b8a-626e-da8a-bbff37bcde61@baylibre.com>
Date:   Mon, 3 Jul 2023 17:51:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/3] Configure usb0 as peripheral on am335x boards
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vigneshr@ti.com, nm@ti.com, Tom Rini <trini@konsulko.com>
References: <20230629-usb0-as-peripheral-v1-0-167f78a11746@baylibre.com>
 <20230630072047.GK14287@atomide.com>
 <f4fa80fd-1a6a-4718-0287-f5288cd9d912@baylibre.com>
 <7f44798b-e2bf-1620-da37-ca13bfd07a21@kernel.org>
 <babf5f20-ddf4-74bf-1788-f8e356acaa92@baylibre.com>
 <9ef45899-c766-e839-522a-3b048f8106f7@kernel.org>
 <6a51d860-2d20-6c35-3935-985d5b41853e@baylibre.com>
 <73a4545a-e149-261a-a0c5-a526e8740bd5@kernel.org>
From:   Julien Panis <jpanis@baylibre.com>
In-Reply-To: <73a4545a-e149-261a-a0c5-a526e8740bd5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/23 17:27, Roger Quadros wrote:
>
> On 03/07/2023 17:14, Julien Panis wrote:
>> On 7/3/23 15:44, Roger Quadros wrote:
>>> On 03/07/2023 14:56, Julien Panis wrote:
>>>> On 6/30/23 21:40, Roger Quadros wrote:
>>>>> Hi,
>>>>>
>>>>> On 30/06/2023 11:30, Julien Panis wrote:
>>>>>> Hello Tony,
>>>>>>
>>>>>> On 6/30/23 09:20, Tony Lindgren wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> * Julien Panis <jpanis@baylibre.com> [230629 13:10]:
>>>>>>>> This series configures usb0 dr_mode as 'peripheral' for am335x-evm,
>>>>>>>> am335x-evmsk, and am335x-icev2. This USB port is mainly used for
>>>>>>>> RNDIS and DFU.
>>>>>>> Is this a mini-B connector? Just wondering if it was originally attempted
>>>>>>> to be configured as OTG or how it ended up with a host configuration..
>>>>>> It's a micro USB-AB connector.
>>>>>> I don't know how it ended up with a host configuration, it looks like an oversight.
>>>>>> Maybe Vignesh or Nishanth can confirm (?)
>>>>> usb0 role should be "otg".
>>>>> It is rightly so in Linux DT. am33xx.dtsi contains "otg" and all AM335x board files inherit from it.
>>>>>
>>>>> So I don't think setting it to "peripheral" in u-boot is the right thing to do.
>>>> This series is for kernel (not for u-boot).
>>>> Why is it a problem to set usb0 as 'peripheral' in kernel for the 3 board dts ?
>>>>
>>>> With usb0 not set as 'peripheral', the 3 boards (am335x-evm, evm-sk, icev2)
>>>> do not boot with uboot 2023.04. This error is returned, with LOG_LEVEL=5:
>>>>       No USB device found
>>>>       USB ether init failed
>>>>       initcall sequence 8ffdbba4 failed at call 808024d9 (err=-19)
>>>>       ### ERROR ### Please RESET the board ###
>>>> This error is also returned with usb0 as 'otg'.
>>> This error is at u-boot correct? This will need further investigation.
>>>
>>> Does it function correctly in Linux when kept as 'otg'?
>>>
>> This error is at u-boot level, indeed. I add Tom Rini to this thread, since he
>> was involved in the discussion here:
>> https://lore.kernel.org/all/20230621-fix_usb_ether_init-v2-0-ff121f0e8d7a@baylibre.com/
>> If dr_mode is set as 'peripheral' in '<board>-u-boot.dtsi' and kept as 'otg'
>> in linux, it functions correctly in linux.
> OK.
>
> So NAK for this patch series as we don't want to break 'otg' on Linux.
>
> u-boot doesn't support 'otg' mode. So we need to force it either to
> 'peripheral' or 'host'.
>
> One solution would be to have 'peripheral' in am335x-*-u-boot.dts?
>

OK. In other words, we just need to reconsider my previous u-boot series. :-)
I was setting usb0 as 'peripheral' in 'am335x-*-u-boot.dts' here:
https://lore.kernel.org/all/20230621-fix_usb_ether_init-v2-0-ff121f0e8d7a@baylibre.com/

Julien
