Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250B66C00C3
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 12:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjCSLUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 07:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjCSLUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 07:20:21 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859251E5FC;
        Sun, 19 Mar 2023 04:20:20 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id o12so36498142edb.9;
        Sun, 19 Mar 2023 04:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679224819;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nua7g9m8fXDvLK8bvfVNWIcYQvrDF3aMO7flTfqkskc=;
        b=nlH8TDRiOf7tV464M8Zg6oDfT/G5BJ/Rw3ubdtE13sMffnXyOtCuYDRXMYizgDEixq
         iv6LnVUicKlDNMXEVWZsThyWOOJkCdqOqrk27vqa76stenHvlpo5AR0FJ9nCqcPxd0S2
         2CuPQVM0VBioS1nKwryUDmalmQF1Wk5W4H5aJDNuMK1/k48aRQFx8I6JUa8DYBS6HW+Y
         R+yiONy3+C6bE/x0hDADxjIZorpcDCIokhYxou/unI7L3loYREBQP5bR8D2NlkXrxILc
         X45ZsS/XHH47G84mmM5CFFvhUXIS8hJYEzlq0guE/SE7tlG8UtLPWfoInARKdEefhAuL
         FQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679224819;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nua7g9m8fXDvLK8bvfVNWIcYQvrDF3aMO7flTfqkskc=;
        b=kK3ppnpRdO2OzVbIzot6OM+EpXxmQR0M9q+ig3kTvaVZnOXtSS0AMQmPFJUQbUyQU6
         eytk6/5WzmdPOOTyxaPXqZIvcY33YtanPf1OZfk4FQU8F6MV0FkWDBoWSP//5CMwVZ3T
         D9lqPprkRz5zf37hw3NA535ge4kYxSovU1SqsrhbEXYve7pUa+JI47wEwBdy6AVdgOc5
         W5Ufv66scad8C1Z2OY8CAIPlSKw1wunipE8gJWxCxnIUaQNR+8ljx+7iJmKZcd0a/yxn
         7xQjZusKimG6BLlDb5DIpoQEwbOY6zMGw+IZaobXM3ixFAkrJaHHakJP2bOREeABA33G
         ohmg==
X-Gm-Message-State: AO0yUKVisw4W5uUwQrwt1gNkyQ8yF5z+LGQU74ei7KkooLBfTFuM7+CW
        1Kjth7qezCeDxlZQx6KrVfI=
X-Google-Smtp-Source: AK7set+hMP0Nah50yyE+2WQIVAft6HUrTwLTTe4gn/WHdX6PnVkhIebOv6lo/3abMicENWh+Qktlhg==
X-Received: by 2002:a17:906:74dd:b0:92b:f3c3:7c5f with SMTP id z29-20020a17090674dd00b0092bf3c37c5fmr5474545ejl.53.1679224818910;
        Sun, 19 Mar 2023 04:20:18 -0700 (PDT)
Received: from [192.168.1.16] ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id lg10-20020a170906f88a00b008cc920469b5sm3183869ejb.18.2023.03.19.04.20.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 04:20:18 -0700 (PDT)
Message-ID: <b5a65ee5-5ae9-9f2e-16f9-906d64c4ac66@gmail.com>
Date:   Sun, 19 Mar 2023 13:20:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Outreachy
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dan Carpenter <error27@gmail.com>
Cc:     Michael.Hennerich@analog.com, jic23@kernel.org,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Outreachy Linux Kernel <outreachy@lists.linux.dev>
References: <ec13bbba-88ec-64b0-58ae-eee8617990b8@gmail.com>
 <8a30c3d1-a1a4-468c-a9f4-d15e0f418ef6@kili.mountain>
 <cdb828ad-855d-f7bc-d23e-17ed50750768@infradead.org>
 <48571e97-8766-e67d-c263-29fd67a31f06@metafoo.de>
Content-Language: en-US
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
In-Reply-To: <48571e97-8766-e67d-c263-29fd67a31f06@metafoo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On ١٥‏/٣‏/٢٠٢٣ ٢٢:٠٩, Lars-Peter Clausen wrote:
> On 3/15/23 12:24, Randy Dunlap wrote:
>>
>> On 3/15/23 07:03, Dan Carpenter wrote:
>>> On Wed, Mar 15, 2023 at 03:17:28PM +0200, Menna Mahmoud wrote:
>>>> Hi Mentors,
>>>>
>>>>
>>>> I am Menna, Outreachy applicant and I work on my clean-up patches.
>>>>
>>>> Is it Okay to work on this error reported by checkpatch script?
>>>>
>>>>
>>>> drivers/staging/iio/frequency/ad9832.c
>>>> --------------------------------------
>>>> ERROR: Use 4 digit octal (0777) not decimal permissions
>>>> #256: FILE: drivers/staging/iio/frequency/ad9832.c:256:
>>>> +static IIO_DEV_ATTR_FREQ(0, 1, 0200, NULL, ad9832_write, 
>>>> AD9832_FREQ1HM);
>>> What???  Is it complaining about the 0200?  That is octal. Why is
>>> checkpatch complaining about this?  Am I wrong?  Maybe I am misreading.
>>>
>>> I could investigate, but I am leaving that task to you.  It may be that
>>> checkpatch has a problem and you can fix that instead.
>>>
>> Yes, checkpatch seems to be confused here.
> It seems to make an assumption that everything starting with 
> IIO_DEV_ATTR_ has the mode field at the same position. Which is not 
> the case.
>
> https://github.com/torvalds/linux/blob/master/scripts/checkpatch.pl#L798
>
> Still a good target to get this fixed as part of a outreachy task.


I see, Thanks Randy and Lars-Peter for your help I will try check this.

