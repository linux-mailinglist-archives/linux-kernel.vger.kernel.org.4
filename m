Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32102606B51
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 00:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiJTWhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 18:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJTWht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 18:37:49 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE8B1C20B2;
        Thu, 20 Oct 2022 15:37:48 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1322fa1cf6fso1371749fac.6;
        Thu, 20 Oct 2022 15:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=z3SGi30j7hFN3YbuFDduStPgqshj7yXMDHLAjGLiyeY=;
        b=PSO+4So0AYkxGI24LGhGHcIwtS7rQOeehTspOoBE0bCvAAGBhtrI7YUyy75ohLbMS6
         f0vh3O1aokYrbHvVga1e1nhY3V1C82hj6xQ8Oxo9oqyIjOfhid/PHPpW+1ojOJUUSdCA
         1FpX9LvjSbghks0tM7W4x39q/5ZzA8JyfGL7PMii3u8RlS3Aw1m5N3l8OwxO10ojybxf
         FX3N7nwnJNsJsmBnqEGFbjuj3sBx5PNN1oPY4t+WSoaWrY/fc5V7Reuryu2ADUuoJaB6
         adGDmhMZ31wQFFNWeaEhUb30aWunfcEnZLI49YBmOjq3pa9UrTAb2H85x37GBb4Otph6
         k+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z3SGi30j7hFN3YbuFDduStPgqshj7yXMDHLAjGLiyeY=;
        b=scjWB/cqdTrU4Wiz0PAmOaXD8WEVow0l24noYjYcbg/jlVJ2eZzJyoXC4pJzTVJCk9
         O7rZdGMd7rXAMx60ItsMhz12reaymfviePo5g4HL8cBSeBvPPGCZcoyBy8Mo71hwLjLj
         j27qhNyMypi0SD5/p9NJifsuiwochyUA0EY/YKWGDD+pPHiL0VGDEyktgLt+pZMPPXzr
         Cc2NJ8hRLm00Z132VDJxmeIYM9ZQf0Qd0wMJ5pyo5VxQC5SBpwFWFHqBNv+41Px4BzD3
         gJgoOlVJmWjRQLXpI5WVJmMJmI6Ce8tc6uVKRZnj7j/o0LaQWUh9htAEmET4PFzLDI6F
         8VNQ==
X-Gm-Message-State: ACrzQf0lsLj7WKOTaLUAmLSjNlN4USnVx5iMF6gMTvxYZNK3mTtYj2w1
        d5cDK6bIBda4z2rDN9wbMyA=
X-Google-Smtp-Source: AMsMyM4YZllEZu9hVOKnIRboHVpiVMwXKsI5fQCdYA9QwWs+Eur9DZIeOTyDL26wrL30rnJRH2Uwlg==
X-Received: by 2002:a05:6870:c8a2:b0:136:5491:8f08 with SMTP id er34-20020a056870c8a200b0013654918f08mr26250667oab.225.1666305468183;
        Thu, 20 Oct 2022 15:37:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s4-20020a056870248400b00136cfb02a94sm9475643oaq.7.2022.10.20.15.37.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 15:37:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e2fadcfa-aedc-ded4-8867-5f2525852af6@roeck-us.net>
Date:   Thu, 20 Oct 2022 15:37:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC PATCH v2 4/4] hwmon: (jc42) Don't cache the temperature
 register
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-hwmon@vger.kernel.org, jdelvare@suse.com,
        linux-kernel@vger.kernel.org
References: <20221020210320.1624617-1-martin.blumenstingl@googlemail.com>
 <20221020210320.1624617-5-martin.blumenstingl@googlemail.com>
 <20221020221417.GG4035307@roeck-us.net>
 <CAFBinCB3oKxdCNbjAtO+tw+yGrb1oBJwtHxCh_ptTPB6MTw5uA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAFBinCB3oKxdCNbjAtO+tw+yGrb1oBJwtHxCh_ptTPB6MTw5uA@mail.gmail.com>
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

On 10/20/22 15:22, Martin Blumenstingl wrote:
> Hi Guenter,
> 
> On Fri, Oct 21, 2022 at 12:14 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Thu, Oct 20, 2022 at 11:03:20PM +0200, Martin Blumenstingl wrote:
>>> Now that we're utilizing regmap and it's regcache for the
>>> minimum/maximum/critical temperature registers the only cached register
>>> that's left is the actual temperature register. Drop the custom cache
>>> implementation as it just complicates things.
>>>
>>
>> Ah, you got there eventually. Just combine this patch into the first
>> patch of the series. No need to keep separate patches, especially since
>> a lot of the code changed in patch 1 and 2 is just thrown away here.
> Thanks again for the quick response and for the great feedback. I'll
> combine the patches tomorrow and send a v3!
> 
>> That reminds me, though: Make sure that the alarm bits are not dropped
>> after reading the temperature (running the 'sensors' command with
>> alarms active should do). I have some JC42 chips here and will do the
>> same.
> I configured below ambient high and crit temperatures:
>    jc42-i2c-0-1a
>    Adapter: SMBus PIIX4 adapter port 0 at 0b00
>    temp1:        +35.0°C  (low  =  +0.0°C)                  ALARM (HIGH, CRIT)
>                          (high = +25.0°C, hyst = +25.0°C)
>                          (crit = +30.0°C, hyst = +30.0°C)
> 
> Then I ran "sensors" three times in a row.
> The output of all "sensors" commands is the same, meaning all of them
> show the ALARM (HIGH, CRIT) part.
> 

Excellent!

> Do you want me to mention this somewhere (for example in the
> cover-letter or the new patch #1)?
> 
Yes, please mention it in the cover letter.

Background for the question: Some older sensor chips (granted, typically
20+ years old) tend to reset the alarm status after reading it, only
to set it again after the next measurement cycle.

Thanks,
Guenter

