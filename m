Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB1E5BF71A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 09:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiIUHKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 03:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiIUHJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 03:09:40 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2C782D0C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:08:56 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id q17so5814176lji.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=UpnmxEZjYtOG6g/lpNXAceVawQxLWFCGGEaQrDHy5V4=;
        b=CpjuGH7fQ3hfn0TArXKJBCYatTvVXo5Hnq/Xt7HFV6pvjSQMFDv4By3E8wxD3tnnNz
         k/PHTrQi3V+0/7Ctfe1q4iBr9LG/qFaCejdFc3GeRVdkbh7th3zf7e53tTs2qU51ZHet
         cHEoHqShQvIe1l1nZThOW6MVl4+ijLd1vMyqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=UpnmxEZjYtOG6g/lpNXAceVawQxLWFCGGEaQrDHy5V4=;
        b=OdKLSGRjWFbnwfheZlRUQhPyVoN9VjJrfPBDNtyaJZn00s4IwhzTEYqMz42b+EF9pd
         pzmQYIJzEMPNVUYwJmHcJa/G3PjZetQzixN7y3/rpu+Yt97eixicBDqLa/vM1qEqS0YK
         Zkm1pLjIxUJ9+7H0LMAj1eOYh2MBpWbKXtFerkSIsq4NxhNDbuY+qaNWDdEgVSaX9DmY
         OwFQOR1h+yikjrgIJk98UdolUOMwEYDc5CcsoZVK90/ctRLrVcfxCmrZF6FgnMF344cK
         G7El5MsslBKi/Qx6jKyqNy23O3OZzKhPqZWsMW+xwDa6F8C56B7x9xm6EzNLzVpKw2NS
         jRFQ==
X-Gm-Message-State: ACrzQf3XkLSQYms1T1qKCOTswUJpdoDItheyiU3jKjimJCc2vZ3SU8ye
        VOh4x5V6Ub+FN5OdhL32+LYlmpmW0Hndu7/V
X-Google-Smtp-Source: AMsMyM5ym1ZyeDbfxTShbmvZgQ4KMmkg6nQqN1T0yNgq8tr5nRsRPZgIQ2nsDVOkvnR+UHG25qYmXQ==
X-Received: by 2002:a2e:940b:0:b0:268:fa1c:106f with SMTP id i11-20020a2e940b000000b00268fa1c106fmr7905996ljh.101.1663744134250;
        Wed, 21 Sep 2022 00:08:54 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id b15-20020a19644f000000b00499fe9ce5f2sm307894lfj.175.2022.09.21.00.08.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 00:08:53 -0700 (PDT)
Message-ID: <4fdd52c9-2de7-b86b-f081-cb59a8f72c5a@rasmusvillemoes.dk>
Date:   Wed, 21 Sep 2022 09:08:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/6] rtc: isl12022: simplify some expressions
Content-Language: en-US
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220830100152.698506-1-linux@rasmusvillemoes.dk>
 <20220830100152.698506-3-linux@rasmusvillemoes.dk>
 <YyHugb47cJPNuHbs@mail.local>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <YyHugb47cJPNuHbs@mail.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2022 17.08, Alexandre Belloni wrote:
> Hi,
> 
> On 30/08/2022 12:01:48+0200, Rasmus Villemoes wrote:
>> These instances of '&client->dev' might as well be spelled 'dev', since
>> 'client' has been computed from 'dev' via 'client =
>> to_i2c_client(dev)'.
>>
>> Later patches will get rid of that local variable 'client', so remove
>> these unnecessary references so those later patches become easier to
>> read.
>>
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> ---
>>  drivers/rtc/rtc-isl12022.c | 11 +++++------
>>  1 file changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
>> index 2dc19061cf5f..5e6bb9153c89 100644
>> --- a/drivers/rtc/rtc-isl12022.c
>> +++ b/drivers/rtc/rtc-isl12022.c
>> @@ -112,13 +112,13 @@ static int isl12022_rtc_read_time(struct device *dev, struct rtc_time *tm)
>>  		return ret;
>>  
>>  	if (buf[ISL12022_REG_SR] & (ISL12022_SR_LBAT85 | ISL12022_SR_LBAT75)) {
>> -		dev_warn(&client->dev,
>> +		dev_warn(dev,
> 
> While at it, I would prefer that one to also become a dev_dbg

Well, I prefer to keep it, because my customer actually wants to use
this information. Grepping it out from dmesg is of course not the best
interface, but if it gets demoted to a dev_dbg() it doesn't even get there.

I'll address your other comments and respin. Thanks.

Rasmus
