Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533DE6FD388
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 03:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbjEJB1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 21:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjEJB1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 21:27:01 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED1E26BD;
        Tue,  9 May 2023 18:26:59 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6435bbedb4fso7159750b3a.3;
        Tue, 09 May 2023 18:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683682019; x=1686274019;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eEArS+kabsb+fSj/X6VQ7ACodsIFNt5JLcPXN1+j86M=;
        b=AMofmhhQxuI+/Ta/xu+zM0kGDlwMOD4fuf2FL646bvCis5kncCEXK8AT4f5ZvuIwqk
         oCroTcsYRu4Du+YQSHP/YrGptUN63h3JJlXOmukQUQjqZ18bttEnvW3se533CBAdszr5
         TyQrYfkrgOb0Y7TbM60svXzh12GzV8LyS9IAw9VqU3ka5vrDQs9bMxWdJeMka4CzntIS
         8C3ymzUXGRk7wa3sxNsMbSOhfiOiv0tuDEx2sIHTMRsTk9zb+N8cNXIyjvbiEv0lWp+e
         rVdSpXKKNO1RCfGPs5deb/tGsUynv+DjfJMF2XPrRhzrLQ+WmB3QJ+3tFP9sxKuABk+f
         Y+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683682019; x=1686274019;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eEArS+kabsb+fSj/X6VQ7ACodsIFNt5JLcPXN1+j86M=;
        b=ZDWxV1sQcuJKiGnf1P5b4EjMBw3jx7TnP2MldZKudWShSoCXfQh0Oh5EGpi/rWmM36
         JIVeVJvmkoq2EJY828GvAigsG/aeK2svSe21tEK4VlIpgS6qjGmtxAelqas6EKmS+qiX
         WFVODWfuz8q01VgUU4+7fC1AzYP0Ru3s+EkFeP4RD+iqXRKst9p+D/cOJ/QIvZ6RBeL1
         BoUZm57eIpT8O01qMsnQ/ODLq7w5i9+0ujcRJ6LTBqm0VjdWfS056gQwS54xEAEJ1Zqu
         GSSYJF89AJOCPNFtNbAhs841WvaJeAY/FuIUpSVlHCHEsZSkweKNKUs72IWGy1v25xtL
         dp/w==
X-Gm-Message-State: AC+VfDw2OsKG+p7KjE5eaKP8iuIzxgMVkpxGBLyRjr0R2Sgb14ugUVJi
        ydK4r+ZVGeg+JccnyykUdcA=
X-Google-Smtp-Source: ACHHUZ7Fe4IYlb9nVqD1imy2o9VmsAZXxyb26u3Hau9eW97be7LwC+3ZfqjpjiWPm4YHL9LsNN9IVA==
X-Received: by 2002:a05:6a20:1608:b0:f2:c2a3:3a1 with SMTP id l8-20020a056a20160800b000f2c2a303a1mr20395456pzj.43.1683682018908;
        Tue, 09 May 2023 18:26:58 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id a16-20020a62e210000000b006439df7ed5fsm2426977pfi.6.2023.05.09.18.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 18:26:58 -0700 (PDT)
Message-ID: <6bee2314-043d-e1af-016b-779df88f1868@gmail.com>
Date:   Wed, 10 May 2023 09:26:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v10 10/10] tty: serial: Add Nuvoton ma35d1 serial driver
 support
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, Lee Jones <lee@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-serial <linux-serial@vger.kernel.org>, schung@nuvoton.com,
        mjchen@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230508025936.36776-1-ychuang570808@gmail.com>
 <20230508025936.36776-11-ychuang570808@gmail.com>
 <2ba483e9-267f-2159-1ea8-75a2618fcdf9@linux.intel.com>
 <eeeaf258-8f2b-436a-aba0-b32dc90b359f@app.fastmail.com>
 <b9573562-d4d7-3535-fb4d-f2bc694f2a4@linux.intel.com>
 <72983689-0e98-4482-b549-ba2530274943@app.fastmail.com>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <72983689-0e98-4482-b549-ba2530274943@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Arnd and Ilpo,


Thank you for the comments.


On 2023/5/9 下午 08:32, Arnd Bergmann wrote:
> On Tue, May 9, 2023, at 14:25, Ilpo Järvinen wrote:
>> On Tue, 9 May 2023, Arnd Bergmann wrote:
>>> On Tue, May 9, 2023, at 12:17, Ilpo Järvinen wrote:
>>>> On Mon, 8 May 2023, Jacky Huang wrote:
>>>>> +
>>>>> +#define UART_NR			17
>>>>> +
>>>>> +#define UART_REG_RBR		0x00
>>>>> +#define UART_REG_THR		0x00
>>>>> +#define UART_REG_IER		0x04
>>>>> +#define UART_REG_FCR		0x08
>>>>> +#define UART_REG_LCR		0x0C
>>>>> +#define UART_REG_MCR		0x10
>>>> These duplicate include/uapi/linux/serial_reg.h ones, use the std ones
>>>> directly.
>>>>
>>>> Setup regshift too and use it in serial_in.
>>> I think this came up in previous reviews, but it turned out that
>>> only the first six registers are compatible, while the later
>>> ones are all different, and it's not 8250 compatible.
>> So use the normal name for compatible ones and HW specific names for the
>> others?
>>
>> It might not be compatible in everything but surely 8250 influence is
>> visible here and there.
> I'd rename all of them and share nothing. I had the same thought as you
> when I first looked at the driver, and thought of how we merged the omap
> uart into 8250 for this reason, but after I found a datasheet for this
> one, my impression was that it's a much more distant cousin of 8250
> than the others,
>
> There is clearly some family lineage, but there are differences
> everywhere, and I don't think it was designed by extending a 8250
> compatible hardware block with extra features, but rather built
> from scratch (sigh) based only loosely on a register description
> but then extending it with no intent of retaining compatibility.
>
>         Arnd

Yes, the design of this UART IP is indeed incompatible with the 8250, but it
does imitate the 8250 in some register and register bit field naming, and
even in usage definitions, which can easily lead to misunderstandings.

In order to distinguish it from the 8250 and make it clear that it has 
nothing
to do with the 8250, I hope you can agree with me not to use the existing
register and bit field definitions of the 8250 in this driver.

In fact, this UART design has been used for more than 15 years and is used
in our M0/M23/M4, ARM7/ARM9 MCUs and MPUs. The MA35 series will also
continue to use this design. I will add the MA35_ prefix to all 
registers and bit
fields, and make the modifications suggested by Ilpo that are unrelated to
this 8250 issue.


Best Regards,
Jacky Huang

