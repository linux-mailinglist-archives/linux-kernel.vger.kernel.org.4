Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306AA656B4F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 14:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiL0NYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 08:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiL0NYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 08:24:32 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC9CB1D6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 05:24:31 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id qk9so31936959ejc.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 05:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H3ZA4K99KoV8xtIWLMOEToauN5ng5q+nSOJU1SMRa5w=;
        b=Wr0+bZzvHPG2FSnVIYSCvLpV4XkGb7Cp+0jd/IGQ4hFXriQpFt9TlnsYbNuy3gxHwu
         C5J7tE1VggCMV1tbKIDmPboBRXZmnes6msZpI8AijQLWYvCE7B6+ev5c7gNM0CU0FiPM
         UXpcwdwboM98oOkI6kq8Zgp5eGBjMCqdwW5SwMp1Ss7lJCzkwPO1yz99i0xMGz4DFgmn
         63wqsAub7nfC598ytse0jsHaykF9/rPVGEakSjlj4/izvgnX1N8spVZJHvoiAUjRPm8y
         MNvR7ilSNAxNvC2591P5lNqx54aqD4Z7kmHj/3UyooApXWRCvOXWg7A+c4PUgpGs00Vf
         aqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H3ZA4K99KoV8xtIWLMOEToauN5ng5q+nSOJU1SMRa5w=;
        b=VtI1VML3kHPuGhkCcs6l9S6IAuru3gW1DGRStPLx0TpCTXwqkLElgdlG3z5dsldW/C
         aZpKnjGVgLEkZsiUBzHvdt2OA3dFvZffXtiCIZ3PwdMdbBXPx69PtWq1j8n3A0FuBBiC
         hBYsKU9R5u3W0gOhWgtRT+9T5LDOFFrySsu/iWPE9BkvEfCodi7rZGSrX2jw8RghaX/n
         4Z6+c8NQiGPCnd4+kmIvIQiycU/e1tkwBal/boMOw1YCSguIMFd8ntFYgdrASxXg8UU1
         hCE7pbHZZIYx0RkDdQzcuHo5JhBk/4uN5lPMZR8Y1e1zoSqq5z/hShk850q/BRf2wIVN
         VuCQ==
X-Gm-Message-State: AFqh2kqrr5dMkjKSLJbT76CbbT6zXFCWzw8bKz9uwRPa+khbI4TXkKkY
        lJikx/ye2ygY6yWfc5fgO6PpjQ78qyBjxFZ0
X-Google-Smtp-Source: AMrXdXvC9W4RKBZ6i2zN04Rln5WWxwZwzURAge146Q8l27t9zdmSXNFqnm4hgDtjKdnPqzsjcg2vyA==
X-Received: by 2002:a17:906:c18d:b0:843:770e:777f with SMTP id g13-20020a170906c18d00b00843770e777fmr15956000ejz.24.1672147469751;
        Tue, 27 Dec 2022 05:24:29 -0800 (PST)
Received: from [192.168.0.104] ([82.77.81.131])
        by smtp.gmail.com with ESMTPSA id lb26-20020a170907785a00b0084b8979fc5bsm4491911ejc.43.2022.12.27.05.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 05:24:29 -0800 (PST)
Message-ID: <abf7dc0e-df13-25ae-83b7-204eee0189d4@linaro.org>
Date:   Tue, 27 Dec 2022 15:24:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 3/3] mtd: spi-nor: Add support for IS25LX256 operating
 in 1S-8S-8S octal read mode
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
Cc:     Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
        greg.malysa@timesys.com,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "open list:SPI NOR SUBSYSTEM" <linux-mtd@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221202135539.271936-1-nathan.morrison@timesys.com>
 <20221202135539.271936-4-nathan.morrison@timesys.com>
 <9927a8c3-40cf-2c69-46c6-f660ff2422b1@linaro.org>
 <eafebda5-7342-dfa9-7745-543d5f7d6f3d@linaro.org>
 <14b5fc24d0e9391807768c595a4277ee@walle.cc>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <14b5fc24d0e9391807768c595a4277ee@walle.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.12.2022 14:37, Michael Walle wrote:
> Am 2022-12-26 09:17, schrieb Tudor Ambarus:
>> On 26.12.2022 10:04, Tudor Ambarus wrote:
>>> Hi, Nathan,
>>>
>>> The series is starting to look good, but I'll need another version,
>>> please.
>>>
>>> On 02.12.2022 15:55, Nathan Barrett-Morrison wrote:
>>>> This adds the IS25LX256 chip into the ISSI flash_info parts table
>>>
>>> Describe your changes in imperative mood, e.g. "Add support for
>>> S25LX256" instead of "This adds ..."
>>>
>>> It may worth to re-read
>>> https://www.kernel.org/doc/html/latest/process/submitting-patches.html
>>> once in a while.
>>>
>>>>
>>>> Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
>>>> ---
>>>>   drivers/mtd/spi-nor/issi.c | 32 ++++++++++++++++++++++++++++++++
>>>>   1 file changed, 32 insertions(+)
>>>>
>>>> diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
>>>> index 89a66a19d754..362bc3603d8f 100644
>>>> --- a/drivers/mtd/spi-nor/issi.c
>>>> +++ b/drivers/mtd/spi-nor/issi.c
>>>> @@ -29,6 +29,35 @@ static const struct spi_nor_fixups 
>>>> is25lp256_fixups = {
>>>>       .post_bfpt = is25lp256_post_bfpt_fixups,
>>>>   };
>>>> +static int
>>>> +is25lx256_post_bfpt_fixups(struct spi_nor *nor,
>>>> +               const struct sfdp_parameter_header *bfpt_header,
>>>> +               const struct sfdp_bfpt *bfpt)
>>>> +{
>>>> +    /*
>>>> +     * IS25LX256 supports both 1S-1S-8S and 1S-8S-8S.
>>>> +     * However, the BFPT does not contain any information denoting 
>>>> this
>>>> +     * functionality, so the proper fast read opcodes are never setup.
>>>> +     * We're correcting this issue via the fixup below.  Page program
>>>> +     * commands are detected and setup properly via the 4BAIT lookup.
>>>> +     */
>>
>> Why don't you set the READ support when parsing the 4bait table?
> 
> That would deviate from the read handling of all the other modes.

Oh, I see now, so you need to amend BFPT with the 3B opcodes so that the
4bait table convert the 3B read opcodes to 4B. That's fine, yes.

> 
>> We need to see the SFDP dump to determine how we treat this. I'm not
>> sure a post_bfpt hook is the right thing to do for this flash.
> 
> See:
> https://lore.kernel.org/linux-mtd/e07105d41ec62a6ee47ca0295ca347dc@walle.cc/

Okay, it looks fine. I still need the write, erase, verify erase, write,
read and compare test.

> 
> But yes, I missed that you should include the sfdp dump and some other
> commands in the comment section of the patch which adds support for that
> flash (see Tudors reply).
> 
Nathan, please resubmit addressing those small comments if you can.

> Tudor, what is the status of your documentation patch? I'd really like
> to refer to the kernel docs instead of having write the same over and
> over again ;)

I hope to have it ready for 6.3.

Cheers,
ta
