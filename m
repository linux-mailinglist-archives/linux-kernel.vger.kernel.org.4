Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE296B23B4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 13:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjCIMKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 07:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjCIMJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 07:09:59 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CA2E8ABC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 04:09:57 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id ec29so6063823edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 04:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678363796;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YPxJ2OLIeiVM9zIWTy8Z43PNxojoFyB4wHkVvrTMHsI=;
        b=PCsPuCrSaeWNjmDcMFw4bgKtBYhGYqAj+i0zbY3WNGu0vBzRYo2/guv0/GeJl7bNfu
         3YZW8IM9wnoCeWWtit/jGd9sxzLQUNwy0zQ+E6mmPyFu9Vd5HsFxYTFOxB5W3z8ReLVC
         6OlM8tbxyXovsn7ZLBEGJ1lssXttPBcKEZEEPpjm8A6LdXJ5iHJZwP32FBlWhryra/Sg
         yyS6tl8QVZZkdPFrkE9ixOAd6/MtOQwY8fwNFyqS9qyQwyRq+Td43GQ6G2JXJ6ZDoHR6
         xxon3Itaz79Ep3O1CiueLrpg6250OlViZAS1Opi7Bswchq0FKEn9pw7RxKk7U3McWukW
         UyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678363796;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YPxJ2OLIeiVM9zIWTy8Z43PNxojoFyB4wHkVvrTMHsI=;
        b=S7YnQ/aGmu8A62tgyZb5ILJu4ATMhILDu0AsAc0g7w21dRbmTm+be7RLK5BhkhtWT9
         BuEckRzO5swiwSD/SW6DtZJ3OsVYPO/nh7VO3dTnot1OqWFoBVft5mI9iFEuLz3GtCSj
         Yxju3UwrpXjEY6qbwd0d15JTpnzLRGMDVIDbsC7nie1o1spD4C7Ae3YyeUbQbZOvvxdZ
         7GeAqSnQDzlPNsJKJ/uiUXO03HtGrs8JZhMLisZJjJZNDVXE2/frIHyWDcKGPMfjguQ0
         phnUmmmAf6OLIRfsNVmz8hZX6L2kVnSlNL0Jz+dQClslv2sg60byblVp7Y51n2EBWRQz
         Becg==
X-Gm-Message-State: AO0yUKXYfrqcdHzUx4D2Fwi2Zvt0Vyh3HwYv5aHmeM49OdW/sOFf9inP
        w6nU6776c28/mIYxqWZREeRZdw==
X-Google-Smtp-Source: AK7set/2yYrC/HUaBoW5bZf02GEocIZbb7pOirl6sFK8E+2O9TV3wFT42mnMHbUGh4cjSro0hUSJIQ==
X-Received: by 2002:a17:907:97d3:b0:883:b1b4:e798 with SMTP id js19-20020a17090797d300b00883b1b4e798mr25054045ejc.10.1678363796112;
        Thu, 09 Mar 2023 04:09:56 -0800 (PST)
Received: from [172.20.10.10] ([213.233.108.171])
        by smtp.gmail.com with ESMTPSA id jy24-20020a170907763800b008d7a8083dffsm8751132ejc.222.2023.03.09.04.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 04:09:55 -0800 (PST)
Message-ID: <5183a184-c72d-3acd-70cd-6aa1e31533f5@linaro.org>
Date:   Thu, 9 Mar 2023 12:09:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] spi: Replace `dummy.nbytes` with `dummy.ncycles`
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
Cc:     Serge Semin <fancer.lancer@gmail.com>, Sergiu.Moga@microchip.com,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        Claudiu.Beznea@microchip.com, chin-ting_kuo@aspeedtech.com,
        clg@kaod.org, joel@jms.id.au, andrew@aj.id.au,
        kdasu.kdev@gmail.com, han.xu@nxp.com, john.garry@huawei.com,
        matthias.bgg@gmail.com, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, haibo.chen@nxp.com,
        yogeshgaur.83@gmail.com, heiko@sntech.de,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        michal.simek@xilinx.com, bcm-kernel-feedback-list@broadcom.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20220911174551.653599-1-sergiu.moga@microchip.com>
 <20220925220304.buk3yuqoh6vszfci@mobilestation>
 <18e6e8a8-6412-7e31-21e0-6becd4400ac1@microchip.com>
 <20220926172454.kbpzck7med5bopre@mobilestation>
 <1766f6ef-d9d8-04f7-a6bf-0ea6bc0b3d23@linaro.org>
 <f647e713a65f5d3f0f2e3af95c4d0a89@walle.cc>
 <1849e2c8-54f5-9e56-4ed8-8b0e4a826d04@linaro.org>
 <302ecf0421fe4c99fca3eb0ca2f66127@walle.cc>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <302ecf0421fe4c99fca3eb0ca2f66127@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/9/23 10:56, Michael Walle wrote:
