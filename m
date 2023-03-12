Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B746B64BF
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 11:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjCLKL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 06:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjCLKLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 06:11:24 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4E028E80
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 03:11:20 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id da10so37691180edb.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 03:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678615879;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j8G031avMSPK+DJWKW31cg0HGNEgLSCzSCq48aOVZWQ=;
        b=BIbzDnAx4QSz33kamzjYWgoJ/xsBCDeD//AbIp9xpobYZZWzskR7nvllN2/f73AJ2m
         H/94z+Gx7Ze6wHeT0INyYHDtv14EaLvSQpu2dxYlBmmi2BaKA/iT+uf6Ff0lld6IKpsU
         WTnmyGf6VHIJaDQfP+YJ1a+oiZ2BwCJtSpMOaAK/bxjAhjS/vdKDRV5V/eUwSAmBNqcW
         Q75G88ta2xyjhQM5Un7EU9ZjqOOZB2ss8/9acqtEWiBz/fWiQV2QGT/5isXikWzcsHiD
         UzfmQTU4NNL8+w+zes/Zv+pa+nJWnER73SQn+lmWy+i4M+/4SvuvEbhqQapP75DToysb
         Q2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678615879;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j8G031avMSPK+DJWKW31cg0HGNEgLSCzSCq48aOVZWQ=;
        b=ZoGtvOkPzke86hqcegvYmD6JZMo5DYFw/OQvqH8HJ5xuLmPPbpsfwNtOe9RIXP03t2
         xwmFOEWrtWCBtdfDc2vQzqd1fauh2sWoZFGuWa6fTPouXPycL9ZYpWfELuviP5o+FX4y
         iZB816SR/rHa+7DiikbnuUSlnA9rq4o5nj//OY5H9a16lQnMzMNN1mQsPls7KnEg6Hp0
         TKJHnDlSbkkWBpIO1UtrpyWWTB2eyf/FHiPE2Ok3wbcMyR+w7ACHqKcUdSWd9Gv287eH
         sgDbafqZMB5Q6BEEnKaeMiX35sm6OHPizYM9fE4CfVLYT54hCv+sKmL9NRnH8uaFF99n
         zIbQ==
X-Gm-Message-State: AO0yUKVf+ZaXV9og9P30mX5jtAjfwr4K9gQTWFp6uG/A8VMdW5LmKxnE
        iVHH/e0hslpyTg/PNi43qnNmFg==
X-Google-Smtp-Source: AK7set8AvzfQ4wSyspYsX+pjSkZyBPpXkfTQZR8Vo0MZMbyxvgQD4APiwUOxmrATQ5mjRiT1EFiPmQ==
X-Received: by 2002:a17:906:2a58:b0:8b1:2614:fbf2 with SMTP id k24-20020a1709062a5800b008b12614fbf2mr29001123eje.70.1678615879062;
        Sun, 12 Mar 2023 03:11:19 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id c1-20020a170906762100b008b17e55e8f7sm2052006ejn.186.2023.03.12.03.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 03:11:18 -0700 (PDT)
Message-ID: <3dce3d36-cba5-c056-92a2-18b67711a6db@linaro.org>
Date:   Sun, 12 Mar 2023 11:11:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/4] iio: dac: ad5755: mark OF related data as maybe
 unused
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Robert Eshleman <bobbyeshleman@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230311111457.251475-1-krzysztof.kozlowski@linaro.org>
 <20230311111457.251475-2-krzysztof.kozlowski@linaro.org>
 <20230311122208.059a81cb@jic23-huawei>
 <68e9c7d9-1087-0454-6122-a88c7339ab3c@linaro.org>
 <20230311183121.577eb52b@jic23-huawei>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230311183121.577eb52b@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2023 19:31, Jonathan Cameron wrote:
> On Sat, 11 Mar 2023 13:25:33 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 11/03/2023 13:22, Jonathan Cameron wrote:
>>> On Sat, 11 Mar 2023 12:14:55 +0100
>>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>>   
>>>> The driver can be compile tested with !CONFIG_OF making certain data
>>>> unused (of_device_id is not used for device matching):  
>>>
>>> It should be used for device matching I think, so I'd rather see
>>> it assigned for that purpose than hiding the issue.  
>>
>> That would require testing and changes. The device matching is via SPI
>> table which has device data. Probably adding OF matching would require
>> bigger changes to for handling the match data.
>>
>> This was intentional design in this driver, so we are not hiding here
>> anything.
> 
> I doubt it was intentional. Mostly people do this because the magic
> fallbacks to find the spi_device_id entry work.
> 
> If we'd noticed at review time it would not have gone in like this.
> Note that the spi_match_id() use of_modalias_node() which has stripped the
> vendor id off the compatible then matches against the spi_device_id
> table.
> 
> So it 'should' just work.  Now ideally we'd switch to
> spi_get_device_match_data() but that needs more significant changes.
> Though simple enough ones that review would be enough.
> 
> Just need to use pointers to the ad75755_chip_info_tbl entries
> rather than the enum in both the spi id table and the of one - this
> avoids the issue with the enum value of 0 counting as a failed match.

It's not that simple change... maybe you are right that adding match
data to OF table would not break anything, but to me it is something
substantial and requiring testing, which obviously I cannot do.
Therefore I am going to skip this one (thus the error stays).

Best regards,
Krzysztof

