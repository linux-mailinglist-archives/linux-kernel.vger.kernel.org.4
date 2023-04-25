Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93E26EDDA4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 10:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbjDYIHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 04:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbjDYIHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 04:07:09 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18AD3AAA;
        Tue, 25 Apr 2023 01:07:05 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63d4595d60fso33690510b3a.0;
        Tue, 25 Apr 2023 01:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682410025; x=1685002025;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BjJjmGJHgsmevEHXxxC0Fcc1Z6Vq9hoaSZq1v6myiuU=;
        b=cr+CuWk3gIqJ1J/X9xHfW5vgZ5OzRYDALmI/7XoHXPgnRQND57oYi3yXHVFv4r8uBG
         nuJ8a0/pH5uFf3YNAN0mdV90PYEkip7usprgAaBzbR8Xoaov53Cqv+xXQCNrcVKnBVNs
         XnZiDeZCsxi+GTmoHXSILCQKxEkLs516QnTfl6au9buUEqPzpwi1UPrzJ5P4pbJU3iEM
         Vep1rwivZRRlJZTYWIGYM6Wt4KwHAyQg0FEfTs0EZ/yNGnqwrEmKVzXb07X2RO7axhVj
         kzI0b0RzcIVIOxVe8D8FTfW8r6XQHW8CmwOa7FxrfM8F+dkDGXnJ1OF/oRoLAWeknqzB
         /4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682410025; x=1685002025;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BjJjmGJHgsmevEHXxxC0Fcc1Z6Vq9hoaSZq1v6myiuU=;
        b=hHfH3AKa51CusxAbFhf+oNRwbyCNWSE2ptu37KcaobsKyvwSGl2orLAg01/Rkjm/GA
         ErfAMQzrsZ53fhkrDK8YDwlurrX33MyrY14L+P/WdOqsiCU+o/55LBCeDXhEFT+IBcSi
         5vJ9aB7xp36VZF5pczY4DDVSUf57iLTWrvcyAfPFXYR+WAO3CM3+J4LSn5W6T4+rKuM/
         wN6uK+4+wMQbTnVbYmmNh+S59ortlfjs0c9xFX6eNZhQOPFYJjx1gX6KneNB4o9biTC9
         3niD0/gG+XArMGxrJVRq76P/5ht9nbTJuMJDJuc1VAJh6opAnoKyhcJuy9hoQwFqIlYc
         qoPQ==
X-Gm-Message-State: AAQBX9d+VTgm3xsoJZ7pMmER0WftO3ndTAW8m8GdjZ42pnvrMv9c0s+3
        91cXe5/GTsd+J4L12umDGyHTPIP017Z2bA==
X-Google-Smtp-Source: AKy350bB8f4hiQ0km6TxbMIrwG2jg80ssgR28qrvp/alNZXYNx/TwhGPilKHOyfiu5GjPkjUFgXRqA==
X-Received: by 2002:a17:902:f98e:b0:1a6:b971:fae9 with SMTP id ky14-20020a170902f98e00b001a6b971fae9mr15147214plb.8.1682410025148;
        Tue, 25 Apr 2023 01:07:05 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902b70900b001a96d295f15sm3436740pls.284.2023.04.25.01.07.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 01:07:04 -0700 (PDT)
Message-ID: <49fe5ee3-3b82-f14f-60b6-ec14fe1f5663@gmail.com>
Date:   Tue, 25 Apr 2023 16:07:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v7 10/12] reset: Add Nuvoton ma35d1 reset driver support
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>, arnd@arndb.de,
        schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230412053824.106-1-ychuang570808@gmail.com>
 <20230412053824.106-11-ychuang570808@gmail.com>
 <20230424192137.GB30248@pengutronix.de>
 <4e1cd1c7-e681-fb25-1dcf-16d68e5e525b@gmail.com>
 <7f5fb515-a0a4-48fb-fdd5-247aff414d7d@linux.intel.com>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <7f5fb515-a0a4-48fb-fdd5-247aff414d7d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Ilpo,



