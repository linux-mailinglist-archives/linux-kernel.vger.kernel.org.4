Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD455E7C4F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 15:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbiIWNvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 09:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiIWNvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 09:51:32 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5DD127574;
        Fri, 23 Sep 2022 06:51:31 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id u69so317723pgd.2;
        Fri, 23 Sep 2022 06:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=vQ7OXxgt3UHb9qns2oREalFT54VGNY8TnAzMaOLw5z0=;
        b=ViQdxJI8Jnzvtb8tZHcp7/WLK2JxnpPajBdwHraR4DjPdGbIRpxfNpk5CCMiljJRoi
         dvCe4TGC+NKoF+bDuk7ynMT/sAKuHotUgTlBLfWRWChAUyaTbpQZhNxUqWNRr3HFT3ZK
         Q/7r0QGtZpPd+OLM1CVjy217ZAiFPrsM1AOSUWrC3VNfoC7mUO0YFdj3O6TLOsfUTpGo
         TEdCxOBz/9H13Z6K2cW6eA7XHiOtQYf7DO8qqcwV4mWBmCGzmkDlDp0tsX1OHotdPg0h
         CFKVzqJpN1+WZyuMaTkO4ZAUJzdRo71fr4JKPxLeK8Zn8pPrAdmVkMsvd98/tazy8zmZ
         B18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=vQ7OXxgt3UHb9qns2oREalFT54VGNY8TnAzMaOLw5z0=;
        b=o3ZO0eSXdumT7mWkeJvGnqg9gifcp6Tv8WcrND0syzopgvCAD9QWb21whz/0+K+Bwe
         uwRAP05FAkrJcseHhRr3fyvjpW+xLxj0uRXsC0527NrrsZJLZ9B/OH8jQW4CNAK5sfNN
         K+VcRbM16WGWdyg5HF3EeGwWpSkbpCbInenWNfgehBqD/Abre9RaUrVLg4OFoQHuIAuk
         kY6yf4RtvHJaoI10quoVetADfO9DWMGxOJYNlqOEeqonFBCl/6pFStCAshGu6+PUgEd7
         dJwe7NQqvOKDnjA0zaGotb7DK1X3TWmnc5+A4B3v75RTEBYTYerKMwctWGrzV8J8Tyve
         hZXQ==
X-Gm-Message-State: ACrzQf23gPM++IAtscx9lrdfCarbYs+ogqc1aL07K0txfIZsmUJ009gk
        4T3ALkl0VLG3tQFlYlK6T/DevURSavGH6w==
X-Google-Smtp-Source: AMsMyM6A9EF9xffEXk+S/8BHhmmPiZtxIh9rRWv9NDT3Oqo5tfjnCx0xM0RroT2qDR/ppMjXM8PnQA==
X-Received: by 2002:a63:f050:0:b0:439:db24:8b07 with SMTP id s16-20020a63f050000000b00439db248b07mr7451289pgj.60.1663941090818;
        Fri, 23 Sep 2022 06:51:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ix12-20020a170902f80c00b0016b81679c1fsm5993698plb.216.2022.09.23.06.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 06:51:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <56cc6788-d54b-2f2f-32b2-a318adabf97a@roeck-us.net>
Date:   Fri, 23 Sep 2022 06:51:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 9/9] rtc: isl12022: add support for temperature sensor
Content-Language: en-US
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <20220830100152.698506-1-linux@rasmusvillemoes.dk>
 <20220921114624.3250848-1-linux@rasmusvillemoes.dk>
 <20220921114624.3250848-10-linux@rasmusvillemoes.dk>
 <8cb2bac1-3a03-09a1-c071-96ca4a95fa44@roeck-us.net>
 <62a262a1-b945-ad4f-fdb8-d05fcba882d3@rasmusvillemoes.dk>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <62a262a1-b945-ad4f-fdb8-d05fcba882d3@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/22 01:40, Rasmus Villemoes wrote:
> On 21/09/2022 16.13, Guenter Roeck wrote:
>> On 9/21/22 04:46, Rasmus Villemoes wrote:
> 
>>> +static int isl12022_hwmon_read(struct device *dev,
>>> +                   enum hwmon_sensor_types type,
>>> +                   u32 attr, int channel, long *val)
>>> +{
>>> +    if (type == hwmon_chip && attr == hwmon_chip_update_interval) {
>>> +        *val = 60000;
>>> +        return 0;
>>> +    }
>>
>> It is not the purpose of the update_interval attribute to inform the
>> user what the update interval of this chip happens to be. The purpose
>> of the attribute is to inform the chip what update interval it should use.
> 
> Well, I think it's a completely natural thing to expose a fixed and
> known update_interval as a 0444 property, and it might even be useful to
> userspace to know that there's no point reading the sensor any more
> often than that. And I didn't come up with this by myself, there's
> already at least a couple of instances of a 0444 update_interval.
> 

That doesn't make it better. It is still an abuse of the ABI.

Guenter
