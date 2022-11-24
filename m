Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1A8637B15
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiKXOIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiKXOH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:07:59 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A351D1DDE6;
        Thu, 24 Nov 2022 06:07:58 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id g51-20020a9d12b6000000b0066dbea0d203so983953otg.6;
        Thu, 24 Nov 2022 06:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=tbKJ66k3bEJ2YgpscZ/J58iV2a3Uob0SyXOVW95BgtM=;
        b=m/LWoLXUnEffELHxU7yDpDmQ8Ip9NdwaMHpYsBHax6A2Ml08pQcgIYKU/X6BOxVxMM
         nVb82LCBlMoaILtaSOu/YAnh8281nkLsXHGlAqdS7g1Ekh+jAc6fRxO78TspJ6WnMmcW
         rv8VfGm90PMNjZE9D6pBHqWm6/0vlWSy+exezJ04xvcmv3XvA6tQ3LezvfcTFmHwOZhQ
         UzZ96gHeXR0qBw5LG+dHb1fe5TEkKmtZzxyYYlLcQEef88lT949XrP95rE3c5npaTkwF
         bap/8pKdimerWzLCvxsWA4IbI1Z2W/KY/Cp5cFMvdm7ZkTEJan/v0IXUeVy2dQhSqhO+
         4ONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tbKJ66k3bEJ2YgpscZ/J58iV2a3Uob0SyXOVW95BgtM=;
        b=7Mg0v7dRLkm+qQU2i0PvjIna7P9XB89gR/4DHIZ1GImT6sTTcXRDA4qFwCPymm4y0U
         crp2wh5yyZ9hHtdjUjI4RzUL5w2xSazc3hrnXtRguLAyC87bWGFxG77eOFyZIy7RlozO
         vqzaPCsEUER5TqowDdnV1kF/AxS/gSOdBf+87NcWuxr88fZ2ZB/+xYerYUuEWv8CSwD8
         DcJsxgcLmBr+k9hun9V6xwtlLLv652OAAO6+ME7yxoNmNC7A4e6lRTI4KsyBxT0Ubgbk
         mG0L9PQWTEvbXbVc6BoWcEix1PrHhYD6YteANc29JNyy2LV0P+vnzUnA2DGTdsLP12V+
         lK4Q==
X-Gm-Message-State: ANoB5pmC3pzAFfThxlFbn2LM18//CGsa4L+WW6xiQoXdw5Jws/HKG1Kv
        OPPbzW6x1oQmLbvjG6jShy8=
X-Google-Smtp-Source: AA0mqf7v6W0bA6cY5L4SrYMRjySoqn3wivMj+us5T81g6PKyNHae/SN5xnBZ83dlawUlYuOcITjxvQ==
X-Received: by 2002:a05:6830:168b:b0:661:91c9:7d81 with SMTP id k11-20020a056830168b00b0066191c97d81mr17459829otr.164.1669298877980;
        Thu, 24 Nov 2022 06:07:57 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o133-20020acabe8b000000b0035ab03d9153sm416900oif.47.2022.11.24.06.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 06:07:57 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7ce64ea0-f595-a5b6-a810-2bc9133b5386@roeck-us.net>
Date:   Thu, 24 Nov 2022 06:07:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 3/3] hwmon: (pmbus/core): Implement IRQ support
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>
Cc:     broonie@kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
References: <20221122135014.3504094-1-Naresh.Solanki@9elements.com>
 <20221122135014.3504094-3-Naresh.Solanki@9elements.com>
 <1724dbac-024a-2758-a030-c07352b536fc@roeck-us.net>
 <df8201b0-414e-4daf-0dae-bd3ce790304c@9elements.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <df8201b0-414e-4daf-0dae-bd3ce790304c@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 11/24/22 00:56, Naresh Solanki wrote:
> Hi Guenter,
> 
> On 22-11-2022 10:32 pm, Guenter Roeck wrote:
>> On 11/22/22 05:50, Naresh Solanki wrote:
>>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>>
>>> Implement IRQ support to monitor PMBUS regulator events.
>>>
>>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>>
>> Adding a PMBus interrupt handler should be generic and also handle hwmon
>> specific events. It should report any status changes as sysfs attribute
>> notifications.
> This handler scope is to address regulator faults.
> 

Maybe that is the use case from your perspective, but this is primarily
a hardware monitoring driver and needs to primarily serve its hardware
monitoring functionality.

Guenter


