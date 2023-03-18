Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADBD6BFA33
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 14:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjCRNRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 09:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCRNRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 09:17:45 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FA43A856;
        Sat, 18 Mar 2023 06:17:44 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id bc12so7376428plb.0;
        Sat, 18 Mar 2023 06:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679145463;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f+COqB4c+m/g6jmv7auDfhMOskvwOSpXxEk7kJ344Qs=;
        b=ptqIX8JS1BjvbCWXL88KHqmofUWW0MuFFaMWbrsHj8tBEoTuj/O9Ki65CXHqBv3uIv
         bf/TQyC4745awZJXlbK9rgt+oXk3KhnVr5OQaEDNsnhnYbeA94iOFmuE/1jGAnwavVuO
         g7E3Ra49aFBpBsvQUIke+Yl7JtdysIdGE6e2AIeEJvgbLObE0ziJ0qFnNEtjeAOjBTeC
         FYNo8WgkMiA8OSZvs3VMavV7ghEHuh+jG9ohWUoscHDIInVTqWxoIXLSi0YOBcDIJA+A
         yPG9+BpJ8vVtv4VFSj64v4kbxUQrW5EPQaC4jAF2QQVNXH3ryDxGLo2O+3rhIp/fhzpj
         6MTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679145463;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f+COqB4c+m/g6jmv7auDfhMOskvwOSpXxEk7kJ344Qs=;
        b=VsRgLlo8OkQs9jucisZXscta0vbYI/gYcSoYVHDIBWqwo9V+fQJdHBQ92a+kWxrWJQ
         J8c+UK6y5KWfYaozqHXy4Ii8hDPhPcblKM9HMuaXONkiUNsCqQZheSB0SyxpLGdV8Atm
         FY9jjfLx9FkdI2BsQmxxO9bntKhJHEgc2qP7N4rHftdaAOqBXuxcYwJ7UORCGRQcjBve
         Fs3hDJGN/KDU7TQvQi7EkqtdJo91wu+RzbPyUSYNJvXKUgHxuKlOM/HfmuHai4RgZIVi
         Fu8Nm0nxuWqTZjsgrByjIcEoBxElhm5WLCyc9aM4SLnxq7TYwsJ0om0hX5QLmXqON5zZ
         1FmQ==
X-Gm-Message-State: AO0yUKXaeJVLpYGwHGtTuUcGuQepGf4bIW7rB4SGbPAePOlmzYoHjIHz
        B3PxH1zBAhDaKixdyWXghQU=
X-Google-Smtp-Source: AK7set+B+p8x/wM/YFN9CWjDxTme8ZHWkbPrzeueh4qZtgOfVZKGg9ufoHqwDnq09mTi4nXnskNWxw==
X-Received: by 2002:a17:902:e54e:b0:1a0:42c0:b2a5 with SMTP id n14-20020a170902e54e00b001a042c0b2a5mr12315471plf.24.1679145463445;
        Sat, 18 Mar 2023 06:17:43 -0700 (PDT)
Received: from [192.168.1.101] (1-160-164-133.dynamic-ip.hinet.net. [1.160.164.133])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b00199193e5ea1sm3286293plx.61.2023.03.18.06.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Mar 2023 06:17:43 -0700 (PDT)
Message-ID: <7cc8258c-3a77-5387-aaa4-658761fbb0ae@gmail.com>
Date:   Sat, 18 Mar 2023 21:17:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 11/15] arm64: dts: nuvoton: Add initial ma35d1 device tree
To:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
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
 <20230315072902.9298-12-ychuang570808@gmail.com>
 <2063c6d1-85ed-43d9-b572-a762b6ce18c1@app.fastmail.com>
Content-Language: en-US
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <2063c6d1-85ed-43d9-b572-a762b6ce18c1@app.fastmail.com>
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

Dear Arnd,


Thanks for your suggestion.


On 2023/3/16 下午 10:17, Arnd Bergmann wrote:
> On Wed, Mar 15, 2023, at 08:28, Jacky Huang wrote:
>> +	mem: memory@80000000 {
>> +		device_type = "memory";
>> +		reg = <0x00000000 0x80000000 0 0x20000000>; /* 512M DRAM */
>> +	};
>> +};
> In most machines, the memory size is detected by the boot loader
> and filled in the dtb in memory before starting the kernel, so
> you should not need two separate files here for the two common
> memory configurations.


On ma35d1, memory size is determined early before uboot.

BL1 (MaskROM boot code) -> BL2 (arm-trust-firmware) -> BL32 (op-tee) & 
BL33 (uboot).

The DDR was initialized in BL2 stage with a selected DDR setting, which

is hard coded, including DDR size.

We searched the arm64 dts and found that almost all vendors claimed

memory size in board level dtsi/dts. This seems to be common.

So, can we have it unchanged?


> Since the machine is called 'som', I would assume that this is a
> module that is integrated on another board, so more commonly one
> would have a dtsi file for the som in addition to the one for the
> soc, and have all the components of the module listed in this
> file, while the dts file that includes the som.dtsi lists the
> devices on the carrier board and enables the on-chip devices
> that are connected to the outside.
>
>         Arnd


You are right, ma35d1 som have a base board, and a cpu board on it.

It is a good suggestion that we should have a dtsi for som base board.

Consider that we are in the initial submit, and such a dtsi will be an empty

file at this stage. So, I would like to do it when peripheral drivers

upstream started. Is it ok?


Best  regards,

Jacky Huang


