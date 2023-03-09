Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057D76B25FC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 14:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjCINze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 08:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjCINzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:55:04 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9E75269
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 05:54:32 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id j19-20020a05600c191300b003eb3e1eb0caso3657554wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 05:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678370071;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+yNMGdQC/Xw2IM5J0z39LrXI/wVpt74oZIMsD87S200=;
        b=K7sXdAFy2z4bNQssKxVGN0CKWVjncTXW3VNw27sxQUhZ4toVTMpMfoKgamejk4M//3
         UYw0C5S0MB14uALgQJ0MU8mkL13/HcmZ58Ma2NprweXhZTT+MTN3cHCmCO16cWEhFmZJ
         S8lUWOV7zXulkBDx0mS9OPGDVaswJ7Gc+2PdVKtM9mU9HeiXSM2LfUJwlMFTMxPn8zes
         jpWki0+2dgBR/u25caK3XxHeVY8jtubTX3/H8MOv8IZDVt54A5Ng9/ASlgnTKnHn5gmi
         JpIVvIG86rQCG+AIHULWfhPK1DJuMzARFYBcFu+kR3CeJroS3LoxfCYLwGcEgKE/phNn
         nfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678370071;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+yNMGdQC/Xw2IM5J0z39LrXI/wVpt74oZIMsD87S200=;
        b=OoGG0N1ujToS/NYEVur7hrzg84bDLMf+ZnWum5jB59+oXyEfCkbsFb/iTxAFaeZAlO
         CkBcNYFlGTzI+lYg8M8jO4w8B5woxzmH7ghCJbXoByTX8NWTIRkO0x60b3+7wpyn7T3T
         lXbdMjpRkK74T06GZUjy9eDkjKwseLjkpRS3v8N26L1lkQyEUSbi0e2yjI7w8dSKi+RJ
         lQaryCKu2Uvs2GHDF9MEh62iXrZlgXvL7FmhFmTlk5t6LtfHCBvnWUww70kiNAWcFWFi
         B8dwCaQzyW3GwPbZ4lQJGiuz4HDPWMS2ajpoCN4i4RICPxaH4LK5NmEhetz8sbzVAjCP
         TH5w==
X-Gm-Message-State: AO0yUKWaNFl5DbA4uHE8wthhEycPwSPtiERlCT5W81VCNfs4G1+UPO1Y
        sa9tG5S+2IoT/Hk8iNbTrrmNvg==
X-Google-Smtp-Source: AK7set9BC1aUcCmXpoGmNq+F0KtxUnHtaWTpYlQDUbfH+9jnFAvfgT6oTZA+trXsjWT36mi++mzKeg==
X-Received: by 2002:a05:600c:2199:b0:3eb:f59f:6daf with SMTP id e25-20020a05600c219900b003ebf59f6dafmr7949883wme.34.1678370071103;
        Thu, 09 Mar 2023 05:54:31 -0800 (PST)
Received: from [192.168.0.173] ([79.115.63.78])
        by smtp.gmail.com with ESMTPSA id v15-20020a05600c444f00b003e2232d0960sm2757515wmn.23.2023.03.09.05.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 05:54:28 -0800 (PST)
Message-ID: <b8b61fc0-1e4f-146b-2036-03fda5359585@linaro.org>
Date:   Thu, 9 Mar 2023 15:54:25 +0200
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
 <5183a184-c72d-3acd-70cd-6aa1e31533f5@linaro.org>
 <03a9f117316ab81f1b5a18100f771e65@walle.cc>
 <6c2090bf-d102-a333-3a83-03abe81ff70e@linaro.org>
 <460ef5ff3846b409b322ca53559e2476@walle.cc>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <460ef5ff3846b409b322ca53559e2476@walle.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09.03.2023 15:33, Michael Walle wrote:
>>>> The controllers that can talk in dummy ncycles don't need the
>>>> dummy.{buswidth, dtr} fields.
>>>>
>>>> The controllers that can't talk in dummy cycles, but only on a "byte"
>>>> boundary need both buswidth and dtr fields. Assume a flash needs 32
>>>> dummy cycles for an op on 8D-8D-8D mode. If the controller does not 
>>>> have
>>>> the buswidth and dtr info, it can't convert the dummy ncycles to 
>>>> nbytes.
>>>> If he knows only that buswidth is 8, it will convert ncycles to 4 
>>>> bytes.
>>>> If dtr is also specified it converts ncycles to 2 bytes.
>>>
>>> No they don't need it. Lets take your semper flash and assume it needs
>>> 12 latency cycles. SPI-NOR will set ncycles to 12 *regardless of the 
>>> mode
>>> or dtr setting*. The controller then knows we need 12 clock cycles. 
>>> It has
>>> then to figure out how that can be achieved. E.g. if it can only do the
>>> "old" byte programming and is in quad mode, good for it. It will send 6
>>> dummy bytes, which will result in 12 dummy clock cycles, because 1 byte
>>> takes two clock cycles in quad SDR mode. If its in octal mode, send 12
>>> bytes. If its in dual mode, send 3 bytes. Obiously, it cannot be in
>>> single bit mode, because it cannot send 1.5 bytes..
>>>
>>
>> You miss the fact that you can have 1-1-4. What buswidth do you use
>> for dummy, the address buswidth or the data buswidth?
> 
> Doesn't matter, does it? The driver is free to chose, 1, 4, or anything
> else. You don't sample any data during the dummy phase.
> To answer your question: single for instruction, single for address,
> whatever you choose for dummy as long as there are ncycles space between
> address and data, and quad for data.

Huh? How does the controller chose, based on what?

> 
> Depending on the capabilites of the hardware it will likely be 1 or 4.
> 
>> What happens if crazy protocols like 1S-1S-8D appear? What buswidth
>> and transfer mode are you going to use for dummy?
> 
> Also doesn't matter. What matters is how many dummy clock cycles you
> do. Again, they don't depent on the mode. You just have to count
> the clock cycles between the address and the data phase (and that is
> what your ncycle parameter will tell the controller).
> 
>> And please don't tell me that "we're going to assume that
>> dummy.buswidth = address.buswidth because that's what we currently do
>> in SPI NOR", because I'm not convinced that the assumption is correct.
> 
> No, it doesn't matter :)
> 
> -michael
