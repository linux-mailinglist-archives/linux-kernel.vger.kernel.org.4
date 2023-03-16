Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612156BC578
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 06:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjCPFH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 01:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCPFH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 01:07:56 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E0E2B9DD;
        Wed, 15 Mar 2023 22:07:55 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id h5so378662ile.13;
        Wed, 15 Mar 2023 22:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678943274;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5FY1OYYemRIJbRGg0Hnj2EHjgKI4BX1UotO3CIZiLw8=;
        b=Av9Dc4DJhI/DzOfbFHuVe6V7/fnyJy2S5X50bEFzu9nTTtcckTPY+7GpdKHZin8uKU
         J92Of9Q4wpXdbGPwlImxuHqiB4h0Jp8MIwVtpIhLvgK8H3A9F8HGG+b7rT7jopkOcsDt
         h+We2bxJBu9qr/v0r59XGkuSHZg0MeOm7eh1odoOhRjDsbw+uY5ItYRUiTABwoUNmBCp
         WBB1Np4RtRPpGyuhVFT0PCQpTrD4Z6U1/lGEfxrFXPz4vhA5qdUHKktDXwqxQz52XVg+
         oyvFTKQlA0VaTraphx1ckIPdJuhyCSi96EzroxuNewAqox3/UoaHWMqq5vXJJApTB39Z
         MwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678943274;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5FY1OYYemRIJbRGg0Hnj2EHjgKI4BX1UotO3CIZiLw8=;
        b=hzntUjTNrZ7k9+UZdP91ZsCvzzRpRuKHU8EUSpnlPEZNfPuuLUgFgX3cjExCETOZdp
         Sj5qy4zQavWDXh5HE9yRJjnUfOkZ/3Gvk2vjuWAlTPfWWwfGgfNU2wXD2I1+cC4vg7rJ
         42MB/Uenb3bxC16Iy3oQpXRUFe+dsiekQaDYs21vUbpIuJx3+NrU1zsxrDah7XxbJBNY
         BdY4BaaPApWPO50cAMvqL6BuSoTg78MAuPh4yzgc29U/xUlMUaydT7RNulPfPrQr1h3u
         pr02GXq1wbWsmyXJ9hEi3OOWFYlk4kDsJ+rD0PWnevLd29l3/avuAq6stbwY48DrkWew
         woNg==
X-Gm-Message-State: AO0yUKV325y1I6sPOymEPWbj0axAzcfa2Zbj01Php1407DcmFUoehpXZ
        ydoOYiAX5OQrfktaEI7YBGbyGu5CpfI=
X-Google-Smtp-Source: AK7set8554oyIEybJRqZ9YhBi7nBFauEPGjMaPl9VYKZvaRQMIpR3kzowK5pndZhUNdfmt/AetDnVg==
X-Received: by 2002:a05:6e02:108f:b0:316:e457:489 with SMTP id r15-20020a056e02108f00b00316e4570489mr5591131ilj.32.1678943274471;
        Wed, 15 Mar 2023 22:07:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y22-20020a02bb16000000b003fd73ca55c4sm2228600jan.91.2023.03.15.22.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 22:07:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5c805125-4cb5-cdf8-6b50-5a6ce7e97149@roeck-us.net>
Date:   Wed, 15 Mar 2023 22:07:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Phinex Hung <phinex@realtek.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>
Cc:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230315121606.GA71707@threadripper>
 <8dbed631-62b6-1802-8f4e-7141b1a91a56@roeck-us.net>
 <D23B9D06-0DEA-4E3B-A64C-C928CAF2FEF8@realtek.com>
 <aaf0553c-48de-580f-70d5-aafeecb19e16@roeck-us.net>
 <1E8784A0-713E-41A8-A26D-72869E3E5779@realtek.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1] hwmon: drivetemp: support to be a platform driver for
 thermal_of
