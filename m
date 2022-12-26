Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239B5656110
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 09:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiLZIRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 03:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbiLZIRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 03:17:12 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B131ABA2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 00:17:10 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so4392266wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 00:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DlEaU2ipuYNDCsSp9eEhyRPhSMuWMkrFixv4Lp/tLOw=;
        b=l+YBi3VdCvIJii1Sl3OpF+RosvfA98Pz3/nEcoyI4h24lEurQc4yqpJ+iYNaGqthmi
         ZD7Mnhc4OFu1mJN6jqdcEaovz5NPEXucfN5h1d5Fm77zaChmVcJSyqdd0hil66aOSOAJ
         /dpkN4DfidSzbDzKHIDCRhHl28v3bqZjXJdcenyK6/oh82xAhbUYhGMs5gyLQTKI3LiH
         ht33fyF7zb+eVpCvMddWSjULPVevp4LMu9eP+3vqUeg0cnKglUb74J7gdeEXJbmGzUjF
         QGOLiEsnY2c6ZXyTjQhJN0pr1nkSGWaHgHTCA4DbU36xjelecCz4Y8rDk3Dsh4Ing3HC
         HJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DlEaU2ipuYNDCsSp9eEhyRPhSMuWMkrFixv4Lp/tLOw=;
        b=d3/ITmSUpWMaRxXdKkeLwyFGTBAEk71t/wyrheHPZHfp97lHgx5zsZzz/wNJCrQrxP
         K/CtnUtUnsEe5d1o73rXteoK6SKWH4OotSU/Gp0oPd3hdhVOQSVc4sBz+zqmzOgpgX1G
         iwAz3eY5DbOV7i/PsWmRWgcd8Yp1tBeRf8lxk5rr2Kv6tPwFd3cOCEvcLGLmlqgheGk8
         d+pEdfxKkXButou+wif2Mx/fuUYdIvBVeXyQv8N9BA/M4iq8uTjwF+33h9DRTVOBMr9D
         cQV4Kt6rtbaUtaE/bFEpuyLOo2nINg9pZgTOr+yA967W5Ufgcax/zob54JVM9qThQBbx
         u08g==
X-Gm-Message-State: AFqh2kontVPxn6/pgUu2OxPwpK99OGbiPZKZA46HS96+sTjCw0v1uP1p
        urF1Q1RLK6OXy3XP1Cc8rKcrEg==
X-Google-Smtp-Source: AMrXdXs9hiMNzjyyGo7MgY5qWJrrLBaCmZIaGzRHkw/xGaeSOCDNA48xOFyRVI7k21dKTByTaPN8mw==
X-Received: by 2002:a05:600c:a4a:b0:3d3:3d1b:6354 with SMTP id c10-20020a05600c0a4a00b003d33d1b6354mr12512998wmq.3.1672042629259;
        Mon, 26 Dec 2022 00:17:09 -0800 (PST)
Received: from [192.168.0.173] ([82.77.81.131])
        by smtp.gmail.com with ESMTPSA id w20-20020a1cf614000000b003cf4d99fd2asm13056707wmc.6.2022.12.26.00.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Dec 2022 00:17:08 -0800 (PST)
Message-ID: <eafebda5-7342-dfa9-7745-543d5f7d6f3d@linaro.org>
Date:   Mon, 26 Dec 2022 10:17:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 3/3] mtd: spi-nor: Add support for IS25LX256 operating
 in 1S-8S-8S octal read mode
Content-Language: en-US
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Cc:     greg.malysa@timesys.com,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "open list:SPI NOR SUBSYSTEM" <linux-mtd@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221202135539.271936-1-nathan.morrison@timesys.com>
 <20221202135539.271936-4-nathan.morrison@timesys.com>
 <9927a8c3-40cf-2c69-46c6-f660ff2422b1@linaro.org>
In-Reply-To: <9927a8c3-40cf-2c69-46c6-f660ff2422b1@linaro.org>
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



On 26.12.2022 10:04, Tudor Ambarus wrote:
> Hi, Nathan,
> 
> The series is starting to look good, but I'll need another version,
> please.
> 
> On 02.12.2022 15:55, Nathan Barrett-Morrison wrote:
>> This adds the IS25LX256 chip into the ISSI flash_info parts table
> 
> Describe your changes in imperative mood, e.g. "Add support for
> S25LX256" instead of "This adds ..."
> 
> It may worth to re-read
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html
> once in a while.
> 
>>
>> Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
>> ---
>>   drivers/mtd/spi-nor/issi.c | 32 ++++++++++++++++++++++++++++++++
>>   1 file changed, 32 insertions(+)
>>
>> diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
>> index 89a66a19d754..362bc3603d8f 100644
>> --- a/drivers/mtd/spi-nor/issi.c
>> +++ b/drivers/mtd/spi-nor/issi.c
>> @@ -29,6 +29,35 @@ static const struct spi_nor_fixups is25lp256_fixups 
>> = {
>>       .post_bfpt = is25lp256_post_bfpt_fixups,
>>   };
>> +static int
>> +is25lx256_post_bfpt_fixups(struct spi_nor *nor,
>> +               const struct sfdp_parameter_header *bfpt_header,
>> +               const struct sfdp_bfpt *bfpt)
>> +{
>> +    /*
>> +     * IS25LX256 supports both 1S-1S-8S and 1S-8S-8S.
>> +     * However, the BFPT does not contain any information denoting this
>> +     * functionality, so the proper fast read opcodes are never setup.
>> +     * We're correcting this issue via the fixup below.  Page program
>> +     * commands are detected and setup properly via the 4BAIT lookup.
>> +     */

Why don't you set the READ support when parsing the 4bait table? We need
to see the SFDP dump to determine how we treat this. I'm not sure a
post_bfpt hook is the right thing to do for this flash.

Thanks,
ta
