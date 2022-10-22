Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26787608423
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 06:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiJVEEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 00:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJVEER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 00:04:17 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE2027E2C9;
        Fri, 21 Oct 2022 21:04:16 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id j6-20020a4ab1c6000000b004809a59818cso713664ooo.0;
        Fri, 21 Oct 2022 21:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Yw0pw+RlOzwWJIc8TxHrrJQC0UxntH5q/xKxVjdlPQc=;
        b=GAa3BQg/4cgVaEw0MW3idqWB7FdBlv1hlhPWABv7kqHuz6gpMAhdqrKBmgo8njIbvH
         EGOrYQMz6jmOGqvsrPp83OgyShrvK4VuVWOeNiriJSEDtOXs5NEEOdk9qweYVIt5lkaw
         6wpM1uF1UlHfdDA/nX6ecMiAt96jdsjeL/nN3EA9SlPC2xLAhMJC9L+SaKdIPZhMsT70
         DCLCC+E4/DzT+KhmvOmcdomGYSubgA2V2J75JoameIGfMIioGlEHfYNCUl8lLpd9EqoX
         FChja0E8+5DlANlaOJm0DQeOWNXscQNBPS4eRBjFhUzR88RYXcr2dnQweRWt9xv+EbIB
         2sTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yw0pw+RlOzwWJIc8TxHrrJQC0UxntH5q/xKxVjdlPQc=;
        b=UwE3jMx28z+mGBlp3fG618R1pcTUWqi27NUp5EPGozP8zHAMm6f4PeGvUQ7mlATIkE
         heEcXg59HE8Ji8NbcS4kmOcGK4p5j9easCfJW4jkcikk+0qfbPyZyfNMZJUgNbwJBDmo
         2XfOlpznByNVo831JKGklUIbq9mLgFl8v2wOXj5Lxfm0Tn+FejIQ36l0avUTpxQVyZgO
         Ji28Y8NivdsSnKmlQKhsNO9/8tnBFIGQ+ycOw1vjdmSnJecIiDWaS3x/hy10QLOwS8Rc
         0oR/QQcJB9G7jzqBsrKGHk0L2CrM5JU2pxyRWCz7WnGtV63tHj+z8uYUCG7KQJzrs4yO
         XOjw==
X-Gm-Message-State: ACrzQf2IEsgArxCz7g+NRkeYxiym4DBzQJ5qBRmcaAG2HTqXeMfIKjcL
        TuhWZp9uKSG5ORWj2oIehL0=
X-Google-Smtp-Source: AMsMyM6EPoNVcm+bwUh5FIXxfMZup0bf+mR4q5Kx88/R8kWASSsj0StZbuVB4n0lxbvxHxgup0AvVA==
X-Received: by 2002:a4a:a387:0:b0:480:9a7a:4e99 with SMTP id s7-20020a4aa387000000b004809a7a4e99mr10342793ool.4.1666411456080;
        Fri, 21 Oct 2022 21:04:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r22-20020a056870581600b001324315bb6asm11365614oap.29.2022.10.21.21.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 21:04:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7de80d4f-7c25-6b6b-ebb0-e9e1254dac53@roeck-us.net>
Date:   Fri, 21 Oct 2022 21:04:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 1/2] hwmon: (jc42) Convert register access and caching
 to regmap/regcache
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-hwmon@vger.kernel.org, jdelvare@suse.com,
        linux-kernel@vger.kernel.org
References: <20221021165000.1865615-1-martin.blumenstingl@googlemail.com>
 <20221021165000.1865615-2-martin.blumenstingl@googlemail.com>
 <20221021171127.GB1888515@roeck-us.net>
 <CAFBinCDRA-Xw_Y9PkL2vmCqW3A1vCWeRB2EDEJQgQ+qKMn9dYw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAFBinCDRA-Xw_Y9PkL2vmCqW3A1vCWeRB2EDEJQgQ+qKMn9dYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/22 10:51, Martin Blumenstingl wrote:
> Hi Guenter,
> 
> On Fri, Oct 21, 2022 at 7:11 PM Guenter Roeck <linux@roeck-us.net> wrote:
> [...]
>>> @@ -368,17 +361,14 @@ static int jc42_write(struct device *dev, enum hwmon_sensor_types type,
>>>                }
>>>                data->config = (data->config & ~JC42_CFG_HYST_MASK) |
>>>                                (hyst << JC42_CFG_HYST_SHIFT);
>>> -             ret = i2c_smbus_write_word_swapped(data->client,
>>> -                                                JC42_REG_CONFIG,
>>> -                                                data->config);
>>> +             ret = regmap_write(data->regmap, JC42_REG_CONFIG,
>>> +                                data->config);
>>>                break;
>>
>> This code sequence still requires a mutex since another thread could modify
>> the upper limit (and/or the hysteresis) while the hysteresis is in the process
>> of being written. Worst case there could be a mismatch between the value in
>> data->config and the value actually written into the chip. Granted, that is
>> unlikely to happen, but the race still exists.
> Thanks for spotting this - this is indeed a potential issue.
> Do you also want me to add locking for the data->config access (read)
> in jc42_read()? Without a lock there in theory jc42_write() may have
> already updated data->config with a new value while hardware still has
> the old value. So in the end the read output may show a hysteresis
> which was not programmed to the registers at that time.
> 

Thanks for noticing. I had missed that one. Yes, please.

Thanks,
Guenter