In-Reply-To: <1E8784A0-713E-41A8-A26D-72869E3E5779@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/23 20:29, Phinex Hung wrote:
> 
> On 3/16/23 11:02, Guenter Roeck" <groeck7@gmail.com <mailto:groeck7@gmail.com> <mailto:groeck7@gmail.com <mailto:groeck7@gmail.com>> wrote:
> 
> ﻿
>> Sure. But your argument is inappropriate: You could as well argue that
>> this system with a single fan should bundle all its thermal sensors into
>> a single thermal zone, and that it should do so in the driver(s)
>> providing the thermal zone sensors to the thermal subsystem. This does
>> not take into account that there might be systems with dozens (or hundreds,
>> for that matter) of drives, in a system with multiple disk trays and fans
>> for each of those.
> 
>> I don't know if and how the thermal subsystem deals with the situation
>> of having N thermal zone sensors and M << N cooling devices. This is
>> a general problem, not limited to disk drives. Just as we won't bundle
>> multiple thermal sensors on a multi-channel thermal sensor chip into a
>> single thermal zone, we won't bundle multiple disk drives into a single
>> thermal zone.
> 
> It's true, there are several different combinations.
> 
> Keep a single sensor with a single thermal might give more flexibility.
> 
> My idea is inspired from the comment of the following patch..
> 
> https://www.spinics.net/lists/devicetree/msg537186.html
> 
> By the comment in this patch, it said that "Thermal zone works only with first disks".
> 
> But it has two hard disk, each describes a thermal-sensors-cells.
> 
>   /* Thermal zone works only with first disk */.
> 
> That is why I am trying to hack the original temp_read call back to support multiple sensors.
> 
> Anyway, keep a single mapping might be good and thanks for your comment.
> 
> 
>> In theory it should work just like described in the kirkwood devicetree
>> files. If that doesn't work, the question is how to find the sata port
>> nodes from the drivetemp driver. I don't have a system with such nodes,
>> so I have no means to find or know the answer.
> 
> 
>> I also don't know how to attach more than one thermal sensor to a
>> single thermal zone, or if that is even possible. If it isn't, it
>> is a limitation of the thermal subsystem, and trying to hack around
>> it in a driver providing thermal sensors would be inappropriate.
> 
> 
> Thank you for this great module to make thermal and cooling control simpler.
> 
> That is why I am trying to get it work under our kernel 4.19 since our SoC currently works under 4.19 only.
> 
> Sata ports can be found without any issue, and the corresponding hwmon entries can be found, such as.
> 
> root@OpenWRT-Kylin:/sys/class/hwmon# ls -al
> total 0
> drwxr-xr-x    2 root     root             0 Mar 11 08:13 .
> drwxr-xr-x   42 root     root             0 Mar 11 08:13 ..
> lrwxrwxrwx    1 root     root             0 Mar 11 08:13 hwmon0 -> ../../devices/platform/soc/98000000.bus/9801b000.syscon/9801bc00.rtk_fan/hwmon/hwmon0
> lrwxrwxrwx    1 root     root             0 Mar 11 08:13 hwmon1 -> ../../devices/platform/soc/98000000.bus/9803f000.sata/ata1/host0/target0:0:0/0:0:0:0/hwmon/hwmon1
> lrwxrwxrwx    1 root     root             0 Mar 11 08:13 hwmon2 -> ../../devices/platform/soc/98000000.bus/9803f000.sata/ata2/host1/target1:0:0/1:0:0:0/hwmon/hwmon2
> 
> And I add the port number in the name of these hwmon devices so that I can differentiate them.
> 
> root@OpenWRT-Kylin:/sys/class/hwmon# cat hwmon1/name hwmon1/temp1_input
> drivetemp_port0
> 52000
> root@OpenWRT-Kylin:/sys/class/hwmon# cat hwmon2/name hwmon2/temp1_input
> drivetemp_port1
> 49000
> 
> My initial problem is that "how could I associated these hwmon devices with thermal zones"?
> 
> By tracing the source code, finding that I probably need to register thermal_zone using a platform device.
> 

Wrong conclusion. You have (or should have) devicetree node(s) such as

         sata: sata@80000 {
                 compatible = "marvell,orion-sata";
                 reg = <0x80000 0x5000>;
                 interrupts = <21>;
                 clocks = <&gate_clk 14>, <&gate_clk 15>;
                 clock-names = "0", "1";
                 phys = <&sata_phy0>, <&sata_phy1>;
                 phy-names = "port0", "port1";
                 status = "disabled";
         };

Those nodes should have devices associated with them (in this case instantiated
by drivers/ata/sata_mv.c). At the same time, the drivetemp driver callback
(drivetemp_add) gets called with a device pointer as parameter. The question
is how to get from the device pointer passed to drivetemp_add() to the device
created by the sata_mv driver. Is it dev ? or dev->parent ? Or dev->parent->parent ?
The devicetree node associated with that device is the one which should be used
to set the hwmon device devicetree node. Essentially you'll have to find out where
in the device list to find the of_node pointing to the above sata node. Then we
can discuss how to make that node available to the thermal subsystem.

Guenter

