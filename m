Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489E16933C8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 21:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjBKUtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 15:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBKUtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 15:49:01 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4520417CE7;
        Sat, 11 Feb 2023 12:49:00 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id v24-20020a05683011d800b0068bdd29b160so2621362otq.13;
        Sat, 11 Feb 2023 12:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=SBF8oeuFweutBaHY9bvdsWw6FssTNusRjuc4E0c5qWI=;
        b=H3JhajLSBfKlLrVazgehNI5J11F8fC/9A2+KRvtOyynydz2bvljufHVanOEFPMoXSI
         UxOpcAM4bh4Y9NDG3ZBYYnnQ7Hffvm6CZaWPlGD9pPfLg317n0c2qVtogH8MUM5MjQKD
         RZp7/YlyJiUX/0fVwVJY+NcH9CqBqAoVWdbWh+ZRgXxnXr9BUxRG/4b7LDWYlQS+33ki
         xeolk27T9i8I240ODrPdq+wgS0h0McD+KuU/t6/n2McKeSK9vwlJ78bkKFW4DVn8KvZG
         Uo/Y515IG/LXmOPnfiWaNEPKESKcGEL9u0a9j/i8jEtsf4TZtiiQKi+TxdVgdx0/R1J6
         tmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SBF8oeuFweutBaHY9bvdsWw6FssTNusRjuc4E0c5qWI=;
        b=UojD3oFZJFVXNSY6fADnoWBxPPcZVfQDqVlEEv1YKx4VEf2voWwiBG890u4eOQx480
         CdwIOAGo5XVjjfRywcDcP9J2b7VbXSJ9R+j7Hb4CJbMkLX481Y3Cv3WrPPpS535DEpAu
         aU+XNVkVzcxOoqQ9xdZ0zs+ZyUg42kJmnfmPapy8HSH3Yc7bJOgEne68Uex2EcIppRgV
         s2lk307vZb8WITB70kGJeuPXNf/H8QmBuRTqYHCGonAD0FeHYgReSxxQ0DjaYGFXGaI3
         ev27rutson/fFl/Ybqh6LIvBPnaMh3KsFPMCs560SzWHT9tVN+vzoNugYxZokTkG3otR
         m4rA==
X-Gm-Message-State: AO0yUKWEaXPxKPTCgUPnDHTob3FrzEiUCBvXNlFexTmjdCGHHDWnek9y
        NxitV4v3fIPleTkYfWSze58=
X-Google-Smtp-Source: AK7set92tBJBCDr6QmPHXt7/4PxMOuvxo1FV+2qPxCKe739R2sTqZdDClUwR7kJYUxnmlvujunHmwA==
X-Received: by 2002:a05:6830:18fa:b0:68d:c15e:7146 with SMTP id d26-20020a05683018fa00b0068dc15e7146mr8267157otf.20.1676148539123;
        Sat, 11 Feb 2023 12:48:59 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f14-20020a9d6c0e000000b00670461b8be4sm3458657otq.33.2023.02.11.12.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Feb 2023 12:48:58 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <904da857-2e27-87a1-4541-6288df564d80@roeck-us.net>
Date:   Sat, 11 Feb 2023 12:48:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/5] hwmon: (aquacomputer_d5next) Add temperature offset
 control for Aquaero
Content-Language: en-US
To:     Leonard Anderweit <leonard.anderweit@gmail.com>,
        Aleksa Savic <savicaleksa83@gmail.com>,
        linux-hwmon@vger.kernel.org
Cc:     Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230211165923.17807-1-leonard.anderweit@gmail.com>
 <20230211165923.17807-4-leonard.anderweit@gmail.com>
 <0664b935-d201-419a-3f1d-3df4226a8db1@roeck-us.net>
 <00875064-0407-b114-56c9-87aecb0d3ee4@gmail.com>
 <b716a9ec-93ba-7c42-c8d3-1d6db950ad7b@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <b716a9ec-93ba-7c42-c8d3-1d6db950ad7b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/23 11:48, Leonard Anderweit wrote:
> Am 11.02.23 um 19:54 schrieb Aleksa Savic:
>> On 2023-02-11 19:08:27 GMT+01:00, Guenter Roeck wrote:
>>>
>>> aquaero is already supported, and the checksum is so far generated
>>> and sent. Is it ignored ? Also, is it guaranteed that _all_ aquero devices
>>> don't need it ?
>>
>> Reading its sensors is currently supported, not writing to it (before these
>> patches).
>>
>> The checksum is ignored and not needed for either aquaero 5 (which Leonard has)
>> nor 6 (which I have).
>>
>>>
>>> If it is not needed and ignored, does it really add value to selectively drop it ?
>>
>> I think we can indeed remove that check.
> 
> I don't think that check can be removed as the checksum is not appended to the control report but is in the last two bytes. So using the checksum on Aquaero will overwrite the data at that location. It is currently unknown what these two bytes do so I do not want to overwrite them.
> 

The current code _does_ overwrite those bytes, or am I missing something ?

If so, changing that would be a bug fix which really should not be hidden
in a patch making functional changes.

Thanks,
Guenter

>>
>> Thanks,
>> Aleksa
>>
>>>
>>> Either case, this change is not mentioned in the commit log, and it
>>> violates the "one logical change per patch" rule. Please split it into
>>> a separate patch and explain why the change is needed.
>>>
>>> Another change to separate is the introduction of ctrl_report_id
>>> and the secondary_ctrl_report variables, which is also done silently
>>> and not explained. That should also be a separate patch to simplify
>>> review.
> 
> I will separate the changes into more commits for the next version.
> 
> Regards,
> Leonard
> 
>>>
>>> Thanks,
>>> Guenter
>>

