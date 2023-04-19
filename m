Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144426E82EF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 23:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjDSVAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 17:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjDSVAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 17:00:19 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DAE6E8A;
        Wed, 19 Apr 2023 13:59:59 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d8so270295plg.2;
        Wed, 19 Apr 2023 13:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681937999; x=1684529999;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wg5/dukhZYhdc8/qhlvP79OyWl4s5S4ymsYixZdIlFA=;
        b=EmF/wqTN1e6Vo6VR2i3nUJkCGPqdk4zF5rMVl6Ab6+cPxC8QNeHvZNuLn16TPCIYoa
         oX55blNRJzrsH2VAli6MNUDYMK+w1HkfjQOTaE/DwOiQ0doJEmQMdK1dMPs9aHinxfMn
         z+h53r74LYETZ0Ft1A0Ydfr+CZcAZUDXxidfRCMrf/OQ2JLhqLmm/W2J/v+DJTaxSFvi
         9eed52cyssAAKAk1wLOcZmlQ6j8jjPVfeFYGbpFWAfus0r18dFrYC1SG5M0LJj+Or9Ya
         g7Vh4KF33LJceBGbN4nBjs7odj0MmgpCGQ1umfWvl4i0X8F56dC7aKSokc6YXW/oI6xB
         s8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681937999; x=1684529999;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wg5/dukhZYhdc8/qhlvP79OyWl4s5S4ymsYixZdIlFA=;
        b=YWSiwLnLnz/3F5zROM+0Fs+uLy1fInKhBhYcVxRbVVwVXUbwMRNFz+X0T6FQeh9IVR
         YQqOA81xVFO86AyaR295GhpX6gey/Dfv0h81KjspSRN3zWEnM5Z/QozP3uCzeD5HtCx5
         5eDuYQ+g5aSpaQuOnT809Rdeqh0R3F1oMUMkRc0AOptaL82bLq734to9uKJq0Z+XY9o+
         AV/hfHDdQoSskom7Pv+eTbO4TdVAGqZtzgf3h+o8hBXxSHiThL1rM99hJHKgEm/1BrbV
         VQFAreHVOhq8cQFFhsuh0gR/qy76imTETP9rtRwn1ciOas93nVPRFaymaHeoEYCC7X0P
         3Mqg==
X-Gm-Message-State: AAQBX9dvorRMH9XxXrIzxJMq74I2h8GTa+UOTB8MD5Xy00gOV+lL7M4Y
        Y46P1lI47tQRSqP93B5bE7Py/bspBSs=
X-Google-Smtp-Source: AKy350ZxjbBI/jPnVNOn+1XD21Vx7dF1Mp51++44aInh80sRab5HciSEK9bZ1d19O93S/okvFM8k0Q==
X-Received: by 2002:a05:6a20:748f:b0:ef:c5b6:b6a8 with SMTP id p15-20020a056a20748f00b000efc5b6b6a8mr4613767pzd.45.1681937999155;
        Wed, 19 Apr 2023 13:59:59 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2-20020a63d642000000b005140ce70582sm10718610pgj.44.2023.04.19.13.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 13:59:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <76ae207d-9872-95e9-277c-d98f5f979659@roeck-us.net>
Date:   Wed, 19 Apr 2023 13:59:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "manio@skyboo.net" <manio@skyboo.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230418233656.869055-1-chris.packham@alliedtelesis.co.nz>
 <20230418233656.869055-3-chris.packham@alliedtelesis.co.nz>
 <4d78b62f-1592-45d9-874a-30f1906cd2d3@roeck-us.net>
 <9ad2433a-676f-0a90-809c-f256d2b9ba79@alliedtelesis.co.nz>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 2/2] hwmon: (adt7475) Convert to use device_property
 APIs
In-Reply-To: <9ad2433a-676f-0a90-809c-f256d2b9ba79@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/23 13:49, Chris Packham wrote:
> 
> On 20/04/23 04:06, Guenter Roeck wrote:
>> On Wed, Apr 19, 2023 at 11:36:56AM +1200, Chris Packham wrote:
>>> Instead of of_property_read_*() use the equivalent
>>> device_property_read_*() API. This will allow these properties to be
>>> used on DT unaware platforms. For DT aware platforms this will be a
>>> noop.
>>>
>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>>> ---
>>>
>>> Notes:
>>>       This is an additional update for master from the preceeding bugfix
>>>       commit. I've not added a fixes tag for this one because I don't think
>>>       there will be a behaviour change for existing usages.
>>>       
>>>       I know we have one upcoming DT unaware platform that we may want to use
>>>       some of these properties via ACPI tables so I won't object if this ends
>>>       up on the stable track but I don't think it meets the criteria for
>>>       stable.
>>>
>>>    drivers/hwmon/adt7475.c | 8 ++++----
>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
>>> index 6a6ebcc896b1..3b9289bc5997 100644
>>> --- a/drivers/hwmon/adt7475.c
>>> +++ b/drivers/hwmon/adt7475.c
>>> @@ -1468,7 +1468,7 @@ static int load_config3(const struct i2c_client *client, const char *propname)
>>>    	u8 config3;
>>>    	int ret;
>>>    
>>> -	ret = of_property_read_string(client->dev.of_node, propname, &function);
>>> +	ret = device_property_read_string(&client->dev, propname, &function);
>> Unfortunately that is a problem because the parameter passed to
>> load_config3 is a pointer to a const data structure and
>> device_property_read_string doesn't like that (afaics for
>> no good reason). You'll also have to change the client parameter
>> to load_config() and friends to not be const.
> 
> Not sure how I didn't notice that. Probably rushing to get the fix part out.
> 
> I do have a v3 that drops the const where needed to silence the warnings
> but I'll sit on that for now in the hope that your patch gets accepted.
> 

Sounds good to me. There is no hurry with this one, after all.

Thanks,
Guenter

