Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4146C1A23
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjCTPr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbjCTPri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:47:38 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DB2C64B;
        Mon, 20 Mar 2023 08:39:04 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id j3-20020a17090adc8300b0023d09aea4a6so16913052pjv.5;
        Mon, 20 Mar 2023 08:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679326743;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gE0cE5gTx1TulJ/p8gXBQMe9jpH4tyJlUCYbcVwZyoc=;
        b=CimXe3p7Be6lTDyAxAZ4RGXdGxAy4tKPJeew/tWaCvgppYwwCmMx3YCmnQ6iBC+RCa
         VAYwZ7/Am+WUNP5/np4L7IbSMCVyEhv3UqsQGrc/ltMdx06Qktf2Ob5S724mz13BIe7d
         CNb2UvBOjQLmtr8OISD8o10qup+9dKJLZXprCFQ2vovnRe6CTl2jO+aLLWtJYbZ9m54u
         kpFpuNB09yNvCwTccJm3FR05zaMbPoxN3fho6P0azb7LbTiJmlJTiphpo3v/XUec7Lzs
         QB3yxNjH0NYSbgrkbCSgF1Cf/Ztr0aSmqZftisUndLstR8074ak31iElXUC4Kq/T+xtq
         UtQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679326743;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gE0cE5gTx1TulJ/p8gXBQMe9jpH4tyJlUCYbcVwZyoc=;
        b=NgjC3NFxhAG1AIq+ABkjgTX9/4u7SIAVnOQpEb/MR63Es60+N+CoF2BpTg0O886M7b
         GI7Ghj0O0ZUB7htfHe9bba92EJyDEAzrF+JCz9boAlx3FtcTU+zx9Wu6uwrkWXmzKj1H
         ePwseYJxbu1UhpUq3XSTI0qxCKQveIF9JYrDfK62fySV2a3Nw1reeAKwR8NWiHgdqhEP
         0uSVCHQPv8K7MKL+EkE+CkiMdNGYv5V5x0IiAyGS9CYemMM3FT3PeMlEMVs3gAcEPIuG
         sZcfSgirgDIFIy+sUX3v2xpfLxGXnkR0QddvKGjtIVdCSDtoZpX6DomvsbMvLg0b6iPv
         3MOQ==
X-Gm-Message-State: AO0yUKU4+6LwduWYweo+cKorYfYOfzjGEmhw6YPvDYLMI8oN908fURRJ
        ntIPCOSsLQVtDLOpVVjHfWU=
X-Google-Smtp-Source: AK7set+HgBorRFvv0+hZ8QWB1uWn6efvYd2XrJpvIiCVC+B1A5KY6U4FPYUYrqBDSiLEgqx6KkdbIA==
X-Received: by 2002:a17:903:138c:b0:1a1:918e:4129 with SMTP id jx12-20020a170903138c00b001a1918e4129mr15972090plb.30.1679326743362;
        Mon, 20 Mar 2023 08:39:03 -0700 (PDT)
Received: from [192.168.1.101] (1-160-164-133.dynamic-ip.hinet.net. [1.160.164.133])
        by smtp.gmail.com with ESMTPSA id jj2-20020a170903048200b0019fea4bb887sm6923879plb.157.2023.03.20.08.39.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 08:39:03 -0700 (PDT)
Message-ID: <13b4ac3c-d650-c646-b76f-3de69946d321@gmail.com>
Date:   Mon, 20 Mar 2023 23:38:59 +0800
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
 <7cc8258c-3a77-5387-aaa4-658761fbb0ae@gmail.com>
 <12298b67-3012-4902-9dcc-61c3c9907a47@app.fastmail.com>
Content-Language: en-US
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <12298b67-3012-4902-9dcc-61c3c9907a47@app.fastmail.com>
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


On 2023/3/18 下午 10:04, Arnd Bergmann wrote:
> On Sat, Mar 18, 2023, at 14:17, Jacky Huang wrote:
>> On 2023/3/16 下午 10:17, Arnd Bergmann wrote:
>>> On Wed, Mar 15, 2023, at 08:28, Jacky Huang wrote:
>>>> +	mem: memory@80000000 {
>>>> +		device_type = "memory";
>>>> +		reg = <0x00000000 0x80000000 0 0x20000000>; /* 512M DRAM */
>>>> +	};
>>>> +};
>>> In most machines, the memory size is detected by the boot loader
>>> and filled in the dtb in memory before starting the kernel, so
>>> you should not need two separate files here for the two common
>>> memory configurations.
>>
>> On ma35d1, memory size is determined early before uboot.
>>
>> BL1 (MaskROM boot code) -> BL2 (arm-trust-firmware) -> BL32 (op-tee) &
>> BL33 (uboot).
>> The DDR was initialized in BL2 stage with a selected DDR setting, which
>> is hard coded, including DDR size.
>>
>> We searched the arm64 dts and found that almost all vendors claimed
>> memory size in board level dtsi/dts. This seems to be common.
>>
>> So, can we have it unchanged?
> I see the memory size encoded in about one out of three .dts files,
> which is more than I expected. It's clearly not harmful to have it
> listed in the dts, it just shouldn't be necessary.
>
> If it helps you with your current u-boot, then leave it in, but
> consider adding detection logic into u-boot so it can override
> the value in the dtb file at boot time.


Thank you for your understanding. As more drivers are added, I think 
this memory

size encoded will look less conspicuous. In fact, in the previous arm9 
project, we

did detect the memory size by uboot, and then passed it to the kernel. 
If there is

a need in the future, we will consider to support it in ma35d1.

>>> Since the machine is called 'som', I would assume that this is a
>>> module that is integrated on another board, so more commonly one
>>> would have a dtsi file for the som in addition to the one for the
>>> soc, and have all the components of the module listed in this
>>> file, while the dts file that includes the som.dtsi lists the
>>> devices on the carrier board and enables the on-chip devices
>>> that are connected to the outside.
>>>
>> You are right, ma35d1 som have a base board, and a cpu board on it.
>>
>> It is a good suggestion that we should have a dtsi for som base board.
>>
>> Consider that we are in the initial submit, and such a dtsi will be an empty
>> file at this stage. So, I would like to do it when peripheral drivers
>> upstream started. Is it ok?
> It's not a big deal either way. I if you want to keep it only with
> one dts file and one dtsi file, that's fine, but maybe rename the dts
> file based on the name of the carrier rather than the SoM in this
> case.
>
>       Arnd


Thank you. As the dts names are consistent with the ma35d1 BSP on 
linux-5.10.y,

we would like to keep the consistence still.


Best regards,

Jacky Huang


