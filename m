Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858D4745BBD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 13:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjGCL47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 07:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjGCL45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 07:56:57 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E749A115
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 04:56:55 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbc54caad5so37152775e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 04:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1688385414; x=1690977414;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TTq4B8VQydiZBj9HRWXj7S7KM5zH7YsDOhpU1L0DXi4=;
        b=IEoMrr0Ski5D2vzSr0VAQh5kNAU7257QhAft+YiErVJ9WunpDECW4kav+qfqa8TdBa
         4aYSZt67yCoGIiwL3OjCOL6XhnPsCV3PX/xyTGlfJ7SNEaHXKnGhmfwUNd/wR6fo1+7n
         L63xfGVlUeJ6DclBLXgIleEWkuHNM9AJiFT7L+eOhFSZ8WB00mw3mqGfOBNAcb2OK8YP
         VxmbHN3b3oBnK8G2byqiO7Hcw8tzsNHqFpYjAR8Ghw5EuiYILv5ndcnVD6XcdtS4iZaf
         nv5qddQ/PUEtu9PGxgYDGMcANb7Z4OLAR5VKtmL7E7+MbG0/CcuXG9ZRj/yWTwZJHRkf
         +Giw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688385414; x=1690977414;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TTq4B8VQydiZBj9HRWXj7S7KM5zH7YsDOhpU1L0DXi4=;
        b=MYxAjE9RskwpJbo8zT08C7dHlo/Weglsv70DQVVbb5tGasEivZtq8ACAb/E+yN4n9R
         0c1e0NCCQQl+N00PeOQ5LAuWxa3dD/Wvk6ix9RranwijXL0HgidrdqlKxDH5OKivKPLg
         MgiYB7752XufbqscKVxK6VKyz6NRfJsYxkPUyGhpPw7MPHuRTPQPYXXubCw4Egj5AAyu
         PQ4yS5My1Ti6cMfuEa/qmPsKTkdMsK+S7+lQhYBX4qkBL1fVBpG139uAUlVEayPdWULE
         Jp7kbi/G5WVd6PTpcby8+VvnXY/XKsNZtl8eH85tm5JchRYEeDIBp1ia7nGJaIMXAff7
         cSKw==
X-Gm-Message-State: AC+VfDxSWgpKfzArJngVxi44SUdweb5QxBxllnY+JqyXGdgYOmmvvImg
        SH12bS6T1BKJaSVW35kHJBRTow==
X-Google-Smtp-Source: ACHHUZ5CW2k7JvgHdwNLhg2i8HEeB/5xPMDUQZX5RoLenIKDPWRe8KP9Flewwh8BRzeQh9yYMTS06Q==
X-Received: by 2002:a05:600c:3787:b0:3fb:ac73:f7d9 with SMTP id o7-20020a05600c378700b003fbac73f7d9mr7607357wmr.32.1688385414262;
        Mon, 03 Jul 2023 04:56:54 -0700 (PDT)
Received: from [192.168.35.121] ([77.205.22.13])
        by smtp.gmail.com with ESMTPSA id n24-20020a7bcbd8000000b003fbca05faa9sm8198120wmi.24.2023.07.03.04.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 04:56:53 -0700 (PDT)
Message-ID: <babf5f20-ddf4-74bf-1788-f8e356acaa92@baylibre.com>
Date:   Mon, 3 Jul 2023 13:56:52 +0200
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
        vigneshr@ti.com, nm@ti.com
References: <20230629-usb0-as-peripheral-v1-0-167f78a11746@baylibre.com>
 <20230630072047.GK14287@atomide.com>
 <f4fa80fd-1a6a-4718-0287-f5288cd9d912@baylibre.com>
 <7f44798b-e2bf-1620-da37-ca13bfd07a21@kernel.org>
From:   Julien Panis <jpanis@baylibre.com>
In-Reply-To: <7f44798b-e2bf-1620-da37-ca13bfd07a21@kernel.org>
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

On 6/30/23 21:40, Roger Quadros wrote:
> Hi,
>
> On 30/06/2023 11:30, Julien Panis wrote:
>> Hello Tony,
>>
>> On 6/30/23 09:20, Tony Lindgren wrote:
>>> Hi,
>>>
>>> * Julien Panis <jpanis@baylibre.com> [230629 13:10]:
>>>> This series configures usb0 dr_mode as 'peripheral' for am335x-evm,
>>>> am335x-evmsk, and am335x-icev2. This USB port is mainly used for
>>>> RNDIS and DFU.
>>> Is this a mini-B connector? Just wondering if it was originally attempted
>>> to be configured as OTG or how it ended up with a host configuration..
>> It's a micro USB-AB connector.
>> I don't know how it ended up with a host configuration, it looks like an oversight.
>> Maybe Vignesh or Nishanth can confirm (?)
> usb0 role should be "otg".
> It is rightly so in Linux DT. am33xx.dtsi contains "otg" and all AM335x board files inherit from it.
>
> So I don't think setting it to "peripheral" in u-boot is the right thing to do.

This series is for kernel (not for u-boot).
Why is it a problem to set usb0 as 'peripheral' in kernel for the 3 board dts ?

With usb0 not set as 'peripheral', the 3 boards (am335x-evm, evm-sk, icev2)
do not boot with uboot 2023.04. This error is returned, with LOG_LEVEL=5:
     No USB device found
     USB ether init failed
     initcall sequence 8ffdbba4 failed at call 808024d9 (err=-19)
     ### ERROR ### Please RESET the board ###
This error is also returned with usb0 as 'otg'.

Julien Panis
