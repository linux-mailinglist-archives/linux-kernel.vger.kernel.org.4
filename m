Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CE5693360
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 20:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjBKTrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 14:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjBKTrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 14:47:37 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940DFEB54;
        Sat, 11 Feb 2023 11:47:35 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id c26so18499682ejz.10;
        Sat, 11 Feb 2023 11:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXEDCEma1gMYRQAW/RN00tZ3sWe+13/Cf5q6JLW2DnE=;
        b=QaVdL7A8hUHNBugmWLes/UMIqWNJvS5VaxjoV0mOc50q6J01gKe7HZGfGKPUuAabjR
         hIjME+omCN/uxqdF7xU1h56O1jN3aZG4QWA3Nl1azxe9WVgKkZYp1WXAHNd2p5jt1R9j
         wKwBNPrbrs63f6QAkUwxyYCZFZFJrEijmNE6ILegV4OPL8HUQd1Pia6BT5T4fqMRRTH+
         xCCRyHzRNxFCoAxoSwXqsOYAaHe7S53Rs5L+zY50jX/+scwWmRrI2+ObfXu+Vr52M3u6
         g0Jb9yhkpYKtlTb07ztQolbJG3BnN4OR1yolz48k/e+TrJ6TubTAhV7/JCtCEBqK/prx
         JzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EXEDCEma1gMYRQAW/RN00tZ3sWe+13/Cf5q6JLW2DnE=;
        b=Yt9ZkQQflQFugqty2BxW68JIX/zA6r2qR7wmtIwiL2oqZp0zJz/wkcgenN4hEGDkkH
         QztddGk0ktS4vg/IqW6rWqDkj9CkXEO80+uIaaYV4WJJbAOrxOnXqIS7fw/ek8ZASjiA
         CsGgFsE/XQsz0XzKfc/SYxrWXEDLQF2x8jNfFoj9Vz+DdLk9uYb9NGFlr7+0TjgxL7ML
         o3uhU7d/QaM2ziH5r7jWsgpyMqzTsri6KUWFbxwte3Sii8eu9W5X+D54TV76WB43IE35
         ZDErS/zS5Lr6uLLuUpabSASEeWkryyAPlDwYtJsfBxIvNBDYT4kG8eA7k14k4118z0T+
         dZDA==
X-Gm-Message-State: AO0yUKV18gHwLT+x/ofNHivwW8vEWupc64k/hSMjcZI9NyiO2wtm4paK
        U4vBEZvdHZt0b1EZqCr4Oxg=
X-Google-Smtp-Source: AK7set8XMlNQbHpSDcd08bIPvsxTXOzgKIS66MLm4SWNrH2/LaDVMKygD5l1sXFeWugryT1XhfcY2g==
X-Received: by 2002:a17:906:9b8b:b0:895:58be:96b with SMTP id dd11-20020a1709069b8b00b0089558be096bmr27839681ejc.3.1676144854103;
        Sat, 11 Feb 2023 11:47:34 -0800 (PST)
Received: from ?IPV6:2001:9e8:20d3:ac00:30d6:d4a1:e6f6:5876? ([2001:9e8:20d3:ac00:30d6:d4a1:e6f6:5876])
        by smtp.gmail.com with ESMTPSA id k6-20020a1709065fc600b0081bfc79beaesm4193997ejv.75.2023.02.11.11.47.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Feb 2023 11:47:33 -0800 (PST)
Message-ID: <b716a9ec-93ba-7c42-c8d3-1d6db950ad7b@gmail.com>
Date:   Sat, 11 Feb 2023 20:48:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: de-DE, en-US, en-US-large
To:     Aleksa Savic <savicaleksa83@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230211165923.17807-1-leonard.anderweit@gmail.com>
 <20230211165923.17807-4-leonard.anderweit@gmail.com>
 <0664b935-d201-419a-3f1d-3df4226a8db1@roeck-us.net>
 <00875064-0407-b114-56c9-87aecb0d3ee4@gmail.com>
From:   Leonard Anderweit <leonard.anderweit@gmail.com>
Subject: Re: [PATCH 3/5] hwmon: (aquacomputer_d5next) Add temperature offset
 control for Aquaero
In-Reply-To: <00875064-0407-b114-56c9-87aecb0d3ee4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 11.02.23 um 19:54 schrieb Aleksa Savic:
> On 2023-02-11 19:08:27 GMT+01:00, Guenter Roeck wrote:
>>
>> aquaero is already supported, and the checksum is so far generated
>> and sent. Is it ignored ? Also, is it guaranteed that _all_ aquero devices
>> don't need it ?
> 
> Reading its sensors is currently supported, not writing to it (before these
> patches).
> 
> The checksum is ignored and not needed for either aquaero 5 (which Leonard has)
> nor 6 (which I have).
> 
>>
>> If it is not needed and ignored, does it really add value to selectively drop it ?
> 
> I think we can indeed remove that check.

I don't think that check can be removed as the checksum is not appended 
to the control report but is in the last two bytes. So using the 
checksum on Aquaero will overwrite the data at that location. It is 
currently unknown what these two bytes do so I do not want to overwrite 
them.

> 
> Thanks,
> Aleksa
> 
>>
>> Either case, this change is not mentioned in the commit log, and it
>> violates the "one logical change per patch" rule. Please split it into
>> a separate patch and explain why the change is needed.
>>
>> Another change to separate is the introduction of ctrl_report_id
>> and the secondary_ctrl_report variables, which is also done silently
>> and not explained. That should also be a separate patch to simplify
>> review.

I will separate the changes into more commits for the next version.

Regards,
Leonard

>>
>> Thanks,
>> Guenter
> 
