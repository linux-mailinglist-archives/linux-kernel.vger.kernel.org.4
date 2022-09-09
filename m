Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55075B332B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiIIJIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbiIIJIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:08:06 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A6A5B78D
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 02:08:05 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t7so1619201wrm.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 02:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=V/JKdWLwqyfcF5XL2U75G3plGgDo+tzYRz+CopKoDoo=;
        b=mLoa3aHhb0UwKgQtSVQEWMkDIjd0UwwgQD9OZxJF1JJ52ZHU7sjpaq/nviK/kVklaH
         bsaGXf+k9K5iY0TKbJYfEh0YesR3AZNBdB/9uXrCvQuZo5TcXwHusw15O6SxRrT270/M
         iYeqdXc65YKN7sIRgrpWwXx3cdfHVHsazMcr9IFsnci+u0nFFSV7pGr95daPO5VM15y3
         dQRMYTdfrODbAsOwDS1yw9L3bV7JAJrQY+VGpQEveSoHaDx72JjaTCMRbc8qu6anOmPB
         1ujwvAPyhIKCMw0qenYVJ5xXR0u+1RtRLPYiXB/HXrU1QZXeRgSJCWY6LB2SIX8rwXIz
         KqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=V/JKdWLwqyfcF5XL2U75G3plGgDo+tzYRz+CopKoDoo=;
        b=3NDtZUalfGO4Px4HZJJjfkjj8DDNjZiFKr3pSlcjxUEXFUYx/W8WoHQhq0MBXA9myl
         oVHzyX1jtcsPMcQsF4m9xlS9fHd9eTyNoU+uqyjt3fxB8zKbHOj6b36VG8smyScelTi/
         ylEXbpAJ7Y89PW3DdRwAFw8l1tb1D7egnWV9QiJGL7l9rgg3mFfUn1n9suAAa+Pwc5ZW
         fN0+Coz3/z+Wdr+P0KWQQtp553TAPIsOoeEFgCcJmGqixTWFK6HZ3bQNDmkCIKmezA7i
         ncdV5z+wuDuZV19wuCjOHcQkePIfTQqx3i5a6tmMnjyg98YzP4pfhiGfwtWL8bcuoMAV
         W8rg==
X-Gm-Message-State: ACgBeo29xXEIts+penZRNXNmXUqhRBB52n2m8nbS71nJtCvydHVBMZ2L
        FQEsz2Cm1nlZjvrZ9ZwC6uVtzQ==
X-Google-Smtp-Source: AA6agR6CKOuXRCp2u/u7Dt4ZYxSBRyjw4ebI/vZDh00rUYVALqeQgFrPCC7XlvX2DXzrGP9u4otdVg==
X-Received: by 2002:a5d:5c0c:0:b0:228:df98:7516 with SMTP id cc12-20020a5d5c0c000000b00228df987516mr7316497wrb.208.1662714483905;
        Fri, 09 Sep 2022 02:08:03 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id o5-20020a05600c510500b003a31fd05e0fsm16469187wms.2.2022.09.09.02.08.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 02:08:03 -0700 (PDT)
Message-ID: <ccb50ec6-a0e9-e700-bd1e-220909fcc788@linaro.org>
Date:   Fri, 9 Sep 2022 10:08:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 13/20] nvmem: core: drop priv pointer in post process
 callback
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
References: <20220901221857.2600340-1-michael@walle.cc>
 <20220901221857.2600340-14-michael@walle.cc>
 <373b10aa-f5c8-28b3-88b0-f87a1a40b000@linaro.org>
 <42bc3f6796cc75baafc15c6d2c71ec92@walle.cc>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <42bc3f6796cc75baafc15c6d2c71ec92@walle.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/09/2022 09:58, Michael Walle wrote:
> Am 2022-09-09 10:52, schrieb Srinivas Kandagatla:
>> On 01/09/2022 23:18, Michael Walle wrote:
>>> It doesn't make any more sense to have a opaque pointer set up by the
>>> nvmem device. Usually, the layout isn't associated with a particular
>>> nvmem device.
>>>
>> This is really not a good idea to remove the context pointer, as this
>> is the only way for callback to get context which it can make use of.
> 
> In which case? As I mentioned it's the priv to the nvmem driver and all
> the "normal" callbacks can do very little with it. If there will be a
> future need, then there should be a proper opaque pointer associated
> with the layout and not the nvmem driver.

Yes, the opaque object here is the layout priv which I agree with, but 
removing the context totally from the callback is not a good idea.

We should have some context to callbacks to be able to allow them to 
deal with some private info.


--srini

> 
> -michael
> 
>> I would prefer this to be left as it is.
>>
>> --srini
>>
>>> Signed-off-by: Michael Walle <michael@walle.cc>
>>> ---
>>> changes since v1:
>>>   - new patch
>>>
>>>   drivers/nvmem/core.c           | 4 ++--
>>>   drivers/nvmem/imx-ocotp.c      | 4 ++--
>>>   include/linux/nvmem-provider.h | 5 +++--
>>>   3 files changed, 7 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>>> index d31d3f0ab517..6910796937f9 100644
>>> --- a/drivers/nvmem/core.c
>>> +++ b/drivers/nvmem/core.c
>>> @@ -1523,8 +1523,8 @@ static int __nvmem_cell_read(struct 
>>> nvmem_device *nvmem,
>>>           nvmem_shift_read_buffer_in_place(cell, buf);
>>>         if (cell->read_post_process) {
>>> -        rc = cell->read_post_process(nvmem->priv, id, index,
>>> -                         cell->offset, buf, cell->bytes);
>>> +        rc = cell->read_post_process(id, index, cell->offset, buf,
>>> +                         cell->bytes);
>>>           if (rc)
>>>               return rc;
>>>       }
>>> diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
>>> index ac0edb6398f1..5e869d4a81c5 100644
>>> --- a/drivers/nvmem/imx-ocotp.c
>>> +++ b/drivers/nvmem/imx-ocotp.c
>>> @@ -222,8 +222,8 @@ static int imx_ocotp_read(void *context, unsigned 
>>> int offset,
>>>       return ret;
>>>   }
>>>   -static int imx_ocotp_cell_pp(void *context, const char *id, int 
>>> index,
>>> -                 unsigned int offset, void *data, size_t bytes)
>>> +static int imx_ocotp_cell_pp(const char *id, int index, unsigned int 
>>> offset,
>>> +                 void *data, size_t bytes)
>>>   {
>>>       u8 *buf = data;
>>>       int i;
>>> diff --git a/include/linux/nvmem-provider.h 
>>> b/include/linux/nvmem-provider.h
>>> index 9d22dc5a3fa5..46067a6a0395 100644
>>> --- a/include/linux/nvmem-provider.h
>>> +++ b/include/linux/nvmem-provider.h
>>> @@ -19,8 +19,9 @@ typedef int (*nvmem_reg_read_t)(void *priv, 
>>> unsigned int offset,
>>>   typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
>>>                    void *val, size_t bytes);
>>>   /* used for vendor specific post processing of cell data */
>>> -typedef int (*nvmem_cell_post_process_t)(void *priv, const char *id, 
>>> int index,
>>> -                     unsigned int offset, void *buf, size_t bytes);
>>> +typedef int (*nvmem_cell_post_process_t)(const char *id, int index,
>>> +                     unsigned int offset, void *buf,
>>> +                     size_t bytes);
>>>     enum nvmem_type {
>>>       NVMEM_TYPE_UNKNOWN = 0,
