Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34E06DCDE1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 01:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjDJXN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 19:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjDJXNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 19:13:37 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5473C25;
        Mon, 10 Apr 2023 16:12:41 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id g3so7342442pja.2;
        Mon, 10 Apr 2023 16:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681168355; x=1683760355;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w2pu/Q9tC6woWsX5eYA7h2LnjeiP9LM5xH/fnPuGwas=;
        b=dNuLRTPRYm275ecTGqtgGoYnZrkeoM9tEOTogYbTjT0CHqxmEuf5MmiYbvO54JxQAe
         NOibCupxxc6IEdjlOqw73QuGuvRpvXd/Q6dAHavE3NOp1CcbeNNZ3tCk9DpoSNAvUNxL
         ID6GcUPcexcMFqaF0aozjfd/XlxRdZaxDexO2qtzYc0Oe/PSSoP2yEherIbbNM4BE1lo
         ixdAMbeoS2IJAKOTbYks1eGOBRaxwt+k71uuKEK11cmBcIHjWDAHh4G6bY338TcahGuo
         Itsq+pbZFpwTlKjhpAqxKEN8/mHyU3V4t1n+ryY8oH9Zfycu/uXnlYJ1iPmnh9d5+noj
         5YMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681168355; x=1683760355;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w2pu/Q9tC6woWsX5eYA7h2LnjeiP9LM5xH/fnPuGwas=;
        b=Kix+cbIx52upG5O4CTrd9ivvg8+WwkZ/WPGyQzaIXkF3R73QbyMmwmv/ZmnuRwSDrb
         1kYg7eTbkwf5Szc4GXywcNz9cGjUzL9t1/Mlc0eCSAIB89EBYZfSDG7rsC42Tu1fl7ad
         o3eHyIjnyG3GIbtMMOk378K5mwKPyecaAg4knoX7jQa5CIK1+ylkKwA4CNB3ufArlfp0
         L+kAo7Jr6fFOZESApo/wWavXNz4VMbl9LjxkwOqv0hcs5EPU/+O354vPvcEu+x/nENft
         TssRaHnagP8vrUtA3pslCPPrRDmLJajXXDQvkrLjg/3ZA3zVo1TFgyMCWSbxOumevGCe
         v9bw==
X-Gm-Message-State: AAQBX9d+UIPRJImZLFCZ/5TxlTwMe9WpOKoHN08dqsLYFL/GQArnY6I6
        mTSJXtyWeygGps7C0ZGbyRLXcP12U23/lA==
X-Google-Smtp-Source: AKy350ZDficuU/593PNroWmP5br0YdTUa+zA2WXrBeWQmOA8nbsKCEndPFwdVXzd19BDpmO36jOeAA==
X-Received: by 2002:a17:903:338e:b0:1a1:d215:ef0c with SMTP id kb14-20020a170903338e00b001a1d215ef0cmr11579153plb.16.1681168355057;
        Mon, 10 Apr 2023 16:12:35 -0700 (PDT)
Received: from [192.168.1.105] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id k21-20020a170902ba9500b001a1ccb37847sm8348645pls.146.2023.04.10.16.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 16:12:34 -0700 (PDT)
Message-ID: <1f4b874b-bd1e-17ff-51dd-19bf2d73214f@gmail.com>
Date:   Mon, 10 Apr 2023 16:12:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] Documentation: firmware: Clarify firmware path usage
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20230402135423.3235-1-f.fainelli@gmail.com>
 <87y1mzcq9y.fsf@meer.lwn.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <87y1mzcq9y.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/10/2023 3:43 PM, Jonathan Corbet wrote:
> Florian Fainelli <f.fainelli@gmail.com> writes:
> 
>> Newline characters will be taken into account for the firmware search
>> path parameter, warn users about that and provide an example using 'echo
>> -n' such that it clarifies the typical use of that parameter.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>   Documentation/driver-api/firmware/fw_search_path.rst | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/driver-api/firmware/fw_search_path.rst b/Documentation/driver-api/firmware/fw_search_path.rst
>> index a360f1009fa3..d7cb1e8f0076 100644
>> --- a/Documentation/driver-api/firmware/fw_search_path.rst
>> +++ b/Documentation/driver-api/firmware/fw_search_path.rst
>> @@ -22,5 +22,10 @@ can use the file:
>>   
>>   * /sys/module/firmware_class/parameters/path
>>   
>> -You would echo into it your custom path and firmware requested will be
>> -searched for there first.
>> +You would echo into it your custom path and firmware requested will be searched
>> +for there first. Be aware that newline characters will be taken into account
>> +and may not produce the intended effects. For instance you might want to use:
>> +
>> +echo -n /path/to/script > /sys/module/firmware_class/parameters/path
>> +
>> +to ensure that your script is being used.
> 
> So I have no problem with applying this, but I have to ask...might it
> not be better to fix the implementation of that sysfs file to strip
> surrounding whitespace from the provided path?  This patch has the look
> of a lesson learned the hard way; rather than codifying this behavior
> into a feature, perhaps we could just make the next person's life a bit
> easier...?

I was not sure whether it was on purpose or not, Greg, will we break 
anyone's use case if we strip off \n from the firmware path passed via 
sysfs?
-- 
Florian
