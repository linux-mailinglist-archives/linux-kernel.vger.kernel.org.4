Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C991D60C4B8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbiJYHHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiJYHG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:06:59 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F930625F1;
        Tue, 25 Oct 2022 00:06:58 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id b2so20397285lfp.6;
        Tue, 25 Oct 2022 00:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8043rJedakz3yZ0z90+IfFCIJlgzttal/kEkX/MKtrA=;
        b=qdKFnm3S7SOUrkHeDgmV5z/rDLyPWOnjojVEZuRyEfA9KEvVpoUwb43AQxJSehGvoq
         KPFMee2e/TKTZcT7OfM4WZoYTMK1vuAnAgCfAa3lr0qVrXqcdfLve0WU3oritH6w3hKm
         2eKz/qf2YCW1AWpeiwFjzFVHxpkdXK2CXPBShgXipEKsyd9MjF5A/YID2OfDrAscSPYz
         atfoA98C6IjFxDg1MGdNSCjvdRIg1PTT4YyJ6js1+tUrezlpWlKJrYpOGlvvVD3p9goX
         BdjvFQcRZM+t0wOa+IopHlspWX0ZFemeKls4TwQoaMsHCZRnwlIE79RRlJgAWcucswRH
         gC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8043rJedakz3yZ0z90+IfFCIJlgzttal/kEkX/MKtrA=;
        b=6Xd1aviWKU9tj99MMPQIgH7vwTFFr5xfXcldQoAHj3MDA/vOufXYPGJiefW3oBt3wB
         hy2msJJWo0elcMiBbEjXCUPlX8QBR/Js1rSd/zuqOaWxckIRR2WiKX4lx1ueDO17Mluq
         PxmtEILns41hLGo6TcuNgU6+SWd9poODs+X+35qVhSbcxjoHs1+HCLl/yysvbemV74b0
         lJn8l/L3UO81XBB3GLVf8McfnHQe5JTHilaZOpft//QWZCvnLSJXtH8tGni7/gvym5ui
         SRWEOQD91/R1uxNWPr3b/b49IeCGi6TPQBOVvJq3s4pPBBHzJ2ZZJ9QQvUpeUTP3INv3
         PNog==
X-Gm-Message-State: ACrzQf1pOF0lCouRgcG2TRVeKC6uRxbfa60PtqhAfMbO91vzwp2V9MQO
        TM7nirNPpm4QIy4s8LA21TWkDzB3ZqY=
X-Google-Smtp-Source: AMsMyM5iUHz31uhE/ItaKL0wiFjLAMYPJvIHN3fW28Tkw87cfMzGfsb+NObmNtIJBLV01dwyEsSmkQ==
X-Received: by 2002:a05:6512:a93:b0:4a2:a5b3:fbb4 with SMTP id m19-20020a0565120a9300b004a2a5b3fbb4mr12518720lfu.346.1666681616012;
        Tue, 25 Oct 2022 00:06:56 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::2? (dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::2])
        by smtp.gmail.com with ESMTPSA id i11-20020ac25b4b000000b004a91d1b3070sm275794lfp.308.2022.10.25.00.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 00:06:55 -0700 (PDT)
Message-ID: <cd6eb645-4663-40a6-c238-7c82123db1a4@gmail.com>
Date:   Tue, 25 Oct 2022 10:06:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Akhil R <akhilrajeev@nvidia.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <Y1dzCCMCDswQFVvO@dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi>
 <Y1eGwtqbOhXCGoaM@paasikivi.fi.intel.com>
Content-Language: en-US
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH] drivers: fwnode: fix fwnode_irq_get_byname() kerneldoc
In-Reply-To: <Y1eGwtqbOhXCGoaM@paasikivi.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On 10/25/22 09:48, Sakari Ailus wrote:
> Moi,
> 
> On Tue, Oct 25, 2022 at 08:24:24AM +0300, Matti Vaittinen wrote:
>> The fwnode_irq_get_byname() may return zero on device-tree mapping
>> error. Fix documentation to reflect this as current documentation
>> suggests check:
>>
>> if (ret < 0)
>> is enough to detect the errors. This is not the case.
>>
>> Add zero as a return value indicating error.
>>
>> Fixes: ca0acb511c21 ("device property: Add fwnode_irq_get_byname")
>> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> ---
>>   drivers/base/property.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/property.c b/drivers/base/property.c
>> index 4d6278a84868..df437d10aa08 100644
>> --- a/drivers/base/property.c
>> +++ b/drivers/base/property.c
>> @@ -960,7 +960,7 @@ EXPORT_SYMBOL(fwnode_irq_get);
>>    * string.
>>    *
>>    * Return:
>> - * Linux IRQ number on success, or negative errno otherwise.
>> + * Linux IRQ number on success, zero or negative errno otherwise.
> 
> I wonder if it would be possible instead to always return a negative error
> code on error. Returning zero on error is really unconventional and can be
> expected to be a source of bugs.

Agree, and I did also consider just adding:

if (!ret)
	return -EINVAL; (or another feasible errno)

return ret;

at the end of the fwnode_irq_get_byname().

However, such a functional change would require auditing the existing 
callers which I have no time right now.
if (someone is up to the task)
	be my guest :)
else
	please fix the doc ;)

Yours
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

