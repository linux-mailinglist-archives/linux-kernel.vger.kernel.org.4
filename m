Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60316A2D03
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 02:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjBZB6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 20:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBZB62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 20:58:28 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA4BCA3A
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 17:58:27 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id h8so91081plf.10
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 17:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oo3uPGqFe9qxhSafXTbcqHa1iqkVF6jZJyZwrrstAQQ=;
        b=bzH3XZ+CPyGFOwbYWMzFz0HdwaNyI7+MKGARhjTvB28cgdTFj/Y51mJ2DufNv0GZvD
         PR8k/F29kZ5owkP8h2SSKsnw8jQOPAMRnIkPhUyD8plxD/TrxaekuS6FIxMPtkNncBN6
         MfjWOCy5/6HpHPeqps6YOd1sxbfQLiElYHYLzinITBJIFMwpakf63BL1G3YQC1ptnqjo
         rdoI+oIy00xXzgVI27RrWciOIb55ExN1SfNxmtVjHU4zY/YnC44DdAjhQC9CL3XsBtE/
         8PqCpON/A6lrQpqNU5hcGdAWujZtYyUVFGBJEndKat5zcnNTby1rusD12pEetcH4Ce68
         DJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oo3uPGqFe9qxhSafXTbcqHa1iqkVF6jZJyZwrrstAQQ=;
        b=n7VKB9YzHwN9+LugXH1hS8TsnSP8XjR/uQUyEfTrOR8W1tUkAxHFq+DQD2oGzJhYad
         STFvbF9ku8XLv8nBGMdyWFBPmm9KGbCl7RQnCnpJpu2EZQSiZWB3/wFfYjJ+EvX4bl/H
         WE63h3VBGwQ13xva0HWUFBK1PWzMqAYODHnJ4Ax/wOQX61btMrhtc/7uFTQ0PMjyNejC
         qWvP6LC1aTCTjw+1Dc9lvpGaMImvxUJLlO/22O6KtCemRO9Dbc23HvPSiioKOkzDl1Ak
         nSq7H9PkWA8DdqDlXDzinTJkzufZXaxHm+Wkj46OP8SzT2ckSA99anwMI2nj6arSx/Pm
         IV0A==
X-Gm-Message-State: AO0yUKVGimU6jaW4bkmUyoUdrf14Qrcd3yLA9t6FIN+kB8bbD+QVA8to
        8a28ZxYZXztH1+e47tdxiaAcg4gtLvU=
X-Google-Smtp-Source: AK7set+gjq08m3bAEEdl66LVIgBE0mxVxbAO9s09vw4iXzMNw7nNTA/Ua3M0QTRvX6I2stXG/JIvkg==
X-Received: by 2002:a05:6a20:3943:b0:cc:a8d7:ad62 with SMTP id r3-20020a056a20394300b000cca8d7ad62mr6153082pzg.27.1677376706971;
        Sat, 25 Feb 2023 17:58:26 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:4a48:1c16:31cb:9a06:c73e? ([2600:8802:b00:4a48:1c16:31cb:9a06:c73e])
        by smtp.gmail.com with ESMTPSA id b11-20020aa7810b000000b005d72e54a7e1sm1710413pfi.215.2023.02.25.17.58.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Feb 2023 17:58:26 -0800 (PST)
Message-ID: <0fa79232-18f7-af96-e116-a71b735a903d@gmail.com>
Date:   Sat, 25 Feb 2023 17:58:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Raspberry Pi 4B: Failed to create device link with
 soc:firmware:gpio
Content-Language: en-US
To:     Saravana Kannan <saravanak@google.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
References: <03b70a8a-0591-f28b-a567-9d2f736f17e5@gmail.com>
 <CAGETcx-KLfxKae6-Kc74gOu2fiuu+5528j_TNEaY21U3_yZO0w@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <CAGETcx-KLfxKae6-Kc74gOu2fiuu+5528j_TNEaY21U3_yZO0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/25/2023 4:01 PM, Saravana Kannan wrote:
> On Sat, Feb 25, 2023 at 7:38 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>> Hi Saravana,
>>
>> Using v6.2-10217-ga93e884edf61v my Raspberry Pi 4B issues the following
>> for the "extended GPIO" provider:
>>
>> [    5.969855] uart-pl011 fe201000.serial: Failed to create device link
>> with soc:firmware:gpio
> 
> Outside of this error, is it actually breaking anything? 

There is just this warning, there does not appear to be a functional issue.

> Also, can you
> pull in this patch and tell me what it says? I want to know what the
> flags are.
> https://lore.kernel.org/lkml/20230225064148.274376-1-saravanak@google.com/
> 
> Can you also change every pr_debug and dev_dbg in drivers/base/core.c
> to an info and then give me the logs as an attachment?

Sure will do.

> 
>> The kernel configuration I am using can be found here:
>>
>> https://gist.github.com/ffainelli/4eb83740c25b10f75b54560f8c8febb1
>>
>> And the DTS is arch/arm*/boot/dts/bcm2711-rpi-4-b.dts
> 
> Ah, is this yet another case of a DTS that's not upstream? Don't
> worry, I'll still look at it as it might point to some existing
> upstream issue too.

This is with the upstream DTS file under that directory, I used * to 
denote that this was used equally for both arm and arm64.

Thanks!
-- 
Florian
