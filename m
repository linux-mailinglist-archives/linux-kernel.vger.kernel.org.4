Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916656A338F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 20:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjBZTN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 14:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBZTN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 14:13:56 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F1CC172
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 11:13:55 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so3471878pjg.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 11:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CWOVPk6zTBjsO6jxFdvrtyavLkpi6cpxQJZJr0PeRDk=;
        b=n8TYcMXsLN1VX40X8dOnGNCq2FQpNncZQ+c4t0IpT0IDpdVGu5cvtUzAw0a26eyLwG
         l/WqsCbsyXC+9U83AxnS637ZvM/0kPhfr8Z1giWL2fpS6ehlmpulS8L9ohGq4bGxXUpf
         9w6KyavslPB/dPp5ycp+GeFbep2B/YdmJMt9FyJYZHOsHj5CMxRPAmg7dbseHsiDgYGE
         N97NSM8Tx0tnqEYccXGqaS9HlRMeN9AMOShH2Wn1KovU/Ke2JmUQLZYk4gswN5WiIsfB
         TvIrUZuF49zP5+oVqIm1oGFuFWD1ZHcml5equ9vtxVsCsvdFznQFODvHRnH0j8tH8bpW
         RUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CWOVPk6zTBjsO6jxFdvrtyavLkpi6cpxQJZJr0PeRDk=;
        b=yrtSTXEOeVeML+5uabWprancLV64LQC4TS6IMkmd23eVtrTZYTwlVAh00r2t7r7yRS
         f1US+YSBzp2zo1jpPLUmb1pCqo9T6wJja6xGRFFIkP3NyZAOR/B0zxUG0gvKsw0Ic/g/
         FTB9Xtk+KT8Ml8jqLtfXxoQPpCqzrLC5XyCRRTLvZBh2Yz6yGQgNgyoXm9hzJAOI2lvF
         +W/phAeTnVBuBwiR1lwtLYhD6huS67sHdlPVFt3AaVbAiemwPCz0HiNSDQXNnblQTRH6
         x9cZES4IxqC644asyfcHHdt2dbpYcDvTbGXADSC3aGDnQ5qQDC1hc6h6wZHLc1RATX8v
         T7gA==
X-Gm-Message-State: AO0yUKUmUX4n4mu2l+B0IjVQHLjzipC82UC/8vVT3VsYPuVM6MsuuY5i
        NdSzCPM5/Tn6SynTb0VMLO4GMq/AGOY=
X-Google-Smtp-Source: AK7set87aNNlVEfhtFCOdE5xdyYZTTB7Omd4TMoCkWepuoe4cWq9vaI8T5fypsuEzJBUPGBKVG+YZw==
X-Received: by 2002:a17:903:22c8:b0:198:fded:3b69 with SMTP id y8-20020a17090322c800b00198fded3b69mr27251019plg.53.1677438835096;
        Sun, 26 Feb 2023 11:13:55 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:4a48:1c16:31cb:9a06:c73e? ([2600:8802:b00:4a48:1c16:31cb:9a06:c73e])
        by smtp.gmail.com with ESMTPSA id iw19-20020a170903045300b0019c33ee4730sm2749320plb.146.2023.02.26.11.13.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Feb 2023 11:13:54 -0800 (PST)
Message-ID: <f13906c0-1a0c-dfa4-dcd3-96ebc82aabd8@gmail.com>
Date:   Sun, 26 Feb 2023 11:13:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Raspberry Pi 4B: Failed to create device link with
 soc:firmware:gpio
Content-Language: en-US
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
References: <03b70a8a-0591-f28b-a567-9d2f736f17e5@gmail.com>
 <CAGETcx-KLfxKae6-Kc74gOu2fiuu+5528j_TNEaY21U3_yZO0w@mail.gmail.com>
 <0fa79232-18f7-af96-e116-a71b735a903d@gmail.com>
In-Reply-To: <0fa79232-18f7-af96-e116-a71b735a903d@gmail.com>
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



On 2/25/2023 5:58 PM, Florian Fainelli wrote:
> 
> 
> On 2/25/2023 4:01 PM, Saravana Kannan wrote:
>> On Sat, Feb 25, 2023 at 7:38 AM Florian Fainelli 
>> <f.fainelli@gmail.com> wrote:
>>>
>>> Hi Saravana,
>>>
>>> Using v6.2-10217-ga93e884edf61v my Raspberry Pi 4B issues the following
>>> for the "extended GPIO" provider:
>>>
>>> [    5.969855] uart-pl011 fe201000.serial: Failed to create device link
>>> with soc:firmware:gpio
>>
>> Outside of this error, is it actually breaking anything? 
> 
> There is just this warning, there does not appear to be a functional issue.
> 
>> Also, can you
>> pull in this patch and tell me what it says? I want to know what the
>> flags are.
>> https://lore.kernel.org/lkml/20230225064148.274376-1-saravanak@google.com/

Pulling in this patch results in the following being printed:

[   14.866835] uart-pl011 fe201000.serial: Failed to create device link 
(0x180) with soc:firmware:gpio

>>
>> Can you also change every pr_debug and dev_dbg in drivers/base/core.c
>> to an info and then give me the logs as an attachment?
> 
> Sure will do.

Please find the log here:

https://gist.github.com/4e7e5e09ebfb3994505c917a8c0892d6

Thanks
-- 
Florian
