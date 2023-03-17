Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A661D6BE911
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 13:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjCQMSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 08:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjCQMSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 08:18:30 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EFA2278E;
        Fri, 17 Mar 2023 05:18:29 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id j6so2632590ilr.7;
        Fri, 17 Mar 2023 05:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679055508;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8AcaGHDHcERLiQBg3HARB73c5KMQHhhDF9x20pYjWh8=;
        b=NKzaHAD/eGbZ9kLyby3FfZ2jei9z3Z14c+zbdDB6W/l2m8cxWLbyNl8KMda0I1IcaT
         KZ4Gq+AS7Lcw+myylmTJo8N1YDa0BZW8f5zJgiMLza3EpntKgGrC4FJSw0/anBWt0BUp
         gDpXBuLWkVRe5Ro2KV4QscJ2MB8wSkfdQsP5RecU5TRtFKnlGrIWzcHYWvPu4nP9KAXw
         +ZM7bc7eDkollCIPpalrM83ATq0lBeO5YX7mO9KYT97FOXtZj880qcgD/RxDedIgvfer
         0sMlXv6EYzpKCUGn0KEyiajatGj61rfSV2q5ZPsBHo6vLZQ1+YxUfU0E/EjYt+U3LijX
         0W8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679055508;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8AcaGHDHcERLiQBg3HARB73c5KMQHhhDF9x20pYjWh8=;
        b=Tmqmb918oQlq3/kkbjLKZNWpVcaMvYMuZhWJj6kpaNoHXM3MS+CgSU5jkwc5AGFe7S
         rbxtrThq9/YorFZppic/A/1wRG8FhZeBR/M594vg201UuP+dpyiqgJ2Mi3X0pWF/JxaJ
         5pt10xyfSi4x2+m4r6QVp688CxJXta+DkV3f6dzGZvvyshOSx9CA2J03ttH3AMQyi1jh
         wWuBBDMlRgI9QeGOHTgfQtD3GqluBIwsoc+RUqm//BeIWHTRCofxnqCaSIxoBeBEf9hJ
         D0UBYI/3pUU5L+ZYZK1Y0wxhn50XgzrbSJx9Sq/yGAEO3NCwqiksPgY4g9zZ4KwaNE0V
         psTQ==
X-Gm-Message-State: AO0yUKV269SJhqup/zH9nV//aM+JR1xegMZw29/g0JbqJbKQfIt6DHci
        ceQ0S6EFFjc6orRpJtC61z8=
X-Google-Smtp-Source: AK7set9j8Pt67CPWTNkS3pMQLQ0qOlX/G7nhNs0cBkg8OELH9E4+ra8smNo8aYkqI4EAvQAlUB8XVw==
X-Received: by 2002:a92:d792:0:b0:324:5df7:d454 with SMTP id d18-20020a92d792000000b003245df7d454mr1417491iln.10.1679055508482;
        Fri, 17 Mar 2023 05:18:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c28-20020a02331c000000b0040071bcb216sm650670jae.102.2023.03.17.05.18.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 05:18:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2e80d283-b1ff-3648-9cae-47037cfe799d@roeck-us.net>
Date:   Fri, 17 Mar 2023 05:18:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] usb: typec: tcpm: remove unnecessary (void*) conversions
Content-Language: en-US
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Yu Zhe <yuzhe@nfschina.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, liqiong@nfschina.com
References: <20230316082338.18388-1-yuzhe@nfschina.com>
 <ZBRPDz4vn0x8hzd0@kuha.fi.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <ZBRPDz4vn0x8hzd0@kuha.fi.intel.com>
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

On 3/17/23 04:29, Heikki Krogerus wrote:
> On Thu, Mar 16, 2023 at 04:23:38PM +0800, Yu Zhe wrote:
>> Pointer variables of void * type do not require type cast.
>>
>> Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
> 
> I would have prefered that both drivers are patched separately in
> their own patch, but that's minor. If Guenter is OK with this then:
> 
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 

I seem to have missed the original patch. Anyway, lgtm

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

And, yes, those should really have been separate patches, one per driver.

Guenter

>> ---
>>   drivers/usb/typec/tcpm/fusb302.c | 2 +-
>>   drivers/usb/typec/tcpm/tcpm.c    | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
>> index 1ffce00d94b4..4b7b8f6af3ca 100644
>> --- a/drivers/usb/typec/tcpm/fusb302.c
>> +++ b/drivers/usb/typec/tcpm/fusb302.c
>> @@ -190,7 +190,7 @@ static void fusb302_log(struct fusb302_chip *chip, const char *fmt, ...)
>>   
>>   static int fusb302_debug_show(struct seq_file *s, void *v)
>>   {
>> -	struct fusb302_chip *chip = (struct fusb302_chip *)s->private;
>> +	struct fusb302_chip *chip = s->private;
>>   	int tail;
>>   
>>   	mutex_lock(&chip->logbuffer_lock);
>> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
>> index a0d943d78580..e8bfe3f57ab4 100644
>> --- a/drivers/usb/typec/tcpm/tcpm.c
>> +++ b/drivers/usb/typec/tcpm/tcpm.c
>> @@ -737,7 +737,7 @@ static void tcpm_log_source_caps(struct tcpm_port *port)
>>   
>>   static int tcpm_debug_show(struct seq_file *s, void *v)
>>   {
>> -	struct tcpm_port *port = (struct tcpm_port *)s->private;
>> +	struct tcpm_port *port = s->private;
>>   	int tail;
>>   
>>   	mutex_lock(&port->logbuffer_lock);
>> -- 
>> 2.11.0
> 