On 2023/4/25 下午 03:40, Ilpo Järvinen wrote:
> On Tue, 25 Apr 2023, Jacky Huang wrote:
>
>>
>> On 2023/4/25 上午 03:21, Philipp Zabel wrote:
>>> Hi Jacky,
>>>
>>> On Wed, Apr 12, 2023 at 05:38:22AM +0000, Jacky Huang wrote:
>>>> From: Jacky Huang <ychuang3@nuvoton.com>
>>>>
>>>> This driver supports individual IP reset for ma35d1. The reset
>>>> control registers is a subset of system control registers.
>>>>
>>>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>>>> ---
>>>>
>>>> +static const struct {
>>>> +	unsigned long id;
>>> Why store the id? ids should be contiguous and should start at 0,
>>> so the id could just be an index into the array.
>> Thank you, I didn't notice that the IDs were already consecutive.
>> The id field is indeed unnecessary, and I will remove it.
> I recommend you still keep the IDs in the array initializer though, like
> this:
>
> ...
> } ma35d1_reset_map[] = {
> 	[MA35D1_RESET_CHIP] = {0x20, 0},
> 	[MA35D1_RESET_CA35CR0] = {0x20, 1},
> 	...

Okay, I will modify the code like this.

>>>> +	u32 reg_ofs;
>>>> +	u32 bit;
>>>> +} ma35d1_reset_map[] = {
>>>> +	{ MA35D1_RESET_CHIP,    0x20, 0  },
>>>> +	{ MA35D1_RESET_CA35CR0,	0x20, 1  },
>>>> +	{ MA35D1_RESET_CA35CR1, 0x20, 2  },
>>>> +	{ MA35D1_RESET_CM4,     0x20, 3  },
>>>> +	{ MA35D1_RESET_PDMA0,   0x20, 4  },
>>>> +	{ MA35D1_RESET_PDMA1,   0x20, 5  },
>>>> +	{ MA35D1_RESET_PDMA2,   0x20, 6  },
>>>> +	{ MA35D1_RESET_PDMA3,   0x20, 7  },
>>>> +	{ MA35D1_RESET_DISP,    0x20, 9  },
>>>> +	{ MA35D1_RESET_VCAP0,   0x20, 10 },
>>>> +	{ MA35D1_RESET_VCAP1,   0x20, 11 },
>>>> +	{ MA35D1_RESET_GFX,     0x20, 12 },
>>>> +	{ MA35D1_RESET_VDEC,    0x20, 13 },
>>>> +	{ MA35D1_RESET_WHC0,    0x20, 14 },
>>>> +	{ MA35D1_RESET_WHC1,    0x20, 15 },
>>>> +	{ MA35D1_RESET_GMAC0,   0x20, 16 },
>>>> +	{ MA35D1_RESET_GMAC1,   0x20, 17 },
>>>> +	{ MA35D1_RESET_HWSEM,   0x20, 18 },
>>>> +	{ MA35D1_RESET_EBI,     0x20, 19 },
>>>> +	{ MA35D1_RESET_HSUSBH0, 0x20, 20 },
>>>> +	{ MA35D1_RESET_HSUSBH1, 0x20, 21 },
>>>> +	{ MA35D1_RESET_HSUSBD,  0x20, 22 },
>>>> +	{ MA35D1_RESET_USBHL,   0x20, 23 },
>>>> +	{ MA35D1_RESET_SDH0,    0x20, 24 },
>>>> +	{ MA35D1_RESET_SDH1,    0x20, 25 },
>>>> +	{ MA35D1_RESET_NAND,    0x20, 26 },
>>>> +	{ MA35D1_RESET_GPIO,    0x20, 27 },
>>>> +	{ MA35D1_RESET_MCTLP,   0x20, 28 },
>>>> +	{ MA35D1_RESET_MCTLC,   0x20, 29 },
>>>> +	{ MA35D1_RESET_DDRPUB,  0x20, 30 },
>>>> +	{ MA35D1_RESET_TMR0,    0x24, 2  },
>>>> +	{ MA35D1_RESET_TMR1,    0x24, 3  },
>>>> +	{ MA35D1_RESET_TMR2,    0x24, 4  },
>>>> +	{ MA35D1_RESET_TMR3,    0x24, 5  },
>>>> +	{ MA35D1_RESET_I2C0,    0x24, 8  },
>>>> +	{ MA35D1_RESET_I2C1,    0x24, 9  },
>>>> +	{ MA35D1_RESET_I2C2,    0x24, 10 },
>>>> +	{ MA35D1_RESET_I2C3,    0x24, 11 },
>>>> +	{ MA35D1_RESET_QSPI0,   0x24, 12 },
>>>> +	{ MA35D1_RESET_SPI0,    0x24, 13 },
>>>> +	{ MA35D1_RESET_SPI1,    0x24, 14 },
>>>> +	{ MA35D1_RESET_SPI2,    0x24, 15 },
>>>> +	{ MA35D1_RESET_UART0,   0x24, 16 },
>>>> +	{ MA35D1_RESET_UART1,   0x24, 17 },
>>>> +	{ MA35D1_RESET_UART2,   0x24, 18 },
>>>> +	{ MA35D1_RESET_UAER3,   0x24, 19 },
>>>> +	{ MA35D1_RESET_UART4,   0x24, 20 },
>>>> +	{ MA35D1_RESET_UART5,   0x24, 21 },
>>>> +	{ MA35D1_RESET_UART6,   0x24, 22 },
>>>> +	{ MA35D1_RESET_UART7,   0x24, 23 },
>>>> +	{ MA35D1_RESET_CANFD0,  0x24, 24 },
>>>> +	{ MA35D1_RESET_CANFD1,  0x24, 25 },
>>>> +	{ MA35D1_RESET_EADC0,   0x24, 28 },
>>>> +	{ MA35D1_RESET_I2S0,    0x24, 29 },
>>>> +	{ MA35D1_RESET_SC0,     0x28, 0  },
>>>> +	{ MA35D1_RESET_SC1,     0x28, 1  },
>>>> +	{ MA35D1_RESET_QSPI1,   0x28, 4  },
>>>> +	{ MA35D1_RESET_SPI3,    0x28, 6  },
>>>> +	{ MA35D1_RESET_EPWM0,   0x28, 16 },
>>>> +	{ MA35D1_RESET_EPWM1,   0x28, 17 },
>>>> +	{ MA35D1_RESET_QEI0,    0x28, 22 },
>>>> +	{ MA35D1_RESET_QEI1,    0x28, 23 },
>>>> +	{ MA35D1_RESET_ECAP0,   0x28, 26 },
>>>> +	{ MA35D1_RESET_ECAP1,   0x28, 27 },
>>>> +	{ MA35D1_RESET_CANFD2,  0x28, 28 },
>>>> +	{ MA35D1_RESET_ADC0,    0x28, 31 },
>>>> +	{ MA35D1_RESET_TMR4,    0x2C, 0  },
>>>> +	{ MA35D1_RESET_TMR5,    0x2C, 1  },
>>>> +	{ MA35D1_RESET_TMR6,    0x2C, 2  },
>>>> +	{ MA35D1_RESET_TMR7,    0x2C, 3  },
>>>> +	{ MA35D1_RESET_TMR8,    0x2C, 4  },
>>>> +	{ MA35D1_RESET_TMR9,    0x2C, 5  },
>>>> +	{ MA35D1_RESET_TMR10,   0x2C, 6  },
>>>> +	{ MA35D1_RESET_TMR11,   0x2C, 7  },
>>>> +	{ MA35D1_RESET_UART8,   0x2C, 8  },
>>>> +	{ MA35D1_RESET_UART9,   0x2C, 9  },
>>>> +	{ MA35D1_RESET_UART10,  0x2C, 10 },
>>>> +	{ MA35D1_RESET_UART11,  0x2C, 11 },
>>>> +	{ MA35D1_RESET_UART12,  0x2C, 12 },
>>>> +	{ MA35D1_RESET_UART13,  0x2C, 13 },
>>>> +	{ MA35D1_RESET_UART14,  0x2C, 14 },
>>>> +	{ MA35D1_RESET_UART15,  0x2C, 15 },
>>>> +	{ MA35D1_RESET_UART16,  0x2C, 16 },
>>>> +	{ MA35D1_RESET_I2S1,    0x2C, 17 },
>>>> +	{ MA35D1_RESET_I2C4,    0x2C, 18 },
>>>> +	{ MA35D1_RESET_I2C5,    0x2C, 19 },
>>>> +	{ MA35D1_RESET_EPWM2,   0x2C, 20 },
>>>> +	{ MA35D1_RESET_ECAP2,   0x2C, 21 },
>>>> +	{ MA35D1_RESET_QEI2,    0x2C, 22 },
>>>> +	{ MA35D1_RESET_CANFD3,  0x2C, 23 },
>>>> +	{ MA35D1_RESET_KPI,     0x2C, 24 },
>>>> +	{ MA35D1_RESET_GIC,     0x2C, 28 },
>>>> +	{ MA35D1_RESET_SSMCC,   0x2C, 30 },
>>>> +	{ MA35D1_RESET_SSPCC,   0x2C, 31 }
>>>> +};
Best Regards,
Jacky Huang