> Am 2023-03-09 11:42, schrieb Tudor Ambarus:
>> On 09.03.2023 10:38, Michael Walle wrote:
>>>> In an ideal world, where both the controller and the device talk about
>>>> dummy number of cycles, I would agree with you, buswidth and dtr should
>>>> not be relevant for the number of dummy cycles. But it seems that there
>>>> are old controllers (e.g. spi-hisi-sfc-v3xx.c, spi-mt65xx.c,
>>>> spi-mxic.c)
>>>> that support buswidths > 1 and work only with dummy nbytes, they are
>>>> not
>>>> capable of specifying a smaller granularity (ncycles). Thus the older
>>>> controllers would have to convert the dummy ncycles to dummy nbytes.
>>>> Since mixed transfer modes are a thing (see jesd251, it talks about
>>>> 4S-4D-4D), where single transfer mode (S) can be mixed with double
>>>> transfer mode (D) for a command, the controller would have to guess the
>>>> buswidth and dtr of the dummy. Shall they replicate the buswidth and
>>>> dtr
>>>> of the address or of the data? There's no rule for that.
>>>
>>> But in the end that doesn't matter because they are just dummy clock
>>> cycles and the mode will only affect the data/address/command.
>>> Therefore,
>>> the controller is free to choose the mode that suits it best.
>>>  > But that begs the question, is ncycles in regard to DTR or SDR?
>>> That is,
>>> are you counting just one type of edges or both the falling and rising
>>> edges. The smallest granularity would be ncycles in regard of DTR. To
>>> me,
>>> it's not obvious what the SEMPER Nano Flash [1] uses. I'd say we choose
>>> the smallest granularty in spi-mem to be future proof and maybe provide
>>> some spi-mem helper to help setting the cycles for SDR/DTR. As an
>>> example,
>>> if you want to wait 4 cycles in SDR you'd have ncycles=8 in spi-mem.
>>>
>>
>> No, we can't invent our own measuring units. We have cycles and half
>> cycles (regardless of the transfer mode used (STR, DTR)).
> 
> That is basically what I was saying, just using the correct term.
> Ok. So we don't need the dtr property, right? I'm still not sure,

We do.

As of now you can't specify 20 dummy cycles for READID in 8D-8D-8D mode
because all the layers treats dummy as bytes, whereas they should treat
it as cycles. One dummy byte in 8D-8D-8D means 16 dummy cycles. 20 dummy
cycles in 8D-8D-8D means one byte and a quarter? This is a non-sense.

As the code is now, SPI NAND uses dummy cycles that are multiple of 8.
SPI NOR requires a variable number of dummy cycles, there's no
restrictions. In SPI NOR we get from SFDP or datasheets the number of
dummy cycles, and in the code we convert them to dummy nbytes. Then when
we get at the controller side, the majority of the controllers undo the
operation, they take the dummy nbytes and convert them to dummy ncycles.
Isn't better to use dummy ncycles from the beginning?

The controllers that can talk in dummy ncycles don't need the
dummy.{buswidth, dtr} fields.

The controllers that can't talk in dummy cycles, but only on a "byte"
boundary need both buswidth and dtr fields. Assume a flash needs 32
dummy cycles for an op on 8D-8D-8D mode. If the controller does not have
the buswidth and dtr info, it can't convert the dummy ncycles to nbytes.
If he knows only that buswidth is 8, it will convert ncycles to 4 bytes.
If dtr is also specified it converts ncycles to 2 bytes.

> what the semper nano flash uses. Half cycles? But according to your

there's no spimem flash code that use half cycles for now.

> naming you'd specify full cylces?

A clock period, yes.

Hope it helps.
ta
