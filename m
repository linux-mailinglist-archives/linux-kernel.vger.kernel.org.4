Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE49F6F0EE3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 01:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjD0X3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 19:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344331AbjD0X3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 19:29:41 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534C32D6B;
        Thu, 27 Apr 2023 16:29:40 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1a667067275so71201965ad.1;
        Thu, 27 Apr 2023 16:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682638180; x=1685230180;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tfABu7Cc2LVPUFjUnfFsZx1Y3J2FYen/EYucbIUAmiM=;
        b=bB6ttVGdDlatWPnwYoqs9EpnA38tcqe6dI8rkdN0lUdtTiomKwPJyAKJVkbtqZ0628
         2Bz2Db0BDnMHrVjn3iuL/CrT7/TerOMRTTAm3sijJreV8OWlOBh3lqUjiRd0vDMxD9yv
         lVyzsdDqvBtaHDfXlsoP6J0v3/3z9A7s1/bBnXNaQeSrTes6G2PEsepIllHxoIIWJhVF
         QkHWry40uVZKJFw8jqwUgjIFvEqw7+u5Ptq20Jv3QkuWaEmkXskEcffjv57LEPGXt4ol
         e4inqVBHiptE+YK28eptMcW86cpYiBVN6jykZ6mnYopA/pmR9qNsv6LitUBIQWSjMDaL
         VBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682638180; x=1685230180;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tfABu7Cc2LVPUFjUnfFsZx1Y3J2FYen/EYucbIUAmiM=;
        b=Hsj7z8arCnFBd9kTB5q/a3Qv1r6I/AHMFxroCzWz2skZvNKl8IZ1eZ6kN8zQJmmslW
         AyjanV2o/qnVo9lJC8hLBz1Jlx3PS/LDR0uPEIzMiicYUzSThrIVcgnzXgBJwhcx7puK
         7qllE6pP++Vx++9oRZd4+p9Mv9l4fTl94YkV4Xqn5toBJfhIoFZnfhKblxlrGWJoJYwT
         v8Srg3YqgoOn3T2SKr7hyk45gPpYRxFBAEiaMtKAxE5A/kBRbBahStdhKmEaO8qzMShR
         3szH7LJKWmHeZrfGX+Q1v9ggiEXNFSQAktngqAnmz6Y5M1vMt1MTwmSi2YxWHAhT035g
         QXzg==
X-Gm-Message-State: AC+VfDwijJ5L93W8XYKaFYu/a2iiKKDPP/il9rK6yVCfF6sClRru7us7
        Hb23H0KlNVbEqru54rf/v1M=
X-Google-Smtp-Source: ACHHUZ4+LxQiAZFcsCO3jxQhJcObopxUPcV8H3quHLqumCeHYnO9PWdu3969Yc9tzcIQEcM2NIAmJw==
X-Received: by 2002:a17:902:ebd1:b0:1a6:52f9:d4c7 with SMTP id p17-20020a170902ebd100b001a652f9d4c7mr3052365plg.60.1682638179758;
        Thu, 27 Apr 2023 16:29:39 -0700 (PDT)
Received: from [10.69.53.73] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id jl13-20020a170903134d00b001a9666376a9sm8330235plb.226.2023.04.27.16.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 16:29:39 -0700 (PDT)
Message-ID: <a8e21766-266c-c0dc-157c-c6951a5727a7@gmail.com>
Date:   Thu, 27 Apr 2023 16:29:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 2/2] serial: 8250_bcm7271: fix leak in `brcmuart_probe`
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Al Cooper <alcooperx@gmail.com>,
        XuDong Liu <m202071377@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Jiri Slaby <jirislaby@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230427181916.2983697-1-opendmb@gmail.com>
 <20230427181916.2983697-3-opendmb@gmail.com>
 <37c23054-1590-b33d-9299-7d5d6198f8f0@wanadoo.fr>
From:   Doug Berger <opendmb@gmail.com>
In-Reply-To: <37c23054-1590-b33d-9299-7d5d6198f8f0@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/2023 1:29 PM, Christophe JAILLET wrote:
> Le 27/04/2023 à 20:19, Doug Berger a écrit :
>> Smatch reports:
>> drivers/tty/serial/8250/8250_bcm7271.c:1120 brcmuart_probe() warn:
>> 'baud_mux_clk' from clk_prepare_enable() not released on lines: 1032.
>>
>> The issue is fixed by using a managed clock.
>>
>> Fixes: 41a469482de2 ("serial: 8250: Add new 8250-core based Broadcom 
>> STB driver")
>> Reported-by: XuDong Liu <m202071377@hust.edu.cn>
>> Link: 
>> https://lore.kernel.org/lkml/20230424125100.4783-1-m202071377@hust.edu.cn/
>> Signed-off-by: Doug Berger <opendmb@gmail.com>
>> ---
>>   drivers/tty/serial/8250/8250_bcm7271.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_bcm7271.c 
>> b/drivers/tty/serial/8250/8250_bcm7271.c
>> index 90ee7bc12f77..af0e1c070187 100644
>> --- a/drivers/tty/serial/8250/8250_bcm7271.c
>> +++ b/drivers/tty/serial/8250/8250_bcm7271.c
>> @@ -1012,7 +1012,7 @@ static int brcmuart_probe(struct platform_device 
>> *pdev)
>>       of_property_read_u32(np, "clock-frequency", &clk_rate);
>>       /* See if a Baud clock has been specified */
>> -    baud_mux_clk = of_clk_get_by_name(np, "sw_baud");
>> +    baud_mux_clk = devm_clk_get(dev, "sw_baud");
> 
> If switching to devm_clk_get(), maybe devm_clk_get_enabled() could also 
> be an option to fix both issues and avoid adding some LoC.
> 
> The order of operation in the remove function would then be different. I 
> don't know if it can be an issue.
I like the idea, but it doesn't backport to the source of the error.
I'll try to remember to submit something after the merge closes.

> 
> Just my 2c.
> 
> CJ
Thanks!
     Doug

